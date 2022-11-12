-- name: CreateAccount :one
INSERT INTO accounts (
    owner,
    balance
) VALUES (
             $1, $2
         ) RETURNING *;

-- name: GetAccount :one
SELECT * FROM accounts
WHERE id = $1 LIMIT 1;

-- name: GetAccountForUpdate :one
SELECT * FROM accounts
WHERE id = $1 LIMIT 1
    FOR NO KEY UPDATE;

-- name: ListAccounts :many
SELECT * FROM accounts
WHERE OWNER = $1
ORDER BY id
LIMIT $2;

-- name: UpdateAccount :one
Update accounts
SET balance = $2
WHERE id = $1
RETURNING *;

-- name: UpdateAccountBalance :one
Update accounts
SET balance = balance + sqlc.arg(amount)
WHERE id = sqlc.arg(id)
RETURNING *;

-- name: DeleteAccount :exec
DELETE FROM accounts
WHERE id = $1;