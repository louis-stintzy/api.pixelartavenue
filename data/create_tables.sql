-- Script de création des tables de la base de données PixelArtAvenue
BEGIN;

DROP TABLE IF EXISTS "user", "artwork", "artwork_characteristics", "comment", "like", "favorites", "follow";

CREATE TABLE "user" (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255),
    avatar_url VARCHAR(255),
    created_at TIMESTAMP NOT NULL DEFAULT now(),
    updated_at TIMESTAMP
);

CREATE TABLE "artwork" (
    id SERIAL PRIMARY KEY,
    token VARCHAR(255) NOT NULL UNIQUE,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    user_id INT REFERENCES "user"(id) ON DELETE SET NULL NOT NULL, -- Anonymiser les œuvres si l'utilisateur est supprimé
    created_at TIMESTAMP NOT NULL DEFAULT now(),
    updated_at TIMESTAMP
);

CREATE TABLE "artwork_characteristics" (
    id SERIAL PRIMARY KEY,
    artwork_id INT REFERENCES "artwork"(id) ON DELETE CASCADE NOT NULL, -- Supprimer les caractéristiques si l'œuvre est supprimée
    gridSize_width INT NOT NULL,
    gridSize_height INT NOT NULL,
    gridSize_pixelSize INT NOT NULL,
    gridColor_background VARCHAR(255) NOT NULL,
    gridColor_line VARCHAR(255) NOT NULL,
    gridPrinting VARCHAR(255) NOT NULL,
    pixelColors JSONB NOT NULL
);

CREATE TABLE "comment" (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES "user"(id) ON DELETE SET NULL NOT NULL, -- Anonymiser les commentaires si l'utilisateur est supprimé
    artwork_id INT REFERENCES "artwork"(id) ON DELETE CASCADE NOT NULL, -- Supprimer les commentaires si l'œuvre est supprimée
    content TEXT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT now(),
    updated_at TIMESTAMP
);

CREATE TABLE "like" (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES "user"(id) ON DELETE CASCADE NOT NULL, -- Supprimer les likes si l'utilisateur est supprimé
    artwork_id INT REFERENCES "artwork"(id) ON DELETE CASCADE NOT NULL, -- Supprimer les likes si l'œuvre est supprimée
    created_at TIMESTAMP NOT NULL DEFAULT now()
);

CREATE TABLE "favorites" (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES "user"(id) ON DELETE CASCADE NOT NULL, -- Supprimer les favoris si l'utilisateur est supprimé
    artwork_id INT REFERENCES "artwork"(id) ON DELETE CASCADE NOT NULL, -- Supprimer les favoris si l'œuvre est supprimée
    created_at TIMESTAMP NOT NULL DEFAULT now()
);

CREATE TABLE "follow" (
    follower_id INT REFERENCES "user"(id) ON DELETE CASCADE NOT NULL, -- Supprimer le suivi si l'utilisateur suiveur est supprimé
    followed_id INT REFERENCES "user"(id) ON DELETE CASCADE NOT NULL, -- Supprimer le suivi si l'utilisateur suivi est supprimé
    created_at TIMESTAMP NOT NULL DEFAULT now(),
    PRIMARY KEY (follower_id, followed_id)
);

COMMIT;