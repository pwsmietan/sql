
select username from person.Person 
delete from POC_Data

select * from POC_Data

select * from person.Person as a
inner join Person.EmailAddress as b
on a.BusinessEntityID=b.BusinessEntityID
where a.Username='billj' and a.Password='poc'

drop table Weighted

SELECT DS__keywords, COUNT(DS__keywords) AS TotalIncidents, 
	CONVERT(decimal(5,2),CAST(COUNT(DS__keywords) AS decimal)/(SELECT COUNT(*) * .01 FROM FormVCMC_Security01)) AS [Weight]
    INTO Weighted
	FROM FormVCMC_Security01 GROUP BY DS__keywords ORDER BY Weight desc

SELECT DS__keywords, COUNT(DS__keywords) AS TotalIncidents, 
	CONVERT(decimal(5,2),CAST(COUNT(DS__keywords) AS decimal)/(SELECT COUNT(*) * .01 FROM FormVCMC_Security01)) AS [Weight]
	FROM FormVCMC_Security01 WHERE incident_date between '9/1/2013' and '12/1/2013'
	GROUP BY DS__keywords ORDER BY Weight desc


select * from Weighted

SELECT * FROM Weighted WHERE Weight >= 5 ORDER BY Weight DESC

SELECT * into ByLocation FROM FormVCMC_Security01 WHERE incident_date between '9/1/2013' and '12/1/2013'
select * from ByLocation


	GROUP BY DS__keywords ORDER BY Weight desc

