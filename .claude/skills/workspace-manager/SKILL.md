---
name: workspace-manager
description: Quản lý không gian làm việc cá nhân tại ~/.claude/workspace/ — liệt kê dự án content marketing hiện có, tạo dự án mới với cấu trúc chuẩn, hoặc giải thích quy ước tổ chức workspace. Dùng khi user nói "tạo dự án mới", "liệt kê projects của tôi", "tôi đang có những project nào", hoặc hỏi về cách tổ chức workspace cá nhân trên Claude Code.
---

# Workspace Manager

Skill này quản lý workspace cá nhân tại `~/.claude/workspace/`.

(Chú ý: KHÔNG nhầm với `~/.claude/projects/` — folder đó là nơi Claude Code lưu session memory nội bộ, không phải project user.)

## Cấu trúc workspace

```
~/.claude/workspace/
  README.md           # Quy ước tổ chức
  <project-slug>/     # Mỗi project là 1 folder
    notes/            # Ghi chú research
    drafts/           # Bản nháp content
    final/            # Content đã duyệt
    README.md         # Mục tiêu, kênh, deadline
```

## Khi user yêu cầu

### "Liệt kê projects của tôi"

Đọc `~/.claude/workspace/` (chỉ folder, bỏ qua file ẩn và file ở root) và liệt kê. Hiển thị tên + ngày sửa cuối. Nếu không có project nào, gợi ý tạo project mới.

PowerShell helper:
```powershell
Get-ChildItem -Path "$env:USERPROFILE\.claude\workspace" -Directory |
  Select-Object Name, @{N='LastModified';E={$_.LastWriteTime.ToString('yyyy-MM-dd')}}
```

### "Tạo project mới tên X"

1. Slugify tên: lowercase, dấu cách → hyphen, bỏ dấu tiếng Việt.
2. Tạo folder `~/.claude/workspace/<slug>/{notes,drafts,final}`.
3. Tạo `README.md` với template:
   ```markdown
   # <Tên project>
   - **Tạo ngày:** YYYY-MM-DD
   - **Mục tiêu:**
   - **Kênh phân phối:**
   - **Deadline:**
   ```
4. Thông báo path đã tạo.

### "Giải thích workspace"

Đọc `~/.claude/workspace/README.md` và tóm tắt cho user.

## Lưu ý

- KHÔNG tạo file ngoài `~/.claude/workspace/` khi dùng skill này.
- KHÔNG xóa project mà chưa hỏi xác nhận user.
- Tên slug phải unique — nếu trùng, hỏi user trước khi ghi đè.
