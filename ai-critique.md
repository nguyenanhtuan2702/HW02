# AI Critique — HW02 Domain Testing

## 1. Phạm vi đánh giá

Phần đánh giá này dựa trên các tài liệu Domain Testing/BVA, kết quả kiểm thử, evidence, bug reports, `ai-audit.md`, `ai-gap-analysis.md` và lượt review FR-01 bằng Skill. SRS trong [`eshop-sut/README.md`](../eshop-sut/README.md) được dùng làm nguồn yêu cầu chính; [`eshop-sut/api_specification.md`](../eshop-sut/api_specification.md) chỉ dùng để đối chiếu phạm vi API.

Nhật ký AI hiện có là bản tóm tắt một số phiên, không phải transcript đầy đủ. Có thể đánh giá những đầu ra và vấn đề được ghi lại cho FR-01/FR-09, nhưng không đủ căn cứ để quy mọi nội dung trong test design FR-17/FR-11 cho AI ban đầu. Tương tự, phần ghi nhận về automation tập trung chủ yếu vào việc bổ sung screenshot, cấu hình capture và chạy lại test để hoàn thiện evidence; lịch sử hiện có không đủ để tái dựng toàn bộ quá trình AI viết và debug script auto test từ đầu. Khi rà soát, mã automation cũng không còn được tìm thấy trong hai workspace đã nêu ở audit. Vì vậy, phần critique này không kết luận về chất lượng toàn bộ mã automation ban đầu mà chỉ đánh giá những kết quả và artifacts còn có căn cứ.

## 2. Điểm hữu ích của AI

- AI giúp tổ chức Domain Testing theo trình tự rõ ràng: xác định biến và điều kiện, chia lớp tương đương, chọn ca đại diện, rồi lập bảng truy vết. Các test case có ID, dữ liệu và expected result nên thuận tiện đối chiếu giữa thiết kế và kết quả chạy.
- Phân tích BVA đã tập trung vào giới hạn có căn cứ trong SRS. Ví dụ, FR-01 dùng các mật khẩu 7/8/9 ký tự quanh giới hạn tối thiểu 8; FR-09 kiểm tra ngưỡng đơn hàng, hạn sử dụng và số lượt; FR-17 kiểm tra các ngưỡng `discount_value`, `min_order_amount` và `max_uses_per_user`. Với FR-11, tài liệu ghi BVA là N/A thay vì tự đặt giới hạn chưa có trong đặc tả.
- Các test Invalid thường giữ những điều kiện còn lại hợp lệ, giúp cô lập nguyên nhân. Bộ test đã phát hiện nhiều sai lệch thực tế, gồm lỗi tính giảm giá phần trăm và lỗi kiểm tra dữ liệu ở API.
- AI hỗ trợ tạo Skill dùng lại cho nhiều feature và chuẩn bị tài liệu hướng dẫn/demo. Skill nhấn mạnh truy vết yêu cầu, không biến thông tin chưa xác định thành Invalid, tách Domain Testing khỏi BVA và không trình bày thiết kế như kết quả thực thi.
- Việc tổng hợp kết quả và evidence giúp nối test case với JSON, trace và screenshot. Các bug reports nhóm nhiều ca FAIL có cùng hành vi thành 10 báo cáo theo nguyên nhân, thay vì coi 27 ca FAIL là 27 lỗi độc lập; các ca BLOCKED/NOT AUTOMATED được giữ riêng.

## 3. Điểm chưa chính xác hoặc chưa đầy đủ

