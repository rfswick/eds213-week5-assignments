-- Week 5 -- Create a Trigger
-- Part 1

CREATE TRIGGER egg_filler
AFTER INSERT ON Bird_eggs
FOR EACH ROW
BEGIN
    UPDATE Bird_eggs
    SET Egg_num = (
        SELECT COALESCE(MAX(Egg_num), 0) + 1
        FROM Bird_eggs
        WHERE Nest_ID = NEW.Nest_ID
          AND Egg_num IS NOT NULL
    )
    WHERE Egg_num IS NULL
      AND Nest_ID = NEW.Nest_ID
      AND Length = NEW.Length
      AND Width = NEW.Width;
END;