---
name: competitor-radar
description: Soi fanpage đối thủ ngành đào tạo lập trình Việt Nam (FUNiX, MindX, CodeGym, F8, NIIT, Techmaster, Got It, FPT Polytechnic...) — biết họ làm content pillar gì, tần suất bao nhiêu, format nào engagement cao, và quan trọng nhất là "gap chưa ai khai thác". Researcher agent gọi skill này để fill mục 3 của brief; content creator gọi để tìm góc nội dung khác biệt.
---

# Competitor Radar — Soi fanpage đối thủ ngành lập trình VN

Skill cung cấp **bản đồ đối thủ** ngành đào tạo lập trình Việt Nam: ai làm content gì mạnh, ai post mỗi ngày, ai chỉ chạy quảng cáo, **góc nào chưa ai khai thác**. Mục tiêu cuối: giúp researcher/content creator tìm ra **content gap** thay vì copy lại format đại trà.

## Khi nào dùng skill này

- Researcher cần fill mục 3 "Đối thủ / Tham chiếu" + phần "Gap chưa ai khai thác" trong brief.
- Content creator muốn check trước khi viết: "topic này có ai làm chưa, làm theo hướng nào?"
- Manager xây content strategy quý, cần overview competitive landscape.

**KHÔNG dùng khi**: chỉ muốn xem post mới nhất của 1 page cụ thể → dùng WebFetch trực tiếp, không cần skill.

## Cấu trúc skill

```
competitor-radar/
├── SKILL.md              (file này)
└── data/
    └── competitors.yaml  (~12 đối thủ + content pillar + ước tính tần suất + format mạnh)
```

## 4 thao tác chính

### 1. `list` — Liệt kê toàn bộ đối thủ

Đọc `data/competitors.yaml`, trả về **bảng tóm tắt**:

| Tên | Tier | Content pillar mạnh | Tần suất | Format chủ lực |
| --- | --- | --- | --- | --- |

Dùng khi researcher hoặc user muốn overview ngành.

### 2. `info <id>` — Chi tiết 1 đối thủ

In đầy đủ entry trong YAML: URL fanpage, số follower (ước tính), 3–5 content pillar, format mạnh, post hot mẫu, ghi chú riêng.

Dùng khi muốn deep-dive 1 đối thủ cụ thể trước khi soạn nội dung cùng phân khúc.

### 3. `scan <id>` — Fetch post mới nhất (live)

WebFetch URL fanpage Facebook public của competitor. Lấy 5–10 post gần nhất nếu accessible. Trả về:
- Tiêu đề / hook của từng post
- Format (image / video / carousel / text-only / livestream)
- Ước tính engagement (rough — chỉ số like/comment visible)

**Lưu ý**: Facebook public page render bằng JS — WebFetch chỉ lấy được phần HTML server-side, có thể thiếu. Nếu fetch thất bại → suggest user chụp screenshot và mô tả.

### 4. `gap-analysis <topic>` — Phần quý nhất của skill

So chéo `<topic>` user định viết với content pillar trong `competitors.yaml`. Trả về:

```markdown
## Gap analysis cho topic: "[topic]"

**Đã có ai làm**:
- [Competitor X] làm dạng [format] — góc [angle]
- [Competitor Y] làm dạng [format] — góc [angle]

**Chưa ai khai thác (gap)**:
1. [Góc 1]: lý do gap (vì sao ngon, vì sao chưa ai làm)
2. [Góc 2]: ...
3. [Góc 3]: ...

**Cảnh báo over-saturated**:
- Góc [Z]: 5+ competitor đã làm — bỏ qua.

**Đề xuất**: chọn 1 trong 3 gap trên + chỉ định format ([carousel/short/long]) phù hợp brand voice.
```

Gap analysis dựa trên **competitor pillar đã track + suy luận của Claude**, KHÔNG đảm bảo 100% — nếu cần verify chính xác, gợi ý user scan live qua action 3.

## Quy trình mỗi lần được gọi

1. **Parse intent**: list / info / scan / gap-analysis?
2. **Đọc `competitors.yaml`**.
3. **Match `<id>`** (key chính xác) hoặc fuzzy match theo `aliases`.
4. **Format output** theo template ở mục 4 thao tác.
5. **Nếu scan thất bại** (FB chặn / render JS): fallback gợi ý cách lấy data thủ công.
6. **Suggest next**: sau khi list/info → đề xuất "muốn gap-analysis topic cụ thể, gõ `gap-analysis <topic>`".

## Nguyên tắc bất di bất dịch

- **Không bịa số follower / engagement**. Nếu data trong YAML là ước tính → ghi rõ `(ước tính)` hoặc `[cần verify]`.
- **Không spy bằng cách bypass authentication**. Chỉ fetch public page; không scrape private group, không reverse-engineer API riêng tư.
- **Không bashing đối thủ**. Mục tiêu là tìm gap, KHÔNG phải nói xấu. Output luôn neutral tone.
- **Cập nhật manual**: data trong YAML cần manual review mỗi 6 tháng — competitor đổi content strategy thường xuyên. Khi user nói "data này cũ rồi" → đề xuất user cập nhật entry hoặc tự scan live qua action 3.
- **Gap analysis có giới hạn**: chỉ phản ánh data đã track. Nếu topic nằm ngoài cụm content pillar nào → trả lời "chưa đủ data, đề xuất scan live + research thêm".

## Handoff với skill / agent khác

- **Researcher agent** gọi `list` + `gap-analysis` để fill mục 3 của brief.
- **content-templates** dùng output gap để chọn angle khác biệt khi viết caption.
- **vn-it-data-hub** không liên quan trực tiếp — bổ trợ cho phần số liệu trong brief, không phải phần đối thủ.

## Mở rộng

Thêm competitor mới:
1. Mở `data/competitors.yaml`.
2. Thêm entry theo schema (xem comment đầu file YAML).
3. Update `content_pillars` field — đây là phần quan trọng cho gap-analysis.

Cập nhật entry cũ:
1. Scan live qua action 3 → so với data cũ.
2. Update `last_reviewed` field.
3. Note thay đổi vào `change_log` (optional).
