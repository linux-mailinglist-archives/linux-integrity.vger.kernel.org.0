Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D76B53B892D
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Jun 2021 21:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233710AbhF3Tfm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Jun 2021 15:35:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10134 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233736AbhF3Tfm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Jun 2021 15:35:42 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15UJ7JA4088844
        for <linux-integrity@vger.kernel.org>; Wed, 30 Jun 2021 15:33:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=wL2YBPmhWFwT8ih7bGaUaLwKyQyRBtvtcpn+S62YIl8=;
 b=YMfuL7ll8L7ILtShRQ1VbLIoMcakZIMNJkQlDs1ZOu/vWd88zPruef3f8w+oNGuGfMje
 BIbpzU/BFiv9fAxp+45u7eL91bbl0kc0AxKR52lV0CyITyFfxrZIEjGMMdHjX/VtHQVI
 pcLSOKcL3ywKYCHGyYzyTFc+tzf2GtMw8ykp+NTJ5vF99TgwIbHvSi2rc9g4n4KzIOgo
 ZfsywAs9yArIY2H7l4NC3JS2iFQGtACvktLImOvXy1q6lQPfsgvh7cOHswzk/g6sP3Lr
 jNRSRHQbC1A9qf5hdqN+xVEyBl+7oAdofITIqMUi/Zy/uhAaZJuoxV9KyN4MxHV/eYb9 ew== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39gtqmr0ks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 30 Jun 2021 15:33:12 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15UJVfS7029224
        for <linux-integrity@vger.kernel.org>; Wed, 30 Jun 2021 19:33:11 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma02wdc.us.ibm.com with ESMTP id 39duvd9e58-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 30 Jun 2021 19:33:11 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15UJXBvf35914166
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jun 2021 19:33:11 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B0C6AC068;
        Wed, 30 Jun 2021 19:33:11 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 16127AC067;
        Wed, 30 Jun 2021 19:33:11 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.47.158.155])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 30 Jun 2021 19:33:11 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils 2/3] libimaevm: Remove calculation of a digest over a directory
Date:   Wed, 30 Jun 2021 15:33:02 -0400
Message-Id: <20210630193303.2531284-3-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210630193303.2531284-1-stefanb@linux.ibm.com>
References: <20210630193303.2531284-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yJL0FkO7l0UJI4lom18JtNoKWF5UHIOl
X-Proofpoint-ORIG-GUID: yJL0FkO7l0UJI4lom18JtNoKWF5UHIOl
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-30_11:2021-06-30,2021-06-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 spamscore=0 suspectscore=0
 phishscore=0 malwarescore=0 clxscore=1015 mlxscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106300106
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Signature verification on directories is not supported by IMA in the
kernel, so remove the calculation of digests over directories.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 src/libimaevm.c | 37 -------------------------------------
 1 file changed, 37 deletions(-)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index 4d51901..07a25c9 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -177,40 +177,6 @@ out:
 	return err;
 }
 
-static int add_dir_hash(const char *file, EVP_MD_CTX *ctx)
-{
-	struct dirent *de;
-	DIR *dir;
-	unsigned long long ino;
-	unsigned int type;
-	int result = 0;
-
-	dir = opendir(file);
-	if (!dir) {
-		log_err("Failed to open: %s\n", file);
-		return -1;
-	}
-
-	while ((de = readdir(dir))) {
-		ino = de->d_ino;
-		type = de->d_type;
-		log_debug("entry: %s, ino: %llu, type: %u, reclen: %hu\n",
-			  de->d_name, ino, type, de->d_reclen);
-		if (EVP_DigestUpdate(ctx, de->d_name, strlen(de->d_name)) != 1 ||
-		    EVP_DigestUpdate(ctx, &ino, sizeof(ino)) != 1||
-		    EVP_DigestUpdate(ctx, &type, sizeof(type)) != 1) {
-			log_err("EVP_DigestUpdate() failed\n");
-			output_openssl_errors();
-			result = 1;
-			break;
-		}
-	}
-
-	closedir(dir);
-
-	return result;
-}
-
 static int add_link_hash(const char *path, EVP_MD_CTX *ctx)
 {
 	int len;
@@ -265,9 +231,6 @@ int ima_calc_hash(const char *file, uint8_t *hash)
 	case S_IFREG:
 		err = add_file_hash(file, pctx);
 		break;
-	case S_IFDIR:
-		err = add_dir_hash(file, pctx);
-		break;
 	case S_IFLNK:
 		err = add_link_hash(file, pctx);
 		break;
-- 
2.31.1

