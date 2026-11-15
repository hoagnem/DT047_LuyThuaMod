# DT047 — Tính lũy thừa lớn lấy phần dư (lũy thừa nhanh)

- Sinh viên: **Vũ Hoàng Nam** — MSSV **N24DCDT052** — Lớp D24CQDT01-N
- Môn: Cấu trúc dữ liệu và giải thuật (INT13185, nhóm 03), GV Hồ Nhựt Minh
- Giáo trình INT1306: Chương 4, mục 4.1.4 (Lũy thừa nhanh); Ví dụ 4.2; bài tập chương 4, câu 19;
  trang in 92–93, 112; trang PDF 104–105, 124.
- Ngôn ngữ: Julia (chỉ dùng thư viện chuẩn). Phiên bản đã dùng: `julia version 1.12.7`.
- URL GitHub: https://github.com/hoagnem/DT047_LuyThuaMod · SHA C: `eef7a473f33ed844e49db17dfba0e5f85a58bb76` (mã, test, demo đã chạy và chụp ảnh; SHA S ghi trong ThongTinNop.txt)

## Bài toán và hợp đồng input/output

Tính `a^n mod M` mà không nhân `a` liên tiếp `n` lần: chia đôi số mũ, gọi **một lần** cho `n÷2`
rồi dùng lại (biến `nua`).

- Input: số nguyên `a, n, M`, `0 ≤ a ≤ 10^9`, `0 ≤ n ≤ 10^9`, `1 ≤ M ≤ 1000000007`.
  Vi phạm thì `kiem_tra_dau_vao` ném `ArgumentError` (demo in `INPUT KHONG HOP LE`).
- Output: `ket_qua = a^n mod M`, `so_goi` (tính cả lần gọi cơ sở `n=0`), `so_nhan` (số phép nhân lấy dư).
- Quy ước: `n=0` trả `1 % M` (nên `0^0 = 1 mod M`, và `M=1` luôn cho `0`).
- Mọi phép nhân dùng `Int64`, lấy dư ngay sau khi nhân; tích hai số đã lấy dư `< (10^9+7)^2 ≈ 1.0·10^18 < 9.22·10^18`.

## Cấu trúc thư mục

```
src/LuyThuaMod.jl            thuật toán: luy_thua_mod, nhan_lap_mod, luy_thua_mod_lap, lan_vet_so_mu, in_lan_vet
demo.jl                      chạy ví dụ / tham số / nhập bàn phím
test/runtests.jl             bộ kiểm thử (21 ca, ID T01–T21)
scripts/khao_sat_quy_mo.jl   khảo sát 3 quy mô n = 10^3, 10^6, 10^9 bằng phép đếm
docs/lan_vet_tay.md          bảng lần vết tay n = 10
docs/anh_ket_qua/            ảnh gốc A01–A09 đã chụp; A10, A11 làm sau khi có GitHub, xem README trong thư mục
docs/logs/                   log chạy thật (sinh bằng lệnh bên dưới)
```

## Lệnh chạy

Mở terminal tại thư mục gốc của repo:

```powershell
julia --version
julia --startup-file=no demo.jl                  # Ví dụ 1 (A01), Ví dụ 2 (A02) và lần vết n=10
julia --startup-file=no demo.jl 7 100 13         # Ví dụ 2 qua tham số dòng lệnh
julia --startup-file=no demo.jl --nhap           # nhập a, n, M từ bàn phím (dữ liệu mới)
julia --startup-file=no demo.jl -1 5 7           # input sai -> bị từ chối (A08)
julia --startup-file=no test/runtests.jl         # bộ kiểm thử (A09)
julia --startup-file=no scripts/khao_sat_quy_mo.jl
```

Hai ví dụ của phiếu: `a=2, n=10, M=1000 → 24` và `a=7, n=100, M=13 → 9`.
Không có tham số biên dịch (không dùng C++).

## Kết quả kiểm thử

Kết quả chạy thật `test/runtests.jl`: **21 ca độc lập (T01–T21); 4827/4827 phép kiểm đạt (Pass 4827, Total 4827), 0 lỗi**, thời gian ~0,3 s. Số ca và số phép kiểm là hai con số khác nhau (một ca có thể chứa nhiều phép kiểm, ví dụ T14 có 735, T20 có 4000).
Expected được tính độc lập bằng `pow(a, n, M)` của Python và công thức đếm
`so_goi = bitlen(n)+1`, `so_nhan = bitlen(n)+popcount(n)` (n ≥ 1), không lấy từ kết quả chạy của chính chương trình.

## Công bố mã và clone kiểm tra

```powershell
git init
git add README.md .gitignore src demo.jl test scripts docs
git commit -m "DT047 luy thua nhanh lay phan du"
git branch -M main
git remote add origin https://github.com/TEN_TAI_KHOAN/TEN_REPO.git
git push -u origin main
git rev-parse HEAD
```

Clone vào thư mục mới chưa tồn tại rồi chạy lại:

```powershell
git clone https://github.com/TEN_TAI_KHOAN/TEN_REPO.git kiem_tra_N24DCDT052
cd kiem_tra_N24DCDT052
git rev-parse HEAD
julia --version
julia --startup-file=no demo.jl
julia --startup-file=no test/runtests.jl
```

## Tình trạng đợt 1

- Đã xong: mã thuật toán, demo, test (21 ca, 4827/4827 phép kiểm đạt), khảo sát quy mô, lần vết tay, ảnh A01–A09.
- Chưa làm (đợt 2): GitHub và SHA C, ảnh A10, A11, báo cáo Word/PDF, TXT nộp rời.
