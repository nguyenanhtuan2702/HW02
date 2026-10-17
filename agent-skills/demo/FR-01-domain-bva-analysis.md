# FR-01 Registration — Domain Testing và BVA

## 1. Mục đích, phạm vi và cách đọc kết quả

Tài liệu này thiết kế kiểm thử cho FR-01 Registration dựa trên đặc tả gốc. Phạm vi gồm yêu cầu nghiệp vụ, hợp đồng API đăng ký được tài liệu hóa và yêu cầu giao diện biểu mẫu liên quan trực tiếp. Đây là **phân tích thiết kế**, không phải kết quả chạy test.

Thứ tự căn cứ:

1. `D:\eshop-sut\README.md` là SRS, nguồn ưu tiên cho yêu cầu nghiệp vụ FR-01 và yêu cầu GUI FR-22.
2. `D:\eshop-sut\api_specification.md` bổ sung endpoint, request mẫu và phản hồi thành công của API; tài liệu không quy định phản hồi lỗi.
3. `D:\HW02\FR-01-registration\domain-testing.md`, `bva.md` và `execution-results.md` là tài liệu phân tích/kết quả hiện hành để đối chiếu, không phải nguồn tạo ra yêu cầu.

Ngày/phiên bản đặc tả không được nêu trong các tài liệu đã đọc. Không suy ra giới hạn hoặc hành vi không được ghi rõ.

## 2. Nguồn và yêu cầu truy vết

| ID | Yêu cầu có căn cứ | Nguồn và vị trí |
|---|---|---|
| REQ-01 | Người đăng ký phải cung cấp Họ Tên. | SRS `README.md`, `### FR-01: Đăng ký tài khoản`, dòng 32. |
| REQ-02 | Email phải có định dạng hợp lệ (ví dụ `user@domain.com`) và duy nhất trong hệ thống. | SRS `README.md`, `### FR-01`, dòng 33. |
| REQ-03 | Mật khẩu có ít nhất 8 ký tự, ít nhất một chữ hoa, một chữ thường, một chữ số và một ký tự trong tập `@`, `$`, `!`, `%`, `*`, `?`, `&`. | SRS `README.md`, `### FR-01`, dòng 34. |
| REQ-04 | Form có trường Xác nhận mật khẩu; hệ thống từ chối nếu hai trường mật khẩu không khớp. | SRS `README.md`, `### FR-01`, dòng 35. |
| REQ-05 | Đăng ký thành công chuyển người dùng tới trang Đăng nhập. | SRS `README.md`, `### FR-01`, dòng 36. |
| REQ-06 | Trường bắt buộc có dấu `*`; email dùng `type="email"`; mật khẩu dùng `type="password"`; thông báo lỗi nằm phía trên nút submit. | SRS `README.md`, `### FR-22: Form Requirements`, dòng 250 và 252–255. |
| REQ-07 | API đăng ký là `POST /api/register`, request mẫu gồm `name`, `email`, `password`; phản hồi thành công mẫu là HTTP 200 và JSON có `message` cùng `id`. | `api_specification.md`, `### 1.1 Đăng ký tài khoản`, dòng 11–21. |

**Lưu ý về nguồn/API:** API spec không mô tả validation, các phản hồi lỗi, kiểu/range của `id`, hay trường xác nhận mật khẩu trong request. Do đó REQ-07 chỉ làm căn cứ cho hình dạng request/response thành công đã nêu, không chứng minh API tự thực thi mọi validation của FR-01. Việc FR-01 yêu cầu xác nhận mật khẩu trong khi request API mẫu chỉ có ba trường là điểm cần chủ sở hữu đặc tả làm rõ cho luồng API trực tiếp.

## 3. Biến và điều kiện

| Biến | Miền được đặc tả | Điều kiện/chưa xác định |
|---|---|---|
| Họ Tên (`name`) | Giá trị được cung cấp. | Rỗng là không đáp ứng “phải cung cấp”. Không có quy định về độ dài, ký tự, khoảng trắng hay chuẩn hóa. |
| Email | Định dạng hợp lệ; chưa được dùng trong hệ thống. | Ví dụ định dạng là `user@domain.com`. Không có grammar đầy đủ, quy tắc hoa/thường, trimming hoặc giới hạn độ dài. |
| Mật khẩu | Tối thiểu 8 ký tự; phải có đủ 4 nhóm thành phần được liệt kê. | Không có giới hạn tối đa, quy tắc Unicode/đếm ký tự đặc biệt, hoặc quy tắc cho khoảng trắng. |
| Xác nhận mật khẩu | Có trường; giá trị phải khớp với mật khẩu. | Đặc tả không quy định riêng thông báo hoặc cách xử lý trường xác nhận rỗng ngoài quy tắc không khớp. |
| Kết quả | Đăng ký thành công dẫn tới trang Đăng nhập. | Không quy định URL cụ thể, nội dung thông báo thành công/thất bại, mã HTTP/lỗi API hay dữ liệu lỗi. |

