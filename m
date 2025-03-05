Return-Path: <linux-integrity+bounces-5119-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBC3A502F6
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Mar 2025 16:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C0AF16373B
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Mar 2025 14:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88AC248885;
	Wed,  5 Mar 2025 14:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KsCJJDF7"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA8524C073
	for <linux-integrity@vger.kernel.org>; Wed,  5 Mar 2025 14:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741186483; cv=none; b=NzsfWUjgG3eYKWciqdL/Wr/TZhN5qa0uSkF0eYQj6ifcSn420YX/RpojOIzo/pyz3sTKg7gCaFhz8g3lYAXKtFWbpMOwcES79MdLrrP4ve+greA/A4lTGaSZ6XxCU9uSZ2civ3IZZ1m+EWdJ8PI3y6IRsN8GXVeQDR6NmfHEivE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741186483; c=relaxed/simple;
	bh=WcT6gW3waZSLQDz9wvyo03jU/ECl597orI3QxOjn2b4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A13o7Y4EQapwv84rGGRWPtsg59C57PfSMmbUbca+JXT3SQpOCrV2A0ve0X9p+rxtNUqQcaVk0hlZQihexWdmDB0kzsS7WrfM6BlyfP1DWim2jsOE5viBLgOeQiZqiIGuBQ2WVR3yywV3qlSi/MUiDkz94Wpz/kV1weUDxZM9/fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KsCJJDF7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525ArSPg008101;
	Wed, 5 Mar 2025 14:54:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=yHHRBDZIJVgbFSknx
	YrXzeJC0MQmU4oIq3enwGgiPx8=; b=KsCJJDF7LrwhTFUDWgme2BrM0WaiOSB7E
	rpY+WFnzoeaotqTkhPvuUfVjjPOpX8AmSa9FStCZX98wGo8Sz2r2XJ8Av+DoGPOe
	cVllZrCMaQQzcmRyRIbxHantxLeSTJVilCSXHB3yNuDgrH5u71Y94fVBvzKEWqjC
	95l4NVH91sAVHdJCHHtc9CNNAzhysnPIStfuCSV1/Z/Ma/UdOC3G4TUcfqztpAms
	1RkZ4O2mTNz/W4NTEFy0Xqpx4CbK/r675FvqhzY8IkLE4i5LLqQTjubXeBEAXXFK
	RxqPDMHGN8IskIMxkUhXMSKdXvfxYOt+qssSkpzzAUmm1Ul1yjVew==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4568ppc75q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 14:54:37 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 525BLN9v020841;
	Wed, 5 Mar 2025 14:54:37 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454djnkanu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 14:54:37 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 525EsXED13304092
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Mar 2025 14:54:33 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7734F20043;
	Wed,  5 Mar 2025 14:54:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B55D220040;
	Wed,  5 Mar 2025 14:54:31 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com.com (unknown [9.61.124.31])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Mar 2025 14:54:31 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: ltp@lists.linux.it
Cc: Mimi Zohar <zohar@linux.ibm.com>, Stefan Berger <stefanb@linux.ibm.com>,
        Petr Vorel <pvorel@suse.cz>, linux-integrity@vger.kernel.org
Subject: [PATCH v3 5/5] ima_violations.sh: require kernel v6.14 for minimizing violations tests
Date: Wed,  5 Mar 2025 09:54:21 -0500
Message-ID: <20250305145421.638857-5-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305145421.638857-1-zohar@linux.ibm.com>
References: <20250305145421.638857-1-zohar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4KSx66GJD6S1wY-3ISK4BhfUVdxi_uHn
X-Proofpoint-ORIG-GUID: 4KSx66GJD6S1wY-3ISK4BhfUVdxi_uHn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_06,2025-03-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 mlxscore=0 impostorscore=0 adultscore=0 priorityscore=1501 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503050114

Depending on the IMA policy and the number of violations, the kernel
patches for minimizing the number of open-writers and ToMToU (Time of
Measure Time of Use) violations may be a major performance improvement.

Most likely the kernel patches will be back ported, but for now limit
the new tests to new kernels with the applied patches.  Bail after the
first new test.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 .../kernel/security/integrity/ima/tests/ima_violations.sh     | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
index 0395f8d0a..8e988fca6 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
@@ -177,6 +177,10 @@ test4()
 {
 	tst_res TINFO "verify limiting single open writer violation"
 
+	if tst_kvcmp -lt 6.14; then
+		tst_brk TCONF "Minimizing violations requires kernel 6.14 or newer"
+	fi
+
 	local search="open_writers"
 	local count num_violations
 
-- 
2.48.1


