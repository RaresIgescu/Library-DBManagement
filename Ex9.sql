--9
--Scrieti o procedura care, primind ca parametri un titlu
--de carte si un numar minim de exemplare disponibile, va verifica daca exista
--suficiente exemplare din acea carte pentru a putea fi imprumutate.
--Daca exista suficiente exemplare, procedura va afisa informatiile
--despre autorii cartii,daca a fost sau nu imprumutata, locatia acesteia in biblioteca si editura
--care a publicat cartea. Daca nu exista suficiente exemplare disponibile
--procedura va lansa o exceptie. De asemenea daca titlul introdus nu exista
--in baza de date, procedura va lansa o alta exceptie proprie.
create or replace procedure exercitiul_9(
    v_titlu in varchar2,
    v_min_exe in number) 
    is
    numar_invalid exception;
    exemplare_insuficiente exception;
    
    v_exemplare number;
    v_id_carte number;
    v_id_editura number;
    v_locatie varchar2(100);
    v_nume_editura varchar2(100);
    v_numar_afisat number;
    v_stare varchar2(50);
begin
    if v_min_exe < 0 then
        raise numar_invalid;
    end if;

    select id_carte, id_editura
    into v_id_carte, v_id_editura
    from carte 
    where titlu = v_titlu;
    
    select distinct (l.etaj || ' - ' || l.zona || ' - Raftul ' || l.raft), e.nume, s.nr_disponibile, decode(i.data_imprumut,
                                                                                                        null, 'Nu a fost imprumutata',
                                                                                                        'A fost imprumutata') as stare
    into v_locatie, v_nume_editura, v_exemplare, v_stare
    from locatie l
    join carte c on c.id_locatie = l.id_locatie
    join editura e on c.id_editura = e.id_editura
    join stoc s on c.id_carte = s.id_carte
    left join imprumut i on i.id_carte = c.id_carte
    where c.id_carte = v_id_carte;
    
    if v_exemplare < v_min_exe then
        raise exemplare_insuficiente;
    end if;

    dbms_output.put_line('Autori pentru cartea "' || v_titlu || '":');
    for autor_rec in (
        select a.nume, a.prenume
        from autor a
        join redacteaza r on a.id_autor = r.id_autor
        where r.id_carte = v_id_carte) loop
        dbms_output.put_line(' - ' || autor_rec.nume || ' ' || autor_rec.prenume);
    end loop;
    
    dbms_output.put_line('Locatia cartii: ' || v_locatie);
    dbms_output.put_line('Editura cartii: ' || v_nume_editura);
    dbms_output.put_line('Stare: ' || v_stare);
exception
    when no_data_found then
        dbms_output.put_line('Eroare: Titlul nu poate fi gasit in baza de date.');
    when numar_invalid then
        dbms_output.put_line('Eroare: Numarul introdus nu este valid' || chr(10) || 'incercati un numar natural cel putin mai mare sau egal cu 1.');
    when exemplare_insuficiente then
        dbms_output.put_line('Eroare: Nu exista suficiente exemplare pentru cartea: "' || v_titlu || '".');
    when too_many_rows then
        dbms_output.put_line('Eroare: Mai multe carti au acelasi nume.');
    when others then
        dbms_output.put_line('Eroare neprevazuta.');
end;
/

declare
    v_titlu varchar2(100) := '&carte';
    v_nr number :=&numar;
begin
    exercitiul_9(v_titlu, v_nr);
end;
/