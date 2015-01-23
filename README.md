## RBHangman

Курсов проект по Програмиране с Ruby.

Пресъздаване на класическата игра бесеница.

```
  _______
 |/      |
 |      (.)
 |      \|/
 |       |
 |      /'\
 |
_|___
```

Проектът е в процес на разработка!

## Изисквания и инсталация

ruby-2.2.0

[Shoes](http://shoesrb.com/)

Необходимо е да бъдат инсталирани следните gem-ове:

`gem install sqlite3`


В процес на разработка ...

Следва продължение ...


## Структура

С цел по-добра капсулация, всички класове и модули са дефинирани в модула `RBHangman`

Класът `RBHangman::DB` дефинира връзката с базата данни `rbhangman.db`. Тази база данни има две таблици: `HIGHSCORES`, `DICTIONARY`.

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

selector(select, from, where = nil, order_by = nil)

inserter(table, values, columns)

updater(update, set, where)
```

Класът `RBHangman::Word` е наследник на `RBHangman::DB`.

При създаване на нова инстанция на `RBHangman::Word`, в инстанционната променлива `@hidden` се зарежда произволна дума от БД като списък от букви.
 
```ruby
try(letter)

alias [] try
```

Горният публичен метод ни позволява работа с думата според правилата на играта бесеница. Отгатнатите букви се пазят в списъка `@revealed`.


Подобно на `RBHangman::Word`, класът `RBHangman::Player` е също наследник на `RBHangman::DB`. Всеки обект от този клас съдържа обект от клас `RBHangman::Word`, а също така и инстанционни променливи за име и брой отгатнати думи - `@name` и `@score`. Играта приключва, когато бъдат направени 10 грешни опита за отгатване на буквите на дадена дума. Прави се запис в таблицата `HIGHSCORES` в случай, че е постигнат нов рекорд.

По-важни методи от този клас са:

```ruby
try_letter(letter)

alias [] try_letter
```
```ruby
new_word
```


Класът `RBHangman::Game` също наследява от `RBHangman::DB`.

По-важни методи от този клас са: 

```ruby
in_database?(word)

add_new(word)

highscores(top = 10)

select_player(name)

player_name

...
```






Следва продължение ...

В процес на разработка ...





