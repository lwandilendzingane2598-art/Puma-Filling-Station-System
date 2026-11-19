<?php
session_start();
$conn = new mysqli("localhost", "root", "", "puma_db");
if ($conn->connect_error) { die("Database Connection Failed"); }

$msg = "";

// --- 1. REGISTRATION, LOGIN & LOGOUT ---
if (isset($_POST['register'])) {
    $user = mysqli_real_escape_string($conn, $_POST['username']);
    $pass = password_hash($_POST['password'], PASSWORD_DEFAULT);
    $bank = mysqli_real_escape_string($conn, $_POST['bank_account']);
    $role = $_POST['role'];
    $check = $conn->query("SELECT id FROM users WHERE username='$user'");
    if ($check->num_rows > 0) { $msg = "<div class='alert error'>Username already taken.</div>"; }
    else {
        $conn->query("INSERT INTO users (username, password, role, bank_account) VALUES ('$user', '$pass', '$role', '$bank')");
        $msg = "<div class='alert success'>Account Created! Please log in.</div>";
    }
}

if (isset($_POST['login'])) {
    $user = mysqli_real_escape_string($conn, $_POST['username']);
    $res = $conn->query("SELECT * FROM users WHERE username='$user'");
    $u = $res->fetch_assoc();
    if ($u && password_verify($_POST['password'], $u['password'])) {
        $_SESSION['user_id'] = $u['id']; $_SESSION['username'] = $u['username'];
        $_SESSION['role'] = $u['role']; $_SESSION['bank'] = $u['bank_account'];
    } else { $msg = "<div class='alert error'>Invalid Login Credentials.</div>"; }
}

if (isset($_GET['logout'])) { session_destroy(); header("Location: index.php"); exit(); }

// --- 2. HR ACTIONS: BACKUP, RESET, & PAYROLL ---
if (isset($_GET['backup_db']) && $_SESSION['role'] == 'hr') {
    $tables = array('users', 'attendance', 'payroll_history'); $return = "";
    foreach($tables as $table) {
        $result = $conn->query("SELECT * FROM $table"); $num_fields = $result->field_count;
        $return .= "DROP TABLE IF EXISTS $table;";
        $row2 = $conn->query("SHOW CREATE TABLE $table")->fetch_row(); $return .= "\n\n".$row2[1].";\n\n";
        while($row = $result->fetch_row()) {
            $return .= "INSERT INTO $table VALUES(";
            for($j=0; $j<$num_fields; $j++) { $row[$j] = addslashes($row[$j]); if (isset($row[$j])) { $return .= '"'.$row[$j].'"' ; } else { $return .= '""'; } if ($j<($num_fields-1)) { $return .= ','; } }
            $return .= ");\n";
        } $return .= "\n\n";
    }
    header('Content-Type: application/octet-stream'); header("Content-disposition: attachment; filename=\"puma_backup_".date('Y-m-d').".sql\"");
    echo $return; exit;
}

if (isset($_POST['reset_pass']) && $_SESSION['role'] == 'hr') {
    $tid = $_POST['user_id']; $new_p = password_hash("123456", PASSWORD_DEFAULT);
    $conn->query("UPDATE users SET password='$new_p' WHERE id=$tid");
    $msg = "<div class='alert info'>Password for User ID $tid reset to: 123456</div>";
}

if (isset($_POST['mark_paid'])) {
    $uid = $_POST['user_id']; $name = $_POST['name']; $bank = $_POST['bank']; $hrs = $_POST['hrs']; $net = $_POST['net']; $period = $_POST['period'];
    $conn->query("INSERT INTO payroll_history (user_id, employee_name, bank_account, total_hours, net_pay, pay_period) VALUES ('$uid', '$name', '$bank', '$hrs', '$net', '$period')");
    $msg = "<div class='alert success'>Payment recorded for $name</div>";
}

// --- 3. EMPLOYEE ACTIONS: CLOCKING & PROFILE ---
if (isset($_POST['action']) && $_SESSION['role'] == 'employee') {
    $uid = $_SESSION['user_id'];
    if ($_POST['action'] == 'checkin') { $conn->query("INSERT INTO attendance (user_id, check_in) VALUES ('$uid', NOW())"); }
    else { $conn->query("UPDATE attendance SET check_out=NOW() WHERE user_id='$uid' AND check_out IS NULL ORDER BY id DESC LIMIT 1"); }
}

if (isset($_POST['update_profile'])) {
    $new_b = mysqli_real_escape_string($conn, $_POST['new_bank']); $uid = $_SESSION['user_id'];
    $conn->query("UPDATE users SET bank_account='$new_b' WHERE id=$uid"); $_SESSION['bank'] = $new_b;
    $msg = "<div class='alert success'>Profile updated!</div>";
}

// --- 4. DATA CALCULATIONS (HR ONLY) ---
$start_date = $_GET['start_date'] ?? date('Y-m-01');
$end_date = $_GET['end_date'] ?? date('Y-m-t');
$current_period = "$start_date to $end_date";
$search = isset($_GET['search']) ? mysqli_real_escape_string($conn, $_GET['search']) : "";

