Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7F503C16CA
	for <lists+linux-integrity@lfdr.de>; Thu,  8 Jul 2021 18:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbhGHQGz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 8 Jul 2021 12:06:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48780 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229992AbhGHQGy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Jul 2021 12:06:54 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 168G3lBT075185
        for <linux-integrity@vger.kernel.org>; Thu, 8 Jul 2021 12:04:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=3gJxilfmgb3aZYy10i+tUGinihr/lvJD/KIwxH+mKYE=;
 b=pA0YJ7BrcPFpGWPRJQkliAX47xsbN0jjHqAhul/qPZmywZno7TghMreLSe7DZz1hqZho
 deC/31W7Jj7mxZFXaCvk/Zg0M7B3mzFrdyFtSJUKgCwuBwv97+a3861ZynyPVZGrlN26
 wSmz0NyeaSToqhKSifgj+My3MMtADK3fOhiSRk5TihDPKY7tAR15r8jnOr7d538FA37O
 MeNHCe5DuxU/9jHf/NQr25w/wx7yqanPXaKioHFpPnS1lhGp0tF5tGZWfsMucN8Odn0c
 dfraclMlw/PO647LBLSgaM4BWYEjO1MQFo6YQ/qk6fCToPwzczui2bkjacCR9K2Q2a4Y IA== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39nhcb8eeq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 08 Jul 2021 12:04:12 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 168FvNrW019075
        for <linux-integrity@vger.kernel.org>; Thu, 8 Jul 2021 16:04:11 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma03dal.us.ibm.com with ESMTP id 39jhq1cepj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 08 Jul 2021 16:04:11 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 168G4AJc31261112
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Jul 2021 16:04:10 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D7F4124060;
        Thu,  8 Jul 2021 16:04:10 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 505B1124055;
        Thu,  8 Jul 2021 16:04:10 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.47.158.155])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  8 Jul 2021 16:04:10 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils v2 4/4] libimaevm: Remove calculation of a digest over a symbolic link
Date:   Thu,  8 Jul 2021 12:04:08 -0400
Message-Id: <20210708160408.2779849-5-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210708160408.2779849-1-stefanb@linux.ibm.com>
References: <20210708160408.2779849-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pNxkojln4zdK813f06FS4kPyUZSU1rNj
X-Proofpoint-GUID: pNxkojln4zdK813f06FS4kPyUZSU1rNj
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

Signature verification on symbolic links is not supported by IMA in the
kernel, so remove the calculation of digests over symbolic links.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
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

