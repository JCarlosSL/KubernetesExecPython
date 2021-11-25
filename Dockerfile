FROM python:3.8.5-alpine

RUN pip install --upgrade pip

RUN adduser -D backend
USER backend
WORKDIR /home/backend

COPY --chown=backend:backend ./backendExecPython/requirements.txt .

RUN pip --no-cache-dir install --user -r requirements.txt

ENV PATH="/home/backend/.local/bin:${PATH}"

COPY --chown=backend:backend ./backendExecPython /app

WORKDIR /app

COPY ./entrypoint.sh /

ENTRYPOINT ["sh", "/entrypoint.sh"]

