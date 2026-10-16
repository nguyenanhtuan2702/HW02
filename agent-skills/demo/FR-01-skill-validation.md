# FR-01 Registration — Kiểm chứng Domain Testing và BVA

> **Loại tài liệu:** Phân tích thiết kế mới dựa trên đặc tả gốc; không phải kết quả thực thi. Không ghi actual result, PASS/FAIL hoặc evidence.
>
> **Skill:** `eshop-domain-bva-testing` đã được gọi trong phiên này và quy trình trong `SKILL.md` được áp dụng.

## 1. Phạm vi, nguồn và giới hạn

- **Feature/actor:** FR-01 — người dùng đăng ký tài khoản EShop.
- **Luồng trong phạm vi:** Cung cấp họ tên, email, mật khẩu và xác nhận mật khẩu; kiểm tra các điều kiện FR-01; khi đăng ký thành công, chuyển tới trang Đăng nhập.
- **Nguồn ưu tiên:** SRS là nguồn yêu cầu nghiệp vụ; API specification được dùng để đối chiếu giao diện API, không thay thế các quy tắc FR-01 trong SRS.
- **Đặc tả gốc:** [`eshop-sut/README.md`](../../../eshop-sut/README.md), tài liệu *Đặc tả Yêu cầu Hệ thống (System Requirements Specification)*, phiên bản 2.0 (cập nhật 2026-05-14), mục **2. Quản lý Tài khoản**, heading **FR-01: Đăng ký tài khoản**. Các trích dẫn dưới đây giữ nguyên nội dung yêu cầu, rút gọn khi cần.
- **Đối chiếu API:** [`eshop-sut/api_specification.md`](../../../eshop-sut/api_specification.md), mục **1.1 Đăng ký tài khoản**: `POST /api/register`; body mẫu có `name`, `email`, `password`; phản hồi thành công mẫu là `200 OK` cùng `{"message":"User registered successfully","id":1}`.
- **Nguồn thứ cấp để đối chiếu:** [`FR-01-registration/domain-testing.md`](../../FR-01-registration/domain-testing.md) và [`FR-01-registration/bva.md`](../../FR-01-registration/bva.md). Đây là tài liệu test design hiện có, không phải nguồn yêu cầu ưu tiên hơn SRS.
- **Ngoài phạm vi:** Chạy test, xác minh triển khai, đánh giá screenshot/trace, sửa test plan hoặc ghi nhận kết quả thực thi.

## 2. Yêu cầu, biến và hành vi

Các mã REQ dưới đây là mã truy vết tạm cho các câu trong FR-01; không thay thế mã FR-01.

| Mã | Yêu cầu/điều kiện được trích từ SRS | Biến/đầu ra | Căn cứ |
|---|---|---|---|
| REQ-01 | “Người dùng phải cung cấp: **Họ Tên**, **Email**, **Mật khẩu**.” | Họ tên, email, mật khẩu | `README.md`, mục 2, FR-01, gạch đầu dòng 1 |
| REQ-02 | “Email phải có định dạng hợp lệ (`user@domain.com`) và là duy nhất trong hệ thống.” | Định dạng email; trạng thái đã đăng ký/chưa đăng ký | `README.md`, mục 2, FR-01, gạch đầu dòng 2 |
| REQ-03 | “Tối thiểu 8 ký tự, có ít nhất 1 chữ hoa, 1 chữ thường, 1 chữ số và 1 ký tự đặc biệt (`@`, `$`, `!`, `%`, `*`, `?`, `&`).” | Độ dài và thành phần mật khẩu | `README.md`, mục 2, FR-01, gạch đầu dòng 3 |
| REQ-04 | “Phải có trường **Xác nhận mật khẩu** — hệ thống từ chối nếu hai trường không khớp.” | Mật khẩu và xác nhận mật khẩu | `README.md`, mục 2, FR-01, gạch đầu dòng 4 |
| REQ-05 | “Sau khi đăng ký thành công, người dùng được chuyển tới trang Đăng nhập.” | Kết quả đăng ký và trang đích | `README.md`, mục 2, FR-01, gạch đầu dòng 5 |
| API-01 | API đăng ký là `POST /api/register`, body mẫu gồm `name`, `email`, `password`; có ví dụ phản hồi thành công `200 OK`. | Request/response API | `api_specification.md`, mục 1.1 |

