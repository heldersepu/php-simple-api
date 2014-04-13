<?php
/**
 * @file   geo_lookup.php
 * @brief  Retrieves a list of restaurants in the given location
 *
 * Sample call: <a href="/api/geo_lookup.php?coord=-73.897390,40.640856">/api/geo_lookup.php?coord=-73.897390,40.640856</a>
 */

include_once 'db.php';

function action($address, $coord)
{
	global $db;
	$data = array();
	try {
		if (isset($address)) {
			$geourl = "http://maps.google.com/maps/api/geocode/json?address=";
			$geourl .= str_replace(" ", "+", $address) . "&sensor=false";
			$geocode = file_get_contents($geourl);
			$output= json_decode($geocode);

			$lat = $output->results[0]->geometry->location->lat;
			$lng = $output->results[0]->geometry->location->lng;
			$coord = $lng.",".$lat;
		}
		if (isset($coord)) {
			$query = "SELECT  S.*, ASTEXT(`geom`) AS geom FROM `oc_store_geom` G" .
					" JOIN v_store S ON G.store_id = S.store_id " .
					" WHERE MBRCONTAINS( geom, GEOMFROMTEXT( 'Point(" . str_replace(",", " ", $coord) . ")' ) ) ";
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
			if (isset($address)) {
				$data['coord'] = $coord;
			}
		} else {
			$data['error'] = 'Missing coord parameter';
		}
	} catch (Exception $e) {
		$data['error'] = $e->getMessage();
	}
	return json_encode($data);
}

echo action($_GET['address'], $_GET['coord']);
?>
