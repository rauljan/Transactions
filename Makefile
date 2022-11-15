postgres:
	docker run --name transactions --network bank-network -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:15-alpine

createdb:
	docker exec -it transactions createdb --username=root --owner=root bank

dropdb:
	docker exec -it transactions dropdb bank

migrateup:
	migrate -path db/migration -database "postgres://root:secret@localhost:5432/bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgres://root:secret@localhost:5432/bank?sslmode=disable" -verbose down

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

tidy:
	go mod tidy

vendor:
	go mod vendor

server:
	go run main.go

mock:
	mockgen -package mockdb -destination db/mock/store.go github.com/rauljan/transactions/db/sqlc Store

local:
	docker build -t transactions:latest .
	docker run --name transactions --network bank-network -p 8080:8080 -e GIN_MODE=release -e DB_SOURCE="postgres://root:secret@go-bank:5432/bank?sslmode=disable" transactions:latest

.PHONY: postgres createdb dropdb migrateup migratedown migrateup1 migratedown1 sqlc test server mock local