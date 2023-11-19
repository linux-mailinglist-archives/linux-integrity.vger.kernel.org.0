Return-Path: <linux-integrity+bounces-88-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C867F079D
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Nov 2023 17:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1133A1C2085D
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Nov 2023 16:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A36014F70;
	Sun, 19 Nov 2023 16:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cdFJjcz1"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE57A137
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 08:51:10 -0800 (PST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AJF9fGG021285
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 16:51:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=bWnqHgBdRw/DjKfOn9Z9kzFqLboIroA5nbIT14EKU9M=;
 b=cdFJjcz19oDzVvvqYdH3fO5mE3cXkO5qGi/Yv7+UoS5COqrO6DQ/6FcHiNpERn9gk8OC
 hRdpGBPZVeGRJznQncEeZdsj17DjIEClSz28Mr+RX23IuyAxrqp2UAQ5EbNvkehvl8Eb
 /VqfAyZfLhkP4qxXCjDDwD+E9i+dYBRHsm94PT5zoBVkeFte33pKlC15zC/VEMQy7Cx9
 XM1I0SuVkLS1ARnB9E0jqvwd9EzB6tWqY6jleOELz8X6XmL9UQmX7pRylIWfztng5Igo
 NtyStvTjRPto1YsbYXbMvB/UXIr6JzqMJypFF99EH6i9/ZhBfektHQ6aZRXxuGj4/5Tt 5w== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ufmrs9dca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 16:51:09 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AJEEA5R020968
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 16:51:09 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uf7ksmbh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 16:51:09 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AJGp6MC18874978
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 19 Nov 2023 16:51:06 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2530F20049;
	Sun, 19 Nov 2023 16:51:06 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2ADD920040;
	Sun, 19 Nov 2023 16:51:05 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.61.134.108])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 19 Nov 2023 16:51:04 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>
Subject: [ima-evm-utils PATCH 10/12] Update EVM signature verification to use a local hash algorithm variable
Date: Sun, 19 Nov 2023 11:50:41 -0500
Message-Id: <20231119165043.46960-11-zohar@linux.ibm.com>
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
X-Proofpoint-GUID: L2sGq14idHiDlNFCqopoGXoOKNItSZfH
X-Proofpoint-ORIG-GUID: L2sGq14idHiDlNFCqopoGXoOKNItSZfH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-19_15,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311190128

Instead of relying on the "imaevm_params.algo" global variable, which
is not concurrency-safe, define and use a local file hash algorithm
variable.

Update calc_evm_hash(), verify_hash2().

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index ad4565b3ee52..7ae897d8b8b3 100644
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
 
-	return verify_hash2(public_keys, file, imaevm_params.hash_algo,
-			    hash, mdlen, sig, len);
+	return verify_hash2(public_keys, file, hash_algo, hash,
+			    mdlen, sig, len);
 }
 
 static int cmd_verify_evm(struct command *cmd)
-- 
2.39.3


