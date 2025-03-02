--10
--Un trigger care monitorizeaza numarul total de evenimente
--organizate de un cititor. Cand un cititor este adaugat
--sau eliminat din tabela organizeaza, triggerul actualizeaza
--automat numarul total de evenimente organizate de acel cititor intr-un
--camp suplimentar al tabelei cititor.
create or replace trigger actualizare_autori
after insert on redacteaza
begin
    update carte c
    set nr_autori = (
        select count(*)
        from redacteaza r
        where r.id_carte = c.id_carte)
    --actualizam doar acele randuri pentru care exista
    --cel putin o potrivire cu un rand din tabelul redacteaza
    --ar actualiza cartile care nu au autori in redacteaza desi nu este necesar
    where exists (
        select 1
        from redacteaza r
        where r.id_carte = c.id_carte);
end;
/

--inainte de inserare
select nr_autori
from carte
where id_carte = 8;

insert into redacteaza values (8,7);

--dupa inserare
select nr_autori
from carte
where id_carte = 8;