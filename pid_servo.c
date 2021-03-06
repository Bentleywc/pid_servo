#include <stdlib.h>
#include <stdio.h>
#include <pthread.h>
#include <unistd.h>
#include "simulated_temp.h"
#include "read_temp.h"
#include "servo.h"
#include "control.h"

int main(int argc, char *argv[])
{
    pthread_t read_loop, servo_loop, simulate_loop, control_loop,
        command_loop;

    control_init();
    simulate_temp_init();
    servo_init();
    read_temp_init();

    pthread_create(&control_loop, NULL, control_thread, NULL);
    pthread_create(&command_loop, NULL, command_thread, NULL);
    pthread_create(&simulate_loop, NULL, simulate_temp_thread, NULL);
    pthread_create(&read_loop, NULL, read_temp_thread, NULL);
    pthread_create(&servo_loop, NULL, servo_thread, NULL);

    for (;;)
        usleep(1e6);

    return 0;
}
