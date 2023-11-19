Return-Path: <linux-integrity+bounces-89-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F05E27F079E
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Nov 2023 17:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6F0F1F2246E
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Nov 2023 16:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54D214F9A;
	Sun, 19 Nov 2023 16:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XekOrZ3o"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F24C2
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 08:51:11 -0800 (PST)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AJFkDYG001821
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 16:51:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=8tO4FcQuyDhSJDKZzEWqKjXSstK5sb+m/qmV7RTuC20=;
 b=XekOrZ3o5w1DAhy/gMfItIyfNEuVa1hQJ2Q0gLcQxdfGJvUjNV5PL3xwRkcHRzpcmkqK
 e7N8BLk1hdrwBRr+AvPVQfmVXR0MfNnKuq2IXcImSqrvdUiW/B0eyG64i5yad5SB7ZQx
 4XxhrGGUHu9NXfUzHigFpOEdB/O+oTld3beSklGkOVkM+m5lkvKieRbLauffcVDbsVPj
 ysSLDiO0KbMs2cfTjk25UPxCitmLZwMHklOveWbJLAcEfx6F7P2vCLfjHkIWJEOu0P4v
 jgaK0fqLOZpUWmwhm3a40vqopO9NUkuWpj4vn0jxrkPx+f4L0DkAtu7cR9bOT19rXHB0 oA== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ufn9t0rpy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 16:51:10 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AJEC510002215
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 16:51:10 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf7yy47kq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 16:51:10 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AJGp7CG24576698
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 19 Nov 2023 16:51:07 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2993B20049;
	Sun, 19 Nov 2023 16:51:07 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 741CD20040;
	Sun, 19 Nov 2023 16:51:06 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.61.134.108])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 19 Nov 2023 16:51:06 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>
Subject: [ima-evm-utils PATCH 11/12] Use a file specific hash algorithm variable for signing files
Date: Sun, 19 Nov 2023 11:50:42 -0500
Message-Id: <20231119165043.46960-12-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231119165043.46960-1-zohar@linux.ibm.com>
References: <20231119165043.46960-1-zohar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4O12pPaUmiMA7xUV90XVkusE4jgKyL0R
X-Proofpoint-GUID: 4O12pPaUmiMA7xUV90XVkusE4jgKyL0R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-19_15,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 mlxscore=0 phishscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311190128

Instead of relying on the library "imaevm_params.algo" global variable,
which is not concurrency-safe, define and use an evmctl file specific
hash algorithm variable.

Propogate using the file specific hash algorithm variable in sign_evm(),
sign_ima(), hash_ima(), and sign_hash() function.

Replace using the library function ima_calc_hash() with ima_calc_hash2().

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 7ae897d8b8b3..b802eeb1bf15 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -140,6 +140,7 @@ static bool evm_immutable;
 static bool evm_portable;
 static bool veritysig;
 static bool hwtpm;
+static char *hash_algo;
 
 #define HMAC_FLAG_NO_UUID	0x0001
 #define HMAC_FLAG_CAPS_SET	0x0002
@@ -570,12 +571,12 @@ static int sign_evm(const char *file, const char *key)
 	unsigned char sig[MAX_SIGNATURE_SIZE];
 	int len, err;
 
-	len = calc_evm_hash(file, imaevm_params.hash_algo, hash);
+	len = calc_evm_hash(file, hash_algo, hash);
 	if (len <= 1)
 		return len;
 	assert(len <= sizeof(hash));
 
-	len = sign_hash(imaevm_params.hash_algo, hash, len, key, NULL, sig + 1);
+	len = sign_hash(hash_algo, hash, len, key, NULL, sig + 1);
 	if (len <= 1)
 		return len;
 	assert(len < sizeof(sig));
@@ -609,10 +610,10 @@ static int hash_ima(const char *file)
 {
 	unsigned char hash[MAX_DIGEST_SIZE + 2]; /* +2 byte xattr header */
 	int len, err, offset;
-	int algo = imaevm_get_hash_algo(imaevm_params.hash_algo);
+	int algo = imaevm_get_hash_algo(hash_algo);
 
 	if (algo < 0) {
-		log_err("Unknown hash algo: %s\n", imaevm_params.hash_algo);
+		log_err("Unknown hash algo: %s\n", hash_algo);
 		return -1;
 	}
 	if (algo > PKEY_HASH_SHA1) {
@@ -624,7 +625,7 @@ static int hash_ima(const char *file)
 		offset = 1;
 	}
 
-	len = ima_calc_hash(file, hash + offset);
+	len = ima_calc_hash2(file, hash_algo, hash + offset);
 	if (len <= 1)
 		return len;
 	assert(len + offset <= sizeof(hash));
@@ -632,7 +633,7 @@ static int hash_ima(const char *file)
 	len += offset;
 
 	if (imaevm_params.verbose >= LOG_INFO)
-		log_info("hash(%s): ", imaevm_params.hash_algo);
+		log_info("hash(%s): ", hash_algo);
 
 	if (sigdump || imaevm_params.verbose >= LOG_INFO)
 		imaevm_hexdump(hash, len);
@@ -656,12 +657,12 @@ static int sign_ima(const char *file, const char *key)
 	unsigned char sig[MAX_SIGNATURE_SIZE];
 	int len, err;
 
-	len = ima_calc_hash(file, hash);
+	len = ima_calc_hash2(file, hash_algo, hash);
 	if (len <= 1)
 		return len;
 	assert(len <= sizeof(hash));
 
-	len = sign_hash(imaevm_params.hash_algo, hash, len, key, NULL, sig + 1);
+	len = sign_hash(hash_algo, hash, len, key, NULL, sig + 1);
 	if (len <= 1)
 		return len;
 	assert(len < sizeof(sig));
@@ -854,7 +855,7 @@ static int cmd_sign_hash(struct command *cmd)
 			assert(hashlen / 2 <= sizeof(hash));
 			hex2bin(hash, line, hashlen / 2);
 
-			siglen = sign_hash(imaevm_params.hash_algo, hash,
+			siglen = sign_hash(hash_algo, hash,
 					   hashlen / 2, key, NULL, sig + 1);
 			sig[0] = EVM_IMA_XATTR_DIGSIG;
 		}
@@ -3077,7 +3078,7 @@ int main(int argc, char *argv[])
 			sigdump = 1;
 			break;
 		case 'a':
-			imaevm_params.hash_algo = optarg;
+			hash_algo = optarg;
 			break;
 		case 'p':
 			if (optarg)
-- 
2.39.3


