Return-Path: <linux-integrity+bounces-369-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6255E8078A5
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Dec 2023 20:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C4941C20F88
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Dec 2023 19:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E94547F42;
	Wed,  6 Dec 2023 19:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="otKo4gId"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B88172D
	for <linux-integrity@vger.kernel.org>; Wed,  6 Dec 2023 11:28:22 -0800 (PST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B6J99r6018468
	for <linux-integrity@vger.kernel.org>; Wed, 6 Dec 2023 19:28:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=/tUyNf+x4oPm616E8U/Xv97EhaOTpJDwTryz4nKfWM4=;
 b=otKo4gIdaclEGlzBOVNIAptHCbp50QNYFeowOwL0MQ5FBopQzMOJum3ZpIS97bElVnqa
 c6J1Py8ECdN5j+IfAsijqnFEfowoqGJrZJBZ1AvxWI7wKTHjl60nvk5qYl6xxya97IZA
 qidfH52tCR7BKuasUy0Toyb7/YojvqiY7ZvhfCcPOeDDVuh6FaKFv3TW5TJeNJicahuY
 UTkQEgS3Dah/qP6BUti5y5ac0sTri3Y+BJcvkCazCXSL1x/vNr8htNq805F67WrO9fTv
 i4XLhDpNUEi3fcDhFabhw0ozrLX2hOJPdXvV/b3iHuathrXWDMFQ9EY6fJcbJPpPLDQk Rg== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3utup9pnb8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 06 Dec 2023 19:28:20 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B6Ic4jg001541
	for <linux-integrity@vger.kernel.org>; Wed, 6 Dec 2023 19:28:19 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3utav2ek83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 06 Dec 2023 19:28:19 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B6JSGgr6423118
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Dec 2023 19:28:16 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B7FB2004B;
	Wed,  6 Dec 2023 19:28:16 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C1B3C20040;
	Wed,  6 Dec 2023 19:28:15 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.61.99.183])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Dec 2023 19:28:15 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Stefan Berger <stefanb@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>
Subject: [ima-evm-utils PATCH v2 10/13] Update EVM signature verification to use a local hash algorithm variable
Date: Wed,  6 Dec 2023 14:27:31 -0500
Message-Id: <20231206192734.339999-11-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231206192734.339999-1-zohar@linux.ibm.com>
References: <20231206192734.339999-1-zohar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cSkcmlUIsUT_zBzpE1ne-6f4_D6o9fZ7
X-Proofpoint-GUID: cSkcmlUIsUT_zBzpE1ne-6f4_D6o9fZ7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_16,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312060141

Instead of relying on the "imaevm_params.algo" global variable, which
is not concurrency-safe, define and use a local file hash algorithm
variable.

Update calc_evm_hash(), imaevm_verify_hash().

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 5aea3652c80f..9e1f4e33bc01 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -340,7 +340,8 @@ err:
  * Returns 0 for EVP_ function failures. Return -1 for other failures.
  * Return hash algorithm size on success.
  */
-static int calc_evm_hash(const char *file, unsigned char *hash)
+static int calc_evm_hash(const char *file, const char *hash_algo,
+			 unsigned char *hash)
 {
         const EVP_MD *md;
 	struct stat st;
@@ -408,10 +409,9 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
 	}
 #endif
 
-	md = EVP_get_digestbyname(imaevm_params.hash_algo);
+	md = EVP_get_digestbyname(hash_algo);
 	if (!md) {
-		log_err("EVP_get_digestbyname(%s) failed\n",
-			imaevm_params.hash_algo);
+		log_err("EVP_get_digestbyname(%s) failed\n", hash_algo);
 		err = 0;
 		goto out;
 	}
@@ -570,7 +570,7 @@ static int sign_evm(const char *file, const char *key)
 	unsigned char sig[MAX_SIGNATURE_SIZE];
 	int len, err;
 
-	len = calc_evm_hash(file, hash);
+	len = calc_evm_hash(file, imaevm_params.hash_algo, hash);
 	if (len <= 1)
 		return len;
 	assert(len <= sizeof(hash));
@@ -909,6 +909,7 @@ static int verify_evm(void *public_keys, const char *file)
 {
 	unsigned char hash[MAX_DIGEST_SIZE];
 	unsigned char sig[MAX_SIGNATURE_SIZE];
+	const char *hash_algo = NULL;
 	int sig_hash_algo;
 	int mdlen;
 	int len;
@@ -938,15 +939,15 @@ static int verify_evm(void *public_keys, const char *file)
 		log_err("unknown hash algo: %s\n", file);
 		return -1;
 	}
-	imaevm_params.hash_algo = imaevm_hash_algo_by_id(sig_hash_algo);
+	hash_algo = imaevm_hash_algo_by_id(sig_hash_algo);
 
-	mdlen = calc_evm_hash(file, hash);
+	mdlen = calc_evm_hash(file, hash_algo, hash);
 	if (mdlen <= 1)
 		return mdlen;
 	assert(mdlen <= sizeof(hash));
 
-	return imaevm_verify_hash(public_keys, file, imaevm_params.hash_algo,
-				  hash, mdlen, sig, len);
+	return imaevm_verify_hash(public_keys, file, hash_algo, hash,
+				  mdlen, sig, len);
 }
 
 static int cmd_verify_evm(struct command *cmd)
-- 
2.39.3


