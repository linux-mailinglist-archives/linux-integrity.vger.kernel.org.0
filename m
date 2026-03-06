Return-Path: <linux-integrity+bounces-8939-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kA32Eckkq2n6aAEAu9opvQ
	(envelope-from <linux-integrity+bounces-8939-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 06 Mar 2026 20:02:33 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3221226E5F
	for <lists+linux-integrity@lfdr.de>; Fri, 06 Mar 2026 20:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBB5C304B00B
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Mar 2026 19:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BBF7081E;
	Fri,  6 Mar 2026 19:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Qzb0QqRv"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBD536C0AA
	for <linux-integrity@vger.kernel.org>; Fri,  6 Mar 2026 19:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772823721; cv=none; b=eMi4lhY2apzlqsVXYEnHqtr11a1Ie8pJWTMRycTu3S3Jg0bJHIrdUV9PHk8x1PvqHKG5yrL/mcYEYWNIrn6AO4jHEykOdGBbmjxO+eP41RhrtEi25Rb5eh4gAlCb94qZBof3xgwGNzI+72NzHkoeNtzMpHsA35L0ABUIM1TO9Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772823721; c=relaxed/simple;
	bh=Sc0oRSnlXB/lp8XmOU5+qsZYPl6xHE62APL/ybxXreY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qT6PFD7dvEBScrrUFQNDepHfmhCGQirGMFx1mRAXdfEWaO/2lwTAviC7MHVexOTEF+lu2Ts0hAj0JrSYQ6j/IUnnGRH7I9bjvf/r3YYpazFVNWWtNCxhngmaM7KfQB4y1kC2BP9IZk20iTe6LENinrpmcyf+ijxBu0Ab4Cs5ZzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Qzb0QqRv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 626DU85E141670;
	Fri, 6 Mar 2026 19:01:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=C2opuEzOBJERUntLbN0vdssD8YDB6WBef1Eg8vlhI
	50=; b=Qzb0QqRv/zMyQ6TJpS7QPLUUYuGFBKyuN2+20zJIHN0bqWQ3SEWSBxtkx
	NYyDvSIa7M7uqbXYC0lkLzKEfZy5r2+CTLMj+vWwO8gctc8eQ5z+jwkyf0K13Ame
	qp1ZM8yRzWA3TNRlDnHYu1M3BHmw7gjQF9+wxpQxRQHjBVrvYloMJgOpK/qsfVcK
	/3Bi4F9wMuPOnkCi7auX3wCjnuFjKLgGXCFLmqBDDo8As+MuXEo4PY0ndsHMVmV0
	eO/05LW8ghQE3Q0qyhBbLslkirtBEkczywCIskieUHSVV6WHI41ht479JKrojnpo
	PIRWlphfeBF2SRL8Z1MEsS8T8u2Bg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckskda2c7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Mar 2026 19:01:47 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 626FEoP6027733;
	Fri, 6 Mar 2026 19:01:46 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmcwjrx0m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Mar 2026 19:01:46 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 626J1jHO42664438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Mar 2026 19:01:45 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED9F72004B;
	Fri,  6 Mar 2026 19:01:44 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B87C920040;
	Fri,  6 Mar 2026 19:01:43 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.fios-router.home (unknown [9.61.31.3])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Mar 2026 19:01:43 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, Frederick Lawler <fred@cloudflare.com>,
        Jeff Layton <jlayton@kernel.org>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>
Subject: [PATCH] ima: detect file change code cleanup
Date: Fri,  6 Mar 2026 14:01:40 -0500
Message-ID: <20260306190141.309937-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6Q76KbX7PHpGcH3bLpq5j86gvnGVM5XK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE3NiBTYWx0ZWRfX4nk6tTz48JTb
 eSDDQ+Z1W2Ym7CD9wuQno4G23lXhuSZSmTOScsWum4ZrzWuO8xsDaOZaWmQ31EhlW0pGcc3E5/V
 /bzjHX9Yrgfzh2GsgAfNE6mgrJEx+/nTw6Rb2e3IT93mPy03tebr3BBRAltlIH8sx7sVlELT69W
 juYDph824PKoblLmgYpnY3RyPgtlb/UAbqdPtR8Q47FULkOHrtvkgwNZapKFMcyMKEKet7Pg8OQ
 AqIPnR155zJR2xWuhjWhovPv6mRIhPnxvlj4AR0PctZhI5fn0izlfhQTQNIUcHUFgYQl5KbriLZ
 ol0U79ds2dbhOTqCaKCL0O65kd+XnaNORAtHZxdP2Youk6T6QyD8mmZT1HYpyQdUVR7Gk28i38w
 bud8aJw2eHnwg2lEeyY6Mq6CA1QOvkLJZhR3JeMsceIPlY6YXgIKLYGX88mCbFIg98mHciKpL/V
 kBiixB2XbGn30N/FVwg==
X-Authority-Analysis: v=2.4 cv=H7DWAuYi c=1 sm=1 tr=0 ts=69ab249b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=V9fOTgLxXPwWSu-OC1EA:9
X-Proofpoint-ORIG-GUID: 6Q76KbX7PHpGcH3bLpq5j86gvnGVM5XK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060176
X-Rspamd-Queue-Id: A3221226E5F
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-8939-lists,linux-integrity=lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.ibm.com:mid];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action

Functionally no change, just simplify the ima_detect_file_change() code.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
@Fred, looking to merge with commit 0824f861605d ("ima: fallback to using
i_version to detect file change")

 security/integrity/ima/ima_main.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 6c49afa8dcc0..5cea53fc36df 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -194,18 +194,13 @@ static bool ima_detect_file_change(struct ima_iint_cache *iint,
 	result = vfs_getattr_nosec(&file->f_path, &stat, STATX_CHANGE_COOKIE,
 				   AT_STATX_SYNC_AS_STAT);

-	if (!result && stat.result_mask & STATX_CHANGE_COOKIE &&
-	    stat.change_cookie != iint->real_inode.version)
-		return true;
-	else if (!(stat.result_mask & STATX_CHANGE_COOKIE) &&
-		 IS_I_VERSION(inode) &&
-		 !(inode_eq_iversion(inode, iint->real_inode.version)))
-		return true;
-	else if (!(stat.result_mask & STATX_CHANGE_COOKIE) &&
-		 !(IS_I_VERSION(inode)))
-		return true;
-
-	return false;
+	if (!result && stat.result_mask & STATX_CHANGE_COOKIE)
+		return stat.change_cookie != iint->real_inode.version;
+
+	if (IS_I_VERSION(inode))
+		return !inode_eq_iversion(inode, iint->real_inode.version);
+
+	return true;
 }

 static void ima_check_last_writer(struct ima_iint_cache *iint,
--
2.53.0


