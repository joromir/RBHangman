## RBHangman

Курсов проект по Програмиране с Ruby.

Пресъздаване на класическата игра бесеница.

Проектът е в процес на разработка!

## Изисквания

ruby-2.2.0

Необходимо е да бъдат инсталирани следните gem-ове:

`gem install sqlite3`


В процес на разработка ...

Следва продължение ...

## Инсталация

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

Този клас притежава и два класови метода: 

```ruby
in_database?(word)

add_new(word)
```

Подобно на `RBHangman::Word`, класът `RBHangman::Player` е също наследник на `RBHangman::DB`. Всеки обект от този клас съдържа обект от клас `RBHangman::Word`, а също така и инстанционни променливи за име и брой отгатнати думи - `@name` и `@score`. Играта приключва, когато бъдат направени 10 грешни опита за отгатване на буквите на дадена дума. Прави се запис в таблицата `HIGHSCORES` в случай, че е постигнат нов рекорд.

По-важни методи от този клас са:

```ruby
try_letter(letter)

new_word
```
```ruby
alias [] try_letter
```


Класът `RBHangman::Game` също наследява от `RBHangman::DB`.

Следва продължение ...

В процес на разработка ...





