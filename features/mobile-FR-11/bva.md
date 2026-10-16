# FR-11: Xem lịch sử đơn hàng (User)

## Bước 1. Xác định các giá trị biên

### 1.1. Mục tiêu

Boundary Value Analysis (BVA) là kỹ thuật kiểm thử tập trung vào các giá trị nằm tại hoặc gần ranh giới của miền dữ liệu. Kỹ thuật này giúp phát hiện những lỗi có thể xảy ra khi hệ thống xác định sai giới hạn cho phép.

Dựa trên các điều kiện của chức năng FR-11 – Xem lịch sử đơn hàng, cần xem xét các miền dữ liệu có giới hạn được quy định rõ trong đặc tả.

### 1.2. Xác định điều kiện có giá trị biên

FR-11 yêu cầu hiển thị mã đơn, ngày đặt, tổng tiền và trạng thái hiện tại; người dùng chỉ được xem đơn hàng của chính mình. Tuy nhiên, đặc tả không nêu giới hạn số học hoặc độ dài cụ thể cho các trường này.

| Mã điều kiện | Điều kiện | Giá trị biên được quy định |
|---|---|---|
| C1 | Người dùng chỉ xem được đơn hàng của chính mình | Không phải miền giá trị số có biên dưới/trên; là điều kiện quyền sở hữu. |
| C2 | Hiển thị mã đơn, ngày đặt, tổng tiền và trạng thái hiện tại | Không quy định độ dài mã đơn, khoảng ngày hoặc giới hạn tổng tiền. |
| C3 | Trạng thái được dịch sang tiếng Việt rõ ràng và phân biệt màu sắc | Các trạng thái là tập giá trị rời rạc; không quy định biên số học. |
| C4 | Số lượng đơn hàng hiển thị | Không quy định số lượng tối thiểu bắt buộc, số lượng tối đa hoặc giới hạn phân trang. |

Do đó, từ FR-11 hiện tại không thể xác định một bộ giá trị “ngay dưới biên – tại biên – ngay trên biên” mà không tự thêm ràng buộc ngoài đặc tả.

Các trường hợp 0 đơn hàng, 1 đơn hàng và nhiều đơn hàng có thể dùng làm lớp tương đương trong `domain-testing.md`, nhưng không được xem là test case BVA chính thức vì FR-11 không quy định một biên số lượng cụ thể.

Đối với trạng thái, FR-10 liệt kê `pending`, `confirmed`, `shipping`, `delivered` và `canceled`. Đây là các giá trị rời rạc, không phải miền số liên tục có thể xác định giá trị ngay dưới/trên biên. Những giá trị này được kiểm tra bằng phân lớp tương đương trong phần Domain Testing.

## Bước 2. Thiết kế test case theo giá trị biên

### 2.1. Nguyên tắc thiết kế

BVA chỉ được thiết kế khi đặc tả xác định được biên của miền dữ liệu. Với FR-11 hiện tại, chưa có giới hạn độ dài mã đơn, khoảng ngày hợp lệ, miền tổng tiền hoặc giới hạn số lượng đơn hàng.

Vì vậy, không tự tạo các giá trị như tổng tiền bằng 0, một mức tổng tiền tối đa, ngày nhỏ nhất/lớn nhất hoặc số lượng đơn tối đa rồi xem chúng là biên chính thức.

### 2.2. Bảng rà soát test case BVA

| Mã test case | Miền dữ liệu | Giá trị ngay dưới biên | Giá trị tại biên | Giá trị ngay trên biên | Kết luận |
|---|---|---|---|---|---|
| Không áp dụng | Mã đơn | Không xác định | Không xác định | Không xác định | Đặc tả không quy định biên độ dài hoặc miền mã đơn. |
| Không áp dụng | Ngày đặt | Không xác định | Không xác định | Không xác định | Đặc tả không quy định khoảng ngày hợp lệ. |
| Không áp dụng | Tổng tiền | Không xác định | Không xác định | Không xác định | Đặc tả không quy định giá trị nhỏ nhất/lớn nhất. |
| Không áp dụng | Số lượng đơn hàng | Không xác định | Không xác định | Không xác định | Đặc tả không quy định giới hạn số lượng hoặc phân trang. |
| Không áp dụng | Trạng thái đơn hàng | Không áp dụng | Không áp dụng | Không áp dụng | Trạng thái là tập giá trị rời rạc, được kiểm tra bằng Equivalence Partitioning. |

**Kết luận:** Chưa có test case BVA chính thức cho FR-11 vì không xác định được biên được đặc tả. Đây không phải là khẳng định rằng hệ thống không thể có lỗi biên; chỉ là tài liệu hiện tại chưa cung cấp các giới hạn cần thiết để thiết kế BVA có căn cứ.

### 2.3. Các bước thực hiện kiểm thử

Hiện chưa thể đưa ra các bước thực thi BVA cụ thể vì chưa có test case BVA được xác định từ biên trong đặc tả. Các kiểm tra về quyền sở hữu đơn hàng, số lượng đơn hàng đại diện và hiển thị từng trạng thái đã được trình bày trong `domain-testing.md` theo kỹ thuật phân lớp tương đương.

Khi có yêu cầu bổ sung xác định rõ giới hạn cho mã đơn, ngày đặt, tổng tiền hoặc số lượng đơn hàng trên mỗi trang, có thể thực hiện các bước sau:

1. Xác định biên dưới và/hoặc biên trên từ yêu cầu bổ sung.
2. Chọn giá trị ngay dưới biên, tại biên và ngay trên biên.
3. Giữ các điều kiện còn lại ở trạng thái hợp lệ để cô lập ảnh hưởng của biên đang kiểm tra.
4. Thực thi test case, ghi nhận kết quả thực tế và lưu bằng chứng.

Các bước trên chỉ được áp dụng sau khi biên đã được quy định; không dùng để tự suy đoán giới hạn nghiệp vụ.

## Bước 3. Đánh giá kết quả kiểm thử

Do chưa có giá trị biên được quy định trong FR-11, hiện chưa có test case BVA chính thức để thực thi và đánh giá Pass/Fail.

| Mã test case | Kết quả mong đợi | Kết quả thực tế | Trạng thái | Bằng chứng |
|---|---|---|---|---|
| Không áp dụng | Chưa thể xác định nếu chưa có biên trong đặc tả | Chưa thực thi | N/A | Chưa có |

Trạng thái N/A ở đây nghĩa là không áp dụng được BVA dựa trên các giới hạn hiện có trong đặc tả; không phải là kết quả kiểm thử Pass.

## Kết luận

Với FR-11, đặc tả chỉ quy định phạm vi sở hữu đơn hàng, bốn thông tin phải hiển thị và cách trình bày trạng thái. Đặc tả không quy định biên số học hoặc giới hạn độ dài/số lượng cho các miền dữ liệu trên.

Vì vậy, không tạo test case với giá trị ngay dưới, tại và ngay trên biên khi chưa có căn cứ. Các trường hợp 0, 1 và nhiều đơn hàng cùng năm trạng thái được kiểm tra như các lớp tương đương trong `domain-testing.md`, không gọi nhầm là BVA.
