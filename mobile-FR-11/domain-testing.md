# FR-11: Xem lịch sử đơn hàng (User)

## Bước 1. Xác định biến đầu vào và đầu ra

### 1.1. Mô tả chức năng

FR-11 – Xem lịch sử đơn hàng cho phép người dùng xem các đơn hàng của chính mình. Thông tin cần hiển thị cho mỗi đơn hàng gồm mã đơn, ngày đặt, tổng tiền và trạng thái hiện tại. Trạng thái phải được dịch sang tiếng Việt rõ ràng và phân biệt bằng màu sắc.

Mục tiêu của bước này là xác định các biến đầu vào, biến đầu ra và điều kiện nghiệp vụ làm cơ sở cho việc phân chia các lớp tương đương.

### 1.2. Xác định các biến đầu vào

| Mã | Biến đầu vào | Mô tả |
|---|---|---|
| I1 | Người dùng hiện tại | Ngữ cảnh người dùng đang xem lịch sử, dùng để xác định đơn hàng nào thuộc về người dùng đó. |
| I2 | Tập đơn hàng | Tập các bản ghi đơn hàng có liên quan đến người dùng hiện tại. Tập dữ liệu có thể rỗng, có một đơn hàng hoặc có nhiều đơn hàng. |
| I3 | Trạng thái đơn hàng | Trạng thái hiện tại của từng đơn hàng được dùng để hiển thị trong lịch sử. FR-10 định nghĩa các trạng thái: `pending`, `confirmed`, `shipping`, `delivered`, `canceled`. |

**Câu trong đặc tả làm căn cứ:**

- FR-11: “Người dùng chỉ xem được đơn hàng của chính mình.”
- FR-11: “Hiển thị: Mã đơn, Ngày đặt, Tổng tiền, Trạng thái hiện tại.”
- FR-10: “Đơn hàng có 5 trạng thái...” và liệt kê `pending`, `confirmed`, `shipping`, `delivered`, `canceled`.

Lưu ý: Người dùng hiện tại và tập đơn hàng là các biến logic được xác định từ yêu cầu nghiệp vụ, không phải các trường nhập liệu được nêu nguyên văn trong FR-11.

### 1.3. Xác định các điều kiện đầu vào

| Mã | Biến liên quan | Điều kiện đầu vào | Câu trong đặc tả làm căn cứ |
|---|---|---|---|
| C1 | Người dùng hiện tại, tập đơn hàng | Người dùng chỉ được xem đơn hàng của chính mình. | FR-11: “Người dùng chỉ xem được đơn hàng của chính mình.” |
| C2 | Tập đơn hàng | Với mỗi đơn hàng được hiển thị, hệ thống cần cung cấp mã đơn, ngày đặt, tổng tiền và trạng thái hiện tại. | FR-11: “Hiển thị: Mã đơn, Ngày đặt, Tổng tiền, Trạng thái hiện tại.” |
| C3 | Trạng thái đơn hàng | Trạng thái phải được dịch sang tiếng Việt rõ ràng. | FR-11: “Trạng thái phải được dịch sang tiếng Việt rõ ràng...” |
| C4 | Cách hiển thị trạng thái | Các trạng thái phải được phân biệt bằng màu sắc. | FR-11: “...và phân biệt màu sắc.” |
| C5 | Trạng thái đơn hàng | Các trạng thái được định nghĩa trong FR-10 gồm `pending`, `confirmed`, `shipping`, `delivered` và `canceled`. | FR-10: “Đơn hàng có 5 trạng thái...” và danh sách trạng thái tương ứng. |

### 1.4. Xác định các biến đầu ra

| Mã | Biến đầu ra | Mô tả | Câu trong đặc tả làm căn cứ |
|---|---|---|---|
| O1 | Danh sách đơn hàng | Danh sách đơn hàng được hiển thị cho người dùng hiện tại; không hiển thị đơn hàng của người dùng khác. | FR-11: “Người dùng chỉ xem được đơn hàng của chính mình.” |
| O2 | Mã đơn | Mã đơn hàng được hiển thị trong lịch sử. | FR-11: “Hiển thị: Mã đơn...” |
| O3 | Ngày đặt | Ngày đặt hàng được hiển thị trong lịch sử. | FR-11: “...Ngày đặt...” |
| O4 | Tổng tiền | Tổng tiền của đơn hàng được hiển thị trong lịch sử. | FR-11: “...Tổng tiền...” |
| O5 | Trạng thái hiện tại | Trạng thái được hiển thị bằng tiếng Việt rõ ràng và phân biệt bằng màu sắc. | FR-11: “...Trạng thái hiện tại. Trạng thái phải được dịch sang tiếng Việt rõ ràng và phân biệt màu sắc.” |

