# Transactions
Run app:

  docker pull postgres:15-alpine
  
  docker run --name transactions --network bank-network -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:15-alpine
  
  docker logs postgres15
  
  docker exec -it postgres15 psql -U root
