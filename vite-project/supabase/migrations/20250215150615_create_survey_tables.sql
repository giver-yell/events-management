-- Survey_types table
CREATE TABLE Survey_types (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

-- Question_Master table
CREATE TABLE Question_Master (
    id SERIAL PRIMARY KEY,
    question_text TEXT NOT NULL,
    is_choice BOOLEAN NOT NULL
);

-- Choice_Master table
CREATE TABLE Choice_Master (
    id SERIAL PRIMARY KEY,
    choice_text TEXT NOT NULL,
    question_master_id INT NOT NULL,
    FOREIGN KEY (question_master_id) REFERENCES Question_Master (id) ON DELETE CASCADE
);

-- Event_questions table
CREATE TABLE Event_questions (
    id SERIAL PRIMARY KEY,
    event_id INT NOT NULL,
    question_master_id INT NOT NULL,
    FOREIGN KEY (question_master_id) REFERENCES Question_Master (id) ON DELETE CASCADE
);

-- User_surveys table
CREATE TABLE User_surveys (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    event_id INT NOT NULL,
    survey_type_id SMALLINT NOT NULL,
    FOREIGN KEY (survey_type_id) REFERENCES Survey_types (id) ON DELETE CASCADE
);

-- Survey_answers table
CREATE TABLE Survey_answers (
    id SERIAL PRIMARY KEY,
    user_survey_id INT NOT NULL,
    event_question_id INT NOT NULL,
    choice_master_id INT,
    answer_text TEXT,
    FOREIGN KEY (user_survey_id) REFERENCES User_surveys (id) ON DELETE CASCADE,
    FOREIGN KEY (event_question_id) REFERENCES Event_questions (id) ON DELETE CASCADE,
    FOREIGN KEY (choice_master_id) REFERENCES Choice_Master (id) ON DELETE CASCADE
);

-- Genders table
CREATE TABLE Genders (
    id SMALLINT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

-- User_roles table
CREATE TABLE User_roles (
    id SMALLINT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- User_statuses table
CREATE TABLE User_statuses (
    id SMALLINT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Users table
CREATE TABLE Users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL,
    line_id VARCHAR(100),
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    furigana_first_name VARCHAR(50) NOT NULL,
    furigana_last_name VARCHAR(50) NOT NULL,
    birth_date DATE,
    phone_number VARCHAR(20),
    gender_id SMALLINT NOT NULL,
    user_role_id SMALLINT NOT NULL,
    user_status_id SMALLINT NOT NULL,
    FOREIGN KEY (gender_id) REFERENCES Genders (id) ON DELETE CASCADE,
    FOREIGN KEY (user_role_id) REFERENCES User_roles (id) ON DELETE CASCADE,
    FOREIGN KEY (user_status_id) REFERENCES User_statuses (id) ON DELETE CASCADE
);

-- Children table
CREATE TABLE Children (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    furigana_first_name VARCHAR(50) NOT NULL,
    furigana_last_name VARCHAR(50) NOT NULL,
    birth_date DATE NOT NULL,
    gender_id SMALLINT NOT NULL,
    FOREIGN KEY (gender_id) REFERENCES Genders (id) ON DELETE CASCADE
);

-- Users_children table
CREATE TABLE Users_children (
    parent_id INT NOT NULL,
    child_id INT NOT NULL,
    PRIMARY KEY (parent_id, child_id),
    FOREIGN KEY (parent_id) REFERENCES Users (id) ON DELETE CASCADE,
    FOREIGN KEY (child_id) REFERENCES Children (id) ON DELETE CASCADE
);

-- Payment_methods table
CREATE TABLE Payment_methods (
    id SMALLINT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Events_payment_methods table
CREATE TABLE Events_payment_methods (
    event_id INT NOT NULL,
    payment_method_id SMALLINT NOT NULL,
    PRIMARY KEY (event_id, payment_method_id),
    FOREIGN KEY (payment_method_id) REFERENCES Payment_methods (id) ON DELETE CASCADE
);

-- Reservations table
CREATE TABLE Reservations (
    id SERIAL PRIMARY KEY,
    event_id INT NOT NULL,
    user_id INT NOT NULL,
    payment_method_id SMALLINT NOT NULL,
    payment_status_id SMALLINT NOT NULL,
    comment TEXT,
    meal_id INT,
    FOREIGN KEY (user_id) REFERENCES Users (id) ON DELETE CASCADE,
    FOREIGN KEY (payment_method_id) REFERENCES Payment_methods (id) ON DELETE CASCADE
);

-- Event_waitlists table
CREATE TABLE Event_waitlists (
    event_id INT NOT NULL,
    user_id INT NOT NULL,
    PRIMARY KEY (event_id, user_id),
    FOREIGN KEY (user_id) REFERENCES Users (id) ON DELETE CASCADE
);

-- Owners table
CREATE TABLE Owners (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL,
    line_id VARCHAR(100),
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    furigana_first_name VARCHAR(50) NOT NULL,
    furigana_last_name VARCHAR(50) NOT NULL,
    birth_date DATE NOT NULL,
    phone_number VARCHAR(20)
);

-- Payment_timings table
CREATE TABLE Payment_timings (
    id SMALLINT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

-- Events table
CREATE TABLE Events (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    contents TEXT NOT NULL,
    cost SMALLINT NOT NULL,
    start_at TIMESTAMP NOT NULL,
    end_at TIMESTAMP NOT NULL,
    owner_id INT NOT NULL,
    payment_timing_id SMALLINT NOT NULL,
    shop_id INT NOT NULL,
    FOREIGN KEY (owner_id) REFERENCES Owners (id) ON DELETE CASCADE,
    FOREIGN KEY (payment_timing_id) REFERENCES Payment_timings (id) ON DELETE CASCADE
);

-- Reservation_cancellations table
CREATE TABLE Reservation_cancellations (
    id SERIAL PRIMARY KEY,
    reservation_id INT NOT NULL,
    user_id INT NOT NULL,
    cancel_reason TEXT,
    FOREIGN KEY (reservation_id) REFERENCES Reservations (id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES Users (id) ON DELETE CASCADE
);

-- Prefectures table
CREATE TABLE Prefectures (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

-- Cities table
CREATE TABLE Cities (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

-- Shops table
CREATE TABLE Shops (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    postal_code VARCHAR(15) NOT NULL,
    state_id INT NOT NULL,
    city_id INT NOT NULL,
    street_address VARCHAR(255) NOT NULL,
    building_address VARCHAR(255),
    phone_number VARCHAR(20),
    email VARCHAR(100),
    website VARCHAR(255),
    capacity SMALLINT NOT NULL,
    description TEXT NOT NULL,
    FOREIGN KEY (state_id) REFERENCES Prefectures (id) ON DELETE CASCADE,
    FOREIGN KEY (city_id) REFERENCES Cities (id) ON DELETE CASCADE
);

-- Payment_statuses table
CREATE TABLE Payment_statuses (
    id SMALLINT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Meals table
CREATE TABLE Meals (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    image_url VARCHAR(255),
    allergens VARCHAR(255),
    calories SMALLINT,
    shop_id INT NOT NULL,
    FOREIGN KEY (shop_id) REFERENCES Shops (id) ON DELETE CASCADE
);
