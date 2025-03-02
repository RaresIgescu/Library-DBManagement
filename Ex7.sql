--7
--Sa se afiseze pentru fiecare editura numele autorilor
--si titlurile cartilor scrise de ei care au fost
--publicate de editura respectiva dupa anul 2000
--si care au fost imprumutate cel putin o data
create or replace procedure exercitiul_7 is
    cursor edituri is
        select id_editura, nume
        from editura;
    
    cursor carti_autori(v_id_editura number) is
        select distinct a.nume, a.prenume, c.titlu
        from autor a
        join redacteaza r on a.id_autor = r.id_autor
        join carte c on c.id_carte = r.id_carte
        join imprumut i on i.id_carte = c.id_carte
        where c.id_editura = v_id_editura
        and c.an_aparitie > 2000;
    v_editura edituri%rowtype;
    v_carti_autori carti_autori%rowtype;
    bool number := 0;
begin
    open edituri;
    loop
        fetch edituri into v_editura;
        exit when edituri%notfound;
        
        dbms_output.put_line('Editura: ' || v_editura.nume);
        open carti_autori(v_editura.id_editura);
        bool := 1;
        loop
            fetch carti_autori into v_carti_autori;
            exit when carti_autori%notfound;
            
            bool := 0;
            
            dbms_output.put_line('  Autor: ' || v_carti_autori.nume || ' ' || v_carti_autori.prenume);
            dbms_output.put_line('      Carte: ' || v_carti_autori.titlu);
        dbms_output.new_line;
        end loop;
        if bool = 1 then
            dbms_output.put_line('   Nu are nicio carte publicata care sa respecte cerintele.');
        end if;
        close carti_autori;
    dbms_output.new_line;
    dbms_output.put_line('------------------------------------------');
    dbms_output.new_line;
    end loop;
    close edituri;
end exercitiul_7;
/
 
begin
    exercitiul_7;
end;
/