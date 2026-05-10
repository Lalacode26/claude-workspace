# Workspace Cá Nhân

Đây là nơi lưu các dự án content marketing cá nhân của tôi.

> Lưu ý: KHÔNG nhầm folder này với `~/.claude/projects/` — folder đó là nơi Claude Code lưu session memory nội bộ.

## Quy ước tổ chức

```
workspace/
  <project-slug>/        # 1 folder = 1 dự án
    README.md            # Mục tiêu, kênh, deadline
    notes/               # Ghi chú research
    drafts/              # Bản nháp content
    final/               # Content đã duyệt, sẵn sàng đăng
```

## Quy ước đặt tên slug

- Lowercase, dùng hyphen, không dấu tiếng Việt
- Format: `<năm>-<tên>` nếu là project có thời hạn
  - Ví dụ: `2026-fanpage-postlab`, `2026q2-launch-campaign`
- Tên ngắn nếu là project thường trực
  - Ví dụ: `personal-blog`, `linkedin`

## Tạo project mới

Yêu cầu Claude: **"Tạo project mới tên X"** — skill `workspace-manager` sẽ scaffold folder.

## Skills sử dụng được trong workspace

Tất cả skills tại `~/.claude/skills/` đều load được trong mọi project và mọi cuộc trò chuyện:

| Skill | Mô tả |
|---|---|
| **workspace-manager** | Quản lý projects (tạo / liệt kê) |
| **content-templates** | Templates content fanpage (hiện có: `tips`) |
| **ai-multitool** | Gọi Gemini, Claude API; chuẩn bị docs cho NotebookLM |

## Env vars cần set

Để dùng skill `ai-multitool`:

```powershell
setx GEMINI_API_KEY "your-gemini-key"
setx ANTHROPIC_API_KEY "your-anthropic-key"
```

Sau khi `setx`, mở terminal mới để biến env có hiệu lực.

Lấy Gemini key tại: https://aistudio.google.com/apikey
