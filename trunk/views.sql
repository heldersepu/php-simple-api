
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
SELECT st.store_id, name, url, email, phone, fax, logo, address, min_checkout
FROM  `oc_store` st
JOIN  `v_store_email` v1 
	ON st.store_id = v1.store_id
JOIN  `v_store_logo` vl2 
	ON st.store_id = vl2.store_id
JOIN  `v_store_fax` vf2 
	ON st.store_id = vf2.store_id
JOIN  `v_store_phone` v2 
	ON st.store_id = v2.store_id
JOIN  `v_store_address` v3
	ON st.store_id = v3.store_id
JOIN  `v_store_min_checkout` vmc
	ON st.store_id = vmc.store_id

