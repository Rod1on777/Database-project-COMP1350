-- create schema ass2;
use ass2;

create table Reserve(
	ReserveID varchar(2),
    Reservename varchar(35),
    Reservelocation varchar(25),
    ReserveSize int(3),
    
    primary key (ReserveID)
);

create table Vehicle(
	VehicleID varchar(2),
    ReserveID varchar(2),
    VehicleType varchar(15),
    VehicleCapacity int(2),
    VehicleRegoNum varchar(6),
    
    primary key (VehicleID, ReserveID),
    foreign key (ReserveID) references Reserve(ReserveID)
);

create table Tour(
	TourID varchar(2),
    TourName varchar(25),
    TourCost decimal(5,2),
    TourDuration int(1),
    
    primary key (TourID)
);

create table Staff(
	StaffID varchar(2),
    StaffName varchar(20),
    StaffPosition varchar(20),
    StaffSalary decimal(8,2),
    
    primary key (StaffID)
);

create table VisitorGroup(
	VisGroupID varchar(3),
    VisGroupName varchar(20),
    VisGroupCountry varchar(15),
    VisGroupNumPeople int(2),
    
    primary key (VisGroupID)
);

create table Booking(
	BookingID varchar(3),
    TourID varchar(2),
    VehicleID varchar(2),
    ReserveID varchar(2),
    VisGroupID varchar(3),
    StaffID varchar(2),
    BookingDate date,
    BookingTime time,
    
    primary key (BookingID),
    foreign key (TourID) references Tour(TourID),
    foreign key (VehicleID) references Vehicle(VehicleID),
    foreign key (ReserveID) references Reserve(ReserveID),
    foreign key (VisGroupID) references VisitorGroup(VisGroupID),
    foreign key (StaffID) references Staff(StaffID)
);

create table Organisation(
	OrganisationID varchar(2),
    OrganisationName varchar(20),
    OrganisationManager varchar(20),
    OrgContactNumber varchar(14),
    
    primary key (OrganisationID)
);

create table Partnership(
	ReserveID varchar(2), 
    OrganisationID varchar(2),
    StartDate date,
    EndDate date,
    Amount decimal(10,2),
    
    primary key (ReserveID, OrganisationID),
    foreign key (ReserveID) references Reserve(ReserveID),
    foreign key (OrganisationID) references Organisation(OrganisationID)
);

create table TourPackage(
	PackageTourID  varchar(2),
    ComponentTourID varchar(2),
    
    primary key (PackageTourID ,ComponentTourID),
    foreign key (PackageTourID) references Tour(TourID),
    foreign key (ComponentTourID) references Tour(TourID)
);