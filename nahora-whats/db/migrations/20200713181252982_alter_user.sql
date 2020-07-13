-- +micrate Up
-- SQL in section 'Up' is executed when this migration is applied
ALTER TABLE users ADD COLUMN username TEXT;
ALTER TABLE users ADD COLUMN age TEXT;
ALTER TABLE users ADD COLUMN phone TEXT;

-- +micrate Down
-- SQL section 'Down' is executed when this migration is rolled back
ALTER TABLE users DROP COLUMN username;
ALTER TABLE users DROP COLUMN age ;
ALTER TABLE users DROP COLUMN phone;