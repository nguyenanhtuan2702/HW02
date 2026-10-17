# Agent Skill: EShop Domain Testing và BVA

## Tên và mục tiêu

- **Tên:** `eshop-domain-bva-testing`
- **Mục tiêu:** Hướng dẫn GitHub Copilot Agent phân tích yêu cầu nhiều feature EShop theo Domain Testing và Boundary Value Analysis (BVA), tạo test plan bằng tiếng Việt có truy vết tới đặc tả và kiểm tra độ bao phủ.
- **Skill chuẩn dùng trong workspace:** [`SKILL.md`](../.github/skills/eshop-domain-bva-testing/SKILL.md). Đây là bản duy nhất; tài liệu nộp bài này không sao chép nội dung Skill để tránh lệch phiên bản.

## Cấu trúc file

```text
.github/
└── skills/
    └── eshop-domain-bva-testing/
        └── SKILL.md                  # Skill được Copilot phát hiện trong workspace
agent-skills/
├── README.md                         # Tài liệu hướng dẫn và mô tả để nộp HW02
├── demo-plan.md                      # Kịch bản thực hiện demo/video trên FR-01
└── demo/
    ├── HW02_DEMO.mp4                 # Video demo Agent Skill
    ├── FR-01-domain-bva-analysis.md  # Đầu ra minh họa mới; không phải kết quả thực thi
    └── FR-01-skill-validation.md     # Ghi nhận kiểm tra Skill; không phải kết quả thực thi
```

## Khi nào sử dụng

Dùng Skill khi cần đọc đặc tả một feature và:

- trích xuất yêu cầu, điều kiện, biến đầu vào/đầu ra và hành vi;
- phân hoạch lớp tương đương Valid/Invalid;
- thiết kế test case đại diện và kiểm tra bao phủ;
- xác định các miền có giới hạn được đặc tả, lập BVA quanh biên;
- rà soát test plan hoặc tạo tài liệu Markdown theo cấu trúc HW02.

## Cách gọi trong Copilot Agent mode

Mở workspace HW02 trong VS Code, mở Copilot Chat, chọn **Agent**, rồi nhập `/eshop-domain-bva-testing` (hoặc chọn Skill cùng tên trong danh sách gợi ý). Có thể gọi trực tiếp bằng yêu cầu:

```text
/eshop-domain-bva-testing
Đọc FR-01-registration/domain-testing.md và bva.md. Phân tích Domain Testing,
sau đó phân tích BVA riêng cho điều kiện mật khẩu tối thiểu 8 ký tự nếu được
xác nhận trong đặc tả. Đưa căn cứ cho từng kết luận, đánh dấu nội dung cần
đối chiếu với đặc tả gốc và lưu kết quả mới vào agent-skills/demo/.
Không sửa test plan, execution results hay evidence hiện có.
```

Nếu Skill chưa hiện trong danh sách, xác nhận workspace đang mở đúng thư mục gốc, đường dẫn chính xác là `.github/skills/eshop-domain-bva-testing/SKILL.md`, tên trong frontmatter khớp tên thư mục; sau đó refresh/reopen workspace hoặc bắt đầu phiên Agent mới để Copilot quét lại. Có thể gọi tên Skill trong prompt để yêu cầu Copilot nạp file, nhưng nên kiểm tra agent đã đọc file Skill trước khi dựa vào hướng dẫn.

## Đầu vào người dùng cần cung cấp

- Đặc tả nghiệp vụ/SRS chính thức và feature/luồng cần phân tích.
- Tài liệu liên quan, quy tắc ngoài đặc tả nếu được phép sử dụng, và thứ tự ưu tiên khi nguồn mâu thuẫn.
- Phạm vi, định dạng/mẫu HW02, ngôn ngữ và vị trí lưu kết quả.
- Dữ liệu, tài khoản hoặc môi trường có sẵn nếu cần thiết để mô tả tiền điều kiện.
- Tài liệu test plan hiện có nếu muốn rà soát thay vì tạo mới.

Nếu thiếu đặc tả gốc, Skill vẫn có thể tạo bản nháp dựa trên tài liệu được cung cấp, nhưng phải công khai giới hạn, đánh dấu quy tắc chưa xác nhận và nêu câu hỏi cần người dùng trả lời.