**Giới hạn/điểm chưa xác định từ nguồn:** SRS đưa `user@domain.com` làm ví dụ định dạng, không đặc tả đầy đủ grammar email; không định nghĩa phân biệt chữ hoa/thường khi so trùng email. SRS không quy định độ dài tối đa/tối thiểu của họ tên hoặc email, cách đếm độ dài mật khẩu với Unicode, thông báo lỗi cụ thể hay cấu trúc/status phản hồi khi đăng ký thất bại. API specification không liệt kê trường xác nhận mật khẩu trong body và không mô tả các quy tắc kiểm tra/thất bại. Vì vậy, không tự thêm các quy tắc hoặc thông báo này vào expected result.

## 3. Domain Testing — phân lớp tương đương

Các lớp dưới đây áp dụng theo từng điều kiện. Một giá trị mật khẩu có thể thuộc lớp hợp lệ của một điều kiện nhưng vẫn không hợp lệ theo điều kiện mật khẩu khác. `Valid`/`Invalid` mô tả lớp trên điều kiện được nêu, không tự khẳng định toàn bộ request hợp lệ.

| Điều kiện | Biến/miền | Lớp ID | Mô tả lớp | Phân loại | Căn cứ |
|---|---|---|---|---|---|
| REQ-01: cung cấp họ tên | Họ tên | EC01 | Có cung cấp giá trị họ tên | Valid theo điều kiện bắt buộc | `README.md`, mục 2, FR-01, gạch đầu dòng 1 |
| REQ-01 | Họ tên | EC02 | Không cung cấp họ tên | Invalid theo điều kiện bắt buộc | Như trên |
| REQ-02: định dạng và duy nhất | Email | EC03 | Email đúng định dạng và chưa được dùng | Valid | `README.md`, mục 2, FR-01, gạch đầu dòng 2 |
| REQ-02 | Email | EC04 | Không cung cấp email | Invalid theo yêu cầu phải cung cấp và email phải hợp lệ | Như trên |
| REQ-02 | Email | EC05 | Email không đáp ứng định dạng hợp lệ | Invalid | Như trên; ví dụ `user@domain.com` không phải grammar đầy đủ |
| REQ-02 | Email | EC06 | Email đúng định dạng nhưng đã được dùng | Invalid theo yêu cầu duy nhất | Như trên |
| REQ-03: tối thiểu 8 ký tự | Mật khẩu | EC07 | Độ dài từ 8 ký tự trở lên | Valid theo điều kiện độ dài | `README.md`, mục 2, FR-01, gạch đầu dòng 3 |
| REQ-03 | Mật khẩu | EC08 | Độ dài dưới 8 ký tự | Invalid theo điều kiện độ dài | Như trên |
| REQ-03: có chữ hoa | Mật khẩu | EC09 | Có ít nhất một chữ hoa | Valid theo điều kiện chữ hoa | Như trên |
| REQ-03 | Mật khẩu | EC10 | Không có chữ hoa | Invalid theo điều kiện chữ hoa | Như trên |
| REQ-03: có chữ thường | Mật khẩu | EC11 | Có ít nhất một chữ thường | Valid theo điều kiện chữ thường | Như trên |
| REQ-03 | Mật khẩu | EC12 | Không có chữ thường | Invalid theo điều kiện chữ thường | Như trên |
| REQ-03: có chữ số | Mật khẩu | EC13 | Có ít nhất một chữ số | Valid theo điều kiện chữ số | Như trên |
| REQ-03 | Mật khẩu | EC14 | Không có chữ số | Invalid theo điều kiện chữ số | Như trên |
| REQ-03: ký tự đặc biệt | Mật khẩu | EC15 | Có ít nhất một ký tự trong tập `@`, `$`, `!`, `%`, `*`, `?`, `&` | Valid theo điều kiện ký tự đặc biệt | Như trên |
| REQ-03 | Mật khẩu | EC16 | Không có ký tự nào thuộc tập đã nêu | Invalid theo điều kiện ký tự đặc biệt | Như trên |
| REQ-04: xác nhận khớp | Mật khẩu và xác nhận | EC17 | Hai giá trị khớp nhau | Valid | `README.md`, mục 2, FR-01, gạch đầu dòng 4 |
| REQ-04 | Mật khẩu và xác nhận | EC18 | Hai giá trị không khớp; trường xác nhận rỗng là một biến thể của lớp này | Invalid; SRS nói rõ hệ thống từ chối khi không khớp | Như trên |

**Phân vùng chưa xác định:** Chuỗi chỉ gồm khoảng trắng có được tính là “có cung cấp” họ tên/email hay không; các quy tắc hợp lệ chi tiết ngoài ví dụ email; các giới hạn trường và cách đếm Unicode chưa có căn cứ. Không gán các giá trị đó vào lớp Invalid. Phân tích hiện tại không tạo lớp riêng cho từng ký tự đặc biệt: REQ-03 quy định một tập cho điều kiện có ít nhất một ký tự thuộc tập; các giá trị riêng lẻ không phải biên số học.

