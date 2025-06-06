-- Week 5 -- Create a Trigger
-- Part 2

CREATE TRIGGER egg_filler
AFTER INSERT ON Bird_eggs
FOR EACH ROW
BEGIN
    UPDATE Bird_eggs
    SET
        Egg_num = (
            SELECT COALESCE(MAX(Egg_num), 0) + 1
            FROM Bird_eggs
            WHERE Nest_ID = NEW.Nest_ID
              AND Egg_num IS NOT NULL
        ),
        Book_page = (
            SELECT Book_page FROM Bird_nests WHERE Nest_ID = NEW.Nest_ID
        ),
        Year = (
            SELECT Year FROM Bird_nests WHERE Nest_ID = NEW.Nest_ID
        ),
        Site = (
            SELECT Site FROM Bird_nests WHERE Nest_ID = NEW.Nest_ID
        )
    WHERE Egg_num IS NULL
      AND Nest_ID = NEW.Nest_ID
      AND Length = NEW.Length
      AND Width = NEW.Width;
END;