$monthly_data = array_fill(1, 12, 0); $top_earners = []; $yearly_total = 0;
if (isset($_SESSION['role']) && $_SESSION['role'] == 'hr') {
    $year = date('Y');
    $m_res = $conn->query("SELECT MONTH(payment_date) as m, SUM(net_pay) as total FROM payroll_history WHERE YEAR(payment_date)='$year' GROUP BY m");
    while($r = $m_res->fetch_assoc()) { $monthly_data[$r['m']] = $r['total']; $yearly_total += $r['total']; }
    $t_res = $conn->query("SELECT employee_name, SUM(net_pay) as e, SUM(total_hours) as h FROM payroll_history WHERE YEAR(payment_date)='$year' GROUP BY employee_name ORDER BY e DESC LIMIT 3");
    while($tr = $t_res->fetch_assoc()) { $top_earners[] = $tr; }
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>PUMA Filling Station</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background: #f4f7f6; margin: 0; padding: 20px; }
        .container { max-width: 1200px; margin: auto; background: white; padding: 30px; border-radius: 12px; box-shadow: 0 4px 20px rgba(0,0,0,0.08); }
        .btn { padding: 8px 15px; border: none; border-radius: 6px; cursor: pointer; color: white; font-weight: bold; text-decoration: none; font-size: 12px; transition: 0.2s; }
        .btn-blue { background: #3498db; } .btn-green { background: #2ecc71; } .btn-red { background: #e74c3c; } .btn-orange { background: #f39c12; } .btn-dark { background: #2c3e50; }
        input, select { padding: 10px; margin: 5px 0; width: 100%; border: 1px solid #ddd; border-radius: 6px; box-sizing: border-box; }
        .alert { padding: 12px; border-radius: 6px; margin-bottom: 20px; text-align: center; font-weight: bold; }
        .success { background: #d4edda; color: #155724; } .error { background: #f8d7da; color: #721c24; } .info { background: #d1ecf1; color: #0c5460; }
        table { width: 100%; border-collapse: collapse; margin-top: 15px; font-size: 13px; }
        th, td { padding: 12px; border-bottom: 1px solid #eee; text-align: left; }
        .grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 15px; margin: 20px 0; }
        .stat-box { background: #fff; border: 1px solid #eee; padding: 15px; border-radius: 8px; text-align: center; }
        .hidden { display: none; }
        @media print { .no-print { display: none !important; } }
    </style>
</head>
<body>

<div class="container">
    <?php echo $msg; ?>

    <?php if (!isset($_SESSION['user_id'])): ?>
        <div style="max-width: 400px; margin: 50px auto; text-align: center;">
            <div id="login-form">
                <h2>Puma Filling Station System</h2>
                <form method="POST">
                    <input type="text" name="username" placeholder="Username" required>
                    <input type="password" name="password" placeholder="Password" required>
                    <button type="submit" name="login" class="btn btn-blue" style="width:100%">Login</button>
                </form>
                <p>Need account? <a href="#" onclick="toggleAuth()">Register</a></p>
            </div>
            <div id="register-form" class="hidden">
                <h2>Staff Registration</h2>
                <form method="POST">
                    <input type="text" name="username" placeholder="Full Name" required>
                    <input type="password" name="password" placeholder="Password" required>
                    <input type="text" name="bank_account" placeholder="Bank Account Number" required>
                    <select name="role"><option value="employee">Employee</option><option value="hr">HR</option></select>
                    <button type="submit" name="register" class="btn btn-green" style="width:100%">Create Account</button>
                </form>
                <p><a href="#" onclick="toggleAuth()">Back to Login</a></p>
            </div>
        </div>
        <script>function toggleAuth() { document.getElementById('login-form').classList.toggle('hidden'); document.getElementById('register-form').classList.toggle('hidden'); }</script>

    <?php else: ?>
        <div class="no-print" style="display:flex; justify-content:space-between; align-items:center; border-bottom: 1px solid #eee; padding-bottom:10px;">
            <h3>User: <?php echo $_SESSION['username']; ?></h3>
            <div>
                <?php if($_SESSION['role'] == 'hr'): ?><a href="?backup_db=1" class="btn btn-dark">💾 Backup DB</a><?php endif; ?>
                <a href="?logout=1" class="btn btn-red">Logout</a>
            </div>
        </div>

        <?php if ($_SESSION['role'] == 'hr'): ?>
            <h2>HR Enterprise Dashboard</h2>
            <div class="grid">
                <?php foreach($top_earners as $idx => $t): ?>
                    <div class="stat-box" style="border-top: 4px solid #f1c40f;">
                        <small><?php echo ($idx==0?'🥇':($idx==1?'🥈':'🥉')); ?> Top Earner</small>
                        <h4><?php echo $t['employee_name']; ?></h4>
                        <p style="color:#27ae60; font-weight:bold;">E<?php echo number_format($t['e'],2); ?></p>
                    </div>
                <?php endforeach; ?>
            </div>

            <form method="GET" class="no-print" style="background:#f9f9f9; padding:15px; border-radius:8px; display:flex; gap:10px; align-items:flex-end;">
                <div><label>Search:</label><br><input type="text" name="search" value="<?php echo htmlspecialchars($search); ?>"></div>
                <div><label>Range:</label><br><input type="date" name="start_date" value="<?php echo $start_date; ?>"> to <input type="date" name="end_date" value="<?php echo $end_date; ?>"></div>
                <button type="submit" class="btn btn-blue">Filter</button>
            </form>

            <table>
                <tr><th>Staff</th><th>Bank</th><th>Hrs</th><th>Net (E)</th><th>Status</th><th class="no-print">Action</th></tr>
                <?php
                $sql = "SELECT * FROM users WHERE role='employee'";
                if($search) $sql .= " AND username LIKE '%$search%'";
                $users = $conn->query($sql); $total_payout = 0;
                while($u = $users->fetch_assoc()) {
                    $uid = $u['id'];
                    $att = $conn->query("SELECT * FROM attendance WHERE user_id=$uid AND DATE(check_in) >= '$start_date' AND DATE(check_in) <= '$end_date' AND check_out IS NOT NULL");
                    $h = 0; $g = 0;
                    while($a = $att->fetch_assoc()){ $d = (strtotime($a['check_out']) - strtotime($a['check_in'])) / 3600; $h += $d; $g += (min($d,8)*11.25)+(max(0,$d-8)*15); }
                    if($h > 0) {
                        $net = $g - 150; $total_payout += $net;
                        $paid = $conn->query("SELECT id FROM payroll_history WHERE user_id=$uid AND pay_period='$current_period'")->num_rows > 0;
                        echo "<tr><td>{$u['username']}</td><td>{$u['bank_account']}</td><td>".round($h,1)."</td><td>".number_format($net,2)."</td>
                        <td>".($paid?'<span style="color:green">PAID</span>':'<span style="color:orange">PENDING</span>')."</td>
                        <td class='no-print'>";
                        if(!$paid) { echo "<form method='POST' style='display:inline;'><input type='hidden' name='user_id' value='$uid'><input type='hidden' name='name' value='{$u['username']}'><input type='hidden' name='bank' value='{$u['bank_account']}'><input type='hidden' name='hrs' value='$h'><input type='hidden' name='net' value='$net'><input type='hidden' name='period' value='$current_period'><button name='mark_paid' class='btn btn-green'>Pay</button></form> "; }
                        echo "<form method='POST' style='display:inline;'><input type='hidden' name='user_id' value='$uid'><button name='reset_pass' class='btn btn-orange' onclick='return confirm(\"Reset to 123456?\")'>Reset</button></form></td></tr>";
                    }
                }
                ?>
            </table>
            <div style="background:#2c3e50; color:white; padding:15px; border-radius:8px; margin-top:10px; text-align:center;">
                <h3>Total Period Payout: E<?php echo number_format($total_payout, 2); ?></h3>
            </div>

        <?php else: ?>
            <div class="grid">
                <div class="stat-box" style="background:#eef2f7;">
                    <h3>Shift Control</h3>
                    <form method="POST">
                        <button name="action" value="checkin" class="btn btn-green" style="width:100%; padding:15px; margin-bottom:10px;">Clock IN</button>
                        <button name="action" value="checkout" class="btn btn-red" style="width:100%; padding:15px;">Clock OUT</button>
                    </form>
                </div>
                <div class="stat-box">
                    <h3>Your Profile</h3>
                    <p>Bank: <?php echo $_SESSION['bank']; ?></p>
                    <form method="POST"><input type="text" name="new_bank" placeholder="New Acc Num" required><button name="update_profile" class="btn btn-blue" style="width:100%">Update Bank</button></form>
                </div>
            </div>
            <div class="stat-box" style="grid-column: span 2; text-align:left;">
                <h3>Recent History (Last 5)</h3>
                <table>
                    <tr><th>Date</th><th>In</th><th>Out</th><th>Status</th></tr>
                    <?php
                    $uid = $_SESSION['user_id'];
                    $hist = $conn->query("SELECT * FROM attendance WHERE user_id=$uid ORDER BY check_in DESC LIMIT 5");
                    while($h = $hist->fetch_assoc()) {
                        echo "<tr><td>".date('d M',strtotime($h['check_in']))."</td><td>".date('H:i',strtotime($h['check_in']))."</td><td>".($h['check_out']?date('H:i',strtotime($h['check_out'])):'--:--')."</td><td>".($h['check_out']?'Done':'<b>Active</b>')."</td></tr>";
                    }
                    ?>
                </table>
            </div>
        <?php endif; ?>
    <?php endif; ?>
</div>

</body>
</html>



