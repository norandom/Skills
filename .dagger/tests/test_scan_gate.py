"""Exercise the scanner wrapper without Dagger, network calls, or credentials."""

import ast
import os
from pathlib import Path
import shutil
import subprocess
import unittest
import uuid
import runpy
from unittest.mock import patch


SOURCE = Path(__file__).parents[1] / "src" / "skills" / "main.py"
TREE = ast.parse(SOURCE.read_text(encoding="utf-8"))
SCAN_ONE = next(
    ast.literal_eval(node.value)
    for node in TREE.body
    if isinstance(node, ast.Assign)
    and any(isinstance(target, ast.Name) and target.id == "_SCAN_ONE" for target in node.targets)
)
BASH = os.environ.get("TEST_BASH") or shutil.which("bash")


class DiagnosticTests(unittest.TestCase):
    def test_credentials_are_redacted(self):
        redact = runpy.run_path(str(SOURCE.parents[2] / "scripts" / "scan_diagnostics.py"))["redact"]
        with patch.dict(os.environ, {"ANTHROPIC_API_KEY": "test-private-value"}):
            result = redact("test-private-value sk-ant-example Authorization: Bearer test-token")
        self.assertNotIn("test-private-value", result)
        self.assertNotIn("sk-ant-example", result)
        self.assertNotIn("test-token", result)
        self.assertIn("[REDACTED]", result)


@unittest.skipUnless(BASH, "Bash is required")
class ScanGateTests(unittest.TestCase):
    def run_gate(self, scanner_rc=0, degraded=False, use_llm=True):
        name = "skillspector-test-" + uuid.uuid4().hex
        prelude = "sleep() { :; }\nskillspector() { "
        if degraded:
            prelude += "echo 'LLM call failed'; "
        prelude += f"return {scanner_rc}; }}\n"
        env = dict(os.environ, SKILL_DIR=f"/tmp/{name}", MAX_ATTEMPTS="2",
                   LLM_FLAG="", USE_LLM="1" if use_llm else "0")
        try:
            return subprocess.run([BASH, "-c", prelude + SCAN_ONE], env=env,
                                  capture_output=True, text=True, check=False)
        finally:
            # These exact two files are created by this test's unique scan name.
            subprocess.run([BASH, "-c", f"rm -f /tmp/{name}.log /tmp/{name}.md"],
                           check=True)

    def test_clean_llm_pass(self):
        result = self.run_gate()
        self.assertEqual(result.returncode, 0, result.stderr)

    def test_finding_fails(self):
        result = self.run_gate(scanner_rc=1)
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("GATE FAIL", result.stdout)

    def test_degraded_zero_exit_fails_closed(self):
        result = self.run_gate(degraded=True)
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("GATE ERROR", result.stdout)
        self.assertEqual(result.stderr.count("LLM degraded"), 2)

    def test_degraded_nonzero_exit_fails_closed(self):
        result = self.run_gate(scanner_rc=1, degraded=True)
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("GATE ERROR", result.stdout)

    def test_static_pass(self):
        result = self.run_gate(use_llm=False)
        self.assertEqual(result.returncode, 0)

    def test_incomplete_scan_is_error_not_finding(self):
        result = self.run_gate(scanner_rc=2)
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("GATE ERROR", result.stdout)
        self.assertNotIn("GATE FAIL", result.stdout)


if __name__ == "__main__":
    unittest.main()
