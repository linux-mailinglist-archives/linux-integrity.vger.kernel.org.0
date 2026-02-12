Return-Path: <linux-integrity+bounces-8494-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id O44/H/Uzjmm0AwEAu9opvQ
	(envelope-from <linux-integrity+bounces-8494-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Feb 2026 21:11:33 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B58F9130E0C
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Feb 2026 21:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B330F300C90B
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Feb 2026 20:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A599E2E8B82;
	Thu, 12 Feb 2026 20:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TVwtrpWr"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D93129B8E5
	for <linux-integrity@vger.kernel.org>; Thu, 12 Feb 2026 20:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770927088; cv=none; b=GkeSvgXk5WiS77ktjejdNFKmC3SibKkR6RShGJXiQp4IBzGuWxoPk1nHgsPjQzE04l22qRQ6ReU96wiOFirFyzT4JvDEPgQPfGrUW1Dt2Xz3G4I8i0c6xla8Biv91shx5G2iK7fQV8MyO8jYyK3SfOi4iBher8dlsL2n4WRS+1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770927088; c=relaxed/simple;
	bh=l7AzdhsHrlhGzO8PS8uoFtm3Qnc6wyJxRBEVTfLQkLc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G98dZLd3K6uvFywVQOPggqbX6yRqgPXsdTAqOKFxRtct1lbpMeKA0aOdrkAgIaCMVxcdnZYBD7otKbyZ/x5YiybSxTU61G3UIhuHNquSIFL5fAK1JDHvn/hCg6Cw6f6Svuv/28DnSyhKe1bIsPN/Vjnb1YIDP2DfE6RCuV7Yo2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TVwtrpWr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61CEYDxm2923105;
	Thu, 12 Feb 2026 20:11:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=3GfvQdDHrDUj4EpSVvUlMtCmiUFaDN/11nKxaxKUj
	Uo=; b=TVwtrpWr1TtMPbkZ6bEDPO1b3x2720aK+MRAUXLe5h8QiWM89bzswwrmS
	+A7LZNF+WevdWM/OXjQ9T51BLkDrzoThwKJrg5QAti7pJ81OLLAbVqcFKgl61AxU
	EQuN/y4Y1jxxiPrHw+Nv+O6E4QfXZr6spHE7tu9ER/NEw+oeM9U8nVQAgN6xVdHL
	N+MNM+3ebz3jGkkuGT0MNjhcvfod7hA1Qv94S7hBgKL0MrwxaL4BHKaxZ85hbkOW
	1lusBls6xi3kpi82Q6RypnuNnIqlNvIb6xrDr1+Oc89nYJ8et/CYLAz3xDjPq6/A
	V9XDTRuQttD2pgYgPLiq2LdGYZIXA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696ur0rj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Feb 2026 20:11:14 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61CIFplV019246;
	Thu, 12 Feb 2026 20:11:13 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c6hxkbvt0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Feb 2026 20:11:13 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61CKBBlZ39059740
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Feb 2026 20:11:11 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A219920043;
	Thu, 12 Feb 2026 20:11:11 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C5B620040;
	Thu, 12 Feb 2026 20:11:10 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.fios-router.home (unknown [9.61.21.193])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Feb 2026 20:11:10 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, Frederick Lawler <fred@cloudflare.com>,
        Jeff Layton <jlayton@kernel.org>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>
Subject: [PATCH] ima: fallback to using i_version
Date: Thu, 12 Feb 2026 15:11:00 -0500
Message-ID: <20260212201100.881432-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=YZiwJgRf c=1 sm=1 tr=0 ts=698e33e2 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=9GdR2PvGIDy7Q2hpH10A:9
X-Proofpoint-ORIG-GUID: sqJngfV48ihMwQ1AyJsMmuv5rLIHeDBp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDE1MyBTYWx0ZWRfX9HhSRWAK2XZS
 T3k1BjQ7MQ1CPhjOwJUBaH1hJx/L6cLIe5YoyBLFaEoONN+PPuFSjB6w/NNMO3Sn+id+V37oGI3
 oYxZ0wkaIx1UlZHK8BgbFIL6dQ6O2OORvj7TlthjAAo6V2pABmSt7TekX8SWKR3ONDs6Ql6xB5m
 oxl5wLLwjL08Wr8xEVEiURFYlt9SiaBHHeZtjVhBANL/vf6uUGBPjY/3LNXbokGCo7+zcS6tpyl
 /YYpiDovcWF0ku++qDoW/DvMySZ4+aDLs5ZxWlrOsNmGcgibmC6sDHbP+8tydrIFCVXInrQZCqF
 BQ98ONcrtyfLImMcU+hDhGRQgXkBsWArcJDQMODUT10jNlPUOjoDTVZZ0ZDGDK6kusqMGf4eL6W
 CgutrHHVbbzjGfyNQ23Yn8T+Ezcj3Idbx8SlFksu2SFB51CQtQQnw673RuIL/fNjCsfIbGWg7DD
 xWc5E3SyP0zcPPnItCw==
X-Proofpoint-GUID: sqJngfV48ihMwQ1AyJsMmuv5rLIHeDBp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_05,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602120153
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8494-lists,linux-integrity=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: B58F9130E0C
X-Rspamd-Action: no action

Commit db1d1e8b9867 ("IMA: use vfs_getattr_nosec to get the i_version")
replaced detecting file change based on i_version with
STATX_CHANGE_COOKIE.

On filesystems without STATX_CHANGE_COOKIE enabled, revert back to
detecting file change based on i_version.

Fixes: db1d1e8b9867 ("IMA: use vfs_getattr_nosec to get the i_version")
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/ima/ima_api.c  | 13 ++++++++----
 security/integrity/ima/ima_main.c | 34 +++++++++++++++++++++++++------
 2 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index c35ea613c9f8..3f0c73a8b459 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -267,15 +267,20 @@ int ima_collect_measurement(struct ima_iint_cache *iint, struct file *file,
 		goto out;
 
 	/*
-	 * Detecting file change is based on i_version. On filesystems
-	 * which do not support i_version, support was originally limited
-	 * to an initial measurement/appraisal/audit, but was modified to
-	 * assume the file changed.
+	 * Detect file change based on STATX_CHANGE_COOKIE, when supported,
+	 * and fallback to detecting file change based on i_version.
+	 *
+	 * On filesystems which did not support i_version, support was
+	 * originally limited to an initial measurement/appraisal/audit,
+	 * but was later modified to assume the file changed.
 	 */
 	result = vfs_getattr_nosec(&file->f_path, &stat, STATX_CHANGE_COOKIE,
 				   AT_STATX_SYNC_AS_STAT);
 	if (!result && (stat.result_mask & STATX_CHANGE_COOKIE))
 		i_version = stat.change_cookie;
+	else if (IS_I_VERSION(inode))
+		i_version = inode_peek_iversion(inode);
+
 	hash.hdr.algo = algo;
 	hash.hdr.length = hash_digest_size[algo];
 
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 1d6229b156fb..fc50f727c954 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -184,7 +184,9 @@ static void ima_check_last_writer(struct ima_iint_cache *iint,
 				  struct inode *inode, struct file *file)
 {
 	fmode_t mode = file->f_mode;
+	int modified = 0;
 	bool update;
+	int result;
 
 	if (!(mode & FMODE_WRITE))
 		return;
@@ -197,12 +199,32 @@ static void ima_check_last_writer(struct ima_iint_cache *iint,
 
 		update = test_and_clear_bit(IMA_UPDATE_XATTR,
 					    &iint->atomic_flags);
-		if ((iint->flags & IMA_NEW_FILE) ||
-		    vfs_getattr_nosec(&file->f_path, &stat,
-				      STATX_CHANGE_COOKIE,
-				      AT_STATX_SYNC_AS_STAT) ||
-		    !(stat.result_mask & STATX_CHANGE_COOKIE) ||
-		    stat.change_cookie != iint->real_inode.version) {
+
+		if (iint->flags & IMA_NEW_FILE)
+			modified = 1;
+
+		/*
+		 * Detect file change based on STATX_CHANGE_COOKIE, when
+		 * supported, and fallback to detecting file change based
+		 * on i_version. On filesystems which do not support either,
+		 * assume the file changed.
+		 */
+		 result = vfs_getattr_nosec(&file->f_path, &stat,
+					    STATX_CHANGE_COOKIE,
+					    AT_STATX_SYNC_AS_STAT);
+
+		if (!result && stat.result_mask & STATX_CHANGE_COOKIE &&
+		    stat.change_cookie != iint->real_inode.version)
+			modified = 1;
+		else if (!(stat.result_mask & STATX_CHANGE_COOKIE) &&
+			 IS_I_VERSION(inode) &&
+			 !(inode_eq_iversion(inode, iint->real_inode.version)))
+			modified = 1;
+		else if (!(stat.result_mask & STATX_CHANGE_COOKIE) &&
+			 !(IS_I_VERSION(inode)))
+			modified = 1;
+
+		if (modified) {
 			iint->flags &= ~(IMA_DONE_MASK | IMA_NEW_FILE);
 			iint->measured_pcrs = 0;
 			if (update)
-- 
2.53.0


