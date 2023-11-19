Return-Path: <linux-integrity+bounces-85-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 789BF7F079A
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Nov 2023 17:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FD271F223A3
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Nov 2023 16:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C2214A97;
	Sun, 19 Nov 2023 16:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hvwPJ8GL"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635EE128
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 08:51:09 -0800 (PST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AJGAa2W012798
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 16:51:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=tNU7n3T4oJv/TBLIx91ChqGEHptee8qGFGd5ERNKrdU=;
 b=hvwPJ8GLZX9jpq8YmN3U5wubnWZqi65zqONg3Q4tSrlJys3ouw/vgfov4cen7fdSm3sL
 N+u2rLYY1gB5UArBFmMfOZkCwVl6Cht4PVkmWq6uC02veA7b4B7QJXjlfqA7XcU41fyi
 IaGSH3k3p4VZr6AxHbiZocz0qVZYLgGyu597oW4levxD3qshFkUl1KtYctE5YS5lBtJ3
 xZ1YoZB8zAX4Rt2LtwJS9Qfla1e5Db2qC0prjzdtpbLfW7Rfsx7cHS/V5doGnrbbLWMs
 io9F+SMcaKzs8PUfZJYHAu/6byfqvcYoolnpOCoii+QS33gJrnwGtw+X/t8nmac+hJ3z sw== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uf1f6rcd2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 16:51:08 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AJECoT9007586
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 16:51:06 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ufaa1kht5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 16:51:06 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AJGp3wr23790134
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 19 Nov 2023 16:51:03 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B76720049;
	Sun, 19 Nov 2023 16:51:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D5C2320040;
	Sun, 19 Nov 2023 16:51:02 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.61.134.108])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 19 Nov 2023 16:51:02 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>
Subject: [ima-evm-utils PATCH 08/12] Define library ima_calc_hash2() function with a hash algorithm parameter
Date: Sun, 19 Nov 2023 11:50:39 -0500
Message-Id: <20231119165043.46960-9-zohar@linux.ibm.com>
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
X-Proofpoint-GUID: uKdk7bo9e-nLM-pd8TfAP9ifOncEzk9n
X-Proofpoint-ORIG-GUID: uKdk7bo9e-nLM-pd8TfAP9ifOncEzk9n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-19_15,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 phishscore=0 mlxscore=0 spamscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311190129

Instead of relying on the "imaevm_params.algo" global variable, which
is not concurrency-safe, define a new library ima_calc_hash2() function
with the hash algorithm as a parameter.

To avoid library incompatablity, make the existing ima_calc_hash()
function a wrapper for ima_calc_hash2().

Deprecate ima_calc_hash().

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/imaevm.h    |  1 +
 src/libimaevm.c | 12 ++++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/src/imaevm.h b/src/imaevm.h
index 1ed2c81d510d..81acd8df41cb 100644
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
index e64d167a2a8a..4c9da7a2f06b 100644
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


