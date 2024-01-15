create or replace function fn_uuid_time_ordered() returns uuid as $$
declare
    v_time timestamp with time zone:= null;
    v_secs bigint := null;
    v_usec bigint := null;

    v_timestamp bigint := null;
    v_timestamp_hex varchar := null;

    v_clkseq_and_nodeid bigint := null;
    v_clkseq_and_nodeid_hex varchar := null;

    v_bytes bytea;

    c_epoch bigint := -12219292800; -- RFC-4122 epoch: '1582-10-15 00:00:00'
    c_variant bit(64):= x'8000000000000000'; -- RFC-4122 variant: b'10xx...'
begin

    -- Get seconds and micros
    v_time := clock_timestamp();
    v_secs := EXTRACT(EPOCH FROM v_time);
    v_usec := mod(EXTRACT(MICROSECONDS FROM v_time)::numeric, 10^6::numeric);

    -- Generate timestamp hexadecimal (and set version 6)
    v_timestamp := (((v_secs - c_epoch) * 10^6) + v_usec) * 10;
    v_timestamp_hex := lpad(to_hex(v_timestamp), 16, '0');
    v_timestamp_hex := substr(v_timestamp_hex, 2, 12) || '6' || substr(v_timestamp_hex, 14, 3);

    -- Generate clock sequence and node identifier hexadecimal (and set variant b'10xx')
    v_clkseq_and_nodeid := ((random()::numeric * 2^62::numeric)::bigint::bit(64) | c_variant)::bigint;
    v_clkseq_and_nodeid_hex := lpad(to_hex(v_clkseq_and_nodeid), 16, '0');

    -- Concat timestemp, clock sequence and node identifier hexadecimal
    v_bytes := decode(v_timestamp_hex || v_clkseq_and_nodeid_hex, 'hex');

    return encode(v_bytes, 'hex')::uuid;

end $$ language plpgsql;

CREATE TABLE cars (
    id uuid DEFAULT fn_uuid_time_ordered() PRIMARY KEY,
    model TEXT,
    registration_number TEXT,
    fuel_level INTEGER CHECK ( fuel_level BETWEEN 0 AND 100),
    is_reserve BOOLEAN DEFAULT FALSE NOT NULL
);

INSERT INTO cars (id, model, registration_number, fuel_level, is_reserve) VALUES
    ('700abb4a-9501-4f68-af60-36efd0b0c595', 'Kia Rio', 'о787оо50', 40, true),
    ('2fc2c9e5-ffd4-4877-9fa6-2e25152d75ee', 'VW Polo', 'е887ео777', 20, false),
    ('e476304b-68a8-46bf-80a8-ca9cf5c18c4b', 'VW Polo', 'м761он797', 50, true),
    ('d5b957bc-7c46-44df-9eea-fa7d6aefd88b', 'Toyota RAV4', 'н761он797', 80, true)
;