## 4. Domain Testing — phân hoạch tương đương

Các lớp Invalid dưới đây chỉ dựa trên điều kiện vi phạm nêu trong SRS. Từng test Invalid ở phần 5 chỉ thay đổi một điều kiện; các trường hợp khác giữ hợp lệ. Lớp `EC18` kiểm tra giá trị khác mật khẩu; trường xác nhận rỗng cũng không khớp về mặt giá trị nhưng không được tách thành một lớp có thông báo/hành vi riêng nếu chưa có yêu cầu.

| Điều kiện/Yêu cầu | Biến/miền | Lớp ID | Mô tả lớp | Phân loại | Căn cứ |
|---|---|---|---|---|---|
| REQ-01 | Họ Tên | EC01 | Họ Tên được cung cấp; nội dung/độ dài còn lại chưa bị ràng buộc trong FR-01. | Valid | SRS `README.md`, FR-01, dòng 32. |
| REQ-01 | Họ Tên | EC02 | Họ Tên rỗng/không được cung cấp. | Invalid | SRS `README.md`, FR-01, dòng 32: “phải cung cấp”. |
| REQ-02 | Email | EC03 | Email đúng định dạng và chưa tồn tại. | Valid | SRS `README.md`, FR-01, dòng 33. |
| REQ-02 | Email | EC04 | Email rỗng. | Invalid | SRS `README.md`, FR-01, dòng 32–33: phải cung cấp Email và Email phải đúng định dạng. |
| REQ-02 | Email | EC05 | Email không rỗng nhưng sai định dạng. | Invalid | SRS `README.md`, FR-01, dòng 33. |
| REQ-02 | Email | EC06 | Email đúng định dạng nhưng đã tồn tại. | Invalid | SRS `README.md`, FR-01, dòng 33: Email duy nhất. |
| REQ-03 | Độ dài mật khẩu | EC07 | Độ dài ít nhất 8 ký tự và các điều kiện thành phần được xét riêng. | Valid | SRS `README.md`, FR-01, dòng 34. |
| REQ-03 | Độ dài mật khẩu | EC08 | Độ dài dưới 8 ký tự, trong khi các nhóm thành phần khác được thỏa mãn. | Invalid | SRS `README.md`, FR-01, dòng 34. |
| REQ-03 | Chữ hoa | EC09 | Có ít nhất một chữ hoa; các điều kiện mật khẩu còn lại hợp lệ. | Valid | SRS `README.md`, FR-01, dòng 34. |
| REQ-03 | Chữ hoa | EC10 | Không có chữ hoa; các điều kiện mật khẩu còn lại hợp lệ. | Invalid | SRS `README.md`, FR-01, dòng 34. |
| REQ-03 | Chữ thường | EC11 | Có ít nhất một chữ thường; các điều kiện mật khẩu còn lại hợp lệ. | Valid | SRS `README.md`, FR-01, dòng 34. |
| REQ-03 | Chữ thường | EC12 | Không có chữ thường; các điều kiện mật khẩu còn lại hợp lệ. | Invalid | SRS `README.md`, FR-01, dòng 34. |
| REQ-03 | Chữ số | EC13 | Có ít nhất một chữ số; các điều kiện mật khẩu còn lại hợp lệ. | Valid | SRS `README.md`, FR-01, dòng 34. |
| REQ-03 | Chữ số | EC14 | Không có chữ số; các điều kiện mật khẩu còn lại hợp lệ. | Invalid | SRS `README.md`, FR-01, dòng 34. |
| REQ-03 | Ký tự đặc biệt | EC15 | Có ít nhất một ký tự thuộc tập `@`, `$`, `!`, `%`, `*`, `?`, `&`; các điều kiện khác hợp lệ. | Valid | SRS `README.md`, FR-01, dòng 34. |
| REQ-03 | Ký tự đặc biệt | EC16 | Không có ký tự nào thuộc tập được chấp nhận; các điều kiện khác hợp lệ. | Invalid | SRS `README.md`, FR-01, dòng 34. |
| REQ-04 | Mật khẩu và xác nhận | EC17 | Hai giá trị giống nhau. | Valid | SRS `README.md`, FR-01, dòng 35. |
| REQ-04 | Mật khẩu và xác nhận | EC18 | Hai giá trị khác nhau (bao gồm xác nhận rỗng nếu mật khẩu không rỗng); chỉ điều kiện khớp bị vi phạm. | Invalid | SRS `README.md`, FR-01, dòng 35. |

