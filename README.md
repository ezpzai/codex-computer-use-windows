# codex-computer-use-windows

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Python 3.10+](https://img.shields.io/badge/Python-3.10+-blue.svg)](https://www.python.org/)
[![MCP](https://img.shields.io/badge/MCP-Server-green.svg)](https://modelcontextprotocol.io/)

**[한국어 README](README.ko.md)**

> Enhanced Windows desktop automation plugin for [OpenAI Codex](https://github.com/openai/codex) — reliable Unicode input, robust window focus, Chrome browser tools, and chat app integration via MCP.

---

## What is this?

A **Model Context Protocol (MCP)** server plugin that gives Codex full control over the Windows desktop: screenshots, mouse, keyboard, clipboard, window management, Chrome automation, and direct text input to chat apps — all without needing screenshots for many operations.

### Key Improvements over the original

| Problem | Fix |
|---|---|
| Clipboard crashes on 64-bit Windows | All Win32 clipboard APIs now have proper `argtypes`/`restype` declarations |
| `uiautomation` listed but not installed | Auto-installs on first startup if missing |
| `focus_window` silently fails | Uses `AttachThreadInput` + `BringWindowToTop` fallback with verification |
| No direct text input to apps | New `send_text_to_window` and `send_keys_to_window` tools |
| `observe_screen` trusts wrong window | Returns `active_hwnd`, supports `expected_window` mismatch detection |
| Must screenshot Chrome to see URL | New `chrome_get_url`, `chrome_search`, `chrome_read_page` tools |
| Korean text (한글) garbled in shell | All Unicode goes through safe clipboard path |

---

## Available Tools

### Screen & Observation
| Tool | Description |
|---|---|
| `screenshot` | Capture full screen or region |
| `screenshot_active_window` | Capture only the focused window |
| `observe_screen` | All-in-one: screenshot + UI tree + OCR + window verification |
| `get_screen_size` | Get primary monitor dimensions |
| `get_cursor_position` | Get current mouse position |
| `extract_text` | OCR text from screen region |
| `extract_text_active_window` | OCR text from focused window |

### Mouse & Keyboard
| Tool | Description |
|---|---|
| `click` | Click at coordinates |
| `move_mouse` | Move cursor |
| `drag_mouse` | Drag to coordinates |
| `type_text` | Type ASCII text |
| `type_unicode` | Type Unicode text (Korean, emoji, etc.) via clipboard |
| `press_key` | Press a key |
| `hotkey` | Press key combinations |
| `scroll` | Scroll vertically |

### Window Management
| Tool | Description |
|---|---|
| `list_windows` | List all visible windows |
| `focus_window` | Bring window to foreground (with AttachThreadInput fallback) |
| `run_program` | Launch a program |
| `open_app` | Quick-launch common apps by name |
| `get_window_text` | Read window text via UI Automation |

### Clipboard
| Tool | Description |
|---|---|
| `get_clipboard` | Read clipboard (64-bit safe) |
| `set_clipboard` | Write clipboard (64-bit safe) |

### Chrome / Browser (No Screenshot Needed)
| Tool | Description |
|---|---|
| `chrome_get_url` | Get current URL |
| `chrome_get_tab_title` | Get tab title |
| `chrome_navigate` | Navigate to URL |
| `chrome_search` | Search Google/Naver/Daum/Bing directly |
| `chrome_read_page` | Read page text content (up to 8000 chars) |

### Chat / Messaging
| Tool | Description |
|---|---|
| `send_text_to_window` | Focus window + paste Unicode text |
| `send_keys_to_window` | Focus window + paste + optional Enter |

### UI Automation
| Tool | Description |
|---|---|
| `get_ui_tree` | Get accessibility tree (no screenshot needed) |
| `find_and_click_element` | Find and click by element name |

### Utilities
| Tool | Description |
|---|---|
| `batch_actions` | Execute multiple actions in one call |
| `wait` | Pause for UI updates |

---

## Installation

### Prerequisites

- **Windows 10/11** (interactive desktop session)
- **Python 3.10+** with `py` launcher
- **Codex** desktop app or CLI

### Method 1: Codex Plugin (Recommended)

Clone into your Codex plugins directory:

```bash
git clone https://github.com/ezpzai/codex-computer-use-windows.git
```

Copy to the Codex plugin path:

```
%LOCALAPPDATA%\codex\plugins\computer-use-windows
```

Or for the bundled plugins path:

```
<Codex Install Dir>\resources\plugins\openai-bundled\plugins\computer-use-windows
```

The directory structure should be:
```
computer-use-windows/
├── .codex-plugin/
│   └── plugin.json
├── .mcp.json
├── scripts/
│   ├── launch-windows.cmd
│   ├── requirements.txt
│   └── windows_server.py
├── skills/
│   └── computer-use-windows/
│       └── SKILL.md
├── README.md
└── README.ko.md
```

### Method 2: Standalone MCP Server

1. Clone the repo:
```bash
git clone https://github.com/ezpzai/codex-computer-use-windows.git
cd codex-computer-use-windows
```

2. Create venv and install:
```bash
py -3 -m venv .venv
.venv\Scripts\python.exe -m pip install -r scripts\requirements.txt
```

3. Run the MCP server:
```bash
.venv\Scripts\python.exe scripts\windows_server.py
```

### Method 3: MCP Client Configuration

Add to your MCP client config (e.g., `~/.codex/mcp.json`, Claude Desktop, etc.):

```json
{
  "mcpServers": {
    "computer-use-windows": {
      "command": "cmd.exe",
      "args": ["/d", "/s", "/c", "path\\to\\scripts\\launch-windows.cmd mcp"],
      "cwd": "path\\to\\computer-use-windows"
    }
  }
}
```

---

## Setup for Codex Agents

### Using the Skill in AGENTS.md

Add the Computer Use skill reference to your project's `AGENTS.md` or `.instructions.md`:

```markdown
<skills>
<skill>
<name>computer-use-windows</name>
<description>Control Windows desktop — screenshots, mouse, keyboard, Chrome, chat apps</description>
<file>skills/computer-use-windows/SKILL.md</file>
</skill>
</skills>
```

### Example Agent Instructions

```markdown
## Desktop Automation Agent

You have access to the Computer Use (Windows) MCP tools.

### Common Patterns

- **Search the web**: Use `chrome_search(query="...", engine="naver")` — no screenshot needed
- **Read a page**: Use `chrome_read_page()` to get text content
- **Send a chat message**: Use `send_keys_to_window(title="ChatApp", text="message", send_enter=True)`
- **Open apps**: Use `open_app("notepad")`, `open_app("chrome")`, etc.
- **Observe without screenshots**: Use `observe_screen(include_screenshot=False, include_ui_tree=True)`
- **Verify focus**: Use `observe_screen(expected_window="MyApp")` to detect mismatches
```

---

## Quick Examples

### Search Naver without screenshots
```
"네이버에서 '코덱스' 검색해줘"
→ chrome_search(query="코덱스", engine="naver")
→ chrome_read_page()  # read results as text
```

### Send a KakaoTalk message
```
"카카오톡 HW에게 '안녕' 보내줘"
→ send_keys_to_window(title="HW", text="안녕", send_enter=True)
```

### Check what Chrome is showing
```
"크롬에서 지금 뭐 보고 있어?"
→ chrome_get_url() + chrome_get_tab_title()
```

### Open Notepad and type
```
"메모장 열어서 메모해줘"
→ open_app("notepad")
→ type_unicode("원하는 내용")
```

---

## Dependencies

| Package | Purpose |
|---|---|
| `mcp` | Model Context Protocol server framework |
| `pyautogui` | Mouse/keyboard automation |
| `pillow` | Image processing |
| `mss` | Fast screenshot capture |
| `uiautomation` | Windows UI Automation (auto-installed if missing) |

---

## Limitations

- Works only on the **interactive desktop session** (not in headless/RDP shadow mode)
- Cannot control **elevated UAC prompts** or the secure desktop
- Chrome tools work with **Google Chrome** specifically (not Edge/Firefox, though `open_app` supports Edge)
- `find_and_click_element` and `get_ui_tree` require the `uiautomation` package

---

## Contributing

Issues and PRs welcome at [github.com/ezpzai/codex-computer-use-windows](https://github.com/ezpzai/codex-computer-use-windows).

## License

[MIT](LICENSE)
