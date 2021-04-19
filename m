Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8A8036469D
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Apr 2021 17:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240660AbhDSPCa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Apr 2021 11:02:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56640 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239586AbhDSPC3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Apr 2021 11:02:29 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13JEY350063432
        for <linux-integrity@vger.kernel.org>; Mon, 19 Apr 2021 11:02:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=VUOGGhhTvxxg5pW0BbgZgrUZRYXuFgYJYDI+OeysVIA=;
 b=s50mzSQU/v+LiwdCKaOqk6Dq13v2dTWwrKSmxYJO5PYcpg5Q7digA01GWUL9BqrsJkRk
 U8+OkzRaKhE59kyLDQaXJMMrLIFzbUpzo9v/gOFNpG9RGaAPQCs6XRZMimtMGU4mOX6P
 ErlpLxQ48VBwe5gr3EfvAL+AgyZsFEY07cRkT1waTMcnlG/DURHGOlsx2ebxoLIpfe4g
 ypotq/KJB5L/12lGHP0GznCsj9Quu2orDuk3U09DjSJfxhJpzU92mj7hBfypt5bOqFUE
 OPTIir2617uQyhNDRQyi049wkG8JPYCorpoFxZLasgF57akL92VrIYbaefaiEfbuZJJu wg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 380d6uv8fb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 19 Apr 2021 11:01:59 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13JEZK7P068416
        for <linux-integrity@vger.kernel.org>; Mon, 19 Apr 2021 11:01:59 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 380d6uv8et-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Apr 2021 11:01:59 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13JErcIW021478;
        Mon, 19 Apr 2021 15:01:57 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma01dal.us.ibm.com with ESMTP id 37yqa9qe4v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Apr 2021 15:01:57 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13JF1uxH17170798
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Apr 2021 15:01:56 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 14E96136063;
        Mon, 19 Apr 2021 15:01:56 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE57D13604F;
        Mon, 19 Apr 2021 15:01:55 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.47.158.155])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 19 Apr 2021 15:01:55 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 1/6] libimaevm: Properly check for error returned by EVP_DigestUpdate
Date:   Mon, 19 Apr 2021 11:01:46 -0400
Message-Id: <20210419150151.236409-2-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210419150151.236409-1-stefanb@linux.ibm.com>
References: <20210419150151.236409-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 54AwuZEWPbZtyxJGUvrFDxab3qevbUTJ
X-Proofpoint-ORIG-GUID: 5VWCVD7XwZOZhHEz5435zFNmsck4Wfjs
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-19_10:2021-04-19,2021-04-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 phishscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104190100
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The error checking in add_dir_hash was wrong. EVP_DigestUpdate returns 1
on success and 0 on error, so we cannot just accumulate it using or'ing.

From the man page:
       EVP_DigestInit_ex(), EVP_DigestUpdate(), EVP_DigestFinal_ex()
           Returns 1 for success and 0 for failure.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 src/libimaevm.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index fa6c278..d8fc0d4 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -179,7 +179,6 @@ out:
 
 static int add_dir_hash(const char *file, EVP_MD_CTX *ctx)
 {
-	int err;
 	struct dirent *de;
 	DIR *dir;
 	unsigned long long ino, off;
@@ -198,11 +197,10 @@ static int add_dir_hash(const char *file, EVP_MD_CTX *ctx)
 		type = de->d_type;
 		log_debug("entry: %s, ino: %llu, type: %u, off: %llu, reclen: %hu\n",
 			  de->d_name, ino, type, off, de->d_reclen);
-		err = EVP_DigestUpdate(ctx, de->d_name, strlen(de->d_name));
-		/*err |= EVP_DigestUpdate(ctx, &off, sizeof(off));*/
-		err |= EVP_DigestUpdate(ctx, &ino, sizeof(ino));
-		err |= EVP_DigestUpdate(ctx, &type, sizeof(type));
-		if (!err) {
+		if (EVP_DigestUpdate(ctx, de->d_name, strlen(de->d_name)) != 1 ||
+		    /* EVP_DigestUpdate(ctx, &off, sizeof(off)) != 1 || */
+		    EVP_DigestUpdate(ctx, &ino, sizeof(ino)) != 1||
+		    EVP_DigestUpdate(ctx, &type, sizeof(type)) != 1) {
 			log_err("EVP_DigestUpdate() failed\n");
 			output_openssl_errors();
 			result = 1;
-- 
2.30.2

