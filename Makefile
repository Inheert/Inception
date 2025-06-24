# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: tclaereb <tclaereb@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/06/22 16:51:57 by tclaereb          #+#    #+#              #
#    Updated: 2025/06/24 15:00:05 by tclaereb         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

COMPOSE	:= docker-compose -f ./srcs/compose.yml

all: build run

build: create_dir
	$(COMPOSE) build

run: create_dir
	$(COMPOSE) up -d

stop:
	$(COMPOSE) down

restart: down run

logs:
	$(COMPOSE) logs -f

clean:
	@echo "Useless instruction, please refer to down, restart or fclean."

fclean: stop
	@docker-compose rm -f -s -v 2>/dev/null || true
	@docker volume rm -f $$(docker volume ls -q) 2>/dev/null || true
	@docker system prune -a -f || true

re: fclean all

create_dir:
	@mkdir -p "${PWD}/data/wordpress"
	@mkdir -p "${PWD}/data/mariadb"


.PHONY: all build run down restart logs clean fclean create_dir
