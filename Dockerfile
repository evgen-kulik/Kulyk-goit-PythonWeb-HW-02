# FROM вказує на базовий образ контейнера, якщо не вказати ":3.10", то буде всиановлено останню версію (latest)
FROM python:3.10

# Встановлюємо змінну середовища
ENV APP_HOME /app

# Встановимо робочу директорію всередині контейнера
WORKDIR $APP_HOME

# Скопіюємо файли з поточної директорії "." в робочу директорію контейнера "/work_dir"
COPY pyproject.toml $APP_HOME/pyproject.toml

# Встановимо залежності в середині контейнера
RUN pip install poetry
RUN poetry config virtualenvs.create false && poetry install --only main

# Скопіюємо інші файли до директорії контейнера
COPY . .

# Встановимо застосунок всередині контейнера
RUN python setup.py install

# Позначимо порт, де працює програма
EXPOSE 5000

# Запустимо програму всередині контейнера
CMD ["python", "cont_runner.py"]