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