### 1.5. Hành vi mong đợi của hệ thống

**Trường hợp có đơn hàng hợp lệ:**

Hệ thống chỉ hiển thị đơn hàng của người dùng hiện tại. Mỗi đơn hàng cần có mã đơn, ngày đặt, tổng tiền và trạng thái hiện tại. Trạng thái được dịch sang tiếng Việt rõ ràng và phân biệt bằng màu sắc.

**Trường hợp không có đơn hàng:**

FR-11 không yêu cầu người dùng phải có ít nhất một đơn hàng. Vì vậy, trường hợp không có đơn hàng được xem là một trạng thái dữ liệu cần kiểm tra, không tự động xem là dữ liệu Invalid. Đặc tả chưa quy định cụ thể nội dung thông báo hoặc hình thức Empty State.

**Trường hợp có đơn hàng của người khác:**

Đơn hàng của người dùng khác không được hiển thị trong lịch sử của người dùng hiện tại.

### 1.6. Những thông tin chưa được quy định

Đặc tả FR-11 chưa quy định rõ:

- Số lượng đơn hàng tối đa được hiển thị hoặc giới hạn số đơn hàng trên mỗi trang.
- Thứ tự sắp xếp đơn hàng.
- Định dạng hoặc độ dài hợp lệ của mã đơn.
- Miền giá trị nhỏ nhất/lớn nhất hoặc độ chính xác của tổng tiền.
- Khoảng ngày hợp lệ hoặc định dạng ngày cụ thể.
- Màu cụ thể ứng với từng trạng thái.
- Nội dung thông báo và bố cục chính xác khi người dùng chưa có đơn hàng.
- Cách xử lý khi dữ liệu có trạng thái ngoài năm trạng thái được định nghĩa trong FR-10.
- Hành vi chi tiết khi người dùng chưa đăng nhập; FR-11 không mô tả trường hợp này trực tiếp.

Các thông tin trên không được tự bổ sung thành ràng buộc nghiệp vụ nếu chưa có đặc tả bổ sung.

## Bước 2. Xác định các lớp tương đương

### 2.1. Nguyên tắc phân chia lớp tương đương

Dựa trên các biến đầu vào và điều kiện đã xác định ở Bước 1, miền dữ liệu và kết quả hiển thị của FR-11 được chia thành các lớp tương đương hợp lệ (Valid Equivalence Classes) và không hợp lệ (Invalid Equivalence Classes).

Các lớp được tách riêng khi có khả năng được xử lý hoặc hiển thị khác nhau. Trường hợp không có đơn hàng được xem là trạng thái dữ liệu hợp lệ để kiểm tra, vì FR-11 không quy định phải có ít nhất một đơn hàng. Những hành vi chưa được đặc tả sẽ được ghi chú riêng thay vì tự đặt ra kết quả mong đợi.

### 2.2. Xác định các lớp tương đương cho từng điều kiện

#### Điều kiện 1: Người dùng chỉ được xem đơn hàng của chính mình

| Mã EC | Lớp tương đương | Loại |
|---|---|---|
| EC01 | Đơn hàng thuộc người dùng hiện tại | Valid |
| EC02 | Đơn hàng thuộc người dùng khác xuất hiện trong lịch sử của người dùng hiện tại | Invalid |

Giải thích: FR-11 giới hạn phạm vi lịch sử theo chủ sở hữu đơn hàng. EC02 vi phạm trực tiếp điều kiện này.

#### Điều kiện 2: Số lượng đơn hàng trong lịch sử

| Mã EC | Lớp tương đương | Loại |
|---|---|---|
| EC03 | Người dùng hiện tại không có đơn hàng | Valid data state |
| EC04 | Người dùng hiện tại có đúng một đơn hàng | Valid |
| EC05 | Người dùng hiện tại có từ hai đơn hàng trở lên | Valid |

Giải thích: Các lớp trên đại diện cho những trạng thái dữ liệu có thể gặp khi hiển thị lịch sử. FR-11 không quy định số lượng tối thiểu bắt buộc hoặc giới hạn số lượng tối đa. Vì vậy, EC03 không được xếp vào Invalid.

#### Điều kiện 3: Trạng thái đơn hàng thuộc tập trạng thái được định nghĩa

FR-10 định nghĩa năm trạng thái đơn hàng: `pending`, `confirmed`, `shipping`, `delivered`, `canceled`.

