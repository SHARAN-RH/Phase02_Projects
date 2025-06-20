<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);
session_start();
if (!isset($_SESSION['user_id'])) {
    header('Location: login.php');
    exit();
}
require 'db.php';

// Add a new bookmark
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['title'], $_POST['url'])) {
    $title = trim($_POST['title']);
    $url = trim($_POST['url']);
    if ($title !== '' && $url !== '') {
        $stmt = $pdo->prepare('INSERT INTO bookmarks (user_id, title, url) VALUES (?, ?, ?)');
        $stmt->execute([$_SESSION['user_id'], $title, $url]);
    }
}

// Delete a bookmark
if (isset($_GET['delete'])) {
    $del_id = (int)$_GET['delete'];
    $stmt = $pdo->prepare('DELETE FROM bookmarks WHERE id = ? AND user_id = ?');
    $stmt->execute([$del_id, $_SESSION['user_id']]);
}

// Fetch user's bookmarks
$stmt = $pdo->prepare('SELECT id, title, url FROM bookmarks WHERE user_id = ? ORDER BY created_at DESC');
$stmt->execute([$_SESSION['user_id']]);
$bookmarks = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>
<!DOCTYPE html>
<html>
<head>
    <title>Your Bookmarks</title>
    <style>
        body { font-family: Arial; }
        ul { list-style-type: none; }
        li { margin-bottom: 8px; }
        a.logout { float: right; }
    </style>
</head>
<body>
    <h1>Your Bookmarks</h1>
    <a href="logout.php" class="logout">Logout</a>
    <h2>Add Bookmark</h2>
    <form method="post">
        Title: <input type="text" name="title" required>
        URL: <input type="url" name="url" required>
        <button type="submit">Add</button>
    </form>
    <h2>Saved Bookmarks</h2>
    <ul>
        <?php foreach ($bookmarks as $bm): ?>
            <li>
                <a href="<?php echo htmlspecialchars($bm['url']); ?>" target="_blank"><?php echo htmlspecialchars($bm['title']); ?></a>
                <a href="?delete=<?php echo $bm['id']; ?>" onclick="return confirm('Delete this bookmark?');">[Delete]</a>
            </li>
        <?php endforeach; ?>
    </ul>
</body>
</html>

