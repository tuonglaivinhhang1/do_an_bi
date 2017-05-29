create table Accidents(
	AccidentIndex nvarchar(50) primary key,
	Longitude float,--kinh độ
	Latitude float,--vĩ độ
	AccidentSeverity nvarchar(50),
	NumberOfVehicles int,
	NumberOfCasualities int,
	Date nvarchar(20),
	DayOfWeek nvarchar(20),
	Time nvarchar(20),
	Location nvarchar(50),
	RoadType nvarchar(50),
	RoadClass nvarchar(50),--phân  loại đường theo chất lượng và chức năng
	SpeedMax float,--Tốc độ tối đa cho phép trên đường
	JunctionDetail nvarchar(100),--giao lộ
	JunctionControl  nvarchar(100),--điều khiển giao thông tại giao lộ
	LightConditions nvarchar(100),
	WeatherCondition nvarchar(100),
	RoadSurfaceCondition nvarchar(100),
	SpecialConditionsAtSite nvarchar(100),
	CarriageWayHazards nvarchar(100),--những nguy hiểm trên đường
	Area nvarchar(50)--Urban or Rural
)

create table Vehicles(
	AccidentIndex nvarchar(50) primary key,
	VehicleType nvarchar(50),
	VehicleManoeuvre nvarchar(100),--Thao tác của phương tiện khi xảy ra tai nạn
	VehicleLocation nvarchar(100),
	JunctionLocation nvarchar(100),
	SkiddingAndOverturning nvarchar(100),--phuong tiện có bị trượt hay lộn vòng không
	HitObjectInCarriageway  nvarchar(100),--Đối tượng (trong làn đường) bị xe đâm vào
	HitObjectOffCarriageway nvarchar(100),--Đối tượng (ngoài làn đường) bị xe đâm vào
	WasVehicleLeftHand nvarchar(50),
	JourneyPurpose nvarchar(50),
	SexOfDriver  nvarchar(50),
	AgeOfDriver int,
	EngineCapacity int,
	AgeOfVehicle int not null,
	PropulsionCode nvarchar(100)--Loại động cơ
)
create table Casualties(
	AccidentIndex nvarchar(50),
	CasualtyClass nvarchar(50),--Driver or rider, passenger, pedestrian
	SexOfCasualty nvarchar(50),
	AgeOfCasualty int,
	CasualtySeverity nvarchar(50),
	PedestrianLocation nvarchar(100),--Vị trí trên đường, nếu là pedestrian
	PedestrianMovement nvarchar(200),--Hành động tại thời điểm xảy ra tại nạn, nếu là pedestrian
	CarPassenger nvarchar(100),--Vị trí trên xe, nếu là car passenger
	BusOrCoachPassenger nvarchar(100),--Vị trí trên xe, nếu là bus/coach passenger
	CasualtyType nvarchar(100)--Các loại người liên quan khác, ngoài pedestrian/car/bus/coach passenger


)
select * from CasualtyType
--======================START TẠO STAGE=====================================
--mục đích các ID tự tăng trong Stage là để khỏi bị ghi đè bởi các ID giống nhau ở các nguồn
create database Stage_UKA
GO
create table Stage_Accidents(
	
	AccidentIndex nvarchar(50) primary key,
	Longitude float,--kinh độ
	Latitude float,--vĩ độ
	AccidentSeverity nvarchar(50),
	NumberOfVehicles int,
	NumberOfCasualities int,
	Date nvarchar(20),
	DayOfWeek nvarchar(20),
	Time nvarchar(20),
	Location nvarchar(50),
	RoadType nvarchar(50),
	RoadClass nvarchar(50),--phân  loại đường theo chất lượng và chức năng
	SpeedMax float,--Tốc độ tối đa cho phép trên đường
	JunctionDetail nvarchar(100),--giao lộ
	JunctionControl  nvarchar(100),--điều khiển giao thông tại giao lộ
	LightConditions nvarchar(100),
	WeatherCondition nvarchar(100),
	RoadSurfaceCondition nvarchar(100),
	SpecialConditionsAtSite nvarchar(100),
	CarriageWayHazards nvarchar(100),--những nguy hiểm trên đường
	Area nvarchar(50),--Urban or Rural
	DataSource int,
	Status int
)

