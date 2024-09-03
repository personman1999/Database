CREATE DATABASE cybersoft_db;

USE cybersoft_db;



CREATE TABLE loaisanpham (
    maloaisp INT,
    tenloaisp VARCHAR(255) NOT NULL,
    primary key(maloaisp)
);

CREATE TABLE sanpham (
    ma_sp INT,
    ten_sp VARCHAR(255) NOT NULL,
    mota TEXT,
    soluong INT,
    gia DECIMAL(10, 2),
    giaban DECIMAL(10, 2),
    maloaisp INT,
    
    primary key(ma_sp),
    FOREIGN KEY (maloaisp) REFERENCES loaisanpham(maloaisp)
);


CREATE TABLE khachhang (
    ma_kh INT,
    ho VARCHAR(255) NOT NULL,
    ten VARCHAR(255) NOT NULL,
    diachi VARCHAR(255),
    so_dt VARCHAR(20),
    email VARCHAR(255),
    
    primary key(ma_kh)
);


CREATE TABLE hoadon (
    ma_hoadon INT,
    ngay_mua DATE NOT NULL,
    ma_kh INT,
    
    primary key(ma_hoadon),
    FOREIGN KEY (ma_kh) REFERENCES khachhang(ma_kh)
);



CREATE TABLE chitiethoadon (
    ma_hoadon INT,
    ma_sp INT,
    soluong INT,
    PRIMARY KEY (ma_hoadon, ma_sp),
    FOREIGN KEY (ma_hoadon) REFERENCES hoadon(ma_hoadon),
    FOREIGN KEY (ma_sp) REFERENCES sanpham(ma_sp)
);




