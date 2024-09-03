CREATE DATABASE db_qlbansach;

USE db_qlbansach;



CREATE TABLE khachhang (
    makh INT ,
    hoten VARCHAR(100),
    ngaysinh DATE,
    gioitinh VARCHAR(10),
    dienthoai VARCHAR(15),
    diachi VARCHAR(255),
    taikhoan VARCHAR(50),
    matkhau VARCHAR(50),
    email VARCHAR(100),
    
    primary key(makh)
);


CREATE TABLE donhang (
    madonhang INT,
    ngaydat DATE,
    ngaygiao DATE,
    tinhtranggh VARCHAR(100),
    hinhthucthanhtoan VARCHAR(50),
    makh INT,
    
    primary key(madonhang),
    FOREIGN KEY (makh) REFERENCES khachhang(makh)
);


CREATE TABLE tacgia (
    matacgia INT,
    tentacgia VARCHAR(100),
    dienthoai VARCHAR(15),
    tieusu TEXT,
    diachi VARCHAR(255),
    
    primary key(matacgia)
);



CREATE TABLE nhaxuatban (
    mansx INT,
    tennsb VARCHAR(100),
    dienthoai VARCHAR(15),
    diachi VARCHAR(255),
    
    primary key(mansx)
);


CREATE TABLE chude (
    machude INT ,
    tenchude VARCHAR(100),
    
    primary key(machude)
);



CREATE TABLE sach (
    masach INT,
    tensach VARCHAR(100),
    soluongton INT,
    ngaycapnhat DATE,
    anhbia VARCHAR(255),
    mota TEXT,
    giaban DECIMAL(10, 2),
    mansx INT,
    machude INT,
    
    primary key(masach),
    FOREIGN KEY (mansx) REFERENCES nhaxuatban(mansx),
    FOREIGN KEY (machude) REFERENCES chude(machude)
);


CREATE TABLE gom (
    madonhang INT,
    masach INT,
    soluong INT,
    dongia DECIMAL(10, 2),
    
    PRIMARY KEY (madonhang, masach),
    FOREIGN KEY (madonhang) REFERENCES donhang(madonhang),
    FOREIGN KEY (masach) REFERENCES sach(masach)
);



CREATE TABLE thamgia (
    matacgia INT,
    masach INT,
    vaitro VARCHAR(100),
    vitri INT,
    PRIMARY KEY (matacgia, masach),
    FOREIGN KEY (matacgia) REFERENCES tacgia(matacgia),
    FOREIGN KEY (masach) REFERENCES sach(masach)
);



























