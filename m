Return-Path: <linux-integrity+bounces-4905-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8D2A3C501
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Feb 2025 17:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0EEA3AD8A6
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Feb 2025 16:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8ADC1FE461;
	Wed, 19 Feb 2025 16:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WzzkmVJJ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D93B1FE44A
	for <linux-integrity@vger.kernel.org>; Wed, 19 Feb 2025 16:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739982433; cv=none; b=FM2Q/9PybdlhnOgAOdvCJ7GEZQE8xrxkVyeO6vhMifrOE1QVSSuN2vmVB34yJM30mh9XfAndv9MgBCoOoKRu8xiWq+tS4alBYibSOX0lIC4OdlWD8aGvzcm9Nz19al0ddDSo8o3F+UJTtI+SpXW7Yha+Sq2OjxTey0d4FVqKkTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739982433; c=relaxed/simple;
	bh=Ym8mOf7SRwVj7efUbWRFWAz5fEDj7LwRC+LXs4EiEBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TrwfMk6PeTEn5m8WaR2eAUJQ90gMDWwnNkAQVPdE8BZQiJewDQBpc09HR3+GDUO6rtbgTSzZw9c1tVTkXH8Taj9YqufJTI4fCgxhKi1115iPPhdR/lI9cSZU3X+SDZM/Znfa70bjMbWoN3tiMvExCXTh2/m0ISM8wWo2uabHhVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WzzkmVJJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JGAk7k027701;
	Wed, 19 Feb 2025 16:21:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=LXIwBUuQtrq3CIchk
	UJhIgPpHJO2a0dXqUi89EtrmDg=; b=WzzkmVJJxMXpn0JQttr7MRNzKY22bwDZu
	0MT4/e3eMpzBt1D8x94eRCamsIotINLtcDid8EO1cjZI06PNxgCRAxBhC/MVDxo4
	DsxbzbYCXTjfGickTl9KgFsggYL54w9x+vcVNI8+EAX5es3/mG+SKEY+mcL24jFH
	k/ufrga2cFQGsbDBDz/pcFvV0LX1CKkVhfhRELxyzpkkqHs9XhCrle0XDIANp5J3
	xk3v8MujHr5q2cmK4ukqEKZg3aUCFYCxK+r9gnaz7q03lLVDLQWbPWkEXwnkLjm+
	c2BGQgkhcJRXIYqBaP+J/DYX87T2S0x0LaHl+UCdkPS5QLjMh2aqQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44w3ba4bpw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 16:21:59 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51JECLQ8027066;
	Wed, 19 Feb 2025 16:21:58 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44w0254ywf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 16:21:58 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51JGLsBh47972708
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 16:21:54 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6409A20043;
	Wed, 19 Feb 2025 16:21:54 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D442820040;
	Wed, 19 Feb 2025 16:21:52 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.fios-router.home (unknown [9.61.30.244])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Feb 2025 16:21:52 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, roberto.sassu@huawei.com,
        Stefan Berger <stefanb@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>
Subject: [PATCH 2/2] ima: limit the number of ToMToU integrity violations
Date: Wed, 19 Feb 2025 11:21:31 -0500
Message-ID: <20250219162131.416719-3-zohar@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: R_4oHfoBZIZA6nHv-JTLT1n1BKNiFeVp
X-Proofpoint-GUID: R_4oHfoBZIZA6nHv-JTLT1n1BKNiFeVp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_07,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=802
 bulkscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502190124

Each time a file in policy, that is already opened for read, is opened
for write a Time-of-Measure-Time-of-Use (ToMToU) integrity violation
audit message is emitted and a violation record is added to the IMA
measurement list, even if a ToMToU violation has already been recorded.

Limit the number of ToMToU integrity violations for an existing file
open for read.

Note: The IMA_MUST_MEASURE atomic flag must be set from the reader side
based on policy.  This may result in a per open reader additional ToMToU
violation.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/ima/ima_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index cde3ae55d654..f1671799a11b 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -129,9 +129,10 @@ static void ima_rdwr_violation_check(struct file *file,
 		if (atomic_read(&inode->i_readcount) && IS_IMA(inode)) {
 			if (!iint)
 				iint = ima_iint_find(inode);
+
 			/* IMA_MEASURE is set from reader side */
-			if (iint && test_bit(IMA_MUST_MEASURE,
-						&iint->atomic_flags))
+			if (iint && test_and_clear_bit(IMA_MUST_MEASURE,
+						       &iint->atomic_flags))
 				send_tomtou = true;
 		}
 	} else {
-- 
2.48.1


