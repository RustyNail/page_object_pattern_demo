FROM ruby:2.4-slim
RUN apt-get update -qq && apt-get install -y curl unzip build-essential libnss3-tools
RUN curl https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' && \
    apt-get update && apt-get -y install google-chrome-stable
RUN curl -o /tmp/chromedriver_linux64.zip https://chromedriver.storage.googleapis.com/$(curl -fsSL https://chromedriver.storage.googleapis.com/LATEST_RELEASE)/chromedriver_linux64.zip && unzip /tmp/chromedriver_linux64.zip -d /usr/local/bin
RUN mkdir /usr/share/fonts/noto
RUN curl -o /tmp/NotoSansCJKjp-hinted.zip https://noto-website-2.storage.googleapis.com/pkgs/NotoSansCJKjp-hinted.zip && unzip /tmp/NotoSansCJKjp-hinted.zip -d /usr/share/fonts/noto/
RUN mkdir /usr/src/app
WORKDIR /usr/src/app
ADD Gemfile ./Gemfile
ADD Gemfile.lock ./Gemfile.lock
RUN gem install bundler && bundle ins
RUN ln -sf  /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
CMD bundle ex rspec
