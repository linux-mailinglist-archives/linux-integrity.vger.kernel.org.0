Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 071FB2163FC
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Jul 2020 04:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgGGC0w (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Jul 2020 22:26:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28404 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727936AbgGGC0v (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Jul 2020 22:26:51 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06726UPw142085;
        Mon, 6 Jul 2020 22:26:47 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3248nrhwvt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jul 2020 22:26:47 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0672ACLH150396;
        Mon, 6 Jul 2020 22:26:47 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3248nrhwv9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jul 2020 22:26:47 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0672Lw2U007563;
        Tue, 7 Jul 2020 02:26:45 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06fra.de.ibm.com with ESMTP id 322h1g9dux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Jul 2020 02:26:45 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0672Qg5e64159960
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Jul 2020 02:26:43 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D76894C04A;
        Tue,  7 Jul 2020 02:26:42 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 315FD4C046;
        Tue,  7 Jul 2020 02:26:42 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.174.194])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  7 Jul 2020 02:26:42 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Bruno Meneguele <bmeneg@redhat.com>,
        Vitaly Chikunov <vt@altlinux.org>
Subject: [PATCH 6/6] ima-evm-utils: define a basic hash_info.h file
Date:   Mon,  6 Jul 2020 22:26:31 -0400
Message-Id: <1594088791-27370-7-git-send-email-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1594088791-27370-1-git-send-email-zohar@linux.ibm.com>
References: <1594088791-27370-1-git-send-email-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-07_01:2020-07-06,2020-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=892 spamscore=0 phishscore=0 suspectscore=1
 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 cotscore=-2147483648 mlxscore=0 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007070010
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Some older system kernel header packages don't necessarily include
hash_info.h.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/Makefile.am   |  2 +-
 src/hash_info.gen | 43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/src/Makefile.am b/src/Makefile.am
index 36652427a8ec..9bbff5034ef4 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -34,5 +34,5 @@ endif
 
 AM_CPPFLAGS = -I$(top_srcdir) -include config.h
 
-CLEANFILES = hash_info.h
+CLEANFILES = hash_info.h tmp_hash_info.h
 DISTCLEANFILES = @DISTCLEANFILES@
diff --git a/src/hash_info.gen b/src/hash_info.gen
index 54532ca5b847..5f7a97fb3117 100755
--- a/src/hash_info.gen
+++ b/src/hash_info.gen
@@ -18,11 +18,54 @@ KERNEL_HEADERS=$1
 HASH_INFO_H=uapi/linux/hash_info.h
 HASH_INFO=$KERNEL_HEADERS/include/$HASH_INFO_H
 
+TMPHASHINFO="./tmp_hash_info.h"
+gen_hashinfo() {
+cat << __EOF__ >$TMPHASHINFO
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+/*
+ * Hash Info: Hash algorithms information
+ *
+ * Copyright (c) 2013 Dmitry Kasatkin <d.kasatkin@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ *
+ */
+
+enum hash_algo {
+	HASH_ALGO_MD4,
+	HASH_ALGO_MD5,
+	HASH_ALGO_SHA1,
+	HASH_ALGO_RIPE_MD_160,
+	HASH_ALGO_SHA256,
+	HASH_ALGO_SHA384,
+	HASH_ALGO_SHA512,
+	HASH_ALGO_SHA224,
+	HASH_ALGO_RIPE_MD_128,
+	HASH_ALGO_RIPE_MD_256,
+	HASH_ALGO_RIPE_MD_320,
+	HASH_ALGO_WP_256,
+	HASH_ALGO_WP_384,
+	HASH_ALGO_WP_512,
+	HASH_ALGO_TGR_128,
+	HASH_ALGO_TGR_160,
+	HASH_ALGO_TGR_192,
+	HASH_ALGO_SM3_256,
+	HASH_ALGO__LAST
+};
+__EOF__
+}
+
 # Allow to specify kernel-headers past include/
 if [ ! -e $HASH_INFO ]; then
   HASH_INFO2=$KERNEL_HEADERS/$HASH_INFO_H
   if [ -e $HASH_INFO2 ]; then
     HASH_INFO=$HASH_INFO2
+  else
+    gen_hashinfo
+    HASH_INFO="$TMPHASHINFO"
   fi
 fi
 
-- 
2.7.5

