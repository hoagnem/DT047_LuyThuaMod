# Lan vet tay: a = 2, n = 10, M = 1000 (Vi du 1 cua phieu DT047)

Quy uoc: ham `luy_thua_mod(a, n, M)`, nua = ket qua cua lan goi cho n÷2; moi binh phuong
va moi phep nhan them a (khi n le) deu la mot phep nhan lay du.

Chuoi goi (di xuong): n = 10 -> 5 -> 2 -> 1 -> 0 (5 lan goi, tinh ca co so n = 0).

| Muc | n  | chan/le | nua | Phep tinh                    | Ket qua | So nhan |
|-----|----|---------|-----|------------------------------|---------|---------|
| 1   | 10 | chan    | 32  | 32*32 = 1024 mod 1000 = 24   | 24      | 1       |
| 2   | 5  | le      | 4   | 4*4 = 16; roi 16*2 = 32      | 32      | 2       |
| 3   | 2  | chan    | 2   | 2*2 = 4                      | 4       | 1       |
| 4   | 1  | le      | 1   | 1*1 = 1; roi 1*2 = 2         | 2       | 2       |
| 5   | 0  | -       | -   | co so: 1 mod 1000            | 1       | 0       |

(Muc danh so tu tren xuong theo thu tu goi, giong bang `in_lan_vet(2, 10, 1000)`; gia tri
tinh tu muc 5 len muc 1.)

Tong: 5 lan goi, 2 + 1 + 2 + 1 = 6 phep nhan. Ket qua 2^10 mod 1000 = 24 (dung voi phieu).

Khong goi hai lan cung n÷2: neu goi `luy_thua(a, n÷2) * luy_thua(a, n÷2)` thi moi muc nhan doi
so lan goi (cay goi nhi phan day du) va thoi gian quay ve O(n); luu vao `nua` giu O(log n).
