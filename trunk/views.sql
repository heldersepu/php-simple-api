
CREATE VIEW v_store_email AS
SELECT store_id, value as email
FROM   `oc_setting`
WHERE `key`='config_email'

CREATE VIEW v_store_phone AS
SELECT store_id, value as phone
FROM   `oc_setting`
WHERE `key`='config_telephone'

CREATE VIEW v_store_fax AS
SELECT store_id, value as fax
FROM   `oc_setting`
WHERE `key`='config_fax'

DROP VIEW v_store_logo;
CREATE VIEW v_store_logo AS
SELECT store_id, value as logo
FROM   `oc_setting`
WHERE `key`='config_logo'

DROP VIEW v_store_address;
CREATE VIEW v_store_address AS
SELECT store_id, value as address
FROM   `oc_setting`
WHERE `key`='config_address'

DROP VIEW v_store_min_checkout;
CREATE VIEW v_store_min_checkout AS
SELECT store_id, value as min_checkout
FROM   `oc_setting`
WHERE `key`='config_min_checkout'


DROP VIEW v_store;
CREATE VIEW v_store AS
SELECT st.store_id, name, url, email, phone, fax, logo, address, min_checkout, mon, tue, wed, thu, fri, sat, sun
FROM  `oc_store` st
LEFT JOIN  `v_store_email` v1
	ON st.store_id = v1.store_id
LEFT JOIN  `v_store_logo` vl2
	ON st.store_id = vl2.store_id
LEFT JOIN  `v_store_fax` vf2
	ON st.store_id = vf2.store_id
LEFT JOIN  `v_store_phone` v2
	ON st.store_id = v2.store_id
LEFT JOIN  `v_store_address` v3
	ON st.store_id = v3.store_id
LEFT JOIN  `v_store_min_checkout` vmc
	ON st.store_id = vmc.store_id
LEFT JOIN  `v_store_simple_hours` vsh
	ON st.store_id = vsh.store_id


CREATE VIEW v_close_store AS
SELECT `key`, `value`, ST.store_id
FROM `oc_setting` AS SE
JOIN `oc_store` AS ST
WHERE `group` = 'close_store' AND
(
`key` like CONCAT('%_start_time', CAST(ST.store_id AS CHAR))
OR
`key` like CONCAT('%_start_time_night', CAST(ST.store_id AS CHAR))
OR
`key` like CONCAT('%_end_time', CAST(ST.store_id AS CHAR))
OR
`key` like CONCAT('%_end_time_night', CAST(ST.store_id AS CHAR))
)


