--8
--Fornmuleaza o functie care primeste numele complet al unui cititor
--(nume + prenume) ca parametru si returneaza cartea imprumutata
--cel mai recent de catre cititorul specificat.
--Cartea va fi afisata cu toate datele sale 
--la care se adauga aici si autorul/autorii
--care au redactat acea carte impreuna cu nationalitatea
--fiecaruia
create or replace function exercitiul_8(
    nume_cititor in varchar2) return varchar2 is
        v_id_carte number;
        v_an_aparitie number;
        v_gen varchar2(50);
        v_nr_autori number;
        v_titlu varchar2(50);
        v_nr number;
        v_rezultat varchar2(2000);
            
begin
    select count(*)
    into v_nr
    from cititor
    where (nume || ' ' || prenume) = nume_cititor;
 
    if v_nr = 0 then
        return 'Cititorul nu a fost gasit in baza de date.';
    elsif v_nr > 1 then
        raise too_many_rows;
    end if;
 
    select ca.id_carte, ca.titlu, ca.an_aparitie, ca.gen, ca.nr_autori
    into v_id_carte, v_titlu, v_an_aparitie, v_gen, v_nr_autori
    from carte ca
    join imprumut i on i.id_carte = ca.id_carte
    join cititor c on c.id_cititor = i.id_cititor
    where (c.nume || ' ' || c.prenume) = nume_cititor
    order by i.data_imprumut desc
    fetch first 1 row only;
    
    v_rezultat := 'Ultima carte imprumutata: ' 
            || v_titlu || chr(10) || 
            '   Anul aparitiei: ' || v_an_aparitie
            || chr(10) || '   Genul cartii: ' || v_gen ||
            chr(10) || '   Numarul de autori: ' || v_nr_autori || ' care sunt urmatorii: ' || chr(10);
    
    for i in (select a.nume, a.prenume, a.nationalitate
              from autor a
              join redacteaza r on r.id_autor = a.id_autor
              where r.id_carte = v_id_carte) loop
        v_rezultat := v_rezultat || '      Numele: ' || i.nume ||
                    ' ' || i.prenume || chr(10) ||
                    '      Nationalitate: ' || i.nationalitate || chr(10);
    end loop;
    return v_rezultat;
exception
    when no_data_found then
        return 'Cititorul nu a facut niciun imprumut in baza de date';
    when too_many_rows then
        return 'Exista mai multi cititori cu acest nume.';
    when others then
        return 'Alta eroare.';
end;
/
 
declare
    v_nume varchar2(50) := '&nume';
begin
    dbms_output.put_line(exercitiul_8(v_nume));
end;
/