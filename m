Return-Path: <linux-integrity+bounces-1419-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4ED8615D8
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Feb 2024 16:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D89231C24189
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Feb 2024 15:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AAD823A7;
	Fri, 23 Feb 2024 15:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AoucNGDG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8E881AC6
	for <linux-integrity@vger.kernel.org>; Fri, 23 Feb 2024 15:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708702271; cv=none; b=CF/Thw6FHzKPBc9BhzotfTyN69YerogPEn9gem/cDSB5zzmKzcCfy+am9z7UwetccBP4wWdCyN0SGBdvueNgl10gna9TXOXx4lgFdT6Vwip8XQJr6btIceW7Dz9DiV4KXCwX086+g3mfJZiVutCnsIhER8tMD1j6ufcjO+aYKNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708702271; c=relaxed/simple;
	bh=7aDDw6axSZhIXmeyVJ5X0Ga7FLRTIgt8eeWrnJ8ibFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M+zmYJX+RsUhoF7O1eJXvyQzb1llB7sPfoSEyGSBcH0QKlT03ZPdylZL6Hu7PLyDgrIzhFGORV6rDrAQvg9FKnNyp2kh18FDxm6OboQl1YpK0+6zUx+VtcRP8phIH5MA/QVkEgpoTeGNuZDOUIKSRdHpdmROOKX9I96HtHhZkAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AoucNGDG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41NEDXPr000819;
	Fri, 23 Feb 2024 15:30:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=IjmbAeuFVX32mVIappYWX81tArzk3M87IaPnLUIZL8I=;
 b=AoucNGDGIBuNJh8kxJhSbGoec2XJDMWcJ+4rfls/cjJ+T5aNfXnO6b8rn71mTY9smLmw
 sB322fU5sSTSt56hDVeOUsWQnAStl7uGNQCSK/jP9UM+DAEmq7YJFDYKElWVu0POUF8r
 et5bmf2/+z2d7ySGwvGsv76sawV5zJXU7c13ZJKLPIE0+PMZqnYoEVraIdCeonJZtsWT
 BRKhJbeeozG3llredyokaBF4Cbbavk5KUaKbwd2JFwPqmzcU+XakKlmoCShAuc00EzM0
 sGPS79FPEmyLo/M7zbP4kGk/Wi0wDnZgxYTrPd2Xt8ce8AdrH9ag81EKveSajWcwmm1m 1w== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wevxdt440-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 15:30:55 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41NEBnsC017261;
	Fri, 23 Feb 2024 15:30:26 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb8mmx2sd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 15:30:26 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41NFUMF042271038
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 15:30:24 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF58958064;
	Fri, 23 Feb 2024 15:30:22 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E80758060;
	Fri, 23 Feb 2024 15:30:22 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Feb 2024 15:30:22 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com, vt@altlinux.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 ima-evm-utils 3/6] evmctl: Replace deprecated sign_hash with imaevm_signhash
Date: Fri, 23 Feb 2024 10:30:11 -0500
Message-ID: <20240223153014.4048133-4-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240223153014.4048133-1-stefanb@linux.ibm.com>
References: <20240223153014.4048133-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: sE5yq11IFiTm6hoEgWVKlC7VfmxAFIiP
X-Proofpoint-GUID: sE5yq11IFiTm6hoEgWVKlC7VfmxAFIiP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_01,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 mlxlogscore=848 phishscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402230112

Replace the deprecated sign_hash with imaevm_signhash. Define local
variables to pass the choice of signature version, key id, and whether
to use an OpenSSL engine to imaevm_signhash.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 src/evmctl.c | 75 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 45 insertions(+), 30 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index d050b5e..20f34dd 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -147,6 +147,14 @@ static char *g_keypass;
 #define HMAC_FLAG_CAPS_SET	0x0002
 
 static unsigned long hmac_flags;
+static uint32_t imaevm_keyid;
+static struct imaevm_ossl_access access_info;
+static long sigflags;
+
+static inline bool use_x509(long sigflags)
+{
+	return (sigflags & IMAEVM_SIGFLAG_SIGNATURE_V1) == 0;
+}
 
 typedef int (*find_cb_t)(const char *path);
 static int find(const char *path, int dts, find_cb_t func);
@@ -577,7 +585,8 @@ static int sign_evm(const char *file, char *hash_algo, const char *key)
 		return len;
 	assert(len <= sizeof(hash));
 
-	len = sign_hash(hash_algo, hash, len, key, g_keypass, sig + 1);
+	len = imaevm_signhash(hash_algo, hash, len, key, g_keypass,
+			      sig + 1, sigflags, &access_info, imaevm_keyid);
 	if (len <= 1)
 		return len;
 	assert(len < sizeof(sig));
@@ -663,7 +672,8 @@ static int sign_ima(const char *file, char *hash_algo, const char *key)
 		return len;
 	assert(len <= sizeof(hash));
 
