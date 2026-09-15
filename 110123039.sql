-- 1. Tạo Database
CREATE DATABASE IF NOT EXISTS QuanLyCuaHangNuocHoa;
USE QuanLyCuaHangNuocHoa;

-- 2. Bảng Nhà Cung Cấp
CREATE TABLE NhaCungCap (
    MaNCC INT AUTO_INCREMENT PRIMARY KEY,
    TenNCC VARCHAR(100) NOT NULL,
    SoDienThoai VARCHAR(15),
    DiaChi VARCHAR(255)
);

-- 3. Bảng Thương Hiệu
CREATE TABLE ThuongHieu (
    MaThuongHieu INT AUTO_INCREMENT PRIMARY KEY,
    TenThuongHieu VARCHAR(100) NOT NULL,
    QuocGia VARCHAR(50)
);

-- 4. Bảng Nước Hoa
CREATE TABLE NuocHoa (
    MaNuocHoa INT AUTO_INCREMENT PRIMARY KEY,
    TenNuocHoa VARCHAR(150) NOT NULL,
    MaThuongHieu INT,
    MaNCC INT,
    DungTich INT, -- đơn vị ml
    GiaBan DECIMAL(10, 2) NOT NULL,
    SoLuongTon INT DEFAULT 0,
    FOREIGN KEY (MaThuongHieu) REFERENCES ThuongHieu(MaThuongHieu) ON DELETE SET NULL,
    FOREIGN KEY (MaNCC) REFERENCES NhaCungCap(MaNCC) ON DELETE SET NULL
);

-- 5. Bảng Khách Hàng
CREATE TABLE KhachHang (
    MaKhachHang INT AUTO_INCREMENT PRIMARY KEY,
    HoTen VARCHAR(100) NOT NULL,
    SoDienThoai VARCHAR(15) UNIQUE,
    Email VARCHAR(100)
);

-- 6. Bảng Hóa Đơn
CREATE TABLE HoaDon (
    MaHoaDon INT AUTO_INCREMENT PRIMARY KEY,
    MaKhachHang INT,
    NgayLap DATETIME DEFAULT CURRENT_TIMESTAMP,
    TongTien DECIMAL(10, 2) DEFAULT 0,
    FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaKhachHang) ON DELETE SET NULL
);

-- 7. Bảng Chi Tiết Hóa Đơn (Mối quan hệ Nhiều - Nhiều giữa NuocHoa và HoaDon)
CREATE TABLE ChiTietHoaDon (
    MaHoaDon INT,
    MaNuocHoa INT,
    SoLuong INT NOT NULL,
    GiaDonVi DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (MaHoaDon, MaNuocHoa),
    FOREIGN KEY (MaHoaDon) REFERENCES HoaDon(MaHoaDon) ON DELETE CASCADE,
    FOREIGN KEY (MaNuocHoa) REFERENCES NuocHoa(MaNuocHoa) ON DELETE CASCADE
);
