# AI Audit Report — HW02 Domain Testing

## 1. Thông tin chung

- **Bài tập:** HW02 — Domain Testing on EShop
- **Ngày thực hiện:** 14/10/2026
- **Khoảng thời gian làm việc được xác định:** Khoảng 21:43–22:57 (UTC+7), riêng thời điểm của từng tương tác cần đối chiếu lại với lịch sử ChatGPT.
- **Công cụ AI:** ChatGPT của OpenAI
- **Mục đích sử dụng AI:** Hỗ trợ phân tích yêu cầu, tổ chức repository, áp dụng Domain Testing, xây dựng các lớp tương đương và lựa chọn test case, áp dụng Boundary Value Analysis (BVA).
- **Nguyên tắc sử dụng:** Kết quả từ AI được xem là bản nháp hỗ trợ. Sinh viên có trách nhiệm kiểm tra lại với đặc tả chính thức, thực thi test case và điều chỉnh các nội dung chưa chính xác.

---

## 2. Nhật ký sử dụng AI

### Lần 1. Phân tích yêu cầu bài tập và lựa chọn feature

**Thời gian:** Ngày 14/10/2026; giờ cụ thể cần đối chiếu lịch sử ChatGPT.

**Tên công cụ:** ChatGPT.

**Prompt đã sử dụng:**

> Giải thích chi tiết bài tập sau, thì tui chọn các FR 1,9,17 tương ứng cho 3 pool đầu pool 4 thì sử dụng mobile test cô quy định đó là các chức năng bao gồm 1->19 thuộc 3 pool còn lại nhưng không được chọn trùng thì tui chọn FR 15 cho pool 4.

**Đầu ra AI:**

- Phân tích yêu cầu HW02 và hướng dẫn quy trình áp dụng Domain Testing, BVA cho các feature được chọn.
- Xác định FR-01 là đăng ký tài khoản, FR-09 là mã giảm giá và FR-17 là quản lý mã giảm giá.
- Lưu ý cần xác minh phạm vi FR-15 khi kiểm thử Mobile, vì chức năng quản lý sản phẩm trên Web Admin không mặc nhiên có mặt trên ứng dụng Mobile.
- Đề xuất cấu trúc báo cáo, cách ghi nhận kết quả thực thi, bằng chứng, bug report, AI Gap Analysis, AI Audit Report và Git commit log.

**Kết quả review:** Chọn FR-01, FR-09 và FR-17 cho ba pool đầu. Phạm vi FR-15 trên Mobile cần được xác minh với hướng dẫn của giảng viên và chức năng thực tế của ứng dụng.

### Lần 2. Hỗ trợ tạo cấu trúc repository HW02

**Thời gian:** Khoảng 21:43 ngày 14/10/2026 (UTC+7).

**Tên công cụ:** ChatGPT.

**Prompt đã sử dụng:**

> oke tui đã git clone ebi shop về tiếp theo mình sẽ tạo repo với cấu trúc sau HW02/ ... có cách nào tạo nhanh ko

**Đầu ra AI:**

- Đề xuất tạo repository bài tập HW02 riêng, tách biệt với repository mã nguồn EShop SUT.
- Cung cấp script PowerShell tạo các thư mục `features`, `bug-reports`, `evidence`, `agent-skills` và các file Markdown cần thiết.
- Hướng dẫn khởi tạo Git repository bằng `git init`.
- Giải thích cách kiểm tra cấu trúc thư mục bằng lệnh `tree /F`.

**Kết quả review:** Sử dụng script để tạo cấu trúc ban đầu; kiểm tra lại đường dẫn và nội dung file sau khi tạo.

### Lần 3. Khắc phục việc không thấy repository trên GitHub

**Thời gian:** Ngày 14/10/2026; giờ cụ thể cần đối chiếu lịch sử ChatGPT.

**Tên công cụ:** ChatGPT.

**Prompt đã sử dụng:**

> Sao tui ko thấy trên git ta

**Đầu ra AI:**

- Giải thích rằng `git init` chỉ tạo Git repository trên máy tính, không tự động tải dữ liệu lên GitHub.
- Hướng dẫn tạo repository mới trên website GitHub.
- Hướng dẫn kết nối repository local với remote bằng `git remote add origin`.
- Hướng dẫn kiểm tra trạng thái Git, commit các file và push nhánh `main` lên GitHub.

**Kết quả review:** Phân biệt repository local với repository từ xa và thực hiện push sau khi cấu hình remote phù hợp.

### Lần 4. Xác định các lớp tương đương của FR-01

**Thời gian:** Ngày 14/10/2026; giờ cụ thể cần đối chiếu lịch sử ChatGPT.

**Tên công cụ:** ChatGPT.

**Prompt đã sử dụng:**

