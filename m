Return-Path: <linux-integrity+bounces-84-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1E07F0799
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Nov 2023 17:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 149B9280DAC
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Nov 2023 16:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCFC14A8A;
	Sun, 19 Nov 2023 16:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fuX5budB"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4574511D
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 08:51:09 -0800 (PST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AJGAb9n012848
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 16:51:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=uqVs7n8bbbpxZVlgRbqsHGQwwungLFmlOO7+nuYmo94=;
 b=fuX5budBQLEI3JRtYoL+ry2JB7YQS/Zy02hRwDdmWaX+ybFRyCIK0/X/yyLUIgBgcYwu
 ZEVohme+M5ABw4nYjd4IYJOPyCW4yS+ZOMXTRNRelL0GsUpw9wYTcJPaG7KUcYCNKvUl
 mxJ/VF//hOHOhhUt+HnpJMmey2YHEKH/g/TYLbT+N8ofMwMJSmssED1DTxvy+ldDIPMm
 KHNJ2cWul9ZyhtMrAok0OBMq+ndDV70A1mKH7i+w8mpmleW9rar3dxhZ7BhG4LJNBh6Q
 HD6Ack3corz5tuCfgATMYrbnLZUpWU3SQJRD80IvQ/DyrfB6lwt/uhm9TO39Y4fX6UmU PQ== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uf1f6rcc8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 16:51:08 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AJE8RJ9020958
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 16:50:58 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uf7ksmbgg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 16:50:58 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AJGouDK24511184
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 19 Nov 2023 16:50:56 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E9E92004B;
	Sun, 19 Nov 2023 16:50:56 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4585C20040;
	Sun, 19 Nov 2023 16:50:55 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.61.134.108])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 19 Nov 2023 16:50:55 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>
Subject: [ima-evm-utils PATCH 02/12] Free public keys list
Date: Sun, 19 Nov 2023 11:50:33 -0500
Message-Id: <20231119165043.46960-3-zohar@linux.ibm.com>
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
X-Proofpoint-GUID: Lhp02MyLX2eY55NfeH2Dbaqhf0XfQbWr
X-Proofpoint-ORIG-GUID: Lhp02MyLX2eY55NfeH2Dbaqhf0XfQbWr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-19_15,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 phishscore=0 mlxscore=0 spamscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311190129

On failure to allocate memory, free the public keys list.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/imaevm.h    |  1 +
 src/libimaevm.c | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/src/imaevm.h b/src/imaevm.h
index 18d7b0e447e1..828976e52881 100644
--- a/src/imaevm.h
+++ b/src/imaevm.h
@@ -249,6 +249,7 @@ uint32_t imaevm_read_keyid(const char *certfile);
 int sign_hash(const char *algo, const unsigned char *hash, int size, const char *keyfile, const char *keypass, unsigned char *sig);
 int verify_hash(const char *file, const unsigned char *hash, int size, unsigned char *sig, int siglen);
 int ima_verify_signature(const char *file, unsigned char *sig, int siglen, unsigned char *digest, int digestlen);
+void free_public_keys(void *public_keys);
 void init_public_keys(const char *keyfiles);
 int imaevm_hash_algo_from_sig(unsigned char *sig);
 const char *imaevm_hash_algo_by_id(int algo);
diff --git a/src/libimaevm.c b/src/libimaevm.c
index 117a1a72b60c..74e9d09b1f05 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -399,11 +399,25 @@ static EVP_PKEY *find_keyid(uint32_t keyid)
 	return 0;
 }
 
+void free_public_keys(void *public_keys)
+{
+	struct public_key_entry *entry = public_keys, *next;
+
+	while (entry != NULL) {
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
+		free_public_keys(g_public_keys);
 }
 
 /*
-- 
2.39.3