- **Expected result FR-01 có chỗ vượt quá SRS.** Test design cũ nêu các thông báo cụ thể như họ tên bắt buộc, email đã được sử dụng hoặc hai mật khẩu không khớp. SRS quy định điều kiện nghiệp vụ nhưng không quy định câu chữ thông báo. Ngoài ra, thiết kế cũ tách xác nhận mật khẩu rỗng và không khớp thành hai lớp hành vi, dù SRS chỉ yêu cầu từ chối khi hai trường không khớp và không nói hai trường hợp được xử lý khác nhau. Đây là các điểm cần hiệu chỉnh; do thiếu transcript đầy đủ, không thể khẳng định riêng câu chữ hoặc cách phân lớp nào do AI tạo ra.
- **Oracle của FR-01 chưa đồng bộ hoàn toàn với kết quả.** TC02/TC03 có expected result nói thông báo trường bắt buộc, trong khi actual result ghi thông báo native của trình duyệt bằng tiếng Anh; trạng thái vẫn được ghi PASS. Cần xác định test đang đánh giá việc submit bị chặn hay nội dung thông báo cụ thể. SRS không yêu cầu chính xác câu thông báo đó.
- **FR-09 có một phần kiểm tra lặp.** TC09-09 và BVA-FR09-02 đều kiểm tra `BIGBUY` tại đúng ngưỡng 500.000 ₫ và cùng phát hiện bị từ chối sai. Việc lặp lại có thể củng cố kết quả, nhưng nên ghi rõ một ca kiểm tra nhánh tính toán/Domain Testing, ca còn lại kiểm tra biên để tránh đếm thành hai lỗi.
- **Một số kết quả PASS chỉ xác nhận giao diện, chưa xác nhận API.** Ở FR-17, TC17-03, TC17-09 và BVA-FR17-10 bị trình duyệt chặn trước khi gửi request. Điều đó xác nhận native form validation tại UI, nhưng chưa cho biết API xử lý trực tiếp dữ liệu thiếu hoặc không hợp lệ như thế nào. Tương tự, FR-01 có chênh lệch giữa form đăng ký và API specification về trường xác nhận mật khẩu; cần xác định rõ bề mặt kiểm thử trước khi kết luận phạm vi API.
- **Độ chắc chắn của kết luận bị giới hạn bởi lịch sử và môi trường.** Các báo cáo lỗi dựa trên những execution đã lưu và chưa được tái hiện độc lập. FR-11 TC04–TC08 vẫn BLOCKED vì thiếu tài khoản/fixture phù hợp; đây không phải bằng chứng lỗi ứng dụng. Không có prompt và output ban đầu đủ để đánh giá attribution cho FR-17/FR-11.
- **Chưa thể critique đầy đủ quá trình viết auto test ban đầu.** Nhật ký còn ghi nhận việc Copilot điều chỉnh cơ chế chụp screenshot/cấu hình và chạy lại 31 UI test để bổ sung evidence; cả 31 được báo cáo PASS trong execution tương ứng. Tuy nhiên, transcript của session viết và debug automation ban đầu không còn đầy đủ để đối chiếu prompt, các phiên bản script và quyết định triển khai. Audit gần nhất cũng ghi nhận mã automation hiện không tìm thấy trong `D:\eshop-sut` hoặc `D:\HW02`. Vì vậy, có thể nhận xét về kết quả chạy và evidence còn lưu, nhưng chưa đủ căn cứ để khẳng định AI đã viết phần mã nào, chất lượng script ban đầu ra sao hoặc toàn bộ quá trình debug diễn ra thế nào. Đây là giới hạn truy vết, không tự động đồng nghĩa với lỗi của AI.

Các giới hạn trên không phủ nhận những lỗi ứng dụng có evidence. Chẳng hạn, FR-09 ghi nhận giảm phần trăm sai và chấp nhận yêu cầu không có JWT; FR-17 ghi nhận API chấp nhận một số giá trị vi phạm SRS. Chúng cho thấy test design đã tìm được lỗi, đồng thời việc diễn giải kết quả vẫn cần review của người kiểm thử.

## 4. Việc con người đã kiểm tra và điều chỉnh

- Đối chiếu điều kiện và expected result với SRS gốc, đồng thời tách yêu cầu nghiệp vụ khỏi ví dụ request/response trong API specification.
- Kiểm tra actual result cùng JSON, trace và screenshot; ví dụ, kết luận TC09-06 thiếu JWT dựa trên trace của request, không dựa riêng vào screenshot giao diện đang đăng nhập.
- Trong bản review FR-01 bằng Skill, bỏ các thông báo lỗi chưa có căn cứ khỏi expected result, gộp trường hợp xác nhận rỗng/không khớp thành một lớp hành vi và giữ chúng như hai biến thể test. Bản review là tài liệu minh họa mới; test plan và execution gốc chưa được sửa.
- Nhóm các ca FAIL theo hành vi/nguyên nhân, giữ riêng những lỗi khác nhau xuất hiện trong cùng một test case, và không tạo bug từ các ca BLOCKED hoặc NOT AUTOMATED.
- Phân biệt evidence của execution gốc với lần bổ sung; ảnh bổ sung không được dùng để thay đổi trạng thái lịch sử. Các ca API-only dùng JSON/trace thay vì ảnh trình duyệt không phù hợp.
- Ghi rõ giới hạn attribution trong AI Gap Analysis: FR-17/FR-11 không có prompt/output ban đầu được lưu đủ để kết luận AI đã bỏ sót hay tạo ra vấn đề nào.

