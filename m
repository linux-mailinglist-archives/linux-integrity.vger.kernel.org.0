Return-Path: <linux-integrity+bounces-93-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C19C7F07A2
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Nov 2023 17:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA7AD280D9C
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Nov 2023 16:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969CF156C2;
	Sun, 19 Nov 2023 16:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VVidqJBS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CF2129
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 08:51:19 -0800 (PST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AJGAXAD001007
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 16:51:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=DAxWLUHQi7gJNhVtOjrWiEzpRRZcGPOOnQluiUzerXY=;
 b=VVidqJBSZf0U/KzbDzQvkP+Zutowqqh0uxfVeLymVgQtmrqj/uKIUHFtl2+oNzpYc0ua
 W6Tjmj5m01EFIVwjV2OPgt/JC84kd/mP3dXXE4Ipmgo9NnHNWrfnPVq0dj/idvmq7FKN
 vE5RM8Nav3J3h5xLkyqEoKAvlQmd3ZIjtZgCpmHgmgkSWxyYpX4wi7d4O9xAOTV4MIV6
 buQyzMjTxyKcgn6QhQXZjK7apbhwqYnL2kcGij6fjMXzbYwQGf0fE0t0zqVK8d0F/IUU
 e+vVJfMDZVlcyZVJjiqA6y3NyxTb3afZaazMJYJPDytFzlRtos7HQgmPO39tb4BB+LQy 3A== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ueywxsk7m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 16:51:18 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AJE6GXO031867
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 16:51:02 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf93kbwhp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 16:51:02 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AJGoxDl524874
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 19 Nov 2023 16:50:59 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A94620049;
	Sun, 19 Nov 2023 16:50:59 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5792E20040;
	Sun, 19 Nov 2023 16:50:58 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.61.134.108])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 19 Nov 2023 16:50:58 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>
Subject: [ima-evm-utils PATCH 04/12] Update a library function definition to include a "hash_algo" parameter
Date: Sun, 19 Nov 2023 11:50:35 -0500
Message-Id: <20231119165043.46960-5-zohar@linux.ibm.com>
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
X-Proofpoint-GUID: rdfXLlYjpHGVDBXosMCKD2ewLk-49ZRt
X-Proofpoint-ORIG-GUID: rdfXLlYjpHGVDBXosMCKD2ewLk-49ZRt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-19_15,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=859
 malwarescore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311190129

Instead of relying on a global "hash_algo" variable, which is not
concurrency-safe, update the verify_hash2() function definition to
include a "hash_algo" parameter as a place holder.

Export the verify_hash2() definition.

Define verify_hash2().  To avoid library incompatablity, make the existing
function verify_hash() a function wrapper for verify_hash2().

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/imaevm.h    | 1 +
 src/libimaevm.c | 9 +++++----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/src/imaevm.h b/src/imaevm.h
index 146123ba5c42..1ed2c81d510d 100644
--- a/src/imaevm.h
+++ b/src/imaevm.h
@@ -248,6 +248,7 @@ uint32_t imaevm_read_keyid(const char *certfile);
 
 int sign_hash(const char *algo, const unsigned char *hash, int size, const char *keyfile, const char *keypass, unsigned char *sig);
 int verify_hash(const char *file, const unsigned char *hash, int size, unsigned char *sig, int siglen);
+int verify_hash2(void *public_keys, const char *file, const char *hash_algo, const unsigned char *hash, int size, unsigned char *sig, int siglen);
 int ima_verify_signature(const char *file, unsigned char *sig, int siglen, unsigned char *digest, int digestlen);
 int ima_verify_signature2(void *public_keys, const char *file, unsigned char *sig, int siglen, unsigned char *digest, int digestlen);
 void free_public_keys(void *public_keys);
diff --git a/src/libimaevm.c b/src/libimaevm.c
index bf8c99770ddc..e64d167a2a8a 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -732,7 +732,7 @@ int imaevm_hash_algo_from_sig(unsigned char *sig)
 		return -1;
 }
 
-int verify_hash2(void *public_keys, const char *file,
+int verify_hash2(void *public_keys, const char *file, const char *hash_algo,
 		 const unsigned char *hash, int size,
 		 unsigned char *sig, int siglen)
 {
@@ -770,7 +770,7 @@ int verify_hash2(void *public_keys, const char *file,
 int verify_hash(const char *file, const unsigned char *hash, int size,
 		unsigned char *sig, int siglen)
 {
-	return verify_hash2(g_public_keys, file, hash, size, sig, siglen);
+	return verify_hash2(g_public_keys, file, NULL, hash, size, sig, siglen);
 }
 
 int ima_verify_signature2(void *public_keys, const char *file,
@@ -803,7 +803,7 @@ int ima_verify_signature2(void *public_keys, const char *file,
 	 * measurement list, not by calculating the local file digest.
 	 */
 	if (digest && digestlen > 0)
-		return verify_hash2(public_keys, file, digest, digestlen,
+		return verify_hash2(public_keys, file, NULL, digest, digestlen,
 				   sig, siglen);
 
 	hashlen = ima_calc_hash(file, hash);
@@ -811,7 +811,8 @@ int ima_verify_signature2(void *public_keys, const char *file,
 		return hashlen;
 	assert(hashlen <= sizeof(hash));
 
-	return verify_hash2(public_keys, file, hash, hashlen, sig, siglen);
+	return verify_hash2(public_keys, file, NULL, hash, hashlen,
+			    sig, siglen);
 }
 
 /*
-- 
2.39.3


