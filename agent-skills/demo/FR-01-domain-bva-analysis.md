# FR-01 Registration — Phân tích minh họa Domain Testing và BVA

> **Loại tài liệu:** Đầu ra thiết kế minh họa mới, không phải kết quả thực thi. Actual result, PASS/FAIL và evidence không được tạo trong tài liệu này.

## 1. Phạm vi, nguồn và giới hạn

- **Feature:** FR-01 — Đăng ký tài khoản.
- **Nguồn yêu cầu ưu tiên:** [SRS EShop](../../../eshop-sut/README.md), phiên bản 2.0 (cập nhật 2026-05-14), mục 2, heading **FR-01: Đăng ký tài khoản**. Đã tìm thấy và đọc đặc tả gốc; các điều kiện nghiệp vụ bên dưới được đối chiếu với nguồn này.
- **Nguồn API riêng:** [API specification](../../../eshop-sut/api_specification.md), mục 1.1, mô tả `POST /api/register`, body mẫu `name`, `email`, `password` và phản hồi thành công mẫu. Đây là contract API, không thay thế SRS. Tài liệu không nêu trường xác nhận mật khẩu hoặc quy tắc/response khi thất bại.
- **Tài liệu thứ cấp đối chiếu:** [domain-testing.md](../../FR-01-registration/domain-testing.md) và [bva.md](../../FR-01-registration/bva.md). Chúng là test design hiện hành, không phải nguồn yêu cầu ưu tiên hơn SRS.
- **Giới hạn:** SRS nêu ví dụ định dạng email nhưng không định nghĩa grammar đầy đủ; không quy định độ dài tên/email, cách so trùng email không phân biệt hoa thường, cách đếm Unicode hoặc nội dung/thể thức phản hồi lỗi. Những nội dung này được để `Chưa xác định`, không suy diễn thành yêu cầu.
- **Ngoài phạm vi:** Thực thi test, tạo/cập nhật test results, bug report hoặc evidence.

## 2. Yêu cầu, biến và hành vi đầu vào

Các mã `REQ` là mã truy vết tạm trong bản demo; nguồn chính thức là SRS, mục 2, FR-01.

| Mã | Điều kiện/biến | Yêu cầu được xác nhận | Căn cứ |
|---|---|---|---|
| REQ-01 | Họ tên, email, mật khẩu | Người dùng phải cung cấp các trường này. | SRS `README.md`, mục 2, FR-01, gạch đầu dòng 1 |
| REQ-02 | Email | Email phải có định dạng hợp lệ (ví dụ `user@domain.com`) và duy nhất. | SRS `README.md`, mục 2, FR-01, gạch đầu dòng 2 |
| REQ-03 | Mật khẩu | Tối thiểu 8 ký tự; có ít nhất một chữ hoa, một chữ thường, một chữ số và một ký tự trong tập `@`, `$`, `!`, `%`, `*`, `?`, `&`. | SRS `README.md`, mục 2, FR-01, gạch đầu dòng 3 |
| REQ-04 | Xác nhận mật khẩu | Phải có trường xác nhận; từ chối nếu hai trường không khớp. | SRS `README.md`, mục 2, FR-01, gạch đầu dòng 4 |
| REQ-05 | Hành vi sau đăng ký thành công | Chuyển người dùng tới trang Đăng nhập. | SRS `README.md`, mục 2, FR-01, gạch đầu dòng 5 |
| API-01 | API đăng ký | `POST /api/register`; body mẫu có `name`, `email`, `password`; phản hồi thành công mẫu `200 OK`. | API specification, mục 1.1 |

SRS mô tả hành vi nghiệp vụ thành công và điều kiện từ chối không khớp ở REQ-04, nhưng không quy định câu chữ thông báo lỗi hoặc response API cho các dữ liệu sai. API specification chỉ minh họa request/response thành công; không đủ căn cứ để suy ra response thất bại hoặc trường `confirmPassword`.

## 3. Domain Testing — phân lớp tương đương

Các lớp được phân theo hành vi của từng điều kiện; lớp Valid/Invalid được hỗ trợ bởi REQ tương ứng trong SRS (tại `README.md`, mục 2, FR-01).

