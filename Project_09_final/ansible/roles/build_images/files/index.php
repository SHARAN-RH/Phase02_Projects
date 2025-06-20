<?php
$mysqli = new mysqli('mysql', 'root', 'rootpassword', 'bookmarks');

if ($mysqli->connect_errno) {
    echo "Failed to connect to MySQL: " . $mysqli->connect_error;
    exit();
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $url = $mysqli->real_escape_string($_POST['url']);
    $title = $mysqli->real_escape_string($_POST['title']);
    $mysqli->query("INSERT INTO bookmarks (url, title) VALUES ('$url', '$title')");
}

// Fetch all bookmarks
$result = $mysqli->query("SELECT * FROM bookmarks ORDER BY created_at DESC");
?>
<!DOCTYPE html>
<html>
<head>
    <title>Bookmark Manager</title>
</head>
<body>
    <h1>Bookmark Manager</h1>
    <form method="post">
        <input type="text" name="title" placeholder="Title" required>
        <input type="url" name="url" placeholder="https://example.com" required>
        <button type="submit">Add Bookmark</button>
    </form>
    <ul>
    <?php while($row = $result->fetch_assoc()): ?>
        <li>
            <a href="<?= htmlspecialchars($row['url']) ?>" target="_blank"><?= htmlspecialchars($row['title']) ?></a>
            <span>(added <?= $row['created_at'] ?>)</span>
        </li>
    <?php endwhile; ?>
    </ul>
</body>
</html>

