FROM python:3.8-buster
ARG WEB3_INFURA_PROJECT_ID
ARG ETHERSCAN_TOKEN

RUN pip3 install eth-brownie
RUN apt update && apt install -y npm
RUN npm install --global ganache-cli
RUN mkdir -p /app/dafidao-mainnet-fork
WORKDIR /app/dafidao-mainnet-fork

ADD init_brownie.py /app/dafidao-mainnet-fork/init_brownie.py
RUN brownie run init_brownie.py --network mainnet-fork

ADD supply_tokens.py /app/dafidao-mainnet-fork/supply_tokens.py
ADD entrypoint.sh /app/dafidao-mainnet-fork

ENTRYPOINT ["./entrypoint.sh"]
