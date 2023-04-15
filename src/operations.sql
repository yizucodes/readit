USE readit;

-- Create 15 sample users

INSERT INTO `user` (`userName`, `firstName`, `lastName`, `password`, `email`, `dateOfBirth`, `about`)
VALUES
    ('johndoe', 'John', 'Doe', 'password123', 'johndoe@example.com', '1990-01-01', 'I am a software developer.'),
    ('janedoe', 'Jane', 'Doe', 'password456', 'janedoe@example.com', '1992-05-12', 'I am a nurse.'),
    ('bobsmith', 'Bob', 'Smith', 'password789', 'bobsmith@example.com', '1985-08-27', 'I am a teacher.'),
    ('amandasmith', 'Amanda', 'Smith', 'password1234', 'amandasmith@example.com', '1987-03-04', 'I am a graphic designer.'),
    ('mikejohnson', 'Mike', 'Johnson', 'password5678', 'mikejohnson@example.com', '1995-11-20', 'I am a marketing manager.'),
    ('jennifersmith', 'Jennifer', 'Smith', 'password9012', 'jennifersmith@example.com', '1982-09-15', 'I am a business owner.'),
    ('davidmiller', 'David', 'Miller', 'password3456', 'davidmiller@example.com', '1998-02-22', 'I am a student.'),
    ('sarahjohnson', 'Sarah', 'Johnson', 'password7890', 'sarahjohnson@example.com', '1991-07-06', 'I am a lawyer.'),
    ('chrisbrown', 'Chris', 'Brown', 'password12345', 'chrisbrown@example.com', '1988-12-12', 'I am a musician.'),
    ('michaeljackson', 'Michael', 'Jackson', 'password67890', 'michaeljackson@example.com', '1970-08-29', 'I am a legend.'),
    ('angelinajolie', 'Angelina', 'Jolie', 'password123456', 'angelinajolie@example.com', '1975-06-04', 'I am an actress.'),
    ('bradpitt', 'Brad', 'Pitt', 'password234567', 'bradpitt@example.com', '1963-12-18', 'I am an actor.'),
    ('kimkardashian', 'Kim', 'Kardashian', 'password345678', 'kimkardashian@example.com', '1980-10-21', 'I am a reality TV star.'),
    ('kanyewest', 'Kanye', 'West', 'password456789', 'kanyewest@example.com', '1977-06-08', 'I am a musician and fashion designer.'),
    ('elonmusk', 'Elon', 'Musk', 'password567890', 'elonmusk@example.com', '1971-06-28', 'I am an entrepreneur and inventor.');
