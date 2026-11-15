# Khao sat 3 quy mo n = 10^3, 10^6, 10^9 (a = 2, M = 1_000_000_007) trong mien phieu.
# Do bang PHEP DEM (so lan goi, so phep nhan), khong chi bang thoi gian.
# Nhan lap can dung n phep nhan: chi chay thuc voi n <= 10^6, n = 10^9 chi ghi so phep nhan ly thuyet.
# Chay: julia --startup-file=no scripts/khao_sat_quy_mo.jl
include(joinpath(@__DIR__, "..", "src", "LuyThuaMod.jl"))
using .LuyThuaMod

const M = 1_000_000_007
println(rpad("n", 14), rpad("so_goi", 9), rpad("so_nhan", 9), rpad("nhan_lap", 14), "khop_nhan_lap")
for n in (10^3, 10^6, 10^9)
    r = chay_luy_thua(2, n, M)
    if n <= 10^6
        d = DemPhep()
        kq_lap = nhan_lap_mod(2, n, M, d)
        println(rpad(n, 14), rpad(r.so_goi, 9), rpad(r.so_nhan, 9), rpad(d.so_nhan, 14),
                kq_lap == r.ket_qua ? "ket qua trung" : "KHAC")
    else
        println(rpad(n, 14), rpad(r.so_goi, 9), rpad(r.so_nhan, 9), rpad(n, 14), "(khong chay, qua lau)")
    end
end
