Return-Path: <linux-integrity+bounces-371-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5CC8078A6
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Dec 2023 20:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC2591C20F76
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Dec 2023 19:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A8F47F4B;
	Wed,  6 Dec 2023 19:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ihbysJ+c"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D17D64
	for <linux-integrity@vger.kernel.org>; Wed,  6 Dec 2023 11:28:24 -0800 (PST)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B6H7OUK014236
	for <linux-integrity@vger.kernel.org>; Wed, 6 Dec 2023 19:28:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=7qgApP/gm/lN/2a9ovz0KItsDebVNxVffJZdGvn1y+0=;
 b=ihbysJ+cGqkYTmi+5vKbSYjLAwXMScuGKdS8xgQo8MjympVp2MOEkxvaMtjnnUnZE2OM
 ofAUT9UI63Vgamg1X5YxVtIou0pkoOAywC+eUvmGZi7UVvTg29F3nwMZea/JTm9Et/2a
 TmD7kJ6cRXk5PWncE3M0VyJFrRAoFL/y+P1brAzR2f1GJu7VFDESzFP7Cq/z+QXrzNb0
 JKPdqYpf9dIetxi6F4PQOn3+Pt9VPPNDLhldOngC7GX6zmM0YemjU+cK8u+Nq9LSs6nK
 6206bIv8jJJ8WTS03oNX3UEa6oPaljZ649/r4F09aOwY8xoxpstenCRVBlG44rTpZLV4 OA== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3utv7g5gq4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 06 Dec 2023 19:28:22 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B6IWvke027096
	for <linux-integrity@vger.kernel.org>; Wed, 6 Dec 2023 19:28:21 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3utav2xjs3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 06 Dec 2023 19:28:21 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B6JSJIo19071590
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Dec 2023 19:28:19 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 115462004D;
	Wed,  6 Dec 2023 19:28:19 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 277272004B;
	Wed,  6 Dec 2023 19:28:18 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.61.99.183])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Dec 2023 19:28:17 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Stefan Berger <stefanb@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>
Subject: [ima-evm-utils PATCH v2 12/13] Update sign_hash_v*() definition to include the key password
Date: Wed,  6 Dec 2023 14:27:33 -0500
Message-Id: <20231206192734.339999-13-zohar@linux.ibm.com>
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
X-Proofpoint-GUID: XuI8exLS6bVx6k0TkshB0Ked24Kh1BAv
X-Proofpoint-ORIG-GUID: XuI8exLS6bVx6k0TkshB0Ked24Kh1BAv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_16,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 malwarescore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312060141

The library sign_hash() definition already includes a key password as a
parameter, but it isn't passed on to sign_hash_v*() functions.  Update
the sign_hash_v*() function definitions and callers.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/libimaevm.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index 10e1ed3eab4d..9d8f419ae64d 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -1115,7 +1115,8 @@ static int get_hash_algo_v1(const char *algo)
 }
 
 static int sign_hash_v1(const char *hashalgo, const unsigned char *hash,
-			int size, const char *keyfile, unsigned char *sig)
+			int size, const char *keyfile, const char *keypass,
+			unsigned char *sig)
 {
 	int len = -1, hashalgo_idx;
 	SHA_CTX ctx;
@@ -1149,7 +1150,7 @@ static int sign_hash_v1(const char *hashalgo, const unsigned char *hash,
 	log_info("hash(%s): ", hashalgo);
 	log_dump(hash, size);
 
-	key = read_priv_key(keyfile, imaevm_params.keypass);
+	key = read_priv_key(keyfile, keypass);
 	if (!key)
 		return -1;
 
@@ -1202,7 +1203,8 @@ out:
  * Return: -1 signing error, >0 length of signature
  */
 static int sign_hash_v2(const char *algo, const unsigned char *hash,
-			int size, const char *keyfile, unsigned char *sig)
+			int size, const char *keyfile, const char *keypass,
+			unsigned char *sig)
 {
 	struct signature_v2_hdr *hdr;
 	int len = -1;
@@ -1237,7 +1239,7 @@ static int sign_hash_v2(const char *algo, const unsigned char *hash,
 	log_info("hash(%s): ", algo);
 	log_dump(hash, size);
 
-	pkey = read_priv_pkey(keyfile, imaevm_params.keypass);
+	pkey = read_priv_pkey(keyfile, keypass);
 	if (!pkey)
 		return -1;
 
@@ -1307,14 +1309,14 @@ err:
 
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


