--------------------------------------------------------
--  File created - Tuesday-April-21-2020   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package CALCULATIONS
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "AABD"."CALCULATIONS" AS 

  procedure match_comparison; 
  
  function check_match_result(
    P_A_TEAM_ID IN VARCHAR2,
    A_score IN Number,
    P_B_TEAM_ID IN VARCHAR2,
    B_score In number
    ) RETURN VARCHAR2;
    
  procedure calculate_probability_A;
      
END CALCULATIONS;

/
