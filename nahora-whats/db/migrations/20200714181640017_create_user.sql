03:41:47  [583µs]   CREATE TABLE IF NOT EXISTS __clear_metadatas ( metatype text NOT NULL, value text NOT NULL );
03:41:47  [1ms]   CREATE UNIQUE INDEX IF NOT EXISTS __clear_metadatas_idx ON __clear_metadatas (metatype, value);
03:41:47  [1ms] SELECT * FROM __clear_metadatas WHERE ("metatype" = 'migration')
03:41:47  [370µs] BEGIN
2020-07-14T18:41:47.416842Z   INFO - [Clear::Migration::Direction(@dir=true)] CreateTable
03:41:47  (Info) [Clear::Migration::Direction(@dir=true)] CreateTable
03:41:47  [1ms] CREATE TYPE gender AS ENUM ('male', 'female', 'unknow')
03:41:47  [759µs] CREATE TYPE renda AS ENUM ('low', 'mid', 'high', 'unknow')
03:41:47  [42ms] CREATE TABLE users (id bigserial NOT NULL PRIMARY KEY, username text NOT NULL, phone text NOT NULL, money float, gender gender DEFAULT 'unknow', renda renda DEFAULT 'unknow', created_at timestamp without time zone NOT NULL DEFAULT NOW(), updated_at timestamp without time zone NOT NULL DEFAULT NOW())
03:41:47  [14ms] CREATE UNIQUE INDEX users_phone ON users (phone)
03:41:47  [14ms] CREATE INDEX users_created_at ON users (created_at)
03:41:47  [13ms] CREATE INDEX users_updated_at ON users (updated_at)
03:41:47  [1ms] INSERT INTO "__clear_metadatas" ("metatype", "value") VALUES ('migration', '1')
03:41:47  [7ms] COMMIT
nil
03:41:47  [409µs] BEGIN
03:41:47  [504µs] ROLLBACK --program error
