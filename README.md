# Windows Shutdown Manager

A lightweight Windows batch utility for scheduling and cancelling shutdowns. No third-party dependencies.

## Features

- Schedule a shutdown in **5 hours** (matches the original script's delay), **1 hour**, or **60 seconds**.
- Cancel a pending shutdown.
- Ask for confirmation before scheduling.
- **Does not use `/f`** to force-close applications.
- Runs locally; no network requests or administrator privileges normally required.

## Requirements

Windows 10 or Windows 11 with `choice.exe` and `shutdown.exe` (standard Windows tools).

## Getting started

1. Download or clone this repository.
2. Double-click `shutdown.bat`, or launch it from Command Prompt.
3. Select a number from the menu and follow the confirmation prompt.
4. Select **5** to quit without scheduling anything.

> **Warning:** Shutdown can still interrupt work or cause data loss. Save open documents and check your applications before the timer expires. Applications that block shutdown might prevent it from completing. This utility does not guarantee unsaved work will be protected.

## Cancel a scheduled shutdown

Run `shutdown.bat` and choose **4**, or run:

```cmd
shutdown /a
```

A shutdown already in progress may be too late to cancel. Windows may reject scheduling another shutdown while one is pending; cancel the old one first.

## Task Scheduler

The interactive version is intended for manual use, **not unattended scheduled tasks**. For an automated shutdown, configure Windows Task Scheduler to run `shutdown.exe` directly with arguments such as `/s /t 300`, and understand the consequences before enabling it. To cancel, use `shutdown /a`.

## Original version

The original one-line script was:

```bat
c:\windows\system32\shutdown -s -f -t 18000
```

Version 2 preserves the five-hour option while removing forced application closure and adding cancellation and confirmation. Git history retains the earlier script.

## Testing

Static checks are provided in `tests/test_structure.py`:

```bash
python tests/test_structure.py
```

**Important:** Automated tests do not execute shutdown commands. Windows behaviour requires manual testing on a non-critical machine. You can schedule the five-hour timer, then immediately cancel it using menu option 4.

## Licence

GPL-3.0, preserving the existing repository licence. See `LICENSE`.
