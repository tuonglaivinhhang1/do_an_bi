--===============Start create NDS===================
create database NDS_UKA

GO

create table DataSource(
	MaDataSource int identity(1,1) primary key,
	Name nvarchar(100),
	TimeCreate datetime,
	TimeUpdate datetime,
	Status int
)
create table Status(
	MaStatus int identity(1,1) primary key,
	Name nvarchar(50),
	TimeCreate datetime,
	TimeUpdate datetime
)


create table Severty(
	MaSeverty int identity(1,1) primary key,
	Name nvarchar(100),
	TimeCreate datetime,
	TimeUpdate datetime,
	Status int,
	DataSource int
)
create table Location(
	MaLocation int identity(1,1) primary key,
	Name nvarchar(100),
	TimeCreate datetime,
	TimeUpdate datetime,
	Status int,
	DataSource int
)

create table RoadClass(
	MaRoadClass int identity(1,1) primary key,
	Name nvarchar(100),
	TimeCreate datetime,
	TimeUpdate datetime,
	Status int,
	DataSource int
)

create table VehicleType(
	MaVehicleType int identity(1,1) primary key,
	Name nvarchar(100),
	TimeCreate datetime,
	TimeUpdate datetime,
	Status int,
	DataSource int
)
create table Area(
	MaArea int identity(1,1) primary key,
	Name nvarchar(100),
	TimeCreate datetime,
	TimeUpdate datetime,
	Status int,
	DataSource int
)
create table Accidents(
	MaAccidents int identity(1,1) primary key,
	AccidentIndex nvarchar(50),
	Longitude float,--kinh d?
	Latitude float,--vi d?
	SevertyDT int,
	NumberOfVehicles int,
	NumberOfCasualities int,
	Date nvarchar(20),
	DayOfWeek nvarchar(20),
	Time nvarchar(20),
	LocationDT int,
	RoadType nvarchar(50),
	RoadClass int,
	SpeedMax float,--T?c d? t?i da cho phép trên du?ng
	JunctionDetail nvarchar(100),--giao l?
	JunctionControl  nvarchar(100),--di?u khi?n giao thông t?i giao l?
	LightConditions nvarchar(100),
	WeatherCondition nvarchar(100),
	RoadSurfaceCondition nvarchar(100),
	SpecialConditionsAtSite nvarchar(100),
	CarriageWayHazards nvarchar(100),--nh?ng nguy hi?m trên du?ng
	AreaDT int,
	TimeCreate datetime,
	TimeUpdate datetime,
	Status int,
	DataSource int
)

create table Casualtyclass(
	MaCasualtyclass int identity(1,1) primary key,
	Name nvarchar(100),
	TimeCreate datetime,
	TimeUpdate datetime,
	Status int,
	DataSource int
)

create table CasualtyType(
	MaCasualtyType int identity(1,1) primary key,
	Name nvarchar(100),
	TimeCreate datetime,
	TimeUpdate datetime,
	Status int,
	DataSource int
)
create table Casualties(
	MaCasualties int identity(1,1) primary key,
	IndexID int,--lay tu stage
	Ma_AccidentIndex int,
	CasualtyClassDT int,--Driver or rider, passenger, pedestrian
	SexOfCasualty nvarchar(50),
	AgeOfCasualty int,
	SeverityDT int,
	PedestrianLocation nvarchar(100),--V? trí trên du?ng, n?u là pedestrian
	PedestrianMovement nvarchar(200),--Hành d?ng t?i th?i di?m x?y ra t?i n?n, n?u là pedestrian
	CarPassenger nvarchar(100),--V? trí trên xe, n?u là car passenger
	BusOrCoachPassenger nvarchar(100),--V? trí trên xe, n?u là bus/coach passenger
	CasualtyTypeDT int,--Các lo?i ngu?i liên quan khác, ngoài pedestrian/car/bus/coach passenger
	TimeCreate datetime,
	TimeUpdate datetime,
	Status int,
	DataSource int
)


create table JourneyPurpose(
	MaJourneyPurpose int identity(1,1) primary key,
	Name nvarchar(100),
	TimeCreate datetime,
	TimeUpdate datetime,
	Status int,
	DataSource int
)
create table Vehicles(
	MaVehicles int identity(1,1) primary key,
	IndexID int,--lay tu stage
	Ma_AccidentIndex int,
	VehicleTypeDT int,
	VehicleManoeuvre nvarchar(100),--Thao tác c?a phuong ti?n khi x?y ra tai n?n
	VehicleLocation nvarchar(100),
	JunctionLocation nvarchar(100),
	SkiddingAndOverturning nvarchar(100),--phuong ti?n có b? tru?t hay l?n vòng không
	HitObjectInCarriageway  nvarchar(100),--Ð?i tu?ng (trong làn du?ng) b? xe dâm vào
	HitObjectOffCarriageway nvarchar(100),--Ð?i tu?ng (ngoài làn du?ng) b? xe dâm vào
	WasVehicleLeftHand nvarchar(50),
	JourneyPurposeDT int,
	SexOfDriver  nvarchar(50),
	AgeOfDriver int,
	EngineCapacity int,
	AgeOfVehicle int not null,
	PropulsionCode nvarchar(100),--Lo?i d?ng co
	TimeCreate datetime,
	TimeUpdate datetime,
	Status int,
	DataSource int
)