create table Stage_Vehicles(
	ID int identity(1,1) primary key,
	IndexID int,--là identity trong các nguồn
	AccidentIndex nvarchar(50),
	VehicleType nvarchar(50),
	VehicleManoeuvre nvarchar(100),--Thao tác của phương tiện khi xảy ra tai nạn
	VehicleLocation nvarchar(100),
	JunctionLocation nvarchar(100),
	SkiddingAndOverturning nvarchar(100),--phuong tiện có bị trượt hay lộn vòng không
	HitObjectInCarriageway  nvarchar(100),--Đối tượng (trong làn đường) bị xe đâm vào
	HitObjectOffCarriageway nvarchar(100),--Đối tượng (ngoài làn đường) bị xe đâm vào
	WasVehicleLeftHand nvarchar(50),
	JourneyPurpose nvarchar(50),
	SexOfDriver  nvarchar(50),
	AgeOfDriver int,
	EngineCapacity int,
	AgeOfVehicle int not null,
	PropulsionCode nvarchar(100),--Loại động cơ
	DataSource int,
	Status int
)
create table Stage_Casualties(
	ID int identity(1,1) primary key,
	IndexID int,
	AccidentIndex nvarchar(50) ,
	CasualtyClass nvarchar(50),--Driver or rider, passenger, pedestrian
	SexOfCasualty nvarchar(50),
	AgeOfCasualty int,
	CasualtySeverity nvarchar(50),
	PedestrianLocation nvarchar(100),--Vị trí trên đường, nếu là pedestrian
	PedestrianMovement nvarchar(200),--Hành động tại thời điểm xảy ra tại nạn, nếu là pedestrian
	CarPassenger nvarchar(100),--Vị trí trên xe, nếu là car passenger
	BusOrCoachPassenger nvarchar(100),--Vị trí trên xe, nếu là bus/coach passenger
	CasualtyType nvarchar(100),--Các loại người liên quan khác, ngoài pedestrian/car/bus/coach passenger
	DataSource int,
	Status int
)	
--======================END TẠO STAGE=====================================
select count(*) from Accidents
select * from Accidents where AccidentIndex='201501ZT80122'
SELECT TOP 100 * FROM Accidents ORDER BY AccidentIndex;

truncate table Accidents;
alter table Accidents
add  TimeCreate datetime;
alter table Accidents
add TimeUpdate datetime;

GO
create trigger detect
on Accidents
for insert,update,delete
as begin
	DECLARE @Action as char(1);
    SET @Action = (CASE WHEN EXISTS(SELECT * FROM INSERTED)
                         AND EXISTS(SELECT * FROM DELETED)
                        THEN 'U'  -- Set Action to Updated.
                        WHEN EXISTS(SELECT * FROM INSERTED)
                        THEN 'I'  -- Set Action to Insert.
                        WHEN EXISTS(SELECT * FROM DELETED)
                        THEN 'D'  -- Set Action to Deleted.
                        ELSE NULL -- Skip. It may have been a "failed delete".   
                    END)
	
end
GO
create proc insertdate
	
	as
		declare @rows int
		set @rows=(select COUNT(*) from Accidents)
		while @rows>0
begin

		update Accidents
		set TimeCreate='12/12/2015',TimeUpdate='4/1/2017',Status=1

		set @rows=@rows-1
end

exec insertdate 

alter table Stage_Casualties
add Status int
truncate table Stage_Accidents

