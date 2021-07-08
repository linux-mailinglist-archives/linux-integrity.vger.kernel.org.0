Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24EEA3C16D0
	for <lists+linux-integrity@lfdr.de>; Thu,  8 Jul 2021 18:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhGHQG7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 8 Jul 2021 12:06:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:14398 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229992AbhGHQG6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Jul 2021 12:06:58 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 168G3kmg075106
        for <linux-integrity@vger.kernel.org>; Thu, 8 Jul 2021 12:04:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=AF+afRAj6xC18HRymqmCo8vWiya647NOdPLgPKzOQi8=;
 b=Xg3sc+OGJ1L7uDX/F7r2F+mPs1Izk1uNxaMWgtq3HHsa/SsSKEhHPgp41J9O1Wv/j70x
 B2tq4vZOT2Eo9pbMFeY4EpSHxv2EM28daAwx27XI1jkPflqr8GqEq7XyZK1DTd8aMVWR
 AOHZcy8RP+sUV9dd3ATySZ9YnF5Jwkn3xnjitmpvx2XGU9ubaRe3FQAmxlCCy0OvgFd7
 jYyqjNA9Hu1KBCw3XmqnZXjtMnLDjqYG62q0J3n2Cqk19gQQeMb9dqb8L0TyVzrFKVDT
 MRXH1rVQy4IWJqYl+h3p8urWqXcTslre8Rn3znzHAekrXgIaa53kVghesXibQCuch37y 7g== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39nhcb8eef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 08 Jul 2021 12:04:16 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 168Fx5Gl027109
        for <linux-integrity@vger.kernel.org>; Thu, 8 Jul 2021 16:04:10 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma05wdc.us.ibm.com with ESMTP id 39jfhd7c8k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 08 Jul 2021 16:04:10 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 168G4AJn37486870
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Jul 2021 16:04:10 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 44E03124074;
        Thu,  8 Jul 2021 16:04:10 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 40E33124072;
        Thu,  8 Jul 2021 16:04:10 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.47.158.155])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  8 Jul 2021 16:04:10 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils v2 3/4] libimaevm: Remove calculation of a digest over a directory
Date:   Thu,  8 Jul 2021 12:04:07 -0400
Message-Id: <20210708160408.2779849-4-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210708160408.2779849-1-stefanb@linux.ibm.com>
References: <20210708160408.2779849-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KJzlNzE1pIXlvtKv2twV-SOPGEqLt2QC
X-Proofpoint-GUID: KJzlNzE1pIXlvtKv2twV-SOPGEqLt2QC
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-08_10:2021-07-08,2021-07-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107080083
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Signature verification on directories is not supported by IMA in the
kernel, so remove the calculation of digests over directories.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
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

