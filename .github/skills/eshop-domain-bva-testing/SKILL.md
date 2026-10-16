---
name: eshop-domain-bva-testing
description: "Phân tích yêu cầu EShop bằng Domain Testing và Boundary Value Analysis (BVA), lập lớp tương đương, test case có truy vết và kiểm tra độ bao phủ bằng tiếng Việt. Dùng khi người dùng yêu cầu phân tích, thiết kế, rà soát hoặc cập nhật test plan Domain Testing/BVA cho một feature."
---

# EShop Domain Testing và BVA

Hướng dẫn này tạo ra bản phân tích và thiết kế kiểm thử có thể kiểm chứng theo tài liệu đầu vào. Dùng được cho nhiều feature EShop; không mặc định quy tắc của FR-01 áp dụng cho feature khác.

## Khi sử dụng

Kích hoạt khi cần phân tích đặc tả nghiệp vụ, phân hoạch lớp tương đương, lập test case Domain Testing, thiết kế BVA, hoặc rà soát độ bao phủ và truy vết của các tài liệu đó.

## Quy tắc bắt buộc

- Đọc và trích dẫn đặc tả được cung cấp. Với mỗi điều kiện, lớp tương đương, biên và expected result, ghi mã yêu cầu hoặc trích đoạn ngắn cùng tên tài liệu và mục/heading (hoặc trang/dòng nếu có).
- Không biến nội dung của test plan, ghi chú, code, hay hành vi quan sát được thành yêu cầu đặc tả nếu không có căn cứ. Nêu rõ loại nguồn đang dùng.
- Không tự tạo giới hạn, quy tắc nghiệp vụ, thông báo lỗi, trạng thái hoặc đầu ra chưa được quy định. Đánh dấu `Chưa xác định` và đặt câu hỏi/ghi chú để người dùng xác nhận.
- Phân biệt `Chưa xác định` (đặc tả thiếu thông tin) với `Invalid` (đặc tả quy định giá trị không hợp lệ). Không tự gán giá trị chưa biết vào lớp Invalid.
- Đánh dấu giả định rõ ràng, nêu lý do và tác động; không trình bày giả định như yêu cầu.
- Với test case Invalid, chỉ vi phạm một lớp Invalid mỗi lần; giữ điều kiện còn lại hợp lệ. Nếu không thể cô lập, giải thích vì sao.
- Không tuyên bố test đã chạy, PASS/FAIL, có evidence, hoặc đã nạp Skill nếu điều đó chưa được quan sát và xác minh. Expected result là kết quả thiết kế, không phải actual result.
- Domain Testing và BVA là hai phân tích riêng. Lớp tương đương là các phân vùng theo hành vi; không xem mỗi lớp rời rạc (ví dụ trạng thái) là biên số học.
- Trả lời bằng tiếng Việt, ở định dạng Markdown có thể lưu thành tài liệu HW02.

## Quy trình Domain Testing

### 1. Xác định phạm vi và nguồn

1. Đọc đặc tả nghiệp vụ liên quan, xác định feature, actor, luồng chính, điều kiện trước/sau và nội dung ngoài phạm vi.
2. Liệt kê các nguồn đã đọc, phiên bản/ngày nếu có, các mục liên quan và thứ tự ưu tiên khi chúng mâu thuẫn.
3. Nếu chỉ có tài liệu phân tích thứ cấp mà thiếu đặc tả gốc, tiếp tục ở mức bản nháp có điều kiện; nêu rõ giới hạn và các quy tắc cần xác nhận.

### 2. Trích xuất yêu cầu và biến

Lập danh sách yêu cầu có mã tạm ổn định (ví dụ `REQ-01`, không thay mã gốc nếu tài liệu đã có). Trích xuất:

- điều kiện đầu vào và quy tắc nghiệp vụ;
- biến đầu vào, kiểu/miền được đặc tả và quan hệ giữa các biến;
- biến/kết quả đầu ra, chuyển trạng thái, thông báo hoặc hành vi mong đợi;
- tiền điều kiện, dữ liệu/tài nguyên phụ thuộc và các điều kiện ảnh hưởng đến xử lý;
- điều kiện chưa xác định, mâu thuẫn, hoặc không thể kiểm thử với thông tin hiện có.

Không suy luận rằng mọi trường bắt buộc, thông báo cụ thể, định dạng hoặc trạng thái đều tồn tại nếu tài liệu không nói vậy.

### 3. Phân hoạch tương đương

1. Xác định điều kiện quyết định hành vi; phân hoạch từng miền thành các lớp hợp lệ và không hợp lệ có căn cứ.
2. Mỗi lớp phải mô tả rõ giá trị/điều kiện thuộc lớp và lý do các giá trị trong lớp được kỳ vọng được xử lý tương đương.
3. Trích dẫn yêu cầu cụ thể cho cả lớp Valid lẫn Invalid. Chỉ lập lớp Invalid khi có điều kiện bị vi phạm được quy định.
4. Tách các lớp nếu có thể tạo kết quả xử lý khác nhau, chẳng hạn thiếu dữ liệu và sai định dạng khi đặc tả phân biệt chúng.
5. Ghi riêng các phân vùng chưa xác định thay vì đoán hoặc tạo lớp Invalid.

