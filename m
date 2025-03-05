Return-Path: <linux-integrity+bounces-5116-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA59A502FE
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Mar 2025 16:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D589189DD0F
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Mar 2025 14:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD5524EA9D;
	Wed,  5 Mar 2025 14:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="igYb5oIt"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97E024DFF4
	for <linux-integrity@vger.kernel.org>; Wed,  5 Mar 2025 14:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741186478; cv=none; b=sUY3n84JhDxyJlCm1NPNDjs6Q/WqjJGEQO2Geitnt3iuTWanmwZ1WeFUwEAn4H2V0ISxQVyImRWlOql6APsIQD4zSdCnHH3Nf8AZCaDdW1X8fo7EcL5RawAZnWFvKSFs1YZgoWbV7NipaH1NDF1ih8JBj0+IceUbH7PRGrYeIUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741186478; c=relaxed/simple;
	bh=KUo9wQlmv9/QzJPGNoYq36h1ywrzW0R3JyxWK1ltRE0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VkwsxP+xSxiZNVidlVbgGvLP3p1o9/wI/A89GJMZZTV5ak300BiO25u8HEETevobBCkDM5aplCRbB4ORaZeoFyuTwx/aHCRP1hqxloTqtvfvYcNItgF1hPS9CZC/KXVjslNSUjVx6x+7Io1InQQn72gFjdz4Uh11mndKJF/eq6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=igYb5oIt; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525CSVob032499;
	Wed, 5 Mar 2025 14:54:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=dIsUEWCxqhEdj+mTgGu8xdt/PVIOMBGgS/hEVPIwg
	wE=; b=igYb5oItdSb0xnE+GdQpgH9i320UNZefULGnQaraOpVyR2swfTVobD4bM
	x4wTS6/RW4IdswzkCxdWJ//JiDiIjGEU7gX9JqXarzQHOCKGY1zuB3Wb6Kvghcil
	hLwCGYVTjZqzQnkBiUhsUAcFAapQcp2fIfsxIGfPalbguti+O5LXA3wJv4d0jQEa
	7lmSO4kuun00OpyRuWn9b0aMdOr/og66VsuXi9hYuu5e0bE+59AZX5wB2+dQpGoc
	r4ecl2YC3dfdOKzLqB14Y/SJJBppRCJ2kpgUYZmXTual/RrM/UIXFdo88OHr1b0w
	GFuHeLwJ2zspEIwfg2xszZTL33EAA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 456pnarqdh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 14:54:30 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 525EVnfb009015;
	Wed, 5 Mar 2025 14:54:29 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454cxyke6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 14:54:29 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 525EsPt656230392
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Mar 2025 14:54:25 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC2EF2004B;
	Wed,  5 Mar 2025 14:54:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F8D320040;
	Wed,  5 Mar 2025 14:54:24 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com.com (unknown [9.61.124.31])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Mar 2025 14:54:23 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: ltp@lists.linux.it
Cc: Mimi Zohar <zohar@linux.ibm.com>, Stefan Berger <stefanb@linux.ibm.com>,
        Petr Vorel <pvorel@suse.cz>, linux-integrity@vger.kernel.org
Subject: [PATCH v3 1/5] ima_violations.sh: force $LOG ToMToU violation earlier
Date: Wed,  5 Mar 2025 09:54:17 -0500
Message-ID: <20250305145421.638857-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 08Wrky9M1XQegqMomOuHwtwvuqwf27t1
X-Proofpoint-GUID: 08Wrky9M1XQegqMomOuHwtwvuqwf27t1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_06,2025-03-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=806
 bulkscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503050114

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


