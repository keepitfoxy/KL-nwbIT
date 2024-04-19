git commit - rejestracja migawki plików

git branch myBranch - tworzenie gałęzi o nazwie myBranch

git checkout <nazwa-gałęzi> - wskazanie, na której gałęzi chcemy pracować

git switch - zastępuje checkout (jest mnie przeciążone)

git checkout -b <nazwa-gałęzi> - jeśli chcesz stworzyć nową gałąź ORAZ się na nią przełączyć

git merge - scalanie gałęzi; "Chcę uwzględnić całą pracę tych rodziców *oraz* wszystkich ich przodków"

git merge <nazwa-gałęzi> - mergowanie brancha do maina, jeśli jesteśmy zczekałtowani na mainie

git rebase <nazwa-brancha> - kopiowanie zestawu commitów i wrzucanie gdzieś indziej

HEAD - commit z najnowszymi zmianami

git log - pokazuje hashe 
fed2 - mozna użyć zamiast długiego ciągu hasha

^ - Poruszanie się wstecz o jeden commit

~<num> - Poruszanie się wstecz o ileś commitów

^^ - “dziadek” commita, itd. itd. z “^”

-f - bezpośrednie przypisanie gałęzi do commita

git branch -f main HEAD~3 - przenosi (na siłę) gałąź `main` trzy commity wstecz - za HEADa.
git branch -f main HEAD~3 - przeniesienie (na siłę) na gałąź C6

git reset <nazwa brancha> - wraca do starszego commita (ten nowy “zły” jakby w ogóle nie został dodany) - to jest spoko, jak działamy lokalnie

git reset HEAD~1 - wraca do wersji o jedno oczko wyżej

git revert <nazwa brancha> - W celu odwrócenia zmian i *podzielenia się* nimi z innymi - tworzy nową “starą” zmianę, z którą możemy się podzielić z innymi

• `git cherry-pick <Commit1> <Commit2> <...>` - Jest to bardzo prosty sposób określenia, że chcesz przenieść zmiany poniżej swojej obecnej lokalizacji (`HEAD`)
git rebase -i <do której gałęzi ma się “cofnąć” i od niej wybierać> - podobny do cherry-picka

git commit --amend -dokonanie modyfikacji w commicie
git tag <version> <nazwa-brancha> - można tagować wersje konkretnego commita

git describe <ref> - polecenie opisujące,  `<ref>` jest czymkolwiek, co git może odnieść do commita; Jeśli nie podasz `<ref>`, git użyje aktualnie checkoutowanego miejsca (`HEAD`), a wynik wygląda następująco: <tag>_<numCommits>_g<hash>;  `tag` jest znacznikiem najbliższego przodka w historii, `numCommits` jest liczbą commitów od tego znacznika, a `<hash>` jest haszem opisywanego commitu.
git bisect - na potrzeby debugowania

git checkout <nazwa-brancha>^<liczba> - jeśli mamy więcej niż jednego rodzica, to określamy dla którego z kolei rodzica mamy się odwołać

git checkout HEAD~^2~2 - skrócona wersja - idziemy o jeden poziom do góry, później do drugiego rodzica, póżniej o dwóch przodków dalej

Zdalny Git:

git clone - klonowanie repozytorium

o/main - typ gałęzi (zdalnej)
• `<remote name>/<branch name>` - stąd o/main - branch name jest main, a remote name jest o

w gicie jednak najczęściej używa się “orgin” zamiast o

git fetch - pobieranie danych ze zdalnego repo, których brakuje w naszym lokalny repo i aktualizuje miejsca, które wskazują nasze zdalne gałęzie (np. o/main)

ważne - `git fetch` nie zmienia nic w *twoim* stanie lokalnym
git pull - połączenie git fetcha i merge

git push - odpowiada za przesłanie i aktualizację *naszych* zmian na wybranego remote'a
push.default - to nie to samo, bo zależy to od wersji Gita

git pull —rebase - połączenie pulla i rebase
`! [remote rejected] main -> main (TF402455: Pushes to this branch are not permitted; you must use a pull request to update this branch.)`  - taki komunikat pojawi się, gdy ktoś zablokuje maina i trzeba zrobić pull requesta

feature branch - gałąź, którą tworzy się przy pull rqst
git checkout -b feature C2

git push origin feature

jak przenosić sidowe gałęzie na jedną całą? git rebase main side1, git rebase side1 side2 itd.

git merge <nazwa gałęzi> - łączy dotychczasowe commity na danej gałęzi

remote tracking:
`local branch "main" set to track remote branch "o/main"` - Gałąź `main` ma ustawione śledzenie gałęzi `o/main`, Po zakończeniu klonowania lokalnie masz tylko jedną gałąź

`git checkout -b totallyNotMain o/main` - (przykład)tworzy nową gałąź o nazwie `totallyNotMain` i każe jej śledzić `o/main`.

git branch -u o/main <nazwa-brancha> - spowoduje, że gałąź <nazwa-brancha> będzie śledzić `o/main`

git push <remote> <place> - schemat, ignoruje miejsce, w którym aktualnie jesteśmy, np. możemy być na C0, a i tak pushnie maina

przykład:

git push origin main - *Przejdź do gałęzi o nazwie "main" w moim repozytorium, weź wszystkie commity, a potem idź do gałęzi "main" na zdalnym repozytorium, które nazywa się "origin". Umieść na tej gałęzi wszystkie commity, których tam jeszcze nie ma, i daj znać, jak skończysz.*

git push origin <source>:<destination> - jeśli chcemy określić źródło i cel commitów; refspec 

git fetch origin <nazwa-gałęzi> - eźmie wszystkie commity, których brakuje lokalnie, i zrzuci je nam na lokalną gałąź <nazwa-gałęzi>
haczyk przy fetchowaniu za pomocą `<source>:<destination>`:  `<źródło>` to teraz *zdalne* miejsce, a `<cel>` jest *lokalnym* miejscem, na które trafią commity. To dokładne przeciwieństwo git push, i to ma sens, skoro przenosimy teraz dane w odwrotnym kierunku!

można jako <source> dać nic i wtedy po wpisaniu np takich komend:

- `git push origin :side`
- `git fetch origin :bugFix`

Jeśli pushniemy istniejące “nicości”, to usuwają się gałęzi side i bugFix (w tym przypadku)

Jeśli natomiast tych gałęzi nie było w ogóle w oryginale, to po fetchowaniu na naszą wersję pojawi sie owa gałąź

git pull origin foo = git fetch origin foo; git merge o/foo

git pull origin bar~1:bugFix = git fetch origin bar~1:bugFix; git merge bugFix

git pull origin bar:foo

git pull origin main:side