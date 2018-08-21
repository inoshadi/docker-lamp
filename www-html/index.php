<!DOCTYPE html>
<html>
<head>
    <title>Hello Worlds!</title>
</head>
<body>
    <header>
    <h1>Hello <?php echo $_SERVER['REMOTE_ADDR'];?></h1>
    </header>

    <div>
        <ul>
            <li><a href="webutils/phpinfo.php">View PHP Info</a></li>
            <li><a href="webutils/adminer.php">Access Database using adminer</a></li>            
        </ul>
    </div>
</body>
</html>

