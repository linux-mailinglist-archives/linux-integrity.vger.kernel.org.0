Return-Path: <linux-integrity+bounces-5024-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D20A4A46D
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Feb 2025 21:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8098E3B8890
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Feb 2025 20:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A5F1B87FB;
	Fri, 28 Feb 2025 20:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="W1hn/NhM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF841C54B2
	for <linux-integrity@vger.kernel.org>; Fri, 28 Feb 2025 20:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740776135; cv=none; b=r5YU5MjTli4ZOOZuOUPwu4FPutApyUxYl9DcuMIaB1kfHm69VMnlqD7HaWqROFQ02w0E/TwqQlr0bMqD39RRip6XeWirOuFXnA1pHEZMz0r9GcAzoSH5rOh3NIPe2xFSYrYjYVdjeZxBFG0pPd+V0E/tWUjvf9vIacBdz3v0XT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740776135; c=relaxed/simple;
	bh=ftb1+KM4CygywhTSZuLLFR5O/mFZCEba9+dJOa0070Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GuQRxtog28dPUjUvXeKVyikMdD4x7ynYDz8hCPYvTMpKEaD+WsMrkLBmy6inHYCw8DVJbj9UM2TO3w/5Df8ud4j7rfXXkpZoxBr9Vkdk4VMA1VqsgJ+YY3gJQegaQu0Ew56d9KVQbhrY5ov4vIKiE3nuj2vGlKn+YHGcouLN2Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=W1hn/NhM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51SDXjuc029263;
	Fri, 28 Feb 2025 20:55:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=xMewSHS2CgmKE5APk
	SyR7dfgF/p4a7etf3qDdzc30rY=; b=W1hn/NhMUh6a1jvX2szoTnzBoaGmLBCoG
	Itd+f7fvrEG/K90H3iJ7Eqxn7GTYCYEk3IaGeB1lSGkcdx8r9Lvc8cEpHfZFvcxM
	5quEBKgHvzpb7Zy5I5oNIDBTc9aEcWLeWc3b2AR2ev2vB4QVdXoicPnxcFIRMQMd
	IyJOLPIeB4JojvW9OdilV6OTITUW1TeEWGFpxHL8ZcNR4f9zjm4g3YXN6DoLCgq/
	HyJRCcug/aIGpksiqRoyfD+prVNb3Rbref06F+q9Srd3yZXzlU1l+iz0WUh64McR
	rud77dmafoHr/+D6Tv0RB02VEY2heaaTpd6p6VkbKyso3ArkFOpew==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 453400mxuc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 20:55:22 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51SIHXZu027337;
	Fri, 28 Feb 2025 20:55:22 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yum2g5k1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 20:55:22 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51SKtI1Q32178530
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 20:55:18 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 585F220043;
	Fri, 28 Feb 2025 20:55:18 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E715720040;
	Fri, 28 Feb 2025 20:55:16 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com.com (unknown [9.61.94.47])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 28 Feb 2025 20:55:16 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, roberto.sassu@huawei.com,
        Stefan Berger <stefanb@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>
Subject: [PATCH v2 1/2] ima: limit the number of open-writers integrity violations
Date: Fri, 28 Feb 2025 15:55:04 -0500
Message-ID: <20250228205505.476845-2-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228205505.476845-1-zohar@linux.ibm.com>
References: <20250228205505.476845-1-zohar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7gyh4ZYzYWM2mInryC5lN0076hqYupD3
X-Proofpoint-ORIG-GUID: 7gyh4ZYzYWM2mInryC5lN0076hqYupD3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_06,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 clxscore=1015 mlxlogscore=999 suspectscore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502280148

Each time a file in policy, that is already opened for write, is opened
for read, an open-writers integrity violation audit message is emitted
and a violation record is added to the IMA measurement list. This
occurs even if an open-writers violation has already been recorded.

Limit the number of open-writers integrity violations for an existing
file open for write to one.  After the existing file open for write
closes (__fput), subsequent open-writers integrity violations may be
emitted.

Tested-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Tested-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
Changelog v2:
- Based on Roberto's review, renamed the atomic flag name, updated the
patch description.
- Added Petr's and Stefan's tags.

Changelog v1:
- Basesd on Stefan's RFC comments, updated the patch description and code:
removed unnecessary checks, simplified code.

 security/integrity/ima/ima.h      |  1 +
 security/integrity/ima/ima_main.c | 11 +++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index a4f284bd846c..3423b3088de5 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -182,6 +182,7 @@ struct ima_kexec_hdr {
 #define IMA_CHANGE_ATTR		2
 #define IMA_DIGSIG		3
 #define IMA_MUST_MEASURE	4
+#define IMA_EMITTED_OPENWRITERS	5

 /* IMA integrity metadata associated with an inode */
 struct ima_iint_cache {
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 28b8b0db6f9b..95118c1887cb 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -137,8 +137,13 @@ static void ima_rdwr_violation_check(struct file *file,
 	} else {
 		if (must_measure)
 			set_bit(IMA_MUST_MEASURE, &iint->atomic_flags);
-		if (inode_is_open_for_write(inode) && must_measure)
-			send_writers = true;
+
+		/* Limit number of open_writers violations */
+		if (inode_is_open_for_write(inode) && must_measure) {
+			if (!test_and_set_bit(IMA_EMITTED_OPENWRITERS,
+					      &iint->atomic_flags))
+				send_writers = true;
+		}
 	}

 	if (!send_tomtou && !send_writers)
@@ -167,6 +172,8 @@ static void ima_check_last_writer(struct ima_iint_cache *iint,
 	if (atomic_read(&inode->i_writecount) == 1) {
 		struct kstat stat;

+		clear_bit(IMA_EMITTED_OPENWRITERS, &iint->atomic_flags);
+
 		update = test_and_clear_bit(IMA_UPDATE_XATTR,
 					    &iint->atomic_flags);
 		if ((iint->flags & IMA_NEW_FILE) ||
--
2.48.1


