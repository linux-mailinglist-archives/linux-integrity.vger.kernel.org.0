Return-Path: <linux-integrity+bounces-360-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3C880789E
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Dec 2023 20:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8071DB20ED7
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Dec 2023 19:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B06547F4A;
	Wed,  6 Dec 2023 19:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="l3YYvpDs"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C804D6E
	for <linux-integrity@vger.kernel.org>; Wed,  6 Dec 2023 11:28:09 -0800 (PST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B6HiKi1007718
	for <linux-integrity@vger.kernel.org>; Wed, 6 Dec 2023 19:28:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Qv/a0F7cJyEs0qPwJUu7Eg+VPqyQ/pvfKdhpRA7WgZc=;
 b=l3YYvpDsvfS8x5/WrxCz5R/zrgFKOnSHA1g1vCFMdPzMOR3+lYsi+M+rm/zLpxyEaF+y
 5nWa8Bp5qF9B19D7SyE6GTT3JY0vsT3E02sGKe9FPaOTjhC5grF90wtQNO1Xw0owF+pR
 U4kqqH58sJTd1rj3Z+nuPmOTL24HeYDMWmjQzsY/klM42IvWd8Zpz/TKz0oDgeqqqpVo
 7ftpNa3d7DqfQRboTRaSDYuIE0kVeQS250EVxNf3bj2jMOLHs/LJFTiI1EWcK1b5Nxrg
 mAc5Mk5GrV3xYygYgOZgOmEkJvvyQ2hAWWa9/gyS3/LPlysuACXdqbnbdkULcQ0TTS2u JQ== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3utwm5ap29-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 06 Dec 2023 19:28:08 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B6IWvkU027096
	for <linux-integrity@vger.kernel.org>; Wed, 6 Dec 2023 19:28:07 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3utav2xjq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 06 Dec 2023 19:28:07 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B6JS4Cc45351516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Dec 2023 19:28:04 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7EEBB20040;
	Wed,  6 Dec 2023 19:28:04 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F1C6920043;
	Wed,  6 Dec 2023 19:28:02 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.61.99.183])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Dec 2023 19:28:02 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Stefan Berger <stefanb@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>
Subject: [ima-evm-utils PATCH v2 01/13] Rename "public_keys" to "g_public_keys"
Date: Wed,  6 Dec 2023 14:27:22 -0500
Message-Id: <20231206192734.339999-2-zohar@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: QxRLkztskGdAWHt1w2j36Nt5E3T9XXdv
X-Proofpoint-GUID: QxRLkztskGdAWHt1w2j36Nt5E3T9XXdv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_16,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312060141

In preparation for replacing the library global public_keys variable,
which is not concurrency-safe, with a local variable, rename public_keys
to g_public_keys.

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/libimaevm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index 5b224625644e..244774d01805 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -370,14 +370,14 @@ struct public_key_entry {
 	char name[9];
 	EVP_PKEY *key;
 };
-static struct public_key_entry *public_keys = NULL;
+static struct public_key_entry *g_public_keys = NULL;
 
 static EVP_PKEY *find_keyid(uint32_t keyid)
 {
-	struct public_key_entry *entry, *tail = public_keys;
+	struct public_key_entry *entry, *tail = g_public_keys;
 	int i = 1;
 
-	for (entry = public_keys; entry != NULL; entry = entry->next) {
+	for (entry = g_public_keys; entry; entry = entry->next) {
 		if (entry->keyid == keyid)
 			return entry->key;
 		i++;
@@ -394,7 +394,7 @@ static EVP_PKEY *find_keyid(uint32_t keyid)
 	if (tail)
 		tail->next = entry;
 	else
-		public_keys = entry;
+		g_public_keys = entry;
 	log_err("key %d: %x (unknown keyid)\n", i, __be32_to_cpup(&keyid));
 	return 0;
 }
@@ -429,8 +429,8 @@ void init_public_keys(const char *keyfiles)
 		calc_keyid_v2(&entry->keyid, entry->name, entry->key);
 		sprintf(entry->name, "%x", __be32_to_cpup(&entry->keyid));
 		log_info("key %d: %s %s\n", i++, entry->name, keyfile);
-		entry->next = public_keys;
-		public_keys = entry;
+		entry->next = g_public_keys;
+		g_public_keys = entry;
 	}
 	free(keyfiles_free);
 }
-- 
2.39.3


