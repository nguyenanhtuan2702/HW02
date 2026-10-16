# BÁO CÁO HW02 — DOMAIN TESTING VÀ BOUNDARY VALUE ANALYSIS

**Đối tượng:** Ứng dụng EShop
**Phạm vi:** FR-01 Registration, FR-09 Coupons, FR-17 Coupon Management và FR-11 Mobile Order History
**Ngày tổng hợp:** 17/10/2026

## Mục lục

- [1. Giới thiệu](#gioi-thieu)
- [2. Phương pháp kiểm thử](#phuong-phap-kiem-thu)
- [3. FR-01 — Registration](#fr-01)
- [4. FR-09 — Coupons](#fr-09)
- [5. FR-17 — Coupon Management](#fr-17)
- [6. FR-11 — Mobile Order History](#fr-11)
- [7. Tổng hợp kết quả kiểm thử](#tong-hop-ket-qua)
- [8. Bug Reporting](#bug-reporting)
- [9. AI Gap Analysis và Agent Skill](#ai-gap-analysis-va-agent-skill)
- [10. Kết luận](#ket-luan)
- [11. Tài liệu tham khảo và liên quan](#tai-lieu-tham-khao)

<a id="gioi-thieu"></a>
## 1. Giới thiệu

HW02 áp dụng Domain Testing và Boundary Value Analysis (BVA) để thiết kế, thực thi và đánh giá kiểm thử cho các chức năng đã chọn trong EShop. Mục tiêu là xác định các miền dữ liệu và điều kiện ảnh hưởng đến hành vi, chọn test case đại diện cho các lớp, tập trung kiểm tra những giá trị sát biên được quy định, rồi đối chiếu kết quả thực tế với yêu cầu và lưu bằng chứng.

Phạm vi gồm bốn feature:

| Feature | Chức năng | Nền tảng/phạm vi |
|---|---|---|
| FR-01 | Đăng ký tài khoản | Web/API |
| FR-09 | Áp dụng mã giảm giá | Checkout/API |
| FR-17 | Quản lý mã giảm giá | Web Admin/API; SRS quy định thêm, xem, xóa |
| FR-11 | Xem lịch sử đơn hàng | Ứng dụng Mobile |

Nguồn nghiệp vụ chính là SRS EShop, phiên bản 2.0, trong repository EShop tại `../eshop-sut/README.md`. API specification được dùng để hiểu ví dụ contract API, không thay thế yêu cầu SRS. **Lưu ý khi đóng gói ZIP:** liên kết tương đối sang repository EShop chỉ hoạt động nếu hai repository vẫn nằm cạnh nhau; cần bảo đảm người chấm có thể truy cập nguồn SRS, hoặc đổi sang URL repository công khai trước khi nộp.

Kết quả FR-01, FR-09 và FR-17 được ghi từ môi trường Windows, Node.js 24.15.0, Web `http://localhost:5173`, Admin `http://localhost:5174` và API `http://localhost:3000/api`; các lượt chạy chính có Run ID `20261016-155435`. FR-11 được kiểm thử thủ công trên Samsung Galaxy S21 FE 5G, Android qua Expo Go; phiên bản Android không được ghi lại. Một số test cần tài khoản hoặc fixture chưa có nên bị `BLOCKED`; hai test FR-01 chưa được tự động hóa do giao diện/API hiện có không hỗ trợ trường xác nhận mật khẩu.

## 2. Phương pháp kiểm thử

**Domain Testing** xác định các biến, điều kiện và miền đầu vào/đầu ra có thể làm thay đổi kết quả. Với mỗi điều kiện, Equivalence Partitioning chia miền thành các lớp tương đương `Valid` và `Invalid` có căn cứ yêu cầu. Test case đại diện được chọn để bao phủ lớp; với ca Invalid, các điều kiện còn lại được giữ hợp lệ để cô lập nguyên nhân.

**BVA** kiểm tra các giá trị ở ngay dưới, tại và ngay trên một giới hạn được đặc tả. Chỉ áp dụng BVA khi tài liệu nêu giới hạn và có thể xác định đơn vị/lân cận phù hợp. Những lớp rời rạc, như trạng thái đơn hàng, thuộc Domain Testing chứ không tự động là giá trị biên.

Với mỗi test case, kết quả thiết kế (expected result) được lưu riêng với kết quả thực tế (actual result), trạng thái và evidence. `PASS`/`FAIL` trong báo cáo phản ánh trạng thái đã ghi trong execution report; `BLOCKED` là không thực hiện được vì thiếu điều kiện/dữ liệu, `NOT AUTOMATED` là chưa tự động hóa, còn `N/A` là kỹ thuật không áp dụng theo biên hiện được đặc tả. Test case được thiết kế không đồng nghĩa với test đã chạy.

<a id="fr-01"></a>
## 3. FR-01 — Registration

### 3.1. Mô tả và căn cứ nghiệp vụ

FR-01 cho phép người dùng tạo tài khoản. SRS yêu cầu họ tên, email và mật khẩu; email phải hợp lệ và duy nhất; mật khẩu có ít nhất 8 ký tự, gồm chữ hoa, chữ thường, chữ số và ít nhất một ký tự trong tập `@`, `$`, `!`, `%`, `*`, `?`, `&`; biểu mẫu phải có trường xác nhận mật khẩu và từ chối nếu hai trường không khớp; đăng ký thành công chuyển người dùng tới trang Đăng nhập. SRS không định nghĩa đầy đủ grammar email, thông báo lỗi chính xác hoặc response thất bại của API.

API specification mục 1.1 nêu `POST /api/register`, body ví dụ `name`, `email`, `password` và response thành công mẫu `200 OK`. Tài liệu này không liệt kê trường xác nhận mật khẩu và không mô tả validation thất bại. Vì vậy, yêu cầu trường xác nhận trong SRS được áp dụng cho luồng đăng ký; không suy diễn rằng API phải nhận trường này nếu contract chưa xác nhận.

### 3.2. Domain Testing

**Biến và điều kiện:** input gồm họ tên, email, mật khẩu và xác nhận mật khẩu. Output gồm kết quả đăng ký, thông báo/response và trang đích sau đăng ký thành công. Các điều kiện: họ tên được cung cấp; email hợp lệ và duy nhất; mật khẩu đủ độ dài/thành phần; xác nhận mật khẩu khớp.

**Phân lớp tương đương theo test plan hiện có:**

| Điều kiện | Lớp Valid | Lớp Invalid |
|---|---|---|
| Họ tên | EC01: có giá trị | EC02: bỏ trống |
| Email | EC03: đúng định dạng, chưa dùng | EC04: bỏ trống; EC05: sai định dạng; EC06: đã tồn tại |
| Độ dài mật khẩu | EC07: từ 8 ký tự | EC08: dưới 8 ký tự |
| Chữ hoa | EC09: có ít nhất một chữ hoa | EC10: không có chữ hoa |
| Chữ thường | EC11: có ít nhất một chữ thường | EC12: không có chữ thường |
| Chữ số | EC13: có ít nhất một chữ số | EC14: không có chữ số |
| Ký tự đặc biệt | EC15: có ký tự thuộc tập SRS | EC16: không có ký tự thuộc tập SRS |
| Xác nhận mật khẩu | EC17: hai giá trị khớp | EC18: xác nhận trống; EC19: không khớp |

Tài liệu thiết kế hiện có ghi 19 lớp. Bản review FR-01 bằng Skill lưu ý rằng SRS chỉ quy định từ chối khi hai trường không khớp, không nói trường hợp trống và không khớp phải có hành vi khác nhau. Bản review xem EC18/EC19 là hai biến thể của cùng lớp hành vi; test case TC11/TC12 vẫn giữ như hai dữ liệu đại diện. Test plan gốc chưa được sửa.

**Test case đại diện:** dữ liệu nền hợp lệ dùng họ tên `Nguyễn Văn An`, email hợp lệ chưa dùng, mật khẩu `Abcdef1!` và xác nhận trùng khớp.

| TC | Dữ liệu/thay đổi chính | Lớp | Expected result trong test plan |
|---|---|---|---|
| TC01 | Dữ liệu nền hợp lệ | EC01, EC03, EC07, EC09, EC11, EC13, EC15, EC17 | Tạo tài khoản thành công và chuyển tới trang Đăng nhập |
| TC02 | Họ tên rỗng | EC02 | Từ chối và thông báo họ tên là trường bắt buộc |
| TC03 | Email rỗng | EC04 | Từ chối và thông báo email là trường bắt buộc |
| TC04 | Email `nguyen-at-example.com` | EC05 | Từ chối email sai định dạng |
| TC05 | Email hợp lệ đã dùng | EC06 | Từ chối và thông báo email đã được sử dụng |
| TC06 | Mật khẩu/xác nhận `Ab1!` | EC08 | Từ chối mật khẩu dưới 8 ký tự |
| TC07 | Mật khẩu/xác nhận `abcdefg1!` | EC10 | Từ chối vì thiếu chữ hoa |
| TC08 | Mật khẩu/xác nhận `ABCDEFG1!` | EC12 | Từ chối vì thiếu chữ thường |
| TC09 | Mật khẩu/xác nhận `Abcdefg!` | EC14 | Từ chối vì thiếu chữ số |
| TC10 | Mật khẩu/xác nhận `Abcdefg1` | EC16 | Từ chối vì thiếu ký tự đặc biệt được chấp nhận |
| TC11 | Xác nhận mật khẩu để trống | EC18 | Từ chối và thông báo trường xác nhận chưa được nhập |
| TC12 | `Abcdef1!` / `Abcdef2!` | EC19 | Từ chối và thông báo hai mật khẩu không khớp |

Test plan ánh xạ EC01–EC19 tới TC01–TC12. Các lớp Valid được kết hợp ở TC01; mỗi ca Invalid thay đổi một điều kiện mục tiêu. Những câu thông báo cụ thể trong expected result của test plan không được SRS quy định; cần xem đây là chi tiết của test plan, không phải nội dung bắt buộc theo SRS.

### 3.3. BVA

SRS quy định biên dưới là 8 ký tự. Test dùng ký tự ASCII, giữ các trường khác hợp lệ và xác nhận mật khẩu trùng khớp.

| BVA ID | Vị trí | Mật khẩu | Expected result |
|---|---|---|---|
| BVA-FR01-01 | Ngay dưới biên: 7 | `Abcde1!` | Từ chối do không đạt độ dài tối thiểu |
| BVA-FR01-02 | Tại biên: 8 | `Abcdef1!` | Đạt điều kiện độ dài; nếu các điều kiện khác hợp lệ, đăng ký thành công và chuyển tới trang Đăng nhập |
| BVA-FR01-03 | Ngay trên biên: 9 | `Abcdefg1!` | Đạt điều kiện độ dài; nếu các điều kiện khác hợp lệ, đăng ký thành công và chuyển tới trang Đăng nhập |

Không thiết kế BVA cho định dạng email, độ dài họ tên/email hoặc từng thành phần mật khẩu vì SRS không quy định các biên tương ứng.

### 3.4. Kết quả kiểm thử và evidence

Lượt chạy gốc `20261016-155435` có 13 ca đã thực thi: 3 `PASS`, 10 `FAIL`; TC11/TC12 là `NOT AUTOMATED`. Kết quả chi tiết nằm trong [execution report FR-01](./FR-01-registration/execution-results.md) và [evidence index](./evidence/evidence-index.md).

| TC | Actual result tóm tắt | Trạng thái gốc |
|---|---|---|
| TC01 | URL vẫn ở `/register`; báo `Mật khẩu quá yếu! Phải dài tối thiểu 8 ký tự, gồm chữ hoa, chữ thường, số và KÝ TỰ ĐẶC BIỆT.`; `confirmationFieldCount:0`, `accountCreated:false` | FAIL |
| TC02 | Native form chặn submit; `validationMessage:"Please fill out this field."` | PASS |
| TC03 | Native form chặn submit; `validationMessage:"Please fill out this field."` | PASS |
| TC04 | API `200`, `User registered successfully`, id 50 với email sai định dạng | FAIL |
| TC05 | API `200`, `User registered successfully`, id 51 với email đã tồn tại | FAIL |
| TC06 | API `200`, tạo id 52 với mật khẩu `Ab1!` | FAIL |
| TC07 | API `200`, tạo id 53 với mật khẩu `abcdefg1!` | FAIL |
| TC08 | API `200`, tạo id 54 với mật khẩu `ABCDEFG1!` | FAIL |
| TC09 | API `200`, tạo id 55 với mật khẩu `Abcdefg!` | FAIL |
| TC10 | API `200`, tạo id 56 với mật khẩu `Abcdefg1` | FAIL |
| TC11 | Chưa chạy: giao diện không có trường xác nhận; API không nhận/kiểm tra trường này | NOT AUTOMATED |
| TC12 | Chưa chạy: giao diện không có trường xác nhận; API không nhận/kiểm tra trường này | NOT AUTOMATED |
| BVA-FR01-01 | `accepted:false`, độ dài 7; giao diện hiển thị lỗi mật khẩu yếu | PASS |
| BVA-FR01-02 | `accepted:false`, độ dài 8; giao diện hiển thị lỗi mật khẩu yếu | FAIL |
| BVA-FR01-03 | `accepted:false`, độ dài 9; giao diện hiển thị lỗi mật khẩu yếu | FAIL |

TC02/TC03 được ghi `PASS` vì trình duyệt chặn submit, nhưng actual message tiếng Anh không trùng câu thông báo cụ thể trong expected của test plan. SRS không quy định chính xác thông báo; điểm này được nêu trong AI Gap Analysis để người review kiểm tra oracle, không tự đổi trạng thái lịch sử.

Lượt bổ sung `20261016-evidence-1623` chạy lại 3 ca giao diện (BVA-FR01-01, TC02, TC03); cả 3 ghi `PASS` và bổ sung screenshot. Đây là bằng chứng bổ sung, không thay trạng thái lượt gốc. TC11/TC12 vẫn `NOT AUTOMATED`. Các lỗi liên quan được ghi ở [BR-FR01-01](./bug-reports/BR-FR01-01.md) (UI từ chối mật khẩu hợp lệ), [BR-FR01-02](./bug-reports/BR-FR01-02.md) (thiếu trường xác nhận) và [BR-FR01-03](./bug-reports/BR-FR01-03.md) (API chấp nhận email/mật khẩu không hợp lệ). Screenshot TC01: [ảnh](./evidence/FR-01-registration/TC01/screenshots/20261016-155435-TC01-FAIL.png); screenshot BVA tại biên và trên biên: [BVA-FR01-02](./evidence/FR-01-registration/BVA-FR01-02/screenshots/20261016-155435-BVA-FR01-02-FAIL.png), [BVA-FR01-03](./evidence/FR-01-registration/BVA-FR01-03/screenshots/20261016-155435-BVA-FR01-03-FAIL.png).

<a id="fr-09"></a>
## 4. FR-09 — Coupons

### 4.1. Mô tả chức năng và căn cứ nghiệp vụ

Tại Checkout, mã giảm giá chỉ được áp dụng khi mã tồn tại và hoạt động, còn hạn, tổng đơn hàng đạt ngưỡng, người dùng có JWT hợp lệ và chưa dùng hết lượt. SRS quy định `total >= min_order_amount` và `used_count < max_uses_per_user`. Với `percent`, `discount_amount = total × discount_value / 100`; với `fixed`, `discount_amount = discount_value`; `final_amount = total - discount_amount`.

Các mã mẫu từ SRS và tài liệu thiết kế gồm `SAVE10` (percent 10%, ngưỡng 300.000 ₫, hạn 2099-12-31, 1 lần/người), `BIGBUY` (fixed 50.000 ₫, ngưỡng 500.000 ₫, hạn 2099-12-31, 1 lần/người), `VIP100` (fixed 100.000 ₫, ngưỡng 300.000 ₫, hạn 2099-12-31, 2 lần/người) và `EXPIRED` (percent 20%, ngưỡng 100.000 ₫, hạn 2020-01-01, 1 lần/người). Các trường hợp cần mã inactive hoặc tài khoản có số lần dùng cụ thể cần dữ liệu chuẩn bị trước.

SRS chưa xác định cách xử lý chữ hoa/thường, làm tròn, múi giờ/thời điểm hết hạn, giới hạn giảm tối đa hoặc thời điểm tiêu thụ lượt. Báo cáo không bổ sung các quy tắc đó.

### 4.2. Domain Testing

**Biến/điều kiện:** mã `code`, tổng tiền `total`, JWT, trạng thái `is_active`, `expired_at`, `min_order_amount`, loại `type`, `discount_value`, `used_count` và `max_uses_per_user`; output là trạng thái áp dụng, khoản giảm và số tiền cuối cùng.

| Điều kiện | Lớp Valid | Lớp Invalid |
|---|---|---|
| Tồn tại/hoạt động | EC01: tồn tại và `is_active=1` | EC02: không tồn tại; EC03: inactive |
| Hạn sử dụng | EC04: ngày hiện tại trước hạn | EC05: ngày hiện tại bằng/sau hạn |
| Ngưỡng đơn hàng | EC06: `total >= min_order_amount` | EC07: `total < min_order_amount` |
| Xác thực | EC08: JWT hợp lệ | EC09: không có token; EC10: token sai/hết hạn |
| Lượt dùng | EC11: `used_count < max_uses_per_user` | EC12: bằng/vượt giới hạn |
| Nhánh tính toán | EC13: `percent`; EC14: `fixed` | Không tạo lớp Invalid cho `type` trong FR-09; loại hợp lệ được quy định ở FR-17 |

Thiết kế xác định 14 lớp và 9 test case Domain Testing:

| TC | Dữ liệu/điều kiện chính | Lớp | Expected result |
|---|---|---|---|
| TC09-01 | `SAVE10`, total 500.000 ₫, JWT hợp lệ, chưa dùng | EC01, EC04, EC06, EC08, EC11, EC13 | Áp dụng; giảm 50.000 ₫; còn 450.000 ₫ |
| TC09-02 | `NO_SUCH_CODE`, điều kiện khác hợp lệ | EC02 | Từ chối vì mã không tồn tại |
| TC09-03 | Mã tồn tại nhưng `is_active=0` | EC03 | Từ chối vì mã không hoạt động |
| TC09-04 | `EXPIRED`, được xác nhận active; điều kiện khác hợp lệ | EC05 | Từ chối vì đã hết hạn |
| TC09-05 | `BIGBUY`, total 499.999 ₫ | EC07 | Từ chối vì dưới ngưỡng 500.000 ₫ |
| TC09-06 | `SAVE10`, không có JWT | EC09 | Từ chối do chưa đăng nhập |
| TC09-07 | `SAVE10`, JWT không hợp lệ/hết hạn | EC10 | Từ chối do xác thực không hợp lệ |
| TC09-08 | `SAVE10`, đã dùng 1 lần, giới hạn 1 | EC12 | Từ chối vì đã hết lượt |
| TC09-09 | `BIGBUY`, total đúng 500.000 ₫, JWT hợp lệ | EC01, EC04, EC06, EC08, EC11, EC14 | Áp dụng; giảm 50.000 ₫; còn 450.000 ₫ |

Tài liệu design ánh xạ cả 14 lớp vào các test trên. TC09-09 cũng kiểm tra nhánh fixed ở đúng ngưỡng; giá trị đúng ngưỡng lặp với BVA-FR09-02, giúp xác nhận cùng sai lệch nhưng không phải hai bug độc lập.

### 4.3. BVA

| BVA ID | Miền/biên | Giá trị | Expected result |
|---|---|---:|---|
| BVA-FR09-01 | Total ngay dưới ngưỡng `BIGBUY` 500.000 ₫ | 499.999 ₫ | Từ chối |
| BVA-FR09-02 | Total tại ngưỡng | 500.000 ₫ | Chấp nhận; giảm 50.000 ₫; còn 450.000 ₫ |
| BVA-FR09-03 | Total ngay trên ngưỡng | 500.001 ₫ | Chấp nhận; giảm 50.000 ₫; còn 450.001 ₫ |
| BVA-FR09-04 | Hạn trước `T0` | `T0 - 1 ngày` | Từ chối vì hết hạn |
| BVA-FR09-05 | Hạn tại `T0` | `T0` | Từ chối theo điều kiện ngày hiện tại phải trước hạn |
| BVA-FR09-06 | Hạn sau `T0` | `T0 + 1 ngày` | Chấp nhận điều kiện hạn sử dụng |
| BVA-FR09-07 | `VIP100`, max 2, ngay dưới giới hạn | used 1 | Chấp nhận nếu điều kiện khác hợp lệ |
| BVA-FR09-08 | Tại giới hạn | used 2 | Từ chối vì đã dùng hết lượt |
| BVA-FR09-09 | Vượt giới hạn | used 3 | Từ chối vì used không nhỏ hơn max |

Điều kiện khác được giữ hợp lệ: mã active, JWT hợp lệ, tổng đạt ngưỡng và chưa hết hạn (trừ test hạn dùng). Ngày trong SRS chưa có múi giờ/thời điểm trong ngày, nên tài liệu dùng `T0` theo ngày kiểm thử và ghi chú cần xác nhận nếu dữ liệu thực là timestamp.

### 4.4. Kết quả thực thi và evidence

Run gốc `20261016-155435`: 18 ca đã chạy, 13 `PASS`, 5 `FAIL`, không có `BLOCKED` hoặc `NOT AUTOMATED`. Bảng dưới đây tóm tắt actual result đã ghi; response đầy đủ ở [execution report FR-09](./FR-09-coupons/execution-results.md) và [evidence index](./evidence/evidence-index.md).

| TC | Actual result tóm tắt | Trạng thái gốc |
|---|---|---|
| TC09-01 | HTTP 200, `applied:true`, `discount_amount:-4500000`, `final_amount:5000000` | FAIL |
| TC09-02 | HTTP 404, `applied:false`, “Mã giảm giá không tồn tại hoặc đã bị vô hiệu hóa” | PASS |
| TC09-03 | HTTP 404, `applied:false`, “Mã giảm giá không tồn tại hoặc đã bị vô hiệu hóa” | PASS |
| TC09-04 | HTTP 400, từ chối do mã hết hạn | PASS |
| TC09-05 | HTTP 400, từ chối do total dưới 500.000 ₫ | PASS |
| TC09-06 | Không có `Authorization` trên request nhưng API trả `applied:true`, HTTP 200; response còn có lỗi tính giảm | FAIL |
| TC09-07 | JWT không hợp lệ nhưng API trả HTTP 200 và `success:true`; response còn có lỗi tính giảm | FAIL |
| TC09-08 | HTTP 400, từ chối vì đã dùng hết lượt | PASS |
| TC09-09 | Total đúng 500.000 ₫ bị từ chối HTTP 400 vì chưa đủ giá trị tối thiểu | FAIL |
| BVA-FR09-01 | 499.999 ₫ bị từ chối | PASS |
| BVA-FR09-02 | 500.000 ₫ bị từ chối với lỗi ngưỡng | FAIL |
| BVA-FR09-03 | 500.001 ₫ được áp dụng; giảm 50.000 ₫; còn 450.001 ₫ | PASS |
| BVA-FR09-04 | Hạn trước `T0` bị từ chối | PASS |
| BVA-FR09-05 | Hạn bằng `T0` bị từ chối | PASS |
| BVA-FR09-06 | Hạn sau `T0` được chấp nhận; actual ghi giảm 0 ₫, còn 500.000 ₫ | PASS |
| BVA-FR09-07 | used 1/max 2 được áp dụng; giảm 100.000 ₫, còn 400.000 ₫ | PASS |
| BVA-FR09-08 | used 2/max 2 bị từ chối | PASS |
| BVA-FR09-09 | used 3/max 2 bị từ chối | PASS |

Lượt bổ sung `20261016-evidence-1623` chạy lại 13 ca giao diện (TC09-02–05, TC09-08 và BVA-FR09-01, 03–09); tất cả được ghi `PASS` để bổ sung screenshot. Trạng thái run gốc giữ nguyên, gồm 5 `FAIL`. Các bug reports: [BR-FR09-01](./bug-reports/BR-FR09-01.md) (tính phần trăm); [BR-FR09-02](./bug-reports/BR-FR09-02.md) (request thiếu/sai JWT); [BR-FR09-03](./bug-reports/BR-FR09-03.md) (từ chối sai tại đúng ngưỡng). TC09-06 kết luận theo trace request không có `Authorization`, không theo riêng ảnh giao diện đang đăng nhập.

<a id="fr-17"></a>
## 5. FR-17 — Coupon Management

### 5.1. Mô tả chức năng và căn cứ nghiệp vụ

SRS FR-17 cho Admin thao tác thêm, xem và xóa mã giảm giá. Trường bắt buộc: `code` duy nhất; `type` là `percent` hoặc `fixed`; `discount_value > 0`; có `expired_at`; `min_order_amount >= 0`; `max_uses_per_user >= 1`. API Admin có thêm yêu cầu JWT hợp lệ và role Admin theo FR-12. SRS FR-17 không nêu thao tác sửa mã, nên phạm vi kiểm thử không bổ sung Update.

### 5.2. Domain Testing

**Biến:** `code`, `type`, `discount_value`, `expired_at`, `min_order_amount`, `max_uses_per_user`, thao tác và mã định danh bản ghi. Test plan xác định 16 lớp tương đương:

| Điều kiện | Lớp Valid | Lớp Invalid |
|---|---|---|
| `code` duy nhất | EC01: có giá trị, chưa tồn tại | EC02: thiếu/rỗng; EC03: đã tồn tại |
| `type` | EC04: `percent`; EC05: `fixed` | EC06: thiếu; EC07: ngoài tập cho phép |
| `discount_value` | EC08: lớn hơn 0 | EC09: bằng 0; EC10: âm |
| `expired_at` | EC11: được cung cấp | EC12: thiếu |
| `min_order_amount` | EC13: từ 0 trở lên | EC14: âm |
| `max_uses_per_user` | EC15: từ 1 trở lên | EC16: nhỏ hơn 1 |

Ngày hết hạn quá khứ không được xếp Invalid vì FR-17 chỉ yêu cầu trường này phải có giá trị, không quy định phải trong tương lai. Thiết kế gồm 13 ca Domain Testing:

| TC | Dữ liệu/thao tác | Lớp/phạm vi | Expected result |
|---|---|---|---|
| TC17-01 | Tạo code mới, `percent`, giá trị 10 | EC01, EC04, EC08, EC11, EC13, EC15 | Tạo thành công, xuất hiện trong danh sách |
| TC17-02 | Tạo code mới, `fixed`, giá trị 50.000 | EC01, EC05, EC08, EC11, EC13, EC15 | Tạo thành công, xuất hiện trong danh sách |
| TC17-03 | `code` rỗng, trường khác hợp lệ | EC02 | Từ chối tạo |
| TC17-04 | `code` trùng | EC03 | Từ chối tạo mã trùng |
| TC17-05 | Thiếu `type` | EC06 | Từ chối tạo |
| TC17-06 | `type=other` | EC07 | Từ chối loại không hỗ trợ |
| TC17-07 | `discount_value=0` | EC09 | Từ chối vì giá trị giảm phải dương |
| TC17-08 | `discount_value=-1` | EC10 | Từ chối vì giá trị giảm không dương |
| TC17-09 | Thiếu `expired_at` | EC12 | Từ chối tạo |
| TC17-10 | `min_order_amount=-1` | EC14 | Từ chối vì ngưỡng phải không âm |
| TC17-11 | `max_uses_per_user=0` | EC16 | Từ chối vì giới hạn phải từ 1 trở lên |
| TC17-12 | Mở danh sách mã | Xem | Danh sách hiển thị |
| TC17-13 | Xóa mã đã tạo | Xóa | Mã bị xóa và không còn trong danh sách |

Các mã hợp lệ mẫu trong test design là `TEST_PERCENT_01` (`percent`, 10, `2099-12-31`, min 0, max 1) và `TEST_FIXED_01` (`fixed`, 50000, `2099-12-31`, min 0, max 1). Ngày tương lai là dữ liệu thử, không phải giới hạn SRS.

### 5.3. BVA

| BVA ID | Miền/loại | Giá trị | Vị trí | Expected result |
|---|---|---:|---|---|
| BVA-FR17-01 | `discount_value`, percent | -1 | Dưới 0 | Từ chối |
| BVA-FR17-02 | `discount_value`, percent | 0 | Tại 0 | Từ chối; phải lớn hơn 0 |
| BVA-FR17-03 | `discount_value`, percent | 1 | Trên 0 | Chấp nhận điều kiện giá trị |
| BVA-FR17-04 | `discount_value`, fixed | -1 | Dưới 0 | Từ chối |
| BVA-FR17-05 | `discount_value`, fixed | 0 | Tại 0 | Từ chối; phải lớn hơn 0 |
| BVA-FR17-06 | `discount_value`, fixed | 1 | Trên 0 | Chấp nhận điều kiện giá trị |
| BVA-FR17-07 | `min_order_amount` | -1 | Dưới 0 | Từ chối |
| BVA-FR17-08 | `min_order_amount` | 0 | Tại 0 | Chấp nhận |
| BVA-FR17-09 | `min_order_amount` | 1 | Trên 0 | Chấp nhận |
| BVA-FR17-10 | `max_uses_per_user` | 0 | Dưới biên 1 | Từ chối |
| BVA-FR17-11 | `max_uses_per_user` | 1 | Tại 1 | Chấp nhận |
| BVA-FR17-12 | `max_uses_per_user` | 2 | Trên 1 | Chấp nhận |

Các test giữ code duy nhất và trường còn lại hợp lệ. Hai loại mã được kiểm tra riêng cho biên `discount_value`; SRS không xác định giới hạn trên nên không thêm BVA phía trên.

### 5.4. Kết quả thực thi và evidence

Run gốc `20261016-155435` có 25 test: 15 `PASS`, 10 `FAIL`, không có `BLOCKED` hoặc `NOT AUTOMATED`. Xem [execution report FR-17](./FR-17-coupon-management/execution-results.md) và [evidence index](./evidence/evidence-index.md).

| TC | Actual result tóm tắt | Trạng thái gốc |
|---|---|---|
| TC17-01 | HTTP 200, tạo coupon, hiển thị trong Admin table | PASS |
| TC17-02 | HTTP 200, tạo coupon, hiển thị trong Admin table | PASS |
| TC17-03 | Native form chặn submit; `requestSent:false` | PASS |
| TC17-04 | HTTP 500, `SQLITE_CONSTRAINT: UNIQUE constraint failed: coupons.code`; không tạo mã trùng | PASS |
| TC17-05 | API HTTP 200 tạo coupon dù thiếu `type` | FAIL |
| TC17-06 | API HTTP 200 tạo coupon với `type=other` | FAIL |
| TC17-07 | API HTTP 200 tạo coupon với `discount_value=0` | FAIL |
| TC17-08 | API HTTP 200 tạo coupon với `discount_value=-1` | FAIL |
| TC17-09 | Native form chặn submit; `requestSent:false` | PASS |
| TC17-10 | API HTTP 200 tạo coupon với `min_order_amount=-1` | FAIL |
| TC17-11 | Native form chặn submit; `requestSent:false` | PASS |
| TC17-12 | Mã kiểm thử xuất hiện trong danh sách Admin | PASS |
| TC17-13 | Xóa trả HTTP 200; `stillListed:false` | PASS |
| BVA-FR17-01 | API tạo coupon với `discount_value=-1`, percent | FAIL |
| BVA-FR17-02 | API tạo coupon với `discount_value=0`, percent | FAIL |
| BVA-FR17-03 | `discount_value=1`, percent được tạo | PASS |
| BVA-FR17-04 | API tạo coupon với `discount_value=-1`, fixed | FAIL |
| BVA-FR17-05 | API tạo coupon với `discount_value=0`, fixed | FAIL |
| BVA-FR17-06 | `discount_value=1`, fixed | PASS |
| BVA-FR17-07 | API tạo coupon với `min_order_amount=-1` | FAIL |
| BVA-FR17-08 | `min_order_amount=0` được tạo | PASS |
| BVA-FR17-09 | `min_order_amount=1` được tạo | PASS |
| BVA-FR17-10 | Native form chặn `max_uses_per_user=0`; không gửi API request | PASS |
| BVA-FR17-11 | `max_uses_per_user=1` được tạo | PASS |
| BVA-FR17-12 | `max_uses_per_user=2` được tạo | PASS |

Các ca `PASS` do native form chặn (`TC17-03`, `TC17-09`, `TC17-11`, `BVA-FR17-10`) chỉ chứng minh validation ở UI; chúng không chứng minh API trực tiếp từ chối các dữ liệu đó. TC17-04 được ghi `PASS` vì mã trùng không được tạo, dù actual là HTTP 500; SRS không nêu status lỗi cụ thể. Lượt bổ sung `20261016-evidence-1623` chạy lại 15 ca giao diện để bổ sung screenshot; cả 15 ghi `PASS`, không thay trạng thái gốc. Bug reports: [BR-FR17-01](./bug-reports/BR-FR17-01.md) về `type`; [BR-FR17-02](./bug-reports/BR-FR17-02.md) về giá trị giảm không dương; [BR-FR17-03](./bug-reports/BR-FR17-03.md) về ngưỡng đơn hàng âm.

<a id="fr-11"></a>
## 6. FR-11 — Mobile Order History

### 6.1. Mô tả và căn cứ nghiệp vụ

FR-11 yêu cầu người dùng chỉ xem đơn hàng của chính mình; mỗi đơn hiển thị mã đơn, ngày đặt, tổng tiền và trạng thái hiện tại. Trạng thái phải được dịch sang tiếng Việt rõ ràng và phân biệt bằng màu sắc. FR-10 xác định năm trạng thái: `pending`, `confirmed`, `shipping`, `delivered`, `canceled`.

### 6.2. Domain Testing

**Biến:** người dùng hiện tại, tập đơn hàng, trạng thái mỗi đơn và các trường hiển thị. Test plan xác định 19 lớp:

| Điều kiện | Lớp Valid | Lớp Invalid/ngoài phạm vi |
|---|---|---|
| Chủ sở hữu | EC01: đơn thuộc người dùng hiện tại | EC02: đơn người khác xuất hiện |
| Số lượng đơn | EC03: 0 đơn; EC04: 1 đơn; EC05: từ 2 đơn | Không có Invalid theo số lượng; SRS không quy định min/max |
| Trạng thái | EC06: pending; EC07: confirmed; EC08: shipping; EC09: delivered; EC10: canceled | Trạng thái khác năm giá trị nằm ngoài đặc tả; chưa có expected result |
| Thông tin đơn | EC11: đủ mã/ngày/tổng/trạng thái | EC12: thiếu mã; EC13: thiếu ngày; EC14: thiếu tổng; EC15: thiếu trạng thái |
| Dịch nhãn | EC16: tiếng Việt rõ | EC17: không dịch/không rõ |
| Màu sắc | EC18: trạng thái được phân biệt bằng màu | EC19: màu không phân biệt |

Test plan có 10 test case đại diện:

| TC | Mục tiêu/lớp | Expected result |
|---|---|---|
| TC01 | Một đơn hợp lệ của người dùng; pending; EC01, EC04, EC06, EC11, EC16, EC18 | Hiển thị đúng đơn và đủ trường; trạng thái tiếng Việt, phân biệt màu |
| TC02 | Không có đơn; EC03 | Không hiển thị đơn của người khác; empty-state cụ thể chưa được SRS quy định |
| TC03 | Nhiều đơn với các trạng thái còn lại; EC01, EC05, EC07–EC10, EC11, EC16, EC18 | Hiển thị các đơn của người dùng, đủ trường, nhãn tiếng Việt và màu phân biệt |
| TC04 | Có đơn User A và B, A đang xem; EC02 | A chỉ thấy đơn của A |
| TC05 | Thiếu mã đơn; EC12 | Kết quả phải có mã đơn; nếu không tạo được fixture thì Blocked |
| TC06 | Thiếu ngày đặt; EC13 | Kết quả phải có ngày đặt; nếu không tạo được fixture thì Blocked |
| TC07 | Thiếu tổng tiền; EC14 | Kết quả phải có tổng tiền; nếu không tạo được fixture thì Blocked |
| TC08 | Thiếu trạng thái; EC15 | Kết quả phải có trạng thái; nếu không tạo được fixture thì Blocked |
| TC09 | Nhãn trạng thái không dịch rõ; EC17 | Giá trị kỹ thuật/nhãn không rõ không đáp ứng FR-11 |
| TC10 | Không phân biệt màu; EC19 | Các trạng thái phải phân biệt bằng màu; không áp đặt mã màu cụ thể |

### 6.3. BVA

BVA là `N/A` theo SRS hiện tại. FR-11 không quy định biên số học, độ dài hợp lệ hay giới hạn số lượng đơn hàng; các trạng thái là tập rời rạc. Do đó 0/1/nhiều đơn thuộc Domain Testing, không phải các giá trị dưới/tại/trên biên. Xem [BVA FR-11](./mobile-FR-11/bva.md).

### 6.4. Kết quả kiểm thử thủ công

Execution ID `FR11-MANUAL-16/10/26-01`, ngày 16/10/2026 lúc 19:25, trên Samsung Galaxy S21 FE 5G, Android qua Expo Go. Tài liệu ghi nhận 10 test: 5 đã thực hiện, 3 `PASS`, 2 `FAIL`, 5 `BLOCKED`.

| TC | Actual result | Trạng thái | Evidence |
|---|---|---|---|
| TC01 | Kết quả ghi nhận đáp ứng expected | PASS | [ev1.jpg](./evidence/FR-11-mobile/TC01/ev1.jpg) |
| TC02 | Không có đơn của người khác; expected được đáp ứng | PASS | [ev2.jpg](./evidence/FR-11-mobile/TC02/ev2.jpg) |
| TC03 | Nhiều đơn được hiển thị nhưng trạng thái không có màu phân biệt | FAIL | [ev3_9_10.jpg](./evidence/FR-11-mobile/TC03/ev3_9_10.jpg) |
| TC04 | Chưa thực hiện: chỉ có một tài khoản User test dùng được; FR-01 cản trở tạo User B | BLOCKED | Chưa có evidence thực thi |
| TC05 | Chưa thực hiện: cần fixture thiếu mã đơn; tester không tự sửa dữ liệu | BLOCKED | Chưa có evidence thực thi |
| TC06 | Chưa thực hiện: cần fixture thiếu ngày đặt; tester không tự sửa dữ liệu | BLOCKED | Chưa có evidence thực thi |
| TC07 | Chưa thực hiện: cần fixture thiếu tổng tiền; tester không tự sửa dữ liệu | BLOCKED | Chưa có evidence thực thi |
| TC08 | Chưa thực hiện: cần fixture thiếu trạng thái; tester không tự sửa dữ liệu | BLOCKED | Chưa có evidence thực thi |
| TC09 | Nhãn trạng thái được ghi nhận là tiếng Việt rõ ràng | PASS | [ev3_9_10.jpg](./evidence/FR-11-mobile/TC09/ev3_9_10.jpg) |
| TC10 | Trạng thái không có màu sắc để phân biệt | FAIL | [ev3_9_10.jpg](./evidence/FR-11-mobile/TC10/ev3_9_10.jpg) |

TC03 và TC10 cùng phản ánh lỗi hiển thị màu trạng thái và dùng cùng ảnh; chúng không được đếm thành hai bug. TC04–TC08 vẫn `BLOCKED`, không phải lỗi đã xác minh. Báo cáo lỗi: [BR-FR11-01](./bug-reports/BR-FR11-01.md); bản ghi đầy đủ: [FR-11 manual execution](./mobile-FR-11/FR-11-manual-execution-results.md).

<a id="tong-hop-ket-qua"></a>
## 7. Tổng hợp kết quả kiểm thử

Các tổng dưới đây đếm từng test case thiết kế một lần, lấy trạng thái gốc từ execution report. `N/A` BVA của FR-11 không phải test case và không nằm trong thống kê.

| Feature | Test Domain | Test BVA | Tổng thiết kế | Có kết quả run gốc (PASS/FAIL) | PASS | FAIL | BLOCKED | NOT AUTOMATED | Ghi chú |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---|
| FR-01 | 12 | 3 | 15 | 13 | 3 | 10 | 0 | 2 | TC11–TC12 chưa tự động hóa |
| FR-09 | 9 | 9 | 18 | 18 | 13 | 5 | 0 | 0 | Không có ca bị chặn |
| FR-17 | 13 | 12 | 25 | 25 | 15 | 10 | 0 | 0 | Một số PASS chỉ là validation UI |
| FR-11 | 10 | 0 | 10 | 5 | 3 | 2 | 5 | 0 | BVA N/A; TC04–TC08 thiếu dữ liệu/fixture |
| **Tổng** | **44** | **24** | **68** | **61** | **34** | **27** | **5** | **2** | **Không có ca NOT RUN trong bộ test đã thiết kế** |

Trong lần bổ sung `20261016-evidence-1623`, 31 ca giao diện đã được chạy lại để bổ sung screenshot: FR-01 có 3, FR-09 có 13, FR-17 có 15; cả 31 được ghi `PASS`. Các ca này trùng với test case đã có trong run gốc, nên không cộng thêm vào 68 test case hoặc dùng để thay trạng thái lịch sử. Test API-only dùng JSON/trace; TC11/TC12 FR-01 vẫn chưa tự động hóa. Chi tiết ảnh theo từng execution ở [evidence index](./evidence/evidence-index.md) và các [execution reports FR-01](./FR-01-registration/execution-results.md), [FR-09](./FR-09-coupons/execution-results.md), [FR-17](./FR-17-coupon-management/execution-results.md).

<a id="bug-reporting"></a>
## 8. Bug Reporting

Bug reports local nhóm các sai lệch đã xác minh theo nguyên nhân. Không có thang severity trong tài liệu dự án nên mức độ nghiêm trọng đều ghi “chưa đánh giá”. Báo cáo chưa được đăng thành GitHub Issues.

| Bug ID | Feature | Test liên quan | Vấn đề đã ghi nhận |
|---|---|---|---|
| [BR-FR01-01](./bug-reports/BR-FR01-01.md) | FR-01 | TC01, BVA-FR01-02, BVA-FR01-03 | UI từ chối mật khẩu 8/9 ký tự đáp ứng điều kiện SRS |
| [BR-FR01-02](./bug-reports/BR-FR01-02.md) | FR-01 | TC01; TC11/TC12 chưa tự động hóa | Form thiếu trường xác nhận mật khẩu |
| [BR-FR01-03](./bug-reports/BR-FR01-03.md) | FR-01 | TC04–TC10 | API chấp nhận email/mật khẩu vi phạm điều kiện FR-01 |
| [BR-FR09-01](./bug-reports/BR-FR09-01.md) | FR-09 | TC09-01 | Phép tính phần trăm cho khoản giảm và tổng cuối sai |
| [BR-FR09-02](./bug-reports/BR-FR09-02.md) | FR-09 | TC09-06, TC09-07 | API chấp nhận yêu cầu thiếu JWT hoặc JWT không hợp lệ |
| [BR-FR09-03](./bug-reports/BR-FR09-03.md) | FR-09 | TC09-09, BVA-FR09-02 | Từ chối đơn bằng đúng ngưỡng tối thiểu |
| [BR-FR17-01](./bug-reports/BR-FR17-01.md) | FR-17 | TC17-05, TC17-06 | API chấp nhận thiếu `type` hoặc `type` ngoài tập cho phép |
| [BR-FR17-02](./bug-reports/BR-FR17-02.md) | FR-17 | TC17-07/08, BVA-FR17-01/02/04/05 | API chấp nhận `discount_value` bằng 0 hoặc âm |
| [BR-FR17-03](./bug-reports/BR-FR17-03.md) | FR-17 | TC17-10, BVA-FR17-07 | API chấp nhận `min_order_amount` âm |
| [BR-FR11-01](./bug-reports/BR-FR11-01.md) | FR-11 | TC03, TC10 | Trạng thái đơn hàng không được phân biệt bằng màu sắc |

Tổng cộng có 10 bug reports đã xác minh, liên kết với 27 test case FAIL duy nhất; TC01 của FR-01 có thể liên quan đến hai lỗi khác nhau. Có 7 ca cần kiểm thử/xác minh thêm: FR-01 TC11/TC12 `NOT AUTOMATED` và FR-11 TC04–TC08 `BLOCKED`. Không tạo bug từ các ca đó. Danh sách và giới hạn evidence được ghi tại [bug-reports/README.md](./bug-reports/README.md).

<a id="ai-gap-analysis-va-agent-skill"></a>
## 9. AI Gap Analysis và Agent Skill

[`ai-gap-analysis.md`](./ai-gap-analysis.md) ghi 12 phát hiện, trong đó có: expected message FR-01 vượt quá điều SRS quy định; EC xác nhận mật khẩu rỗng/không khớp cần xem như biến thể nếu không có yêu cầu phân biệt; phân biệt lỗi ứng dụng với giới hạn API/UI; test FR-17 bị native form chặn chưa xác minh API; và các ca FR-11 bị chặn do thiếu dữ liệu. Tài liệu cũng nêu TC09-09 và BVA-FR09-02 cùng phát hiện lỗi đúng ngưỡng và nên gắn với một bug.

Nhật ký AI có bản tóm tắt cho quá trình thiết kế FR-01 và FR-09. Không có prompt/output ban đầu đủ để quy nội dung thiết kế hiện tại FR-17/FR-11 cho AI. Vì vậy, báo cáo đánh giá trạng thái kiểm thử của các feature đó nhưng không khẳng định AI đã tạo hoặc bỏ sót những nội dung cụ thể.

Skill [`eshop-domain-bva-testing`](./.github/skills/eshop-domain-bva-testing/SKILL.md) hướng dẫn phân tích yêu cầu có truy vết, tạo lớp tương đương và test đại diện, tách BVA, không tự thêm giới hạn, và ghi rõ điểm chưa xác định. Tài liệu hỗ trợ nằm trong [`agent-skills/README.md`](./agent-skills/README.md) và [`agent-skills/demo-plan.md`](./agent-skills/demo-plan.md). Theo [`FR-01-skill-validation.md`](./agent-skills/demo/FR-01-skill-validation.md), Skill được gọi trong một lượt review FR-01. Đầu ra [`FR-01-domain-bva-analysis.md`](./agent-skills/demo/FR-01-domain-bva-analysis.md) là phân tích thiết kế mới, không phải execution result; nó đối chiếu SRS, làm rõ giới hạn API và hợp nhất lớp xác nhận không khớp. Không tìm thấy video demo hoặc liên kết video trong workspace nên báo cáo không khẳng định đã có video.

AI Critique được ghi tại [`ai-critique.md`](./ai-critique.md); tài liệu nêu các điểm hữu ích, hạn chế, phần con người đã review và cách cải thiện việc lưu prompt, xác định bề mặt kiểm thử, kiểm tra oracle và evidence.

<a id="ket-luan"></a>
## 10. Kết luận

Bốn feature có 68 test case được thiết kế, gồm 44 ca Domain Testing và 24 ca BVA. Trong run gốc của FR-01/09/17 và lần kiểm thử thủ công FR-11, có **61 test case có kết quả thực thi `PASS` hoặc `FAIL`**: 34 `PASS` và 27 `FAIL`. Ngoài ra, 5 ca FR-11 ở trạng thái `BLOCKED` và 2 ca FR-01 ở trạng thái `NOT AUTOMATED`; các ca này không nằm trong 61 ca đã có kết quả PASS/FAIL. Tổng cộng bộ test có 68 test case được thiết kế. BVA FR-11 là `N/A`, không tính như một test case đã thực thi.

Execution ghi nhận các lỗi đáng chú ý: UI/API đăng ký chưa đáp ứng một số điều kiện FR-01; API áp dụng coupon sai phép tính phần trăm, bỏ qua xác thực JWT và xử lý sai ngưỡng tối thiểu FR-09; API quản lý coupon chấp nhận một số dữ liệu trái FR-17; Mobile chưa dùng màu để phân biệt trạng thái đơn hàng. Các lỗi được lập thành 10 bug reports theo nhóm nguyên nhân, không đếm mỗi lần FAIL là một bug độc lập.

Evidence giúp xác minh actual result và gắn các test case với execution tương ứng. Lượt chạy bổ sung chỉ phục vụ screenshot, không thay trạng thái run gốc. AI hỗ trợ cấu trúc phân tích và tổng hợp, nhưng các giới hạn của SRS, khác biệt giữa UI/API, trạng thái bị chặn và độ chính xác của expected result cần được con người kiểm tra trước khi kết luận.

<a id="tai-lieu-tham-khao"></a>
## 11. Tài liệu tham khảo và tài liệu liên quan

1. [SRS EShop — README, phiên bản 2.0](../eshop-sut/README.md), bao gồm FR-01, FR-09, FR-10/FR-11, FR-12 và FR-17.
2. [API Specification EShop](../eshop-sut/api_specification.md).
3. Domain Testing và BVA: [FR-01](./FR-01-registration/domain-testing.md), [BVA FR-01](./FR-01-registration/bva.md); [FR-09](./FR-09-coupons/domain-testing.md), [BVA FR-09](./FR-09-coupons/bva.md); [FR-17](./FR-17-coupon-management/domain-testing.md), [BVA FR-17](./FR-17-coupon-management/bva.md); [FR-11](./mobile-FR-11/domain-testing.md), [BVA FR-11](./mobile-FR-11/bva.md).
4. Kết quả: [FR-01](./FR-01-registration/execution-results.md), [FR-09](./FR-09-coupons/execution-results.md), [FR-17](./FR-17-coupon-management/execution-results.md), [FR-11 manual](./mobile-FR-11/FR-11-manual-execution-results.md); [evidence index](./evidence/evidence-index.md).
5. Bug reports: [README/index](./bug-reports/README.md) và 10 báo cáo `BR-*` liên kết tại [mục 8](#bug-reporting).
6. AI artifacts: [AI Audit](./ai-audit.md), [AI Critique](./ai-critique.md), [AI Gap Analysis](./ai-gap-analysis.md), [Agent Skill](./.github/skills/eshop-domain-bva-testing/SKILL.md), [hướng dẫn Skill](./agent-skills/README.md), [kịch bản demo](./agent-skills/demo-plan.md), [FR-01 Skill validation](./agent-skills/demo/FR-01-skill-validation.md) và [FR-01 design demo](./agent-skills/demo/FR-01-domain-bva-analysis.md).
