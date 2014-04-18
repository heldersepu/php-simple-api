<?php
/**
 * @file   show_store.php
 * @brief  Shows all the info for a restaurant
 *
 * Sample call: <a href="/api/show_store.php?store_id=5">/api/show_store.php?store_id=5</a>
 */

include_once 'db.php';

function action($store_id)
{
	global $db;
	$data = array();
	try {
		$query = 'SELECT * FROM `v_store` WHERE store_id='. $store_id;
		$mysqli = new mysqli($db->server, $db->user, $db->pasw, $db->defaultdb);
		$result = $mysqli->query($query);
		if ($result) {
			while ($row = $result->fetch_array(MYSQLI_ASSOC)) {
				$data[] = $row;
			}
			$result->close();
			if (count($data) > 0) {
				$query = 'SELECT ASTEXT(`geom`) AS `geom` FROM `oc_store_geom` WHERE store_id='. $store_id;
				$result = $mysqli->query($query);
				if ($result) {
					while ($row = $result->fetch_array(MYSQLI_ASSOC)) {
						$data[] = $row;
					}
					$result->close();
				}
				$query = 'SELECT `key`, `value` FROM `oc_setting` WHERE store_id='. $store_id;
				$result = $mysqli->query($query);
				if ($result) {
					while ($row = $result->fetch_array(MYSQLI_ASSOC)) {
						$data[] = $row;
					}
					$result->close();
				}
			}
		} else {
			$data['error'] = $mysqli->error;
		}
		$mysqli->close();
	} catch (Exception $e) {
		$data['error'] = $e->getMessage();
	}
	return json_encode($data);
}

if (isset($_GET['store_id'])) {
	if (is_numeric($_GET['store_id'])) {
		echo action($_GET['store_id']);
	} else {
		echo "Invalid store_id";
	}
} else {
	echo "Missing store_id";
}
?>
