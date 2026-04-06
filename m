Return-Path: <linux-integrity+bounces-9128-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGu6G7L50mk3cwcAu9opvQ
	(envelope-from <linux-integrity+bounces-9128-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 06 Apr 2026 02:09:22 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0603C3A0CF2
	for <lists+linux-integrity@lfdr.de>; Mon, 06 Apr 2026 02:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7034C300576C
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Apr 2026 00:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF38C1E4BE;
	Mon,  6 Apr 2026 00:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LvCfdJtK"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E75CE571
	for <linux-integrity@vger.kernel.org>; Mon,  6 Apr 2026 00:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775434111; cv=none; b=btmO7dPESkH+G1qVpg2h8GQ6e0YycPfjlATXQ7554/I98Lm9arYhmCG/6YtJM1MZyApVwyQNX2AbQMgOGhsjGz3W7fWuFuZ4q6/7xO02PN0OvE0HDn9ZHBNrY/LfN0s9bABmeoqZzk/ZfkSDMBpOsOvhA5y3xl3K2p8Yli/j5XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775434111; c=relaxed/simple;
	bh=ZRNS5PGLOJA/qwmcQx7ZVVCjrkn2Z3cvYvTAKpRxW4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BaoZIxmKwR/Nng+9XcLR53YguQaF3/MQc56MDGDIpG4bwdQydyyOQ3aA92HJzRdEVQ6WmzraLS73sUWO175o2Y9Adb3i1DtCHr64DRhKiCS7houOAWG1CFK90lvrNSc9xCX2otUqzDtlY/hgap3HDPJ/Pk90VyxdxsYC1sb/KCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LvCfdJtK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 635NLfvA3739068;
	Mon, 6 Apr 2026 00:08:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=TPv5/wDJAqLhJ632g
	Gt3pN7QgqKwb3sWVjs853yWPuI=; b=LvCfdJtKJb605kjSJ56k02MQ8qwfIVNvG
	YLzxhDisV5FVVm0a03AGWA/ZVFAymwb9mnt6qLFlU4iYeDwa8tOd31Gx6zxvWXcL
	w+sej3Yj3vcATzLTF86xAmewh2vqXNYd9GNWB1SBXibLWNCvGs6khoeJJGIVUzoj
	WFL1SXynqgJPzcSRVgp5VsmROKy71OulUQSTU1lQRD5HVAK+Zgtb3aqLvxZJVnus
	tN0UDLMfdOWg0JGpgPymK/UnyWAJ2Pfpja7+MSAt8WhSzi488CChg3Ib48iyi0nL
	GxUPG6cpyXUz42t1qilqHdADUlW9g9RYBhsfkCn8t0bbkqzZ9MXvg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4das2bvcba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Apr 2026 00:08:19 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 635Lu8jk018534;
	Mon, 6 Apr 2026 00:08:18 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dbcystxcv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Apr 2026 00:08:18 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63608Hqs57737496
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Apr 2026 00:08:17 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B23DA58059;
	Mon,  6 Apr 2026 00:08:17 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5372458057;
	Mon,  6 Apr 2026 00:08:17 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Apr 2026 00:08:17 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com, ebiggers@kernel.org,
        coxu@redhat.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [ima-evm-utils PATCH 1/5] checkpatch: Remove warning when function name is found in output string
Date: Sun,  5 Apr 2026 20:08:06 -0400
Message-ID: <20260406000810.4013201-2-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260406000810.4013201-1-stefanb@linux.ibm.com>
References: <20260406000810.4013201-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -ywuuoXWlY-1gEJ4ob5ppUJGd9CKwUJO
X-Proofpoint-GUID: -ywuuoXWlY-1gEJ4ob5ppUJGd9CKwUJO
X-Authority-Analysis: v=2.4 cv=U9qfzOru c=1 sm=1 tr=0 ts=69d2f973 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=hv_n9tJQjeaGP512:21 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=lEOkgapyWCVQAhMLw5AA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA1MDI0NyBTYWx0ZWRfXze+zYKfAtowJ
 N2ZZSYFnqBpI0w91dVlIPujZhNk44EUapb3O63lRrJLl+hZJguw3g12ncZGX8pWoL0E1Iy/vYNb
 6orGDQY4AMz33iHtOIXsSMW/0BitoZty4snyv3w7d77/kZiL40R51qcrwSgt9PD20V9hefM+l7G
 ZE70CMaXP5JaRgVJQetWhG1wLtTJNk5vQwtKVzfOF9Pz3METTxM6Aw1T7OwniLzde3b1edEhLB8
 vKOeUzApP6esbMCIS8wZ83rt4sYMQ6iUb2KhiO4eBwjsUxE0duK89PTkMSSfjFO2UHe59EBCUsn
 FiBPs6StalFnhYgmHgX5+tqKVYxCMyjjuUMYio2Q+3NYW+824ePhVcLzCMUybaSi8QaRMZh3WIi
 XtfhtSDXX9/aW+YOcG8xT6b8gYePEcokAIXvXDwVi8+e6lI700knxB38yRBe1+at57OeKdQ9AVs
 rzxZBv8xfI4PgNscgWw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-05_08,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 clxscore=1015 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604050247
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9128-lists,linux-integrity=lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[stefanb@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.ibm.com:mid];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 0603C3A0CF2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Remove the following type of warning:

WARNING: Prefer using '"%s...", __func__' to using 'create_sigv3_mldsa', \
   this function's name, in a string

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 scripts/checkpatch.pl | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 3d22bf8..f9553be 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6285,13 +6285,13 @@ sub process {
 # This does not work very well for -f --file checking as it depends on patch
 # context providing the function name or a single line form for in-file
 # function declarations
-		if ($line =~ /^\+.*$String/ &&
-		    defined($context_function) &&
-		    get_quoted_string($line, $rawline) =~ /\b$context_function\b/ &&
-		    length(get_quoted_string($line, $rawline)) != (length($context_function) + 2)) {
-			WARN("EMBEDDED_FUNCTION_NAME",
-			     "Prefer using '\"%s...\", __func__' to using '$context_function', this function's name, in a string\n" . $herecurr);
-		}
+#		if ($line =~ /^\+.*$String/ &&
+#		    defined($context_function) &&
+#		    get_quoted_string($line, $rawline) =~ /\b$context_function\b/ &&
+#		    length(get_quoted_string($line, $rawline)) != (length($context_function) + 2)) {
+#			WARN("EMBEDDED_FUNCTION_NAME",
+#			     "Prefer using '\"%s...\", __func__' to using '$context_function', this function's name, in a string\n" . $herecurr);
+#		}
 
 # check for unnecessary function tracing like uses
 # This does not use $logFunctions because there are many instances like
-- 
2.53.0


