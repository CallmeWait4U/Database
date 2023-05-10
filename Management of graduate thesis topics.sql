CREATE TABLE SINHVIEN
(
    MSSV        CHAR(6)         NOT NULL,
    TENSV       NVARCHAR2(40)   NOT NULL,
    SODT        CHAR(10)        NULL,
    LOP         NVARCHAR2(20)   NULL,
    DIACHI      NVARCHAR2(100)  NULL,
    CONSTRAINT  PK_SINHVIEN PRIMARY KEY(MSSV)
);

CREATE TABLE DETAI
(
    MSDT        CHAR(6)         NOT NULL,
    TENDT       NVARCHAR2(100)  NOT NULL,
    CONSTRAINT  PK_DETAI PRIMARY KEY(MSDT)
);

CREATE TABLE SV_DETAI
(
    MSSV        CHAR(6)         NOT NULL,
    MSDT        CHAR(6)         NOT NULL,
    CONSTRAINT  PK_SV_DETAI PRIMARY KEY(MSSV,MSDT)
);

CREATE TABLE GIAOVIEN
(
    MSGV        INT             NOT NULL,
    TENGV       NVARCHAR2(40)   NOT NULL,
    DIACHI      NVARCHAR2(100)  NOT NULL,
    SODT        CHAR(10)        NULL,
    MSHHAM      INT             NULL,
    NAMHH       INT             NULL,
    CONSTRAINT  PK_GIAOVIEN PRIMARY KEY(MSGV)
);

CREATE TABLE HOCVI
(
    MSHV        INT             NOT NULL,
    TENHV       NVARCHAR2(40)   NOT NULL,
    CONSTRAINT  PK_HOCVI PRIMARY KEY(MSHV)
);

CREATE TABLE CHUYENNGANH
(
    MSCN        INT             NOT NULL,
    TENCN       NVARCHAR2(40)   NOT NULL,
    CONSTRAINT  PK_CHUYENNGANH PRIMARY KEY(MSCN)
);

CREATE TABLE GV_HV_CN
(
    MSGV        INT             NOT NULL,
    MSHV        INT             NOT NULL,
    MSCN        INT             NOT NULL,
    NAM         INT             NULL,
    CONSTRAINT  PK_GV_HV_CN PRIMARY KEY(MSGV,MSHV,MSCN)
);

CREATE TABLE HOCHAM
(
    MSHH        INT             NOT NULL,
    TENHH       NVARCHAR2(30)   NOT NULL,
    CONSTRAINT  PK_HOCHAM PRIMARY KEY(MSHH)
);

CREATE TABLE GV_HDDT
(
    MSGV        INT             NOT NULL,
    MSDT        CHAR(6)         NOT NULL,
    DIEM        INT             NULL,
    CONSTRAINT  PK_GV_HDDT PRIMARY KEY(MSGV,MSDT)
);

CREATE TABLE GV_PBDT
(
    MSGV        INT             NOT NULL,
    MSDT        CHAR(6)         NOT NULL,
    DIEM        INT             NULL,
    CONSTRAINT  PK_GV_PBDT PRIMARY KEY(MSGV,MSDT)
);

CREATE TABLE GV_UVDT
(
    MSGV        INT             NOT NULL,
    MSDT        INT             NOT NULL,
    CONSTRAINT  PK_GV_UVDT PRIMARY KEY(MSGV,MSDT)
);

CREATE TABLE HOIDONG
(
    MSHD        INT             NOT NULL,
    PHONG       CHAR(10)        NULL,
    TGBD        CHAR(10)        NULL,
    NGAYHD      DATE            NULL,
    TINHTRANG   NVARCHAR2(30)   NULL,
    MSGVCTHD    INT             NULL,
    CONSTRAINT  PK_HOIDONG PRIMARY KEY(MSHD)
);

CREATE TABLE HOIDONG_GV
(
    MSHD        INT             NOT NULL,
    MSSV        INT             NOT NULL,
    CONSTRAINT  PK_HOIDONG_GV PRIMARY KEY(MSGV,MSHD)
);

CREATE TABLE HOIDONG_DT
(
    MSHD        INT             NOT NULL,
    MSDT        CHAR(6)         NOT NULL,
    QUYETDINH   NVARCHAR2(15)   NULL,
    CONSTRAINT  PK_HOIDONG_DT PRIMARY KEY(MSHD,MSDT)
);

