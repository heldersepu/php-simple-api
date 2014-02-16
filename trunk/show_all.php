<?php
/**
 * @file   show_all.php
 * @brief  Shows a list of all restaurants
 *
 * Sample call: <a href="/api/show_all.php">/api/geo_lookup.php</a>
 */

include_once 'db.php';

function action()
{
	global $db;
    $data = array();
	try {
		$query = 'SELECT * FROM `v_store` ';
		$mysqli = new mysqli($db->server, $db->user, $db->pasw, $db->defaultdb);
		$result = $mysqli->query($query);
		if ($result) {
			while ($row = $result->fetch_array(MYSQLI_ASSOC)) {
				$data[] = $row;
			}
			$result->close();
		} else {
			$data['error'] = $mysqli->error;
		}
		$mysqli->close();
	} catch (Exception $e) {
		$data['error'] = $e->getMessage();
	}
	return json_encode($data);
}

echo action();
?>
