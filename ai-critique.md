# AI Critique — HW02 Domain Testing

## Đánh giá chất lượng đầu ra

AI hữu ích khi cấu trúc phân tích theo biến, điều kiện, lớp tương đương và BVA; đề xuất ca có truy vết; hỗ trợ tổng hợp evidence và làm Skill dùng lại. Bộ test phát hiện lỗi có evidence ở FR-01, FR-09 và FR-17.

Đầu ra còn hạn chế. Một số expected result FR-01 thêm thông báo không có trong SRS; thiết kế tách mật khẩu xác nhận rỗng và không khớp dù chưa có căn cứ cho hành vi khác nhau. TC02/TC03 vẫn `PASS` khi chỉ xác nhận trình duyệt chặn submit, dù thông báo thực tế bằng tiếng Anh. Một số ca `PASS` FR-17 chỉ xác nhận UI, chưa kiểm tra API. TC09-09 và BVA-FR09-02 trùng biên; FR-11 có năm ca `BLOCKED`. Nhật ký không xác định được AI đã tạo test FR-17/FR-11 hay mã automation nào.

Người kiểm thử đối chiếu expected result với SRS, kiểm tra actual qua JSON, trace, screenshot và phân biệt SRS với API specification. Review FR-01 bằng Skill bỏ thông báo thiếu căn cứ, gộp điều kiện xác nhận với hai biến thể test; test plan và run gốc không bị sửa. 27 ca `FAIL` được nhóm thành 10 bug; `BLOCKED` không bị tính là lỗi.

Cần cung cấp SRS đúng phiên bản, nêu bề mặt UI/API/mobile, yêu cầu trích nguồn cho lớp, biên, expected result và đánh dấu điều chưa xác định. Lưu prompt, output, script, lệnh chạy, evidence theo phiên bản. Người kiểm thử phải xác minh kết quả; test design không thay thế execution.
