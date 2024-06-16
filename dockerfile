FROM ubuntu:latest
RUN apt-get update && apt-get install -y sudo 
RUN mkdir -p /setup 
COPY setup.sh /setup/setup.sh
COPY domain.sh /setup/domain.sh
COPY deRegister.sh /setup/deRegister.sh
COPY set_quiz.sh /setup/set_quiz.sh
COPY allocate_mentees.sh /setup/allocate_mentees.sh
COPY quiz_notification.sh /setup/quiz_notification.sh
COPY display_status.sh /setup/display_status.sh

RUN chmod +x /setup/setup.sh /setup/domain.sh /setup/deRegister.sh /setup/set_quiz.sh /setup/allocate_mentees.sh /setup/quiz_notification.sh /setup/display_status.sh

RUN /setup/setup.sh
RUN /setup/domain.sh
RUN /setup/deRegister.sh
RUN /setup/set_quiz.sh
RUN /setup/allocate_mentees.sh
RUN /setup/quiz_notification.sh
RUN /setup/display_status.sh

ENTRYPOINT ["/bin/bash"]
