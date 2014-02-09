<?php
/**
 * @file   show_all.php
 * @brief  Shows a list of all restaurants
 */

include_once 'db.php';

function action()
{
	$data = array();
	$data[] = array(
            'id' => 123,
            'name' => "Luigi's Pizza",
        );
	return json_encode($data);
}

echo action();
?>
