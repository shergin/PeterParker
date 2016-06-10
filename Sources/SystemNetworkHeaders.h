//
//  SystemNetworkHeaders.h
//  PeterParker
//
//  Created by Valentin Shergin on 5/16/16.
//  Copyright © 2016 The PeterParker Authors. All rights reserved.
//


#include <ifaddrs.h>

/* route.h */
#if TARGET_OS_IPHONE
#if TARGET_IPHONE_SIMULATOR
/* iOS Simulator */
#include <net/route.h>
#else
/* iOS Devices (local, bultin copy) */
#include "route.h"
#endif
#else
/* OS X and other */
#include <net/route.h>
#endif

#include <net/if_dl.h>

#include <sys/types.h>
#include <sys/socket.h>
#include <sys/sysctl.h>

#include <netinet/in.h>

#include <arpa/inet.h>

#include <netdb.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <err.h>
