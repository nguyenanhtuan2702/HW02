# FR-01: Đăng ký tài khoản

## Bước 1. Xác định biến đầu vào và đầu ra

### 1.1. Mô tả chức năng

FR-01 – Đăng ký tài khoản là chức năng cho phép người dùng tạo tài khoản mới trên hệ thống EShop. Người dùng cần cung cấp các thông tin đăng ký theo yêu cầu của hệ thống. Trước khi tạo tài khoản, hệ thống phải kiểm tra tính hợp lệ của dữ liệu đầu vào.

Mục tiêu của bước này là xác định các biến đầu vào, biến đầu ra và những điều kiện cần được kiểm tra. Đây là cơ sở để thực hiện bước tiếp theo là phân chia các lớp tương đương.

### 1.2. Xác định các biến đầu vào

| Mã | Biến đầu vào | Mô tả |
|---|---|---|
| I1 | Họ và tên | Họ tên do người dùng nhập khi đăng ký tài khoản. |
| I2 | Email | Địa chỉ email được sử dụng để đăng ký tài khoản. |
| I3 | Mật khẩu | Mật khẩu do người dùng thiết lập cho tài khoản mới. |
| I4 | Xác nhận mật khẩu | Mật khẩu được nhập lại nhằm kiểm tra tính khớp với mật khẩu ban đầu. |

### 1.3. Xác định các điều kiện đầu vào

Dựa trên các yêu cầu của chức năng đăng ký tài khoản, các điều kiện cần kiểm tra bao gồm:

| Mã | Biến liên quan | Điều kiện đầu vào |
|---|---|---|
| C1 | Họ và tên | Người dùng phải nhập họ và tên. |
| C2 | Email | Email phải đúng định dạng. |
| C3 | Email | Email chưa được sử dụng để đăng ký tài khoản khác. |
| C4 | Mật khẩu | Mật khẩu phải có ít nhất 8 ký tự. |
| C5 | Mật khẩu | Mật khẩu phải có ít nhất một chữ cái viết hoa. |
| C6 | Mật khẩu | Mật khẩu phải có ít nhất một chữ cái viết thường. |
| C7 | Mật khẩu | Mật khẩu phải có ít nhất một chữ số. |
| C8 | Mật khẩu | Mật khẩu phải có ít nhất một ký tự đặc biệt được hệ thống chấp nhận. |
| C9 | Xác nhận mật khẩu | Mật khẩu xác nhận phải trùng khớp với mật khẩu ban đầu. |

*Lưu ý: Các điều kiện cụ thể cần được đối chiếu với đặc tả FR-01 trong SRS và cách triển khai thực tế của EShop trước khi chốt báo cáo.*

### 1.4. Xác định các biến đầu ra

| Mã | Biến đầu ra | Mô tả |
|---|---|---|
| O1 | Kết quả đăng ký | Cho biết thao tác đăng ký thành công hay thất bại. |
| O2 | Thông báo kiểm tra dữ liệu | Hiển thị thông báo tương ứng khi dữ liệu đầu vào không hợp lệ. |
| O3 | Kết quả chuyển trang | Khi đăng ký thành công, hệ thống chuyển người dùng đến trang đăng nhập theo yêu cầu của chức năng. |

### 1.5. Hành vi mong đợi của hệ thống

**Trường hợp dữ liệu hợp lệ:**

Người dùng cung cấp đầy đủ thông tin và đáp ứng các điều kiện đăng ký. Hệ thống tạo tài khoản thành công và chuyển người dùng đến trang đăng nhập.

**Trường hợp dữ liệu không hợp lệ:**

Hệ thống từ chối yêu cầu đăng ký và thông báo lỗi phù hợp với điều kiện chưa được đáp ứng. Tài khoản không được tạo thành công.

### 1.6. Kết luận bước 1

