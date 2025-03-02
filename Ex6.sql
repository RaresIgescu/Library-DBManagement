--6
--Sa se implementeze un subprogram stocat independent
--care sa gestioneze lista evenimentelor organizate de toti cititorii
--care au cel putin un imprumut activ (in care cartea nu a fost inca
--returnata) grupate dupa sala in care au avut loc
create or replace type sala is varray(20) of varchar2(50);
 
create or replace procedure exercitiul_6 is
    type nested_tipuri is table of varchar2(50);
    type indexat_tipuri_sala is table of nested_tipuri index by varchar2(50);
 
    cursor c is
        select c.id_cititor
        from cititor c
        join imprumut i on  i.id_cititor = c.id_cititor
        where data_returnare is null
        order by 1 asc;
 
    lista_sala sala;
    lista_tipuri nested_tipuri;
    lista_ambele indexat_tipuri_sala;
    v_id_cititor number;
begin
open c;
loop
    fetch c into v_id_cititor;
    exit when c%notfound;
    select distinct e.sala
    bulk collect into lista_sala
    from eveniment e
    join organizeaza o on e.id_eveniment = o.id_eveniment
    where o.id_cititor = v_id_cititor;
    
    for i in 1..lista_sala.count loop
        select e.nume
        bulk collect into lista_tipuri
        from eveniment e
        join organizeaza o on e.id_eveniment = o.id_eveniment
        where o.id_cititor = v_id_cititor
            and e.sala = lista_sala(i);
        lista_ambele(lista_sala(i)) := lista_tipuri;
    end loop;
    if lista_sala.count = 0 then
        dbms_output.put_line('Cititorul cu ID-ul ' || v_id_cititor || ' nu a organizat niciun eveniment.');
        dbms_output.new_line;
        dbms_output.put_line('------------------------------------------------');
        dbms_output.new_line;
    else
        dbms_output.put_line('Mai jos sunt prezentate evenimentele organizate de cititorul cu ID-ul: ' || v_id_cititor);
        for i in 1..lista_sala.count loop
            dbms_output.put_line('Sala: ' || lista_sala(i));
            if lista_ambele.exists(lista_sala(i)) then
                for j in 1..lista_ambele(lista_sala(i)).count loop
                    dbms_output.put_line('   Nume: ' || lista_ambele(lista_sala(i))(j));
                end loop;
            end if;
        end loop;
        dbms_output.new_line;
        dbms_output.put_line('------------------------------------------------');
        dbms_output.new_line;
    end if;
end loop;
end;
/
 
begin
    exercitiul_6;
end exercitiul_6;
/