Return-Path: <linux-integrity+bounces-655-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBC182489D
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jan 2024 20:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FA98B219D0
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jan 2024 19:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E7C2C188;
	Thu,  4 Jan 2024 19:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="a8En+3IH"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B922C18C
	for <linux-integrity@vger.kernel.org>; Thu,  4 Jan 2024 19:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 404Iwbia024354
	for <linux-integrity@vger.kernel.org>; Thu, 4 Jan 2024 19:06:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Vwgta3e2UampGXcT6wDn9/4/LoGuKSEzAKGAqbd3nP8=;
 b=a8En+3IHGFS8rEXBSDdTGUYoQTFWqpSJVDFyRMME6jN9u0UONsmZP+L1PbXl4CmSOei3
 CWo0JuZCDQafR1UzbRTibkk6Xc1cy2LAP/POajSS5pYzEkkakoQqYABsPnT/jF+nEMom
 3kyh/3O2Df/0oNOK/IjwDIFYliX7LCtshu5Vr4zeRx59DZvT3Tio7hMx+ZrGvDsImDya
 R/FDJM8zs3zAjx/pif8zwar5twhHR/ZwBkWiRTz3T4W3Oon5NhbQUZ2rGOCBsgsfQcg1
 P1aB/f0fyNTSbv9Cb2tJGnxjDe3WM8cYdzOr44ij4prV2gFqQUyX8PgKx8nk8OP8rhiw Sg== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ve2dt87tj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Thu, 04 Jan 2024 19:06:11 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 404GvscK007298
	for <linux-integrity@vger.kernel.org>; Thu, 4 Jan 2024 19:06:10 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vaxhpb46h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Thu, 04 Jan 2024 19:06:10 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 404J67IS13763172
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Jan 2024 19:06:07 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 895CF20043;
	Thu,  4 Jan 2024 19:06:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C05420040;
	Thu,  4 Jan 2024 19:06:06 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.watson.ibm.com (unknown [9.31.99.90])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Jan 2024 19:06:06 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Stefan Berger <stefanb@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>
Subject: [ima-evm-utils PATCH v3 02/13] Free public keys list
Date: Thu,  4 Jan 2024 14:05:47 -0500
Message-Id: <20240104190558.3674008-3-zohar@linux.ibm.com>
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
X-Proofpoint-GUID: Q0TgIbuPQKaz6YJMwyXnhCaJJLQYh_RZ
X-Proofpoint-ORIG-GUID: Q0TgIbuPQKaz6YJMwyXnhCaJJLQYh_RZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-04_11,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 impostorscore=0 clxscore=1015 bulkscore=0 phishscore=0
 adultscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2401040149

On failure to allocate memory, free the public keys list.

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/imaevm.h    |  2 ++
 src/libimaevm.c | 17 +++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/src/imaevm.h b/src/imaevm.h
index 18d7b0e447e1..64f7db79b33a 100644
--- a/src/imaevm.h
+++ b/src/imaevm.h
@@ -233,6 +233,7 @@ struct RSA_ASN1_template {
 #define DEFAULT_PCR 10
 
 extern struct libimaevm_params imaevm_params;
+struct public_key_entry;
 
 void imaevm_do_hexdump(FILE *fp, const void *ptr, int len, bool cr);
 void imaevm_hexdump(const void *ptr, int len);
@@ -250,6 +251,7 @@ int sign_hash(const char *algo, const unsigned char *hash, int size, const char
 int verify_hash(const char *file, const unsigned char *hash, int size, unsigned char *sig, int siglen);
 int ima_verify_signature(const char *file, unsigned char *sig, int siglen, unsigned char *digest, int digestlen);
 void init_public_keys(const char *keyfiles);
+void imaevm_free_public_keys(struct public_key_entry *public_keys);
 int imaevm_hash_algo_from_sig(unsigned char *sig);
 const char *imaevm_hash_algo_by_id(int algo);
 int calc_hash_sigv3(enum evm_ima_xattr_type type, const char *algo, const unsigned char *in_hash, unsigned char *out_hash);
diff --git a/src/libimaevm.c b/src/libimaevm.c
index 244774d01805..61f91df02460 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -399,11 +399,25 @@ static EVP_PKEY *find_keyid(uint32_t keyid)
 	return 0;
 }
 
+void imaevm_free_public_keys(struct public_key_entry *public_keys)
+{
+	struct public_key_entry *entry = public_keys, *next;
+
+	while (entry) {
+		next = entry->next;
+		if (entry->key)
+			free(entry->key);
+		free(entry);
+		entry = next;
+	}
+}
+
 void init_public_keys(const char *keyfiles)
 {
 	struct public_key_entry *entry;
 	char *tmp_keyfiles, *keyfiles_free;
 	char *keyfile;
+	int err = 0;
 	int i = 1;
 
 	tmp_keyfiles = strdup(keyfiles);
@@ -417,6 +431,7 @@ void init_public_keys(const char *keyfiles)
 		entry = malloc(sizeof(struct public_key_entry));
 		if (!entry) {
 			perror("malloc");
+			err = -ENOMEM;
 			break;
 		}
 
@@ -433,6 +448,8 @@ void init_public_keys(const char *keyfiles)
 		g_public_keys = entry;
 	}
 	free(keyfiles_free);
+	if (err < 0)
+		imaevm_free_public_keys(g_public_keys);
 }
 
 /*
-- 
2.39.3


