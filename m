Return-Path: <linux-integrity+bounces-5115-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAD4A50300
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Mar 2025 16:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D4C51887C1A
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Mar 2025 14:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDB624EAB2;
	Wed,  5 Mar 2025 14:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mtbaNAdb"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B1784D02
	for <linux-integrity@vger.kernel.org>; Wed,  5 Mar 2025 14:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741186478; cv=none; b=QdGQ6mdaEXJRuiJjE2U7bazLqSDmy8sgpLerlSEU6iraORu4sRcxnBEAoQTI8rlWZv8FtBRE3tZGuwl/RlogeOSOva6BUsVGCyyMcYLZpHttRuMDUq6bDQriEGH0Eu8X9pa2ARtthzY5RDg2H0d1QN9kyBh3uVZn/Miwf1QcDVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741186478; c=relaxed/simple;
	bh=GsrXhSENdrMO5MXohV7m3HcfVHNkqHsjudRy/bdUsqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MHYgAIpd5mZISXtDQQfULyQ/pTCL7pSp0d0IQL4AvSnNBIZPqmZQtZv2FAZQstFxlM9XBh8eIgrjKm8mt1BoyT0UuShuWg8tg+by4p+lM789y4pF2Aq7Y7q414JIjqxKvz2EZSoZr/gtMFfIKg61O86q3Hi0i7/phJUMvppWUq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mtbaNAdb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525AJLM9025087;
	Wed, 5 Mar 2025 14:54:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=gC84LdE35S4K++oOO
	gPsesF6e7Hj9gWh2zwcBlqZMa8=; b=mtbaNAdbbr/TAYoQBPiRGbXgLlkccW+jN
	VqxFUaKlV9VPEOm9nDoQIOCMUySW9yFCsC+1K37L2CTQYtz/4h1lRCmV6tOYrZGH
	hd1LP1Mh2tVcfIhlEke2VHwBei/Bk3AJjuxlzOXDqjJy9nvsTrF/joE/WrUVwP0i
	TjjAx8nvDVuSVR1RcQVUWX8BioXIsJwLE4GGNLjAW17HzUqxxuJPa+98g68VRFfs
	VzvgzMmpJYiW1m2+5HnCpX8HWTJg/WV01umnMLSY69OuPkR8hYcxxEYvhyzsng29
	Z29E9OKgBd8IzSFz/vItYPa7pzst8lrhFkzlEV/nd2McO0sVnjAUg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4568x545rk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 14:54:31 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 525BABxF020871;
	Wed, 5 Mar 2025 14:54:31 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454djnkanf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 14:54:31 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 525EsR6t57934102
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Mar 2025 14:54:27 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D04A2004B;
	Wed,  5 Mar 2025 14:54:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 070EC20040;
	Wed,  5 Mar 2025 14:54:26 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com.com (unknown [9.61.124.31])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Mar 2025 14:54:25 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: ltp@lists.linux.it
Cc: Mimi Zohar <zohar@linux.ibm.com>, Stefan Berger <stefanb@linux.ibm.com>,
        Petr Vorel <pvorel@suse.cz>, linux-integrity@vger.kernel.org
Subject: [PATCH v3 2/5] ima_violations.sh: Update validate() to support multiple violations
Date: Wed,  5 Mar 2025 09:54:18 -0500
Message-ID: <20250305145421.638857-2-zohar@linux.ibm.com>
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
X-Proofpoint-GUID: VDHbSiairrhqdRnfPdw1UelQJwUWZpMd
X-Proofpoint-ORIG-GUID: VDHbSiairrhqdRnfPdw1UelQJwUWZpMd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_06,2025-03-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503050114

Add optional support for the number of expected violations.  Include the
expected number of violations in the output.

Limit the new expected violations to the new tests, so that the existing
tests continue to work properly with/without the kernel changes.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 .../security/integrity/ima/tests/ima_violations.sh    | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
index 22863fb72..37bf2182b 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
@@ -72,20 +72,27 @@ validate()
 	local num_violations="$1"
 	local count="$2"
 	local search="$3"
+	local expected_violations="$4"
 	local max_attempt=3
 	local count2 i num_violations_new
 
 	for i in $(seq 1 $max_attempt); do
 		read num_violations_new < $IMA_VIOLATIONS
 		count2="$(get_count $search)"
-		if [ $(($num_violations_new - $num_violations)) -gt 0 ]; then
+		if [ -z "$expected_violations" ] && \
+		   [ $(($num_violations_new - $num_violations)) -gt 0 ] || \
+		   [ $(($num_violations_new - $num_violations)) -eq $expected_violations ]; then
+			[ -z "$expected_violations" ] && expected_violations=1
 			if [ $count2 -gt $count ]; then
-				tst_res TPASS "$search violation added"
+				tst_res TPASS "$expected_violations $search violation(s) added"
 				return
 			else
 				tst_res TINFO "$search not found in $LOG ($i/$max_attempt attempt)..."
 				tst_sleep 1s
 			fi
+		elif [ $(($num_violations_new - $num_violations)) -gt 0 ]; then
+			tst_res $IMA_FAIL "$search too many violations added: $num_violations_new - $num_violations"
+			return
 		else
 			tst_res $IMA_FAIL "$search violation not added"
 			return
-- 
2.48.1