**Chưa xác định:** Quy tắc riêng cho xác nhận rỗng (bắt buộc độc lập, thứ tự validation hoặc thông báo riêng), nội dung/giới hạn Họ Tên, grammar chính xác email và các giới hạn mật khẩu ngoài tối thiểu. Không tạo thêm lớp Invalid cho các quy tắc chưa được đặc tả.

## 5. Test case Domain Testing đề xuất

`Email duy nhất` yêu cầu tiền điều kiện dữ liệu. Dùng địa chỉ test riêng trong môi trường được phép; không tái sử dụng email đã đăng ký. Các giá trị tên miền dưới đây là dữ liệu mẫu, cần thay bằng domain test được môi trường chấp nhận. Bước chung cho test UI: mở form Registration, nhập các dữ liệu, submit; không gọi API hoặc tạo dữ liệu trong lượt phân tích này.

| TC ID | Mục tiêu/lớp bao phủ | Tiền điều kiện | Dữ liệu đầu vào | Expected result (thiết kế) | Lý do chọn và căn cứ |
|---|---|---|---|---|---|
| DT-01 | Đăng ký hợp lệ; EC01, EC03, EC07, EC09, EC11, EC13, EC15, EC17; REQ-01–05 | Email chưa tồn tại. | `name=Nguyễn Văn An`; `email=fr01-dt01@example.test`; `password=Abcdefg1!`; xác nhận giống mật khẩu. | Chấp nhận đăng ký thành công và chuyển tới trang Đăng nhập. Không quy định URL hay thông báo cụ thể. | Bao phủ đường đi hợp lệ bằng một bộ dữ liệu; SRS `README.md`, FR-01 dòng 32–36. |
| DT-02 | Họ Tên thiếu; EC02 | Email mới, hợp lệ. | Tên rỗng; email hợp lệ; mật khẩu và xác nhận `Abcdefg1!`. | Từ chối đăng ký; không khẳng định nội dung thông báo cụ thể. | Chỉ vi phạm REQ-01; SRS `README.md`, FR-01 dòng 32. |
| DT-03 | Email thiếu; EC04 | Không cần tài khoản có sẵn. | Tên hợp lệ; email rỗng; mật khẩu và xác nhận `Abcdefg1!`. | Từ chối đăng ký; không khẳng định nội dung thông báo cụ thể. | Chỉ vi phạm điều kiện Email; SRS `README.md`, FR-01 dòng 32–33. |
| DT-04 | Email sai định dạng; EC05 | Không cần tài khoản có sẵn. | Tên hợp lệ; `email=not-an-email`; mật khẩu và xác nhận `Abcdefg1!`. | Từ chối đăng ký. Vị trí của thông báo nếu được hiển thị theo REQ-06; văn bản lỗi chưa xác định. | Chỉ vi phạm định dạng email; SRS `README.md`, FR-01 dòng 33; FR-22 dòng 253, 255. |
| DT-05 | Email trùng; EC06 | Đã có tài khoản với đúng email test. | Tên hợp lệ; email hợp lệ đã đăng ký; mật khẩu và xác nhận `Abcdefg1!`. | Từ chối đăng ký. Không xác định văn bản lỗi hay mã phản hồi. | Giữ định dạng email hợp lệ, chỉ vi phạm tính duy nhất; SRS `README.md`, FR-01 dòng 33. |
| DT-06 | Mật khẩu dưới mức tối thiểu; EC08 | Email mới, hợp lệ. | Tên hợp lệ; mật khẩu/xác nhận `Abcde1!` (7 ký tự, có đủ nhóm thành phần). | Từ chối đăng ký. | Cô lập độ dài; SRS `README.md`, FR-01 dòng 34. |
| DT-07 | Thiếu chữ hoa; EC10 | Email mới, hợp lệ. | Tên hợp lệ; mật khẩu/xác nhận `abcdefg1!` (9 ký tự). | Từ chối đăng ký. | Các điều kiện độ dài, chữ thường, số, ký tự đặc biệt đều đạt; chỉ thiếu chữ hoa. SRS `README.md`, FR-01 dòng 34. |
| DT-08 | Thiếu chữ thường; EC12 | Email mới, hợp lệ. | Tên hợp lệ; mật khẩu/xác nhận `ABCDEFG1!` (9 ký tự). | Từ chối đăng ký. | Các điều kiện còn lại đạt; chỉ thiếu chữ thường. SRS `README.md`, FR-01 dòng 34. |
| DT-09 | Thiếu chữ số; EC14 | Email mới, hợp lệ. | Tên hợp lệ; mật khẩu/xác nhận `Abcdefg!!` (9 ký tự). | Từ chối đăng ký. | Các điều kiện còn lại đạt; chỉ thiếu chữ số. SRS `README.md`, FR-01 dòng 34. |
| DT-10 | Thiếu ký tự đặc biệt được chấp nhận; EC16 | Email mới, hợp lệ. | Tên hợp lệ; mật khẩu/xác nhận `Abcdefg12` (9 ký tự). | Từ chối đăng ký. | Các điều kiện còn lại đạt; không chứa ký tự nào trong tập được liệt kê. SRS `README.md`, FR-01 dòng 34. |
| DT-11 | Mật khẩu xác nhận không khớp; EC18 | Email mới, hợp lệ. | Tên hợp lệ; `password=Abcdefg1!`; `confirm=Abcdefg2!`. | Từ chối đăng ký. Nội dung thông báo cụ thể chưa xác định. | Cả hai mật khẩu riêng rẽ đều đáp ứng quy tắc; chỉ quan hệ bằng nhau không đạt. SRS `README.md`, FR-01 dòng 35. |
| DT-12 | Hợp đồng API thành công; REQ-07 | Email chưa tồn tại; API/môi trường thử nghiệm sẵn có nếu sau này thực thi. | `POST /api/register`; JSON gồm `name=Nguyen Van A`, email riêng chưa dùng, `password=Password123!`. | Theo ví dụ API: HTTP 200 và JSON có `message: "User registered successfully"` cùng `id`. Giá trị `id` cụ thể không cố định. | Kiểm tra response contract thành công được tài liệu hóa, không kiểm tra validation lỗi. `api_specification.md`, mục 1.1 dòng 11–21. |
| DT-13 | Yêu cầu giao diện biểu mẫu; REQ-06 | Form Registration được mở. | Quan sát nhãn và input của các trường bắt buộc, email, mật khẩu, xác nhận và vị trí lỗi khi có lỗi. | Trường bắt buộc có `*`; email `type="email"`; trường mật khẩu dùng `type="password"`; thông báo lỗi hiển thị phía trên nút submit. Không chốt câu chữ thông báo. | Kiểm tra yêu cầu GUI trực tiếp; SRS `README.md`, FR-22 dòng 252–255. |