> Dựa trên đặc tả FR-01 được cung cấp, chỉ xác định input variables, output variables và điều kiện nghiệp vụ. Chưa tạo test case. Với mỗi kết luận, chỉ ra câu trong đặc tả làm căn cứ. Nêu rõ những thông tin chưa được quy định tương tự dựa trên input/output và đặc tả đã phân tích, thực hiện Step 2 Domain Testing. Lập bảng điều kiện, mã EC, mô tả miền Valid và Invalid. Không tự thêm ràng buộc không có trong đặc tả. Tách lớp khi có khả năng được xử lý khác nhau. Trình bày giống slide đã gửi

**Đầu ra AI:**
- Hướng dẫn thực hiện Bước 1 của Domain Testing: xác định biến đầu vào và đầu ra.
- Ban đầu, AI cung cấp bản nháp tiếng Anh gồm các biến họ tên, email, mật khẩu và xác nhận mật khẩu.
- Đề xuất ghi nhận các kết quả đầu ra như kết quả đăng ký, thông báo kiểm tra dữ liệu và chuyển trang sau khi đăng ký thành công.
- Giải thích sự khác biệt giữa biến đầu vào và điều kiện đầu vào.
- Hướng dẫn Bước 2 — Identify Equivalence Classes theo tài liệu Domain Testing.
- Phân chia các điều kiện của FR-01 thành các lớp hợp lệ (Valid) và không hợp lệ (Invalid).
- Đánh mã EC01 đến EC19, bao gồm họ tên, email, độ dài mật khẩu, chữ hoa, chữ thường, chữ số, ký tự đặc biệt và xác nhận mật khẩu.
- Lập bảng các lớp tương đương cho từng điều kiện và bảng tổng hợp các phân hoạch.
- Giải thích việc tách các lớp Invalid để thuận lợi cho kiểm thử từng điều kiện riêng biệt.

**Kết quả review:** Sử dụng bảng EC làm cơ sở cho bước lựa chọn test case. Cần đối chiếu các điều kiện và tập ký tự được chấp nhận với đặc tả chính thức của EShop.

### Lần 5. Lựa chọn test case đại diện cho các lớp tương đương

**Thời gian:** Ngày 14/10/2026; giờ cụ thể cần đối chiếu lịch sử ChatGPT.

**Tên công cụ:** ChatGPT.

**Prompt đã sử dụng:**

> Dựa trên bảng EC đã review, thực hiện Step 3. Chọn bộ test case đại diện, cho biết mỗi TC bao phủ EC nào. Các TC Invalid chỉ nên vi phạm một lớp Invalid tại một thời điểm. Giải thích vì sao tập test được chọn có thể bao phủ các lớp đã xác định.


**Đầu ra AI:**

- Hướng dẫn Bước 3 — Selecting Test Cases.
- Đề xuất bộ test case ban đầu gồm 12 test case cho FR-01.
- TC01 kiểm tra đăng ký với dữ liệu hợp lệ và bao phủ các lớp Valid.
- TC02–TC12 kiểm tra lần lượt các lớp Invalid như họ tên rỗng, email rỗng, email sai định dạng, email trùng lặp, mật khẩu thiếu điều kiện và xác nhận mật khẩu không hợp lệ.
- Trình bày dữ liệu đầu vào, mục đích kiểm thử, lớp EC được bao phủ và kết quả mong đợi.
- Đề xuất cách kiểm tra độ bao phủ của các lớp EC.

**Kết quả review:** Sử dụng bộ 12 test case làm bản thiết kế ban đầu. Các giá trị email và điều kiện môi trường cần được chuẩn bị trước khi thực thi. Kết quả thực tế chưa được xác nhận chỉ từ việc thiết kế test case.

### Lần 6. Áp dụng Boundary Value Analysis cho FR-01

**Thời gian:** Ngày 14/10/2026; giờ cụ thể cần đối chiếu lịch sử ChatGPT.

**Tên công cụ:** ChatGPT.

**Prompt đã sử dụng:**

> Thực hiện Step 4 Boundary Value Analysis trên các miền giá trị có biên được đặc tả. Xác định biên dưới, biên trên nếu có và chọn các giá trị ngay dưới, tại và ngay trên biên. Phân biệt test case thuộc BVA với test case chỉ dùng để kiểm tra lớp tương đương.

**Đầu ra AI:**

- Hướng dẫn tạo file `features/FR-01-registration/bva.md`.
- Xác định giới hạn độ dài mật khẩu tối thiểu là 8 ký tự.
- Thiết kế ba test case kiểm tra các giá trị 7, 8 và 9 ký tự.
- Giải thích cách giữ các điều kiện khác hợp lệ để tập trung kiểm tra riêng biên độ dài.
- Bổ sung bảng ghi nhận kết quả mong đợi, kết quả thực tế, trạng thái và bằng chứng.
- Hướng dẫn commit phần BVA bằng Git.

