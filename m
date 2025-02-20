Return-Path: <linux-integrity+bounces-4932-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 700C5A3DFE9
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 17:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D817A7AF2C5
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 16:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473E91D5CF9;
	Thu, 20 Feb 2025 16:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DiwK+xxo"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CD41CA84
	for <linux-integrity@vger.kernel.org>; Thu, 20 Feb 2025 16:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740067271; cv=none; b=Lmb/IyuxKqDp0elj0Hu/SkNg0OQzESeiZcWcv7tPHJf5Fg2CPasX8Q6g0QvmBSEBjYVzQU8pP61KT/OOhM3Fy6dAEB1OjvzyVLY2JJ3z+MNTlxo8kcJYv5qCJnDBXaKyUarel6DnOwIBLxc6iVSPA2+MECa5J5bY/W2NuPjGkLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740067271; c=relaxed/simple;
	bh=x1lUNsbMx24UZVy2pAKQl+kkCz6RaD5eGaWkv7CCrTc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kUgsM6FcKzq2fSyoavHE0TxqGbI00+jkH45uaeGeKwCRlSBRyEFeiVK0DMaqxgP0rnw8Zd5vzwHeQNtqUuWfUQwLQNYYFn4pb2RQZGfx1KGK9zWuOahZiqmV1SsKN2ELltU7Cowzuw6zfalOAAAMURK6Kk7q64ew1pKgskRrspc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DiwK+xxo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KD5dGu002208;
	Thu, 20 Feb 2025 16:01:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ZBaeMWKBnDCdyczPSP1LPCqo8qHfeKkPSJaoyxEDx
	yA=; b=DiwK+xxofEyTygsYWneuMF9vldkaSl4dKeu1q+t/WL0RA70CLo/biYuuT
	EDSexpL77QEIkJT9VWPdndLl6fjLFN5g8409ahevaeNXSxaiRirjFDxCjH79ZgKo
	pb17sz+fl5duneWZeHMvANJXZSv96JkIRnKVcC9j0d98bNuNk+DU890y6QAu3id6
	mDVMy1064EFEAuvqJJINq7OwIALNgJUA/cy+nUdtcrkqoslV0YV8F6OkY8uvgVze
	RwKOq2vvJF5vxw+pTTDT6V/Jy+p9lL1fizsnWpuC3LGjFNdkp+WGIsSJw4znBLz5
	ENriXpYS/Rsi8uUMGr6yWLklszvAg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44wtfa3vx9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 16:01:03 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51KFIsv9002297;
	Thu, 20 Feb 2025 16:01:02 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44w03xasmh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 16:01:02 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51KG0xYf35258720
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 16:00:59 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E93F20040;
	Thu, 20 Feb 2025 16:00:59 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B3A720043;
	Thu, 20 Feb 2025 16:00:57 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com.com (unknown [9.61.68.26])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Feb 2025 16:00:57 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org, ltp@lists.linux.it
Cc: Mimi Zohar <zohar@linux.ibm.com>, Stefan Berger <stefanb@linux.ibm.com>,
        Petr Vorel <pvorel@suse.cz>
Subject: [RFC PATCH 1/3] Update validate() to support multiple violations
Date: Thu, 20 Feb 2025 11:00:52 -0500
Message-ID: <20250220160054.12149-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: dHQh1-JARp1NtoejAZc0jPExh8WTLmfC
X-Proofpoint-GUID: dHQh1-JARp1NtoejAZc0jPExh8WTLmfC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_06,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=865
 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502200113

Add support for the number of expected violations.  Include the
expected number of violations in the output.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 .../security/integrity/ima/tests/ima_violations.sh     | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
index 37d8d473c..7f0382fb8 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
@@ -71,20 +71,26 @@ validate()
 	local num_violations="$1"
 	local count="$2"
 	local search="$3"
+	local expected_violations=$4
 	local max_attempt=3
 	local count2 i num_violations_new
 
+	[ -z $expected_violations ] && expected_violations=1
+
 	for i in $(seq 1 $max_attempt); do
 		read num_violations_new < $IMA_VIOLATIONS
 		count2="$(get_count $search)"
-		if [ $(($num_violations_new - $num_violations)) -gt 0 ]; then
+		if [ $(($num_violations_new - $num_violations)) -eq $expected_violations ]; then
 			if [ $count2 -gt $count ]; then
-				tst_res TPASS "$search violation added"
+				tst_res TPASS "$expected_violations $search violation(s) added"
 				return
 			else
 				tst_res TINFO "$search not found in $LOG ($i/$max_attempt attempt)..."
 				tst_sleep 1s
 			fi
+		elif [ $(($num_violations_new - $num_violations)) -gt 0 ]; then
+			tst_res $IMA_FAIL "$search too many violations added"
+			return
 		else
 			tst_res $IMA_FAIL "$search violation not added"
 			return
-- 
2.48.1


