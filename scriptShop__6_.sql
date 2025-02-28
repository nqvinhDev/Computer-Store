create database Computer_Shop

create table Brand(
	BrandID int primary key identity(1,1),
	BrandName varchar(30) 
)

create table Category(
	CategoryID int primary key identity(1,1),
	CategoryName varchar(30) 
)

create table NewsType(
	NewsTypeID int primary key identity(1,1),
	NewsTypeName varchar(30) 
)

CREATE TABLE [User](
	UserID INT IDENTITY(1,1) PRIMARY KEY,
	UserName nvarchar(100),
	[Address] nvarchar(200),
	Phone varchar(50),
	Email varchar(100),
	[Password] varchar(100),
)

create table AdminRole(
	RoleID INT IDENTITY(1,1) PRIMARY KEY,
	RoleName nvarchar(40)
)

CREATE TABLE [Admin](
	AdminID INT IDENTITY(1,1) PRIMARY KEY,
	AdminName nvarchar(100),
	[Address] nvarchar(200),
	Phone varchar(50),
	Email varchar(100),
	[Password] varchar(100),
	RoleID int FOREIGN KEY REFERENCES [AdminRole] (RoleID),
)

CREATE TABLE News (
   NewsID INT IDENTITY(1,1) PRIMARY KEY,
   Title nvarchar(MAX),
	Content nvarchar(MAX),
	NewsType int FOREIGN KEY REFERENCES [NewsType] (NewsTypeID),
	DateSubmited date,
	CreatedBy int FOREIGN KEY REFERENCES [Admin] (AdminID),
   ModifiedBy int FOREIGN KEY REFERENCES [Admin] (AdminID),
	CreatedDate date,
	ModifiedDate date,
	Image nvarchar(max),
	Video nvarchar(max),
)

Create table [Order](
	OrderID INT IDENTITY(1,1) PRIMARY KEY,
	UserID int FOREIGN KEY REFERENCES [User] (UserID),
	OrderDate date,
	ShipDate date,
	TotalPrice money,
	[Status] bit,
	PaymentType nvarchar(100),
	[ShipAddress] nvarchar(200)
)

create table Product(
	ProductID int primary key identity(1,1),
	ProductName varchar(35),
	BrandID int FOREIGN KEY REFERENCES Brand (BrandID),
	CategoryID int FOREIGN KEY REFERENCES Category (CategoryID),
	[Description] nvarchar(max),
	UnitPrice money,
	Discount int,
	Img varchar(60),
	Quantity int,
	UnitInStock int,
	CreatedBy int FOREIGN KEY REFERENCES [Admin] (AdminID),
    ModifiedBy int FOREIGN KEY REFERENCES [Admin] (AdminID),
	CreatedDate date,
	ModifiedDate date
)

create table OrderDetails(
	ProductID int FOREIGN KEY REFERENCES Product(ProductID),
	OrderID int FOREIGN KEY REFERENCES [Order] (OrderID),
	Quantity int,
	Price money,
	Discount int,
	Primary key (ProductID, OrderID)
)

create table Guarantee(
	GuaranteeID int primary key identity(1,1),
	ProductID int FOREIGN KEY REFERENCES Product(ProductID),
	UserID int FOREIGN KEY REFERENCES [User] (UserID),
	StartDate date,
	EndDate date
)

create table RepairBill(
	BillID int primary key identity(1,1),
	UserID int FOREIGN KEY REFERENCES [User] (UserID),
	StartDate date,
	EndDate date,
	TotalPrice money,
	[Address] nvarchar(200),
	[Status] bit
)

create table Error(
	ErrorID int primary key identity(1,1),
	ErrorName nvarchar(60),
	ErrorDescription nvarchar(200)
)

create table RepairBillDetails(
	BillID int FOREIGN KEY REFERENCES RepairBill(BillID),
	ProductID int FOREIGN KEY REFERENCES Product(ProductID),
	ErrorID int FOREIGN KEY REFERENCES [Error] (ErrorID),
	Quantity int,
	Price money,
	Primary key (ProductID, BillID,ErrorID)
)

create table Comment(
	UserID int FOREIGN KEY REFERENCES [User] (UserID),
	ProductID int FOREIGN KEY REFERENCES Product(ProductID),
	Content nvarchar(max),
	CreateDate date,
	Primary key (ProductID, UserID)
)