**Kết quả review:** Bộ test case BVA được xem là bộ thiết kế ban đầu. Cần thực thi trên EShop để xác nhận Pass/Fail và thu thập bằng chứng.

### Lần 7. Tổng hợp AI Audit Report

**Thời gian:** 22:57 ngày 14/10/2026 (UTC+7), theo mốc thời gian của phiên làm việc hiện tại.

**Tên công cụ:** ChatGPT.

**Prompt đã sử dụng:**

> bạn cho tui nội dung ai-audit + time stampe khi mà làm từ nãy đến giờ để tui dán vô

**Đầu ra AI:**

- Tổng hợp nhật ký sử dụng AI theo từng giai đoạn đã thực hiện.
- Ghi nhận prompt, tóm tắt đầu ra AI, kết quả review và các mốc thời gian xác định được.
- Đánh dấu những thời điểm chưa có đủ thông tin để xác minh chính xác, tránh tự tạo timestamp không có căn cứ.

---
### Lần sử dụng 8. Áp dụng Domain Testing và Boundary Value Analysis cho FR-09

**Tên công cụ AI:** ChatGPT (OpenAI)

**Ngày thực hiện:** 14/10/2026

**Thời gian (Timestamp):** Sau 22:57, giờ Việt Nam (UTC+7). Cần đối chiếu lịch sử ChatGPT để xác định chính xác giờ và phút.

**Mục tiêu sử dụng AI:** Hỗ trợ phân tích và thiết kế bộ test case cho FR-09 – Discount Coupons thuộc Pool B (Shopping Cart and Checkout) theo đúng trình tự Domain Testing và Boundary Value Analysis được giảng dạy trong môn Kiểm thử phần mềm.

**Note: Lần này em sử dụng promt tổ hợp đã được sử dụng lúc làm từ FR1
#### 1. Prompt đã sử dụng

**Prompt 1 – Xác định Input/Output và điều kiện nghiệp vụ**

> Dựa trên đặc tả FR-09 được cung cấp, chỉ xác định input variables, output variables và điều kiện nghiệp vụ. Chưa tạo test case. Với mỗi kết luận, chỉ ra câu trong đặc tả làm căn cứ. Nêu rõ những thông tin chưa được quy định.

**Prompt 2 – Xác định các lớp tương đương**

> Dựa trên input/output và đặc tả đã phân tích, thực hiện Step 2 Domain Testing. Lập bảng điều kiện, mã EC, mô tả miền Valid và Invalid. Không tự thêm ràng buộc không có trong đặc tả. Tách lớp khi có khả năng được xử lý khác nhau.

**Prompt 3 – Lựa chọn test case đại diện**

> Dựa trên bảng EC đã review, thực hiện Step 3. Chọn bộ test case đại diện, cho biết mỗi TC bao phủ EC nào. Các TC Invalid chỉ nên vi phạm một lớp Invalid tại một thời điểm. Giải thích vì sao tập test được chọn có thể bao phủ các lớp đã xác định.

**Prompt 4 – Phân tích giá trị biên**

> Thực hiện Step 4 Boundary Value Analysis trên các miền giá trị có biên được đặc tả. Xác định biên dưới, biên trên nếu có và chọn các giá trị ngay dưới, tại và ngay trên biên. Phân biệt test case thuộc BVA với test case chỉ dùng để kiểm tra lớp tương đương. Làm tương tự với FR-09 thuộc Pool 2, đồng thời ghi chú rõ từng phần cần dán vào file nào.

#### 2. Đầu ra của AI

AI đã hỗ trợ xây dựng nội dung cho hai file:

**File 1: `features/FR-09-coupons/domain-testing.md`**

- **Bước 1 – Xác định biến đầu vào và đầu ra:** Xác định mã giảm giá, tổng tiền đơn hàng, trạng thái đăng nhập, trạng thái hoạt động, ngày hết hạn, ngưỡng đơn hàng, loại mã, giá trị giảm và giới hạn lượt sử dụng.
- Xác định năm điều kiện nghiệp vụ: mã tồn tại và đang hoạt động; mã còn hạn; tổng tiền đạt ngưỡng tối thiểu; người dùng có JWT hợp lệ; số lượt đã sử dụng chưa đạt giới hạn.
- Xác định kết quả áp dụng mã, số tiền giảm, số tiền cuối cùng và phản hồi của hệ thống.
- Ghi nhận các thông tin chưa được quy định rõ trong đặc tả, chẳng hạn quy tắc phân biệt chữ hoa/chữ thường của mã, làm tròn số tiền giảm, múi giờ và thời điểm tính lượt sử dụng.
- **Bước 2 – Xác định lớp tương đương:** Xây dựng các lớp EC01–EC12 cho năm điều kiện nghiệp vụ và EC13–EC14 cho hai nhánh tính toán `percent` và `fixed`.
- **Bước 3 – Lựa chọn test case:** Đề xuất 9 test case ban đầu, bao gồm áp dụng mã thành công, mã không tồn tại, mã không hoạt động, mã hết hạn, đơn hàng chưa đạt ngưỡng, JWT không hợp lệ và trường hợp đã sử dụng hết lượt.
- Kiểm tra khả năng bao phủ các lớp tương đương và yêu cầu mỗi test case Invalid chỉ vi phạm một điều kiện tại một thời điểm.

