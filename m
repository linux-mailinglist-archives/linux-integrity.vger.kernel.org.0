Return-Path: <linux-integrity+bounces-5058-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 796FBA4DD22
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Mar 2025 12:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DE5F1899F64
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Mar 2025 11:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67152202C5B;
	Tue,  4 Mar 2025 11:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Gsihoe/W"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D182E2010F5
	for <linux-integrity@vger.kernel.org>; Tue,  4 Mar 2025 11:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741089232; cv=none; b=Yj0k2sLmHvktyUzlRBlcDO8tPJLgXqKg13WlhXGptG4TibBhVy2JI95x90H9NRtrHYFns9e2hl2bSZkhit9KiFOeY+n6RJ1Rzzt05hFrKEAkzXUymB7xu9+q3Rb73UV5yf4MKWaWPP/bSq3/xYwjjy+xzxFxU4w+tqJ5IL+T6qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741089232; c=relaxed/simple;
	bh=3EIfBRx1pUVyyxO6idBraZ0QjrmhDbk92LecZPGoDgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WzRVpWQBLy6kY8PJWoB/qsgZABP79hMWekDz8LmkIK1wfdiTeO9GAo6NGPToZVswNZ+W8/yLWf8wz/iM51/L6qlwpSfXZeKX9C3zND2hTrBXigE80OA2ZXrB2kM3/2z79dS34X44FZiOWFsM0GJ6o0tzl0oDwRH9/hGXe4A5C/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Gsihoe/W; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5248JUMQ025721;
	Tue, 4 Mar 2025 11:53:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=LmcVmL38kPy19S85F
	fWj7n6TEM1bVoju/O73PeQ4eZ0=; b=Gsihoe/W8uYDnsp+uG+1gq03BCcwnJT7S
	Tx0f1vbmSdqrvYqkv6TlEds7wFEOiVYjJS6dkVVkAZP+nOw3507aVAuRFtq41Nd7
	yVmDZWG4QMfjQ6IPMUViFVLVfj19jNfVIflcp1tda5nMkq7RVYh+i4LspZed5/Dj
	q7nm4fLObSc8Hx1U5NGilNuplDuMnM+3N+BqeLPk4WwfUh3w8HMmKXfPTJMS++6n
	7EgceQPtI/Ntp5EyqNZOL8qro8p4YhZRBDpTRSG4UVcspUjUXdxBd2g5enZtNb1w
	MZFBaV+yV8yn+wb55UVxS5BOhfcoZBZKISI2Fzb4adNKT1aBKdIxg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 455cf2q1hn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 11:53:44 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 524Aev4K032243;
	Tue, 4 Mar 2025 11:53:43 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 454cjswdsk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 11:53:43 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 524BreQf47579458
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Mar 2025 11:53:40 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 205A020043;
	Tue,  4 Mar 2025 11:53:40 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7811920040;
	Tue,  4 Mar 2025 11:53:38 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com.com (unknown [9.61.57.16])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Mar 2025 11:53:38 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: ltp@lists.linux.it
Cc: Mimi Zohar <zohar@linux.ibm.com>, Stefan Berger <stefanb@linux.ibm.com>,
        Petr Vorel <pvorel@suse.cz>, linux-integrity@vger.kernel.org
Subject: [PATCH v2 3/4] ima_violations.sh: additional open-writer violation tests
Date: Tue,  4 Mar 2025 06:53:30 -0500
Message-ID: <20250304115331.524842-3-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304115331.524842-1-zohar@linux.ibm.com>
References: <20250304115331.524842-1-zohar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YdbllpIggr-IZ-fqMMGJLyjcHa-9Oe3r
X-Proofpoint-ORIG-GUID: YdbllpIggr-IZ-fqMMGJLyjcHa-9Oe3r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_05,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 spamscore=0 mlxscore=0 bulkscore=0 mlxlogscore=984
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503040097

Kernel patch "ima: limit the number of open-writers integrity
violations" prevents superfluous "open-writers" violations.  Add
corresponding LTP tests.

Link: https://lore.kernel.org/linux-integrity/20250228205505.476845-2-zohar@linux.ibm.com/
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 .../integrity/ima/tests/ima_violations.sh     | 87 ++++++++++++++++++-
 1 file changed, 86 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
index 3f9f1d342..578cb1402 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
@@ -8,7 +8,7 @@
 
 TST_SETUP="setup"
 TST_CLEANUP="cleanup"
-TST_CNT=3
+TST_CNT=6
 
 REQUIRED_BUILTIN_POLICY="tcb"
 REQUIRED_POLICY_CONTENT='violations.policy'
@@ -61,6 +61,17 @@ close_file_write()
 	exec 4>&-
 }
 
+open_file_write2()
+{
+	exec 5> $FILE || tst_brk TBROK "exec 5> $FILE failed"
+	echo 'test writing2' >&5
+}
+
+close_file_write2()
+{
+	exec 5>&-
+}
+
 get_count()
 {
 	local search="$1"
@@ -161,6 +172,80 @@ test3()
 	tst_sleep 2s
 }
 
+test4()
+{
+	tst_res TINFO "verify limiting single open writer violation"
+
+	local search="open_writers"
+	local count num_violations
+
+	read num_violations < $IMA_VIOLATIONS
+	count="$(get_count $search)"
+
+	open_file_write
+	open_file_read
+	close_file_read
+
+	open_file_read
+	close_file_read
+
+	close_file_write
+
+	validate "$num_violations" "$count" "$search" 1
+}
+
+test5()
+{
+	tst_res TINFO "verify limiting multiple open writers violations"
+
+	local search="open_writers"
+	local count num_violations
+
+	read num_violations < $IMA_VIOLATIONS
+	count="$(get_count $search)"
+
+	open_file_write
+	open_file_read
+	close_file_read
+
+	open_file_write2
+	open_file_read
+	close_file_read
+	close_file_write2
+
+	open_file_read
+	close_file_read
+
+	close_file_write
+
+	validate "$num_violations" "$count" "$search" 1
+}
+
+test6()
+{
+	tst_res TINFO "verify new open writer causes additional violation"
+
+	local search="open_writers"
+	local count num_violations
+
+	read num_violations < $IMA_VIOLATIONS
+	count="$(get_count $search)"
+
+	open_file_write
+	open_file_read
+	close_file_read
+
+	open_file_read
+	close_file_read
+	close_file_write
+
+	open_file_write
+	open_file_read
+	close_file_read
+	close_file_write
+	validate "$num_violations" "$count" "$search" 2
+}
+
 . ima_setup.sh
 . daemonlib.sh
 tst_run
-- 
2.48.1


