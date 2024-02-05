Return-Path: <linux-integrity+bounces-1033-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 905F2849CC8
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Feb 2024 15:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4DD51C25336
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Feb 2024 14:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD632C684;
	Mon,  5 Feb 2024 14:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EqLDVLjD"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409D82E63B
	for <linux-integrity@vger.kernel.org>; Mon,  5 Feb 2024 14:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707142542; cv=none; b=dQoJGDqRXlLZWx0vKOMNW4dh+q2IAr79pLGYGzgwGAvkMA4/P+6JsUk0giUMSG6H17RLGOqgdFxbBXpbmCza9C/dWbsfwQFhQl80k6jxVk9ZkxeOo7Ni9Y7tyjVnTb2MoDsMOQqfd+f49Cv8w7vj2t6iJiCU9il2yKm2fB7tjoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707142542; c=relaxed/simple;
	bh=Ez8bnVBU4Jkj+lPXX0aV2ZvvlDEN+IMyiqBhu9Gx8wQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RDwyb7WdYmXSfxLUeIJK+fTIiqMBGVJVU2DsHdee2dLA4tr5odSkiLiw2lWrCavlF6Re24qihhDL3W4jRcyKJ4wcLHwmZBqJGVsY11zezlG0u2ew9iShvnoPyPGzHL4MuJE01EsEF6EDHsO6eyv2WpkjMM67O7SAatu46tPxm8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EqLDVLjD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 415E2OOR028763;
	Mon, 5 Feb 2024 14:15:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=mClszhQYcKHqMqseH4Ll5Wuaa9ykZ8viqoE9QHZ6Qnk=;
 b=EqLDVLjD+iAKufIwfwmy9aCURI8H0XauAVR8XAKDcMUlGlzumJ65aUS9bJTIijfSNW8s
 9dGt+aUR9ZYb7TFLy3YbaWTNHOaphAXyyBPfmbZ+kH+5bNVSz/jJihOyJ0AnYSC789Bw
 j5kGUljv+bm8mlRwX+ONkyE2NIRDdKYkIZ6BiDQm/jbd+X/wb4PXXIgjOR1UlHtbmv3P
 g16dcWgU7+DF5JY5byIOFErCa3iDOXkKuNnifpeDMOT5h+e6Kgp3ydk+aUdOB51UgxTx
 Ja7sfFc0skaoYx9Kyr5zQcr8hUFK0p4Ud3udv28/7IbLDGBIsDN261CqB20Oc6/tzGtX rQ== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w3134ggg8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 14:15:34 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 415Dpog9014765;
	Mon, 5 Feb 2024 14:15:33 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w20tngvws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 14:15:33 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 415EFVuP17892076
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Feb 2024 14:15:32 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D312558063;
	Mon,  5 Feb 2024 14:15:31 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 857205805A;
	Mon,  5 Feb 2024 14:15:31 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Feb 2024 14:15:31 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v1 ima-evm-utils 3/6] evmctl: Replace deprecated sign_hash with imaevm_signhash
Date: Mon,  5 Feb 2024 09:15:25 -0500
Message-ID: <20240205141528.3566511-4-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205141528.3566511-1-stefanb@linux.ibm.com>
References: <20240205141528.3566511-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: e16ghgapYut8uS5n3Q5Un_hvGAjx7m_v
X-Proofpoint-ORIG-GUID: e16ghgapYut8uS5n3Q5Un_hvGAjx7m_v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_08,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 phishscore=0 mlxlogscore=694 priorityscore=1501
 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402050108

Replace the deprecated sign_hash with imaevm_signhash.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 src/evmctl.c | 74 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 44 insertions(+), 30 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index d050b5e..776f304 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -147,6 +147,13 @@ static char *g_keypass;
 #define HMAC_FLAG_CAPS_SET	0x0002
 
 static unsigned long hmac_flags;
+static uint32_t imaevm_keyid;
+static struct imaevm_ossl_access access_info;
+static long sigflags;
+
+static inline bool use_x509(long sigflags) {
+	return (sigflags & IMAEVM_SIGFLAG_SIGNATURE_V1) == 0;
+}
 
 typedef int (*find_cb_t)(const char *path);
 static int find(const char *path, int dts, find_cb_t func);
@@ -577,7 +584,8 @@ static int sign_evm(const char *file, char *hash_algo, const char *key)
 		return len;
 	assert(len <= sizeof(hash));
 
