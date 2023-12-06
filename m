Return-Path: <linux-integrity+bounces-361-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D39780789B
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Dec 2023 20:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33AE81C20F0B
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Dec 2023 19:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D568E47F53;
	Wed,  6 Dec 2023 19:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PoG5lUBs"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C3010CE
	for <linux-integrity@vger.kernel.org>; Wed,  6 Dec 2023 11:28:12 -0800 (PST)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B6JRM6x014204
	for <linux-integrity@vger.kernel.org>; Wed, 6 Dec 2023 19:28:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=luz/yFI1HyrEe6jFFohanHT5A9xkrZH6Ov2dvobHWmk=;
 b=PoG5lUBsOhpPbGI7EKJVFKwdMGySqWB9goxsz3+TCuEWafxZ0mllbDWnIE4+5SWaA0M1
 9jJK8iBHGFlhu4ryAw1tDOqjNk436QhKCznfKz5VkmZee4RTSvwaXungASODCl897lHq
 HF9HWaphwCUbvjn9Y+ZS4wf8jwt0CGGT177LY1st3QmR+jlEixqHs/7IxPaec6mY/Kxe
 LCr66q2K5bTXDVOR22XOAFkdAY8kKTtvmWTAU+f/bHC1OcxyngIvjGCL0AxgcGO6KBa2
 cUHDtJiiozvbEsXY4WmE7mEGh1QwM6OygJICyhCu5t2Qkw2Mw+QHADnPsC4NitJNerXF Ag== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3utv7g5gj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 06 Dec 2023 19:28:10 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B6IQxdp028432
	for <linux-integrity@vger.kernel.org>; Wed, 6 Dec 2023 19:28:10 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3utavjpjgy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 06 Dec 2023 19:28:10 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B6JS6Te43123026
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Dec 2023 19:28:06 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9DEE62004B;
	Wed,  6 Dec 2023 19:28:06 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 55C8620040;
	Wed,  6 Dec 2023 19:28:05 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.61.99.183])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Dec 2023 19:28:05 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Stefan Berger <stefanb@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>
Subject: [ima-evm-utils PATCH v2 02/13] Free public keys list
Date: Wed,  6 Dec 2023 14:27:23 -0500
Message-Id: <20231206192734.339999-3-zohar@linux.ibm.com>
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
X-Proofpoint-GUID: MAvkj3PI0ojrdFb8QkIlx1pW13rsrGXa
X-Proofpoint-ORIG-GUID: MAvkj3PI0ojrdFb8QkIlx1pW13rsrGXa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_16,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 malwarescore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312060141

On failure to allocate memory, free the public keys list.

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/imaevm.h    |  1 +
 src/libimaevm.c | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/src/imaevm.h b/src/imaevm.h
index 18d7b0e447e1..470e8376f2fb 100644
--- a/src/imaevm.h
+++ b/src/imaevm.h
@@ -249,6 +249,7 @@ uint32_t imaevm_read_keyid(const char *certfile);
 int sign_hash(const char *algo, const unsigned char *hash, int size, const char *keyfile, const char *keypass, unsigned char *sig);
 int verify_hash(const char *file, const unsigned char *hash, int size, unsigned char *sig, int siglen);
 int ima_verify_signature(const char *file, unsigned char *sig, int siglen, unsigned char *digest, int digestlen);
+void imaevm_free_public_keys(void *public_keys);
 void init_public_keys(const char *keyfiles);
 int imaevm_hash_algo_from_sig(unsigned char *sig);
 const char *imaevm_hash_algo_by_id(int algo);
diff --git a/src/libimaevm.c b/src/libimaevm.c
index 244774d01805..534468fe99ca 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -399,11 +399,25 @@ static EVP_PKEY *find_keyid(uint32_t keyid)
 	return 0;
 }
 
+void imaevm_free_public_keys(void *public_keys)
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


