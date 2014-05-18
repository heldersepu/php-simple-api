<?php
/**
 * @file   show_products.php
 * @brief  Shows all the info for a restaurant
 *
 * Sample call: <a href="/api/show_products.php?store_id=5">/api/show_products.php?store_id=5</a>
 */

include_once 'db.php';

/**
 * @brief --
 */
function action($store_id)
{
	global $db;
	$data = array();
	try {
		$query = 'SELECT * FROM `v_store_product` WHERE store_id='. $store_id;
		$mysqli = new mysqli($db->server, $db->user, $db->pasw, $db->defaultdb);
		$result = $mysqli->query($query);
		if ($result) {
			while ($row = $result->fetch_array(MYSQLI_ASSOC)) {
				$options = array();
				$queryOpt = 'SELECT option_id, name FROM `v_store_product_option` ' .
							'WHERE product_id='. $row['product_id'];
				$resultOpt = $mysqli->query($queryOpt);
				if ($resultOpt) {
					while ($rowOpt = $resultOpt->fetch_array(MYSQLI_ASSOC)) {
						$options[] = $rowOpt;
						$values = array();
						$queryVal = 'SELECT option_value_id, name, price, image ' . 
									'FROM `v_store_product_option_value` ' .
									'WHERE option_id='. $rowOpt['option_id'] . 
									' AND store_id='. $store_id .
									' AND product_id='. $row['product_id'] ;
						$resultVal = $mysqli->query($queryVal);
						if ($resultVal) {
							while ($rowVal = $resultVal->fetch_array(MYSQLI_ASSOC)) {
								$values[] = $rowVal;
							}
						}
						$options[] = array("option_values" => $values);
					}
					$resultOpt->close();
				}
				$data[] = array("product" => $row, "options" => $options);				
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
