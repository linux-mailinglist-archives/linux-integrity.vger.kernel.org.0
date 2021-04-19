Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A795236469C
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Apr 2021 17:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239911AbhDSPC3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Apr 2021 11:02:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31978 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239230AbhDSPC3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Apr 2021 11:02:29 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13JEXZmY163643
        for <linux-integrity@vger.kernel.org>; Mon, 19 Apr 2021 11:01:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=2VLJSDyPAGX/jbPSN1FNZhhmYmigpmOhT9Djs6/uCQc=;
 b=W+6mPWX0+EUjFB5Cp0tmgDYfmZdYKvauK4m+hNYTp8Ga2Id56gBVaWNn/hNkEwVbp7er
 ODXNUJBEdm/oA68XNm13AlHfY+J1O0JgzYq288DvuOj5GK1N377FoNsifo53suu+Ibqa
 rfx/vder6sMPMYaTqwjZTAL64soYp3FtOYPt88MTMy/8oKyTr9G+ALyA5IF1L54+wDEr
 Y57EjZyZzCUOFJ8ZLZTPNLE/lx0w0/T2VFw3AEfeFEMgwlInl26m61mAH0g0x9vWoaub
 3MU6H+gkEBH6YiNnnqBCLZghCKjk7L0pyA9y4lsv6aFgmCOipKF2F5K17nk/KqZ09QBO Tw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 380cmkmhuu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 19 Apr 2021 11:01:59 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13JEXaVX163743
        for <linux-integrity@vger.kernel.org>; Mon, 19 Apr 2021 11:01:59 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 380cmkmhuc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Apr 2021 11:01:59 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13JEqhD8013458;
        Mon, 19 Apr 2021 15:01:58 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma02dal.us.ibm.com with ESMTP id 37yqa9ycwh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Apr 2021 15:01:58 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13JF1ubs20447736
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Apr 2021 15:01:56 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9FD12136063;
        Mon, 19 Apr 2021 15:01:56 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C0D713605D;
        Mon, 19 Apr 2021 15:01:56 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.47.158.155])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 19 Apr 2021 15:01:56 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 2/6] libimaevm: Remove unused off variable
Date:   Mon, 19 Apr 2021 11:01:47 -0400
Message-Id: <20210419150151.236409-3-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210419150151.236409-1-stefanb@linux.ibm.com>
References: <20210419150151.236409-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VN5AXCrJj51LDKSzjwx5Ck-41EicSp2s
X-Proofpoint-ORIG-GUID: v_BVtKr1JaO3_F7oNFUrfbmpAFj9ZeV1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-19_10:2021-04-19,2021-04-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 mlxscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104190100
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The 'off' variable was unused in add_dir_hash(), so remove it.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 src/libimaevm.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index d8fc0d4..0137884 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -181,7 +181,7 @@ static int add_dir_hash(const char *file, EVP_MD_CTX *ctx)
 {
 	struct dirent *de;
 	DIR *dir;
-	unsigned long long ino, off;
+	unsigned long long ino;
 	unsigned int type;
 	int result = 0;
 
@@ -193,12 +193,10 @@ static int add_dir_hash(const char *file, EVP_MD_CTX *ctx)
 
 	while ((de = readdir(dir))) {
 		ino = de->d_ino;
-		off = de->d_off;
 		type = de->d_type;
-		log_debug("entry: %s, ino: %llu, type: %u, off: %llu, reclen: %hu\n",
-			  de->d_name, ino, type, off, de->d_reclen);
+		log_debug("entry: %s, ino: %llu, type: %u, reclen: %hu\n",
+			  de->d_name, ino, type, de->d_reclen);
 		if (EVP_DigestUpdate(ctx, de->d_name, strlen(de->d_name)) != 1 ||
-		    /* EVP_DigestUpdate(ctx, &off, sizeof(off)) != 1 || */
 		    EVP_DigestUpdate(ctx, &ino, sizeof(ino)) != 1||
 		    EVP_DigestUpdate(ctx, &type, sizeof(type)) != 1) {
 			log_err("EVP_DigestUpdate() failed\n");
-- 
2.30.2