| Điều kiện | Lớp ID | Mô tả lớp | Phân loại | Căn cứ |
|---|---|---|---|---|
| REQ-01: họ tên bắt buộc | EC01 | Có cung cấp họ tên | Valid theo điều kiện bắt buộc | SRS `README.md`, mục 2, FR-01, gạch đầu dòng 1 |
| REQ-01 | EC02 | Không cung cấp họ tên | Invalid theo điều kiện bắt buộc | Như trên |
| REQ-02: email hợp lệ và duy nhất | EC03 | Email đúng định dạng và chưa tồn tại | Valid | SRS `README.md`, mục 2, FR-01, gạch đầu dòng 2 |
| REQ-01/02 | EC04 | Không cung cấp email | Invalid theo yêu cầu cung cấp email | SRS `README.md`, mục 2, FR-01, gạch đầu dòng 1–2 |
| REQ-02 | EC05 | Email không đúng định dạng | Invalid | SRS `README.md`, mục 2, FR-01, gạch đầu dòng 2 |
| REQ-02 | EC06 | Email đúng định dạng nhưng đã được dùng | Invalid theo yêu cầu duy nhất | Như trên |
| REQ-03: độ dài mật khẩu | EC07 | Dài ít nhất 8 ký tự | Valid theo điều kiện độ dài | SRS `README.md`, mục 2, FR-01, gạch đầu dòng 3 |
| REQ-03 | EC08 | Dưới 8 ký tự | Invalid theo điều kiện độ dài | Như trên |
| REQ-03: chữ hoa | EC09 | Có ít nhất một chữ hoa | Valid theo điều kiện chữ hoa | Như trên |
| REQ-03 | EC10 | Không có chữ hoa | Invalid theo điều kiện chữ hoa | Như trên |
| REQ-03: chữ thường | EC11 | Có ít nhất một chữ thường | Valid theo điều kiện chữ thường | Như trên |
| REQ-03 | EC12 | Không có chữ thường | Invalid theo điều kiện chữ thường | Như trên |
| REQ-03: chữ số | EC13 | Có ít nhất một chữ số | Valid theo điều kiện chữ số | Như trên |
| REQ-03 | EC14 | Không có chữ số | Invalid theo điều kiện chữ số | Như trên |
| REQ-03: ký tự đặc biệt | EC15 | Có ít nhất một ký tự trong `@`, `$`, `!`, `%`, `*`, `?`, `&` | Valid theo điều kiện tập ký tự | Như trên |
| REQ-03 | EC16 | Không có ký tự thuộc tập quy định | Invalid theo điều kiện tập ký tự | Như trên |
| REQ-04: xác nhận mật khẩu | EC17 | Hai trường mật khẩu khớp nhau | Valid theo điều kiện khớp | SRS `README.md`, mục 2, FR-01, gạch đầu dòng 4 |
| REQ-04 | EC18 | Hai trường không khớp; xác nhận rỗng là một trường hợp của lớp này | Invalid; SRS quy định từ chối khi không khớp | Như trên |

Phân hoạch có 18 lớp. `domain-testing.md` hiện tách xác nhận rỗng và xác nhận khác thành EC18/EC19, nhưng SRS chỉ nêu hành vi chung “từ chối nếu hai trường không khớp”; không quy định xử lý hoặc kết quả khác nhau giữa hai trường hợp. Vì vậy bản demo gộp chúng thành một lớp hành vi, còn có thể giữ cả hai làm biến thể dữ liệu. Các giá trị khoảng trắng, grammar email ngoài ví dụ và giới hạn trường chưa được SRS xác định nên không xếp vào lớp Invalid.

## 4. Test case Domain Testing và bao phủ

**Bộ dữ liệu nền hợp lệ** cho các trường không bị thay đổi trong từng dòng: họ tên `Nguyễn Văn An`; email hợp lệ, chưa tồn tại (dùng email riêng cho từng lần đăng ký thành công); mật khẩu và xác nhận `Abcdef1!`. Các bước chung: mở form đăng ký, nhập bộ dữ liệu nền với giá trị thay thế ở bảng, submit và ghi nhận kết quả. TC05 cần chuẩn bị trước một tài khoản dùng email test. Expected result là **thiết kế**, căn cứ các yêu cầu SRS tại `README.md`, mục 2, FR-01; không phải kết quả đã chạy. Với REQ-01/02/03, không quy định câu chữ/thể thức phản hồi lỗi, nên không nêu thông báo hoặc response cụ thể.

