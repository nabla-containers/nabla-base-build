#include<stdio.h>
#include<sys/socket.h>
#include<arpa/inet.h>	//inet_addr

#define BUFFER_SIZE 1024

int main(int argc , char *argv[])
{
	int sockfd;
	struct sockaddr_in server;
	char buffer[BUFFER_SIZE];
	int ret;
	
	//Create socket
	sockfd = socket(AF_INET , SOCK_STREAM , 0);
	if (sockfd == -1)
	{
		printf("Could not create socket");
	}
		
	if (argc != 2) {
		puts("USAGE: ./tcp <SERVER_IP>");
		return 1;
	}

	server.sin_addr.s_addr = inet_addr(argv[1]);
	server.sin_family = AF_INET;
	server.sin_port = htons( 5000 );

	//Connect to remote server
	if (connect(sockfd , (struct sockaddr *)&server , sizeof(server)) < 0)
	{
		puts("connect error");
		return 1;
	}

	write(sockfd, "GET /\r\n", strlen("GET /\r\n")); // write(fd, char[]*, len);  
	write(sockfd, "Accept: */*\r\n", strlen("Accept: */*\r\n")); // write(fd, char[]*, len);  
	write(sockfd, "\r\n", strlen("\r\n")); // write(fd, char[]*, len);
	
	while(read(sockfd, buffer, BUFFER_SIZE - 1) != 0){
		printf("%s", buffer);
		bzero(buffer, BUFFER_SIZE);
	}
	close(sockfd);
	return 0;
}
