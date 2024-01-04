Return-Path: <linux-integrity+bounces-654-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF8A824899
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jan 2024 20:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D7DC1C22378
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jan 2024 19:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C0C2C194;
	Thu,  4 Jan 2024 19:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tFaWS/Qh"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E7A28E2E
	for <linux-integrity@vger.kernel.org>; Thu,  4 Jan 2024 19:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 404ItotV002940
	for <linux-integrity@vger.kernel.org>; Thu, 4 Jan 2024 19:06:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=9nB5tjS3wKduLtP71JXNDgsxrY1kTHJ4wxjHOE/u+HE=;
 b=tFaWS/QhVXBg5FBfLp1KR/h8j+ntkndvo2MzkE3WIg1aLqj3F5OY2Zfzmn6od/IU0FD9
 0M9PJAojmgnDJfjnGoMC+mmJMhULI4KjifHX7YQCFCCo4hP2ZuvSg+suH98P3W/ZYXqK
 vZs2kwsL0ecBq7bSPzmb+aufJwCUABDUN5mtABLSh7eqsmkxtvBX9swLUfuAqXVe0MN/
 ZqFx6OtCv1HLqR7NXrsfE028spjuv1iLeBawDfYd2CgzS/XKLTN8sxjNJdkXDXV+700r
 3TTZsvCdE2Rq/dBfEgL4LtNQz9VmNSqcRTWhZujvhcapFtc+VYMCv0ss7vOqoPeCu2QN 9g== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ve1r898wh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Thu, 04 Jan 2024 19:06:16 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 404GbgbP027299
	for <linux-integrity@vger.kernel.org>; Thu, 4 Jan 2024 19:06:16 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vawhtkbph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Thu, 04 Jan 2024 19:06:15 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 404J6D1g25363100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Jan 2024 19:06:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 221252004E;
	Thu,  4 Jan 2024 19:06:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E17520040;
	Thu,  4 Jan 2024 19:06:12 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.watson.ibm.com (unknown [9.31.99.90])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Jan 2024 19:06:12 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Stefan Berger <stefanb@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>
Subject: [ima-evm-utils PATCH v3 08/13] Define library ima_calc_hash2() function with a hash algorithm parameter
Date: Thu,  4 Jan 2024 14:05:53 -0500
Message-Id: <20240104190558.3674008-9-zohar@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: uHxLj3pyyCq7c1QrTjq51gn__HocLhtm
X-Proofpoint-GUID: uHxLj3pyyCq7c1QrTjq51gn__HocLhtm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-04_11,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 mlxscore=0 spamscore=0 malwarescore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401040149

Instead of relying on the "imaevm_params.algo" global variable, which
is not concurrency-safe, define a new library ima_calc_hash2() function
with the hash algorithm as a parameter.

To avoid library incompatibility, make the existing ima_calc_hash()
function a wrapper for ima_calc_hash2().

Deprecate ima_calc_hash().

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/imaevm.h    |  3 ++-
 src/libimaevm.c | 12 ++++++++----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/src/imaevm.h b/src/imaevm.h
index 0b86d28944b3..8e24f08bbddc 100644
--- a/src/imaevm.h
+++ b/src/imaevm.h
@@ -243,7 +243,6 @@ struct public_key_entry;
 
 void imaevm_do_hexdump(FILE *fp, const void *ptr, int len, bool cr);
 void imaevm_hexdump(const void *ptr, int len);
-int ima_calc_hash(const char *file, uint8_t *hash);
 int imaevm_get_hash_algo(const char *algo);
 RSA *read_pub_key(const char *keyfile, int x509);
 EVP_PKEY *read_pub_pkey(const char *keyfile, int x509);
@@ -254,6 +253,7 @@ int key2bin(RSA *key, unsigned char *pub);
 uint32_t imaevm_read_keyid(const char *certfile);
 
 int sign_hash(const char *algo, const unsigned char *hash, int size, const char *keyfile, const char *keypass, unsigned char *sig);
+IMAEVM_DEPRECATED int ima_calc_hash(const char *file, uint8_t *hash);
 IMAEVM_DEPRECATED int verify_hash(const char *file, const unsigned char *hash,
 				  int size, unsigned char *sig, int siglen);
 IMAEVM_DEPRECATED int ima_verify_signature(const char *file, unsigned char *sig,
@@ -261,6 +261,7 @@ IMAEVM_DEPRECATED int ima_verify_signature(const char *file, unsigned char *sig,
 					   int digestlen);
 IMAEVM_DEPRECATED void init_public_keys(const char *keyfiles);
 
+int ima_calc_hash2(const char *file, const char *hash_algo, uint8_t *hash);
 int imaevm_verify_hash(struct public_key_entry *public_keys, const char *file,
 		       const char *hash_algo, const unsigned char *hash,
 		       int size, unsigned char *sig, int siglen);
diff --git a/src/libimaevm.c b/src/libimaevm.c
index a5e9fd5080ac..214c656d6eba 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -181,7 +181,7 @@ out:
 	return err;
 }
 
-int ima_calc_hash(const char *file, uint8_t *hash)
+int ima_calc_hash2(const char *file, const char *hash_algo, uint8_t *hash)
 {
 	const EVP_MD *md;
 	struct stat st;
@@ -202,10 +202,9 @@ int ima_calc_hash(const char *file, uint8_t *hash)
 		goto err;
 	}
 
-	md = EVP_get_digestbyname(imaevm_params.hash_algo);
+	md = EVP_get_digestbyname(hash_algo);
 	if (!md) {
-		log_err("EVP_get_digestbyname(%s) failed\n",
-			imaevm_params.hash_algo);
+		log_err("EVP_get_digestbyname(%s) failed\n", hash_algo);
 		err = 1;
 		goto err;
 	}
@@ -246,6 +245,11 @@ err:
 	return err;
 }
 
+int ima_calc_hash(const char *file, uint8_t *hash)
+{
+	return ima_calc_hash2(file, imaevm_params.hash_algo, hash);
+}
+
 EVP_PKEY *read_pub_pkey(const char *keyfile, int x509)
 {
 	FILE *fp;
-- 
2.39.3