### Bao phủ và giới hạn

| Yêu cầu/lớp | Test bao phủ | Trạng thái thiết kế |
|---|---|---|
| REQ-01 / EC01–EC02 | DT-01, DT-02 | Bao phủ |
| REQ-02 / EC03–EC06 | DT-01, DT-03–DT-05 | Bao phủ; cần email chưa dùng và email có sẵn |
| REQ-03 / EC07–EC16 | DT-01, DT-06–DT-10 và BVA-01–03 | Bao phủ các điều kiện thành phần và độ dài |
| REQ-04 / EC17–EC18 | DT-01, DT-11 | Bao phủ match/non-match; không gán phản hồi riêng cho xác nhận rỗng |
| REQ-05 | DT-01 | Bao phủ luồng thành công |
| REQ-06 | DT-13 | Bao phủ kiểm tra giao diện |
| REQ-07 | DT-12 | Chỉ thiết kế dựa trên phản hồi thành công trong API spec |

Chưa thiết kế test API cho dữ liệu không hợp lệ vì API spec không nêu quy tắc/response lỗi. Chưa thể kiểm tra tính duy nhất nếu không có tài khoản email đã tồn tại; chưa thể thực thi UI/API nếu không có môi trường. Đây là giới hạn thiết kế, không phải kết quả Pass/Fail.