| TC ID | Lớp bao phủ | Tiền điều kiện | Dữ liệu kiểm thử (các trường không nêu giữ hợp lệ) | Bước thực hiện | Expected result | Căn cứ |
|---|---|---|---|---|---|---|
| TC01 | EC01, EC03, EC07, EC09, EC11, EC13, EC15, EC17 | Email chưa tồn tại | Họ tên hợp lệ; email hợp lệ mới; mật khẩu/xác nhận `Abcdef1!` | Nhập form và submit | Đăng ký thành công và chuyển đến trang Đăng nhập | SRS `README.md`, mục 2, FR-01, gạch đầu dòng 1–5 |
| TC02 | EC02 | Email mới | Họ tên rỗng; bộ dữ liệu nền cho các trường khác | Nhập form, submit | Họ tên không đáp ứng yêu cầu phải cung cấp; SRS không quy định thông báo/thể thức từ chối cụ thể | SRS `README.md`, mục 2, FR-01, gạch đầu dòng 1 |
| TC03 | EC04 | Trường khác theo bộ dữ liệu nền | Email rỗng | Nhập form, submit | Email không đáp ứng yêu cầu phải cung cấp và hợp lệ; phản hồi cụ thể chưa được quy định | SRS `README.md`, mục 2, FR-01, gạch đầu dòng 1–2 |
| TC04 | EC05 | Email không trùng; trường khác theo bộ dữ liệu nền | Email `nguyen-at-example.com` | Nhập form, submit | Email không đáp ứng điều kiện định dạng hợp lệ; response cụ thể chưa được quy định | SRS `README.md`, mục 2, FR-01, gạch đầu dòng 2 |
| TC05 | EC06 | Tồn tại tài khoản với email kiểm thử | Email đúng định dạng đã đăng ký; trường khác theo bộ dữ liệu nền | Nhập form, submit | Email không đáp ứng yêu cầu duy nhất; response cụ thể chưa được quy định | SRS `README.md`, mục 2, FR-01, gạch đầu dòng 2 |
| TC06 | EC08 | Email mới; thành phần mật khẩu khác hợp lệ | Mật khẩu và xác nhận `Ab1!` (4 ký tự) | Nhập form, submit | Mật khẩu không đáp ứng độ dài tối thiểu; phản hồi cụ thể chưa được quy định | SRS `README.md`, mục 2, FR-01, gạch đầu dòng 3 |
| TC07 | EC10 | Email mới; các điều kiện mật khẩu khác hợp lệ | Mật khẩu và xác nhận `abcdefg1!` | Nhập form, submit | Mật khẩu không đáp ứng điều kiện có chữ hoa; phản hồi cụ thể chưa được quy định | SRS `README.md`, mục 2, FR-01, gạch đầu dòng 3 |
| TC08 | EC12 | Email mới; các điều kiện mật khẩu khác hợp lệ | Mật khẩu và xác nhận `ABCDEFG1!` | Nhập form, submit | Mật khẩu không đáp ứng điều kiện có chữ thường; phản hồi cụ thể chưa được quy định | SRS `README.md`, mục 2, FR-01, gạch đầu dòng 3 |
| TC09 | EC14 | Email mới; các điều kiện mật khẩu khác hợp lệ | Mật khẩu và xác nhận `Abcdefg!` | Nhập form, submit | Mật khẩu không đáp ứng điều kiện có chữ số; phản hồi cụ thể chưa được quy định | SRS `README.md`, mục 2, FR-01, gạch đầu dòng 3 |
| TC10 | EC16 | Email mới; các điều kiện mật khẩu khác hợp lệ | Mật khẩu và xác nhận `Abcdefg1` | Nhập form, submit | Mật khẩu không đáp ứng điều kiện có ký tự trong tập quy định; phản hồi cụ thể chưa được quy định | SRS `README.md`, mục 2, FR-01, gạch đầu dòng 3 |
| TC11 | EC18 | Email mới; mật khẩu hợp lệ theo bộ dữ liệu nền | Xác nhận mật khẩu rỗng | Nhập form, submit | Hai trường không khớp nên hệ thống từ chối; câu chữ/thể thức phản hồi chưa được quy định | SRS `README.md`, mục 2, FR-01, gạch đầu dòng 4 |
| TC12 | EC18 | Email mới; mật khẩu hợp lệ theo bộ dữ liệu nền | Mật khẩu `Abcdef1!`; xác nhận `Abcdef2!` | Nhập form, submit | Hai trường không khớp nên hệ thống từ chối; câu chữ/thể thức phản hồi chưa được quy định | SRS `README.md`, mục 2, FR-01, gạch đầu dòng 4 |

### Đối chiếu độ bao phủ

