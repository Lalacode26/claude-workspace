---
name: ai-multitool
description: Gọi nhiều AI provider (Anthropic Claude, Google Gemini) qua CLI script và chuẩn bị tài liệu cho NotebookLM. Sử dụng khi user muốn brainstorm ý tưởng content nhanh ("brainstorm 10 idea bằng Gemini", "dùng Gemini để..."), viết caption batch ("viết 5 caption qua Claude API"), hoặc gom tài liệu để upload NotebookLM ("chuẩn bị docs cho NotebookLM", "tổng hợp PDF cho research"). Skill có decision matrix chọn AI phù hợp theo task.
---

# AI Multitool

Skill kết nối 3 nền tảng AI ngoài cho công việc content marketing.

## Decision matrix — chọn AI nào?

| Task | Nên dùng | Lý do |
|---|---|---|
| Brainstorm 10-20 idea ngắn | **Gemini** (`scripts/gemini.ps1`) | Free tier, fast, đủ chất lượng cho ideation |
| Viết caption hoàn chỉnh, có giọng văn | **Claude** (`scripts/claude-batch.ps1`) | Chất lượng prose tốt nhất, tuân thủ template |
| Research sâu nhiều nguồn, hỏi đáp tài liệu | **NotebookLM** (`scripts/notebooklm-prep.ps1`) | Tổng hợp được nhiều PDF/URL, có citation |
| So sánh output 2 model | Cả Claude + Gemini | Chạy song song rồi diff |

## Cách dùng

### Gemini — brainstorm nhanh

```powershell
& "$env:USERPROFILE\.claude\skills\ai-multitool\scripts\gemini.ps1" -Prompt "10 idea content về JavaScript cho fanpage trung tâm lập trình"
```

Dùng kèm prompt template:
```powershell
$prompt = (Get-Content "$env:USERPROFILE\.claude\skills\ai-multitool\prompts\brainstorm.md" -Raw) -replace '\{N\}', '10' -replace '\{TOPIC\}', 'TypeScript'
& "$env:USERPROFILE\.claude\skills\ai-multitool\scripts\gemini.ps1" -Prompt $prompt
```

Yêu cầu: `$env:GEMINI_API_KEY` đã set. Lấy key tại https://aistudio.google.com/apikey

### Claude API — viết caption batch

```powershell
& "$env:USERPROFILE\.claude\skills\ai-multitool\scripts\claude-batch.ps1" `
  -PromptFile "$env:USERPROFILE\.claude\skills\ai-multitool\prompts\rewrite-caption.md" `
  -InputText "Caption gốc cần viết lại..."
```

Yêu cầu: `$env:ANTHROPIC_API_KEY` đã set. Model mặc định `claude-sonnet-4-6`.

### NotebookLM — chuẩn bị docs

```powershell
& "$env:USERPROFILE\.claude\skills\ai-multitool\scripts\notebooklm-prep.ps1" -SourceFolder ".\drafts"
```

Script sẽ:
1. Gom files `.md/.txt/.pdf` từ `SourceFolder` (recursive)
2. Copy sang `.\notebooklm-input/` (hoặc folder do `-OutFolder` chỉ định)
3. Tạo `manifest.txt` liệt kê files
4. Mở browser tới `notebooklm.google.com` để user upload thủ công (NotebookLM không có public API)

Thêm `-NoBrowser` nếu không muốn auto mở browser.

## Prompts có sẵn

- `prompts/brainstorm.md` — ideation template với placeholder `{N}` và `{TOPIC}` (dùng với Gemini)
- `prompts/rewrite-caption.md` — viết lại caption theo brand voice với placeholder `{INPUT}` (dùng với Claude)

## Lưu ý

- Trước khi gọi API, kiểm tra biến env tương ứng. Nếu thiếu, thông báo user dùng `setx GEMINI_API_KEY 'value'` hoặc `setx ANTHROPIC_API_KEY 'value'` (cần mở terminal mới sau khi set).
- Output script in ra console; có thể redirect `> output.md` để lưu.
- KHÔNG hardcode API key vào script hay log ra terminal.
- NotebookLM KHÔNG có public API (tính đến 2026) — script chỉ chuẩn bị input, không tự upload.