| Mã EC | Lớp tương đương | Loại |
|---|---|---|
| EC06 | Trạng thái `pending` | Valid |
| EC07 | Trạng thái `confirmed` | Valid |
| EC08 | Trạng thái `shipping` | Valid |
| EC09 | Trạng thái `delivered` | Valid |
| EC10 | Trạng thái `canceled` | Valid |

Giải thích: Các trạng thái được tách thành từng lớp vì mỗi trạng thái cần được hiển thị rõ ràng bằng tiếng Việt và phân biệt bằng màu sắc.

**Miền ngoài đặc tả:** Một giá trị trạng thái khác năm giá trị trên nằm ngoài tập trạng thái được định nghĩa trong FR-10. Tuy nhiên, FR-11/FR-10 chưa quy định cách hiển thị hoặc xử lý dữ liệu trạng thái này. Do đó, chưa tạo lớp Invalid có tiêu chí Pass/Fail chính thức cho trường hợp này.

#### Điều kiện 4: Các thông tin bắt buộc phải được hiển thị

| Mã EC | Lớp tương đương | Loại |
|---|---|---|
| EC11 | Đơn hàng hiển thị đủ mã đơn, ngày đặt, tổng tiền và trạng thái hiện tại | Valid |
| EC12 | Kết quả hiển thị thiếu mã đơn | Invalid |
| EC13 | Kết quả hiển thị thiếu ngày đặt | Invalid |
| EC14 | Kết quả hiển thị thiếu tổng tiền | Invalid |
| EC15 | Kết quả hiển thị thiếu trạng thái hiện tại | Invalid |

Giải thích: FR-11 liệt kê cụ thể bốn thông tin cần hiển thị. Các trường hợp thiếu từng thông tin được tách riêng để xác định chính xác nội dung nào không đáp ứng yêu cầu.

#### Điều kiện 5: Trạng thái được dịch sang tiếng Việt rõ ràng

| Mã EC | Lớp tương đương | Loại |
|---|---|---|
| EC16 | Trạng thái được dịch sang tiếng Việt rõ ràng | Valid |
| EC17 | Trạng thái không được dịch sang tiếng Việt hoặc nhãn hiển thị không rõ ràng | Invalid |

Giải thích: Đây là yêu cầu hiển thị được quy định trực tiếp trong FR-11.

#### Điều kiện 6: Các trạng thái được phân biệt bằng màu sắc

| Mã EC | Lớp tương đương | Loại |
|---|---|---|
| EC18 | Các trạng thái được phân biệt bằng màu sắc | Valid |
| EC19 | Màu sắc không giúp phân biệt các trạng thái | Invalid |

Giải thích: FR-11 yêu cầu trạng thái phải được phân biệt bằng màu sắc, nhưng không quy định màu cụ thể cho từng trạng thái. Vì vậy, chỉ kiểm tra khả năng phân biệt, không tự đặt bảng màu bắt buộc.

### 2.3. Tập phân hoạch tương đương đầy đủ

| Điều kiện | Các lớp tương đương | Phân loại |
|---|---|---|
| Quyền sở hữu đơn hàng | EC01, EC02 | 1 Valid, 1 Invalid |
| Số lượng đơn hàng | EC03, EC04, EC05 | 3 trạng thái dữ liệu hợp lệ để kiểm tra |
| Trạng thái đơn hàng | EC06, EC07, EC08, EC09, EC10 | 5 Valid |
| Thông tin bắt buộc | EC11, EC12, EC13, EC14, EC15 | 1 Valid, 4 Invalid |
| Dịch trạng thái | EC16, EC17 | 1 Valid, 1 Invalid |
| Phân biệt màu sắc | EC18, EC19 | 1 Valid, 1 Invalid |

Tổng cộng, phân hoạch xác định 19 lớp tương đương có thể kiểm tra theo các yêu cầu hiển thị của FR-11 và tập trạng thái được định nghĩa trong FR-10. Trường hợp trạng thái ngoài tập quy định được ghi nhận riêng vì expected result chưa được đặc tả.

## Bước 3. Lựa chọn test case đại diện

### 3.1. Nguyên tắc lựa chọn test case

Dựa trên tập phân hoạch tương đương đã xác định ở Bước 2, test case được lựa chọn theo các nguyên tắc sau:

- Với các lớp Valid, có thể kết hợp nhiều lớp trong một test case nếu dữ liệu có thể đồng thời thỏa mãn các điều kiện đó.
- Với mỗi lớp Invalid, test case chỉ tập trung kiểm tra một lớp Invalid tại một thời điểm; các điều kiện còn lại phải hợp lệ.
- Mỗi test case cần có dữ liệu/điều kiện tiên quyết và kết quả mong đợi rõ ràng.
- Nếu cần tạo dữ liệu có trường bị thiếu, phải có dữ liệu kiểm thử hoặc cách cấu hình môi trường phù hợp. Nếu không thể tạo tình huống đó, ghi nhận là Blocked thay vì tự kết luận Pass.