| Điều kiện | Các lớp | Test case ánh xạ | Kết quả rà soát |
|---|---|---|---|
| C1 Họ tên | EC01–EC02 | TC01, TC02 | Đã có đại diện |
| C2–C3 Email | EC03–EC06 | TC01, TC03–TC05 | Đã có đại diện; EC06 cần tài khoản có sẵn |
| C4 Độ dài | EC07–EC08 | TC01, TC06 | Có ánh xạ; SRS xác nhận tối thiểu 8 ký tự |
| C5 Chữ hoa | EC09–EC10 | TC01, TC07 | Đã có ánh xạ |
| C6 Chữ thường | EC11–EC12 | TC01, TC08 | Đã có ánh xạ |
| C7 Chữ số | EC13–EC14 | TC01, TC09 | Đã có ánh xạ |
| C8 Ký tự đặc biệt | EC15–EC16 | TC01, TC10 | Có ánh xạ; tập ký tự được SRS quy định |
| C9 Xác nhận mật khẩu | EC17–EC18 | TC01, TC11, TC12 | Đã có ánh xạ; hai test invalid là biến thể của một lớp không khớp |

Tất cả 18 lớp trong phân hoạch demo có test đại diện. Đây là độ bao phủ thiết kế, không phải bằng chứng thực thi. `domain-testing.md` hiện có 19 lớp do tách trường xác nhận rỗng và xác nhận khác nhau; bản demo gộp hai trường hợp vào EC18 vì SRS không quy định khác biệt hành vi. Các kết quả thực thi không được nhập vào tài liệu này.

## 5. BVA — phân tích độc lập

| BVA ID | Miền/yêu cầu | Biên | Giá trị kiểm thử | Điều kiện giữ cố định | Expected result (thiết kế) | Căn cứ và giới hạn |
|---|---|---|---|---|---|---|
| BVA-FR01-01 | REQ-03, độ dài mật khẩu | Ngay dưới biên tối thiểu 8 ký tự | 7 ký tự: `Abcde1!` | Họ tên hợp lệ; email hợp lệ, chưa tồn tại; đủ các thành phần mật khẩu khác; xác nhận khớp | Không đạt điều kiện độ dài tối thiểu; SRS không quy định response/message cụ thể | SRS `README.md`, mục 2, FR-01, gạch đầu dòng 3 |
| BVA-FR01-02 | REQ-03, độ dài mật khẩu | Tại biên tối thiểu | 8 ký tự: `Abcdef1!` | Như trên; email riêng chưa tồn tại | Đạt điều kiện độ dài; với các điều kiện khác hợp lệ, đăng ký thành công và chuyển tới trang Đăng nhập | SRS `README.md`, mục 2, FR-01, gạch đầu dòng 3 và 5 |
| BVA-FR01-03 | REQ-03, độ dài mật khẩu | Ngay trên biên tối thiểu | 9 ký tự: `Abcdefg1!` | Như trên; email riêng chưa tồn tại | Đạt điều kiện độ dài; với các điều kiện khác hợp lệ, đăng ký thành công và chuyển tới trang Đăng nhập | SRS `README.md`, mục 2, FR-01, gạch đầu dòng 3 và 5 |

SRS xác định rõ biên dưới 8 ký tự nên BVA 7/8/9 có căn cứ. Đơn vị lân cận dùng trong thiết kế là một ký tự ASCII; cách đếm Unicode chưa được quy định. Không đủ căn cứ thiết kế BVA chính thức cho email, họ tên, tập thành phần mật khẩu rời rạc, xác nhận mật khẩu hoặc số lượng tài khoản. Thành phần mật khẩu là các điều kiện phân lớp, không phải biên số học.

## 6. Điểm cần con người rà soát

1. Xác nhận phạm vi thực thi là UI, `POST /api/register` hay cả hai. SRS quy định trường xác nhận, nhưng API specification mục 1.1 không liệt kê trường này trong body mẫu.
2. Xác nhận grammar email đầy đủ, việc so trùng email có phân biệt chữ hoa/thường không, cách xử lý khoảng trắng, giới hạn họ tên/email và cách đếm ký tự Unicode.
3. Xác nhận với chủ sở hữu yêu cầu nếu cần thông báo lỗi hoặc response API cụ thể; các nguồn đã đọc chưa quy định chúng.
4. Chuẩn bị email mới riêng cho mỗi ca đăng ký thành công và tài khoản có sẵn cho TC05 trước khi thực thi.
5. Tài liệu này và [bản kiểm chứng Skill](./FR-01-skill-validation.md) cùng dùng SRS `README.md` làm nguồn yêu cầu, API specification làm nguồn contract API, Domain Testing có 18 lớp (EC18 gộp hai biến thể không khớp), và BVA 7/8/9. Cả hai đều là thiết kế, không chứa actual result.
6. Sau khi test thủ công/chạy thật, ghi actual result, trạng thái và evidence vào tài liệu execution phù hợp, không vào bản demo này.
