# FR-01 — Kiểm chứng lượt sử dụng Skill

## 1. Skill được gọi và bằng chứng

- **Skill:** `eshop-domain-bva-testing`.
- **Cách gọi:** Người dùng yêu cầu rõ `/eshop-domain-bva-testing`; nội dung hướng dẫn Skill được cung cấp trong phiên dưới `skill-context` cho nhiệm vụ này.
- **Bằng chứng quan sát được trong phiên:** Có chỉ thị và toàn bộ hướng dẫn Skill gắn với phiên làm việc; đường dẫn `D:\HW02\.github\skills\eshop-domain-bva-testing\SKILL.md` đã được xác nhận tồn tại và đọc (98 dòng; các phần cuối được đọc bằng range tiếp nối). Quy trình Domain Testing/BVA trong file đó được áp dụng trong tài liệu phân tích đi kèm.
- Đây là lượt phân tích/thiết kế tài liệu. Không khẳng định Skill đã chạy test, gọi API hay có kết quả thực thi mới.

## 2. Các file đã đọc

| Đường dẫn | Nội dung dùng trong lượt này |
|---|---|
| `D:\HW02\.github\skills\eshop-domain-bva-testing\SKILL.md` | Quy tắc nguồn, phân hoạch, BVA, traceability, test design và kiểm tra chất lượng. |
| `D:\eshop-sut\README.md` | Đặc tả gốc SRS, FR-01 và FR-22. |
| `D:\eshop-sut\api_specification.md` | API registration, request mẫu và response thành công mục 1.1. |
| `D:\HW02\FR-01-registration\domain-testing.md` | Phân hoạch và test case Domain Testing hiện hành để đối chiếu. |
| `D:\HW02\FR-01-registration\bva.md` | Biên và test case BVA hiện hành để đối chiếu. |
| `D:\HW02\FR-01-registration\execution-results.md` | Kết quả/evidence được ghi từ các lần chạy trước; chỉ đọc, không xác minh hoặc sửa trong lượt này. |

## 3. File được kiểm tra nhưng không tồn tại trong working tree trước khi tạo

- `D:\HW02\agent-skills\demo\FR-01-domain-bva-analysis.md`
- `D:\HW02\agent-skills\demo\FR-01-skill-validation.md`

Đã kiểm tra bằng thao tác đọc/kiểm tra đường dẫn; cả hai đều không tồn tại lúc bắt đầu. Vì vậy không có nội dung demo hiện hữu trong working tree để đọc hay giữ lại. Trạng thái Git ban đầu thể hiện hai đường dẫn này là deleted; theo yêu cầu tạo đúng hai file demo, chúng được tạo lại với phân tích mới. Các thay đổi Git khác có sẵn không thuộc phạm vi và không được chạm tới.

## 4. Tóm tắt quy trình Skill đã thực hiện

1. Xác nhận `D:\eshop-sut`, `D:\HW02` và file Skill tồn tại; đọc hướng dẫn Skill.
2. Đọc SRS FR-01/FR-22 và mục API đăng ký; ghi rõ nguồn nghiệp vụ, nguồn giao diện và phần API không được đặc tả.
3. Lập requirement traceability, biến đầu vào, lớp tương đương Valid/Invalid, test đại diện và coverage.
4. Phân tích BVA riêng cho biên dưới 8 ký tự, chọn điểm 7/8/9 và giữ các điều kiện khác hợp lệ.
5. Đối chiếu test plan Domain/BVA và execution record hiện hành; không dùng tài liệu thứ cấp thay cho đặc tả.
6. Tạo hai file demo được yêu cầu; không sửa source code, tài liệu gốc, execution result hay evidence.

## 5. Đối chiếu tài liệu mới với các tài liệu HW02

Tài liệu mới: [`FR-01-domain-bva-analysis.md`](./FR-01-domain-bva-analysis.md), phần 7.