go
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
	Longitude float,--kinh độ
	Latitude float,--vĩ độ
	SevertyDT int,
	NumberOfVehicles int,
	NumberOfCasualities int,
	Date nvarchar(20),
	DayOfWeek nvarchar(20),
	Time nvarchar(20),
	LocationDT int,
	RoadType nvarchar(50),
	RoadClass int,
	SpeedMax float,--Tốc độ tối đa cho phép trên đường
	JunctionDetail nvarchar(100),--giao lộ
	JunctionControl  nvarchar(100),--điều khiển giao thông tại giao lộ
	LightConditions nvarchar(100),
	WeatherCondition nvarchar(100),
	RoadSurfaceCondition nvarchar(100),
	SpecialConditionsAtSite nvarchar(100),
	CarriageWayHazards nvarchar(100),--những nguy hiểm trên đường
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
	PedestrianLocation nvarchar(100),--Vị trí trên đường, nếu là pedestrian
	PedestrianMovement nvarchar(200),--Hành động tại thời điểm xảy ra tại nạn, nếu là pedestrian
	CarPassenger nvarchar(100),--Vị trí trên xe, nếu là car passenger
	BusOrCoachPassenger nvarchar(100),--Vị trí trên xe, nếu là bus/coach passenger
	CasualtyTypeDT int,--Các loại người liên quan khác, ngoài pedestrian/car/bus/coach passenger
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
	VehicleManoeuvre nvarchar(100),--Thao tác của phương tiện khi xảy ra tai nạn
	VehicleLocation nvarchar(100),
	JunctionLocation nvarchar(100),
	SkiddingAndOverturning nvarchar(100),--phuong tiện có bị trượt hay lộn vòng không
	HitObjectInCarriageway  nvarchar(100),--Đối tượng (trong làn đường) bị xe đâm vào
	HitObjectOffCarriageway nvarchar(100),--Đối tượng (ngoài làn đường) bị xe đâm vào
	WasVehicleLeftHand nvarchar(50),
	JourneyPurposeDT int,
	SexOfDriver  nvarchar(50),
	AgeOfDriver int,
	EngineCapacity int,
	AgeOfVehicle int not null,
	PropulsionCode nvarchar(100),--Loại động cơ
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


--=============end create NDS====================


select* from Data_Flow
IF  NOT EXISTS (SELECT * FROM sys.tables
WHERE name = N'Tempt_Location' AND type = 'U')

BEGIN
create table Tempt_Location
(
Name nvarchar(50),
TimeCreate datetime,
TimeUpdate datetime,
Status int,
DataSource int
)
END

truncate table Accidents
select * from Accidents
select * from DataSource
select * from Status
select * from Severty
select * from Area
select * from Location
select * from Stage_Accidents
select * from Tempt_Location
select * from RoadCLass
select * from Stage_Accidents where Status is null

INSERT INTO Location (Name,TimeCreate,TimeUpdate,Status,DataSource)
SELECT t1.Name,t1.TimeCreate,t1.TimeUpdate,t1.Status,t1.DataSource
FROM Tempt_Location t1
WHERE
NOT EXISTS( SELECT 1
    FROM Location t2
    WHERE t1.Name = t2.Name)

select distinct Name from Location




insert into Stage_AccidentsCopy (AccidentIndex,AccidentSeverity,Location,RoadClass,Area,DataSource,Status)
values('A10','Normal','VN','A','HCM','1','1')
insert into Stage_AccidentsCopy (AccidentIndex,AccidentSeverity,Location,RoadClass,Area,DataSource,Status)
values('A11','Heavy','UK','C','HN','1','1')
insert into Stage_AccidentsCopy (AccidentIndex,AccidentSeverity,Location,RoadClass,Area,DataSource,Status)
values('A12','Slight','US','2','1')
insert into Stage_AccidentsCopy (AccidentIndex,AccidentSeverity,Location,RoadClass,Area,DataSource,Status)
values('A13','Normal','KI','2','1')
insert into Stage_AccidentsCopy (AccidentIndex,AccidentSeverity,Location,RoadClass,Area,DataSource,Status)
values('A14','Slight','IT','1','1')
insert into Stage_AccidentsCopy (AccidentIndex,AccidentSeverity,Location,RoadClass,Area,DataSource,Status)
values('A15','Normal','FR','1','1')
insert into Stage_AccidentsCopy (AccidentIndex,AccidentSeverity,Location,RoadClass,Area,DataSource,Status)
values('A16','Weak','US','1','1')

go






truncate table DataSource

DBCC CHECKIDENT (Location, RESEED, 0)


