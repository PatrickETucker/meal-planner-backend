BEGIN;

DROP TABLE IF EXISTS users_recipe;
DROP TABLE IF EXISTS recipe_ingredient;
DROP TABLE IF EXISTS recipe_tags;
DROP TABLE IF EXISTS tags;
DROP TABLE IF EXISTS ingredient;
DROP TABLE IF EXISTS recipe;
DROP TABLE IF EXISTS users;

CREATE TABLE users
(
    user_id       SERIAL PRIMARY KEY,
    username      VARCHAR(50)  NOT NULL,
    password_hash VARCHAR(200) NOT NULL,
    role          VARCHAR(50)  NOT NULL
);

CREATE TABLE recipe
(
    recipe_id    SERIAL PRIMARY KEY,
    recipe_name  VARCHAR(50) NOT NULL,
    instructions TEXT        NOT NULL,
    is_private   BOOLEAN     NOT NULL DEFAULT FALSE,
    image_url    VARCHAR(100)
);

CREATE TABLE ingredient
(
    ingredient_id   SERIAL PRIMARY KEY,
    ingredient_name VARCHAR(50) NOT NULL
);

CREATE TABLE tags
(
    tag_id   SERIAL PRIMARY KEY,
    tag_name VARCHAR(50) NOT NULL
);

CREATE TABLE recipe_tags
(
    recipe_id INTEGER REFERENCES recipe (recipe_id),
    tag_id    INTEGER REFERENCES tags (tag_id),
    PRIMARY KEY (recipe_id, tag_id)
);


CREATE TABLE users_recipe
(
    user_id   INTEGER REFERENCES users (user_id) ON DELETE CASCADE,
    recipe_id INTEGER REFERENCES recipe (recipe_id) ON DELETE CASCADE,
    PRIMARY KEY (user_id, recipe_id)
);

CREATE TABLE recipe_ingredient
(
    recipe_id     INTEGER REFERENCES recipe (recipe_id) ON DELETE CASCADE,
    ingredient_id INTEGER REFERENCES ingredient (ingredient_id) ON DELETE CASCADE,
    quantity      NUMERIC     NOT NULL,
    unit          VARCHAR(10) NOT NULL,
    PRIMARY KEY (recipe_id, ingredient_id)
);

INSERT INTO users (username, password_hash, role)
VALUES ('user', '$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC', 'ROLE_USER'),
       ('admin', '$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC', 'ROLE_ADMIN');

-- Insert 5 recipes into the 'recipe' table
INSERT INTO recipe (recipe_name, instructions, is_private, image_url)
VALUES ('Spaghetti Carbonara', 'Boil pasta. Cook bacon. Mix with eggs and cheese.', FALSE,
        'http://example.com/carbonara.jpg'),
       ('Margherita Pizza', 'Prepare dough. Add tomatoes, mozzarella, and basil. Bake.', FALSE,
        'http://example.com/margherita.jpg'),
       ('Vegetable Stir Fry', 'Fry mixed vegetables. Add sauce. Serve with rice.', FALSE,
        'http://example.com/stirfry.jpg'),
       ('Chicken Curry', 'Cook chicken pieces. Add curry sauce. Simmer. Serve with rice.', FALSE,
        'http://example.com/curry.jpg'),
       ('Beef Tacos', 'Cook beef with spices. Serve in tortillas with toppings.', FALSE,
        'http://example.com/tacos.jpg');

INSERT INTO users_recipe (user_id, recipe_id)
VALUES (1, 1),
       (1, 2),
       (1, 3),
       (1, 4),
       (1, 5);

-- Insert ingredients into the 'ingredient' table
INSERT INTO ingredient (ingredient_name)
VALUES ('Pasta'),
       ('Bacon'),
       ('Eggs'),
       ('Cheese'),
       ('Dough'),
       ('Tomatoes'),
       ('Mozzarella'),
       ('Basil'),
       ('Mixed Vegetables'),
       ('Sauce'),
       ('Rice'),
       ('Chicken Pieces'),
       ('Curry Sauce'),
       ('Beef'),
       ('Spices'),
       ('Tortillas');

-- Associate ingredients with recipes in 'recipe_ingredient' table
-- Recipe 1: Spaghetti Carbonara
INSERT INTO recipe_ingredient (recipe_id, ingredient_id, quantity, unit)
VALUES (1, 1, 100, 'g'),
       (1, 2, 50, 'g'),
       (1, 3, 2, 'pcs'),
       (1, 4, 50, 'g');

-- Recipe 2: Margherita Pizza
INSERT INTO recipe_ingredient (recipe_id, ingredient_id, quantity, unit)
VALUES (2, 5, 1, 'pcs'),
       (2, 6, 2, 'pcs'),
       (2, 7, 100, 'g'),
       (2, 8, 5, 'leaves');

-- Recipe 3: Vegetable Stir Fry
INSERT INTO recipe_ingredient (recipe_id, ingredient_id, quantity, unit)
VALUES (3, 9, 200, 'g'),
       (3, 10, 50, 'ml'),
       (3, 11, 100, 'g');

-- Recipe 4: Chicken Curry
INSERT INTO recipe_ingredient (recipe_id, ingredient_id, quantity, unit)
VALUES (4, 12, 200, 'g'),
       (4, 13, 100, 'ml'),
       (4, 11, 100, 'g');

-- Recipe 5: Beef Tacos
INSERT INTO recipe_ingredient (recipe_id, ingredient_id, quantity, unit)
VALUES (5, 14, 200, 'g'),
       (5, 15, 5, 'g'),
       (5, 16, 3, 'pcs');

INSERT INTO tags (tag_name)
VALUES ('Mexican'),
       ('Quick Meals');

INSERT INTO recipe_tags (recipe_id, tag_id)
VALUES (5, 1),
       (5, 2);

INSERT INTO tags (tag_name)
VALUES ('Indian');

INSERT INTO recipe_tags (recipe_id, tag_id)
VALUES (4, 3),
       (4, 2);

INSERT INTO tags (tag_name)
VALUES ('Asian');

INSERT INTO recipe_tags (recipe_id, tag_id)
VALUES (3, 4),
       (3, 2);

INSERT INTO tags (tag_name)
VALUES ('Italian');

INSERT INTO recipe_tags (recipe_id, tag_id)
VALUES (2, 5),
       (2, 2);

INSERT INTO tags (tag_name)
VALUES ('Pasta');

INSERT INTO recipe_tags (recipe_id, tag_id)
VALUES (1, 3),
       (1, 2);


COMMIT;
