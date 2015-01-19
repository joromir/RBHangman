## RBHangman

Курсов проект по Програмиране с Ruby.

Пресъздаване на класическата игра бесеница.

Проектът е в процес на разработка!

## Изисквания

Необходимо е да бъдат инсталирани следните gem-ове:

`gem install sqlite3`


В процес на разработка ...

Следва продължение ...

## Структура

С цел по-добра капсулация, всички класове и модули са дефинирани в модула `RBHangman`

Класът `RBHangman::DB` дефинира връзката с базата данни `rbhangman.db`. 


Тази база данни има две таблици: `HIGHSCORES`, `DICTIONARY`.

Имплементация: 

```SQL
CREATE TABLE DICTIONARY(WORD VARCHAR(25) PRIMARY KEY NOT NULL);
```
```SQL
CREATE TABLE HIGHSCORES(PLAYER VARCHAR(25) NOT NULL PRIMARY KEY, SCORE INTEGER NOT NULL);
```

Класът `RBHangman::DB` има следните методи:

```ruby
has_record?(table, value, column)
```

```ruby
selector(select, from, where = nil, order_by = nil)
```

```ruby
inserter(table, values, columns)
```

```ruby
updater(update, set, where)
```

Класът `RBHangman::Word` е наследник на `RBHangman::DB`.

При създаване на нова инстанция на `RBHangman::Word`, в инстанционната променлива `@hidden` се зарежда произволна дума от БД.
 
```ruby
try(letter)
```

Горният публичен метод ни позволява работа с думата според правилата на играта бесеница.

При 10 грешни предположения за буквите на думата, 
методът предизвиква изключение `throw :failure`.
В случай, че отгатнем буквите на думата се предизвиква 
изключение `throw :success`.

Горните две изключения се обработват на по-късен етап и определят хода на играта.

Този клас притежава и два класови метода: 

```ruby
in_database?(word)
```

```ruby
add_new(word)
```







В процес на разработка ...

Следва продължение ...