alter table Vehicles
add Status int
go
alter table Vehicles
add TimeCreate datetime
alter table Vehicles
add TimeUpdate datetime
go
alter table Vehicles
add IndexID int identity(1,1) primary key
go

alter table Casualties
add Status int
go
alter table Casualties
add TimeCreate datetime
go
alter table Casualties
add TimeUpdate datetime
go
alter table Casualties
add IndexID int identity(1,1) primary key
go
update  Vehicles
set TimeCreate ='1/1/2016'
go
update  Vehicles
set TimeUpdate ='1/1/2017'
go
update  Vehicles
set Status =1
go
update  Casualties
set TimeCreate ='1/1/2016'
go
update  Casualties
set TimeUpdate ='1/1/2017'
go
update  Casualties
set Status =1

go
alter table Accidents
add Status int
go
alter table Accidents
add TimeCreate datetime
alter table Accidents
add TimeUpdate datetime
go
update  Accidents
set TimeCreate ='1/1/2016'

update  Accidents
set TimeUpdate ='1/1/2017'
go
update  Accidents
set Status =1




select* from Stage_Accidents where Date is not null

select * from Accidents
go

alter table Stage_Vehicles
add Status int

select Lo.MaLocation,Lo.Name as "NameLocation", Lo.Status as "LoStatus",Lo.TimeCreate as "LoTimeCreate",
Lo.TimeUpdate as "LoTimeUpdate",Lo.DataSource as"LoDataSource",  Se.MaSeverty,Se.Name as "NameSeverTy",
Se.Status as "SeStatus",Se.TimeCreate as "SeTimeCreate",Se.TimeUpdate as "SeTimeUpdate",Se.DataSource as "SeDataSource",
 Ro.MaRoadClass,Ro.Name as "RoadclassName",Ro.Status as "RoStatus", Ro.TimeCreate as "RoTimeCreate", Ro.TimeUpdate as "RoTimeUpdate",
 Ro.DataSource as "RoDataSource",Ar.MaArea,Ar.Name as "AreaName",Ar.Status as "ArStatus",Ar.TimeCreate as "ArTimecreate",
 Ar.TimeUpdate as "ArTimeUpdate", Ar.DataSource as "ArDataSource", Ad.AccidentIndex,Ad.AreaDT,
 Ad.CarriageWayHazards,Ad.DataSource as "AdDatasource",Ad.Date,Ad.DayOfWeek,Ad.JunctionControl,Ad.JunctionDetail,Ad.Latitude,
 Ad.LightConditions,Ad.LocationDT,Ad.Longitude,Ad.MaAccidents,Ad.NumberOfCasualities,Ad.NumberOfVehicles,Ad.RoadClass,
 Ad.RoadSurfaceCondition,Ad.RoadType,Ad.SevertyDT,Ad.SpecialConditionsAtSite,Ad.SpeedMax,Ad.Status as "Adstatus",
 Ad.Time ,Ad.TimeCreate as "AdTimeCreate",Ad.TimeUpdate as "AdTimeUpdate",Ad.WeatherCondition

 from Location as "Lo",RoadClass as "Ro",Area as "Ar",Severty as "Se",Accidents as "Ad"

where Lo.MaLocation=Ro.MaRoadClass and Ro.MaRoadClass=Ar.MaArea and  Ar.MaArea=Se.MaSeverty and Ad.MaAccidents=Lo.MaLocation

--truncate table Stage_Accidents
select AccidentSeverity,DataSource from Stage_Accidents group by AccidentSeverity,DataSource
select * from Location

insert into Location
values('d',1/1/2010,1/1/2010,1,2)

select TOP 10 * from Stage_Casualties order by IndexID desc

select * from Stage_Casualties where IndexID=721235

select * from Casualties

select count(*) from Vehicles

--------------------THIẾT KẾ DDS------------------------
create database DDS;
GO

create table Fact1
(
	DateID int,
	SevertyID int,
	LocationID int,
	ThoiDiemID int,
	SoTNGT int
	--primary key(DateID,SevertyID,LocationID,ThoiDiemID)
)

