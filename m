Return-Path: <linux-integrity+bounces-4934-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C65A3DFB2
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 17:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EBCE1884A56
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 16:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C221FF1AD;
	Thu, 20 Feb 2025 16:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S6bLBx9i"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725D81FF7B7
	for <linux-integrity@vger.kernel.org>; Thu, 20 Feb 2025 16:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740067275; cv=none; b=ZcInrWLTaU2OhnbleVBtwXLxLoV4bjvqOAjySC3ydhd62M34d+RWuMKnKviwvrDFrxqxiwaf/uAb5mR5yO6KPmGibFVYQt2NazfxmOE3v/j7uCZ7WIsHz7V8zFDS+cfmNt+qQ9YVfZg4DfOnLN+yjkNvkaEIjNuaJszC+wNfguc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740067275; c=relaxed/simple;
	bh=cLwAVuRJv8oolEMtxUlGLIdbmqTU2Q4EO9ve85wejxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AhlEt4EXZbHp5bvw7r7MKwEEpmA8ujErIZboBAsmLJi4YVTGiYulBRjw5ju+u4LBdHD/C9fT0VlXQ+y8EuMpsIaPOYcR8eYr5K9f5FGGETkL9VnmtVeSC9RRrGvEZ0K/s75AXwj9rzxEZaSDSkUOBamqDrMBUu9B+0MJlRy9vsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S6bLBx9i; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51K7Wq9X008224;
	Thu, 20 Feb 2025 16:01:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=/UUSWhrXooLS6NXNd
	9cpiIivxQgEZ21j5nQ3LsB5ejY=; b=S6bLBx9iByg2yta8dal8xykRi8w9pb3dV
	esJKVsZxhvJSpjBrfXrfkxqZJv9gW/mNuiKryLE3nNMqqze817nNSMWm0ILKB/Nb
	szq0i5b2ehzgftNbbDe3PO56Py0nsIgYwKUpAsFBsVQvcZhzXxsGr11e39DR2YGx
	OVMOZLtILKt5mHfPMB31Agtaxi6WTjbWkECo9rAKAhhWwG8LVseAR7xGOCMRpBgC
	RjLa7yKD/FpehA+w0J0nX+UtNZ3nfukWzBMEojs39y8wL+9xrqnXCEOhNIjg6Dwj
	9IgBP0uUHqcmNq9qU3GQS6DNjrVxPSBi9xZQtwNfQfaV5XcnF+4Kw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44x03qthka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 16:01:07 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51KF7x6T005771;
	Thu, 20 Feb 2025 16:01:06 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44w02xjtj8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 16:01:06 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51KG125G43516188
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 16:01:02 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D41420043;
	Thu, 20 Feb 2025 16:01:02 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 337E820040;
	Thu, 20 Feb 2025 16:01:01 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com.com (unknown [9.61.68.26])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Feb 2025 16:01:00 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org, ltp@lists.linux.it
Cc: Mimi Zohar <zohar@linux.ibm.com>, Stefan Berger <stefanb@linux.ibm.com>,
        Petr Vorel <pvorel@suse.cz>
Subject: [RFC PATCH 3/3] ima: additional ToMToU violation tests
Date: Thu, 20 Feb 2025 11:00:54 -0500
Message-ID: <20250220160054.12149-3-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250220160054.12149-1-zohar@linux.ibm.com>
References: <20250220160054.12149-1-zohar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tbRq0PLQX38hTjWatrv4JsZBqxCpznMF
X-Proofpoint-ORIG-GUID: tbRq0PLQX38hTjWatrv4JsZBqxCpznMF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_06,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 phishscore=0 mlxlogscore=581 impostorscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502200113

Kernel patch "ima: limit the number of ToMToU integrity violations"
prevents superfluous ToMToU violations.  Add corresponding LTP tests.

Link: https://lore.kernel.org/linux-integrity/20250219162131.416719-3-zohar@linux.ibm.com/
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 .../integrity/ima/tests/ima_violations.sh     | 46 ++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
index 65c5c3a92..5b6d7e993 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
@@ -8,7 +8,7 @@
 
 TST_SETUP="setup"
 TST_CLEANUP="cleanup"
-TST_CNT=6
+TST_CNT=8
 
 REQUIRED_BUILTIN_POLICY="tcb"
 REQUIRED_POLICY_CONTENT='violations.policy'
@@ -245,6 +245,50 @@ test6()
 	validate $num_violations $count $search 2
 }
 
+test7()
+{
+	tst_res TINFO "verify limiting single open reader ToMToU violations"
+
+	local search="ToMToU"
+	local count num_violations
+
+	read num_violations < $IMA_VIOLATIONS
+	count="$(get_count $search)"
+
+	open_file_read
+	open_file_write
+	close_file_write
+
+	open_file_write
+	close_file_write
+	close_file_read
+
+	validate $num_violations $count $search 1
+}
+
+test8()
+{
+	tst_res TINFO "verify new open reader causes additional ToMToU violation"
+
+	local search="ToMToU"
+	local count num_violations
+
+	read num_violations < $IMA_VIOLATIONS
+	count="$(get_count $search)"
+
+	open_file_read
+	open_file_write
+	close_file_write
+	close_file_read
+
+	open_file_read
+	open_file_write
+	close_file_write
+	close_file_read
+
+	validate $num_violations $count $search 2
+}
+
 . ima_setup.sh
 . daemonlib.sh
 tst_run
-- 
2.48.1


