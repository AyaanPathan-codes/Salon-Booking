-- =====================================================
-- ENUMS
-- =====================================================

CREATE TYPE appointment_status AS ENUM (
    'BOOKED',
    'COMPLETED',
    'CANCELLED',
    'NO_SHOW'
);



CREATE TYPE day_of_week_enum AS ENUM (
    'MONDAY',
    'TUESDAY',
    'WEDNESDAY',
    'THURSDAY',
    'FRIDAY',
    'SATURDAY',
    'SUNDAY'
);
-- =====================================================
-- SERVICES
-- =====================================================

CREATE TABLE services
(
    id BIGSERIAL PRIMARY KEY,

    name VARCHAR(100) NOT NULL,

    description TEXT,

    duration_minutes INTEGER NOT NULL,

    price DECIMAL(10,2) NOT NULL,

    active BOOLEAN NOT NULL DEFAULT TRUE,

    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,

    updated_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT uq_services_name
        UNIQUE (name),

    CONSTRAINT chk_services_duration
        CHECK (duration_minutes > 0),

    CONSTRAINT chk_services_price
        CHECK (price >= 0)
);

CREATE INDEX idx_services_active
ON services(active);

-- =====================================================
-- CUSTOMERS
-- =====================================================

CREATE TABLE customers
(
    id BIGSERIAL PRIMARY KEY,

    name VARCHAR(100) NOT NULL,

    phone VARCHAR(20) NOT NULL,

    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,

    updated_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT uq_customers_phone
        UNIQUE(phone)
);

CREATE INDEX idx_customers_phone
ON customers(phone);

-- =====================================================
-- WORKING HOURS
-- =====================================================

CREATE TABLE working_hours
(
    id BIGSERIAL PRIMARY KEY,

    day_of_week day_of_week_enum  NOT NULL,

    start_time TIME NOT NULL,

    end_time TIME NOT NULL,

    is_closed BOOLEAN NOT NULL DEFAULT FALSE,

    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,

    updated_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT chk_working_hours_time
        CHECK(start_time < end_time)
);

-- =====================================================
-- APPOINTMENTS
-- =====================================================

CREATE TABLE appointments
(
    id BIGSERIAL PRIMARY KEY,

    customer_id BIGINT NOT NULL,

    service_id BIGINT NOT NULL,

    appointment_date DATE NOT NULL,

    start_time TIME NOT NULL,

    end_time TIME NOT NULL,

    status appointment_status NOT NULL,

    notes TEXT,

    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,

    updated_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT chk_appointments_time
        CHECK(start_time < end_time),

    CONSTRAINT uq_appointments_date_start_time
        UNIQUE(appointment_date, start_time),

    CONSTRAINT fk_appointments_customer
        FOREIGN KEY(customer_id)
        REFERENCES customers(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_appointments_service
        FOREIGN KEY(service_id)
        REFERENCES services(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE INDEX idx_appointments_date
ON appointments(appointment_date);

CREATE INDEX idx_appointments_status
ON appointments(status);

CREATE INDEX idx_appointments_customer_id
ON appointments(customer_id);

CREATE INDEX idx_appointments_service_id
ON appointments(service_id);