Sau khi phân tích chức năng FR-01, ta xác định được bốn biến đầu vào chính gồm họ và tên, email, mật khẩu và xác nhận mật khẩu; cùng ba nhóm kết quả đầu ra gồm kết quả đăng ký, thông báo kiểm tra dữ liệu và kết quả chuyển trang.

Các điều kiện đầu vào đã xác định sẽ được sử dụng làm cơ sở để thực hiện **Bước 2 – Xác định các lớp tương đương**, trong đó mỗi điều kiện được phân tích thành những lớp hợp lệ và không hợp lệ phù hợp với đặc tả.

## Bước 2. Xác định các lớp tương đương

### 2.1. Nguyên tắc phân chia lớp tương đương

Dựa trên các biến đầu vào và điều kiện đã xác định ở Bước 1, miền dữ liệu của chức năng đăng ký tài khoản được chia thành các lớp tương đương hợp lệ (Valid Equivalence Classes) và không hợp lệ (Invalid Equivalence Classes).

Các lớp tương đương được xác định dựa trên điều kiện đầu vào của từng trường. Những giá trị thuộc cùng một lớp được kỳ vọng có cách xử lý giống nhau từ hệ thống. Do đó, có thể chọn một giá trị đại diện cho mỗi lớp để kiểm thử thay vì kiểm tra tất cả các giá trị có thể có.

Đối với chức năng FR-01, các điều kiện cần phân tích gồm: họ và tên, email, độ dài mật khẩu, thành phần của mật khẩu và xác nhận mật khẩu.

### 2.2. Xác định các lớp tương đương cho từng điều kiện

#### Điều kiện 1: Họ và tên phải được cung cấp

| Mã EC | Lớp tương đương | Loại |
|---|---|---|
| EC01 | Họ và tên có giá trị | Valid |
| EC02 | Họ và tên bị bỏ trống | Invalid |

Giải thích: Hệ thống yêu cầu người dùng cung cấp họ và tên. Vì vậy, dữ liệu có giá trị thuộc lớp hợp lệ; trường bị bỏ trống thuộc lớp không hợp lệ.

#### Điều kiện 2: Email phải có định dạng hợp lệ và chưa được sử dụng

| Mã EC | Lớp tương đương | Loại |
|---|---|---|
| EC03 | Email đúng định dạng và chưa tồn tại trong hệ thống | Valid |
| EC04 | Email bị bỏ trống | Invalid |
| EC05 | Email không đúng định dạng | Invalid |
| EC06 | Email đúng định dạng nhưng đã tồn tại trong hệ thống | Invalid |

Giải thích: Email phải đồng thời đáp ứng hai điều kiện là đúng định dạng và có tính duy nhất. Email bỏ trống, email sai định dạng và email đã tồn tại được tách riêng để có thể kiểm tra từng nguyên nhân khiến việc đăng ký không hợp lệ.

#### Điều kiện 3: Mật khẩu phải có ít nhất 8 ký tự

| Mã EC | Lớp tương đương | Loại |
|---|---|---|
| EC07 | Mật khẩu có độ dài từ 8 ký tự trở lên | Valid |
| EC08 | Mật khẩu có độ dài dưới 8 ký tự | Invalid |

Giải thích: Điều kiện này xác định hai miền dữ liệu dựa trên giới hạn độ dài tối thiểu là 8 ký tự.

#### Điều kiện 4: Mật khẩu phải chứa ít nhất một chữ cái viết hoa

| Mã EC | Lớp tương đương | Loại |
|---|---|---|
| EC09 | Mật khẩu có ít nhất một chữ cái viết hoa | Valid |
| EC10 | Mật khẩu không có chữ cái viết hoa | Invalid |

#### Điều kiện 5: Mật khẩu phải chứa ít nhất một chữ cái viết thường

| Mã EC | Lớp tương đương | Loại |
|---|---|---|
| EC11 | Mật khẩu có ít nhất một chữ cái viết thường | Valid |
| EC12 | Mật khẩu không có chữ cái viết thường | Invalid |

