COPY (
  SELECT radio_id,
         UPPER(callsign),
         CONCAT(INITCAP(name), UPPER(SUBSTRING(surname from 0 for 1))),
         INITCAP(city),
         INITCAP(state),
         COALESCE(
             NULLIF(remarks, 'DMR'),
             CONCAT(
                 'LH: ',
                 TO_CHAR(last_heard, 'YYYY-MM-DD'),
                 ' on ',
                 last_heard_talkgroup
             )
         ) as "Remarks",
         INITCAP(country)
  FROM pnwusers
  WHERE callsign <> ''
  ORDER BY last_heard DESC
) TO STDOUT DELIMITER ',' CSV QUOTE '"';
