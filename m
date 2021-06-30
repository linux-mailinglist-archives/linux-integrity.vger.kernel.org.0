Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6506F3B892C
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Jun 2021 21:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233690AbhF3Tfm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Jun 2021 15:35:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8616 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233710AbhF3Tfl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Jun 2021 15:35:41 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15UJ41HN168133
        for <linux-integrity@vger.kernel.org>; Wed, 30 Jun 2021 15:33:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=fxS56ljeNGJwUux/KMplix2jCVgsS04XSDDCpwLP4F4=;
 b=TbIouh85Bh1YuvdHO+Katk/mPl10/vsn8ZkZxuL4HYLUNhv+cADSOgFXGN/90j0mOY6c
 bpd5WOOaOh2L2ab1TYYZOImWCRrkJvRBTsZSIdXk7bDpUA/1v6i8NmRBmuoq1tJslJVB
 q/p0DFkXjFK0dHNt3XZJ2ErsYy/ueZyuhUFHmXQhV3EycmwQY3SYgzYBD1jVXrZP0/Wm
 lj4jvtCd/nKoSWzOJv5ryz3BjvH326No+bQ2uUOdMJ9s0xJ2F57AN2doW7/4r0N+d2sK
 /Gtv/FA5dTPICKxRPLy05VmqU4d7ZRYi4uU9yz7hKJTfmPz77gtMwTpjLVW6muPERI0l eQ== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39gvnuc0kw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 30 Jun 2021 15:33:12 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15UJVY9Y024288
        for <linux-integrity@vger.kernel.org>; Wed, 30 Jun 2021 19:33:11 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma04wdc.us.ibm.com with ESMTP id 39duvd9bkq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 30 Jun 2021 19:33:11 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15UJXBvt30081296
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jun 2021 19:33:11 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0BC85AC059;
        Wed, 30 Jun 2021 19:33:11 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F33C4AC066;
        Wed, 30 Jun 2021 19:33:10 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.47.158.155])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 30 Jun 2021 19:33:10 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils 1/3] libimaevm: Remove calculation of a digest over a device file
Date:   Wed, 30 Jun 2021 15:33:01 -0400
Message-Id: <20210630193303.2531284-2-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210630193303.2531284-1-stefanb@linux.ibm.com>
References: <20210630193303.2531284-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GaRnBb5zltYOIURIb3yFlapSsK62HHYo
X-Proofpoint-GUID: GaRnBb5zltYOIURIb3yFlapSsK62HHYo
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-30_08:2021-06-30,2021-06-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 mlxlogscore=999
 clxscore=1015 bulkscore=0 priorityscore=1501 spamscore=0 phishscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106300106
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Signature verification on device files is not supported by IMA in the
kernel, so remove calculation of digests over devices files.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
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