### 3.2. Bộ test case bao phủ các lớp tương đương

| Mã test case | Lớp tương đương được kiểm tra | Mục đích |
|---|---|---|
| TC01 | EC01, EC04, EC06, EC11, EC16, EC18 | Kiểm tra lịch sử có một đơn hàng hợp lệ, trạng thái `pending` và đủ thông tin hiển thị |
| TC02 | EC03 | Kiểm tra lịch sử khi người dùng chưa có đơn hàng |
| TC03 | EC01, EC05, EC07, EC08, EC09, EC10, EC11, EC16, EC18 | Kiểm tra nhiều đơn hàng của cùng người dùng với các trạng thái còn lại |
| TC04 | EC02 | Kiểm tra không hiển thị đơn hàng của người dùng khác |
| TC05 | EC12 | Kiểm tra trường hợp kết quả hiển thị thiếu mã đơn |
| TC06 | EC13 | Kiểm tra trường hợp kết quả hiển thị thiếu ngày đặt |
| TC07 | EC14 | Kiểm tra trường hợp kết quả hiển thị thiếu tổng tiền |
| TC08 | EC15 | Kiểm tra trường hợp kết quả hiển thị thiếu trạng thái hiện tại |
| TC09 | EC17 | Kiểm tra trạng thái không được dịch sang tiếng Việt rõ ràng |
| TC10 | EC19 | Kiểm tra trạng thái không được phân biệt bằng màu sắc |

TC05–TC08 cần dữ liệu có thể tái tạo để quan sát trường bị thiếu. Nếu không thể tạo fixture hoặc phản hồi thiếu trường, ghi nhận test case là Blocked và nêu rõ lý do.

### 3.3. Chi tiết test case

#### TC01 – Xem lịch sử có một đơn hàng hợp lệ

**Điều kiện tiên quyết:** Người dùng A có đúng một đơn hàng thuộc về A; đơn hàng có trạng thái `pending`.

**Dữ liệu/điều kiện kiểm tra:**

- Người dùng hiện tại: A.
- Tập đơn hàng của A: một đơn hàng thuộc A.
- Trạng thái: `pending`.

**Các lớp được bao phủ:** EC01, EC04, EC06, EC11, EC16, EC18.

**Kết quả mong đợi:** Hệ thống hiển thị đơn hàng của A với mã đơn, ngày đặt, tổng tiền và trạng thái hiện tại. Trạng thái được dịch sang tiếng Việt rõ ràng và phân biệt bằng màu sắc.

#### TC02 – Xem lịch sử khi không có đơn hàng

**Điều kiện tiên quyết:** Người dùng A không có đơn hàng.

**Dữ liệu/điều kiện kiểm tra:** Tập đơn hàng thuộc A rỗng.

**Lớp được kiểm tra:** EC03.

**Kết quả mong đợi:** Không hiển thị đơn hàng của người dùng khác. Nội dung và bố cục cụ thể của màn hình rỗng chưa được quy định trong FR-11 nên không đánh giá theo một thông báo cụ thể.

#### TC03 – Xem lịch sử có nhiều đơn hàng với các trạng thái khác nhau

**Điều kiện tiên quyết:** Người dùng A có nhiều đơn hàng, tất cả đều thuộc A. Dữ liệu có trạng thái `confirmed`, `shipping`, `delivered` và `canceled`.

**Lớp được bao phủ:** EC01, EC05, EC07, EC08, EC09, EC10, EC11, EC16, EC18.

**Kết quả mong đợi:** Các đơn hàng của A được hiển thị; mỗi đơn có mã đơn, ngày đặt, tổng tiền và trạng thái hiện tại. Các trạng thái được dịch sang tiếng Việt rõ ràng và được phân biệt bằng màu sắc.

#### TC04 – Không hiển thị đơn hàng của người dùng khác

**Điều kiện tiên quyết:** Hệ thống có đơn hàng của người dùng A và B; người đang xem lịch sử là A.

**Dữ liệu/điều kiện kiểm tra:** Kiểm tra danh sách được trả về/hiển thị cho A khi dữ liệu của cả A và B cùng tồn tại.

**Lớp được kiểm tra:** EC02.

