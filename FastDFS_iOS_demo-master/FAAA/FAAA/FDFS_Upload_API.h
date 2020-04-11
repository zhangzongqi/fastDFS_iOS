//
//  FDFS_Upload_API.h
//  Fast_OC_Demo_1
//
//  Created by linxiang on 2017/10/16.
//  Copyright © 2017年 minxing. All rights reserved.
//

#ifndef FDFS_Upload_API_h
#define FDFS_Upload_API_h

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <string.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/stat.h>
#include "fdfs_client.h"
#include "logger.h"


#ifdef __cplusplus
extern "C" {
#endif
    int fdfs_upload_by_filename(const char *filename,char *file_id);
    
#ifdef __cplusplus
}
#endif


#endif /* FDFS_Upload_API_h */
