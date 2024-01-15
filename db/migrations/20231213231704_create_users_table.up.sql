CREATE TABLE "users"
(
    "id"              uuid DEFAULT fn_uuid_time_ordered() PRIMARY KEY,
    "email"           varchar(255) NOT NULL UNIQUE CHECK (email <> ''),
    "password"        varchar(255) NOT NULL CHECK (password <> ''),
    "role"            int DEFAULT 0 NOT NULL CHECK (role BETWEEN 0 AND 3),
    "created_at"      timestamptz DEFAULT now()
);

CREATE TABLE "tokens"
(
    "id"          uuid DEFAULT fn_uuid_time_ordered() PRIMARY KEY,
    "token"       varchar(511) NOT NULL UNIQUE,
    "user_id"     uuid NOT NULL,
    "created_at"  timestamptz DEFAULT now(),
    "expires_at"  timestamptz DEFAULT now(),
    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
);

-- passwords: test123 hashed
INSERT INTO users (id, email, password, role) VALUES
                  ('c9c5b5e9-27d8-42b3-acbc-ed236a3e5492', '79846274627', '$2a$10$jUOo/SnKN.kg2NgNFmZ7O.m2DPWmU9NczejYe3cfDL79ijvroum3q', 2),
                  ('32906384-feb3-4f58-ba2e-97eda8432e79', '79175628572', '$2a$10$jUOo/SnKN.kg2NgNFmZ7O.m2DPWmU9NczejYe3cfDL79ijvroum3q', 1),
                  ('1715f2dc-fecf-4542-8061-43b8f1486b46', '79165524511', '$2a$10$jUOo/SnKN.kg2NgNFmZ7O.m2DPWmU9NczejYe3cfDL79ijvroum3q', 0);

CREATE TABLE "rides"
(
    "id"          uuid DEFAULT fn_uuid_time_ordered() PRIMARY KEY,
    "user_id"     uuid NOT NULL,
    "car_id"      uuid NOT NULL,
    "created_at"  timestamptz DEFAULT now(),
    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
    FOREIGN KEY (car_id) REFERENCES cars (id) ON DELETE CASCADE
);

INSERT INTO rides (user_id, car_id) VALUES
                    ('c9c5b5e9-27d8-42b3-acbc-ed236a3e5492', '700abb4a-9501-4f68-af60-36efd0b0c595'),
                    ('32906384-feb3-4f58-ba2e-97eda8432e79', '2fc2c9e5-ffd4-4877-9fa6-2e25152d75ee'),
                    ('1715f2dc-fecf-4542-8061-43b8f1486b46', 'e476304b-68a8-46bf-80a8-ca9cf5c18c4b');