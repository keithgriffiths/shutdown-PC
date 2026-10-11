"""Non-destructive checks: never execute the Windows shutdown script."""
from pathlib import Path

script = (Path(__file__).resolve().parents[1] / "shutdown.bat").read_text(encoding="utf-8")
normalized = script.lower()
assert 'choice /c 12345' in normalized
assert 'shutdown.exe /a' in normalized
assert 'shutdown.exe /s /t %delay%' in normalized
assert 'set "delay=18000"' in normalized
assert 'set "delay=3600"' in normalized
assert 'set "delay=60"' in normalized
assert 'shutdown.exe /s /f' not in normalized
assert 'shutdown.exe /s /t %delay%\n' in normalized
print('Static structure tests passed. No shutdown command was executed.')
