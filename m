Return-Path: <linux-integrity+bounces-364-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 247A280789D
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Dec 2023 20:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 096751C20F2E
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Dec 2023 19:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4BE47F55;
	Wed,  6 Dec 2023 19:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pXhNnYGn"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4167CD72
	for <linux-integrity@vger.kernel.org>; Wed,  6 Dec 2023 11:28:14 -0800 (PST)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B6IvOit014255
	for <linux-integrity@vger.kernel.org>; Wed, 6 Dec 2023 19:28:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=eiPiLO+GXzrs20m6OsVAvaiJVGkbFSVixW4ZohuU+sE=;
 b=pXhNnYGnoX9Uky4NLWSU6HVRk2TW1I8Fk0jmscSbhpzU1VRhpNdrzPCD7Vu52AFFLyxv
 MJo2j0kG5Q1Cd1/uqSkdS2cAJrnzKv5QcphSe0dA0KgsYzQb0RJ92HLR0d8f/4t2kSLW
 QoTXcwsEx11C4CrTYu72V/1M41KdWjVLJW6HX95nr9l2yjOjvWzgCTJe3KO8IWLJD//A
 5synaYHNCf692k91/o1N0MejnvdFlaCBP9PizjcfEuLIal53aaDCEfjEhW5ewo+D6SS/
 QdD/LDB+TuKACB6TG7JMD6B+1MRbS+1JNObLcJ7MLCWgq5Vm0WHS29WNUnuLZrGbRGmD Lw== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3utv7g5gk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 06 Dec 2023 19:28:12 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B6IUEBm015437
	for <linux-integrity@vger.kernel.org>; Wed, 6 Dec 2023 19:28:12 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3utavkeje1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 06 Dec 2023 19:28:12 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B6JS98V13763148
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Dec 2023 19:28:09 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0EE1D20040;
	Wed,  6 Dec 2023 19:28:09 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3452220043;
	Wed,  6 Dec 2023 19:28:08 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.61.99.183])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Dec 2023 19:28:08 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Stefan Berger <stefanb@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>
Subject: [ima-evm-utils PATCH v2 04/13] Update imaevm_verify_hash() definition to include "hash_algo" parameter
Date: Wed,  6 Dec 2023 14:27:25 -0500
Message-Id: <20231206192734.339999-5-zohar@linux.ibm.com>
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
X-Proofpoint-GUID: rgMRpYvWIo3PlU6pAi00ZjgAcPU-PVeG
X-Proofpoint-ORIG-GUID: rgMRpYvWIo3PlU6pAi00ZjgAcPU-PVeG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_16,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 malwarescore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0
 mlxlogscore=842 phishscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312060141

Instead of relying on a global static "hash_algo" variable, which is not
concurrency-safe, update the imaevm_verify_hash() function definition
and callers to include a "hash_algo" parameter as a place holder.

Now with the "hash_algo" parameter, export the imaevm_verify_hash()
definition.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/imaevm.h    |  3 +++
 src/libimaevm.c | 13 +++++++------
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/src/imaevm.h b/src/imaevm.h
index b29a4745fc77..99987140c278 100644
--- a/src/imaevm.h
+++ b/src/imaevm.h
@@ -248,6 +248,9 @@ uint32_t imaevm_read_keyid(const char *certfile);
 
 int sign_hash(const char *algo, const unsigned char *hash, int size, const char *keyfile, const char *keypass, unsigned char *sig);
 int verify_hash(const char *file, const unsigned char *hash, int size, unsigned char *sig, int siglen);
+int imaevm_verify_hash(void *public_keys, const char *file,
+		       const char *hash_algo, const unsigned char *hash,
+		       int size, unsigned char *sig, int siglen);
 int ima_verify_signature(const char *file, unsigned char *sig, int siglen, unsigned char *digest, int digestlen);
 int ima_verify_signature2(void *public_keys, const char *file,
 			  unsigned char *sig, int siglen,
diff --git a/src/libimaevm.c b/src/libimaevm.c
index 6fecb2ffd139..eeffe97ec8ea 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -729,8 +729,8 @@ int imaevm_hash_algo_from_sig(unsigned char *sig)
 }
 
 int imaevm_verify_hash(void *public_keys, const char *file,
-		       const unsigned char *hash, int size,
-		       unsigned char *sig, int siglen)
+		       const char *hash_algo, const unsigned char *hash,
+		       int size, unsigned char *sig, int siglen)
 {
 	/* Get signature type from sig header */
 	if (sig[1] == DIGSIG_VERSION_1) {
@@ -762,7 +762,8 @@ __attribute__((deprecated)) int verify_hash(const char *file,
 					    const unsigned char *hash, int size,
 					    unsigned char *sig, int siglen)
 {
-	return imaevm_verify_hash(g_public_keys, file, hash, size, sig, siglen);
+	return imaevm_verify_hash(g_public_keys, file, NULL, hash, size,
+				  sig, siglen);
 }
 
 int ima_verify_signature2(void *public_keys, const char *file,
@@ -795,15 +796,15 @@ int ima_verify_signature2(void *public_keys, const char *file,
 	 * measurement list, not by calculating the local file digest.
 	 */
 	if (digest && digestlen > 0)
-		return imaevm_verify_hash(public_keys, file, digest, digestlen,
-					  sig, siglen);
+		return imaevm_verify_hash(public_keys, file, NULL, digest,
+					  digestlen, sig, siglen);
 
 	hashlen = ima_calc_hash(file, hash);
 	if (hashlen <= 1)
 		return hashlen;
 	assert(hashlen <= sizeof(hash));
 
-	return imaevm_verify_hash(public_keys, file, hash, hashlen,
+	return imaevm_verify_hash(public_keys, file, NULL, hash, hashlen,
 				  sig, siglen);
 }
 
-- 
2.39.3


