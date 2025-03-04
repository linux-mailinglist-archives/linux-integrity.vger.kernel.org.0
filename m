Return-Path: <linux-integrity+bounces-5057-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 723E2A4DD1A
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Mar 2025 12:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 929D9176FB8
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Mar 2025 11:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F062010E3;
	Tue,  4 Mar 2025 11:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kke0AGF2"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A2E202C5B
	for <linux-integrity@vger.kernel.org>; Tue,  4 Mar 2025 11:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741089230; cv=none; b=jJjuLZyxgGiXu0QdtTbVp4fqZmdc3cKhSjLdfE65+Y6azhJW6Th/tFjWLngkhHr6opRwz11eI3dXq37EGUZaY0+QW4T09MbLze+SHiK6Ay7MZ9svbw1bFXNNEZJaI785FU0jUW1GCbgH6eiReI1b2JVqB4n9KbRVBe/5Q5PD1tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741089230; c=relaxed/simple;
	bh=kC4I24yg/57i4jz5Qvuppecn7O/o0HYaOR7Lc1nz6j8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hse+TxrkDt6j+6mtA3H0Q4CtbEAnwTQnoBQyXK1yzYfa49wfxJKTJyX72o7MKm8AQ7N76Akom/mvKd7i1Gp+ST5D+D6UQ9Njz4mawWeXP0uV+NIE7Pk6sSkPrVJSSNr8+0u+wFpZCSyHOs4c9pYUpwH0Yt/Io30yXZoEWOYZbW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kke0AGF2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5249aV82019982;
	Tue, 4 Mar 2025 11:53:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=QGbeJRF925HXWhPNN
	J8aV16aHxXe85Vff5z/3n8rWIQ=; b=kke0AGF2rE4KtNYGA4qYAyWq6ad9bSVzG
	40BYwxyQOwGjro+tAETN/IthwJmdy2paMpWwSPzfdlpcwyHPVc1Wrb1xE3H6VnrS
	phjqlWIuaJDedsrBB6ZI/OCu7vkVz93aN6MUNAEKKpr26l9CHT2mkgo2vpILKtCA
	vOhliBgWl4hOuSoQNdAhLs3XsYX8sMqhnoOhWx41ZiDGqh3sDbdwM73SKufD0gyC
	LN9nAMv0YIbrnkKhnoVFKcLqMD4l2rZ7bZS4t3iXYRunTGa4I0LtLS7/OqzI42wR
	4rDhwsafb8mUiTWoKXcPPmGG3cee+iOvYZHulCF6gYEZGgh9Li2CA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 455kmyknst-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 11:53:42 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5249OKNA020877;
	Tue, 4 Mar 2025 11:53:41 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 454esjvvhp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 11:53:41 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 524Brcsc46858514
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Mar 2025 11:53:38 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1701D20043;
	Tue,  4 Mar 2025 11:53:38 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C45E20040;
	Tue,  4 Mar 2025 11:53:36 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com.com (unknown [9.61.57.16])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Mar 2025 11:53:36 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: ltp@lists.linux.it
Cc: Mimi Zohar <zohar@linux.ibm.com>, Stefan Berger <stefanb@linux.ibm.com>,
        Petr Vorel <pvorel@suse.cz>, linux-integrity@vger.kernel.org
Subject: [PATCH v2 2/4] ima_violations.sh: Update validate() to support multiple violations
Date: Tue,  4 Mar 2025 06:53:29 -0500
Message-ID: <20250304115331.524842-2-zohar@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: YDGoMroYa3wtpnbpN-USTH_EBYSyU7Xp
X-Proofpoint-GUID: YDGoMroYa3wtpnbpN-USTH_EBYSyU7Xp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_05,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=945
 priorityscore=1501 bulkscore=0 impostorscore=0 lowpriorityscore=0
 mlxscore=0 malwarescore=0 clxscore=1015 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503040097

Add support for the number of expected violations.  Include the
expected number of violations in the output.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 .../security/integrity/ima/tests/ima_violations.sh     | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
index 22863fb72..3f9f1d342 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
@@ -72,20 +72,26 @@ validate()
 	local num_violations="$1"
 	local count="$2"
 	local search="$3"
+	local expected_violations="$4"
 	local max_attempt=3
 	local count2 i num_violations_new
 
+	[ -z "$expected_violations" ] && expected_violations=1
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
+			tst_res $IMA_FAIL "$search too many violations added: $num_violations_new - $num_violations"
+			return
 		else
 			tst_res $IMA_FAIL "$search violation not added"
 			return
-- 
2.48.1


