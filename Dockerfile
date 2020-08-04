FROM lsiobase/alpine:3.11
ARG Title
ARG Language
ARG BeginTime
ARG EndTime
ARG Duration
ARG Port
ARG FlagPrefix
ARG FlagSuffix
ARG CheckDownScore
ARG AttackScore
WORKDIR /Cardinal
ENV TZ="Asia/Shanghai"
ENV PUID=19999
ENV PGID=19999
COPY ./Cardinal /Cardinal
RUN chmod +x /Cardinal/Cardinal && \
    mkdir /Cardinal/conf && \
    echo -e "[base] #基础配置\n\
        Title=\"${Title}\"\n\
        SystemLanguage=\"${Language}\"\n\
        BeginTime=\"${BeginTime}\"\n\
        RestTime=[\n\
        # [\"2020-02-16T17:00:00+08:00\",\"2020-02-16T18:00:00+08:00\"],\n\
        ]\n\
        EndTime=\"${EndTime}\"\n\
        Duration=${Duration}\n\
        SeparateFrontend=false\n\
        Salt=\"$(cat /proc/sys/kernel/random/uuid)\"\n\
        Port=\":${Port}\"\n\
        FlagPrefix=\"${FlagPrefix}\"\n\
        FlagSuffix=\"${FlagSuffix}\"\n\
        CheckDownScore=${CheckDownScore}\n\
        AttackScore=${AttackScore}\n\
        \n\
        [mysql]\n\
        DBHost=\"db\"\n\
        DBUsername=\"root\"\n\
        DBPassword=\"Cardinal\"\n\
        DBName=\"Cardinal\"\
    " > /Cardinal/conf/Cardinal.toml
EXPOSE 19999
CMD ["/Cardinal/Cardinal"]