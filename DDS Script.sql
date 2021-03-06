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
values('Night','17:01','05:59')


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
create table AgeGroup1
(
	AgeGroupID int identity(1,1) primary key,
	NameAgeGroup nvarchar(100),
	FromAge int,
	ToAge int
)
create table AgeGroup2--phân loại childeren,adult..
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

insert into AgeGroup1(NameAgeGroup,FromAge,ToAge)
values('Group1',0,4)
insert into AgeGroup1(NameAgeGroup,FromAge,ToAge)
values('Group2',5,7)
insert into AgeGroup1(NameAgeGroup,FromAge,ToAge)
values('Group3',8,11)
insert into AgeGroup1(NameAgeGroup,FromAge,ToAge)
values('Group4',12,15)
insert into AgeGroup1(NameAgeGroup,FromAge,ToAge)
values('Group5',16,19)
insert into AgeGroup1(NameAgeGroup,FromAge,ToAge)
values('Group6',20,24)
insert into AgeGroup1(NameAgeGroup,FromAge,ToAge)
values('Group7',25,59)
insert into AgeGroup1(NameAgeGroup,FromAge,ToAge)
values('Group8',60,64)
insert into AgeGroup1(NameAgeGroup,FromAge,ToAge)
values('Group9',65,69)
insert into AgeGroup1(NameAgeGroup,FromAge,ToAge)
values('Group10',70,74)
insert into AgeGroup1(NameAgeGroup,FromAge,ToAge)
values('Group11',75,79)
insert into AgeGroup1(NameAgeGroup,FromAge,ToAge)
values('Group12',80,200)

insert into AgeGroup2(NameAgeGroup,FromAge,ToAge)
values('Children',0,15)

insert into AgeGroup2(NameAgeGroup,FromAge,ToAge)
values('Young adult',0,17)

insert into AgeGroup2(NameAgeGroup,FromAge,ToAge)
values('Adult',18,59)

insert into AgeGroup2(NameAgeGroup,FromAge,ToAge)
values('60 and over',60,200)

alter table Fact2
add constraint FK9
foreign key (DateID) references Date(DateID)

alter table Fact2
add constraint FK10
foreign key (CasualtyTypeID) references CasualtyType(CasualtyTypeID)

alter table Fact2
add constraint FK11
foreign key (AgeGroupID) references AgeGroup1(AgeGroupID)

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
	NameRoadClassification nvarchar(200),
	StartSpeedMax float,
	EndSpeedMax float

)

insert into RoadClassification(NameRoadClassification,StartSpeedMax,EndSpeedMax)
values('Built-up road',0,50)
insert into RoadClassification(NameRoadClassification,StartSpeedMax,EndSpeedMax)
values('Non Built-up road',50,10000)


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


create table Fact6
(
	DateID int,
	CasualtyTypeID int,
	AgeGroupID int,
	SoTNGT int
)
alter table Fact6
add constraint FK25
foreign key (DateID) references Date(DateID)

alter table Fact6
add constraint FK26
foreign key (CasualtyTypeID) references CasualtyType(CasualtyTypeID)

alter table Fact6
add constraint FK27
foreign key (AgeGroupID) references AgeGroup2(AgeGroupID)
