Return-Path: <linux-integrity+bounces-659-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7178248A0
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jan 2024 20:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D179B21F05
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jan 2024 19:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F792C193;
	Thu,  4 Jan 2024 19:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SLBJmOut"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1DB2C19B
	for <linux-integrity@vger.kernel.org>; Thu,  4 Jan 2024 19:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 404HtRPL032184
	for <linux-integrity@vger.kernel.org>; Thu, 4 Jan 2024 19:06:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=BgENYU6MlShfUiJqkPMbZS2hFGBDsFZnskXXsfDDTjw=;
 b=SLBJmOutnXAkdG/WQaDKDfGj90pm3/Rkl6dMNN+tfD2vUgRjlqEEMVJgp7YVS/B9Zvs6
 adkb5735vQ/0GlqKqYM+EcS+TixZzkax+TFyjSD8AKjMMfHlG0oYccHBZowQI1zm4vpM
 94BALERq0yuyvCCqhK9+Dh0Rq1wbeDmAxNN/yJwl4YpkaL9Q9JGPGo3dfAMS8e4xY+pF
 LZN0wJdq6OXzX1+Qy2yeR2yx6o74wFrqsUZ5lqA8H1uB28vLeKXbWErWw6Z0fGqqz8lh
 eYLFVS8znldRaeyoBIOhZJmYl3EmRSiIw6cWAgnFwFsjyCuebFFTl5ROnqADxEb+HuvX 7w== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ve1gft1b1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Thu, 04 Jan 2024 19:06:20 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 404HoYNP017971
	for <linux-integrity@vger.kernel.org>; Thu, 4 Jan 2024 19:06:19 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vayrkttas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Thu, 04 Jan 2024 19:06:19 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 404J6G9e44630350
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Jan 2024 19:06:17 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D58F120043;
	Thu,  4 Jan 2024 19:06:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4CE3220040;
	Thu,  4 Jan 2024 19:06:16 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.watson.ibm.com (unknown [9.31.99.90])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Jan 2024 19:06:16 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Stefan Berger <stefanb@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>
Subject: [ima-evm-utils PATCH v3 12/13] Update sign_hash_v*() definition to include the key password
Date: Thu,  4 Jan 2024 14:05:57 -0500
Message-Id: <20240104190558.3674008-13-zohar@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: BKWEJs3mv_OLcIQ4wWpkNku0SO_kZQ-b
X-Proofpoint-GUID: BKWEJs3mv_OLcIQ4wWpkNku0SO_kZQ-b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-04_11,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015
 suspectscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401040149

The library sign_hash() definition already includes a key password as a
parameter, but it isn't passed on to sign_hash_v*() functions.  Update
the sign_hash_v*() function definitions and callers.

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/libimaevm.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index 48bce59fba43..ce4f6f73097d 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -1112,7 +1112,8 @@ static int get_hash_algo_v1(const char *algo)
 }
 
 static int sign_hash_v1(const char *hashalgo, const unsigned char *hash,
-			int size, const char *keyfile, unsigned char *sig)
+			int size, const char *keyfile, const char *keypass,
+			unsigned char *sig)
 {
 	int len = -1, hashalgo_idx;
 	SHA_CTX ctx;
@@ -1146,7 +1147,7 @@ static int sign_hash_v1(const char *hashalgo, const unsigned char *hash,
 	log_info("hash(%s): ", hashalgo);
 	log_dump(hash, size);
 
-	key = read_priv_key(keyfile, imaevm_params.keypass);
+	key = read_priv_key(keyfile, keypass);
 	if (!key)
 		return -1;
 
@@ -1199,7 +1200,8 @@ out:
  * Return: -1 signing error, >0 length of signature
  */
 static int sign_hash_v2(const char *algo, const unsigned char *hash,
-			int size, const char *keyfile, unsigned char *sig)
+			int size, const char *keyfile, const char *keypass,
+			unsigned char *sig)
 {
 	struct signature_v2_hdr *hdr;
 	int len = -1;
@@ -1234,7 +1236,7 @@ static int sign_hash_v2(const char *algo, const unsigned char *hash,
 	log_info("hash(%s): ", algo);
 	log_dump(hash, size);
 
-	pkey = read_priv_pkey(keyfile, imaevm_params.keypass);
+	pkey = read_priv_pkey(keyfile, keypass);
 	if (!pkey)
 		return -1;
 
@@ -1304,14 +1306,14 @@ err:
 
 int sign_hash(const char *hashalgo, const unsigned char *hash, int size, const char *keyfile, const char *keypass, unsigned char *sig)
 {
-	if (keypass)
-		imaevm_params.keypass = keypass;
+	if (!keypass)	/* Avoid breaking existing libimaevm usage */
+		keypass = imaevm_params.keypass;
 
 	if (imaevm_params.x509)
-		return sign_hash_v2(hashalgo, hash, size, keyfile, sig);
+		return sign_hash_v2(hashalgo, hash, size, keyfile, keypass, sig);
 #if CONFIG_SIGV1
 	else
-		return sign_hash_v1(hashalgo, hash, size, keyfile, sig);
+		return sign_hash_v1(hashalgo, hash, size, keyfile, keypass, sig);
 #endif
 	log_info("Signature version 1 deprecated.");
 	return -1;
-- 
2.39.3


