FROM python:3.9.9-alpine

LABEL "com.github.actions.name"="GitHub Action for FAST-R"
LABEL "com.github.actions.description"="Run FAST-R on Python"
LABEL "com.github.actions.icon"="code"
LABEL "com.github.actions.color"="black"


RUN pip install --upgrade pip
# RUN pip install pytest pytest-cov numpy sklearn xxhash

COPY Pipfile /
RUN python -m pip install --upgrade pipenv wheel
RUN pipenv lock
RUN pipenv install --deploy --dev
RUN echo tree
RUN pipenv run fastr test test example_lines.txt example_bbox.txt

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
