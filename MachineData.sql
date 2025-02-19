select top 20 * from Coin_Pickup order by Pickup_Id desc

-- Just for testing:
-- Pickup_id: 9188770 9188778

-- retrieve all FK/PK relationships 
EXEC sp_fkeys 'Coin_Pickup'
EXEC sp_pkeys 'Coin_Pickup'



select * from Coin_Pickup_Correction_Hist where Pickup_Id in (9188770, 9188778)
select * from Coin_Pickup_Denom where Pickup_Id in (9188770, 9188778)
select * from Coin_Pickup_Denom_Mix where Pickup_Id in (9188770, 9188778)
select * from Coin_Pickup_Not_Found where Pickup_Id in (9188770, 9188778)
select * from Wk_List_Coin_Pickup where Pickup_Id in (9188770, 9188778)

select * from Coin_Pickup_Denom where Pickup_Id=9188770