**File 2: `features/FR-09-coupons/bva.md`**

- **Bước 4 – Boundary Value Analysis:** Xác định ba nhóm biên có thể kiểm tra là ngưỡng đơn hàng tối thiểu, hạn sử dụng và giới hạn lượt dùng.
- Đề xuất 9 test case BVA, sử dụng các giá trị ngay dưới, tại và ngay trên từng biên.
- Bổ sung bảng kết quả mong đợi, kết quả thực tế, trạng thái và bằng chứng.
- Phân biệt các điều kiện đã được kiểm tra bằng lớp tương đương với các điều kiện có thể kiểm tra thông qua giá trị biên.
- Hướng dẫn lưu file và tạo Git commit riêng cho Domain Testing và BVA.

#### 3. Kết quả review của sinh viên

Đầu ra AI được sử dụng làm bản thiết kế ban đầu, chưa được xem là bộ test case đã xác nhận đúng hoàn toàn hoặc đã thực thi thành công.

Các nội dung cần kiểm tra lại gồm:

1. Đối chiếu từng điều kiện nghiệp vụ với đặc tả FR-09 trong SRS chính thức.
2. Xác minh dữ liệu của các mã `SAVE10`, `BIGBUY`, `VIP100` và `EXPIRED` trong môi trường kiểm thử.
3. Kiểm tra trạng thái hoạt động, ngày hết hạn, ngưỡng đơn hàng và giới hạn lượt sử dụng thực tế của từng mã trước khi chạy test.
4. Xác nhận cách hệ thống xử lý ngày hết hạn, đơn vị tiền tệ và số lượt đã sử dụng.
5. Chỉ ghi nhận Pass hoặc Fail sau khi thực thi và so sánh kết quả thực tế với kết quả mong đợi.
6. Ghi nhận bằng chứng và tạo GitHub Issue nếu xác minh được lỗi của hệ thống.

#### 4. Đánh giá sơ bộ việc sử dụng AI

AI hỗ trợ tổ chức quy trình kiểm thử theo từng bước, giảm công sức lập bảng phân hoạch và lựa chọn các giá trị đại diện. Tuy nhiên, kết quả vẫn phụ thuộc vào tính đầy đủ của đặc tả và dữ liệu kiểm thử.

Sinh viên cần chủ động xác minh các giả định, rà soát độ bao phủ của EC, kiểm tra các điều kiện biên và thực thi trên ứng dụng thực tế. Những thông tin chưa được quy định trong SRS không được tự động xem là yêu cầu bắt buộc của hệ thống.

**Trạng thái công việc:** Đã thiết kế bản nháp Domain Testing và BVA cho FR-09; kết quả thực thi và bằng chứng cần được cập nhật sau khi kiểm thử ứng dụng EShop.


## 3. Tổng kết việc sử dụng AI

AI được sử dụng để hỗ trợ tổ chức repository và thực hiện các bước đầu tiên của kỹ thuật Domain Testing và Boundary Value Analysis cho FR-01.

Các đầu ra chính gồm:

1. Cấu trúc thư mục và file phục vụ bài tập HW02.
2. Phân tích biến đầu vào và đầu ra của FR-01.
3. Bảng phân lớp tương đương EC01–EC19.
4. Bộ test case ban đầu gồm TC01–TC12.
5. Bộ test case BVA kiểm tra mật khẩu có độ dài 7, 8 và 9 ký tự.
6. Hướng dẫn tổ chức Git commit cho từng bước.

Các đầu ra trên mới phản ánh giai đoạn phân tích và thiết kế ban đầu. Việc đánh giá tính đúng đắn cuối cùng cần dựa trên đặc tả chính thức, kết quả thực thi thực tế, các bằng chứng thu thập được và phần review của sinh viên.

**Ghi chú về tính đầy đủ của nhật ký:** Các đầu ra trong báo cáo này được tóm tắt từ lịch sử hội thoại, không phải bản sao nguyên văn toàn bộ phản hồi AI. Những mốc giờ riêng lẻ chưa xác minh cần được đối chiếu với lịch sử trò chuyện trước khi nộp báo cáo.
