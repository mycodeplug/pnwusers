CREATE SEQUENCE rown;

COPY (
  SELECT nextval('rown') as "No.",
         radio_id as "Radio ID",
         UPPER(callsign) as "Callsign",
         CONCAT(INITCAP(name), UPPER(SUBSTRING(surname from 0 for 1))) as "Name",
         INITCAP(city) as "City",
         INITCAP(state) as "State",
         INITCAP(country) as "Country",
         COALESCE(
             NULLIF(remarks, 'DMR'),
             CONCAT(
                 'LH: ',
                 TO_CHAR(last_heard, 'YYYY-MM-DD'),
                 ' on ',
                 last_heard_talkgroup
             )
         ) as "Remarks",
         'Private Call' as "Call Type",
         'None' as "Call Alert"
  FROM pnwusers
  WHERE callsign <> ''
  ORDER BY last_heard DESC
) TO STDOUT DELIMITER ',' CSV HEADER QUOTE '"';
DROP SEQUENCE rown;
