# HW02 — Báo cáo lỗi và trạng thái GitHub Issues

Tài liệu này tổng hợp các lỗi được đối chiếu giữa kết quả thực thi kiểm thử, bằng chứng và SRS. Mỗi file `BR-*.md` lưu báo cáo local và nội dung tương ứng với GitHub Issue. Run ID mới nhất trong [`github-issues.csv`](./github-issues.csv) ghi nhận cả 10 Issue đã được tạo trong `nguyenanhtuan2702/eshop-sut`; 7 Issue có screenshot phù hợp được đính kèm và 3 Issue API-only được ghi rõ không có ảnh phù hợp.

## Nguồn và phương pháp kết luận

- SRS: [`eshop-sut/README.md`](../../eshop-sut/README.md), các mục FR-01, FR-09, FR-10/FR-11 và FR-17.
- Kết quả: `execution-results.md` tương ứng của FR-01, FR-09, FR-17; kết quả kiểm thử thủ công của FR-11.
- Bằng chứng: JSON/phản hồi, trace, ảnh chụp màn hình và [`evidence-index.md`](../evidence/evidence-index.md). Đã kiểm tra các liên kết ảnh và xác nhận tệp tồn tại.
- Mã lượt thực thi chính: `20261016-155435`. Không chạy lại kiểm thử.
- **Mức độ nghiêm trọng:** Chưa đánh giá cho tất cả báo cáo vì các tài liệu đã đọc không có quy ước mức độ nghiêm trọng/tác động để áp dụng nhất quán.
- **Tần suất:** Mỗi lỗi được quan sát trong (các) lượt thực thi được dẫn; chưa có lần tái hiện độc lập.
- Các ca FAIL được nhóm theo hành vi/nguyên nhân gốc, không theo số dòng FAIL. Một ca kiểm thử có thể liên quan đến hai lỗi khác nhau nếu kết quả thực tế thể hiện cả hai sai khác.
- FR-11 TC03 và TC10 cùng phản ánh một lỗi màu trạng thái nên được liên kết với cùng báo cáo. TC04–TC08 đang BLOCKED, không phải lỗi ứng dụng đã xác minh.
- FR-09 TC09-06 có ảnh chụp giao diện đang đăng nhập, nhưng trace của chính yêu cầu `/api/apply-coupon` cho thấy không có `Authorization`; kết luận về xác thực dựa trên yêu cầu/phản hồi trong trace, không dựa riêng vào trạng thái giao diện.
- Các ca chỉ kiểm thử API mà không có ảnh được ghi rõ là thiếu ảnh; không dùng ảnh khác thay thế. JSON/trace là bằng chứng thực tế phù hợp cho yêu cầu API.

## Danh sách lỗi đã xác minh

