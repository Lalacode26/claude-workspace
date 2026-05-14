---
name: vn-it-data-hub
description: Kho số liệu thị trường IT Việt Nam (lương dev, số sinh viên IT tốt nghiệp, tỉ lệ tuyển dụng, top stack/công ty...) kèm nguồn chính thống và năm xuất bản. Dùng khi cần cite số liệu trong content/research brief — chống bịa số, chống số liệu OUTDATED. Researcher agent gọi skill này thay vì WebSearch raw.
---

# VN IT Data Hub — Kho số liệu thị trường IT Việt Nam

Skill cung cấp **số liệu có nguồn** về thị trường IT Việt Nam cho content creator / researcher. Mỗi con số đều kèm URL nguồn + năm + flag `[OUTDATED]` nếu cũ hơn 18 tháng.

## Khi nào dùng skill này

- Researcher cần điền mục 6 "Số liệu & Nguồn" trong brief.
- Content creator cần cite số trong caption/post (vd: "57.000 SV IT tốt nghiệp/năm").
- Sale/marketing cần stat cho landing page, ads copy, pitch deck.

**KHÔNG dùng khi**: cần số liệu rất chuyên ngành (medical IT, gov-tech...) → vượt phạm vi skill này, dùng WebSearch trực tiếp.

## Cấu trúc skill

```
vn-it-data-hub/
├── SKILL.md          (file này)
└── data/
    ├── sources.yaml  (danh sách nguồn chính thống + refresh cycle)
    └── stats.yaml    (số liệu cached, mỗi stat có URL + year + status)
```

## 3 thao tác chính

### 1. `lookup <từ khoá>` — Tra cứu nhanh

Đọc `data/stats.yaml`, tìm stat theo `key` hoặc `tags` matching từ khoá user đưa.

**Output mẫu**:
```
📊 Lương fresher dev VN (2024):
   • Backend (Java/Node): 10–15 triệu/tháng
   • Frontend (React): 9–14 triệu/tháng
   • Mobile (Flutter/RN): 10–16 triệu/tháng
   Nguồn: ITviec Salary Report 2024 — https://itviec.com/blog/bao-cao-luong-it-2024
   Cập nhật: 2024-10 — Còn hạn (under 18 months)
```

Nếu stat đã OUTDATED → kèm cảnh báo `⚠️ [OUTDATED — cần refresh từ <source>]`.

### 2. `list-sources` — Liệt kê nguồn chính thống

Đọc `data/sources.yaml`, trả về bảng các báo cáo annual + URL + cycle (cập nhật mấy tháng/lần).

Dùng khi researcher muốn biết "nên search ở đâu" cho topic chưa cached.

### 3. `refresh <stat_key>` — Cập nhật stat từ nguồn

WebFetch URL trong `sources.yaml`, parse số mới, update `stats.yaml`. Báo cáo diff (số cũ → số mới + ngày update).

**Cảnh báo**: chỉ refresh khi user yêu cầu rõ ràng — không tự động chạy.

## Quy trình mỗi lần được gọi

1. **Parse intent**: user đang lookup / list-sources / refresh?
2. **Đọc data file tương ứng** (`stats.yaml` hoặc `sources.yaml`).
3. **Match keyword** theo `key` (exact) → `tags` (contains) → `description` (fuzzy).
4. **Format output** theo template ở mục "Output Format".
5. **Cảnh báo OUTDATED** nếu `last_updated` cách hôm nay > 18 tháng.
6. **Suggest next step**: nếu không tìm thấy stat → gợi ý 1 trong các nguồn ở `sources.yaml` để WebSearch tiếp.

## Output Format (bắt buộc)

```markdown
📊 **[Tên stat]** (năm xuất bản):
   • [Chi tiết số 1]
   • [Chi tiết số 2]
   **Nguồn**: [Tên nguồn] — [URL]
   **Cập nhật**: YYYY-MM — [Còn hạn / ⚠️ OUTDATED]
   **Tags**: #tag1 #tag2
```

Nếu trả nhiều stat → list xuống dòng, KHÔNG nhồi 1 paragraph.

## Nguyên tắc bất di bất dịch

- **Không bao giờ tự bịa số liệu**. Nếu stat không có trong `stats.yaml` và chưa kịp refresh → trả lời "Chưa có trong kho. Đề xuất WebFetch nguồn X" và liệt kê 2–3 source từ `sources.yaml` để user/main agent fetch.
- **Luôn cite URL + năm**. Stat không kèm nguồn = stat không tồn tại.
- **OUTDATED nghiêm ngặt**: > 18 tháng = OUTDATED. > 36 tháng = `[VERY OUTDATED — không nên dùng cho content 2026]`.
- **Ưu tiên nguồn VN trước EN**: TopDev / ITviec / VietnamWorks > LinkedIn / Glassdoor / Statista.
- **Không paste raw WebFetch result**. Luôn chắt lọc thành stat structured.
- **Không tự refresh tự động**. Chỉ refresh khi user gọi `refresh <key>`.

## Handoff với skill / agent khác

- **Researcher agent** gọi skill này để fill mục 6 của brief.
- **content-templates** dùng output để cite trong caption (vd: hook stat-driven).
- **ai-multitool** không cần gọi skill này — số liệu đã có trong brief researcher trả.

## Mở rộng

Khi user muốn thêm stat mới:
1. Mở `data/stats.yaml`.
2. Thêm entry theo schema (xem comment đầu file YAML).
3. Cập nhật `data/sources.yaml` nếu là nguồn lần đầu xuất hiện.
4. Commit/lưu.

Khi báo cáo annual mới ra (vd: TopDev 2026):
1. Update `last_published` trong `sources.yaml`.
2. Chạy `refresh <stat_key>` cho các stat liên quan.