## 6. BVA riêng — độ dài tối thiểu mật khẩu

SRS chỉ nêu giới hạn số học tường minh là tối thiểu 8 ký tự. Không có căn cứ cho biên tối đa của mật khẩu, độ dài email/tên, hoặc khoảng số học khác. Vì vậy chỉ lập BVA chính thức quanh biên dưới này. Các mật khẩu mẫu dùng ký tự ASCII để tránh nhập nhằng khi đếm ký tự Unicode; đây là lựa chọn dữ liệu kiểm thử, không phải quy tắc giới hạn encoding.

| BVA ID | Yêu cầu/miền | Biên | Giá trị | Dữ liệu/điều kiện giữ cố định | Expected result (thiết kế) | Căn cứ |
|---|---|---|---|---|---|---|
| BVA-01 | REQ-03, độ dài mật khẩu tính bằng ký tự | Ngay dưới biên 8 | `Abcde1!` — 7 ký tự | Tên hợp lệ; email hợp lệ chưa dùng; xác nhận khớp; đủ chữ hoa, chữ thường, số, ký tự đặc biệt. | Từ chối do không đạt tối thiểu 8 ký tự. | SRS `README.md`, FR-01 dòng 34. |
| BVA-02 | REQ-03, độ dài mật khẩu tính bằng ký tự | Tại biên 8 | `Abcdef1!` — 8 ký tự | Giữ như BVA-01, chỉ thay password và confirm tương ứng; đủ thành phần. | Đạt điều kiện độ dài; nếu các điều kiện khác hợp lệ thì không được từ chối vì độ dài. Kết quả tổng thể phải đáp ứng FR-01. | SRS `README.md`, FR-01 dòng 34. |
| BVA-03 | REQ-03, độ dài mật khẩu tính bằng ký tự | Ngay trên biên 8 | `Abcdefg1!` — 9 ký tự | Giữ như BVA-01; đủ thành phần. | Đạt điều kiện độ dài; không khẳng định giới hạn tối đa chưa được đặc tả. | SRS `README.md`, FR-01 dòng 34. |

Không áp dụng BVA cho trạng thái email duy nhất, định dạng email hay khớp mật khẩu: đặc tả chưa cho đơn vị/lân cận số học thích hợp.

## 7. Đối chiếu với tài liệu HW02 hiện có

Tài liệu được đối chiếu: [`domain-testing.md`](../../FR-01-registration/domain-testing.md), [`bva.md`](../../FR-01-registration/bva.md), [`execution-results.md`](../../FR-01-registration/execution-results.md). Các ghi nhận này là review tài liệu; không thay đổi hay thực thi lại kết quả lịch sử.

