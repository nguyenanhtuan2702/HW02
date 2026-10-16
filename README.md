# HW02 — Domain Testing và BVA trên EShop

## Mục lục

- [1. Giới thiệu](#1-gioi-thieu)
- [2. Phạm vi kiểm thử](#2-pham-vi-kiem-thu)
- [3. Tổng kết kết quả](#3-tong-ket-ket-qua)
- [4. Bug reports](#4-bug-reports)
- [5. Tài liệu và evidence](#5-tai-lieu-va-evidence)
- [6. Agent Skill và video demo](#6-agent-skill-va-video-demo)
- [7. Tự đánh giá](#7-tu-danh-gia)
- [8. Checklist trước khi nộp](#8-checklist-truoc-khi-nop)

## 1. Giới thiệu

HW02 áp dụng **Domain Testing**, **Equivalence Partitioning** và **Boundary Value Analysis (BVA)** để thiết kế, thực thi và đánh giá kiểm thử cho ứng dụng EShop. Bài làm xác định các lớp dữ liệu có hành vi tương đương, chọn ca đại diện, kiểm tra các giới hạn được đặc tả và đối chiếu kết quả với yêu cầu cùng evidence.

Các sản phẩm chính gồm test design và execution results cho bốn feature, báo cáo tổng hợp, evidence, bug reports, đánh giá việc dùng AI và Agent Skill có tài liệu minh họa FR-01.

### Trạng thái hiện tại

**Đã hoàn thành:** test design, các lượt kiểm thử đã ghi nhận và evidence cho bốn feature; `report.md` và PDF; AI Audit và PDF; AI Critique đúng giới hạn 200–300 từ và PDF; AI Gap Analysis; 10 bug reports Markdown local; Agent Skill cùng tài liệu hướng dẫn/demo. Log mới nhất của script ghi nhận 10 GitHub Issues đã tạo trong `nguyenanhtuan2702/eshop-sut`; 7 issue có screenshot phù hợp được đính kèm, 3 issue API-only được ghi rõ không có ảnh phù hợp.

**Còn cần làm:** quay video demo Skill; cập nhật commit log; tự chấm điểm; kiểm tra và tạo ZIP tổng hợp để nộp.

Trạng thái GitHub Issues ở trên được đối chiếu theo Run ID `20261017-012947` trong [log đăng Issues](bug-reports/github-issues.csv). Lượt rà soát README này không xác minh lại danh sách trên GitHub vì API không kết nối được.

## 2. Phạm vi kiểm thử

| Feature | Tên chức năng | Phạm vi | Tài liệu và evidence |
|---|---|---|---|
| FR-01 | Registration | Đăng ký tài khoản trên Web/API | [Domain](FR-01-registration/domain-testing.md) · [BVA](FR-01-registration/bva.md) · [Execution](FR-01-registration/execution-results.md) · [Evidence](evidence/evidence-index.md#fr-01-registration) |
| FR-09 | Coupons | Áp dụng mã giảm giá trên Checkout/API | [Domain](FR-09-coupons/domain-testing.md) · [BVA](FR-09-coupons/bva.md) · [Execution](FR-09-coupons/execution-results.md) · [Evidence](evidence/evidence-index.md#fr-09-coupons) |
| FR-17 | Coupon Management | Quản lý mã giảm giá trên Web Admin/API | [Domain](FR-17-coupon-management/domain-testing.md) · [BVA](FR-17-coupon-management/bva.md) · [Execution](FR-17-coupon-management/execution-results.md) · [Evidence](evidence/evidence-index.md#fr-17-coupon-management) |
| FR-11 | Mobile Order History | Xem lịch sử đơn hàng trên mobile | [Domain](mobile-FR-11/domain-testing.md) · [BVA](mobile-FR-11/bva.md) · [Manual execution](mobile-FR-11/FR-11-manual-execution-results.md) · [Evidence TC01](evidence/FR-11-mobile/TC01/ev1.jpg) · [Evidence TC03/09/10](evidence/FR-11-mobile/TC03/ev3_9_10.jpg) |

## 3. Tổng kết kết quả

| Chỉ tiêu | Số lượng |
|---|---:|
| Feature được kiểm thử | 4 |
| Test case được thiết kế | 68 |
| Có kết quả PASS/FAIL trong các lượt gốc đã ghi nhận | 61 |
| PASS | 34 |
| FAIL | 27 |
| BLOCKED | 5 |
| NOT AUTOMATED | 2 |
| Bug reports đã lập | 10 |

Phân bổ theo feature:

| Feature | Thiết kế | Có kết quả PASS/FAIL | PASS | FAIL | BLOCKED | NOT AUTOMATED |
|---|---:|---:|---:|---:|---:|---:|
| FR-01 | 15 | 13 | 3 | 10 | 0 | 2 |
| FR-09 | 18 | 18 | 13 | 5 | 0 | 0 |
| FR-17 | 25 | 25 | 15 | 10 | 0 | 0 |
| FR-11 | 10 | 5 | 3 | 2 | 5 | 0 |
| **Tổng** | **68** | **61** | **34** | **27** | **5** | **2** |

Số liệu được đối chiếu với [báo cáo chính](report.md) và các execution results liên kết ở mục [Phạm vi kiểm thử](#2-pham-vi-kiem-thu). `61 = 34 PASS + 27 FAIL`; thêm 5 ca `BLOCKED` và 2 ca `NOT AUTOMATED` thành 68 test case được thiết kế. Trong đó, 5 ca `BLOCKED` của FR-11 cần tài khoản hoặc fixture phù hợp; 2 ca FR-01 chưa được tự động hóa vì giao diện/API hiện tại không hỗ trợ trường xác nhận mật khẩu.

FR-01, FR-09 và FR-17 có lượt gốc `20261016-155435`; FR-11 có execution thủ công riêng `FR11-MANUAL-16/10/26-01`. Vì vậy, 61 là tổng số ca có kết quả PASS/FAIL trong các bản ghi gốc đã lưu, không phải một Run ID chung. BVA của FR-11 là `N/A`, không tính thành test case riêng.

> Lượt bổ sung `20261016-evidence-1623` chạy lại 31 test giao diện để bổ sung screenshot (FR-01: 3, FR-09: 13, FR-17: 15); cả 31 được ghi `PASS`. Đây là các test case đã có, không cộng thêm vào 68 và không thay đổi trạng thái trong lượt gốc.

## 4. Bug reports

Các báo cáo Markdown local đã được ghi nhận là đăng thành 10 GitHub Issues trong [repo đích](https://github.com/nguyenanhtuan2702/eshop-sut), theo Run ID `20261017-012947` trong [CSV kết quả](bug-reports/github-issues.csv). Log ghi nhận 7 issue có screenshot đính kèm. Ba báo cáo API-only `BR-FR01-03`, `BR-FR09-02` và `BR-FR17-01` không có screenshot phù hợp; lý do và JSON/trace thay thế được mô tả trong [bug reports index](bug-reports/README.md). Các URL dưới đây lấy từ log; lượt cập nhật này chưa xác minh lại trạng thái trực tiếp trên GitHub.

| Bug ID | Feature | Mô tả ngắn | Test case liên quan | Báo cáo local | GitHub Issue |
|---|---|---|---|---|---|
| BR-FR01-01 | FR-01 | UI từ chối mật khẩu 8/9 ký tự đáp ứng SRS | TC01, BVA-FR01-02/03 | [Markdown](bug-reports/BR-FR01-01.md) | [#1](https://github.com/nguyenanhtuan2702/eshop-sut/issues/1) |
| BR-FR01-02 | FR-01 | Form đăng ký thiếu trường xác nhận mật khẩu | TC01; TC11/12 chưa tự động hóa | [Markdown](bug-reports/BR-FR01-02.md) | [#2](https://github.com/nguyenanhtuan2702/eshop-sut/issues/2) |
| BR-FR01-03 | FR-01 | API chấp nhận email hoặc mật khẩu không hợp lệ | TC04–TC10 | [Markdown](bug-reports/BR-FR01-03.md) | [#3](https://github.com/nguyenanhtuan2702/eshop-sut/issues/3) |
| BR-FR09-01 | FR-09 | Phép tính giảm giá phần trăm cho kết quả sai | TC09-01 | [Markdown](bug-reports/BR-FR09-01.md) | [#4](https://github.com/nguyenanhtuan2702/eshop-sut/issues/4) |
| BR-FR09-02 | FR-09 | API chấp nhận request thiếu JWT hoặc JWT không hợp lệ | TC09-06/07 | [Markdown](bug-reports/BR-FR09-02.md) | [#5](https://github.com/nguyenanhtuan2702/eshop-sut/issues/5) |
| BR-FR09-03 | FR-09 | Từ chối đơn hàng đúng bằng ngưỡng tối thiểu | TC09-09, BVA-FR09-02 | [Markdown](bug-reports/BR-FR09-03.md) | [#6](https://github.com/nguyenanhtuan2702/eshop-sut/issues/6) |
| BR-FR17-01 | FR-17 | API chấp nhận thiếu hoặc sai `type` | TC17-05/06 | [Markdown](bug-reports/BR-FR17-01.md) | [#7](https://github.com/nguyenanhtuan2702/eshop-sut/issues/7) |
| BR-FR17-02 | FR-17 | API chấp nhận `discount_value` bằng 0 hoặc âm | TC17-07/08, BVA-FR17-01/02/04/05 | [Markdown](bug-reports/BR-FR17-02.md) | [#8](https://github.com/nguyenanhtuan2702/eshop-sut/issues/8) |
| BR-FR17-03 | FR-17 | API chấp nhận `min_order_amount` âm | TC17-10, BVA-FR17-07 | [Markdown](bug-reports/BR-FR17-03.md) | [#9](https://github.com/nguyenanhtuan2702/eshop-sut/issues/9) |
| BR-FR11-01 | FR-11 | Trạng thái đơn hàng không được phân biệt bằng màu | TC03/10 | [Markdown](bug-reports/BR-FR11-01.md) | [#10](https://github.com/nguyenanhtuan2702/eshop-sut/issues/10) |

Mười bug được nhóm theo hành vi/nguyên nhân và liên kết với 27 test case `FAIL` duy nhất; một test case có thể liên quan đến hơn một bug. `FAIL` không đồng nghĩa với số bug độc lập. Mức độ nghiêm trọng hiện chưa được đánh giá.

## 5. Tài liệu và evidence

| Nội dung | Tài liệu hiện có | Trạng thái bổ sung |
|---|---|---|
| Báo cáo chính | [report.md](report.md) · [report.pdf](report.pdf) | Markdown và PDF đã có |
| AI Audit | [ai-audit.md](ai-audit.md) · [ai-audit.pdf](ai-audit.pdf) | Markdown và PDF đã có |
| AI Critique | [ai-critique.md](ai-critique.md) · [ai-critique.pdf](ai-critique.pdf) | 270 từ tính cả tiêu đề; Markdown và PDF đã có |
| AI Gap Analysis | [ai-gap-analysis.md](ai-gap-analysis.md) | Đã có Markdown |
| Bug reports | [Index và 10 báo cáo](bug-reports/README.md) | CSV ghi nhận 10 Issue đã tạo; 7 ảnh đính kèm, 3 API-only không có ảnh phù hợp |
| Script đăng bug reports | [publish-bug-reports.ps1](scripts/publish-bug-reports.ps1) · [CSV kết quả](bug-reports/github-issues.csv) | Mặc định DryRun; log lưu theo từng Bug ID và từng lượt chạy |
| Evidence | [Evidence index](evidence/evidence-index.md) | FR-11 ảnh được liên kết trong execution report và mục 2 |
| Agent Skill | [SKILL.md](.github/skills/eshop-domain-bva-testing/SKILL.md) | Bản Skill trong workspace |
| Hướng dẫn Skill | [agent-skills/README.md](agent-skills/README.md) | Đã có |
| Kịch bản demo | [demo-plan.md](agent-skills/demo-plan.md) | Có kịch bản; chưa có video |
| Demo/review FR-01 | [Skill validation](agent-skills/demo/FR-01-skill-validation.md) · [Phân tích minh họa](agent-skills/demo/FR-01-domain-bva-analysis.md) | Tài liệu phân tích; không thay execution result |
| Git commit log | [git-commit-log.txt](git-commit-log.txt) | File hiện có nhưng đang rỗng, cần cập nhật |

Domain Testing, BVA và execution results của từng feature được liên kết trực tiếp trong [bảng phạm vi](#2-pham-vi-kiem-thu). Không tìm thấy PDF đề bài trong workspace; bảng tự đánh giá bên dưới giữ nguyên thang điểm được nêu trong yêu cầu HW02.

## 6. Agent Skill và video demo

Skill [`eshop-domain-bva-testing`](.github/skills/eshop-domain-bva-testing/SKILL.md) hỗ trợ đọc yêu cầu có truy vết, phân lớp tương đương, chọn test case đại diện và áp dụng BVA trên các giới hạn có căn cứ. [Hướng dẫn Skill](agent-skills/README.md), [kịch bản demo](agent-skills/demo-plan.md) và hai tài liệu demo FR-01 được lưu trong `agent-skills/`.

**Video demo:** Chưa có file video hoặc URL demo trong workspace. Cần quay video theo kịch bản và bổ sung liên kết trước khi nộp; README không tạo URL thay thế.

## 7. Tự đánh giá

Điểm tự đánh giá được để trống theo yêu cầu để sinh viên tự quyết định.

| STT | Tiêu chí | Điểm tối đa | Điểm tự đánh giá |
|---:|---|---:|---|
| 1 | Feature A – Domain Testing và BVA | 25 | Chưa tự đánh giá |
| 2 | Feature B – Domain Testing và BVA | 25 | Chưa tự đánh giá |
| 3 | Feature C – Domain Testing và BVA | 25 | Chưa tự đánh giá |
| 4 | Feature D – Mobile, Domain Testing và BVA | 15 | Chưa tự đánh giá |
| 5 | Agent Skills | 10 | Chưa tự đánh giá |
|  | **Tổng** | **100** | **Chưa chốt** |

## 8. Checklist trước khi nộp

- [x] Hoàn tất và rà soát `report.md`.
- [x] Xuất `report.pdf`.
- [x] Hoàn tất `ai-audit.md` và xuất PDF.
- [x] Hoàn tất AI Critique đúng yêu cầu 200–300 từ và xuất PDF.
- [x] Lập 10 bug reports dạng Markdown local.
- [x] Ghi nhận 10 Bug Reports trên GitHub Issues; đính kèm ảnh phù hợp cho 7 issue và ghi lý do không có ảnh cho 3 issue API-only.
- [x] Tạo Agent Skill cùng hướng dẫn và tài liệu demo FR-01.
- [ ] Quay video demo Agent Skill và thêm liên kết.
- [ ] Hoàn thành `git-commit-log.txt` (file hiện rỗng).
- [ ] Chốt điểm tự đánh giá.
- [ ] Kiểm tra tên file ZIP và toàn bộ nội dung trước khi nộp (chưa xác nhận có ZIP tổng hợp; các ZIP hiện thấy là trace evidence).
