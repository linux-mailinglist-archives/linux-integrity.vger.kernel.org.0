Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8118A3C16CC
	for <lists+linux-integrity@lfdr.de>; Thu,  8 Jul 2021 18:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhGHQGz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 8 Jul 2021 12:06:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5629 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229592AbhGHQGz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Jul 2021 12:06:55 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 168G2xoq009769
        for <linux-integrity@vger.kernel.org>; Thu, 8 Jul 2021 12:04:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=NiI+e9gdznPLyTzi0q05yYGC1NGFxJfy3OMiAwXiNU8=;
 b=WIf/iNItxLV+FGVTDhUD907pdYxQo18syfm5nSrfNLgyKJFuI6/I0ICCDTwLUJc93hjl
 CJh05vGfw3W4hyIm686ROwXjy1qbmA+XiWER/DphXZ7PNd9ERUAbi6jD/cv/oIpXDz44
 l9xnAKPoMxWA5sbexC4+2O2cN4/BiRpzgII/fAsC6CgjbbKir75NfM8xqTrEmxh+emnQ
 J0oD63wVi8Wn+uD/9iYTZNJdqVlDtqopJrQ6Vr3YslMmKZ+zTCyz5NGC+nqL//KyWbze
 we2UxJKBYAjiFsuxZuuLNBFtyfShGQZhGibPvlcvB4YE6a5nxbqwrtSwQJqEj2dzGwH4 Iw== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39p2yf3ecs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 08 Jul 2021 12:04:12 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 168Fx6ah027125
        for <linux-integrity@vger.kernel.org>; Thu, 8 Jul 2021 16:04:10 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma05wdc.us.ibm.com with ESMTP id 39jfhd7c8h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 08 Jul 2021 16:04:10 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 168G4ASm37945838
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Jul 2021 16:04:10 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 326A212406E;
        Thu,  8 Jul 2021 16:04:10 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2548512406C;
        Thu,  8 Jul 2021 16:04:10 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.47.158.155])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  8 Jul 2021 16:04:10 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils v2 2/4] libimaevm: Remove calculation of a digest over a device file
Date:   Thu,  8 Jul 2021 12:04:06 -0400
Message-Id: <20210708160408.2779849-3-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210708160408.2779849-1-stefanb@linux.ibm.com>
References: <20210708160408.2779849-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yuT6fdRIDmfJAf9dtitylU3vGsvCgt-C
X-Proofpoint-GUID: yuT6fdRIDmfJAf9dtitylU3vGsvCgt-C
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-08_09:2021-07-08,2021-07-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 mlxlogscore=999 impostorscore=0 adultscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107080083
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Signature verification on device files is not supported by IMA in the
kernel, so remove calculation of digests over devices files.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/libimaevm.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index 2856270..4d51901 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -225,16 +225,6 @@ static int add_link_hash(const char *path, EVP_MD_CTX *ctx)
 	return !EVP_DigestUpdate(ctx, buf, len);
 }
 
-static int add_dev_hash(struct stat *st, EVP_MD_CTX *ctx)
-{
-	uint32_t dev = st->st_rdev;
-	unsigned major = (dev & 0xfff00) >> 8;
-	unsigned minor = (dev & 0xff) | ((dev >> 12) & 0xfff00);
-
-	log_info("device: %u:%u\n", major, minor);
-	return !EVP_DigestUpdate(ctx, &dev, sizeof(dev));
-}
-
 int ima_calc_hash(const char *file, uint8_t *hash)
 {
 	const EVP_MD *md;
@@ -281,10 +271,6 @@ int ima_calc_hash(const char *file, uint8_t *hash)
 	case S_IFLNK:
 		err = add_link_hash(file, pctx);
 		break;
-	case S_IFIFO: case S_IFSOCK:
-	case S_IFCHR: case S_IFBLK:
-		err = add_dev_hash(&st, pctx);
-		break;
 	default:
 		log_err("Unsupported file type (0x%x)", st.st_mode & S_IFMT);
 		err = -1;
-- 
2.31.1

