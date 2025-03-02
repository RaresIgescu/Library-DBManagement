--11
--Creati un trigger care sa fie declansat
--automat dupa fiecare operatie de UPDATE
--asupra coloanei data_returnare din tabela
--imprumut. Trigger-ul va actualiza tabela STOC
--incrementand numarul de exemplare disponibile
--pentru cartea returnata.
create or replace trigger actualizare_stoc
after insert or update
on imprumut
for each row
begin
    if updating then
        if :OLD.data_returnare is null and :NEW.data_returnare is not null then
            update stoc
            set nr_disponibile = nr_disponibile + 1
            where id_carte = :NEW.id_carte;
        end if;
    end if;
    if inserting then
        declare
            v_nr_disponibile number;
        begin
            select nr_disponibile 
            into v_nr_disponibile
            from stoc
            where id_carte = :NEW.id_carte;
            
            if v_nr_disponibile <= 0 then
                raise_application_error(-20001, 'Nu mai sunt exemplare in biblioteca.');
            end if;
            update stoc
            set nr_disponibile  = nr_disponibile - 1
            where id_carte = :NEW.id_carte;
        end;
    end if;
end;
/