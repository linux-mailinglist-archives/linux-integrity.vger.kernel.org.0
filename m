Return-Path: <linux-integrity+bounces-4933-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9D6A3DFEA
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 17:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CADE77A9D63
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 16:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6992E1FF1DC;
	Thu, 20 Feb 2025 16:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="izQqHok8"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC681CA84
	for <linux-integrity@vger.kernel.org>; Thu, 20 Feb 2025 16:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740067273; cv=none; b=r1ig7ZUa9Xhsr71MRWVtn67iK/anMGUAybgOUiYWt8WvmNi2qVJ9De6lhhJz1pzgy1MREhaX4TRapqsn2q8pKui/sW5WhO15qAEEdGL+OBf5zlSQ7PkDIG64CXKKxeJg85wIjXgrxCbtV1N5JsnrBe3etXzDlKhl4D1CYUZf1JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740067273; c=relaxed/simple;
	bh=Hb5WEoeqD5+0JRtMRFMJkF4PrBhx81bCPCqnYfGsF7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZTaVQVp+FbcpqoqEyNR/3DMSA0dyrxtZGzGkUFsX75veUxeU6pCwUcJ6Fvr2Vly5XEyrbYsA9Tj8ZuGaHaxNvK4sydL/kV8vrOjFn8NUkOwCA/30sD5XSu4wEdntytyZVnC58S6nZQvg14Om/iacy1TQxSOVgw+i75hZGnztB+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=izQqHok8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KChoQ1002255;
	Thu, 20 Feb 2025 16:01:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=rbxod9JTGJoVOfBeZ
	k/WaVpR0qDcIB1nEh0Q2tRv6Cg=; b=izQqHok8jSfFFlqiVVKXrazRb7VDcvmTF
	2iGfg4g/YS/SVpF/qDmXSB2r7b7mwq5P5IJikLcjJq5FQwdoZAJpgsWbpUrkSvAc
	OFv0ciDQzR16Cc2UAe3WVQgDRhm+EQhiFEk1WfndaR97b6eXvrgX3HoDdLD/Rb1A
	ZXV5CqqbOPcwU0DfHgyJbIQj0XP4Xz1PzcsYIDAwJIpI3/i8T7Bj7p0HVm8TwlCU
	UqXGF979pxA7Frh7efbC2aIzROni7vXw8OFgOWmBz3lYNorPPY/IAxheVoCqS9BK
	TQCiOHzs31QMHjiMsCgLPiB6DJSDxzkPDY6r6TVCtM3hAirOYkgOQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44wtfa3vxf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 16:01:05 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51KEt3kl009691;
	Thu, 20 Feb 2025 16:01:04 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44w03yauc6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 16:01:04 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51KG10A547972822
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 16:01:00 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C7A0E20043;
	Thu, 20 Feb 2025 16:01:00 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 71FE520040;
	Thu, 20 Feb 2025 16:00:59 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com.com (unknown [9.61.68.26])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Feb 2025 16:00:59 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org, ltp@lists.linux.it
Cc: Mimi Zohar <zohar@linux.ibm.com>, Stefan Berger <stefanb@linux.ibm.com>,
        Petr Vorel <pvorel@suse.cz>
Subject: [RFC PATCH 2/3] ima: additional open-writer violation tests
Date: Thu, 20 Feb 2025 11:00:53 -0500
Message-ID: <20250220160054.12149-2-zohar@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: RRJqZnyL4wCpdTttUCOXzBT53TClYZkP
X-Proofpoint-GUID: RRJqZnyL4wCpdTttUCOXzBT53TClYZkP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_06,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=905
 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502200113

Kernel patch "ima: limit the number of open-writers integrity
violations" prevents superfluous "open-writers" violations.  Add
corresponding LTP tests.

Link: https://lore.kernel.org/linux-integrity/20250219162131.416719-2-zohar@linux.ibm.com/
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 .../integrity/ima/tests/ima_violations.sh     | 87 ++++++++++++++++++-
 1 file changed, 86 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
index 7f0382fb8..65c5c3a92 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
@@ -8,7 +8,7 @@
 
 TST_SETUP="setup"
 TST_CLEANUP="cleanup"
-TST_CNT=3
+TST_CNT=6
 
 REQUIRED_BUILTIN_POLICY="tcb"
 REQUIRED_POLICY_CONTENT='violations.policy'
@@ -60,6 +60,17 @@ close_file_write()
 	exec 4>&-
 }
 
+open_file_write2()
+{
+	exec 5> $FILE || exit 1
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
@@ -160,6 +171,80 @@ test3()
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
+	validate $num_violations $count $search 1
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
+	validate $num_violations $count $search 1
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
+	validate $num_violations $count $search 2
+}
+
 . ima_setup.sh
 . daemonlib.sh
 tst_run
-- 
2.48.1