## 4. Test case Domain Testing

**Bước chung:** Mở form đăng ký, nhập dữ liệu theo từng dòng và gửi đăng ký. Đối với test thành công, dùng email hợp lệ chưa tồn tại và email mới riêng cho mỗi lần chạy. Đối với test trùng email, chuẩn bị trước tài khoản có email đó. Các trường không nêu trong dữ liệu thay thế dùng bộ nền: họ tên `Nguyễn Văn An`, email hợp lệ chưa dùng, mật khẩu/xác nhận `Abcdef1!`. Mật khẩu nền dài 8 ký tự và chứa đủ các thành phần trong REQ-03.

| TC ID | Mục tiêu/lớp bao phủ | Tiền điều kiện | Dữ liệu (chỉ điều kiện đang thử thay đổi) | Expected result thiết kế | Căn cứ |
|---|---|---|---|---|---|
| TC01 | Valid: EC01, EC03, EC07, EC09, EC11, EC13, EC15, EC17 | Email mới, hợp lệ | Họ tên `Nguyễn Văn An`; email mới hợp lệ; mật khẩu/xác nhận `Abcdef1!` | Đăng ký thành công và chuyển tới trang Đăng nhập | REQ-01–REQ-05; `README.md`, mục 2, FR-01 |
| TC02 | Invalid: EC02 | Email mới, hợp lệ | Họ tên rỗng; các trường khác theo bộ nền | Không coi là đăng ký thành công với họ tên bắt buộc bị thiếu; hình thức từ chối/thông báo chưa được SRS quy định | REQ-01 |
| TC03 | Invalid: EC04 | Các trường khác theo bộ nền | Email rỗng | Không coi là đăng ký thành công khi thiếu email; hình thức từ chối/thông báo chưa được SRS quy định | REQ-01, REQ-02 |
| TC04 | Invalid: EC05 | Email không trùng; các trường khác theo bộ nền | Email `nguyen-at-example.com` | Không coi là đăng ký thành công với email không hợp lệ; quy tắc phản hồi cụ thể chưa được quy định | REQ-02 |
| TC05 | Invalid: EC06 | Đã có tài khoản dùng email kiểm thử | Email hợp lệ đã đăng ký; các trường khác theo bộ nền | Không coi là đăng ký thành công với email không duy nhất; thông báo cụ thể chưa được quy định | REQ-02 |
| TC06 | Invalid: EC08 | Email mới, hợp lệ | Mật khẩu/xác nhận `Ab1!` (4 ký tự; các thành phần còn lại có mặt) | Không coi là đăng ký thành công vì không đạt độ dài tối thiểu; phản hồi cụ thể chưa được quy định | REQ-03 |
| TC07 | Invalid: EC10 | Email mới, hợp lệ | Mật khẩu/xác nhận `abcdefg1!` (9 ký tự; không có chữ hoa) | Không coi là đăng ký thành công vì thiếu chữ hoa; phản hồi cụ thể chưa được quy định | REQ-03 |
| TC08 | Invalid: EC12 | Email mới, hợp lệ | Mật khẩu/xác nhận `ABCDEFG1!` (9 ký tự; không có chữ thường) | Không coi là đăng ký thành công vì thiếu chữ thường; phản hồi cụ thể chưa được quy định | REQ-03 |
| TC09 | Invalid: EC14 | Email mới, hợp lệ | Mật khẩu/xác nhận `Abcdefg!` (8 ký tự; không có chữ số) | Không coi là đăng ký thành công vì thiếu chữ số; phản hồi cụ thể chưa được quy định | REQ-03 |
| TC10 | Invalid: EC16 | Email mới, hợp lệ | Mật khẩu/xác nhận `Abcdefg1` (8 ký tự; không có ký tự trong tập được phép) | Không coi là đăng ký thành công vì thiếu ký tự đặc biệt thuộc tập; phản hồi cụ thể chưa được quy định | REQ-03 |
| TC11 | Biến thể dữ liệu cho Invalid EC18 | Email mới, hợp lệ | Mật khẩu `Abcdef1!`; xác nhận rỗng | Hệ thống từ chối vì xác nhận không khớp; nội dung thông báo chưa được quy định | REQ-04 |
| TC12 | Biến thể dữ liệu cho Invalid EC18 | Email mới, hợp lệ | Mật khẩu `Abcdef1!`; xác nhận `Abcdef2!` | Hệ thống từ chối vì hai trường không khớp; nội dung thông báo chưa được quy định | REQ-04 |