## Các bước xử lý

1. Đọc đặc tả, xác định phạm vi, actor, luồng và nguồn/căn cứ.
2. Trích xuất yêu cầu, điều kiện đầu vào, biến đầu vào/đầu ra, kết quả và các điều kiện có thể ảnh hưởng tới xử lý.
3. Phân hoạch miền hợp lệ/không hợp lệ; giải thích mỗi lớp theo căn cứ cụ thể.
4. Chọn test case đại diện; mỗi test Invalid cô lập một lớp và giữ các điều kiện khác hợp lệ.
5. Ghi ID, tiền điều kiện, dữ liệu, bước thực hiện và expected result.
6. Lập ánh xạ yêu cầu/lớp/test case; kiểm tra lớp bị thiếu, không thể kiểm thử, trùng lặp hoặc chưa có căn cứ.
7. Thực hiện BVA độc lập: chỉ dùng biên có trong đặc tả, thiết kế giá trị dưới/tại/trên khi phù hợp và cô lập điều kiện.
8. Đối chiếu mỗi BVA test với yêu cầu gốc; ghi `Chưa đủ căn cứ` thay vì tự tạo biên.
9. Rà soát giả định, thông tin chưa xác định, mâu thuẫn, ID, expected result và các câu hỏi cần con người xử lý.

## Đầu ra mong đợi

Tài liệu Markdown bằng tiếng Việt, phù hợp HW02, có phạm vi/nguồn, bảng yêu cầu và biến, bảng phân lớp tương đương, test case chi tiết, bảng truy vết/bao phủ, bảng BVA riêng, căn cứ cho expected result, giả định và các điểm cần xác nhận. Skill chỉ thiết kế test; không được tự tuyên bố đã thực thi test hoặc tạo evidence.

## Kiểm tra chất lượng đầu ra

- Mỗi điều kiện/lớp/biên/expected result có trích dẫn hoặc mã yêu cầu truy ngược được.
- Mọi lớp được bao phủ hoặc có ghi rõ lý do chưa kiểm thử.
- Invalid test chỉ vi phạm điều kiện đang kiểm tra; các điều kiện còn lại hợp lệ.
- Biên BVA có căn cứ đặc tả, dùng đúng đơn vị và expected result không mâu thuẫn với yêu cầu.
- Giá trị chưa xác định không bị đánh nhãn Invalid; giả định không bị biến thành yêu cầu.
- Domain Testing không bị lẫn với BVA; không áp giá trị biên số học cho lớp rời rạc nếu không có giới hạn.
- ID, trạng thái thiết kế/thực thi và evidence được dùng nhất quán; không ghi nhận thực thi khi chưa có xác minh.
- Người review kiểm tra lại với đặc tả gốc và các nguồn có thẩm quyền trước khi chốt.

## Giới hạn

- Skill không thay thế đặc tả, quyết định nghiệp vụ, review của tester hoặc phê duyệt của giảng viên.
- Chất lượng kết quả phụ thuộc vào độ đầy đủ, tính chính xác và thứ tự ưu tiên của nguồn người dùng cung cấp.
- Skill không tự truy cập môi trường EShop, tạo tài khoản/dữ liệu, chạy test, xác minh actual result hoặc tạo screenshot trừ khi người dùng yêu cầu và công cụ/môi trường tương ứng có sẵn.
- Việc đặt file đúng cấu trúc giúp Copilot phát hiện Skill theo cơ chế workspace được hỗ trợ, nhưng không chứng minh mọi phiên bản/phiên chat đã nạp nó. Cần kiểm tra gợi ý Skill hoặc xác nhận nội dung đã được nạp trong Copilot Agent mode.

## Tài liệu demo

- [Kịch bản demo/video FR-01](./demo-plan.md)
- [Video demo trên YouTube](https://www.youtube.com/watch?v=Fi23mSQEM7M)
- [File video MP4 trong workspace](./demo/HW02_DEMO.mp4)
- [Phân tích minh họa FR-01](./demo/FR-01-domain-bva-analysis.md)
- [Ghi nhận kiểm tra Skill](./demo/FR-01-skill-validation.md)