-	len = sign_hash(hash_algo, hash, len, key, g_keypass, sig + 1);
+	len = imaevm_signhash(hash_algo, hash, len, key, g_keypass,
+			      sig + 1, sigflags, &access_info, imaevm_keyid);
 	if (len <= 1)
 		return len;
 	assert(len < sizeof(sig));
@@ -663,7 +671,8 @@ static int sign_ima(const char *file, char *hash_algo, const char *key)
 		return len;
 	assert(len <= sizeof(hash));
 
-	len = sign_hash(hash_algo, hash, len, key, g_keypass, sig + 1);
+	len = imaevm_signhash(hash_algo, hash, len, key, g_keypass,
+			      sig + 1, sigflags, &access_info, imaevm_keyid);
 	if (len <= 1)
 		return len;
 	assert(len < sizeof(sig));
@@ -844,8 +853,9 @@ static int cmd_sign_hash(struct command *cmd)
 				continue;
 			}
 
-			siglen = sign_hash(algo, sigv3_hash, hashlen / 2,
-					   key, g_keypass, sig + 1);
+			siglen = imaevm_signhash(algo, sigv3_hash, hashlen / 2,
+						 key, g_keypass, sig + 1, sigflags,
+						 &access_info, imaevm_keyid);
 
 			sig[0] = IMA_VERITY_DIGSIG;
 			sig[1] = DIGSIG_VERSION_3;	/* sigv3 */
@@ -856,8 +866,10 @@ static int cmd_sign_hash(struct command *cmd)
 			assert(hashlen / 2 <= sizeof(hash));
 			hex2bin(hash, line, hashlen / 2);
 
-			siglen = sign_hash(g_hash_algo, hash,
-					   hashlen / 2, key, g_keypass, sig + 1);
+			siglen = imaevm_signhash(g_hash_algo, hash,
+						 hashlen / 2, key, g_keypass,
+						 sig + 1, sigflags,
+						 &access_info, imaevm_keyid);
 			sig[0] = EVM_IMA_XATTR_DIGSIG;
 		}
 
@@ -963,7 +975,7 @@ static int cmd_verify_evm(struct command *cmd)
 		return -1;
 	}
 
