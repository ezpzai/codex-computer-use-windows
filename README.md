# codex-computer-use-windows

<p align="center">
  <img src="assets/banner.svg" alt="codex-computer-use-windows banner" width="800"/>
</p>

<p align="center">
  <a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/License-MIT-yellow.svg" alt="License: MIT"/></a>
  <a href="https://www.python.org/"><img src="https://img.shields.io/badge/Python-3.10+-blue.svg" alt="Python 3.10+"/></a>
  <a href="https://modelcontextprotocol.io/"><img src="https://img.shields.io/badge/MCP-Server-green.svg" alt="MCP"/></a>
  <a href="https://github.com/ezpzai/codex-computer-use-windows/stargazers"><img src="https://img.shields.io/github/stars/ezpzai/codex-computer-use-windows" alt="Stars"/></a>
</p>

<p align="center">
  <b><a href="README.ko.md">한국어</a></b>
</p>

> MCP server that gives Codex full control over the Windows desktop — screenshots, mouse, keyboard, Chrome browser, chat apps, and more.

---

## Overview

An MCP (Model Context Protocol) server plugin for [OpenAI Codex](https://github.com/openai/codex). Control the entire Windows desktop through natural language: take screenshots, click, type, manage windows, search the web via Chrome, and send messages to chat apps — many operations work without screenshots at all.

---

## Quick Start

### Prerequisites

- **Windows 10/11** (interactive desktop session)
- **Python 3.10+** with `py` launcher
- **Codex** CLI or desktop app

### Install & Add to Codex

```bash
# Clone the repo
git clone https://github.com/ezpzai/codex-computer-use-windows.git

# Add to Codex as MCP server
codex mcp add computer-use -- cmd.exe /d /s /c "path\to\codex-computer-use-windows\scripts\launch-windows.cmd mcp"
```

First run automatically creates a venv and installs all dependencies.

### Manual MCP Config

Add to your MCP client config (Codex `mcp.json`, Claude Desktop, etc.):

```json
{
  "mcpServers": {
    "computer-use-windows": {
      "command": "cmd.exe",
      "args": ["/d", "/s", "/c", ".\\scripts\\launch-windows.cmd mcp"],
      "cwd": "C:\\path\\to\\codex-computer-use-windows"
    }
  }
}
```

### Standalone Server

```bash
cd codex-computer-use-windows
py -3 -m venv .venv
.venv\Scripts\python.exe -m pip install -r scripts\requirements.txt
.venv\Scripts\python.exe scripts\windows_server.py
```

---

## Available Tools

| Category | Tools |
|---|---|
| **Screen** | `screenshot` · `screenshot_active_window` · `observe_screen` · `get_screen_size` · `get_cursor_position` · `extract_text` · `extract_text_active_window` |
| **Mouse & Keyboard** | `click` · `move_mouse` · `drag_mouse` · `type_text` · `type_unicode` · `press_key` · `hotkey` · `scroll` |
| **Window** | `list_windows` · `focus_window` · `run_program` · `open_app` · `get_window_text` |
| **Clipboard** | `get_clipboard` · `set_clipboard` |
| **Chrome** | `chrome_get_url` · `chrome_get_tab_title` · `chrome_navigate` · `chrome_search` · `chrome_read_page` |
| **Chat / Messaging** | `send_text_to_window` · `send_keys_to_window` |
| **UI Automation** | `get_ui_tree` · `find_and_click_element` |
| **Utility** | `batch_actions` · `wait` |

---

## For AI Agents

Copy this into your agent's system prompt, `AGENTS.md`, or `.instructions.md` to let it install and use this tool:

````markdown
## Computer Use (Windows) — Setup & Usage

Install the MCP server for Windows desktop control:

```bash
git clone https://github.com/ezpzai/codex-computer-use-windows.git
codex mcp add computer-use -- cmd.exe /d /s /c "path\to\codex-computer-use-windows\scripts\launch-windows.cmd mcp"
```

### Skill Registration

```xml
<skills>
<skill>
  <name>computer-use-windows</name>
  <description>Windows desktop control — screenshots, mouse, keyboard, Chrome, chat apps, UI Automation</description>
  <file>skills/computer-use-windows/SKILL.md</file>
</skill>
</skills>
```

### Available Actions

- **Web search (no screenshot):** `chrome_search(query="...", engine="naver|google|daum|bing")`
- **Read page text:** `chrome_read_page()`
- **Get current URL:** `chrome_get_url()`
- **Navigate:** `chrome_navigate(url="https://...")`
- **Send chat message:** `send_keys_to_window(title="KakaoTalk", text="hello", send_enter=True)`
- **Open app:** `open_app("notepad|chrome|kakaotalk|calculator|...")`
- **Observe (no screenshot):** `observe_screen(include_screenshot=False, include_ui_tree=True)`
- **Type Unicode:** `type_unicode("한글 텍스트")`
- **Read window text:** `get_window_text(title="Notepad")`
````

---

## Limitations

- Interactive desktop session only (no headless / RDP shadow)
- Cannot control elevated UAC prompts or the secure desktop
- Chrome-specific tools target Google Chrome (Edge/Firefox: use `open_app` only)

---

## Contributing

Issues and PRs welcome at [github.com/ezpzai/codex-computer-use-windows](https://github.com/ezpzai/codex-computer-use-windows).

## License

[MIT](LICENSE)