### 4. Chọn test case và dữ liệu

1. Chọn giá trị đại diện để bao phủ lớp; kết hợp các lớp Valid tương thích nếu thích hợp.
2. Với từng test Invalid, chỉ thay đổi điều kiện của lớp Invalid đang kiểm tra; giữ các điều kiện khác Valid. Ghi tiền điều kiện như tài khoản/email đã tồn tại khi cần.
3. Với mỗi test case, ghi ID duy nhất, mục tiêu, tiền điều kiện, dữ liệu, bước thực hiện và expected result có căn cứ.
4. Không đưa test design thành test execution. Chỉ thêm actual result, status hoặc evidence nếu người dùng cung cấp/đã thực hiện và nguồn được xác minh.

### 5. Kiểm tra bao phủ và rà soát

Tạo ánh xạ `Requirement -> condition/partition -> test case`. Mỗi lớp phải được bao phủ bởi ít nhất một test case, hoặc có lý do và trạng thái rõ ràng (ví dụ thiếu tài khoản test, không có môi trường, chưa xác định). Kiểm tra:

- mọi lớp Valid/Invalid và điều kiện đầu vào đều được tính đến;
- mỗi test Invalid cô lập một lớp và các điều kiện khác được giữ hợp lệ;
- ID không trùng, lớp không bị bỏ sót/ánh xạ sai;
- expected result có trích dẫn, không chứa hành vi ngoài đặc tả;
- các trường hợp trùng lặp, phụ thuộc môi trường, giả định và câu hỏi mở được nêu.

## Quy trình BVA riêng biệt

1. Tìm miền dữ liệu và giới hạn tường minh trong đặc tả (minimum, maximum, khoảng, số lượng, thời điểm hoặc giới hạn khác). Ghi chính xác yêu cầu làm căn cứ.
2. Không tự bịa biên, kiểu dữ liệu, độ chính xác, đơn vị hoặc hành vi tại biên. Nếu không có giới hạn tường minh, ghi `Chưa đủ căn cứ để thiết kế BVA chính thức` cho miền đó.
3. Với biên có căn cứ, xác định giá trị ngay dưới, tại và ngay trên biên khi miền và kỹ thuật cho phép. Với khoảng có hai biên, xem xét các giá trị lân cận cả hai đầu. Dùng đơn vị/lân cận hợp lệ theo đặc tả; nếu chưa xác định, hỏi người dùng thay vì tự chọn.
4. Cô lập biên đang thử: giữ các trường/điều kiện khác hợp lệ và cố định; kiểm tra tiền điều kiện/dữ liệu có thể ảnh hưởng.
5. Với mỗi test case BVA ghi ID, miền/đơn vị, biên và giá trị, dữ liệu liên quan, expected result, căn cứ yêu cầu và các giả định.
6. Đối chiếu từng điểm dưới/tại/trên biên với yêu cầu gốc. Expected result ở biên là kết quả thiết kế, không phải kết quả chạy.
7. Giữ BVA tách với Domain Testing. Ví dụ các trạng thái rời rạc cần phân lớp theo hành vi; không tự coi chúng là giá trị biên số học.

## Định dạng đầu ra đề nghị

Tạo tài liệu Markdown với các phần sau, tùy phần nào phù hợp:

1. Phạm vi, nguồn/căn cứ và giới hạn.
2. Yêu cầu, điều kiện, biến đầu vào/đầu ra, hành vi mong đợi, câu hỏi mở.
3. Bảng Domain Testing: `Điều kiện/Yêu cầu | Biến/miền | Lớp ID | Mô tả lớp | Valid/Invalid/Chưa xác định | Căn cứ`.
4. Test case Domain Testing: `TC ID | Mục tiêu/lớp bao phủ | Tiền điều kiện | Dữ liệu | Bước thực hiện | Expected result | Căn cứ`.
5. Bảng truy vết/độ bao phủ và các lớp chưa được kiểm thử, kèm lý do.
6. Bảng BVA độc lập: `BVA ID | Yêu cầu/miền | Biên | Giá trị | Dữ liệu/điều kiện giữ cố định | Expected result | Căn cứ`.
7. Các giả định, mâu thuẫn, câu hỏi cần xác nhận và kiểm tra chất lượng cuối.

Nếu mẫu HW02 hiện có yêu cầu cột/tên mã khác, giữ mẫu hiện hành nhưng đảm bảo các thông tin nêu trên vẫn có thể đối chiếu.

## Hoàn tất

Trước khi trả kết quả, rà lại từng dòng theo nguồn gốc. Nêu rõ nội dung nào còn chờ xác nhận, những gì chưa thể kiểm thử, và các điểm cần con người review. Khi người dùng yêu cầu lưu file, tạo đầu ra mới hoặc chỉ sửa đúng tài liệu được chỉ định; không ghi đè execution results hay evidence ngoài phạm vi.