DROP VIEW v_store_hours;
CREATE VIEW v_store_hours AS
SELECT
    `store_id`,

    MAX(CASE WHEN `key` LIKE 'open_store_start_time%' THEN `value` ELSE '00:00' END) AS open_store_start_time,
    MAX(CASE WHEN `key` LIKE 'open_store_end_time%' THEN `value` ELSE '00:00' END) AS open_store_end_time,
    MAX(CASE WHEN `key` LIKE 'close_store_start_time%' THEN `value` ELSE '00:00' END) AS close_store_start_time,
    MAX(CASE WHEN `key` LIKE 'close_store_end_time%' THEN `value` ELSE '00:00' END) AS close_store_end_time,


    MAX(CASE WHEN `key` LIKE 'monday_start_time%' THEN `value` ELSE '00:00' END) AS monday_start_time,
    MAX(CASE WHEN `key` LIKE 'monday_end_time%' THEN `value` ELSE '00:00' END) AS monday_end_time,
    MAX(CASE WHEN `key` LIKE 'monday_start_time_night%' THEN `value` ELSE '00:00' END) AS monday_start_time_night,
    MAX(CASE WHEN `key` LIKE 'monday_end_time_night%' THEN `value` ELSE '00:00' END) AS monday_end_time_night,

    MAX(CASE WHEN `key` LIKE 'tuesday_start_time%' THEN `value` ELSE '00:00' END) AS tuesday_start_time,
    MAX(CASE WHEN `key` LIKE 'tuesday_end_time%' THEN `value` ELSE '00:00' END) AS tuesday_end_time,
    MAX(CASE WHEN `key` LIKE 'tuesday_start_time_night%' THEN `value` ELSE '00:00' END) AS tuesday_start_time_night,
    MAX(CASE WHEN `key` LIKE 'tuesday_end_time_night%' THEN `value` ELSE '00:00' END) AS tuesday_end_time_night,

    MAX(CASE WHEN `key` LIKE 'wednesday_start_time%' THEN `value` ELSE '00:00' END) AS wednesday_start_time,
    MAX(CASE WHEN `key` LIKE 'wednesday_end_time%' THEN `value` ELSE '00:00' END) AS wednesday_end_time,
    MAX(CASE WHEN `key` LIKE 'wednesday_start_time_night%' THEN `value` ELSE '00:00' END) AS wednesday_start_time_night,
    MAX(CASE WHEN `key` LIKE 'wednesday_end_time_night%' THEN `value` ELSE '00:00' END) AS wednesday_end_time_night,

    MAX(CASE WHEN `key` LIKE 'thursday_start_time%' THEN `value` ELSE '00:00' END) AS thursday_start_time,
    MAX(CASE WHEN `key` LIKE 'thursday_end_time%' THEN `value` ELSE '00:00' END) AS thursday_end_time,
    MAX(CASE WHEN `key` LIKE 'thursday_start_time_night%' THEN `value` ELSE '00:00' END) AS thursday_start_time_night,
    MAX(CASE WHEN `key` LIKE 'thursday_end_time_night%' THEN `value` ELSE '00:00' END) AS thursday_end_time_night,

    MAX(CASE WHEN `key` LIKE 'friday_start_time%' THEN `value` ELSE '00:00' END) AS friday_start_time,
    MAX(CASE WHEN `key` LIKE 'friday_end_time%' THEN `value` ELSE '00:00' END) AS friday_end_time,
    MAX(CASE WHEN `key` LIKE 'friday_start_time_night%' THEN `value` ELSE '00:00' END) AS friday_start_time_night,
    MAX(CASE WHEN `key` LIKE 'friday_end_time_night%' THEN `value` ELSE '00:00' END) AS friday_end_time_night,

    MAX(CASE WHEN `key` LIKE 'saturday_start_time%' THEN `value` ELSE '00:00' END) AS saturday_start_time,
    MAX(CASE WHEN `key` LIKE 'saturday_end_time%' THEN `value` ELSE '00:00' END) AS saturday_end_time,
    MAX(CASE WHEN `key` LIKE 'saturday_start_time_night%' THEN `value` ELSE '00:00' END) AS saturday_start_time_night,
    MAX(CASE WHEN `key` LIKE 'saturday_end_time_night%' THEN `value` ELSE '00:00' END) AS saturday_end_time_night,

    MAX(CASE WHEN `key` LIKE 'sunday_start_time%' THEN `value` ELSE '00:00' END) AS sunday_start_time,
    MAX(CASE WHEN `key` LIKE 'sunday_end_time%' THEN `value` ELSE '00:00' END) AS sunday_end_time,
    MAX(CASE WHEN `key` LIKE 'sunday_start_time_night%' THEN `value` ELSE '00:00' END) AS sunday_start_time_night,
    MAX(CASE WHEN `key` LIKE 'sunday_end_time_night%' THEN `value` ELSE '00:00' END) AS sunday_end_time_night
FROM `v_close_store`
GROUP BY `store_id`


DROP VIEW v_store_simple_hours;
CREATE VIEW v_store_simple_hours AS
SELECT `store_id`,
CONCAT(`monday_start_time`, 	' to ', `monday_end_time`) AS mon,
CONCAT(`tuesday_start_time`, 	' to ', `tuesday_end_time`) AS tue,
CONCAT(`wednesday_start_time`, 	' to ', `wednesday_end_time`) AS wed,
CONCAT(`thursday_start_time`, 	' to ', `thursday_end_time`) AS thu,
CONCAT(`friday_start_time`, 	' to ', `friday_end_time`) AS fri,
CONCAT(`saturday_start_time`, 	' to ', `saturday_end_time`) AS sat,
CONCAT(`sunday_start_time`, 	' to ', `sunday_end_time`) AS sun
FROM `v_store_hours`



--INSERT INTO `oc_setting` ( `store_id`, `group`, `key`, `value`, `serialized`)
SELECT 0 AS `store_id`,
	'close_store' AS `group`,
	CONCAT('close_store_description', CAST(store_id AS CHAR)) AS `key` ,
	CONCAT('&lt;div style=&quot;position: fixed;top: 10px;z-index: 999;background: white;&quot;&gt;\r\n&lt;h1 style=&quot;color: red;&quot;&gt;', CAST(name AS CHAR), ' is closed&lt;/h1&gt;\r\n&lt;/div&gt;\r\n') AS `value`,
	0 AS `serialized`
FROM `oc_store`



