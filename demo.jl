# Demo DT047 - luy thua nhanh lay phan du.
# Cach chay (tu thu muc goc cua repo):
#   julia --startup-file=no demo.jl                 # chay hai vi du cua phieu + lan vet n=10
#   julia --startup-file=no demo.jl 3 45 1000000007 # truyen a n M qua tham so
#   julia --startup-file=no demo.jl --nhap          # nhap a, n, M tu ban phim
include(joinpath(@__DIR__, "src", "LuyThuaMod.jl"))
using .LuyThuaMod

function in_ket_qua(ten, a, n, M, expected = nothing)
    println("---- ", ten, " ----")
    println("input   : a=", a, "; n=", n, "; M=", M)
    r = chay_luy_thua(a, n, M)
    expected === nothing || println("expected: ket_qua=", expected)
    println("actual  : ket_qua=", r.ket_qua, "; so_goi=", r.so_goi, "; so_nhan=", r.so_nhan)
    if expected !== nothing
        println(r.ket_qua == expected ? "PASS" : "FAIL")
    end
    return r
end

function doc_so(dong::AbstractString, ten)
    v = tryparse(Int64, strip(dong))
    v === nothing && throw(ArgumentError("$ten phai la so nguyen, nhan \"$dong\""))
    return v
end

function chay_tu_dong_lenh(args)
    a = doc_so(args[1], "a"); n = doc_so(args[2], "n"); M = doc_so(args[3], "M")
    in_ket_qua("Tham so dong lenh", a, n, M)
    println("so mu da xu ly: ", lan_vet_so_mu(n))
end

function chay_nhap_ban_phim()
    print("Nhap a (0..10^9): "); a = doc_so(readline(), "a")
    print("Nhap n (0..10^9): "); n = doc_so(readline(), "n")
    print("Nhap M (1..1000000007): "); M = doc_so(readline(), "M")
    in_ket_qua("Nhap ban phim", a, n, M)
    println("so mu da xu ly: ", lan_vet_so_mu(n))
end

function chay_mac_dinh()
    in_ket_qua("A01 - Vi du 1 cua phieu", 2, 10, 1000, 24)
    in_ket_qua("A02 - Vi du 2 cua phieu", 7, 100, 13, 9)
    println("---- Lan vet so mu n = 10 (a=2, M=1000) ----")
    println("day so mu: ", lan_vet_so_mu(10))
    in_lan_vet(2, 10, 1000)
end

function main(args)
    try
        if isempty(args)
            chay_mac_dinh()
        elseif args == ["--nhap"]
            chay_nhap_ban_phim()
        elseif length(args) == 3
            chay_tu_dong_lenh(args)
        else
            println("Cach dung: demo.jl | demo.jl a n M | demo.jl --nhap")
            exit(2)
        end
    catch e
        e isa ArgumentError || rethrow()
        println("INPUT KHONG HOP LE: ", e.msg)
        exit(1)
    end
end

main(ARGS)