| Chủ đề | Điểm trùng khớp | Thiếu/điểm cần xem xét | Căn cứ/đề xuất |
|---|---|---|---|
| Miền đầu vào và lớp | Tài liệu Domain hiện có nhận diện name, email, password, confirm; chia email format/duplicate và từng điều kiện mật khẩu tương tự. | Lớp Invalid xác nhận rỗng EC18 được tách riêng dù SRS không quy định hành vi/thông báo riêng cho trường rỗng. Có thể giữ như dữ liệu kiểm tra, nhưng không nên tuyên bố đó là lớp hành vi riêng nếu chưa xác minh. | SRS FR-01 dòng 35 chỉ nói có trường và từ chối khi không khớp; tách trường hợp theo quan sát/đặc tả bổ sung. |
| Expected error | Kỳ vọng từ chối khi tên/email thiếu, email sai/trùng và mật khẩu yếu phù hợp với các điều kiện FR-01. | Những expected result đòi thông báo chính xác như “họ và tên là trường bắt buộc”, “email đã được sử dụng” chưa được đặc tả câu chữ. “Thông báo lỗi phù hợp” không được ghi cho FR-01. | Giữ expected ở mức từ chối; áp dụng vị trí lỗi trên nút submit từ FR-22, không tự đặt nội dung. |
| Password invalid | TC06–TC10 chọn từng vi phạm riêng; dữ liệu cho các thuộc tính còn lại phần lớn đáp ứng điều kiện. | Đảm bảo test các class Invalid chạy trên giao diện/luồng thực thi có căn cứ. API spec chỉ tài liệu hóa ví dụ thành công, không nêu validation lỗi. | API test invalid cần được xác nhận thêm trước khi expected được gán ở tầng API. |
| Confirmation | Lớp khớp/không khớp trong tài liệu hiện có phù hợp FR-01. | EC18 (xác nhận rỗng) và EC19 (giá trị khác) **theo mã của `domain-testing.md` cũ** được đếm như hai Invalid dù phản hồi riêng chưa được quy định; API request mẫu không có trường xác nhận. Execution record nói UI không có trường và API không nhận trường, đây là dấu hiệu cần xác minh, không phải yêu cầu mới. Trong phân hoạch mới ở phần 4, EC18 là lớp mismatch tổng quát. | Làm rõ API có bắt buộc confirmation không và có khác biệt xử lý/feedback giữa rỗng và khác hay không. |
| Test case Domain | TC01–TC12 bao phủ các lớp do tài liệu hiện tại liệt kê; cách cô lập lỗi nhìn chung rõ. | Thiếu case dành riêng cho API response thành công và yêu cầu GUI FR-22; một số case TC04–TC10 trong execution record được gửi tới API. | Bổ sung thiết kế DT-12, DT-13; phân biệt kiểm thử form với kiểm thử endpoint. |
| BVA | BVA hiện tại chọn 7/8/9 ký tự; các giá trị `Abcde1!`, `Abcdef1!`, `Abcdefg1!` đúng lần lượt 7/8/9 và đủ nhóm thành phần theo yêu cầu. | Bộ điểm biên hợp lý và đầy đủ cho biên tối thiểu duy nhất. Expected tại 8/9 chỉ có thể khẳng định điều kiện độ dài, không phải kết quả thực thi; tài liệu hiện tại đã ghi chú giới hạn này. | SRS FR-01 dòng 34; giữ riêng BVA khỏi lớp tương đương. |
| Execution results | Tài liệu hiện hành ghi lại kết quả và evidence lịch sử, không được sửa trong phạm vi công việc này. | `execution-results.md` ghi nhận TC04–TC10 thành công khi gửi input vốn được thiết kế Invalid tới API, và BVA-02/03 fail trong lần chạy nêu tại bảng. Không thể diễn giải lại các actual này thành kết quả của lượt phân tích mới; cần con người xem xét cả tầng test, dữ liệu, evidence và hành vi đặc tả. | Chỉ tham chiếu như nội dung đã ghi trong `execution-results.md`; lượt này không chạy test/API và không xác minh lại evidence. |

## 8. Chưa rõ, giả định và review cần thiết

- **Cần xác nhận:** API trực tiếp có phải thực thi tất cả quy tắc FR-01 và phải nhận/kiểm tra trường xác nhận mật khẩu không.
- **Cần xác nhận:** Có yêu cầu riêng rằng xác nhận mật khẩu phải không rỗng, hay chỉ cần so sánh bằng mật khẩu; có thông báo riêng cho từng lỗi không.
- **Chưa xác định:** Grammar email chính thức, xử lý khoảng trắng/hoa thường, tên miền/email dài tối đa; giới hạn tối đa và cách đếm ký tự mật khẩu; chính sách ký tự Unicode.
- **Chưa xác định:** Mã HTTP và cấu trúc lỗi cho từng trường hợp thất bại; API spec chỉ ghi phản hồi thành công.
- **Giả định dữ liệu kiểm thử:** Địa chỉ `example.test` là placeholder, cần thay bằng email mới mà môi trường test chấp nhận. Không được dùng địa chỉ này như một giới hạn đặc tả.
- Các expected result trong hai bảng test là **kết quả mong đợi được thiết kế**, không phải actual, trạng thái Pass/Fail hay bằng chứng thực thi.

## 9. Kiểm tra chất lượng thiết kế

- Mỗi điều kiện/lớp và expected result được dẫn về FR-01, FR-22 hoặc API mục 1.1.
- Từng test Invalid Domain chỉ vi phạm một điều kiện đang kiểm tra; tiền điều kiện email/tài khoản được nêu khi cần.
- BVA tách riêng Domain Testing và chỉ dùng biên tối thiểu được đặc tả; điểm dưới/tại/trên là 7/8/9.
- Không tạo thông báo lỗi, giới hạn hay hành vi thất bại API ngoài tài liệu.
- Không chạy test, gọi API, sửa tài liệu gốc, execution results hoặc evidence trong lượt này.