Các đối chiếu và giới hạn này được ghi thêm trong [`ai-gap-analysis.md`](./ai-gap-analysis.md), [`agent-skills/demo/FR-01-domain-bva-analysis.md`](./agent-skills/demo/FR-01-domain-bva-analysis.md) và [`bug-reports/README.md`](./bug-reports/README.md). Các tài liệu test plan/execution gốc được giữ nguyên trong lượt review Skill.

## 5. Cách cải thiện việc sử dụng AI

1. Cung cấp SRS gốc, phiên bản và phạm vi feature ngay từ đầu; nêu thứ tự ưu tiên giữa SRS, API specification, test plan cũ và hành vi quan sát được.
2. Yêu cầu AI gắn căn cứ vào từng điều kiện, lớp tương đương, biên và expected result. Mục nào chưa được đặc tả phải ghi `Chưa xác định`, kèm câu hỏi cần xác nhận, thay vì tự điền thông báo hoặc quy tắc.
3. Nêu rõ mỗi test nhắm đến UI, API hay ứng dụng mobile. Với từng bề mặt, xác định dữ liệu nào được gửi, điều gì được quan sát và assertion nào đủ để đánh dấu PASS/FAIL.
4. Yêu cầu AI tách test design khỏi execution. Chỉ ghi actual result, trạng thái và bug khi có log/evidence tương ứng; không để trạng thái PASS che khuất expected result chưa khớp actual.
5. Dùng dữ liệu kiểm thử có thể tái tạo, tiền điều kiện cụ thể và ca đối chứng quanh biên. Khi các ca trùng mục tiêu, ghi vai trò riêng của từng ca và nhóm theo nguyên nhân để thống kê không đếm trùng.
6. Lưu prompt, output quan trọng, timestamp và các chỉnh sửa của người học cùng phiên bản/tên file. Với automation, cần lưu cả script, cấu hình, lệnh chạy, report, trace và liên kết tới execution tương ứng; nên commit theo các mốc phù hợp để có thể truy lại phiên bản đã chạy. Đây là điều kiện để đánh giá chính xác đóng góp của AI ở các feature sau.
7. Khi tổng kết một session Copilot, cập nhật AI Audit ngay khi lịch sử còn truy cập được và ghi rõ nội dung nào không thể xác minh. Không dựng lại prompt hoặc lịch sử debug từ kết quả cuối cùng nếu không có bằng chứng.
8. Giữ review cuối cùng ở con người: kiểm tra căn cứ SRS, đường dẫn evidence, phạm vi dữ liệu, các ca bị chặn và mức độ chắc chắn của kết luận trước khi nộp hoặc đăng issue.

## Kết luận

AI hữu ích trong việc tạo cấu trúc phân tích, đề xuất lớp và biên có truy vết, và hỗ trợ tổng hợp test/evidence. Chất lượng đầu ra tốt hơn khi có SRS rõ, phạm vi UI/API cụ thể và quy tắc không suy diễn. Trong HW02, review của con người đã phát hiện expected result vượt quá SRS, phân biệt validation giao diện với validation API, xác minh các lỗi bằng evidence và ghi rõ những phần chưa thể kết luận. Riêng với auto test, evidence và kết quả chạy còn lại cho phép đánh giá một phần công việc, nhưng lịch sử không đầy đủ và việc thiếu script trong workspace hiện tại khiến chưa thể đánh giá toàn diện quá trình AI viết/debug ban đầu. Các artifact hiện có cho thấy AI hỗ trợ quá trình kiểm thử; chúng không thay thế việc xác nhận yêu cầu, mã kiểm thử và kết quả của người kiểm thử.
