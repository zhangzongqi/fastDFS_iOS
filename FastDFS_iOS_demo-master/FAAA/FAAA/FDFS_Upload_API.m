//
//  FDFS_Upload_API.c
//  Fast_OC_Demo_1
//
//  Created by linxiang on 2017/10/16.
//  Copyright © 2017年 minxing. All rights reserved.
//

#include "FDFS_Upload_API.h"
#import <Foundation/Foundation.h>


int fdfs_upload_by_filename(const char *filename, char *file_id)
{
    const char *local_filename;
    char group_name[FDFS_GROUP_NAME_MAX_LEN + 1];
    ConnectionInfo *pTrackerServer;
    int result;
    int store_path_index;
    ConnectionInfo storageServer;


    log_init();
    g_log_context.log_level = LOG_ERR;
//    ignore_signal_pipe();   //linux

    //加载配置文件
    
    char *buffer;
    if((buffer = getcwd(NULL,0))==NULL){
        perror("getcwd error");
    }
    else{
        printf("%s\n",buffer);
        free(buffer);
    }

    NSString *path = [[NSBundle mainBundle] pathForResource:@"client" ofType:@"conf"];
    
    if ( (result=fdfs_client_init([path UTF8String])) != 0 )
    {
        return result;
    }
    
    //获取tracker句柄
    pTrackerServer = tracker_get_connection();
    if (pTrackerServer == NULL)
    {
        fdfs_client_destroy();
        return errno != 0 ? errno : ECONNREFUSED;
    }
    
    local_filename = filename;
    *group_name = '\0';
    
    //获取storage句柄
    if ((result=tracker_query_storage_store(pTrackerServer, \
                                            &storageServer, group_name, &store_path_index)) != 0)
    {
        fdfs_client_destroy();
        fprintf(stderr, "tracker_query_storage fail, " \
                "error no: %d, error info: %s\n", \
                result, STRERROR(result));
        return result;
    }
    
    //上传文件,得到file_id
    result = storage_upload_by_filename1(pTrackerServer, \
                                         &storageServer, store_path_index, \
                                         local_filename, NULL, \
                                         NULL, 0, group_name, file_id);
    if (result == 0)
    {
        printf("%s\n", file_id);
    }
    else
    {
        fprintf(stderr, "upload file fail, " \
                "error no: %d, error info: %s\n", \
                result, STRERROR(result));
    }
    
    tracker_disconnect_server_ex(pTrackerServer, true);
    fdfs_client_destroy();

    return result;
}


