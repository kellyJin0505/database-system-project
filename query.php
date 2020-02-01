<!DOCTYPE html>
<html>
<head>
	<title>CS143 Project 1</title>
</head>

<body>
	<p>
		Please type an SQL query in the following box: 
	</p>
	<p><small>Note: tables and fields are case sensitive.</small></p>
	<form action = "query.php" method = "GET">
		<textarea name = "query" cols = "60" rows = "8"><?php print "$query" ?></textarea><br />
		<input type = "submit" value = "Submit" />
	</form>
	<h3>Results from MySQL:</h3>
	
<?php
	$db_connection = mysql_connect("localhost", "cs143", "");
	if ($db_connection -> connect_error){
		die("Connection failed: " .$db_connection -> connect_error);
	}

	mysql_select_db("CS143", $db_connection);
	
	$Query = (string)$_GET["query"];
	$rs = mysql_query($Query, $db_connection);
	
	echo "<table border='1' cellspacing='1' cellpadding='2'>";
	echo "<tr>";
	
	$num_fields = mysql_num_fields($rs);
	$i = 0;
	while ($i < $num_fields){
		$attribute = mysql_fetch_field($rs, $i);
		echo "<th align='center'>";
		echo $attribute->name;
		echo "</th>";
		$i = $i + 1;
	}
	echo "</tr>";
	
	while ($row = mysql_fetch_row($rs))
		{
    		foreach($row as $value)
	    	{
				echo "<td align='center'>";
				if (is_null($value))
				    echo "Null";
				else
				    echo $value;
				echo "</td>";
	    	}
	    	echo "</tr>";
    }	
	echo "</table>";
   	mysql_free_result($rs);
	mysql_close($db_connection);
?>
	
</body>
</html>