Các expected result là kết quả thiết kế, không phải actual result. Với REQ-01/02/03, yêu cầu nêu dữ liệu bắt buộc/tiêu chí hợp lệ nhưng không định nghĩa cụ thể thông báo hoặc giao thức thất bại; bảng chỉ yêu cầu dữ liệu vi phạm không được xem là đăng ký hợp lệ và không bịa response. REQ-04 nêu rõ từ chối khi không khớp.

## 5. Truy vết và độ bao phủ Domain Testing

| Yêu cầu | Lớp tương đương | Test case | Bao phủ/ghi chú |
|---|---|---|---|
| REQ-01 | EC01, EC02 | TC01, TC02 | Cả trường hợp cung cấp và thiếu họ tên |
| REQ-02 | EC03–EC06 | TC01, TC03–TC05 | Định dạng hợp lệ/chưa dùng; thiếu, sai định dạng, trùng |
| REQ-03 — độ dài | EC07, EC08 | TC01, TC06 | Thành phần mật khẩu hợp lệ được giữ cố định trong TC06 |
| REQ-03 — chữ hoa | EC09, EC10 | TC01, TC07 | Các điều kiện mật khẩu khác được giữ |
| REQ-03 — chữ thường | EC11, EC12 | TC01, TC08 | Các điều kiện mật khẩu khác được giữ |
| REQ-03 — chữ số | EC13, EC14 | TC01, TC09 | Các điều kiện mật khẩu khác được giữ |
| REQ-03 — ký tự đặc biệt | EC15, EC16 | TC01, TC10 | Tập ký tự lấy nguyên văn từ SRS |
| REQ-04 | EC17, EC18 | TC01, TC11, TC12 | Hai biến thể invalid cùng một lớp hành vi; TC11/TC12 không phải hai lớp độc lập theo yêu cầu hiện có |
| REQ-05 | Hành vi sau thành công | TC01 | Trang đích được kiểm tra trong ca hợp lệ |

Bao phủ thiết kế: tất cả 18 lớp hành vi trong bảng Domain Testing có ít nhất một test đại diện. Chưa bao phủ chi tiết các giá trị thuộc những phân vùng `Chưa xác định` vì SRS không định nghĩa ranh giới/grammar tương ứng; cần xác nhận nghiệp vụ trước khi thêm lớp hoặc expected result.

## 6. BVA độc lập

REQ-03 quy định rõ độ dài tối thiểu **8 ký tự**, nên có căn cứ thiết kế BVA cho biên dưới. Đơn vị lân cận là một ký tự; dữ liệu mẫu dùng ký tự ASCII để tránh phụ thuộc vào cách đếm Unicode chưa được quy định. Cố định họ tên có giá trị, email hợp lệ/chưa tồn tại riêng cho mỗi ca, các thành phần mật khẩu khác hợp lệ và xác nhận bằng mật khẩu.

| BVA ID | Yêu cầu/miền | Biên và vị trí | Giá trị | Dữ liệu/điều kiện giữ cố định | Expected result thiết kế | Căn cứ |
|---|---|---|---|---|---|---|
| BVA-FR01-01 | REQ-03, độ dài mật khẩu | Ngay dưới biên tối thiểu 8 | 7 ký tự: `Abcde1!` | Các trường khác hợp lệ; mật khẩu có chữ hoa, chữ thường, chữ số, ký tự thuộc tập; xác nhận trùng; email mới hợp lệ | Không đạt điều kiện độ dài nên không được chấp nhận là mật khẩu hợp lệ; response cụ thể chưa xác định | `README.md`, mục 2, FR-01, gạch đầu dòng 3 |
| BVA-FR01-02 | REQ-03, độ dài mật khẩu | Tại biên tối thiểu 8 | 8 ký tự: `Abcdef1!` | Như trên; xác nhận trùng | Đạt điều kiện độ dài. Nếu các điều kiện khác hợp lệ, đăng ký thành công và chuyển tới trang Đăng nhập | REQ-03, REQ-05 |
| BVA-FR01-03 | REQ-03, độ dài mật khẩu | Ngay trên biên tối thiểu 8 | 9 ký tự: `Abcdefg1!` | Như trên; xác nhận trùng | Đạt điều kiện độ dài. Nếu các điều kiện khác hợp lệ, đăng ký thành công và chuyển tới trang Đăng nhập | REQ-03, REQ-05 |

Không thiết kế BVA chính thức cho định dạng email, độ dài tên/email, thành phần mật khẩu riêng lẻ hay số lượng tài khoản: SRS không xác định biên số học/lân cận cho các miền đó. Các tiêu chí thành phần mật khẩu là điều kiện phân lớp, không phải biên độ dài.