#### Điều kiện 6: Mật khẩu phải chứa ít nhất một chữ số

| Mã EC | Lớp tương đương | Loại |
|---|---|---|
| EC13 | Mật khẩu có ít nhất một chữ số | Valid |
| EC14 | Mật khẩu không có chữ số | Invalid |

#### Điều kiện 7: Mật khẩu phải chứa ít nhất một ký tự đặc biệt được chấp nhận

Các ký tự đặc biệt được quy định trong đặc tả gồm: `@`, `$`, `!`, `%`, `*`, `?`, `&`.

| Mã EC | Lớp tương đương | Loại |
|---|---|---|
| EC15 | Mật khẩu có ít nhất một ký tự đặc biệt được chấp nhận | Valid |
| EC16 | Mật khẩu không có ký tự đặc biệt nào thuộc danh sách được chấp nhận | Invalid |

Giải thích: Việc phân chia dựa trên tập ký tự đặc biệt được quy định trong đặc tả, không mặc định mọi ký tự đặc biệt đều được hệ thống chấp nhận.

#### Điều kiện 8: Xác nhận mật khẩu phải khớp với mật khẩu ban đầu

| Mã EC | Lớp tương đương | Loại |
|---|---|---|
| EC17 | Mật khẩu xác nhận trùng khớp với mật khẩu ban đầu | Valid |
| EC18 | Trường xác nhận mật khẩu bị bỏ trống | Invalid |
| EC19 | Mật khẩu xác nhận có giá trị nhưng không khớp với mật khẩu ban đầu | Invalid |

Giải thích: Trường hợp bỏ trống và trường hợp nhập mật khẩu không khớp được tách riêng vì chúng có thể được hệ thống kiểm tra và thông báo theo cách khác nhau.

### 2.3. Tập phân hoạch tương đương đầy đủ

Sau khi phân tích từng điều kiện đầu vào, tập các lớp tương đương của FR-01 được tổng hợp như sau:

| Điều kiện | Các lớp tương đương | Phân loại |
|---|---|---|
| Họ và tên | EC01, EC02 | 1 Valid, 1 Invalid |
| Email | EC03, EC04, EC05, EC06 | 1 Valid, 3 Invalid |
| Độ dài mật khẩu | EC07, EC08 | 1 Valid, 1 Invalid |
| Chữ hoa trong mật khẩu | EC09, EC10 | 1 Valid, 1 Invalid |
| Chữ thường trong mật khẩu | EC11, EC12 | 1 Valid, 1 Invalid |
| Chữ số trong mật khẩu | EC13, EC14 | 1 Valid, 1 Invalid |
| Ký tự đặc biệt trong mật khẩu | EC15, EC16 | 1 Valid, 1 Invalid |
| Xác nhận mật khẩu | EC17, EC18, EC19 | 1 Valid, 2 Invalid |

Tổng cộng, bước phân hoạch đã xác định 19 lớp tương đương cho các điều kiện đầu vào của chức năng FR-01.

Lưu ý rằng các lớp của những điều kiện mật khẩu khác nhau có thể giao nhau. Ví dụ, một mật khẩu vừa quá ngắn vừa không có chữ số có thể vi phạm đồng thời hai điều kiện. Khi lựa chọn test case ở Bước 3, cần thiết kế dữ liệu để kiểm tra riêng từng lớp Invalid và tránh vi phạm nhiều điều kiện cùng lúc.

### 2.4. Kết luận Bước 2

Các lớp tương đương đã được xác định dựa trên những điều kiện đầu vào của chức năng đăng ký tài khoản. Các lớp Valid đại diện cho dữ liệu đáp ứng điều kiện tương ứng; các lớp Invalid đại diện cho những trường hợp vi phạm yêu cầu.

Bảng phân hoạch trên là cơ sở để thực hiện Bước 3 – Lựa chọn test case đại diện cho từng lớp tương đương, bảo đảm các lớp đã xác định đều được bao phủ.
