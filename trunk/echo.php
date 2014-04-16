<?php
/**
 * @file   echo.php
 * @brief  Shows the same items given in the post
 *
 * Sample call: <a href="/api/echo.php">/api/echo.php</a>
 */


function action()
{
    $data = array();
	$data["REMOTE_ADDR"] = $_SERVER['REMOTE_ADDR'];
	$data["count"] = count($_POST);
	foreach ($_POST as $k => $v) {
		$data[$k] = $v;
	}
	return json_encode($data);
}

echo action();
?>