-------------------create foreign keys--------------------------
ALTER TABLE SV_DETAI
    ADD
        (
            CONSTRAINT FK_SV_DETAI_SINHVIEN FOREIGN KEY(MSSV) REFERENCES SINHVIEN(MSSV),
            CONSTRAINT PK_SV_DETAI_DETAI FOREIGN KEY(MSDT) REFERENCES DATAI(MSDT)
        );

ALTER TABLE GIAOVIEN
    ADD CONSTRAINT FK_GIAOVIEN_HOCHAM FOREIGN KEY(MSHHAM) REFERENCES HOCHAM(MSHH);
    
ALTER TABLE GV_HV_CN
    ADD
        (
            CONSTRAINT FK_GV_HV_CN_GIAOVIEN FOREIGN KEY(MSGV) REFERENCES GIAOVIEN(MSGV),
            CONSTRAINT FK_GV_HV_CN_HOCVI FOREIGN KEY(MSHV) REFERENCES HOCVI(MSHV),
            CONSTRAINT FK_GV_HV_CN_CHUYENNGANH FOREIGN KEY(MSCN) REFERENCES CHUYENNGANH(MSCN)
        );

ALTER TABLE GV_HDDT
    ADD
        (
            CONSTRAINT FK_GV_HDDT_GIAOVIEN FOREIGN KEY(MSGV) REFERENCES GIAOVIEN(MSGV),
            CONSTRAINT FK_GV_HDDT_DETAI FOREIGN KEY(MSDT) REFERENCES DETAI(MSDT)
        );

ALTER TABLE GV_PBDT
    ADD
        (
            CONSTRAINT FK_GV_PBDT_GIAOVIEN FOREIGN KEY(MSGV) REFERENCES GIAOVIEN(MSGV),
            CONSTRAINT FK_GV_PBDT_DETAI FOREIGN KEY(MSDT) REFERENCES DETAI(MSDT)
        );
        
ALTER TABLE GV_UVDT
    ADD
        (
            CONSTRAINT FK_GV_UVDT_GIAOVIEN FOREIGN KEY(MSGV) REFERENCES GIAOVIEN(MSGV),
            CONSTRAINT FK_GV_UVDT_DETAI FOREIGN KEY(MSDT) REFERENCES DETAI(MSDT)
        );

ALTER TABLE HOIDONG
    ADD CONSTRAINT FK_HOIDONG_GIAOVIEN FOREIGN KEY(MSGVCTHD) REFERENCES GIAOVIEN(MSGV);
    
ALTER TABLE HOIDONG_GV
    ADD
        (
            CONSTRAINT FK_HOIDONG_GV_HOIDONG FOREIGN KEY(MSHD) REFERENCES HOIDONG(MSHD),
            CONSTRAINT FK_HOIDONG_GV_GIAOVIEN FOREIGN KEY(MSGV) REFERENCES GIAOVIEN(MSGV)
        );
        
ALTER TABLE HOIDONG_DT
    ADD
        (
            CONSTRAINT FK_HOIDONG_DT_HOIDONG FOREIGN KEY(MSHD) REFERENCES HOIDONG(MSHD),
            CONSTRAINT FK_HOIDONG_DT_DETAI FOREIGN KEY(MSDT) REFERENCES DETAI(MSDT)
        );
        
--------------------Tao ma so tu dong cho bang GIAOVIEN--------------------
CREATE SEQUENCE MaTuDong
    INCREMENT BY    1
    START WITH      1
    MINVALUE        1
    MAXVALUE        1000000000000000000000000000
    CYCLE;
/
SELECT  MaTuDong.NEXTVAL AS STT, MSDT, TENDT
FROM    DETAI
/
SELECT  MaTuDong.CURRVAL FROM DUAL;
/
SELECT * FROM DETAI;
/
--------------------Create Function----------------------
/*
    Input: MSDT
    Output: Diem trung binh cua de tai
*/
CREATE OR REPLACE FUNCTION TinhDiemTrungBinhDeTai(p_MSDT IN DETAI.MSDT%TYPE) RETURN FLOAT
AS
    DTB FLOAT;
    DHD FLOAT;
    DPB FLOAT;
    DUV FLOAT;
