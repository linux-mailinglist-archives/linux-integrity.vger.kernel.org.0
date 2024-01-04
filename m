Return-Path: <linux-integrity+bounces-649-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD6B824895
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jan 2024 20:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A6131C20DC6
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jan 2024 19:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB83828E3B;
	Thu,  4 Jan 2024 19:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Hh4pnXvA"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759D928E1F
	for <linux-integrity@vger.kernel.org>; Thu,  4 Jan 2024 19:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 404HRvkE025378
	for <linux-integrity@vger.kernel.org>; Thu, 4 Jan 2024 19:06:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=PtTRYvIATNbOgvbpYnQvhXOp61sviG6lJSwYsGrDQYk=;
 b=Hh4pnXvArRFEe6aUFc75JBd2AxEx0IOo6u9eFmwLwrNRg6N1UQLkdjOXVub/yCrd5b1s
 97cDkZ3NVLJovQM9vqOsmbpb0X8MSb6pE5adgHqqvNOiIPbwSQZ4/faSH2BoHyGsot2F
 vvyU6+FSvB/ZGzD9liR3uZNGjq+IDS0a1eHsJw2TxNJQLlq9O70553ddB/8w3gyvAQdk
 ohV++DS+LebPx3/gHN96+UhuPm7IuBwOqgsbmekWwGUipYgtgvzIu6HPPCJBCDcoiIcM
 jDxQPw2+foUlc11VhwTFobOMrjIp7lMVr5SPOJncUdfhiw5eO22tejk2rebLjHPb7BD7 eg== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ve13pu9vn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Thu, 04 Jan 2024 19:06:13 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 404IZwrd024541
	for <linux-integrity@vger.kernel.org>; Thu, 4 Jan 2024 19:06:12 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vb082jmfj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Thu, 04 Jan 2024 19:06:12 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 404J697L40108374
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Jan 2024 19:06:09 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 47B0A20043;
	Thu,  4 Jan 2024 19:06:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B3AD020040;
	Thu,  4 Jan 2024 19:06:08 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.watson.ibm.com (unknown [9.31.99.90])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Jan 2024 19:06:08 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Stefan Berger <stefanb@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>
Subject: [ima-evm-utils PATCH v3 04/13] Update imaevm_verify_hash() definition to include "hash_algo" parameter
Date: Thu,  4 Jan 2024 14:05:49 -0500
Message-Id: <20240104190558.3674008-5-zohar@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: UWQoq9ykq0bg1Cmo-YgkLm_lz0aTApsY
X-Proofpoint-GUID: UWQoq9ykq0bg1Cmo-YgkLm_lz0aTApsY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-04_11,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0
 spamscore=0 impostorscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=975 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401040149

Instead of relying on a global static "hash_algo" variable, which is not
concurrency-safe, update the imaevm_verify_hash() function definition
and callers to include a "hash_algo" parameter as a place holder.

Now with the "hash_algo" parameter, export the imaevm_verify_hash()
definition.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/imaevm.h    |  3 +++
 src/libimaevm.c | 15 ++++++++-------
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/src/imaevm.h b/src/imaevm.h
index 4fd421f5cd1d..0b86d28944b3 100644
--- a/src/imaevm.h
+++ b/src/imaevm.h
@@ -261,6 +261,9 @@ IMAEVM_DEPRECATED int ima_verify_signature(const char *file, unsigned char *sig,
 					   int digestlen);
 IMAEVM_DEPRECATED void init_public_keys(const char *keyfiles);
 
+int imaevm_verify_hash(struct public_key_entry *public_keys, const char *file,
+		       const char *hash_algo, const unsigned char *hash,
+		       int size, unsigned char *sig, int siglen);
 int ima_verify_signature2(struct public_key_entry *public_keys, const char *file,
 			  unsigned char *sig, int siglen,
 			  unsigned char *digest, int digestlen);
diff --git a/src/libimaevm.c b/src/libimaevm.c
index 9cc83e071610..a5e9fd5080ac 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -729,9 +729,9 @@ int imaevm_hash_algo_from_sig(unsigned char *sig)
 		return -1;
 }
 
-int imaevm_verify_hash(void *public_keys, const char *file,
-		       const unsigned char *hash, int size,
-		       unsigned char *sig, int siglen)
+int imaevm_verify_hash(struct public_key_entry *public_keys, const char *file,
+		       const char *hash_algo, const unsigned char *hash,
+		       int size, unsigned char *sig, int siglen)
 {
 	/* Get signature type from sig header */
 	if (sig[1] == DIGSIG_VERSION_1) {
@@ -762,7 +762,8 @@ int imaevm_verify_hash(void *public_keys, const char *file,
 int verify_hash(const char *file, const unsigned char *hash, int size,
 		unsigned char *sig, int siglen)
 {
-	return imaevm_verify_hash(g_public_keys, file, hash, size, sig, siglen);
+	return imaevm_verify_hash(g_public_keys, file, NULL, hash, size,
+				  sig, siglen);
 }
 
 int ima_verify_signature2(struct public_key_entry *public_keys, const char *file,
@@ -795,15 +796,15 @@ int ima_verify_signature2(struct public_key_entry *public_keys, const char *file
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


