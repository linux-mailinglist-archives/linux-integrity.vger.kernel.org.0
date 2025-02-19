Return-Path: <linux-integrity+bounces-4903-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F71A3C4DA
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Feb 2025 17:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD61818870A6
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Feb 2025 16:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAFC1FDE0E;
	Wed, 19 Feb 2025 16:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UUeqSVNW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FA61FDE10
	for <linux-integrity@vger.kernel.org>; Wed, 19 Feb 2025 16:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739982123; cv=none; b=BIn6oYD2gKg8hSKjtBtxzub5FOqT9ZSMw68rz4ds/jkwEirwxQf9XP7TlUtCPQeuJ4Hg+k03G+D3hQ1GmCcKp6DKmxPXfhwR0NW9ib8ooMmSBZB30eFmROwCDs+2AMqZx8SwnEKTLQHg+zraY3PIIiwieaRoRuavLIB5VvFuotI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739982123; c=relaxed/simple;
	bh=7GNNv10L8kDVw8GD0IwdO/p3woIEOs/MZzoPEv928CM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dkmUIU9BLSh/3UjUWHsxv++39BcRUEXoLietWJu+oYtltuPzzkJH71TOwdDB6yX98gh8Hvo3Bgb6IYpEbhEuSU5zo+K6svhhlmDeT0+G9cfvseCKoxQSrcdms8qekghR8UCOcz67L/XUWRZVR0WJRjf9Jbz/cKg1bmV0Vk/6a1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UUeqSVNW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JESHhI005415;
	Wed, 19 Feb 2025 16:21:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=lswXlwutHXC+cwP6E
	e6mqumaluXF1ge5ugz5YxGfBoc=; b=UUeqSVNWsxBPbt2aXNJSFze7IAuYQF+zM
	265UOfgWyNgA/IEpRg9m3ElVr6UB6Ewzl3HHY7Ta6zs1tIQwbiHouradA1+AQOzs
	vtq5aEGGrpVUXlgUmPVpbjk3JZyeA3FQzZuYSz4vcFcudYqGi4+mW/NGvLsqr4aa
	Vt20CFG+lGlW0SMvFW7cTUCpdHda0JounPICp53z4QV8SaLuAoFw52aaZ35rxrup
	3ZklejF07FePKXz1fqW2HTdaQfnuDx3sk0r0isx2htYkQ/PIv3Bl6jJC+ok+qD5S
	Mj3tqJoI7NzdD3m4lBBNTGMsduNqcm9tznycAwc5ZD4VHCxG9sfEw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44w650bpjd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 16:21:55 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51JE28PI009646;
	Wed, 19 Feb 2025 16:21:54 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44w03y50fs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 16:21:54 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51JGLpLk52298034
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 16:21:51 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A67020043;
	Wed, 19 Feb 2025 16:21:51 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BE7120040;
	Wed, 19 Feb 2025 16:21:49 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.fios-router.home (unknown [9.61.30.244])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Feb 2025 16:21:49 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, roberto.sassu@huawei.com,
        Stefan Berger <stefanb@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>
Subject: [PATCH 1/2] ima: limit the number of open-writers integrity violations
Date: Wed, 19 Feb 2025 11:21:30 -0500
Message-ID: <20250219162131.416719-2-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219162131.416719-1-zohar@linux.ibm.com>
References: <20250219162131.416719-1-zohar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LfCSCPI32gnPutih6sYmS6N_hxi0Aznk
X-Proofpoint-GUID: LfCSCPI32gnPutih6sYmS6N_hxi0Aznk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_07,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 clxscore=1015 bulkscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502190124

Each time a file in policy, that is already opened for write, is opened
for read an open-writers integrity violation audit message is emitted
and a violation record is added to the IMA measurement list, even if an
open-writers violation has already been recorded.

Limit the number of open-writers integrity violations for an existing
file open for write to one.  After the existing file open for write
closes (__fput), subsequent open-writers integrity violations may occur.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
Change log v1:
- Basesd on Stefan's RFC comments, updated the patch description and code.

 security/integrity/ima/ima.h      |  1 +
 security/integrity/ima/ima_main.c | 11 +++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index a4f284bd846c..7f21568544dd 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -182,6 +182,7 @@ struct ima_kexec_hdr {
 #define IMA_CHANGE_ATTR		2
 #define IMA_DIGSIG		3
 #define IMA_MUST_MEASURE	4
+#define IMA_LIMIT_VIOLATIONS	5

 /* IMA integrity metadata associated with an inode */
 struct ima_iint_cache {
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 28b8b0db6f9b..cde3ae55d654 100644
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
+			if (!test_and_set_bit(IMA_LIMIT_VIOLATIONS,
+					      &iint->atomic_flags))
+				send_writers = true;
+		}
 	}

 	if (!send_tomtou && !send_writers)
@@ -167,6 +172,8 @@ static void ima_check_last_writer(struct ima_iint_cache *iint,
 	if (atomic_read(&inode->i_writecount) == 1) {
 		struct kstat stat;

+		clear_bit(IMA_LIMIT_VIOLATIONS, &iint->atomic_flags);
+
 		update = test_and_clear_bit(IMA_UPDATE_XATTR,
 					    &iint->atomic_flags);
 		if ((iint->flags & IMA_NEW_FILE) ||
--
2.48.1


