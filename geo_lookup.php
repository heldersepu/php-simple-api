<?php
/**
 * @file   geo_lookup.php
 * @brief  Retrieves a list a restaurants in the given location
 */

include_once 'db.php';

function action($address, $coord)
{
	$data = array();
	$data[] = array(
            'id' => $address,
            'name' => $coord,
        );
	return json_encode($data);
}

echo action($_GET['address'], $_GET['coord']);
?>