**Kết quả mong đợi:** Lịch sử của A chỉ hiển thị các đơn hàng thuộc A, không hiển thị đơn hàng thuộc B.

#### TC05 – Kết quả hiển thị thiếu mã đơn

**Điều kiện tiên quyết:** Có thể tạo hoặc quan sát bản ghi/kết quả hiển thị thiếu mã đơn.

**Lớp được kiểm tra:** EC12.

**Kết quả mong đợi:** Kết quả đáp ứng FR-11 phải có mã đơn. Nếu mã đơn bị thiếu, ghi nhận là không đáp ứng yêu cầu. Nếu không thể tái tạo dữ liệu này, đánh dấu Blocked.

#### TC06 – Kết quả hiển thị thiếu ngày đặt

**Điều kiện tiên quyết:** Có thể tạo hoặc quan sát bản ghi/kết quả hiển thị thiếu ngày đặt.

**Lớp được kiểm tra:** EC13.

**Kết quả mong đợi:** Kết quả đáp ứng FR-11 phải có ngày đặt. Nếu ngày đặt bị thiếu, ghi nhận là không đáp ứng yêu cầu. Nếu không thể tái tạo dữ liệu này, đánh dấu Blocked.

#### TC07 – Kết quả hiển thị thiếu tổng tiền

**Điều kiện tiên quyết:** Có thể tạo hoặc quan sát bản ghi/kết quả hiển thị thiếu tổng tiền.

**Lớp được kiểm tra:** EC14.

**Kết quả mong đợi:** Kết quả đáp ứng FR-11 phải có tổng tiền. Nếu tổng tiền bị thiếu, ghi nhận là không đáp ứng yêu cầu. Nếu không thể tái tạo dữ liệu này, đánh dấu Blocked.

#### TC08 – Kết quả hiển thị thiếu trạng thái hiện tại

**Điều kiện tiên quyết:** Có thể tạo hoặc quan sát bản ghi/kết quả hiển thị thiếu trạng thái.

**Lớp được kiểm tra:** EC15.

**Kết quả mong đợi:** Kết quả đáp ứng FR-11 phải có trạng thái hiện tại. Nếu trạng thái bị thiếu, ghi nhận là không đáp ứng yêu cầu. Nếu không thể tái tạo dữ liệu này, đánh dấu Blocked.

#### TC09 – Trạng thái không được dịch sang tiếng Việt rõ ràng

**Điều kiện tiên quyết:** Có ít nhất một đơn hàng có trạng thái được hiển thị.

**Lớp được kiểm tra:** EC17.

**Kết quả mong đợi:** Trạng thái phải được dịch sang tiếng Việt rõ ràng. Nếu trạng thái vẫn hiển thị bằng giá trị kỹ thuật hoặc nhãn không rõ nghĩa, ghi nhận là không đáp ứng FR-11.

#### TC10 – Trạng thái không được phân biệt bằng màu sắc

**Điều kiện tiên quyết:** Có thể so sánh cách hiển thị của ít nhất hai trạng thái khác nhau.

**Lớp được kiểm tra:** EC19.

**Kết quả mong đợi:** Các trạng thái phải được phân biệt bằng màu sắc. FR-11 không quy định mã màu cụ thể, do đó chỉ đánh giá yêu cầu phân biệt màu sắc chứ không áp đặt một màu cố định cho từng trạng thái.

### 3.4. Đánh giá độ bao phủ các lớp tương đương

- EC01 và EC04 được bao phủ bởi TC01; EC01 và EC05 được bao phủ bởi TC03.
- EC03 được bao phủ bởi TC02.
- EC06 được bao phủ bởi TC01; EC07, EC08, EC09 và EC10 được bao phủ bởi TC03.
- EC11 được bao phủ bởi TC01 và TC03.
- EC02 được bao phủ riêng bởi TC04.
- EC12, EC13, EC14 và EC15 lần lượt được bao phủ bởi TC05, TC06, TC07 và TC08.
- EC16 và EC18 được bao phủ bởi TC01 và TC03; các trường hợp Invalid EC17 và EC19 được kiểm tra riêng bởi TC09 và TC10.

Các test case Invalid tập trung vào từng lớp tại một thời điểm, không cố ý kết hợp nhiều lỗi đầu ra trong cùng một test case. Các test case cần dữ liệu thiếu trường chỉ được thực thi khi có thể tạo dữ liệu phù hợp; nếu không, phải ghi rõ Blocked.

Trạng thái nằm ngoài năm giá trị được FR-10 định nghĩa chưa có expected result được quy định. Vì vậy, chưa đưa trường hợp này vào bộ test case Pass/Fail chính thức.
