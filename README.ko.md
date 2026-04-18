# codex-computer-use-windows

<p align="center">
  <img src="assets/banner.svg" alt="codex-computer-use-windows 배너" width="800"/>
</p>

<p align="center">
  <a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/License-MIT-yellow.svg" alt="License: MIT"/></a>
  <a href="https://www.python.org/"><img src="https://img.shields.io/badge/Python-3.10+-blue.svg" alt="Python 3.10+"/></a>
  <a href="https://modelcontextprotocol.io/"><img src="https://img.shields.io/badge/MCP-Server-green.svg" alt="MCP"/></a>
  <a href="https://github.com/ezpzai/codex-computer-use-windows/stargazers"><img src="https://img.shields.io/github/stars/ezpzai/codex-computer-use-windows" alt="Stars"/></a>
</p>

<p align="center">
  <b><a href="README.md">English</a></b>
</p>

> 로컬 MCP 서버를 통해 Codex가 Windows 데스크톱을 제어할 수 있게 해주는 플러그인 패키지입니다. 스크린샷, 마우스, 키보드, Chrome, 채팅 앱 자동화를 지원합니다.

---

## 개요

이 저장소는 Codex 플러그인 패키지로 설치하는 용도입니다.

이 저장소에는 이미 다음 파일이 포함되어 있습니다.

- [`.codex-plugin/plugin.json`](.codex-plugin/plugin.json)
- [`.mcp.json`](.mcp.json)
- [`skills/computer-use-windows/SKILL.md`](skills/computer-use-windows/SKILL.md)

---

## 설치

필요한 환경:

- Windows 10/11
- `py` 런처가 포함된 Python 3.10+
- Codex 데스크톱 앱

### 방법 1. 
## (자동설치) For AI Agent

Codex 앱 채팅에 이 문장을 그대로 붙여넣으세요:

```text
https://github.com/ezpzai/codex-computer-use-windows 저장소를 $HOME\.codex\plugins\computer-use-windows 에 클론하고, ~/.agents/plugins/marketplace.json 에 ./.codex/plugins/computer-use-windows 를 가리키는 로컬 플러그인 항목을 추가하세요.
```

설치 후 Codex를 다시 시작하고, 
Codex app Plugins > Local Plugins 에서 computer-use-windows 를 설치
![plugins.png](assets/plugins.png)



### 방법 2. 
## (수동설치) 1. 로컬 플러그인 경로에 클론

PowerShell에서 아래 명령을 실행합니다.

```powershell
git clone https://github.com/ezpzai/codex-computer-use-windows.git "$HOME\.codex\plugins\computer-use-windows"
```

### 2. 로컬 마켓플레이스 항목 추가

`~/.agents/plugins/marketplace.json` 파일을 만들거나 수정합니다.

```json
{
  "name": "local-plugins",
  "plugins": [
    {
      "name": "computer-use-windows",
      "source": {
        "source": "local",
        "path": "./.codex/plugins/computer-use-windows"
      },
      "policy": {
        "installation": "AVAILABLE",
        "authentication": "ON_INSTALL"
      },
      "category": "Productivity"
    }
  ]
}
```

### 3. Codex 다시 시작 후 설치

`Plugins > Local Plugins`에서 `computer-use-windows`를 설치합니다.

Codex가 번들된 `.mcp.json`과 `skills/`를 자동으로 읽습니다.

---

## 제공 도구

| 분류 | 도구 |
|---|---|
| 화면 | `screenshot`, `screenshot_active_window`, `observe_screen`, `get_screen_size`, `get_cursor_position`, `extract_text`, `extract_text_active_window` |
| 마우스/키보드 | `click`, `move_mouse`, `drag_mouse`, `type_text`, `type_unicode`, `press_key`, `hotkey`, `scroll` |
| 창 관리 | `list_windows`, `focus_window`, `run_program`, `open_app`, `get_window_text` |
| 클립보드 | `get_clipboard`, `set_clipboard` |
| Chrome | `chrome_get_url`, `chrome_get_tab_title`, `chrome_navigate`, `chrome_search`, `chrome_read_page` |
| 채팅/메시지 | `send_text_to_window`, `send_keys_to_window` |
| UI Automation | `get_ui_tree`, `find_and_click_element` |
| 유틸리티 | `batch_actions`, `wait` |

---

## 참고 사항

- 대화형 데스크톱 세션에서만 동작합니다.
- 관리자 권한 UAC 프롬프트나 보안 데스크톱은 제어할 수 없습니다.
- 브라우저 전용 도구는 Google Chrome 기준입니다.
- `uiautomation` 패키지는 필요 시 첫 실행에서 자동 설치됩니다.

## 기여

이슈와 PR은 [github.com/ezpzai/codex-computer-use-windows](https://github.com/ezpzai/codex-computer-use-windows)에서 받습니다.

## 라이선스

[MIT](LICENSE)
