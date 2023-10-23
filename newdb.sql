create database eComOrganic
go

use eComOrganic
go

Create table Staff
(
	UserName nvarchar(256) primary key,
	Password nvarchar(256),
	DisplayName nvarchar(256),
	Active bit,
	StaffType int
)
go

create table Discount
(
	Id uniqueidentifier primary key,
	Code nvarchar(20),
	IsPercent bit,
	Value DECIMAL(10, 2),
	ExpDate datetime,
	IsShip bit,
	Remaining int,
	Created nvarchar(256),
	DiscountType int,

	foreign key (Created) references Staff(UserName)
)
go

create table CustomerRank
(
	Id uniqueidentifier primary key,
	UserRank nvarchar(256),
)
go	


Create table RankDiscount
(
	DiscountId uniqueidentifier,
	RankId uniqueidentifier,
	Active bit,

	Primary key (DiscountId, RankId),

	foreign key (DiscountId) references Discount(Id),
	foreign key (RankId) references CustomerRank(Id)
)
go

create table Customer
(
	Email nvarchar(100) primary key,
	Name nvarchar(100),
	Phone varchar(20),
	Password nvarchar(256),
	Birdth datetime,
	Gender int,
	Role int,
	IsEmailVerified bit,
	RankId uniqueidentifier,

	foreign key (RankId) references CustomerRank(Id)
)
go


create table Address
(
	Id uniqueidentifier primary key,
	Email nvarchar(100),
	Name nvarchar(100),
	Phone nvarchar(20),
	Address nvarchar(256),

	foreign key (Email) references Customer(Email)
)
go

create table Category
(
	Id uniqueidentifier primary key,
	Name nvarchar(100),
	Slug nvarchar(100),
	Image nvarchar(256),
	Status bit
)
go

create table Product
(
	Id uniqueidentifier primary key,
	Category uniqueidentifier,
	Producer nvarchar(256),
	Name nvarchar(100),
	Description ntext,
	code nvarchar(256),
	Status bit,
	Price int

	foreign key (Category) references Category(Id)
)
go

create table ProductImage
(
	Id uniqueidentifier primary key,
	ProductId uniqueidentifier,
	Image nvarchar(256),
	Alt nvarchar(256),

	foreign key (ProductId) references Product(Id)

)

create table ProductDiscount
(
	ProductID uniqueidentifier,
	DiscountID uniqueidentifier,
	Active bit,

	Primary key (ProductID, DiscountID),

	foreign key (DiscountId) references Discount(Id),
	foreign key (ProductID) references Product(Id)
)
go

create table CustomerCart
(
	Email nvarchar(100),
	ProductId uniqueidentifier,
	Amount int,

	Primary key (Email, ProductId),

	foreign key (Email) references Customer(Email),
	foreign key (ProductID) references Product(Id)
)
go

create table Comment
(
	Id uniqueidentifier primary key,
	ProductId uniqueidentifier,
	Email nvarchar(100),
	Comment ntext,

	foreign key (ProductId) references Product(Id),
	foreign key (Email) references Customer(Email)
)
go

create table Bill
(
	Id uniqueidentifier primary key,
	Address uniqueidentifier,
	Discount uniqueidentifier,
	Refund bit,
	Paid bit,
	Ship Int,
	Status int,
	Verifed bit,

	foreign key (Address) references Address(Id),
	foreign key (Discount) references Discount(Id)
)
go

create table BillInfo
(
	Bill uniqueidentifier,
	ProductId uniqueidentifier,
	Amount int,
	Price DECIMAL(10, 2)

	primary key (Bill, ProductId),

	foreign key (Bill) references Bill(Id),
	foreign key (ProductId) references Product(Id),
)
go

create table Supplier
(
	Id uniqueidentifier primary key,
	Name nvarchar(100),
	Phone varchar(20),
	Address nvarchar(256)
)
go

create table Import
(
	Id uniqueidentifier primary key,
	UserName nvarchar(256),
	SuplierId uniqueidentifier,
	Date DateTime,

	foreign key (UserName) references Staff(UserName),
	foreign key (SuplierId) references Supplier(Id)
)
go

create table ImportInfo
(
	Import uniqueidentifier,
	ProductId uniqueidentifier,
	Amount Int,
	Price DECIMAL(10, 2),

	primary key (Import, ProductId),

	foreign key (Import) references Import(Id),
	foreign key (ProductId) references Product(Id)
)
go