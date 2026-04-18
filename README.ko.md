# codex-computer-use-windows

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Python 3.10+](https://img.shields.io/badge/Python-3.10+-blue.svg)](https://www.python.org/)
[![MCP](https://img.shields.io/badge/MCP-Server-green.svg)](https://modelcontextprotocol.io/)

**[English README](README.md)**

> [OpenAI Codex](https://github.com/openai/codex)를 위한 Windows 데스크탑 자동화 플러그인 — 안정적인 유니코드 입력, 강화된 창 포커스, 크롬 브라우저 도구, 채팅앱 연동을 MCP로 제공합니다.

---

## 이게 뭔가요?

코덱스에게 Windows 데스크탑 전체 제어 능력을 주는 **MCP(Model Context Protocol) 서버 플러그인**입니다. 스크린샷, 마우스, 키보드, 클립보드, 창 관리, 크롬 자동화, 채팅앱 직접 입력까지 — 많은 작업에서 스크린샷 없이도 동작합니다.

### 기존 대비 개선사항

| 문제 | 해결 |
|---|---|
| 64비트 Windows에서 클립보드 크래시 | 모든 Win32 클립보드 API에 `argtypes`/`restype` 정확히 선언 |
| `uiautomation` 목록에만 있고 미설치 | 시작 시 없으면 자동 설치 |
| `focus_window` 조용히 실패 | `AttachThreadInput` + `BringWindowToTop` fallback + 검증 |
| 앱에 직접 텍스트 입력 불가 | `send_text_to_window`, `send_keys_to_window` 도구 추가 |
| `observe_screen`이 잘못된 창을 신뢰 | `active_hwnd` 반환, `expected_window` 불일치 감지 |
| 크롬 URL 확인하려면 스크린샷 필요 | `chrome_get_url`, `chrome_search`, `chrome_read_page` 도구 추가 |
| 한글이 셸에서 깨짐 (???) | 모든 유니코드를 안전한 클립보드 경로로 처리 |

---

## 사용 가능한 도구

### 화면 & 관찰
| 도구 | 설명 |
|---|---|
| `screenshot` | 전체 화면 또는 영역 캡처 |
| `screenshot_active_window` | 활성 창만 캡처 |
| `observe_screen` | 올인원: 스크린샷 + UI 트리 + OCR + 창 검증 |
| `get_screen_size` | 기본 모니터 크기 |
| `get_cursor_position` | 현재 마우스 위치 |
| `extract_text` | 화면 영역 OCR |
| `extract_text_active_window` | 활성 창 OCR |

### 마우스 & 키보드
| 도구 | 설명 |
|---|---|
| `click` | 좌표 클릭 |
| `move_mouse` | 커서 이동 |
| `drag_mouse` | 드래그 |
| `type_text` | ASCII 텍스트 입력 |
| `type_unicode` | 유니코드 텍스트 입력 (한글, 이모지 등) |
| `press_key` | 키 누르기 |
| `hotkey` | 단축키 조합 |
| `scroll` | 세로 스크롤 |

### 창 관리
| 도구 | 설명 |
|---|---|
| `list_windows` | 모든 보이는 창 목록 |
| `focus_window` | 창을 전면으로 (AttachThreadInput fallback 포함) |
| `run_program` | 프로그램 실행 |
| `open_app` | 이름으로 앱 빠른 실행 |
| `get_window_text` | UI Automation으로 창 텍스트 읽기 |

### 클립보드
| 도구 | 설명 |
|---|---|
| `get_clipboard` | 클립보드 읽기 (64비트 안전) |
| `set_clipboard` | 클립보드 쓰기 (64비트 안전) |

### 크롬 / 브라우저 (스크린샷 불필요)
| 도구 | 설명 |
|---|---|
| `chrome_get_url` | 현재 URL 조회 |
| `chrome_get_tab_title` | 탭 제목 조회 |
| `chrome_navigate` | URL로 이동 |
| `chrome_search` | Google/Naver/Daum/Bing 직접 검색 |
| `chrome_read_page` | 페이지 텍스트 읽기 (최대 8000자) |

### 채팅 / 메시징
| 도구 | 설명 |
|---|---|
| `send_text_to_window` | 창 포커스 + 유니코드 붙여넣기 |
| `send_keys_to_window` | 창 포커스 + 붙여넣기 + 선택적 Enter |

### UI 자동화
| 도구 | 설명 |
|---|---|
| `get_ui_tree` | 접근성 트리 조회 (스크린샷 불필요) |
| `find_and_click_element` | 이름으로 요소 찾아 클릭 |

### 유틸리티
| 도구 | 설명 |
|---|---|
| `batch_actions` | 여러 작업을 한 번에 실행 |
| `wait` | UI 업데이트 대기 |

---

## 설치 방법

### 사전 요구사항

- **Windows 10/11** (대화형 데스크탑 세션)
- **Python 3.10+** (`py` 런처 포함)
- **Codex** 데스크탑 앱 또는 CLI

### 방법 1: Codex 플러그인 (권장)

레포를 클론합니다:

```bash
git clone https://github.com/ezpzai/codex-computer-use-windows.git
```

Codex 플러그인 경로에 복사합니다:

```
%LOCALAPPDATA%\codex\plugins\computer-use-windows
```

또는 번들 플러그인 경로:

```
<Codex 설치 경로>\resources\plugins\openai-bundled\plugins\computer-use-windows
```

디렉토리 구조:
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

### 방법 2: 독립 MCP 서버

1. 레포 클론:
```bash
git clone https://github.com/ezpzai/codex-computer-use-windows.git
cd codex-computer-use-windows
```

2. 가상환경 생성 및 설치:
```bash
py -3 -m venv .venv
.venv\Scripts\python.exe -m pip install -r scripts\requirements.txt
```

3. MCP 서버 실행:
```bash
.venv\Scripts\python.exe scripts\windows_server.py
```

### 방법 3: MCP 클라이언트 설정

MCP 클라이언트 설정 파일(예: `~/.codex/mcp.json`, Claude Desktop 등)에 추가합니다:

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

## Codex 에이전트 설정

### AGENTS.md에서 스킬 사용하기

프로젝트의 `AGENTS.md` 또는 `.instructions.md`에 Computer Use 스킬을 추가합니다:

```markdown
<skills>
<skill>
<name>computer-use-windows</name>
<description>Windows 데스크탑 제어 — 스크린샷, 마우스, 키보드, 크롬, 채팅앱</description>
<file>skills/computer-use-windows/SKILL.md</file>
</skill>
</skills>
```

### 에이전트 지시문 예시

```markdown
## 데스크탑 자동화 에이전트

Computer Use (Windows) MCP 도구를 사용할 수 있습니다.

### 자주 쓰는 패턴

- **웹 검색**: `chrome_search(query="...", engine="naver")` — 스크린샷 불필요
- **페이지 읽기**: `chrome_read_page()`로 텍스트 내용 가져오기
- **채팅 메시지 보내기**: `send_keys_to_window(title="채팅방", text="메시지", send_enter=True)`
- **앱 열기**: `open_app("notepad")`, `open_app("chrome")` 등
- **스크린샷 없이 관찰**: `observe_screen(include_screenshot=False, include_ui_tree=True)`
- **포커스 검증**: `observe_screen(expected_window="앱이름")`으로 불일치 감지
```

---

## 빠른 사용 예시

### 네이버에서 스크린샷 없이 검색
```
"네이버에서 '코덱스' 검색해줘"
→ chrome_search(query="코덱스", engine="naver")
→ chrome_read_page()  # 결과를 텍스트로 읽기
```

### 카카오톡 메시지 보내기
```
"카카오톡 HW에게 '안녕' 보내줘"
→ send_keys_to_window(title="HW", text="안녕", send_enter=True)
```

### 크롬 현재 상태 확인
```
"크롬에서 지금 뭐 보고 있어?"
→ chrome_get_url() + chrome_get_tab_title()
```

### 메모장 열고 글쓰기
```
"메모장 열어서 메모해줘"
→ open_app("notepad")
→ type_unicode("원하는 내용")
```

---

## 의존성

| 패키지 | 용도 |
|---|---|
| `mcp` | MCP 서버 프레임워크 |
| `pyautogui` | 마우스/키보드 자동화 |
| `pillow` | 이미지 처리 |
| `mss` | 빠른 스크린샷 캡처 |
| `uiautomation` | Windows UI 자동화 (없으면 자동 설치) |

---

## 제한사항

- **대화형 데스크탑 세션**에서만 작동 (헤드리스/RDP 쉐도우 모드 불가)
- **권한 상승 UAC 프롬프트** 또는 보안 데스크탑 제어 불가
- 크롬 도구는 **Google Chrome** 전용 (Edge/Firefox는 `open_app`으로만 실행 가능)
- `find_and_click_element`와 `get_ui_tree`는 `uiautomation` 패키지 필요

---

## 기여

이슈와 PR 환영합니다: [github.com/ezpzai/codex-computer-use-windows](https://github.com/ezpzai/codex-computer-use-windows)

## 라이선스

[MIT](LICENSE)
