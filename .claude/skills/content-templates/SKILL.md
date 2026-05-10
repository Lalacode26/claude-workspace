---
name: content-templates
description: Templates viết content fanpage cho trung tâm lập trình. Sử dụng khi user yêu cầu viết bài tips/mẹo lập trình ("viết bài tips về X", "tạo post mẹo lập trình", "soạn nội dung tips & tricks", "viết caption tips"). Skill cung cấp khung sườn, hashtag, và độ dài chuẩn cho post Facebook fanpage giáo dục lập trình bằng tiếng Việt.
---

# Content Templates

Templates content marketing cho fanpage trung tâm lập trình.

## Templates có sẵn

| Loại | File | Khi dùng |
|---|---|---|
| Tips & Tricks | `templates/tips.md` | Mẹo lập trình ngắn, dễ hiểu, target dev junior/sinh viên |
| Announcement | `templates/announcement.md` | Thông báo khoá học mới, chính sách, tin tức trung tâm |
| Quote | `templates/quote.md` | Trích dẫn inspire kèm bình luận, dùng để tăng engagement nhẹ |
| Testimonial | `templates/testimonial.md` | Câu chuyện học viên thành công, tăng social proof |
| Event | `templates/event.md` | Workshop, webinar, buổi học thử, sự kiện offline/online |

## Quy trình chung

1. **Xác định loại post** từ yêu cầu user → chọn template tương ứng ở bảng trên.
2. **Đọc template** — hiểu cấu trúc phần, từng phần bao nhiêu từ, và checklist.
3. **Xác nhận thông tin còn thiếu** (tuỳ loại):
   - Tips: chủ đề, ngôn ngữ/framework, level reader
   - Announcement/Event: ngày giờ địa điểm, giá, đối tượng
   - Testimonial: tên học viên, kết quả cụ thể, timeline học
   - Quote: nội dung quote, nguồn (nếu có)
4. **Generate** đúng cấu trúc, độ dài theo template, giọng văn Việt (xưng "mình"/"bạn").
5. **Đính kèm hashtag** từ hashtag bank trong template (5-7 tag).
6. **Output** dạng plain text copy-paste được lên Facebook ngay (không markdown nặng).

## Lưu ý

- KHÔNG sửa file template trừ khi user yêu cầu rõ "cập nhật template".
- Đảm bảo có 1 câu hỏi ở cuối post để tăng comment engagement.
- Nếu user muốn loại `other` (không thuộc 5 loại trên), hỏi mục tiêu post rồi chọn template gần nhất hoặc tự viết theo brand voice.
