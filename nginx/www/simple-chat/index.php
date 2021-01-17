<?php
include 'idiorm.php';
ORM::configure('mysql:host=mysql;dbname=sandbox'); // название бд 
ORM::configure('username', 'mysql'); // имя пользователя для доступа к бд
ORM::configure('password', 'mysql'); // пароль для доступа к бд 
 
// устанавливаем кодировку 
ORM::configure('driver_options', array(PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES utf8'));
 
// вытягиваем переменную из массива $_REQUEST, если такая существует, 
// иначе возвращаем значение $default
function getRequestVar($var, $default=null) {
    return isset($_REQUEST[$var]) 
           ? trim($_REQUEST[$var])
           : $default
    ;
}
 
// Экранируем вывод
function esc($str){
    return htmlspecialchars($str, ENT_QUOTES | ENT_IGNORE);
}
 
if (getRequestVar('name') && getRequestVar('message')) { // Если пришло имя и сообщение
    $record  = ORM::for_table('chat')->create(); // создаем объект, таблицы chat
    $record->name = getRequestVar('name'); // записываем в него значение, в поле name
    $record->message = getRequestVar('message'); // записываем в него значение, в поле message
    $record->created_at = time(); // записываем в него время, в поле created_at
    $record->save(); // сохраняем новую запись в базу данных
    header('Location:?name='.urlencode(getRequestVar('name')));
}
 
$chatHistory = ORM::for_table('chat') // обращаемся к таблице chat
               ->order_by_desc('created_at') // сортируем в обратном порядке по времени
               ->limit(25)   // ограничиваем вывод до 25 последних записей
               ->find_many() // запрашиваем все найденные записи
;
 
?>
<!doctype html>
<html>
<head>
    <title>Chat</title>
    <style>
        .form-group {margin:5px 0;}
        .form-group .form-control {display:block; margin-bottom:5px;}
        hr {margin: 10px 0;}
        .chat-record {border-bottom:1px dotted silver; padding: 5px 0; margin: 5px 0px;}
    </style>
</head>
<body>
    <form action="?" method="post">
        <div class="form-group">
            <label for="name" class="form-control">Имя</label>
            <input type="text" name="name" class="form-control" value="<?=esc(getRequestVar('name'))?>">
        </div>
        <br>
        <div class="form-group">
            <label for="message" class="form-control">Сообщение</label>
            <input type="text" name="message" value="" class="form-control">
            <input type="submit" value="Отправить" class="form-control">
        </div>
    </form>
    <?php if ($chatHistory):?>
        <hr>
        <?php foreach($chatHistory as $record):?>
            <div class="chat-record">
                [<?=esc(date('d.m.y H:i', $record->created_at))?>]
                <?=esc($record->name)?> &rarr;
                <?=esc($record->message)?>
            </div>
        <?php endforeach;?>
    <?php endif;?>
</body>
</html>
 
