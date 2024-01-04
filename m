Return-Path: <linux-integrity+bounces-658-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A22382489F
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jan 2024 20:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9D69B22DD2
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jan 2024 19:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B822C194;
	Thu,  4 Jan 2024 19:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SUr6dyCl"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6363F2C18F
	for <linux-integrity@vger.kernel.org>; Thu,  4 Jan 2024 19:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 404HtTdW032249
	for <linux-integrity@vger.kernel.org>; Thu, 4 Jan 2024 19:06:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=1/h7TU6SPUJVkcx5Z1049oKSVovmpRlZukyqFhfxR8Y=;
 b=SUr6dyClnZFQRPof8qnhcPsV2Hfp48wnb6zC1aeKy6PhIaV44zoUfmRvrVXOUgajkhsM
 Rcaz/YIU39391nnjGwqxu4dL67KE7OEA8qXdorSlCsDpxVVmKFXMsvbw6UIWFjT+vHlK
 qIalu/2IJl8IC4K6dLftzUkkuYmjx2bD1xGK8Hg4mq39Q76Uo2yc/OGkmsMEeT03slzP
 RxqyTIjXYYfK72IFkjbAisguuNySau2MNvkuQPRkFpOR+1dczSC9xdm+br3jS+DfaGgb
 /dwttnxadBoKR1Cs5UN+YJmDeVVKtbUYQCMwc/DUL50ndHnJXGfh2ikTd7z1hA8JUGGV DA== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ve1gft1am-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Thu, 04 Jan 2024 19:06:19 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 404J4Cga019424
	for <linux-integrity@vger.kernel.org>; Thu, 4 Jan 2024 19:06:18 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vc30stabh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Thu, 04 Jan 2024 19:06:18 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 404J6FUv13369882
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Jan 2024 19:06:15 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3AC2220043;
	Thu,  4 Jan 2024 19:06:15 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D29320040;
	Thu,  4 Jan 2024 19:06:14 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.watson.ibm.com (unknown [9.31.99.90])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Jan 2024 19:06:14 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Stefan Berger <stefanb@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>
Subject: [ima-evm-utils PATCH v3 10/13] Update EVM signature verification to use a local hash algorithm variable
Date: Thu,  4 Jan 2024 14:05:55 -0500
Message-Id: <20240104190558.3674008-11-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240104190558.3674008-1-zohar@linux.ibm.com>
References: <20240104190558.3674008-1-zohar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: slaglDOe8vDmXMwh9dlXAV0sD6_32B1m
X-Proofpoint-GUID: slaglDOe8vDmXMwh9dlXAV0sD6_32B1m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-04_11,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015
 suspectscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401040149

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
index 2ccaaf244aa9..3eb995031722 100644
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
@@ -909,6 +909,7 @@ static int verify_evm(struct public_key_entry *public_keys, const char *file)
 {
 	unsigned char hash[MAX_DIGEST_SIZE];
 	unsigned char sig[MAX_SIGNATURE_SIZE];
+	const char *hash_algo = NULL;
 	int sig_hash_algo;
 	int mdlen;
 	int len;
@@ -938,15 +939,15 @@ static int verify_evm(struct public_key_entry *public_keys, const char *file)
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