| Mã lỗi | Tính năng | Ca kiểm thử liên quan | Vấn đề | GitHub Issue | Ảnh đính kèm |
|---|---|---|---|---|---|
| [BR-FR01-01](./BR-FR01-01.md) | FR-01 | TC01, BVA-FR01-02, BVA-FR01-03 | Giao diện từ chối mật khẩu đáp ứng SRS | [#1](https://github.com/nguyenanhtuan2702/eshop-sut/issues/1) | Có |
| [BR-FR01-02](./BR-FR01-02.md) | FR-01 | TC01; TC11/TC12 chưa tự động hóa | Biểu mẫu đăng ký thiếu trường xác nhận mật khẩu | [#2](https://github.com/nguyenanhtuan2702/eshop-sut/issues/2) | Có |
| [BR-FR01-03](./BR-FR01-03.md) | FR-01 | TC04–TC10 | API chấp nhận email/mật khẩu vi phạm điều kiện FR-01 | [#3](https://github.com/nguyenanhtuan2702/eshop-sut/issues/3) | Không có ảnh phù hợp; có JSON/trace API |
| [BR-FR09-01](./BR-FR09-01.md) | FR-09 | TC09-01 | Phép tính giảm giá phần trăm cho kết quả sai | [#4](https://github.com/nguyenanhtuan2702/eshop-sut/issues/4) | Có |
| [BR-FR09-02](./BR-FR09-02.md) | FR-09 | TC09-06, TC09-07 | API chấp nhận yêu cầu thiếu JWT hoặc có JWT không hợp lệ | [#5](https://github.com/nguyenanhtuan2702/eshop-sut/issues/5) | Không có ảnh phù hợp; có JSON/trace API |
| [BR-FR09-03](./BR-FR09-03.md) | FR-09 | TC09-09, BVA-FR09-02 | Từ chối đơn hàng có giá trị đúng bằng ngưỡng tối thiểu | [#6](https://github.com/nguyenanhtuan2702/eshop-sut/issues/6) | Có |
| [BR-FR17-01](./BR-FR17-01.md) | FR-17 | TC17-05, TC17-06 | API chấp nhận thiếu `type` hoặc `type` không nằm trong tập cho phép | [#7](https://github.com/nguyenanhtuan2702/eshop-sut/issues/7) | Không có ảnh phù hợp; có JSON/trace API |
| [BR-FR17-02](./BR-FR17-02.md) | FR-17 | TC17-07, TC17-08, BVA-FR17-01/-02/-04/-05 | Chấp nhận `discount_value` bằng 0 hoặc số âm | [#8](https://github.com/nguyenanhtuan2702/eshop-sut/issues/8) | Có |
| [BR-FR17-03](./BR-FR17-03.md) | FR-17 | TC17-10, BVA-FR17-07 | Chấp nhận `min_order_amount` âm | [#9](https://github.com/nguyenanhtuan2702/eshop-sut/issues/9) | Có |
| [BR-FR11-01](./BR-FR11-01.md) | FR-11 | TC03, TC10 | Không dùng màu sắc để phân biệt trạng thái đơn hàng | [#10](https://github.com/nguyenanhtuan2702/eshop-sut/issues/10) | Có |

**Tổng cộng:** 10 lỗi đã được xác minh từ các bằng chứng hiện có; 27 ca kiểm thử FAIL được liên kết với ít nhất một lỗi (TC01 liên quan đến hai lỗi khác nhau). Số ca kiểm thử được đếm duy nhất là 27.

## Cần kiểm thử/xác minh thêm — chưa ghi nhận là lỗi đã xác minh

| Tính năng | Ca kiểm thử | Trạng thái hiện tại | Việc cần làm |
|---|---|---|---|
| FR-01 | TC11, TC12 | NOT AUTOMATED (chưa tự động hóa) | Sau khi xác nhận phạm vi giao diện/API, tự động hóa hoặc thực hiện kiểm thử để xác nhận hành vi khi mật khẩu xác nhận khớp/không khớp. Việc biểu mẫu thiếu trường đã được quan sát trong TC01 và ghi ở BR-FR01-02. |
| FR-11 | TC04 | BLOCKED (bị chặn) | Chuẩn bị người dùng B và đơn hàng đối chứng theo quy trình dữ liệu được phê duyệt; không suy ra lỗi phân quyền chỉ từ việc thiếu dữ liệu. |
| FR-11 | TC05–TC08 | BLOCKED (bị chặn) | Chỉ thực hiện khi có dữ liệu kiểm thử hợp lệ để tạo các trường hợp còn thiếu; không tự ý sửa dữ liệu. |

**Tổng cần thêm dữ liệu/kiểm thử:** 7 ca kiểm thử (2 chưa tự động hóa, 5 bị chặn). Không tạo lỗi ứng dụng từ các ca BLOCKED. FR-09 TC09-06 được xác minh bằng trace của yêu cầu không có `Authorization`; ảnh chụp cho thấy giao diện đang đăng nhập nên đây là giới hạn của ảnh, không phải lỗi môi trường.

## Trạng thái đăng Issue

Run ID mới nhất `20261017-012947` trong CSV ghi nhận trạng thái `CREATED` và URL cho cả 10 Bug ID. Bảy Issue có trạng thái `ATTACHED`; `BR-FR01-03`, `BR-FR09-02` và `BR-FR17-01` có trạng thái `NO_MATCHING_SCREENSHOT` vì bằng chứng phù hợp là JSON/trace API. CSV giữ lại lịch sử các lần chạy trước (precheck thất bại và DryRun); khi tổng hợp trạng thái hiện tại, dùng Run ID mới nhất cho từng Bug ID. Danh sách trên phản ánh log đăng của script; cần mở URL để kiểm tra trạng thái trực tiếp nếu GitHub có thay đổi sau lượt chạy đó.
