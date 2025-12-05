USE testdbbk;
CALL sp_TimKiemSanPhamNangCao(
    NULL,   -- Từ khóa
    NULL,   -- Giá Min
    NULL,   -- Giá Max
    NULL,   -- Danh mục
    NULL,   -- Số sao
    0,      -- Sắp xếp: 0 (Mới nhất xếp trên cùng)
    1,      -- Trang số 1
    50      -- Lấy 50 sản phẩm
);


-- Tìm: Danh mục "Phụ Kiện", Giá < 500k, Sắp xếp Giá tăng dần
CALL sp_TimKiemSanPhamNangCao(
    NULL,           -- Từ khóa
    0,              -- Giá Min
    500000,         -- Giá Max: 500k
    'Phụ Kiện',     -- Tên danh mục (Phải khớp với dữ liệu mẫu 'Phụ Kiện Công Nghệ')
    NULL,           -- Sao (tiền ít không đòi hỏi sao)
    1,              -- Sắp xếp: 1 (Giá rẻ lên đầu)
    1, 10
);


-- Lần 1: Xem Trang 1 (Mới nhất)
CALL sp_TimKiemSanPhamNangCao(
    NULL, NULL, NULL, 
    'Thời trang',   -- Danh mục
    NULL, 
    3,              -- Sắp xếp: 0 (Số sao cao nhất)
    1, 5            -- Trang 1, xem 5 món
);

-- Lần 2: Xem tiếp Trang 2 (Khách bấm "Next page")
CALL sp_TimKiemSanPhamNangCao(
    NULL, NULL, NULL, 
    'Thời trang', 
    NULL, 
    3, 
    2, 5          
);


-- Tìm "Laptop", nhưng nhập nhầm Giá Min (50 triệu) lớn hơn Giá Max (10 triệu)
CALL sp_TimKiemSanPhamNangCao(
    'Laptop', 
    50000000,       
    10000000,       
    NULL, NULL, 
    0, 1, 10
);