BEGIN
    SELECT AVG(DIEM) INTO DHD FROM GV_HDDT WHERE MSDT = p_MSDT;
    SELECT AVG(DIEM) INTO DPB FROM GV_PBDT WHERE MSDT = p_MSDT;
    SELECT AVG(DIEM) INTO DUV FROM GV_UVDT WHERE MSDT = p_MSDT;
    DTB := ROUND((DHD + DPB + DUV)/3,2);
    RETURN DTB;
END TinhDiemTrungBinhDeTai;
/
BEGIN
    DBMS_OUTPUT.PUT_LINE('DIEM TRUNG BINH LA: ' || TinhDiemTrungBinhDeTai('000001'));
END;

/*
    Input: MSDT
    Output: Xep loai neu
        Diem trung binh >= 8 va diem trung binh < 10: Gioi
        Diem trung binh >= 7: Kha
        Diem trung binh >= 5: Trung binh
        Con lai: Kem
*/
CREATE OR REPLACE FUNCTION XepLoai(p_MSDT IN DETAI.MSDT%TYPE) RETURN NVARCHAR2
AS
    DTB FLOAT;
    XL  NVARCHAR2(20);
BEGIN
    DTB := TinhDiemTrungBinhDeTai(p_MSDT);
    IF (DTB >= 8) AND (DTB <= 10) THEN
        XL := 'GIOI';
    ELSIF (DTB >= 7) THEN
        XL := 'KHA';
    ELSIF (DTB >= 5) THEN
        XL := 'TRUNG BINH';
    ELSE
        XL := 'KEM';
    END IF;
    RETURN XL;
END XepLoai;
/
DECLARE
    p_MSDT  NVARCHAR2(20) := &MOIBAN_NHAP_MSDT;
BEGIN
    DBMS_OUTPUT.PUT_LINE('XEP LOAI: ' || XepLoai(p_MSDT));
END;

-------------------Create Procedure voi tham so truyen vao (IN)---------------------
/*
    Tham so truyen vao: MSGV, TENGV, SODT, DIACHI, MSHH, NAMHHAM.
    Truoc khi chen du lieu can kiem tra MSHH da ton tai trong table HOCHAM chua? Neu chua tra ra thong bao loi.
*/
CREATE OR REPLACE PROCEDURE Them_KiemTraHocHam
(p_MSGV IN NUMBER, p_TENGV IN NVARCHAR2, p_DIACHI IN NVARCHAR2, p_SODT IN CHAR, p_MSHHAM IN NUMBER, p_NAMHH IN NUMBER)
AS
    FK_GIAOVIEN_HOCHAM EXCEPTION;
    PRAGMA EXCEPTION_INIT(FK_GIAOVIEN_HOCHAM, -02291);
BEGIN
    INSERT INTO GIAOVIEN(MSGV,TENGV,DIACHI,SODT,MSHHAM,NAMHH)
        VALUES(p_MSGV,p_TENGV,p_DIACHI,p_SODT,p_MSHHAM,p_NAMHH);
    EXCEPTION
        WHEN FK_GIAOVIEN_HOCHAM THEN
            DBMS_OUTPUT.PUT_LINE('Ma so hoc ham: ' || p_MSHHAM ||
                                    ' nay khong co trong bang HOCHAM!!');
END Them_KiemTraHocHam;
/
EXECUTE Them_KiemTraHocHam(6,'Nguyen Van An','1/60 TV?','08632184',50,2021);
/
/*
    Tham so dua vao la: MSGV, TENGV, SODT, DIACHI, MSHH, NAMHHAM
    Truoc khi chen du lieu can kiem tra MSGV co trung khong, neu trung thi thong bao loi.
*/
/
CREATE OR REPLACE PROCEDURE ThemGiaoVien(p_MSSV IN NUMBER, p_TENGV IN NVARCHAR2, p_DIACHI IN NVARCHAR2, p_SODT IN CHAR, p_MSHHAM IN NUMBER, p_NAMHH IN NUMBER)
AS
    PK_GIAOVIEN EXCEPTION;
    PRAGMA EXCEPTION_INIT(PK_GIAOVIEN,-00001);
