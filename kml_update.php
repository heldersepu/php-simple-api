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
			$poly = "POLYGON(";
			$kml = urldecode($kml);
			$xml = simplexml_load_string($kml);
			foreach( $xml->Document->Placemark as $Placemark ) {
				foreach( $Placemark->Polygon->outerBoundaryIs->LinearRing->coordinates as $coord ) {
					$poly .= "(";
					foreach(explode("\n", $coord) as $element) {
						$latlon = explode(",", $element);
						if (count($latlon) > 1) {
							$poly .=  trim($latlon[0]) . " " . trim($latlon[1]) . ",";
						}
					}
					$poly = substr($poly, 0, -1) . "),";
				}
			}
			$poly = substr($poly, 0, -1) . ")";

			$mysqli = new mysqli($db->server, $db->user, $db->pasw, $db->defaultdb);
			$query = "SELECT COUNT(*) AS c FROM `oc_store_geom` WHERE `store_id`=" . $id;
			$result = $mysqli->query($query);
			if ($result) {
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
				$data['geom'] = $poly;
				$data['success'] = 'data was updated';
			} else {
				$data['error'] = $mysqli->error;
			}
			$mysqli->close();
		} else {
			$data['error'] = 'Missing id or kml parameter';
		}
	} catch (Exception $e) {
		$data['error'] = $e->getMessage();
	}
	return json_encode($data);
}

if (isset($_GET['id'])) {
	echo action($_GET['id'], $_GET['kml']);
} else {
	echo action($_POST['id'], $_POST['kml']);
}
?>
