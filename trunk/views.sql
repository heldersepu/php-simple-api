
CREATE VIEW v_store_email AS 
SELECT store_id, value as email
FROM   `oc_setting`
WHERE `key`='config_email'

CREATE VIEW v_store_phone AS 
SELECT store_id, value as phone
FROM   `oc_setting`
WHERE `key`='config_telephone'

CREATE VIEW v_store_address AS 
SELECT store_id, value as address
FROM   `oc_setting`
WHERE `key`='config_address'

CREATE VIEW v_store AS 
SELECT st.store_id, name, url, email, phone, address
FROM  `oc_store` st
JOIN  `v_store_email` v1 
	ON st.store_id = v1.store_id
JOIN  `v_store_phone` v2 
	ON st.store_id = v2.store_id
JOIN  `v_store_address` v3
	ON st.store_id = v3.store_id

