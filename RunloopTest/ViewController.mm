//
//  ViewController.m
//  RunloopTest
//
//  Created by Robin on 14/12/2017.
//  Copyright © 2017 Robin. All rights reserved.
//

#import "ViewController.h"
#import <pthread.h>

@interface ViewController () {
    
}

@end

pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t cond = PTHREAD_COND_INITIALIZER;
int i;

@implementation ViewController

void * thread1(void *) {
    for (i = 1; i <= 6; i++) {
        pthread_mutex_lock(&mutex);
        NSLog(@"thread 1 lock");
        if (0 == i%3) {
            NSLog(@"thread 1 sigal 1");
            pthread_cond_signal(&cond);
            NSLog(@"thread 1 sigal 2");
        }
        
        pthread_mutex_unlock(&mutex);
        NSLog(@"thread 1 unlock");
        sleep(1);
    }
    
    return (void *)pthread_self();
}

void * thread2(void *) {
    
    while (i < 6) {
        pthread_mutex_lock(&mutex);
        NSLog(@"thread 2 lock");
        if (0 != i%3) {
            NSLog(@"thread 2 wait 1");
            pthread_cond_wait(&cond, &mutex);
            NSLog(@"thread 2 wait 2");
        }
        
        pthread_mutex_unlock(&mutex);
        NSLog(@"thread 2 unlock");
        sleep(1);
    }
    
    return (void *)pthread_self();
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    pthread_t pthread[2];
    pthread_create(&pthread[0], NULL, thread1, NULL);
    pthread_create(&pthread[1], NULL, thread2, NULL);
    
    void * retPthread[2];
    int ret = pthread_join(pthread[0], &retPthread[0]);
    if (0 == ret) {
        NSLog(@"pthread[0]=%lu,retPthread[0]=%lu",(unsigned long)pthread[0],(unsigned long)&retPthread[0]);
    }
    
    ret = pthread_join(pthread[1], &retPthread[1]);
    if (0 == ret) {
        NSLog(@"pthread[1]=%lu,retPthread[1]=%lu",(unsigned long)pthread[1],(unsigned long)&retPthread[1]);
    }
    pthread_mutex_destroy(&mutex);
    pthread_cond_destroy(&cond);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
