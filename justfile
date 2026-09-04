# --- CONFIG -------------------------------------------------

media_file := "docker/media-server/docker-compose.yml"
infra_file := "docker/management/docker-compose.yml"


# --- MEDIA --------------------------------------------------

up-media:
  docker compose -f {{media_file}} up -d

down-media:
  docker compose -f {{media_file}} down

logs-media:
  docker compose -f {{media_file}} logs -f

restart-media:
  docker compose -f {{media_file}} restart


# --- INFRA --------------------------------------------------

up-infra:
  docker compose -f {{infra_file}} up -d

down-infra:
  docker compose -f {{infra_file}} down

logs-infra:
  docker compose -f {{infra_file}} logs -f

restart-infra:
  docker compose -f {{infra_file}} restart


# --- FULL SYSTEM --------------------------------------------

up:
  just up-infra
  just up-media

down:
  just down-media
  just down-infra

restart:
  just down
  just up


# --- STATUS -------------------------------------------------

ps:
  docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"


# --- UPDATES -----------------------------------------------

pull:
  docker compose -f {{media_file}} pull
  docker compose -f {{infra_file}} pull

update:
  just pull
  just restart


# --- CLEAN STATE -------------------------------------------

prune:
  docker system prune -af

# safer alternative if you ever need it:
# docker system prune -f