create table Severty
(
	SevertyID  int identity(1,1) primary key,
	NameSeverty nvarchar(100)
)

create table Location
(
	LocationID int identity(1,1) primary key,
	NameLocation nvarchar(100)
)
create table ThoiDiem
(
	ThoiDiemID int identity(1,1) primary key,
	NameThoiDiem nvarchar(100),
	TimeStart nvarchar(20),
	TimeEnd nvarchar(20)

)

insert into ThoiDiem(NameThoiDiem,TimeStart,TimeEnd)
values('Morning','6:00','12:00')
insert into ThoiDiem(NameThoiDiem,TimeStart,TimeEnd)
values('Afternoon','12:01','17:00')
insert into ThoiDiem(NameThoiDiem,TimeStart,TimeEnd)
values('Evening','17:01','20:00')
insert into ThoiDiem(NameThoiDiem,TimeStart,TimeEnd)
values('Night','20:01','5:59')

create table Date
(
	DateID int identity(1,1) primary key,
	FullDate nvarchar(20),
	DayID int
)
create table Day
(
	DayID int identity(1,1) primary key,
	DayName int,
	MonthID int
)
create table Month
(
	MonthID int identity(1,1) primary key,
	MonthName int,
	QuarterID int
)
create table Quarter
(
	QuarterID int identity(1,1) primary key,
	QuarterName int,
	YearID int
)
create table Year
(
	YearID int identity(1,1) primary key,
	YearName int
)


alter table Fact1
add constraint FK1
foreign key(DateID) references Date(DateID)



alter table Fact1
add constraint FK2
foreign key(LocationID) references Location(LocationID)


alter table Fact1
add constraint FK3
foreign key(SevertyID) references Severty(SevertyID)


alter table Fact1
add constraint FK4
foreign key(ThoiDiemID) references ThoiDiem(ThoiDiemID)




alter table Date
add constraint FK5
foreign key(DayID) references Day(DayID)

alter table Day
add constraint FK6
foreign key(MonthID) references Month(MonthID)

alter table Month
add constraint FK7
foreign key(QuarterID) references Quarter(QuarterID)

alter table Quarter
add constraint FK8
foreign key(YearID) references Year(YearID)


create table Fact2
(
	DateID int,
	CasualtyTypeID int,
	AgeGroupID int,
	GenderID int,
	SoNguoiChet int
)

create table CasualtyType
(
	CasualtyTypeID int identity(1,1) primary key,
	NameCasualtyType nvarchar(100),
	Age int
)
create table AgeGroup
(
	AgeGroupID int identity(1,1) primary key,
	NameAgeGroup nvarchar(100),
	FromAge int,
	ToAge int
)
create table Gender
(
	GenderID int identity(1,1) primary key,
	NameGender nvarchar(50)
)

insert into AgeGroup(NameAgeGroup,FromAge,ToAge)
values('Group1',0,4)
insert into AgeGroup(NameAgeGroup,FromAge,ToAge)
values('Group2',5,7)
insert into AgeGroup(NameAgeGroup,FromAge,ToAge)
values('Group3',8,11)
insert into AgeGroup(NameAgeGroup,FromAge,ToAge)
values('Group4',12,15)
insert into AgeGroup(NameAgeGroup,FromAge,ToAge)
values('Group5',16,19)
insert into AgeGroup(NameAgeGroup,FromAge,ToAge)
values('Group6',20,24)
insert into AgeGroup(NameAgeGroup,FromAge,ToAge)
values('Group7',25,59)
insert into AgeGroup(NameAgeGroup,FromAge,ToAge)
values('Group8',60,64)
insert into AgeGroup(NameAgeGroup,FromAge,ToAge)
values('Group9',65,69)
insert into AgeGroup(NameAgeGroup,FromAge,ToAge)
values('Group10',70,74)
insert into AgeGroup(NameAgeGroup,FromAge,ToAge)
values('Group11',75,79)
insert into AgeGroup(NameAgeGroup,FromAge,ToAge)
values('Group12',80,200)

insert into AgeGroup(NameAgeGroup,FromAge,ToAge)
values('Children',0,15)

