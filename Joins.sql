set statistics io on;
set showplan_all off;

select * from Personnel
select * from Name

select p.id, p.sn, p.rank, n.name from Personnel p
	inner join Name n
	on p.id=n.pid


-- left join == left outer join
select p.id, p.sn, p.rank, n.name from Personnel p
	left join Name n
	on p.id=n.pid

select p.id, p.sn, p.rank, n.name from Personnel p
	left outer join Name n
	on p.id=n.pid

select p.id, p.sn, p.rank, n.name from Personnel p
	right join Name n
	on p.id=n.pid

select p.id, p.sn, p.rank, n.name from Personnel p
	full outer join Name n
	on p.id=n.pid


select p.id, p.sn, p.rank, n.pid, n.name from Personnel p
	cross join Name n

-- cartesian product	
select p.id, p.sn, p.rank, n.pid, n.name from Name n
	cross join Personnel p


