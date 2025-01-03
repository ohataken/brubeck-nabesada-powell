FROM ruby:3.4.1

WORKDIR /app

COPY . .

RUN gem install bundler:2.6.2 && \
    bundle install

# Set runtime interface client as default command for the container runtime
ENTRYPOINT [ "aws_lambda_ric" ]

# Set the CMD to your handler (could also be done as a parameter override outside of the Dockerfile)
CMD [ "lambda_function.LambdaFunction::Handler.process" ]
