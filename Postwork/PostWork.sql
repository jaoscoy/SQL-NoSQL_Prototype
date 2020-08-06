-- 1.- Seleccionar a todos los clientes que radiquen en Mexico
select * from Customer  where Country = "Mexico";
-- 2.- Selecciona a todos los clientes que no radiquen en USA Y Argentina
select * from Customer where Country <> "USA" and Country <> "Argentina";
-- 3.- Seleccionar a todos los clientes que su apellido empiece con a o L
select * from Customer where LastName like 'a%' or LastName like 'l%';
-- 4.- ¿Cual son todos los datos del producto más barato y más caro
select * from Product where UnitPrice = (select min(UnitPrice) from Product) or UnitPrice = (select max(UnitPrice) from Product);
-- 5.- ¿Cuantos productos surte cada proveedor?
select SupplierId, count(*) from Product group by SupplierId;
-- 6.- ¿Cual es el precio promedio de los articulos suministrados por el proveedor?
select SupplierId, round(avg(UnitPrice),2) as Total from Product group by SupplierId order by Total desc;
-- 7.- ¿Cuales son los 5 nombres de las compañias de los proveedores que más productos surten?
select a.Id, CompanyName, count(*) total from Supplier a
left join Product b
on a.Id=b.SupplierID
group by a.Id
order by total desc
limit 5;
-- 8.- ¿el total de ordenes por pais?
select Country, round(count(b.TotalAmount),2) Total from Supplier a
left join `Order` b
on a.Id=b.CustomerId
group by Country
order by Total desc;
-- 9.- ¿Cual es el pais con más total de ingresos?
select Country, round(sum(b.TotalAmount),2) Total from Supplier a
left join `Order` b
on a.Id=b.CustomerId
group by Country
order by Total desc
limit 1;
-- 10.- ¿Cual son las 3 ciudades con mas ordenes?
select Country, round(sum(b.TotalAmount), 2) Total from Supplier a
left join `Order` b
on a.Id=b.CustomerId
group by Country
order by Total desc;
-- 11.- Crea una vista que muestra el total de unidades vendidas por producto
create view Total_productos_por_orden as (select a.Id, a.ProductName, sum(b.Quantity) Total from Product a
left join OrderItem b
on a.Id=b.ProductId
group by a.Id
order by Total desc);
-- 11a.- ¿Cual es el nombre de los 5 productos más vendidos?
select * from Total_productos_por_orden;
-- 12.- ¿Cual es el producto que no se ha vendido?
select * from Total_productos_por_orden where Total is NULL;
-- 13.- ¿Cual fue el total de la venta del producto mostrando el proveedor?
select a.Id, a.ProductName, round(sum(b.UnitPrice),2) Total, c.CompanyName from Product a left join OrderItem b on a.Id=b.ProductId 
left join Supplier c on c.Id=a.SupplierId group by a.Id order by Total desc;
-- 14.- ¿Cual son los 5 clientes que más dinero han gastado y cuantos productos compraron?
select concat(a.FirstName, " ", a.LastName) Nombre, round(sum(b.TotalAmount),2) Total_Amount, sum(c.Quantity) Total_Amount from Customer a
left join `Order` b
on a.Id=b.CustomerId
left join OrderItem c
on b.Id=c.OrderId
group by Nombre
order by Total_Amount desc
limit 5;
-- 15.- Averigua cuales son los 5 que menos han gastado no tomando en cuenta a quienes no han comprado nada.
select concat(a.FirstName, " ", a.LastName) Nombre, round(sum(b.TotalAmount),2) Total_Quantity, sum(c.Quantity) Total_Amount from Customer a
left join `Order` b
on a.Id=b.CustomerId
left join OrderItem c
on b.Id=c.OrderId
group by Nombre
having Total_Quantity is not null
order by Total_Quantity
limit 5;
select * from Clientes order by Total_Quantity desc;
