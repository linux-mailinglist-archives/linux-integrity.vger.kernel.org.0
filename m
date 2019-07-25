Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 412B474D8C
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jul 2019 13:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729413AbfGYLvE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 Jul 2019 07:51:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6196 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726431AbfGYLvD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Jul 2019 07:51:03 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6PBbugY134513
        for <linux-integrity@vger.kernel.org>; Thu, 25 Jul 2019 07:51:02 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tya8ncdea-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 25 Jul 2019 07:51:02 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 25 Jul 2019 12:51:00 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 25 Jul 2019 12:50:57 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6PBouSi37421484
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Jul 2019 11:50:56 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A7B284C050;
        Thu, 25 Jul 2019 11:50:56 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A583C4C040;
        Thu, 25 Jul 2019 11:50:55 +0000 (GMT)
Received: from localhost.ibm.com (unknown [9.80.82.197])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 25 Jul 2019 11:50:55 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Vitaly Chikunov <vt@altlinux.org>, Petr Vorel <pvorel@suse.cz>,
        "Bruno E . O . Meneguele" <bmeneg@redhat.com>,
        Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH] ima-evm-utils: functions/arrays define as static
Date:   Thu, 25 Jul 2019 07:50:15 -0400
X-Mailer: git-send-email 2.7.5
X-TM-AS-GCONF: 00
x-cbid: 19072511-4275-0000-0000-0000035077A6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19072511-4276-0000-0000-00003860A2DF
Message-Id: <1564055415-14090-1-git-send-email-zohar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-25_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907250139
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Make sign_hash_v1(), sign_hash_v2(), get_hash_algo_by_id, and
 pkey_hash_algo[] and pkey_hash_algo_kern[] static.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/libimaevm.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index f83a34765c18..815fc8773e6b 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -62,7 +62,7 @@
 #include "hash_info.h"
 
 /* Names that are primary for OpenSSL. */
-const char *const pkey_hash_algo[PKEY_HASH__LAST] = {
+static const char *const pkey_hash_algo[PKEY_HASH__LAST] = {
 	[PKEY_HASH_MD4]		= "md4",
 	[PKEY_HASH_MD5]		= "md5",
 	[PKEY_HASH_SHA1]	= "sha1",
@@ -76,7 +76,7 @@ const char *const pkey_hash_algo[PKEY_HASH__LAST] = {
 };
 
 /* Names that are primary for the kernel. */
-const char *const pkey_hash_algo_kern[PKEY_HASH__LAST] = {
+static const char *const pkey_hash_algo_kern[PKEY_HASH__LAST] = {
 	[PKEY_HASH_STREEBOG_256] = "streebog256",
 	[PKEY_HASH_STREEBOG_512] = "streebog512",
 };
@@ -105,7 +105,7 @@ void ima_hexdump(const void *ptr, int len)
 	ima_do_hexdump(stdout, ptr, len, true);
 }
 
-const char *get_hash_algo_by_id(int algo)
+static const char *get_hash_algo_by_id(int algo)
 {
 	if (algo < PKEY_HASH__LAST)
 		return pkey_hash_algo[algo];
@@ -793,7 +793,8 @@ static int get_hash_algo_v1(const char *algo)
 	return -1;
 }
 
-int sign_hash_v1(const char *hashalgo, const unsigned char *hash, int size, const char *keyfile, unsigned char *sig)
+static int sign_hash_v1(const char *hashalgo, const unsigned char *hash,
+			int size, const char *keyfile, unsigned char *sig)
 {
 	int len = -1, hashalgo_idx;
 	SHA_CTX ctx;
@@ -878,7 +879,8 @@ out:
  * @sig is assumed to be of (MAX_SIGNATURE_SIZE - 1) size
  * Return: -1 signing error, >0 length of signature
  */
-int sign_hash_v2(const char *algo, const unsigned char *hash, int size, const char *keyfile, unsigned char *sig)
+static int sign_hash_v2(const char *algo, const unsigned char *hash,
+			int size, const char *keyfile, unsigned char *sig)
 {
 	struct signature_v2_hdr *hdr;
 	int len = -1;
-- 
2.7.5