-	len = sign_hash(hash_algo, hash, len, key, g_keypass, sig + 1);
+	len = imaevm_signhash(hash_algo, hash, len, key, g_keypass,
+			      sig + 1, sigflags, &access_info, imaevm_keyid);
 	if (len <= 1)
 		return len;
 	assert(len < sizeof(sig));
@@ -844,8 +854,9 @@ static int cmd_sign_hash(struct command *cmd)
 				continue;
 			}
 
-			siglen = sign_hash(algo, sigv3_hash, hashlen / 2,
-					   key, g_keypass, sig + 1);
+			siglen = imaevm_signhash(algo, sigv3_hash, hashlen / 2,
+						 key, g_keypass, sig + 1, sigflags,
+						 &access_info, imaevm_keyid);
 
 			sig[0] = IMA_VERITY_DIGSIG;
 			sig[1] = DIGSIG_VERSION_3;	/* sigv3 */
@@ -856,8 +867,10 @@ static int cmd_sign_hash(struct command *cmd)
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
 
@@ -963,7 +976,7 @@ static int cmd_verify_evm(struct command *cmd)
 		return -1;
 	}
 
-	if (imaevm_params.x509) {
+	if (use_x509(sigflags)) {
 		if (imaevm_params.keyfile) /* Support multiple public keys */
 			err = imaevm_init_public_keys(imaevm_params.keyfile,
 						      &public_keys);
@@ -1026,7 +1039,7 @@ static int cmd_verify_ima(struct command *cmd)
 		return -1;
 	}
 
-	if (imaevm_params.x509) {
+	if (use_x509(sigflags)) {
 		if (imaevm_params.keyfile) /* Support multiple public keys */
 			err = imaevm_init_public_keys(imaevm_params.keyfile,
 						      &public_keys);
@@ -1061,15 +1074,12 @@ static int cmd_convert(struct command *cmd)
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
 
@@ -1094,7 +1104,7 @@ static int cmd_import(struct command *cmd)
 
 	inkey = g_argv[optind++];
 	if (!inkey) {
-		inkey = imaevm_params.x509 ? "/etc/keys/x509_evm.der" :
+		inkey = use_x509(sigflags) ? "/etc/keys/x509_evm.der" :
 					     "/etc/keys/pubkey_evm.pem";
 	} else
 		ring = g_argv[optind++];
@@ -1124,8 +1134,8 @@ static int cmd_import(struct command *cmd)
 		}
 	}
 
-	if (imaevm_params.x509) {
-		EVP_PKEY *pkey = read_pub_pkey(inkey, imaevm_params.x509);
+	if (use_x509(sigflags)) {
+		EVP_PKEY *pkey = read_pub_pkey(inkey, 1);
 
 		if (!pkey)
 			return 1;
@@ -1138,7 +1148,7 @@ static int cmd_import(struct command *cmd)
 		EVP_PKEY_free(pkey);
 	} else {
 #if CONFIG_SIGV1
-		RSA *key = read_pub_key(inkey, imaevm_params.x509);
+		RSA *key = read_pub_key(inkey, 0);
 
 		if (!key)
 			return 1;
@@ -1153,8 +1163,8 @@ static int cmd_import(struct command *cmd)
 
 	log_info("Importing public key %s from file %s into keyring %d\n", name, inkey, id);
 
-	id = add_key(imaevm_params.x509 ? "asymmetric" : "user",
-		     imaevm_params.x509 ? NULL : name, pub, len, id);
+	id = add_key(use_x509(sigflags) ? "asymmetric" : "user",
+		     use_x509(sigflags) ? NULL : name, pub, len, id);
 	if (id < 0) {
 		log_err("add_key failed\n");
 		err = id;
@@ -3106,7 +3116,7 @@ int main(int argc, char *argv[])
 				hmac_flags |= HMAC_FLAG_NO_UUID;
 			break;
 		case '1':
-			imaevm_params.x509 = 0;
+			sigflags |= IMAEVM_SIGFLAG_SIGNATURE_V1;
 			break;
 		case 'k':
 			imaevm_params.keyfile = optarg;
@@ -3172,11 +3182,12 @@ int main(int argc, char *argv[])
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
@@ -3210,7 +3221,7 @@ int main(int argc, char *argv[])
 				log_err("Invalid keyid value.\n");
 				exit(1);
 			}
-			imaevm_params.keyid = keyid;
+			imaevm_keyid = keyid;
 			break;
 		case 145:
 			keyid = imaevm_read_keyid(optarg);
@@ -3218,7 +3229,7 @@ int main(int argc, char *argv[])
 				log_err("Error reading keyid.\n");
 				exit(1);
 			}
-			imaevm_params.keyid = keyid;
+			imaevm_keyid = keyid;
 			break;
 		case 146:
 			veritysig = 1;
@@ -3241,12 +3252,16 @@ int main(int argc, char *argv[])
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
 
@@ -3272,9 +3287,9 @@ int main(int argc, char *argv[])
 
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
2.43.2


