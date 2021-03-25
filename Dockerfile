FROM python:slim

WORKDIR /usr/src/app

# change mirrors
RUN sed -i "s/deb.debian.org/mirrors.aliyun.com/g" /etc/apt/sources.list  \
 && sed -i "s/security.debain.org/mirrors.aliyun.com/g" /etc/apt/sources.list \
 && rm -Rf /etc/apt/sources.list.d/* \
 && rm -Rf /var/lib/apt/lists/* \
 && pip3 install -i https://pypi.tuna.tsinghua.edu.cn/simple pip -U \
 && python3 -m pip config set \
    global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

RUN apt update && apt install -y ffmpeg \
 && rm -rf /var/lib/apt/lists/*

COPY ./src/requirements.prod .

RUN pip install --no-cache-dir -i https://pypi.tuna.tsinghua.edu.cn/simple -r ./requirements.prod