| Tài liệu | Điểm trùng khớp | Thiếu/điểm cần xem xét trong tài liệu cũ | Nhận xét/căn cứ |
|---|---|---|---|
| [`domain-testing.md`](../../FR-01-registration/domain-testing.md) | Nhận diện đúng name/email/password/confirmation; lớp format/unique email và các thành phần mật khẩu; các test Invalid được thiết kế tách điều kiện. | Tách riêng confirmation rỗng như một Invalid có xử lý riêng khi SRS chỉ nêu field và từ chối khi không khớp; expected error cụ thể chưa có căn cứ; chưa bao quát rõ API success và GUI FR-22. | SRS `README.md`, FR-01 dòng 32–36 và FR-22 dòng 252–255. Thiết kế mới gom confirmation theo quan hệ match/mismatch, nêu phần rỗng cần xác nhận; thêm test giao diện/API có căn cứ. |
| [`bva.md`](../../FR-01-registration/bva.md) | Chọn đúng biên mật khẩu tối thiểu 8 ký tự và ba giá trị 7, 8, 9; dữ liệu mẫu có các thành phần mật khẩu cần thiết; tài liệu phân biệt kết quả theo điều kiện độ dài. | Không tìm thấy thiếu sót về lựa chọn điểm BVA trong thiết kế hiện có. Cần giữ rõ expected tại 8/9 chỉ khẳng định điều kiện độ dài, không phải actual/pass. | SRS `README.md`, FR-01 dòng 34; bva.md dòng 17, 42–44. Phân tích mới giữ 7/8/9 và bổ sung traceability/unit/điều kiện giữ cố định. |
| [`execution-results.md`](../../FR-01-registration/execution-results.md) | Lịch sử có TC01–TC12 và BVA-01–03 cùng actual/evidence; ghi rõ trường confirmation chưa có trong UI/API theo các quan sát lịch sử. | TC04–TC10 được ghi là API registration thành công với input vốn nhắm tới lớp Invalid; BVA-02/03 được ghi FAIL. Cần người review lại test layer, dữ liệu, kết quả/evidence và ý nghĩa so với SRS. | Đây là nội dung execution lịch sử, không phải yêu cầu và không được chạy lại hay chỉnh sửa trong nhiệm vụ này. API spec mục 1.1 chỉ mô tả request/response thành công, không quy định response validation lỗi. |

Các nhận xét trong cột “thiếu/điểm cần xem xét” là **đối chiếu của Agent** dựa trên nội dung đã đọc; chúng không được trình bày như yêu cầu do Skill hay SRS sinh ra. Phân tích thiết kế mới được lưu riêng, không sửa các file đối chiếu.

## 6. Kiểm tra đầu ra

| Đầu ra | Kết quả |
|---|---|
| `agent-skills/demo/FR-01-domain-bva-analysis.md` | Đã tạo: phạm vi/nguồn, requirement traceability, miền/lớp tương đương, test case, coverage, BVA, điểm chưa rõ và so sánh tài liệu cũ. |
| `agent-skills/demo/FR-01-skill-validation.md` | Đã tạo: bằng chứng Skill, danh sách file, quy trình, đối chiếu, giới hạn và kết luận. |

Các liên kết Markdown tới tài liệu trong repository HW02 dùng đường dẫn tương đối. Các đường dẫn EShop ở ổ `D:` được ghi rõ dạng Windows inline code vì nằm ngoài repository HW02. Hai đường dẫn demo được xác minh trước khi tạo; cần kiểm tra lại sự tồn tại và target của liên kết sau khi lưu file.

## 7. Giới hạn và việc không thực hiện

- Không chạy test, không gọi API, không khởi chạy ứng dụng và không xác minh lại evidence của lần chạy lịch sử.
- Không sửa `domain-testing.md`, `bva.md`, `execution-results.md`, source EShop, database hoặc evidence.
- Không tạo yêu cầu mới cho email grammar, giới hạn tối đa, password Unicode, phản hồi lỗi API hay thông báo lỗi cụ thể.
- Hai file demo vắng mặt trong working tree khi bắt đầu; không có lịch sử nội dung working-tree để giữ lại. Không khôi phục nội dung cũ ngoài yêu cầu tạo lại đúng hai file này.

## 8. Kết luận

**Skill `eshop-domain-bva-testing` đã được người dùng gọi thực tế trong phiên và hướng dẫn của Skill đã được nạp/đọc, áp dụng cho phân tích FR-01.** Hai tài liệu được yêu cầu đã được tạo. Phần Domain Testing và BVA đã hoàn thành ở mức thiết kế có truy vết; chưa thực thi test case và không có kết quả Pass/Fail mới.
