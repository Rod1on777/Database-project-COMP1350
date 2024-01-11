use ass2;

-- LEVEL ONE
-- TASK 1
select TourID, TourName, concat('$', TourCost) as TourCost, concat(TourDuration, ' hours') as TourDuration
from Tour
order by TourCost desc;


-- TASK 2
select BookingID, BookingTime as 'Tour Start Time', addtime(BookingTime, sec_to_time(TourDuration*60*60)) as 'Tour End Time'
from Booking b
inner join Tour t
using(TourID)
where BookingTime is not null
order by TourID;

-- TASK 3
select BookingID, BookingDate, ReserveName
from Reserve
inner join booking
using (reserveID)
inner join vehicle
using (vehicleID, reserveID)
where ReserveSize > 300 and VehicleCapacity >= 7 and BookingDate > date_add(current_date(), INTERVAL 6 month)
order by VehicleID;

-- TASK 4
select distinct ReserveName, concat(ReserveSize, ' hectares') as ReserveSize
from Reserve
where ReserveID in (select reserveID
	from vehicle
	where VehicleRegoNum like '%b%')
order by ReserveSize desc;

-- TASK 5
select ReserveID, count(ReserveID) as 'Bookings Per Reserve'
from Booking
where BookingTime < '10:00:00'
group by ReserveID;

-- LEVEL TWO
-- TASK 6
select StaffName, ifnull(BookingDate, 'No Booking') as BookingDate
from Booking
right join Staff
using (StaffID)
where (month(BookingDate)  = 10 or BookingDate is null) and (StaffPosition = 'reserve manager' or StaffPosition = 'senior tour guide') and (StaffSalary >= 70000.00);

-- TASK 7
select distinct VisGroupCountry, StaffName
from Booking
inner join Tour
using(TourID)
inner join Staff
using (StaffID)
inner join VisitorGroup
using(VisGroupID)
where (TourDuration > 2) and StaffID in 
	(select StaffID
	from Booking
	Group by StaffID having count(*) >= 2) 
    and StaffSalary <= 
    (select avg(StaffSalary)
    from Staff);

-- TASK 8
select t.TourName as 'PackageTourName', tt.TourName as 'ComponentTourName'
from TourPackage tp
inner join tour t
on tp.PackageTourID = t.TourID
inner join tour tt
on tp.ComponentTourID = tt.TourID
where PackageTourID in 
	(select PackageTourID
	from TourPackage
	group by PackageTourID having count(*) > 2);
    
-- TASK 9
select distinct PackageTourID as 'TourID', t.TourName, concat('$',t.TourCost) as TourCost,
concat('$', case
	when PackageTourID = 'T1' then 
    (select sum(TourCost)
	from TourPackage tp
	inner join tour tt
	on tp.ComponentTourID = tt.TourID
	where PackageTourID = 'T1')
    
    when PackageTourID = 'T2' then 
    (select sum(TourCost)
	from TourPackage tp
	inner join tour tt
	on tp.ComponentTourID = tt.TourID
	where PackageTourID = 'T2')
end) as TotalComponentCost,

concat('$', case
	when PackageTourID = 'T1' then - t.TourCost +
    (select sum(TourCost)
	from TourPackage tp
	inner join tour tt
	on tp.ComponentTourID = tt.TourID
	where PackageTourID = 'T1')
    
    when PackageTourID = 'T2' then - t.TourCost +
    (select sum(TourCost)
	from TourPackage tp
	inner join tour tt
	on tp.ComponentTourID = tt.TourID
	where PackageTourID = 'T2')
end) as Savings

from TourPackage tp
inner join tour t
on tp.PackageTourID = t.TourID
inner join tour tt
on tp.ComponentTourID = tt.TourID;

-- LEVEL THREE
-- TASK 10
select distinct ReserveName, OrganisationName, (to_days(EndDate) - to_days(StartDate)) / 365 as 'Partnership Duration', concat('$', Amount) as Amount
from Partnership
inner join Reserve
using (ReserveID)
inner join Organisation
using (OrganisationID)
inner join Booking
using (ReserveID)
inner join Tour
using (TourID)
where OrgContactNumber like '_____9%' and TourID <> 'T1' and TourID <> 'T2' and Amount > (SELECT AVG(Amount) FROM Partnership) ;




