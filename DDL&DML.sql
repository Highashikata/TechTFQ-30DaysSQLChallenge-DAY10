DROP TABLE IF EXISTS auto_repair;

CREATE TABLE auto_repair
  (
     client      VARCHAR(20),
     auto        VARCHAR(20),
     repair_date INT,
     indicator   VARCHAR(20),
     value       VARCHAR(20)
  );

INSERT INTO auto_repair
VALUES     ('c1',
            'a1',
            2022,
            'level',
            'good');

INSERT INTO auto_repair
VALUES     ('c1',
            'a1',
            2022,
            'velocity',
            '90');

INSERT INTO auto_repair
VALUES     ('c1',
            'a1',
            2023,
            'level',
            'regular');

INSERT INTO auto_repair
VALUES     ('c1',
            'a1',
            2023,
            'velocity',
            '80');

INSERT INTO auto_repair
VALUES     ('c1',
            'a1',
            2024,
            'level',
            'wrong');

INSERT INTO auto_repair
VALUES     ('c1',
            'a1',
            2024,
            'velocity',
            '70');

INSERT INTO auto_repair
VALUES     ('c2',
            'a1',
            2022,
            'level',
            'good');

INSERT INTO auto_repair
VALUES     ('c2',
            'a1',
            2022,
            'velocity',
            '90');

INSERT INTO auto_repair
VALUES     ('c2',
            'a1',
            2023,
            'level',
            'wrong');

INSERT INTO auto_repair
VALUES     ('c2',
            'a1',
            2023,
            'velocity',
            '50');

INSERT INTO auto_repair
VALUES     ('c2',
            'a2',
            2024,
            'level',
            'good');

INSERT INTO auto_repair
VALUES     ('c2',
            'a2',
            2024,
            'velocity',
            '80');

SELECT *
FROM   auto_repair; 