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
	if (isset($coord)) {
		$query = "SELECT  S.*, ASTEXT(`geom`) AS geom FROM `oc_store_geom` G" .
				" JOIN v_store S ON G.store_id = S.store_id " .
				" WHERE MBRCONTAINS( geom, GEOMFROMTEXT( 'Point(" . str_replace(",", " ", $coord) . ")' ) ) ";
		$mysqli = new mysqli($db->server, $db->user, $db->pasw, $db->defaultdb);
		$result = $mysqli->query($query);
		while ($row = $result->fetch_array(MYSQLI_ASSOC)) {
			$data[] = $row;
		}
		$result->close();
		$mysqli->close();
	} else {
		$data['error'] = 'Missing coord parameter';
	}
	return json_encode($data);
}

echo action($_GET['address'], $_GET['coord']);
?>
