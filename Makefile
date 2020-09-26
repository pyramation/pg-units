
up:
	docker-compose up -d

down:
	docker-compose down -v

ssh:
	docker exec -it units-postgres /bin/bash

install:
	docker exec units-postgres /sql-extensions/install.sh

  