-	if (imaevm_params.x509) {
+	if (use_x509(sigflags)) {
 		if (imaevm_params.keyfile) /* Support multiple public keys */
 			err = imaevm_init_public_keys(imaevm_params.keyfile,
 						      &public_keys);
@@ -1026,7 +1038,7 @@ static int cmd_verify_ima(struct command *cmd)
 		return -1;
 	}
 
-	if (imaevm_params.x509) {
+	if (use_x509(sigflags)) {
 		if (imaevm_params.keyfile) /* Support multiple public keys */
 			err = imaevm_init_public_keys(imaevm_params.keyfile,
 						      &public_keys);
@@ -1061,15 +1073,12 @@ static int cmd_convert(struct command *cmd)
 	uint8_t keyid[8];
 	RSA *key;
 
-	imaevm_params.x509 = 0;
-
 	inkey = g_argv[optind++];
 	if (!inkey) {
-		inkey = imaevm_params.x509 ? "/etc/keys/x509_evm.der" :
-					     "/etc/keys/pubkey_evm.pem";
+		inkey = "/etc/keys/pubkey_evm.pem";
 	}
 
-	key = read_pub_key(inkey, imaevm_params.x509);
+	key = read_pub_key(inkey, 0);
 	if (!key)
 		return 1;
 
@@ -1094,7 +1103,7 @@ static int cmd_import(struct command *cmd)
 
 	inkey = g_argv[optind++];
 	if (!inkey) {
-		inkey = imaevm_params.x509 ? "/etc/keys/x509_evm.der" :
+		inkey = use_x509(sigflags) ? "/etc/keys/x509_evm.der" :
 					     "/etc/keys/pubkey_evm.pem";
 	} else
 		ring = g_argv[optind++];
@@ -1124,8 +1133,8 @@ static int cmd_import(struct command *cmd)
 		}
 	}
 
-	if (imaevm_params.x509) {
-		EVP_PKEY *pkey = read_pub_pkey(inkey, imaevm_params.x509);
+	if (use_x509(sigflags)) {
+		EVP_PKEY *pkey = read_pub_pkey(inkey, 1);
 
 		if (!pkey)
 			return 1;
@@ -1138,7 +1147,7 @@ static int cmd_import(struct command *cmd)
 		EVP_PKEY_free(pkey);
 	} else {
 #if CONFIG_SIGV1
-		RSA *key = read_pub_key(inkey, imaevm_params.x509);
+		RSA *key = read_pub_key(inkey, 0);
 
 		if (!key)
 			return 1;
@@ -1153,8 +1162,8 @@ static int cmd_import(struct command *cmd)
 
 	log_info("Importing public key %s from file %s into keyring %d\n", name, inkey, id);
 
-	id = add_key(imaevm_params.x509 ? "asymmetric" : "user",
-		     imaevm_params.x509 ? NULL : name, pub, len, id);
+	id = add_key(use_x509(sigflags) ? "asymmetric" : "user",
+		     use_x509(sigflags) ? NULL : name, pub, len, id);
 	if (id < 0) {
 		log_err("add_key failed\n");
 		err = id;
@@ -3106,7 +3115,7 @@ int main(int argc, char *argv[])
 				hmac_flags |= HMAC_FLAG_NO_UUID;
 			break;
 		case '1':
-			imaevm_params.x509 = 0;
+			sigflags |= IMAEVM_SIGFLAG_SIGNATURE_V1;
 			break;
 		case 'k':
 			imaevm_params.keyfile = optarg;
@@ -3172,11 +3181,12 @@ int main(int argc, char *argv[])
 			break;
 #if CONFIG_IMA_EVM_ENGINE
 		case 139: /* --engine e */
-			imaevm_params.eng = setup_engine(optarg);
-			if (!imaevm_params.eng) {
+			access_info.u.engine = setup_engine(optarg);
+			if (!access_info.u.engine) {
 				log_info("setup_engine failed\n");
 				goto error;
 			}
+			access_info.type = IMAEVM_OSSL_ACCESS_TYPE_ENGINE;
 			break;
 #endif
 		case 140: /* --xattr-user */
@@ -3210,7 +3220,7 @@ int main(int argc, char *argv[])
 				log_err("Invalid keyid value.\n");
 				exit(1);
 			}
-			imaevm_params.keyid = keyid;
+			imaevm_keyid = keyid;
 			break;
 		case 145:
 			keyid = imaevm_read_keyid(optarg);
@@ -3218,7 +3228,7 @@ int main(int argc, char *argv[])
 				log_err("Error reading keyid.\n");
 				exit(1);
 			}
-			imaevm_params.keyid = keyid;
+			imaevm_keyid = keyid;
 			break;
 		case 146:
 			veritysig = 1;
@@ -3241,12 +3251,16 @@ int main(int argc, char *argv[])
 		g_keypass = getenv("EVMCTL_KEY_PASSWORD");
 
 	if (imaevm_params.keyfile != NULL &&
-	    imaevm_params.eng == NULL &&
+	    access_info.type == IMAEVM_OSSL_ACCESS_TYPE_NONE &&
 	    !strncmp(imaevm_params.keyfile, "pkcs11:", 7)) {
 #if CONFIG_IMA_EVM_ENGINE
-		imaevm_params.eng = setup_engine("pkcs11");
+		if (access_info.type == IMAEVM_OSSL_ACCESS_TYPE_NONE) {
+			access_info.u.engine = setup_engine("pkcs11");
+			if (access_info.u.engine)
+				access_info.type = IMAEVM_OSSL_ACCESS_TYPE_ENGINE;
+		}
 #endif
-		if (!imaevm_params.eng)
+		if (access_info.type == IMAEVM_OSSL_ACCESS_TYPE_NONE)
 			goto error;
 	}
 
@@ -3272,9 +3286,9 @@ int main(int argc, char *argv[])
 
 error:
 #if CONFIG_IMA_EVM_ENGINE
-	if (imaevm_params.eng) {
-		ENGINE_finish(imaevm_params.eng);
-		ENGINE_free(imaevm_params.eng);
+	if (access_info.type == IMAEVM_OSSL_ACCESS_TYPE_ENGINE) {
+		ENGINE_finish(access_info.u.engine);
+		ENGINE_free(access_info.u.engine);
 #if OPENSSL_API_COMPAT < 0x10100000L
 		ENGINE_cleanup();
 #endif
-- 
2.43.0


