# Kế hoạch 11 ảnh A01–A11 — DT047 (N24DCDT052)

Chụp ảnh thật từ lần chạy của chính bạn (terminal đọc được, thấy lệnh + output). Tên tệp gợi ý:

| Mã | Hình | Tệp | Lệnh / nội dung chụp | Expected |
|---|---|---|---|---|
| A01 | 4.1 | `01_vi_du_1.png` | `julia --startup-file=no demo.jl` (phần Ví dụ 1) | a=2, n=10, M=1000 → 24; so_goi=5; so_nhan=6 |
| A02 | 4.2 | `02_vi_du_2.png` | cùng lệnh (phần Ví dụ 2) hoặc `demo.jl 7 100 13` | 9; so_goi=8; so_nhan=10 |
| A03 | 4.3 | `03_tu_thiet_ke_1.png` | `demo.jl 3 45 1000000007` | 644897553; 7; 10 (ca sách, tự chọn) |
| A04 | 4.4 | `04_tu_thiet_ke_2.png` | `demo.jl 1000000000 1000000000 1000000007` | 312556845; 31; 43 |
| A05 | 4.5 | `05_bien_1.png` | `demo.jl 5 0 7` (n=0) | 1; 1; 0 |
| A06 | 4.6 | `06_bien_2.png` | `demo.jl 0 0 7` (0^0) | 1; 1; 0 |
| A07 | 4.7 | `07_bien_3.png` | `demo.jl 123456 789 1` (M=1) | 0 |
| A08 | 4.8 | `08_input_khong_hop_le.png` | `demo.jl -1 5 7` và `demo.jl 2 5 0` | `INPUT KHONG HOP LE` |
| A09 | 4.9 | `09_tong_ket_kiem_thu.png` | `julia --startup-file=no test/runtests.jl` | Tổng kết Test Summary (số ca / số phép kiểm) |
| A10 | 4.10 | `10_clone_sach_chay_lai.png` | clone C vào thư mục mới, `git rev-parse HEAD`, chạy demo + test | khớp SHA C |
| A11 | 4.11 | `11_github_repo_commit.png` | trang repo/commit GitHub thật của bạn tại C | — |

Mỗi ảnh khi đưa vào báo cáo cần: mã ca, input đầy đủ, lệnh, output, chú thích hình và ít nhất 2 câu phân tích.
Không dùng ảnh mẫu của BFS hay ảnh giả. A10, A11 chỉ chụp được sau khi đã đẩy code lên GitHub.

## Trạng thái ảnh

| Ảnh | Trạng thái |
|---|---|
| A01, A02 | Đã có (cùng một lần chạy `demo.jl`, kèm `julia --version` = 1.12.7) |
| A03, A04, A05, A06, A07, A08 | Đã có (đã đối chiếu expected, đạt) |
| A09 | Đã có: liệt kê T01–T21 và tổng kết 4827/4827 (bản verbose) |
| A10, A11 | Đã có (clone sạch commit C; trang commit GitHub) |
