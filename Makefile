# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: Théo <theoclaereboudt@gmail.com>           +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/06/22 16:51:57 by tclaereb          #+#    #+#              #
#    Updated: 2025/06/25 21:55:09 by Théo             ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

COMPOSE	:= docker-compose -f ./srcs/compose.yml

all: build run

build: create_dir
	$(COMPOSE) build $(DOCK)

run: create_dir
	$(COMPOSE) up -d $(DOCK)

stop:
	$(COMPOSE) down $(DOCK)

restart: stop all

logs:
	$(COMPOSE) logs -f $(DOCK)

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
	@mkdir -p "${PWD}/data/adminer"
	@mkdir -p "${PWD}/data/portainer"


enter:
	@if [ -n $(DOCK) ]; then \
		$(COMPOSE) exec -it $(DOCK) bash; \
	fi

privileged:
	@docker run --rm -it --privileged -v /home/inhhert:/host ubuntu bash

.PHONY: all build run stop restart logs clean fclean re create_dir enter privileged
