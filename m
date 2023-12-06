Return-Path: <linux-integrity+bounces-367-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF8F8078A2
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Dec 2023 20:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEED02821CA
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Dec 2023 19:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC57947F5C;
	Wed,  6 Dec 2023 19:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cTnecfTJ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42AED1719
	for <linux-integrity@vger.kernel.org>; Wed,  6 Dec 2023 11:28:18 -0800 (PST)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B6I6vTQ032547
	for <linux-integrity@vger.kernel.org>; Wed, 6 Dec 2023 19:28:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=N9ZQU0q3Qz1lZw9b6KvPCbHgsXGy1epr3RsKpYNaUgA=;
 b=cTnecfTJnA6a7AQUr4KeOkQ8ILN7Rkx/L1YNAPRxuGLjjYExUbFLHeaIq+Mi0C4QDzBs
 QdQpRuAmMWmvZohanv/ejGS9tcyvR8j/XQ4RId9IdmUH+xn1+fSJ9IoZMLZ10CKFHk7W
 ejjIrP8HxrYJqLn9SztI8W44rnVVfb2a0+NlTqjTa4QTXpIGwxrHGG+xm4bkgLauiYV6
 sITxzq3ZPuSO3oH5TEYB29KKLyTApRWeorFZt1OJ1zrjq6UvI7N2UvfAhoMzCoZmQ3n9
 NWf9ZOXtiJ0E17P4Eq9b7S/Ruw73rWqKpFntHmfra21TES66tHWtdJUF3y4J9NPcdqs4 3g== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3utv6qwmcu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 06 Dec 2023 19:28:17 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B6Ibr8P027003
	for <linux-integrity@vger.kernel.org>; Wed, 6 Dec 2023 19:28:17 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3utav2xjrf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 06 Dec 2023 19:28:17 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B6JSEeq15729192
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Dec 2023 19:28:14 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 481AD20043;
	Wed,  6 Dec 2023 19:28:14 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E66A2004B;
	Wed,  6 Dec 2023 19:28:13 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.61.99.183])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Dec 2023 19:28:13 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Stefan Berger <stefanb@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>
Subject: [ima-evm-utils PATCH v2 08/13] Define library ima_calc_hash2() function with a hash algorithm parameter
Date: Wed,  6 Dec 2023 14:27:29 -0500
Message-Id: <20231206192734.339999-9-zohar@linux.ibm.com>
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
X-Proofpoint-GUID: 4ZlIQJJ7WR7gX_PBMVtrO-NX-9F-d4n8
X-Proofpoint-ORIG-GUID: 4ZlIQJJ7WR7gX_PBMVtrO-NX-9F-d4n8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_16,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 mlxscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312060141

Instead of relying on the "imaevm_params.algo" global variable, which
is not concurrency-safe, define a new library ima_calc_hash2() function
with the hash algorithm as a parameter.

To avoid library incompatibility, make the existing ima_calc_hash()
function a wrapper for ima_calc_hash2().

Deprecate ima_calc_hash().

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/imaevm.h    |  1 +
 src/libimaevm.c | 12 ++++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/src/imaevm.h b/src/imaevm.h
index 99987140c278..69b6b42806d4 100644
--- a/src/imaevm.h
+++ b/src/imaevm.h
@@ -237,6 +237,7 @@ extern struct libimaevm_params imaevm_params;
 void imaevm_do_hexdump(FILE *fp, const void *ptr, int len, bool cr);
 void imaevm_hexdump(const void *ptr, int len);
 int ima_calc_hash(const char *file, uint8_t *hash);
+int ima_calc_hash2(const char *file, const char *hash_algo, uint8_t *hash);
 int imaevm_get_hash_algo(const char *algo);
 RSA *read_pub_key(const char *keyfile, int x509);
 EVP_PKEY *read_pub_pkey(const char *keyfile, int x509);
diff --git a/src/libimaevm.c b/src/libimaevm.c
index eeffe97ec8ea..c14ba7632b61 100644
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
 
+__attribute__((deprecated)) int ima_calc_hash(const char *file, uint8_t *hash)
+{
+	return ima_calc_hash2(file, imaevm_params.hash_algo, hash);
+}
+
 EVP_PKEY *read_pub_pkey(const char *keyfile, int x509)
 {
 	FILE *fp;
-- 
2.39.3