BEGIN
    INSERT INTO GIAOVIEN(MSGV,TENGV,DIACHI,SODT,MSHHAM,NAMHH)
        VALUES(p_MSGV,p_TENGV,p_DIACHI,p_SODT,p_MSHHAM,p_NAMHH);
    EXCEPTION
        WHEN PK_GIAOVIEN THEN
            DBMS_OUTPUT.PUT_LINE('Ma so giao vien: ' || p_MSGV ||
                                    ' nay da co trong bang GIAOVIEN!!');
END ThemGiaoVien;
/
EXECUTE ThemGiaoVien(5,'Nguyen Van An','1/60 TVD','08632184',50,2021)
/
/*
    Giong cau 1 va cau 2 kiem tra xem MSGV co trung khong va kiem tra xem MSHH ton tai chua.
    Neu MSGV trung thong bao loi, neu MSHH chua ton tai thong bao loi, nguoc lai cho chen du lieu.
*/
/
CREATE OR REPLACE PROCEDURE KiemTraMaSoGiangVien
(
    p_MSGV      IN NUMBER,
    p_TENGV     IN NVARCHAR2,
    p_DIACHI    IN NVARCHAR2,
    p_SODT      IN CHAR,
    p_MSHHAM    IN NUMBER,
    p_NAMHH     IN NUMBER
)
AS
    PK_GIAOVIEN EXCEPTION;
    PRAGMA EXCEPTION_INIT(PK_GIAOVIEN, -00001);
    FK_GIAOVIEN_HOCHAM EXCEPTION;
    PRAGMA EXCEPTION_INIT(FK_GIAOVIEN_HOCHAM, -02291);
BEGIN
    INSERT INTO GIAOVIEN(MSGV,TENGV,DIACHI,SODT,MSHHAM,NAMHH)
        VALUES(p_MSGV,p_TENGV,p_DIACHI,p_SODT,p_MSHHAM,p_NAMHH);
    EXCEPTION
        WHEN FK_GIAOVIEN_HOCHAM THEN
            DBMS_OUTPUT.PUT_LINE('Ma so hoc ham: ' || p_MSHHAM ||
                                    ' nay khong co trong bang HOCHAM!!');
        WHEN FK_GIAOVIEN_HOCHAM THEN
            DBMS_OUTPUT.PUT_LINE('Ma so hoc ham: ' || p_MSHHAM ||
                                    ' nay khong co trong bang HOCHAM!!');
END KiemTraMaSoGiangVien;
/
EXECUTE KiemTraMaSoGiangVien(6,'Nguyen Van An','1/60 TVD','08632184',1,2021);
/
-------------------Create Procedure voi tham so truyen vao va ra (IN OUT)---------------------
/*
    Dua vao TENHV
    Tra ra: So GV thoa hoc vi, neu khong tim thay thong bao loi.
*/
CREATE OR REPLACE PROCEDURE TimGiangVien(p_TENHV IN HOCVI.TENHV%TYPE, p_SOHV OUT INT)
AS
BEGIN
    SELECT COUNT(DISTINCT MSGV) INTO p_SOGV
    FROM GV_HV_CN
    WHERE MSHV = (SELECT MSHV FROM HOCVI WHERE TENHV = p_TENHV);
END TimGiangVien;
/
DECLARE
    p_TENHV HOCVI.TENHV%TYPE := &MOIBAN_NHAP_TENHOCVI;
    SOGV    INT := 0;
BEGIN
    TimGiangVien(p_TENHV,SOGV);
    DBMS_OUTPUT.PUT_LINE('Co: ' || SOGV || ' giao vien co hoc vi la: ' || p_TENHV);
END;
------------------Create Cursor---------------------------
/*
    Tao bang tam (TAM) luu thong tin ve ma so de tai:
    Viet Cursor lay thong tin tu bang DETAI là MSDT de luu vao bang tam (TAM).
    Trong do ta dung cau truc long ham trong Cursor ham for...in... loop ... end loop;
*/
/
CREATE TABLE TAM
(
    MSDT    CHAR(6)         NOT NULL,
    TENDT   NVARCHAR(100)   NOT NULL
);
/
SELECT * FROM TAM;
/
DECLARE
    CURSOR csTEO IS SELECT * FROM DETAI;
