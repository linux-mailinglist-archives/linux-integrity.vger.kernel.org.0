Return-Path: <linux-integrity+bounces-660-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4154982489E
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jan 2024 20:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5B05282FD5
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jan 2024 19:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94CF2C196;
	Thu,  4 Jan 2024 19:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fASnKE0+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675A82C19A
	for <linux-integrity@vger.kernel.org>; Thu,  4 Jan 2024 19:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 404HUMHx026899
	for <linux-integrity@vger.kernel.org>; Thu, 4 Jan 2024 19:06:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Ku/S8JnN3pEaMuwD6cLzwU1cZN3CcpJpSs7NQ6hzY0g=;
 b=fASnKE0+bqlcLO46qf8sOQkFd7+usva6QoqMgJL0xkkT8pZldfkQPclirGsUq6dFErPk
 shjMQQd1xCdbj8QWUpsKG1HKPZFrNyg2nD2Ry/pTZ7ZWoMijTArOuvC55t1Wai/XLJSQ
 kWOTnZ/31bE3XFLWSlnaNRa0HAj4A9IQtHhU52G0u42SX5gzrQhHGwf9E2T4pzhTqHA6
 AHQaUyCWFBFwfE+ymlCKy0bUH+Rc7GtzpvnP/L7sG4r805hZP4AdLgTpdqvaQxi+k/G9
 euO93cqT4Scr6Sda0OAweKmL8HkEwEK6vlpSlGM/mH4f0+/wBrJ9Y782tm7uRA1OBKgC jw== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ve14rk4jq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Thu, 04 Jan 2024 19:06:19 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 404Gvprs019397
	for <linux-integrity@vger.kernel.org>; Thu, 4 Jan 2024 19:06:19 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vc30stabm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Thu, 04 Jan 2024 19:06:19 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 404J6GOq32637542
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Jan 2024 19:06:16 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A3AF20043;
	Thu,  4 Jan 2024 19:06:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 86C3720040;
	Thu,  4 Jan 2024 19:06:15 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.watson.ibm.com (unknown [9.31.99.90])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Jan 2024 19:06:15 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Stefan Berger <stefanb@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>
Subject: [ima-evm-utils PATCH v3 11/13] Use a file specific hash algorithm variable for signing files
Date: Thu,  4 Jan 2024 14:05:56 -0500
Message-Id: <20240104190558.3674008-12-zohar@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: hnmElAGPl8biqM8leLERqNTELij3oKcP
X-Proofpoint-GUID: hnmElAGPl8biqM8leLERqNTELij3oKcP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-04_11,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401040149

Instead of relying on the library "imaevm_params.algo" global variable,
which is not concurrency-safe, define and use an evmctl file specific
hash algorithm variable.

Propagate using the file specific hash algorithm variable in sign_evm(),
sign_ima(), hash_ima(), and sign_hash() function.

Replace using the library function ima_calc_hash() with ima_calc_hash2().

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 3eb995031722..37441b1b77ea 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -140,6 +140,7 @@ static bool evm_immutable;
 static bool evm_portable;
 static bool veritysig;
 static bool hwtpm;
+static char *g_hash_algo = DEFAULT_HASH_ALGO;
 
 #define HMAC_FLAG_NO_UUID	0x0001
 #define HMAC_FLAG_CAPS_SET	0x0002
@@ -564,18 +565,18 @@ out:
 	return err;
 }
 
-static int sign_evm(const char *file, const char *key)
+static int sign_evm(const char *file, char *hash_algo, const char *key)
 {
 	unsigned char hash[MAX_DIGEST_SIZE];
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
+	int algo = imaevm_get_hash_algo(g_hash_algo);
 
 	if (algo < 0) {
-		log_err("Unknown hash algo: %s\n", imaevm_params.hash_algo);
+		log_err("Unknown hash algo: %s\n", g_hash_algo);
 		return -1;
 	}
 	if (algo > PKEY_HASH_SHA1) {
@@ -624,7 +625,7 @@ static int hash_ima(const char *file)
 		offset = 1;
 	}
 
-	len = ima_calc_hash(file, hash + offset);
+	len = ima_calc_hash2(file, g_hash_algo, hash + offset);
 	if (len <= 1)
 		return len;
 	assert(len + offset <= sizeof(hash));
@@ -632,7 +633,7 @@ static int hash_ima(const char *file)
 	len += offset;
 
 	if (imaevm_params.verbose >= LOG_INFO)
-		log_info("hash(%s): ", imaevm_params.hash_algo);
+		log_info("hash(%s): ", g_hash_algo);
 
 	if (sigdump || imaevm_params.verbose >= LOG_INFO)
 		imaevm_hexdump(hash, len);
@@ -650,18 +651,18 @@ static int hash_ima(const char *file)
 	return 0;
 }
 
-static int sign_ima(const char *file, const char *key)
+static int sign_ima(const char *file, char *hash_algo, const char *key)
 {
 	unsigned char hash[MAX_DIGEST_SIZE];
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
@@ -751,7 +752,7 @@ static int sign_ima_file(const char *file)
 
 	key = imaevm_params.keyfile ? : "/etc/keys/privkey_evm.pem";
 
-	return sign_ima(file, key);
+	return sign_ima(file, g_hash_algo, key);
 }
 
 static int cmd_sign_ima(struct command *cmd)
@@ -854,7 +855,7 @@ static int cmd_sign_hash(struct command *cmd)
 			assert(hashlen / 2 <= sizeof(hash));
 			hex2bin(hash, line, hashlen / 2);
 
-			siglen = sign_hash(imaevm_params.hash_algo, hash,
+			siglen = sign_hash(g_hash_algo, hash,
 					   hashlen / 2, key, NULL, sig + 1);
 			sig[0] = EVM_IMA_XATTR_DIGSIG;
 		}
@@ -874,7 +875,6 @@ static int cmd_sign_hash(struct command *cmd)
 		print_usage(cmd);
 		return -1;
 	}
-
 	return 0;
 }
 
@@ -886,7 +886,7 @@ static int sign_evm_path(const char *file)
 	key = imaevm_params.keyfile ? : "/etc/keys/privkey_evm.pem";
 
 	if (digsig) {
-		err = sign_ima(file, key);
+		err = sign_ima(file, g_hash_algo, key);
 		if (err)
 			return err;
 	}
@@ -897,7 +897,7 @@ static int sign_evm_path(const char *file)
 			return err;
 	}
 
-	return sign_evm(file, key);
+	return sign_evm(file, g_hash_algo, key);
 }
 
 static int cmd_sign_evm(struct command *cmd)
@@ -1426,7 +1426,7 @@ static int cmd_hmac_evm(struct command *cmd)
 	key = imaevm_params.keyfile ? : "/etc/keys/privkey_evm.pem";
 
 	if (digsig) {
-		err = sign_ima(file, key);
+		err = sign_ima(file, g_hash_algo, key);
 		if (err)
 			return err;
 	}
@@ -3088,7 +3088,7 @@ int main(int argc, char *argv[])
 			sigdump = 1;
 			break;
 		case 'a':
-			imaevm_params.hash_algo = optarg;
+			g_hash_algo = optarg;
 			break;
 		case 'p':
 			if (optarg)
-- 
2.39.3


