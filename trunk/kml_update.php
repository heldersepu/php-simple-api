<?php
/**
 * @file   kml_update.php
 * @brief  Update the delivery area of a restaurant
 *
 * Sample call: <a href="/api/kml_update.php?id=0&kml={kmldata}">/api/kml_update.php?id=0&kml={kmldata}</a>
 */

include_once 'db.php';

function action($id, $kml)
{
	global $db;
	$data = array();
	try {
		if (isset($id) and isset($kml)) {
			$intValue = 0;
			$poly = "POLYGON((-73.898597 40.655828,-73.898792 40.65652,-73.899041 40.657371999999995,-73.899967 40.657285,-73.900303 40.657263,-73.902311 40.655792,-73.898597 40.655828))";
			$mysqli = new mysqli($db->server, $db->user, $db->pasw, $db->defaultdb);
			$query = "SELECT COUNT(*) AS c FROM `oc_store_geom` WHERE `store_id`=" . $id;
			$result = $mysqli->query($query);
			while ($row = $result->fetch_array(MYSQLI_ASSOC)) {
				$intValue = $row['c'];
			}
			$result->close();
			if ($intValue == 0) {
				$query = "INSERT INTO `oc_store_geom` (`store_id`, `geom`, `description`) " .
						" VALUES (" . $id . ", GeomFromText('" . $poly . "'), 'test')";
			} else {
				$query = "UPDATE `oc_store_geom` SET " .						
						"`geom`=GeomFromText('" . $poly . "'), " .
						"`description`='test' ".
						"WHERE `store_id`=" . $id ;
			}
			$mysqli->query($query);
			$mysqli->close();
			$data['success'] = 'data was updated';
		} else {
			$data['error'] = 'Missing id or kml parameter';
		}
	} catch (Exception $e) {
		$data['error'] = $e->getMessage();
	}
	return json_encode($data);
}

echo action($_GET['id'], $_GET['kml']);
?>
