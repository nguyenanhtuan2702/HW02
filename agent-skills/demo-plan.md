# Kịch bản demo Skill EShop Domain Testing và BVA

## Mục tiêu

Quay lại quá trình dùng Skill `eshop-domain-bva-testing` trong VS Code Agent mode, từ việc cung cấp tài liệu FR-01 tới đầu ra Domain Testing/BVA, rồi con người đối chiếu và ghi nhận giới hạn. Demo minh họa một lượt phân tích mới; không chạy lại test và không thay đổi test plan, execution results hoặc evidence đã hoàn thành.

## Chuẩn bị

1. Mở workspace `D:\HW02` trong VS Code.
2. Mở Copilot Chat, chọn chế độ **Agent**.
3. Mở song song các tab:
   - `.github/skills/eshop-domain-bva-testing/SKILL.md`
   - `FR-01-registration/domain-testing.md`
   - `FR-01-registration/bva.md`
   - `FR-01-registration/execution-results.md` (chỉ dùng để phân biệt test design với actual result; không sửa)
4. Mở `agent-skills/demo/FR-01-domain-bva-analysis.md` để so sánh đầu ra minh họa đã tạo.
5. Nếu Skill vừa được thêm nhưng chưa xuất hiện trong Agent mode, refresh/reopen workspace hoặc mở một phiên Agent mới. Ghi nhận nếu cần gọi trực tiếp bằng tên/file.

## Kịch bản quay từ đầu đến cuối

### 1. Giới thiệu Skill

Trên màn hình, hiển thị đường dẫn và frontmatter của `SKILL.md`, giải thích ngắn gọn rằng nó cung cấp workflow dùng lại cho nhiều feature, không phải bộ test cố định của FR-01.

### 2. Mở đặc tả FR-01

Mở `FR-01-registration/domain-testing.md` và `bva.md`. Nêu rõ demo này có các tài liệu phân tích và BVA hiện hành, nhưng repository không có SRS/đặc tả FR-01 gốc. Vì vậy, điều kiện mật khẩu tối thiểu 8 ký tự cần được xác nhận với nguồn chính thức; không được trình bày nguồn thứ cấp như SRS.

### 3. Gọi Skill và yêu cầu Domain Testing

Trong Copilot Agent mode, nhập `/eshop-domain-bva-testing`, chọn Skill nếu danh sách gợi ý hiện ra, rồi gửi:

```text
Đọc FR-01-registration/domain-testing.md như tài liệu đầu vào cho FR-01.
Thực hiện Domain Testing theo quy trình trong Skill: nêu phạm vi và nguồn,
điều kiện/biến, các lớp tương đương Valid và Invalid có căn cứ, test case
đại diện với tiền điều kiện/dữ liệu/bước/expected result, và bảng truy vết
bao phủ. Không tạo yêu cầu chưa có nguồn; đánh dấu các điểm cần kiểm tra với
SRS gốc. Chỉ tạo đầu ra mới trong agent-skills/demo/; không sửa tài liệu hoặc
evidence đã có. Không ghi actual result hay trạng thái thực thi.
```

### 4. Yêu cầu phân tích BVA

Gửi yêu cầu tiếp theo trong cùng cuộc trò chuyện:

```text
Tiếp tục với BVA riêng biệt cho điều kiện mật khẩu tối thiểu 8 ký tự, chỉ
nếu điều kiện đó được xác nhận trong đặc tả gốc. Đọc thêm
FR-01-registration/bva.md và đối chiếu miền, biên, giá trị ngay dưới/tại/trên,
dữ liệu giữ cố định, expected result và căn cứ yêu cầu. Nếu chỉ có căn cứ từ
test plan mà không có SRS gốc, hãy ghi rõ kết quả là phân tích tạm thời cần
xác nhận, không coi là quy tắc đã xác thực. Không suy diễn các biên khác.
```

### 5. Quan sát đầu ra

Kiểm tra trong phản hồi/Markdown có:

- nguồn và giới hạn;
- các lớp EC được giải thích, phân biệt Invalid với chưa xác định;
- mỗi test Invalid cô lập điều kiện;
- test IDs, tiền điều kiện, dữ liệu, bước và expected result;
- bảng truy vết/bao phủ;
- bảng BVA độc lập và giá trị sát biên;
- câu hỏi mở, giả định, nội dung chờ xác nhận;
- không có actual result hoặc tuyên bố PASS/FAIL khi chưa chạy test.

### 6. Con người đối chiếu và hiệu chỉnh

Mở lại tài liệu FR-01 cạnh đầu ra. Đối chiếu từng yêu cầu và expected result với nguồn. Xác minh riêng:

- điều kiện tối thiểu 8 ký tự có thực sự nằm trong SRS/đặc tả chính thức;
- các ký tự đặc biệt được chấp nhận;
- kết quả đăng ký thành công, chuyển trang và cách thông báo lỗi;
- mỗi test Invalid chỉ vi phạm một điều kiện;
- các test case không tuyên bố actual result hay ghi đè kết quả đã thực thi.

Nếu phát hiện nội dung không có căn cứ, yêu cầu Agent sửa bằng cách xóa/đánh dấu `Chưa xác định` và hỏi người có thẩm quyền. Không tự coi `domain-testing.md` hay `bva.md` là xác nhận SRS nếu chưa đối chiếu được tài liệu gốc.

### 7. Tổng kết demo

Nêu Skill làm tốt việc tách Domain Testing khỏi BVA, duy trì truy vết, yêu cầu cô lập dữ liệu Invalid và không bịa giới hạn. Nêu giới hạn: kết quả phụ thuộc tài liệu đầu vào; không xác minh nghiệp vụ/SRS nếu thiếu nguồn chính thức; không thực thi test hoặc xác minh giao diện/evidence.

## Ghi chú về việc kiểm tra Skill

Tài liệu đầu ra được chuẩn bị ở [`demo/FR-01-domain-bva-analysis.md`](./demo/FR-01-domain-bva-analysis.md) bằng cách áp dụng quy trình của Skill cho những tài liệu hiện có. Phiên làm việc tạo file không cung cấp giao diện Copilot Agent mode để mở slash picker hoặc quan sát sự kiện nạp Skill; do đó đây không phải bằng chứng rằng Copilot đã thực sự tự nạp Skill. Cần tự chạy các bước 1–4 trong VS Code để xác nhận hiển thị/gọi Skill và thay đầu ra minh họa bằng kết quả Agent nếu muốn lưu đầu ra được tạo trực tiếp.

## Gợi ý bố cục video (3–5 phút)

1. **0:00–0:30:** Workspace, Skill path/frontmatter, cách gọi.
2. **0:30–1:00:** FR-01 source, nêu thiếu SRS gốc.
3. **1:00–2:15:** Prompt và kết quả Domain Testing: yêu cầu → EC → test case → coverage.
4. **2:15–3:15:** Prompt và kết quả BVA: điều kiện 8 ký tự → 7/8/9 → cô lập biến.
5. **3:15–4:30:** Con người đối chiếu tài liệu, chỉ ra cần xác nhận yêu cầu gốc và sửa nội dung không có căn cứ.
6. **4:30–5:00:** Kết luận về ưu điểm và giới hạn; nhấn mạnh đây là thiết kế, không phải execution.
