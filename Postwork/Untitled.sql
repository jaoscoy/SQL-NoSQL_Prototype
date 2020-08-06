CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `clientes` AS
    SELECT 
        CONCAT(`a`.`FirstName`, ' ', `a`.`LastName`) AS `Nombre`,
        ROUND(SUM(`b`.`TotalAmount`), 2) AS `Total_Quantity`,
        SUM(`c`.`Quantity`) AS `Total_Amount`
    FROM
        ((`customer` `a`
        LEFT JOIN `order` `b` ON ((`a`.`Id` = `b`.`CustomerId`)))
        LEFT JOIN `orderitem` `c` ON ((`b`.`Id` = `c`.`OrderId`)))
    GROUP BY `Nombre`
    ORDER BY `Total_Quantity`