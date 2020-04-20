create or replace TRIGGER INSERT_GAME_SET_STADIUM 
BEFORE INSERT ON games
FOR EACH ROW
DECLARE
v_stadium teams.stadium%type;
BEGIN 
  if :NEW.STADIUM is null then     
      select stadium
      into :NEW.stadium
      from teams
      where team_id = :NEW.A_TEAM_ID;      
  end if;
END;

select * from NLS_SESSION_PARAMETERS;