BEGIN
    FOR I IN csTEO LOOP
        INSERT INTO TAM VALUES(I.MSDT,I.TENDT);
    END LOOP;
END;
/
/*
    Tao thu bang tam (TAM) luu thong tin ve ma so de tai:
    - Viet Cursor lay thong tin tu bang DETAI la MSDT de luu vao bang TAM.
    Trong do ta dung cau truc long ham trong Cursor ham for...in... loop ... end loop;
*/
/
DELETE TAM;
/
DECLARE
    CURSOR csTEO IS SELECT * FROM DETAI;
    p_MSDT  CHAR(6);
    p_TENDT NVARCHAR2(100);
BEGIN
    OPEN csTEO;
    LOOP
        FETCH csTEO INTO p_MSDT,p_TENDT;
        EXIT WHEN csTEO%NOTFOUND;
        INSERT INTO TAM VALUES(p_MSDT,p_TENDT);
    END LOOP;
    CLOSE csTEO;
END;
/*
    Them 2 cot DIEMTB va XLOAI vao bang SV_DETAI:
    Dung Cursor cap nhat diem de tai va xep loai.
*/
/
SELECT * FROM SV_DETAI;
/
----------Tao 2 cot DIEMTB va XEPLOAI cho bang SV_DETAI;
ALTER TABLE SV_DETAI ADD DIEMTB FLOAT;
ALTER TABLE SV_DETAI ADD XEPLOAI NVARCHAR2(20);
/
DECLARE
    CURSOR csTEO IS SELECT MSSV, MSDT FROM SV_DETAI;
    p_MSSV  CHAR(6);
    p_MSDT  CHAR(6);
BEGIN
    OPEN csTEO;
    LOOP
        FETCH csTEO INTO p_MSSV, p_MSDT;
        EXIT WHEN csTEO%NOTFOUND;
        UPDATE SV_DETAI
        SET     DIEMTB = TinhDiemTrungBinhDeTai(p_MSDT),
                XEPLOAI = XepLoai(p_MSDT)
        WHERE   MSSV = p_MSSV AND MSDT = p_MSDT;
    END LOOP;
    CLOSE csTEO;
END;
--------------------Create Trigger----------------------
/*
    Tao Trigger thoa man dieu kien khi xoa mot de tai se xoa cac thong tin lien quan:
    Cac bang lien quan den bang DETAI nhu sau:
    1. Bang SV_DETAI
    2. Bang GV_HDDT
    3. Bang GV_PBDT
    4. Bang GV_UVDT
    5. Bang HOIDONG_DT
*/
CREATE OR REPLACE TRIGGER T_556_CAU1
ALTER DELETE
ON DETAI
FOR EACH ROW
BEGIN
    IF :OLS.MSDT IS NOT NULL
        DELETE FROM SV_DETAI    WHERE MSDT = :OLD.MSDT;
        DELETE FROM GV_HDDT     WHERE MSDT = :OLD.MSDT;
        DELETE FROM GV_PBDT     WHERE MSDT = :OLD.MSDT;
        DELETE FROM GV_UVDT     WHERE MSDT = :OLD.MSDT;
        DELETE FROM HOTDONG_DT  WHERE MSDT = :OLD.MSDT;
        DBMS_OUTPUT.PUT_LINE('Da xoa de tai o cac bang lien quan den bang DETAI!');
    ELSE
        DBMS_OUTPUT.PUT_LINE('De tai ban muon xoa khong co trong bang DETAI!');
    END IF;
END T_556_CAU1;
/
DECLARE
    p_MSDT  DETAI.MSDT%TYPE := &MOIBAN_NHAP_MASO_DETAI;
BEGIN
    DELETE DETAI WHERE MSDT = p_MSDT;
END;
/
SELECT * FROM SINHVIEN;
SELECT * FROM DETAI;
SELECT * FROM SV_DETAI;
SELECT * FROM GIAOVIEN;
SELECT * FROM HOCVI;
SELECT * FROM CHUYENNGANH;
SELECT * FROM GV_HV_CN;
SELECT * FROM HOCHAM;
SELECT * FROM GV_HDDT;
SELECT * FROM GV_PBDT;
SELECT * FROM GV_UVDT;
SELECT * FROM HOIDONG;
SELECT * FROM HOIDONG_GV;
SELECT * FROM HOIDONG_DT;