Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3921A3B8930
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Jun 2021 21:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbhF3TgW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Jun 2021 15:36:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17408 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229700AbhF3TgV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Jun 2021 15:36:21 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15UJ4gXo145693
        for <linux-integrity@vger.kernel.org>; Wed, 30 Jun 2021 15:33:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=tzy77037ZlAGIXkqRF+GSNbJUEzOW9Kgtss26fOzVgM=;
 b=n8Kj4Wygt7LHIIMnHqdyXZeZytAMNOBaHsYZjZCao/9AlhOxGgA3OLSSkQwYNnkKf6JM
 KXW41JyCU03cEyYZMO36J22+EdED39VbxG8esJs0KF+3LW5MdP95XgvxoarrZNRbOrYL
 3T7ffJYK9BJwMWcAnmI2FG+fWatyR5YnDUOzDoIbkUsQaYQf+38Li/A032m5cyYw8YPN
 0WX25uTCDm2rI3PZ60ICm647+TE2e1kOjr+5prkgj12lYMT3Prmv5LbAk7EbMtPsCiY3
 VjWGrB7kuIFb8t3ztzfbTx0UnK4roepySz55608hvK2IWoAgtyjioL9+pWxce80AlLb4 6Q== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39gtd00tjg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 30 Jun 2021 15:33:52 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15UJXn7s030476
        for <linux-integrity@vger.kernel.org>; Wed, 30 Jun 2021 19:33:52 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma03dal.us.ibm.com with ESMTP id 39duve1d0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 30 Jun 2021 19:33:52 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15UJXBSm33685998
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jun 2021 19:33:11 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 326CEAC05F;
        Wed, 30 Jun 2021 19:33:11 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 25BDBAC060;
        Wed, 30 Jun 2021 19:33:11 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.47.158.155])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 30 Jun 2021 19:33:11 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils 3/3] libimaevm: Remove calculation of a digest over a symbolic link
Date:   Wed, 30 Jun 2021 15:33:03 -0400
Message-Id: <20210630193303.2531284-4-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210630193303.2531284-1-stefanb@linux.ibm.com>
References: <20210630193303.2531284-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 80H8oCRBukQRuepNRGIhPQe1-PUfmwfn
X-Proofpoint-GUID: 80H8oCRBukQRuepNRGIhPQe1-PUfmwfn
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-30_11:2021-06-30,2021-06-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 mlxscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106300106
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Signature verification on symbolic links is not supported by IMA in the
kernel, so remove the calculation of digests over symbolic links.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 src/libimaevm.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index 07a25c9..6591d20 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -177,20 +177,6 @@ out:
 	return err;
 }
 
-static int add_link_hash(const char *path, EVP_MD_CTX *ctx)
-{
-	int len;
-	char buf[1024];
-
-	len = readlink(path, buf, sizeof(buf));
-	/* 0-length links are also an error */
-	if (len <= 0)
-		return -1;
-
-	log_info("link: %s -> %.*s\n", path, len, buf);
-	return !EVP_DigestUpdate(ctx, buf, len);
-}
-
 int ima_calc_hash(const char *file, uint8_t *hash)
 {
 	const EVP_MD *md;
@@ -231,9 +217,6 @@ int ima_calc_hash(const char *file, uint8_t *hash)
 	case S_IFREG:
 		err = add_file_hash(file, pctx);
 		break;
-	case S_IFLNK:
-		err = add_link_hash(file, pctx);
-		break;
 	default:
 		log_err("Unsupported file type (0x%x)", st.st_mode & S_IFMT);
 		err = -1;
-- 
2.31.1

