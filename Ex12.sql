create table log1 (
    moment_timp  timestamp,
    utilizator varchar2(50),
    tip varchar2(50),
    nume_obiect varchar2(50),
    tip_obiect varchar2(50));
    
create or replace trigger exercitiul_12 
after create or alter or drop
on schema
begin
    insert into log1 (
        moment_timp,
        utilizator,
        tip,
        nume_obiect,
        tip_obiect)
    values (
        systimestamp,
        user,
        ora_sysevent,  
        ora_dict_obj_name, 
        ora_dict_obj_type); 
end;
/