# DT047 - Tinh luy thua lon lay phan du: a^n mod M bang luy thua nhanh.
# Sinh vien: Vu Hoang Nam - N24DCDT052 - Lop D24CQDT01-N
# Giao trinh INT1306: Chuong 4, muc 4.1.4 (Luy thua nhanh), Vi du 4.2, bai tap chuong 4 cau 19.
#
# Chi dung thu vien chuan cua Julia. Moi phep nhan deu dung Int64 va lay du ngay
# sau khi nhan, nen tich hai so da lay du luon nho hon M^2 <= (10^9+7)^2 ~ 1.0e18
# < 9.22e18 (gioi han Int64).

module LuyThuaMod

export MAX_A, MAX_N, MAX_M, DemPhep,
       kiem_tra_dau_vao, luy_thua_mod, chay_luy_thua, nhan_lap_mod,
       luy_thua_mod_lap, lan_vet_so_mu, in_lan_vet

const MAX_A = 10^9
const MAX_N = 10^9
const MAX_M = 1_000_000_007

"""
    DemPhep

Bo dem do chi phi. Quy uoc theo phieu:
- `so_goi`: so lan goi ham luy thua, tinh ca lan goi co so n = 0;
- `so_nhan`: so phep nhan lay du (moi phep `x * y % M` tinh la 1).
"""
mutable struct DemPhep
    so_goi::Int
    so_nhan::Int
end
DemPhep() = DemPhep(0, 0)

"""
    kiem_tra_dau_vao(a, n, M) -> true

Hop dong input: a, n, M la so nguyen, 0 <= a <= 10^9, 0 <= n <= 10^9,
1 <= M <= 1_000_000_007. Vi pham thi nem `ArgumentError` (khong tinh toan tiep).
"""
function kiem_tra_dau_vao(a, n, M)
    (a isa Integer && n isa Integer && M isa Integer) ||
        throw(ArgumentError("a, n, M phai la so nguyen"))
    0 <= a <= MAX_A || throw(ArgumentError("can 0 <= a <= 10^9, nhan a=$a"))
    0 <= n <= MAX_N || throw(ArgumentError("can 0 <= n <= 10^9, nhan n=$n"))
    1 <= M <= MAX_M || throw(ArgumentError("can 1 <= M <= 1000000007, nhan M=$M"))
    return true
end

# Ham de quy loi: `a` DA duoc lay du (0 <= a < M), n >= 0.
function _luy_thua(a::Int64, n::Int64, M::Int64, dem::DemPhep)
    dem.so_goi += 1
    n == 0 && return 1 % M                     # co so; M = 1 thi 1 % 1 = 0
    nua = _luy_thua(a, n ÷ 2, M, dem)          # dung MOT lan goi cho nua so mu
    kq = (nua * nua) % M                       # binh phuong, lay du ngay
    dem.so_nhan += 1
    if isodd(n)
        kq = (kq * a) % M                      # n le: nhan them a (da lay du)
        dem.so_nhan += 1
    end
    return kq
end

"""
    luy_thua_mod(a, n, M, dem = DemPhep()) -> Int64

Tra `a^n mod M` bang chia doi so mu (de quy). `dem` duoc cap nhat tai cho.
n = 0 tra `1 % M` (nen 0^0 = 1 mod M va M = 1 luon cho 0).
"""
function luy_thua_mod(a, n, M, dem::DemPhep = DemPhep())
    kiem_tra_dau_vao(a, n, M)
    return _luy_thua(Int64(a) % Int64(M), Int64(n), Int64(M), dem)
end

"""
    chay_luy_thua(a, n, M) -> NamedTuple (ket_qua, so_goi, so_nhan)

Tien ich: chay `luy_thua_mod` voi bo dem moi va tra ca ba so can in.
"""
function chay_luy_thua(a, n, M)
    dem = DemPhep()
    kq = luy_thua_mod(a, n, M, dem)
    return (ket_qua = kq, so_goi = dem.so_goi, so_nhan = dem.so_nhan)
end

"""
    nhan_lap_mod(a, n, M, dem = DemPhep()) -> Int64

Doi chung: nhan lap n lan, moi lan lay du. Chi dung de kiem voi n nho (phieu: n <= 20).
"""
function nhan_lap_mod(a, n, M, dem::DemPhep = DemPhep())
    kiem_tra_dau_vao(a, n, M)
    am = Int64(a) % Int64(M)
    kq = 1 % Int64(M)
    dem.so_goi += 1
    for _ in 1:Int64(n)
        kq = (kq * am) % Int64(M)
        dem.so_nhan += 1
    end
    return kq
end

"""
    luy_thua_mod_lap(a, n, M, dem = DemPhep()) -> Int64

Tuy chon: ban vong lap binh phuong lien tiep (duyet bit so mu tu thap len cao).
Moi vong binh phuong co so mot lan; bit 1 nhan them vao ket qua.
"""
function luy_thua_mod_lap(a, n, M, dem::DemPhep = DemPhep())
    kiem_tra_dau_vao(a, n, M)
    m = Int64(M)
    co = Int64(a) % m
    e = Int64(n)
    kq = 1 % m
    dem.so_goi += 1
    while e > 0
        if isodd(e)
            kq = (kq * co) % m
            dem.so_nhan += 1
        end
        co = (co * co) % m
        dem.so_nhan += 1
        e = e ÷ 2
    end
    return kq
end

"""
    lan_vet_so_mu(n) -> Vector{Int}

Day so mu duoc xu ly boi ham de quy, tu `n` den co so 0: n, n÷2, ..., 0.
Vi du n = 10 -> [10, 5, 2, 1, 0].
"""
function lan_vet_so_mu(n::Integer)
    n >= 0 || throw(ArgumentError("n phai khong am, nhan n=$n"))
    day = Int[Int(n)]
    while day[end] > 0
        push!(day, day[end] ÷ 2)
    end
    return day
end

"""
    in_lan_vet(a, n, M; io = stdout)

In bang lan vet tay: moi dong la mot muc de quy (so mu, chan/le, nua, ket qua,
so phep nhan o muc do). Cac dong theo thu tu goi tu tren xuong; cot `nua` va
`ket qua` la gia tri tra ve sau khi xuong den co so roi quay len.
"""
function in_lan_vet(a, n, M; io::IO = stdout)
    kiem_tra_dau_vao(a, n, M)
    am = Int64(a) % Int64(M)
    day = lan_vet_so_mu(n)                    # n, n÷2, ..., 0
    kq = Dict{Int,Int64}()
    kq[0] = 1 % Int64(M)
    nua_cua = Dict{Int,Int64}()
    for i in length(day)-1:-1:1               # tinh nguoc tu muc sat co so len muc n
        e = day[i]
        nua = kq[day[i+1]]
        r = (nua * nua) % Int64(M)
        isodd(e) && (r = (r * am) % Int64(M))
        nua_cua[e] = nua
        kq[e] = r
    end
    println(io, "a mod M = ", am, ";  M = ", M)
    println(io, rpad("muc", 5), rpad("so mu", 12), rpad("chan/le", 9),
            rpad("nua", 12), rpad("ket qua", 12), "so nhan")
    for (i, e) in enumerate(day)
        if e == 0
            println(io, rpad(i, 5), rpad(e, 12), rpad("-", 9), rpad("-", 12),
                    rpad(kq[0], 12), 0)
        else
            println(io, rpad(i, 5), rpad(e, 12), rpad(isodd(e) ? "le" : "chan", 9),
                    rpad(nua_cua[e], 12), rpad(kq[e], 12), isodd(e) ? 2 : 1)
        end
    end
    return nothing
end

end # module LuyThuaMod
