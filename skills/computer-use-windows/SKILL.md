# Computer Use (Windows)

Use the `Computer Use` plugin to inspect and drive the active Windows desktop.

## Core Workflow
- Start with `get_screen_size` and `screenshot` (or `observe_screen` for combined info).
- After every UI action, call `wait` if needed and then `screenshot` again.
- Use absolute screen coordinates with `move_mouse`, `click`, and `drag_mouse`.
- Use `type_text` for ASCII, `type_unicode` for Korean/Unicode text.
- Use `press_key` and `hotkey` for keyboard shortcuts.

## Token-Saving Strategies
- Prefer `observe_screen(include_screenshot=False, include_ui_tree=True)` to get structured UI info without image tokens.
- Use `extract_text` or `extract_text_active_window` for OCR when you only need to read text.
- Use `screenshot_active_window` instead of full-screen `screenshot` to reduce image size.
- Use `get_ui_tree` + `find_and_click_element` to interact without screenshots at all.
- Use `batch_actions` to combine multiple actions (click, type, etc.) into a single call.
- Use `get_window_text` to read a window's text content via UI Automation (no screenshot needed).

## Window Management
- `list_windows` to see all open windows.
- `focus_window` to bring a window to the foreground by title. Now uses AttachThreadInput fallback for reliable foreground switching.
- `run_program` to launch applications.
- `open_app` to launch common Windows apps by name (notepad, chrome, kakaotalk, etc.).

## Clipboard
- `get_clipboard` / `set_clipboard` for clipboard read/write (64-bit safe).
- `type_unicode` uses clipboard internally for non-ASCII input (64-bit safe).

## Chrome / Browser Tools (No Screenshot Needed)
- `chrome_get_url` — get current URL from Chrome address bar.
- `chrome_get_tab_title` — get current tab title from window title.
- `chrome_navigate` — navigate Chrome to a specific URL.
- `chrome_search` — search with google/naver/daum/bing directly.
- `chrome_read_page` — read the text content of the current page (up to 8000 chars).

## Chat / Messaging Tools
- `send_text_to_window` — focus a window and paste Unicode text into its active control.
- `send_keys_to_window` — focus a window, paste Unicode text, and optionally press Enter.

## Observing the Screen
- `observe_screen` now returns `active_hwnd` and `active_window` for verification.
- Pass `expected_window` to detect foreground mismatches and auto-fallback to full-screen capture.

## Constraints
- Works only on the interactive desktop session.
- Cannot control elevated UAC prompts or the secure desktop.
- `find_and_click_element` and `get_ui_tree` require the `uiautomation` package (auto-installed if missing).
- OCR uses Windows built-in OCR engine (no extra install needed).
- Keep actions small and verify state from fresh screenshots or UI tree.

## Quick Action Examples

### "네이버에서 '코덱스' 검색해줘"
→ `chrome_search(query="코덱스", engine="naver")`
→ `chrome_read_page()` to read results (no screenshot needed)

### "카카오톡 HW에게 '안녕' 보내줘"
→ `send_keys_to_window(title="HW", text="안녕", send_enter=True)`

### "크롬에서 지금 뭐 보고 있어?"
→ `chrome_get_url()` + `chrome_get_tab_title()` (no screenshot needed)

### "메모장 열어서 글 써줘"
→ `open_app("notepad")` → `type_unicode("내용")`
