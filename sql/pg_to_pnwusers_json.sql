COPY (SELECT ROW_TO_JSON(t) FROM (
    SELECT radio_id, callsign, name, city, state, country, last_heard
    FROM pnwusers
    ORDER BY last_heard DESC
) t)
TO STDOUT
