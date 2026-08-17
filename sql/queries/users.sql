-- name: CreateUser :one
INSERT INTO users (id, created_at, updated_at, email, hashed_password)
VALUES (
    gen_random_uuid(),
    NOW() AT TIME ZONE 'UTC',
    NOW() AT TIME ZONE 'UTC',
    $1,
    $2
)
RETURNING *;

-- name: CheckUser :one
SELECT CASE
    WHEN EXISTS (SELECT 1 FROM users WHERE id = $1)
    THEN TRUE
    ELSE FALSE
END as user_exists;

-- name: GetUserByEmail :one
SELECT * FROM users
WHERE email = $1;
