# FR-11 — Xem lịch sử đơn hàng (User): Kết quả kiểm thử thủ công

## 1. Thông tin lần kiểm thử

- **Feature:** FR-11 — Xem lịch sử đơn hàng (User)
- **Test method:** Manual testing trên điện thoại thật
- **Execution ID:** `FR11-MANUAL-16/10/26-01`
- **Ngày/giờ kiểm thử:** `16/10/2026 19:25`
- **Người kiểm thử:** `Nguyễn Anh Tuấn-23120184`
- **Thiết bị:** `Samsung Galaxy S21 FE 5G`
- **Hệ điều hành:** `Android` (chưa ghi nhận phiên bản cụ thể)
- **Ứng dụng:** `Expo Go`
- **Evidence root:** `evidence/FR-11-mobile/`

> Kết quả dưới đây được ghi theo thông tin kiểm thử đã cung cấp. Cột Evidence chỉ liên kết tới screenshot thực tế đã lưu trong repo.

## 2. Kết quả kiểm thử Domain Testing

| Test Case ID | Test Description | Expected Result | Actual Result | Status | Evidence |
|---|---|---|---|---|---|
| TC01 | Xem lịch sử có một đơn hàng hợp lệ | Hiển thị đơn hàng của người dùng hiện tại với mã đơn, ngày đặt, tổng tiền và trạng thái. Trạng thái được diễn đạt rõ bằng tiếng Việt và phân biệt bằng màu sắc. | Kiểm thử thực tế đáp ứng kết quả mong đợi theo ghi nhận của người kiểm thử. | **PASS** | [ev1.jpg](../evidence/FR-11-mobile/TC01/ev1.jpg) |
| TC02 | Xem lịch sử khi người dùng chưa có đơn hàng | Không hiển thị đơn hàng của người dùng khác. Đặc tả chưa quy định nội dung/bố cục cụ thể của empty state. | Kiểm thử thực tế đáp ứng kết quả mong đợi theo ghi nhận của người kiểm thử. | **PASS** | [ev2.jpg](../evidence/FR-11-mobile/TC02/ev2.jpg) |
| TC03 | Xem nhiều đơn hàng với các trạng thái khác nhau | Các đơn hàng của người dùng hiện tại được hiển thị; mỗi đơn có mã đơn, ngày đặt, tổng tiền và trạng thái. Trạng thái được diễn đạt bằng tiếng Việt và phân biệt bằng màu sắc. | Danh sách nhiều đơn hàng được kiểm tra, nhưng các trạng thái không có màu sắc để phân biệt. | **FAIL** | [ev3_9_10.jpg](../evidence/FR-11-mobile/TC03/ev3_9_10.jpg) |
| TC04 | Không hiển thị đơn hàng của người dùng khác | Lịch sử của User A chỉ hiển thị các đơn thuộc A, không hiển thị đơn thuộc User B. | Chưa thể thực hiện vì hiện chỉ có một tài khoản User test sử dụng được; chưa có User B và đơn hàng đối chứng. Chức năng đăng ký FR-01 đang gặp lỗi nên chưa tạo được tài khoản thứ hai. | **BLOCKED** | Chưa có screenshot FR-11 vì test chưa thực hiện. Có thể tham chiếu evidence lỗi đăng ký của FR-01 nếu đã lưu. |
| TC05 | Kết quả hiển thị thiếu mã đơn | Mã đơn là thông tin bắt buộc theo FR-11. | Không thực hiện vì cần tạo hoặc thay đổi dữ liệu để tái tạo trường hợp thiếu mã đơn; người kiểm thử không tự sửa dữ liệu. | **BLOCKED** | Chưa có evidence thực thi FR-11; không thay đổi dữ liệu để tạo tình huống này. |
| TC06 | Kết quả hiển thị thiếu ngày đặt | Ngày đặt là thông tin bắt buộc theo FR-11. | Không thực hiện vì cần tạo hoặc thay đổi dữ liệu để tái tạo trường hợp thiếu ngày đặt; người kiểm thử không tự sửa dữ liệu. | **BLOCKED** | Chưa có evidence thực thi FR-11; không thay đổi dữ liệu để tạo tình huống này. |
| TC07 | Kết quả hiển thị thiếu tổng tiền | Tổng tiền là thông tin bắt buộc theo FR-11. | Không thực hiện vì cần tạo hoặc thay đổi dữ liệu để tái tạo trường hợp thiếu tổng tiền; người kiểm thử không tự sửa dữ liệu. | **BLOCKED** | Chưa có evidence thực thi FR-11; không thay đổi dữ liệu để tạo tình huống này. |
| TC08 | Kết quả hiển thị thiếu trạng thái hiện tại | Trạng thái hiện tại là thông tin bắt buộc theo FR-11. | Không thực hiện vì cần tạo hoặc thay đổi dữ liệu để tái tạo trường hợp thiếu trạng thái; người kiểm thử không tự sửa dữ liệu. | **BLOCKED** | Chưa có evidence thực thi FR-11; không thay đổi dữ liệu để tạo tình huống này. |
| TC09 | Trạng thái không được dịch sang tiếng Việt rõ ràng | Trạng thái được diễn đạt rõ bằng tiếng Việt; nếu hiển thị mã kỹ thuật hoặc nhãn không rõ nghĩa thì không đáp ứng yêu cầu. | Các nhãn trạng thái được hiển thị bằng tiếng Việt rõ ràng theo ghi nhận của người kiểm thử. | **PASS** | [ev3_9_10.jpg](../evidence/FR-11-mobile/TC09/ev3_9_10.jpg) |
| TC10 | Trạng thái không được phân biệt bằng màu sắc | Các trạng thái được phân biệt bằng màu sắc. FR-11 không quy định màu cụ thể cho từng trạng thái. | Không có màu sắc để phân biệt các trạng thái đơn hàng. | **FAIL** | [ev3_9_10.jpg](../evidence/FR-11-mobile/TC10/ev3_9_10.jpg) |

