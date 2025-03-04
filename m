Return-Path: <linux-integrity+bounces-5056-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7CBA4DD1D
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Mar 2025 12:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75FE53A0827
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Mar 2025 11:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06B9201024;
	Tue,  4 Mar 2025 11:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bqPDeVcg"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059B12010F5
	for <linux-integrity@vger.kernel.org>; Tue,  4 Mar 2025 11:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741089229; cv=none; b=rJ5HSPiypg+hZHPHUtlniGUkdFy+ys+ehIkglgx/wrD2EpmmYcI45S+BUsJ3/clQwUgyg3ZneP3hwEaluBqchA2d74YqdO4oG1TdyJpSlDzKGhs/T8p0Dfe5/mPyPnxVhy2NeRUhPT9ubHYnpTsVBc69uQC4s/IoP5XNXZnlx5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741089229; c=relaxed/simple;
	bh=KUo9wQlmv9/QzJPGNoYq36h1ywrzW0R3JyxWK1ltRE0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CK+ThOyML4HyK1NBj4ZTkTlHh1haMkBoP8InvIHgFU7BVI6pgEBFDX9dZs+MMBj4Cdz7fWiWsRfElJW5ljInKgChMhMDtfi7gXizsjq4Ucx9zRjec37ZRQdwaB5ZNIwVMzsL2j0ZFHmRuXsh0oLRUsL0eTiuq+dzHYXh9XRvZ/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bqPDeVcg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5249rK5v026395;
	Tue, 4 Mar 2025 11:53:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=dIsUEWCxqhEdj+mTgGu8xdt/PVIOMBGgS/hEVPIwg
	wE=; b=bqPDeVcga3sKu45+Jkpj/BG9zYMFd7LL1J8CKYJ7UYwjSLMgUjj06AG5g
	yk7OnPgMFzsDm8NI5gnTSJCMXpSEE1Y/SIDD++OewkO6kq/fX6bolxwCwGjeBW7+
	3GnIOmY5XAbUfbbTJ7eCVheuNLoJcwUUpgNws89x/gAIprWtnslmopxazXRJUKil
	sXyv61bTrnTHlmsTGkpzTG4eytwkS2FxUfhHUQDXpRjq2XzvaLe9hc9s8aDUyPdS
	cIZSmbVdViinIb9ZEEvYVzKXeAgY7+1W6FliSCqWx7j008Lkg7CGk+c1Rh4NLxIV
	DfdnW/4YCH4YVIbC2cAshMlohHHvw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 455kkpbncu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 11:53:42 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 524BmaCC020911;
	Tue, 4 Mar 2025 11:53:42 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454djnd73e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 11:53:42 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 524BraBH59572704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Mar 2025 11:53:36 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F72920043;
	Tue,  4 Mar 2025 11:53:36 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 79C6220040;
	Tue,  4 Mar 2025 11:53:34 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com.com (unknown [9.61.57.16])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Mar 2025 11:53:34 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: ltp@lists.linux.it
Cc: Mimi Zohar <zohar@linux.ibm.com>, Stefan Berger <stefanb@linux.ibm.com>,
        Petr Vorel <pvorel@suse.cz>, linux-integrity@vger.kernel.org
Subject: [PATCH v2 1/4] ima_violations.sh: force $LOG ToMToU violation earlier
Date: Tue,  4 Mar 2025 06:53:28 -0500
Message-ID: <20250304115331.524842-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DMPT953wXYhrz0w3Bqn7xhNzyVE7aAN5
X-Proofpoint-ORIG-GUID: DMPT953wXYhrz0w3Bqn7xhNzyVE7aAN5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_05,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0 mlxlogscore=807
 phishscore=0 spamscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503040097

Violation tests are dependent on searching the $LOG file, which may
itself result in a ToMToU violation.  Preempt getting an additional
violation during the tests by forcing the $LOG ToMToU violation
earlier.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 testcases/kernel/security/integrity/ima/tests/ima_violations.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
index 37d8d473c..22863fb72 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
@@ -30,6 +30,7 @@ setup()
 	if [ ! -e "$LOG" ]; then
 		tst_brk TCONF "log file not found, install auditd"
 	fi
+	exec 3< $LOG || tst_brk TBROK "failed to read log file"
 	tst_res TINFO "using log $LOG"
 }
 
-- 
2.48.1


