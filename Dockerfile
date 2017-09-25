FROM forumi0721/arch-armhf-base

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r mysql && useradd -r -g mysql mysql

RUN pacman -Sy
RUN pacman -S --noconfirm percona-server gawk

RUN rm -rf /var/lib/mysql && mkdir -p /var/lib/mysql && chown -R mysql:mysql /var/lib/mysql
VOLUME /var/lib/mysql

RUN mkdir /home/mysql && chown mysql:mysql /home/mysql

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

USER mysql

EXPOSE 3306
CMD ["mysqld"]

