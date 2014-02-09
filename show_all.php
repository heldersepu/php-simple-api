<?php
/**
 * @file   show_all.php
 * @brief  Shows a list of all restaurants
 */

include_once 'db.php';

function action()
{
	global $db;
	$query = 'SELECT * FROM `v_store` ';
    $mysqli = new mysqli($db->server, $db->user, $db->pasw, $db->defaultdb);
    $result = $mysqli->query($query);
    $data = array();
    while ($row = $result->fetch_array(MYSQLI_ASSOC)) {
        $data[] = $row;
    }
    $result->close();
    $mysqli->close();
	return json_encode($data);
}

echo action();
?>
