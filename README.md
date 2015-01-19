## RBHangman

Курсов проект по Програмиране с Ruby.

Пресъздаване на класическата игра бесеница.

В процес на разработка..

## Изисквания

Необходимо е да бъдат инсталирани следните gem-ове:

`gem install sqlite3`

В процес на разработка ...

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

Класът `RBHangman::DB` има следните публични методи:

```ruby
has_record?(table, value, column)
```

```ruby
simple_query(select, from, where = nil, order_by = nil)
```


В процес на разработка ...
Следва продължение ...






