# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: Théo <theoclaereboudt@gmail.com>           +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/06/22 16:51:57 by tclaereb          #+#    #+#              #
#    Updated: 2025/06/24 21:26:40 by Théo             ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

COMPOSE	:= docker-compose -f ./srcs/compose.yml

all: build run

build: create_dir
	$(COMPOSE) build $(SERVICES)

run: create_dir
	$(COMPOSE) up -d $(SERVICES)

stop:
	$(COMPOSE) down $(SERVICES)

restart: stop all

test:
	@echo $(TEST)

logs:
	$(COMPOSE) logs -f

clean:
	@echo "Useless instruction, please refer to stop, restart or fclean."

fclean: stop
	@docker-compose rm -f -s -v 2>/dev/null || true
	@docker volume rm -f $$(docker volume ls -q) 2>/dev/null || true
	@docker system prune -a -f || true

re: fclean all

create_dir:
	@mkdir -p "${PWD}/data/wordpress"
	@mkdir -p "${PWD}/data/mariadb"
	@mkdir -p "${PWD}/data/website"


.PHONY: all build run down restart logs clean fclean create_dir
