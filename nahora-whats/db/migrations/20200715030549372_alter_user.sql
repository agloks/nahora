12:11:55  [782µs]   CREATE TABLE IF NOT EXISTS __clear_metadatas ( metatype text NOT NULL, value text NOT NULL );
12:11:55  [2ms]   CREATE UNIQUE INDEX IF NOT EXISTS __clear_metadatas_idx ON __clear_metadatas (metatype, value);
12:11:55  [1ms] SELECT * FROM __clear_metadatas WHERE ("metatype" = 'migration')
12:11:55  [245µs] BEGIN
2020-07-15T03:11:55.935283Z   INFO - [Clear::Migration::Direction(@dir=true)] CreateTable
12:11:55  (Info) [Clear::Migration::Direction(@dir=true)] CreateTable
12:11:55  [956µs] CREATE TYPE budget AS ENUM ('low', 'mid', 'high', 'unknow')
12:11:55  [4ms] ALTER TABLE users ADD budget budget NULL DEFAULT 'unknow'
12:11:55  [828µs] INSERT INTO "__clear_metadatas" ("metatype", "value") VALUES ('migration', '2')
12:11:55  [1ms] COMMIT
nil
2020-07-15T03:11:55.981946Z   INFO - command: Seeded database
12:11:55 command (Info) Seeded database  