--update Casualties
--set Ma_AccidentIndex=?,VehicleTypeDT=?,VehicleManoeuvre=?,
--VehicleLocation=?,JunctionLocation=?,SkiddingAndOverturning=?,HitObjectInCarriageway=?,
--HitObjectOffCarriageway=?,WasVehicleLeftHand=?,JourneyPurposeDT=?,SexOfDriver=?,
--AgeOfDriver=?,EngineCapacity=?,AgeOfVehicle=?,PropulsionCode=?,
--TimeUpdate=?,Status=?,DataSource=?



alter table DataSource
add constraint FK1
foreign key (Status) references Status(MaStatus)


alter table Severty
add constraint FK4
foreign key (Status) references Status(MaStatus)
alter table Severty
add constraint FK5
foreign key (DataSource) references DataSource(MaDataSource)

alter table Location
add constraint FK6
foreign key (Status) references Status(MaStatus)
alter table Location
add constraint FK7
foreign key (DataSource) references DataSource(MaDataSource)


alter table RoadClass
add constraint FK10
foreign key (Status) references Status(MaStatus)
alter table RoadClass
add constraint FK11
foreign key (DataSource) references DataSource(MaDataSource)


alter table VehicleType
add constraint FK14
foreign key (Status) references Status(MaStatus)
alter table VehicleType
add constraint FK15
foreign key (DataSource) references DataSource(MaDataSource)

alter table Area
add constraint FK16
foreign key (Status) references Status(MaStatus)
alter table Area
add constraint FK17
foreign key (DataSource) references DataSource(MaDataSource)


alter table Accidents
add constraint FK19
foreign key (LocationDT) references Location(MaLocation)


alter table Accidents
add constraint FK21
foreign key (RoadClass) references RoadClass(MaRoadClass)


alter table Accidents
add constraint FK23
foreign key (AreaDT) references Area(MaArea)


alter table Accidents
add constraint FK24
foreign key (Status) references Status(MaStatus)
alter table Accidents
add constraint FK25
foreign key (Datasource) references Datasource(MaDatasource)

alter table Casualtyclass
add constraint FK26
foreign key (Status) references Status(MaStatus)
alter table Casualtyclass
add constraint FK27
foreign key (DataSource) references DataSource(MaDataSource)

alter table CasualtyType
add constraint FK28
foreign key (Status) references Status(MaStatus)
alter table CasualtyType
add constraint FK29
foreign key (DataSource) references DataSource(MaDataSource)


alter table Casualties
add constraint FK30
foreign key (Ma_AccidentIndex) references Accidents(MaAccidents)

alter table Casualties
add constraint FK31
foreign key (CasualtyClassDT) references CasualtyClass(MaCasualtyClass)

alter table Casualties
add constraint FK32
foreign key (SeverityDT) references Severty(MaSeverty)

alter table Casualties
add constraint FK33
foreign key (CasualtyTypeDT) references CasualtyType(MaCasualtyType)

alter table Casualties
add constraint FK34
foreign key (Status) references Status(MaStatus)
alter table Casualties
add constraint FK35
foreign key (Datasource) references Datasource(MaDatasource)



alter table JourneyPurpose
add constraint FK36
foreign key (Status) references Status(MaStatus)
alter table JourneyPurpose
add constraint FK37
foreign key (DataSource) references DataSource(MaDataSource)



alter table Vehicles
add constraint FK40
foreign key (Ma_AccidentIndex) references Accidents(MaAccidents)



alter table Vehicles
add constraint FK41
foreign key (VehicleTypeDT) references VehicleType(MaVehicleType)



alter table Vehicles
add constraint FK42
foreign key (JourneyPurposeDT) references JourneyPurpose(MaJourneyPurpose)

alter table Vehicles
add constraint FK44
foreign key (Status) references Status(MaStatus)
alter table Vehicles
add constraint FK45
foreign key (Datasource) references Datasource(MaDatasource)

SET IDENTITY_INSERT Status OFF;  
SET IDENTITY_INSERT DataSource OFF;  

insert into Status(Name,TimeCreate,TimeUpdate)
values('Enable',2017-01-01,2017-01-01)
insert into Status(Name,TimeCreate,TimeUpdate)
values('Disable',2017-01-01,2017-01-01)

insert into DataSource(Name,TimeCreate,TimeUpdate,Status)
values('SQL1',2017-01-01,2017-01-01,1)
insert into DataSource(Name,TimeCreate,TimeUpdate,Status)
values('SQL2',2017-01-01,2017-01-01,1)
insert into DataSource(Name,TimeCreate,TimeUpdate,Status)
values('Excel',2017-01-01,2017-01-01,1)
