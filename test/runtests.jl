# Bo kiem thu DT047 - a^n mod M. Chay: julia --startup-file=no test/runtests.jl
# Gia tri expected duoc tinh DOC LAP bang Python: pow(a, n, M); so lan goi va so
# phep nhan tinh bang cong thuc dong (n>=1: goi = bitlen(n)+1, nhan = bitlen(n)+popcount(n);
# n=0: goi 1, nhan 0). Expected KHONG lay tu ket qua chay cua chinh chuong trinh.
using Test
include(joinpath(@__DIR__, "..", "src", "LuyThuaMod.jl"))
using .LuyThuaMod

# (ID, a, n, M, ket_qua, so_goi, so_nhan, muc tieu)
const CA_CHINH = [
    ("T01", 2, 10, 1000, 24, 5, 6, "Vi du 1 cua phieu"),
    ("T02", 7, 100, 13, 9, 8, 10, "Vi du 2 cua phieu"),
    ("T03", 5, 0, 7, 1, 1, 0, "n = 0: tra 1, khong nhan"),
    ("T04", 0, 5, 7, 0, 4, 5, "a = 0, n > 0"),
    ("T05", 0, 0, 7, 1, 1, 0, "0^0 = 1 mod M theo quy uoc"),
    ("T06", 3, 45, 1_000_000_007, 644897553, 7, 10, "Vi du sach, kieu 64 bit"),
    ("T07", 12, 1, 5, 2, 2, 2, "n = 1, a >= M phai lay du truoc"),
    ("T09", 1_000_000_000, 1_000_000_000, 1_000_000_007, 312556845, 31, 43, "bien tren a, n, M gan 10^9"),
    ("T10", 999_999_999, 2, 1_000_000_000, 1, 3, 3, "a = M-1: (-1)^2 mod M"),
    ("T11", 1, 1_000_000_000, 1_000_000_007, 1, 31, 43, "a = 1 voi n lon"),
    ("T12", 3, 64, 1000, 281, 8, 8, "n la luy thua cua 2"),
    ("T13", 7, 2^29 - 1, 1_000_000_007, 30526698, 30, 58, "n toan bit 1 trong mien (2^29-1)"),
    ("T18", 1_000_000_000, 1, 7, 6, 2, 2, "a >= M, n = 1"),
    ("T19", 2, 1_000_000_000, 1_000_000_007, 140625001, 31, 43, "2^(10^9) mod 1e9+7"),
]

@testset verbose = true "DT047 luy thua nhanh lay phan du" begin
    @testset verbose = true "Ca chinh (ket qua + so lan goi + so phep nhan)" begin
        for (id, a, n, M, kq, goi, nhan, muc_tieu) in CA_CHINH
            @testset "$id: $muc_tieu" begin
                r = chay_luy_thua(a, n, M)
                @test r.ket_qua == kq
                @test r.so_goi == goi
                @test r.so_nhan == nhan
            end
        end
    end

    @testset "T08: M = 1 luon tra 0" begin
        for a in (0, 1, 5, 1_000_000_000), n in (0, 1, 2, 17, 1_000_000_000)
            @test luy_thua_mod(a, n, 1) == 0
        end
    end

    @testset "T14: doi chung nhan lap voi moi a<=6, n<=20, M thuoc {1,2,7,10,13}" begin
        for M in (1, 2, 7, 10, 13), a in 0:6, n in 0:20
            @test luy_thua_mod(a, n, M) == nhan_lap_mod(a, n, M)
        end
    end

    @testset "T15: ban vong lap == ban de quy (ket qua va so nhan)" begin
        for (a, n, M) in ((2, 10, 1000), (7, 100, 13), (3, 45, 1_000_000_007),
                          (0, 0, 7), (5, 0, 7), (12, 1, 5), (7, 2^29 - 1, 1_000_000_007))
            d1 = DemPhep(); d2 = DemPhep()
            @test luy_thua_mod(a, n, M, d1) == luy_thua_mod_lap(a, n, M, d2)
            @test d1.so_nhan == d2.so_nhan
        end
    end

    @testset "T16: lan vet so mu" begin
        @test lan_vet_so_mu(10) == [10, 5, 2, 1, 0]
        @test lan_vet_so_mu(0) == [0]
        @test lan_vet_so_mu(1) == [1, 0]
        @test lan_vet_so_mu(100) == [100, 50, 25, 12, 6, 3, 1, 0]
        @test_throws ArgumentError lan_vet_so_mu(-1)
    end

    @testset "T17: input sai bi tu choi (validator)" begin
        @test kiem_tra_dau_vao(0, 0, 1)
        @test kiem_tra_dau_vao(10^9, 10^9, 1_000_000_007)
        @test_throws ArgumentError luy_thua_mod(-1, 5, 7)             # a am
        @test_throws ArgumentError luy_thua_mod(2, -1, 7)             # n am
        @test_throws ArgumentError luy_thua_mod(2, 5, 0)              # M = 0
        @test_throws ArgumentError luy_thua_mod(2, 5, -3)             # M am
        @test_throws ArgumentError luy_thua_mod(2, 5, 1_000_000_008)  # M vuot gioi han
        @test_throws ArgumentError luy_thua_mod(10^9 + 1, 5, 7)       # a vuot gioi han
        @test_throws ArgumentError luy_thua_mod(2, 10^9 + 1, 7)       # n vuot gioi han
        @test_throws ArgumentError luy_thua_mod(2.5, 5, 7)            # khong phai so nguyen
    end

    @testset "T20: cong thuc so lan goi / so nhan voi n tu 1 den 2000" begin
        for n in 1:2000
            r = chay_luy_thua(3, n, 1_000_000_007)
            b = ndigits(n, base = 2)
            @test r.so_goi == b + 1
            @test r.so_nhan == b + count_ones(n)
        end
    end

    @testset "T21: so goi tang theo log2(n), khong tang theo n" begin
        g3 = chay_luy_thua(2, 10^3, 1_000_000_007).so_goi
        g6 = chay_luy_thua(2, 10^6, 1_000_000_007).so_goi
        g9 = chay_luy_thua(2, 10^9, 1_000_000_007).so_goi
        @test (g3, g6, g9) == (11, 21, 31)
    end
end