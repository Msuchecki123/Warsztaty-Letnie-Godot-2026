# Warsztaty letnie Godot \- dokumentacja

## Wstęp

Są to warsztaty przeznaczone dla licealistów, które na ogół organizowaliśmy przy **Dniach Otwartych**.  
Zawiera 4 poziomy, w których mają zmienić coś w edytorze aby przejść poziom, przy okazji poznają Godota i zapoznając się z inspektorem. Jest wiele rozwiązań i żadne nie jest złe, ale w każdym jest opisany “intended” sposób.

## Setup

Trzeba pobrać Godota 4.5.1 stable. Wrzucić folder z projektem np. na pulpit.  
Odpalić Godota, kliknąć **Import** i znaleźć nasz projekt.

## Działanie

W pokolorowanych folderach jest scena world.tscn, która posiada na @export zmienne gracza i level.  
Uczestnicy ilekroć wgrywają nowy level muszą przeciągnąć scenę z eksploratora plików z lewej do inspektora, w miejsce levelu.  
Są elementy **interagujące** i **interaktywne.**  
**Interagujące** mają w @eskport zmienną Interakcji, która przyjmuje obiekt **Interaktywny**.

#### **Level 1**

Tu nie trzeba nic zmieniać. Uczestnicy mają po prostu zapoznać się z wrzuceniem levelu do inspektora, mają zaznaczony node World, na jego scenie.

#### **Level 2**

Mamy tu dwoje drzwi. Klucz pasuje do tych na dole, ale one nie prowadzą do wyjścia.  
Uczestnicy mają tu nauczyć się korzystania z komponentów w @export.  
Należy wejść w klucz, który ma już dodaną interakcję ale nie z tymi drzwiami co trzeba.  
Wystarczy kliknąć Gate2 i podmienić go na Gate1.

#### **Level 3**

W tym levelu mamy ruszającą się platformę nad morzem lawy, podłączoną do **Timera**, a Timer do **Guzika**. Kiedy klikniemy guzik po 0.1s platforma ucieka.  
Należy tu wydłużyć czas Timer tak aby gracz mógł wskoczyć na platformę.

#### **Level 4**

Mamy tu 4 platformy, podłączone do różnych Timerów, po którym się chowają.  
Należy tu wydłużyć czas, albo usunąć interakcję z Timerów.

## Znane Błędy

Jeżeli pojawiają się 2 levely na raz to znaczy, że ktoś wrzucił scenę levelu do worlda, zamiast ją przeciągnąć do @export w “World”. Level powinien się pojawić z lewej strony tam gdzie reszta node’ów i można go bezpiecznie usunąć.

Jeżeli ktoś ma włączoną scenę world.tscn a nie widzi gdzie dać level to nie ma zaznaczonego node “World”.  
