#!/usr/bin/env bash


COMPOSE="docker-compose"
PS_RESULT=$(docker-compose ps -q)


if [[ ! -z "$PS_RESULT" ]]; then
    EXEC="yes"
else
    EXEC="no"
fi


if [[ $# -gt 0 ]]; then
    if [[ -f .env ]]; then
        source .env
    fi


    if [[ "$1" == "start" ]]; then
        ${COMPOSE} up -d

    elif [[ "$1" == "stop" ]]; then
        ${COMPOSE} down

    elif [[ "$1" == "gateway-art" ]]; then
        shift 1

        if [[ "$EXEC" == "yes" ]]; then
            ${COMPOSE} exec gateway_php \
                php artisan "$@"
        else
            ${COMPOSE} run --rm -w /var/www/html gateway_php \
                php artisan "$@"
        fi

    elif [[ "$1" == "gateway-composer" ]]; then
        shift 1

        if [[ "$EXEC" == "yes" ]]; then
            ${COMPOSE} exec gateway_php \
                composer "$@"

        else
            ${COMPOSE} run --rm -w /var/www/html gateway_php \
                composer "$@"
        fi

    elif [[ "$1" == "users-art" ]]; then
        shift 1

        if [[ "$EXEC" == "yes" ]]; then
            ${COMPOSE} exec users_php \
                php artisan "$@"
        else
            ${COMPOSE} run --rm -w /var/www/html users_php \
                php artisan "$@"
        fi

    elif [[ "$1" == "users-composer" ]]; then
        shift 1

        if [[ "$EXEC" == "yes" ]]; then
            ${COMPOSE} exec users_php \
                composer "$@"

        else
            ${COMPOSE} run --rm -w /var/www/html users_php \
                composer "$@"
        fi


    elif [[ "$1" == "acl-art" ]]; then
        shift 1

        if [[ "$EXEC" == "yes" ]]; then
            ${COMPOSE} exec acl_php \
                php artisan "$@"
        else
            ${COMPOSE} run --rm -w /var/www/html acl_php \
                php artisan "$@"
        fi

    elif [[ "$1" == "acl-composer" ]]; then
        shift 1

        if [[ "$EXEC" == "yes" ]]; then
            ${COMPOSE} exec acl_php \
                composer "$@"

        else
            ${COMPOSE} run --rm -w /var/www/html acl_php \
                composer "$@"
        fi


    else
        ${COMPOSE} "$@"
    fi
else
    ${COMPOSE} ps
fi