### Quy ước Status

- `PASS`: Đã thực hiện và actual result đáp ứng expected result.
- `FAIL`: Đã thực hiện và actual result không đáp ứng expected result.
- `BLOCKED`: Không thể thực hiện do thiếu dữ liệu hoặc điều kiện cần thiết; ghi rõ lý do.
- `NOT RUN`: Chưa thực hiện và chưa xác định có bị chặn hay không.

## 3. Tổng kết lần kiểm thử

- **Tổng số test case Domain Testing:** 10
- **Đã thực hiện:** 5 (TC01, TC02, TC03, TC09, TC10)
- **PASS:** 3 (TC01, TC02, TC09)
- **FAIL:** 2 (TC03, TC10)
- **BLOCKED:** 5 (TC04, TC05, TC06, TC07, TC08)
- **NOT RUN:** 0
- **Test case đã có screenshot evidence:** 5/5 test case đã thực hiện (TC01, TC02, TC03, TC09, TC10). TC03, TC09 và TC10 liên kết tới cùng một ảnh đã lưu trong từng thư mục test case.
- **Vấn đề ứng dụng quan sát được:** Trạng thái đơn hàng không được phân biệt bằng màu sắc (được ghi nhận ở TC03 và TC10). Đây có thể là một vấn đề chung, không nên đếm trùng thành hai bug nếu cùng một nguyên nhân.

## 4. Lỗi/điểm không đáp ứng được phát hiện

| Test Case ID | Mô tả sai khác | Đề xuất ghi nhận bug | Evidence |
|---|---|---|---|
| TC03, TC10 | Trạng thái đơn hàng không có màu sắc phân biệt như yêu cầu FR-11. | Ghi nhận một bug cho vấn đề hiển thị màu trạng thái; thêm Bug ID sau khi lập bug report/issue. | [TC03 screenshot](../evidence/FR-11-mobile/TC03/ev3_9_10.jpg); [TC10 screenshot](../evidence/FR-11-mobile/TC10/ev3_9_10.jpg) |

## 5. BVA — Boundary Value Analysis

**Kết luận theo đặc tả hiện tại:** Chưa có test case BVA chính thức để thực thi. FR-11 không quy định biên số học, độ dài hợp lệ hoặc giới hạn số lượng đơn hàng; do đó không tự đặt các giá trị dưới biên/tại biên/trên biên rồi xem là yêu cầu chính thức.

| Miền dữ liệu | Kết quả rà soát | Status | Evidence |
|---|---|---|---|
| Mã đơn | Không có giới hạn độ dài/miền giá trị được đặc tả | N/A | Không áp dụng |
| Ngày đặt | Không có khoảng ngày hợp lệ được đặc tả | N/A | Không áp dụng |
| Tổng tiền | Không có giá trị nhỏ nhất/lớn nhất được đặc tả | N/A | Không áp dụng |
| Số lượng đơn hàng | Không có giới hạn số lượng/phân trang được đặc tả | N/A | Không áp dụng |
| Trạng thái | Là tập giá trị rời rạc, không phải miền số để áp dụng BVA | N/A | Không áp dụng |

`N/A` ở phần BVA nghĩa là chưa áp dụng được kỹ thuật dựa trên các ranh giới trong đặc tả hiện có; không có nghĩa là test đã PASS.

## 6. Hướng dẫn Evidence

Screenshot đã lưu và được liên kết tại cột Evidence. Ảnh `ev3_9_10.jpg` được dùng chung cho TC03, TC09 và TC10; bản sao trong mỗi thư mục test case được liên kết riêng.

```text
evidence/
└── FR-11-mobile/
    ├── TC01/
    │   └── ev1.jpg
    ├── TC02/
    │   └── ev2.jpg
    ├── TC03/
    │   └── ev3_9_10.jpg
    ├── TC04/  # BLOCKED: chưa có User B để thực hiện test
    ├── TC05/  # BLOCKED: không tự sửa dữ liệu
    ├── TC06/  # BLOCKED: không tự sửa dữ liệu
    ├── TC07/  # BLOCKED: không tự sửa dữ liệu
    ├── TC08/  # BLOCKED: không tự sửa dữ liệu
    ├── TC09/
    │   └── ev3_9_10.jpg
    └── TC10/
        └── ev3_9_10.jpg
```

TC04–TC08 hiện không có screenshot FR-11 do các test đang `BLOCKED`. Không đánh dấu evidence cho các test này.

## 7. Ghi chú

- Giữ nguyên expected result theo tài liệu Domain Testing/BVA.
- TC04 được `BLOCKED` vì thiếu tài khoản và đơn hàng đối chứng, không phải vì đã chứng minh chức năng phân quyền sai.
- TC05–TC08 được `BLOCKED` vì người kiểm thử không tự sửa dữ liệu để tạo trường hợp thiếu thông tin.
- TC03 và TC10 cùng ghi nhận hiện tượng thiếu màu phân biệt trạng thái; cần dùng evidence thực tế và có thể liên kết tới cùng một bug report.
- Các đường dẫn screenshot được xác minh là tồn tại trong repo; không đánh dấu TC04–TC08 là có evidence thực thi.