insert into AgeGroup(NameAgeGroup,FromAge,ToAge)
values('Young adult',0,17)

insert into AgeGroup(NameAgeGroup,FromAge,ToAge)
values('Adult',18,59)

insert into AgeGroup(NameAgeGroup,FromAge,ToAge)
values('60 and over',60,200)

alter table Fact2
add constraint FK9
foreign key (DateID) references Date(DateID)

alter table Fact2
add constraint FK10
foreign key (CasualtyTypeID) references CasualtyType(CasualtyTypeID)

alter table Fact2
add constraint FK11
foreign key (AgeGroupID) references AgeGroup(AgeGroupID)

alter table Fact2
add constraint FK12
foreign key (GenderID) references Gender(GenderID)


create table Fact3
(
	DateID int,
	SevertyID int,
	AreaID int,
	RoadClassID int,
	SpeedMaxID int,
	SoTNGT int
)
create table Area
(
	AreaID int identity(1,1) primary key,
	NameArea nvarchar(100)
)
create table RoadClass
(
	RoadClassID int identity(1,1) primary key,
	NameRoadClass nvarchar(100)
)
create table SpeedMax
(
	SpeedMaxID int identity(1,1) primary key,
	SpeedMaxValue float
)

alter table Fact3
add constraint FK13
foreign key (DateID) references Date(DateID)

alter table Fact3
add constraint FK14
foreign key (SevertyID) references Severty(SevertyID)

alter table Fact3
add constraint FK15
foreign key (AreaID) references Area(AreaID)

alter table Fact3
add constraint FK16
foreign key (RoadClassID) references RoadClass(RoadClassID)

alter table Fact3
add constraint FK17
foreign key (SpeedMaxID) references SpeedMax(SpeedMaxID)


create table Fact4
(
	JourneyPurposeID int,
	VehicleTypeID int,
	SoTNGT int
)
create table JourneyPurpose
(
	JourneyPurposeID int identity(1,1) primary key,
	NameJourneyPurpose nvarchar(100)
)
create table VehicleType
(
	VehicleTypeID int identity(1,1) primary key,
	NameVehicleType nvarchar(100)
)

alter table Fact4
add constraint FK18
foreign key (JourneyPurposeID) references JourneyPurpose(JourneyPurposeID)

alter table Fact4
add constraint FK19
foreign key (VehicleTypeID) references VehicleType(VehicleTypeID)

create table Fact5
(
	DateID int,
	SevertyID int,
	RoadClassID int,
	RoadClassificationID int,
	VehicleTypeID int,
	SoTNGT int
)
create table RoadClassification
(
	
	RoadClassificationID int identity(1,1) primary key,
	NameRoadClassification nvarchar(200)
)

alter table Fact5
add constraint FK20
foreign key (DateID) references Date(DateID)

alter table Fact5
add constraint FK21
foreign key (SevertyID) references Severty(SevertyID)


alter table Fact5
add constraint FK22
foreign key (RoadClassID) references RoadClass(RoadClassID)

alter table Fact5
add constraint FK23
foreign key (RoadClassificationID) references RoadClassification(RoadClassificationID)

alter table Fact5
add constraint FK24
foreign key (VehicleTypeID) references VehicleType(VehicleTypeID)

-------------------------END DDS----------------------------
select Top 100 * from Accidents order by Date asc

select MonthName,QuarterName,YearName from Year Y ,Quarter Q,Month M where Y.YearID=Q.YearID and M.QuarterID=Q.QuarterID
DBCC CHECKIDENT (Month, RESEED, 0)


(Month == 1 || Month == 2 || Month == 3) ? 1 : (Month == 4 || Month == 5 || Month == 6) ? 2 : (Month == 7 || Month == 8 || Month == 9) ? 3 : (Month == 10 || Month == 11 || Month == 12) ? 4 : 0

select * from Day
select AgeOfCasualty,Name
from Casualties C,CasualtyType CT
where C.CasualtyTypeDT=CT.MaCasualtyType

select * from Gender

DBCC CHECKIDENT (Severty, RESEED, 0)

delete Severty