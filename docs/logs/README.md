Thư mục log chạy thật. Sau khi cài Julia, sinh log bằng:

```powershell
julia --version                                         *> docs/logs/julia_version.log
julia --startup-file=no demo.jl                         *> docs/logs/demo.log
julia --startup-file=no test/runtests.jl                *> docs/logs/tests.log
julia --startup-file=no scripts/khao_sat_quy_mo.jl      *> docs/logs/quy_mo.log
```
