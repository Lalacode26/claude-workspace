# Template: Tips & Tricks Post (Fanpage trung tâm lập trình)

## Cấu trúc 4 phần — tổng 150-250 từ

### 1. Hook (1-2 câu, ~20 từ)

Mở bài bằng câu hỏi đánh trúng pain point HOẶC một sự thật bất ngờ.

Ví dụ:
- "Bạn có biết 80% bug `undefined is not a function` đến từ cùng một nguyên nhân không?"
- "Mình từng mất 3 tiếng debug chỉ vì quên một dấu `await`."

### 2. Problem (2-3 câu, ~40 từ)

Mô tả tình huống cụ thể reader gặp phải. Dùng "bạn" để cá nhân hóa.

Ví dụ:
"Bạn đang code, gọi một method tưởng có sẵn, console hét lên TypeError, và bạn loop qua 50 dòng code không hiểu sai ở đâu. Đây là vấn đề mọi dev junior đều gặp ít nhất 1 lần/tuần."

### 3. Tip (4-6 câu + 1 đoạn code, ~80 từ)

Đưa giải pháp thực tế.

Format:
- 1 câu khái quát giải pháp
- 1 đoạn code minh họa (max 5 dòng, có comment tiếng Việt)
- 1-2 câu giải thích why nó hoạt động

Ví dụ:
"Trick là dùng optional chaining `?.` để tránh crash khi object chưa có:
```js
// trước: user.profile.name → crash nếu profile chưa load
// sau: user?.profile?.name → trả undefined an toàn
const name = user?.profile?.name ?? 'Khách';
```
Cú pháp này đã có trong JS từ 2020 — short circuit ngay khi gặp `null/undefined`, không throw error."

### 4. CTA (1-2 câu, ~20 từ)

Kêu gọi hành động NHẸ, không bán hàng cứng. Câu cuối nên là câu hỏi.

Ví dụ:
- "Lưu lại bài này, lần sau gặp bug tương tự bạn tiết kiệm được 20 phút. Bạn có tip nào khác hay dùng không?"
- "Comment ngôn ngữ bạn đang học, mình sẽ ra tip riêng cho ngôn ngữ đó nhé!"

## Hashtag bank — chọn 5-7 tag

### Tag chung (luôn có 2-3 tag)
`#hoclaptrinh #tipslaptrinh #devvietnam #codeeveryday #programmingtips #lậptrình #lap_trinh_co_ban #junior_dev`

### Tag theo ngôn ngữ (chọn 2-3 tag phù hợp)

- **JavaScript/TypeScript:** `#javascript #typescript #reactjs #nextjs #nodejs`
- **Python:** `#python #django #fastapi #datascience`
- **Backend chung:** `#backend #api #database #rest_api`
- **Mobile:** `#flutter #reactnative #android_dev`
- **DevOps:** `#docker #git #linux #devops`

## Quy tắc viết (CHECKLIST)

- [ ] Giọng văn thân thiện, xưng "mình"/"bạn"
- [ ] KHÔNG dùng emoji quá 3 cái/post
- [ ] KHÔNG Anglicism quá đà ("solution" → "giải pháp", "issue" → "vấn đề", "feature" → "tính năng")
- [ ] Code block phải có comment tiếng Việt ngắn
- [ ] Câu cuối là câu hỏi (tăng comment)
- [ ] Tổng độ dài 150-250 từ (đếm thực tế, không phỏng đoán)
- [ ] Có 5-7 hashtag, đặt cuối post sau 2 dòng trống
- [ ] Output plain text, sẵn sàng copy lên Facebook