## 7. Đối chiếu với tài liệu HW02 hiện có

### Điểm trùng/được SRS xác nhận

- `domain-testing.md` nhận diện đúng các biến họ tên, email, mật khẩu, xác nhận mật khẩu và các điều kiện bắt buộc, định dạng/duy nhất email, mật khẩu tối thiểu 8 ký tự/thành phần, xác nhận khớp. Các điều kiện này hiện đã có căn cứ trực tiếp tại `README.md`, mục 2, FR-01.
- Các test data như `Abcdef1!`, `Ab1!`, `abcdefg1!`, `ABCDEFG1!`, `Abcdefg!`, `Abcdefg1` cô lập lần lượt các điều kiện mật khẩu; những test này giữ các thành phần còn lại hợp lệ.
- `bva.md` chọn đúng biên dưới 8 ký tự và ba điểm 7/8/9. Các chuỗi mẫu tương ứng đáp ứng các thành phần mật khẩu khác, và dự kiến giữ các trường còn lại hợp lệ.
- Yêu cầu chuyển tới trang Đăng nhập sau thành công trong Domain Testing phù hợp với REQ-05.

### Thiếu, cần chỉnh nếu cập nhật tài liệu sau này

- Hai test plan chưa dẫn nguồn tới SRS. `domain-testing.md` ghi chú điều kiện cần đối chiếu với SRS; việc đối chiếu lượt này đã xác nhận các điều kiện cốt lõi tại `README.md` phiên bản 2.0.
- Các expected result dạng thông báo cụ thể như “họ và tên là trường bắt buộc”, “email đã được sử dụng” hoặc “hai mật khẩu không khớp” chưa được SRS quy định về nội dung câu chữ. Nên đổi thành từ chối/không hoàn tất đăng ký theo điều kiện vi phạm và ghi rõ thông báo/API response cụ thể là chưa xác định.
- `domain-testing.md` tách EC18 (xác nhận rỗng) và EC19 (xác nhận khác) thành hai lớp và dự kiến hai thông báo khác nhau. REQ-04 chỉ quy định từ chối khi hai trường không khớp, không quy định hai cách xử lý khác nhau; nên gộp thành một lớp hành vi không khớp. Có thể giữ TC11/TC12 như hai biến thể dữ liệu của cùng lớp, không coi là hai lớp độc lập.
- API specification mục 1.1 không có trường xác nhận mật khẩu trong body mẫu và không nói cách kiểm tra quy tắc FR-01 hoặc trả lỗi. Cần xác nhận test target là form UI hay API; không suy ra body API phải có trường xác nhận từ SRS UI/business requirement.
- `bva.md` có expected “từ chối” dưới biên và “chấp nhận về điều kiện độ dài” tại/trên biên; cách diễn đạt về riêng điều kiện độ dài là phù hợp. Nên thêm trích dẫn tới `README.md`, mục 2, FR-01 và làm rõ response thất bại cụ thể chưa được đặc tả.
- Bản cũ của [`agent-skills/demo/FR-01-domain-bva-analysis.md`](./FR-01-domain-bva-analysis.md) từng ghi rằng không tìm thấy SRS và điều kiện mật khẩu còn chờ xác nhận. Sau khi đối chiếu với `eshop-sut/README.md`, bản demo đã được cập nhật để dùng SRS làm nguồn yêu cầu; xem nội dung hiện hành trong file được liên kết.

## 8. Câu hỏi mở và kiểm tra chất lượng

1. Xác nhận phạm vi cần kiểm thử cho lần thực thi sau: giao diện đăng ký, `POST /api/register`, hay cả hai; API specification hiện không nêu trường xác nhận trong payload.
2. Xác nhận quy tắc định dạng email đầy đủ, so trùng email có phân biệt chữ hoa/thường không, và cách xử lý khoảng trắng.
3. Xác nhận giới hạn tên/email, cách đếm ký tự mật khẩu (đặc biệt Unicode), cùng response/message khi đầu vào vi phạm REQ-01/02/03.
4. Đã phân biệt lớp điều kiện với kết quả của toàn bộ đăng ký; lớp Invalid trong từng test được cô lập, trừ TC11/TC12 là hai biến thể của cùng điều kiện không khớp.
5. BVA chỉ dùng biên được SRS nêu rõ (8 ký tự); expected result là thiết kế, không phải thực thi.
6. Không đọc hoặc sửa execution results/evidence; không sửa các file Domain Testing/BVA cũ, source EShop hoặc database.
