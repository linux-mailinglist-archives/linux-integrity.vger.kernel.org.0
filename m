Return-Path: <linux-integrity+bounces-8504-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBfzLVhkj2n6QgEAu9opvQ
	(envelope-from <linux-integrity+bounces-8504-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Feb 2026 18:50:16 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C58D138BE5
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Feb 2026 18:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99F2B3039C9D
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Feb 2026 17:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26AD22FF22;
	Fri, 13 Feb 2026 17:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="q6AZZkjp"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53ED017555
	for <linux-integrity@vger.kernel.org>; Fri, 13 Feb 2026 17:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771005013; cv=none; b=dxbLi8hvuVwnnc0siS3vjSEFDnhKL0z1ghySVRC7GVhIb0TX/kitp6wHWSylw39MDSXcJ8VFT4tXo1AShlIS9TQsF4eh5VShVV6LPFyUwzWSfS9m+Epgg9UGPjwWbkfE0Eb6mKUc3QdVQOwkOyAOldJbxqgzd5qECmIQLZPcPBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771005013; c=relaxed/simple;
	bh=aHqfCfHpFAEumzleaZOJX82BuJEPq6+jczMqCqzQq7g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bvLAxPzSH81X/WzJs689adA6iABzYpS0IgRPXua5btECu8a7ijUapvRIgP7Gdkn/XVSUazy43e4Ulq8+KoSpjIJhKR7/gKXq1n3PrUYDNh4smauxIz5+lW9YorKeRvRHytoS3ro/LFqa7iPLNS3PKu95wUdDjPCkinMgW34LoWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=q6AZZkjp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61DC2LOQ369791;
	Fri, 13 Feb 2026 17:49:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=974wsT+mV/vKfVe0GrNsNB7Nwl+e4ppLhe4mc1a28
	XM=; b=q6AZZkjpbMNuFLvdkobQGau9by2ZUIF9Q1QL49TjC6JHG1aCPpuQFp6zE
	hyzhseES494Qb4nBcHObkkGKqCwWKlw2A5KGawgoVlNUQLeSgj3yZwEltQjo/slE
	rKPnJLMWv6VXSk6QAWLWSlhfaULwBt3N7WpzFu+9SM8SNBS5WvQJo5dXue0I4xFr
	nKZGvs4FP510nMP7RADU/Ok9uSoM4eR/3IbtCIJg3eEM1bDxPXdJtAtkvi7nWzKX
	eW3kJq7t/6/Umkci8VxA7dt4BjKi59GlrmNgBIRVA1jAPItmyouq25MQcek68Vme
	ukhT5Iu9YvIScKKi64TelFHCEGSyw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696x97cm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Feb 2026 17:49:54 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61DH1qGc002575;
	Fri, 13 Feb 2026 17:49:53 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c6fqsyytq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Feb 2026 17:49:53 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61DHnpjt27984534
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Feb 2026 17:49:52 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D090A20043;
	Fri, 13 Feb 2026 17:49:51 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 02F4920040;
	Fri, 13 Feb 2026 17:49:50 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.fios-router.home (unknown [9.61.16.168])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Feb 2026 17:49:49 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, Frederick Lawler <fred@cloudflare.com>,
        Jeff Layton <jlayton@kernel.org>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v2] ima: fallback to using i_version to detect file change
Date: Fri, 13 Feb 2026 12:49:47 -0500
Message-ID: <20260213174947.976924-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=WZYBqkhX c=1 sm=1 tr=0 ts=698f6442 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8
 a=QcjPf8HStALqMZpZQ6AA:9
X-Proofpoint-GUID: 338O7nvbH9QqjIrAg-MJhzvQrwEN_9lj
X-Proofpoint-ORIG-GUID: 338O7nvbH9QqjIrAg-MJhzvQrwEN_9lj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDEzNyBTYWx0ZWRfX5Y0PKJbsKV7r
 v63JdVA21d4nQZkQhaqDSYh2OSxmGFiBbORkCtsOExRkegVJC+fuagYQSwEJ9WKneizNn0ZDgY0
 hqZThm7RknWDNNg0CN4deZz/VIFAD/8qURs163gFTg47whb1S9dzEEeDZAuSAXfzO9kJyg87jAX
 uf+ZJtanlcEC5auIinEsOKDC9juhasg+xOPW2jYUp/ynNqn6c46Ps5BEH7w+kojmC7X8IPviv/g
 lxgJ8Y7PHdoqkU8+FbtpPTMjSN+FZEudvBB9BJghNCtPCR6+agXR/JBxPtdUTogwk2wOGJLi12G
 PSgksWJMSiF9RC4kpImlNKy8Pl6JAajNkt8ZdWKzqpmmEJMFnsgooKeS/Hu7OYWduVudSrX/eeR
 asStUYuyqG0esf3KLI4IjvTWDs9wWRYuO5GE54fpQULFgV8NpeyIpNNgj/dqHyEKpkHBlBKL/bd
 PWd/4RrgQDClUBOgSKA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_03,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602130137
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
	TAGGED_FROM(0.00)[bounces-8504-lists,linux-integrity=lfdr.de];
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
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 1C58D138BE5
X-Rspamd-Action: no action

Commit db1d1e8b9867 ("IMA: use vfs_getattr_nosec to get the i_version")
replaced detecting file change based on i_version with
STATX_CHANGE_COOKIE.

On filesystems without STATX_CHANGE_COOKIE enabled, revert back to
detecting file change based on i_version.

On filesystems which do not support either, assume the file changed.

Reported-by: Roberto Sassu <roberto.sassu@huawei.com>
Fixes: db1d1e8b9867 ("IMA: use vfs_getattr_nosec to get the i_version")
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
Changelog v2:
- Use the real_inode's iversion to detect file change on overlayfs
- Add Roberto's Reported-by tag

 security/integrity/ima/ima_api.c  | 13 +++++++----
 security/integrity/ima/ima_main.c | 39 ++++++++++++++++++++++++-------
 2 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index c35ea613c9f8..28cf1fe07f8f 100644
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
+	else if (IS_I_VERSION(real_inode))
+		i_version = inode_peek_iversion(real_inode);
+
 	hash.hdr.algo = algo;
 	hash.hdr.length = hash_digest_size[algo];
 
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 1d6229b156fb..4fc383479847 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -180,6 +180,34 @@ static void ima_rdwr_violation_check(struct file *file,
 				  "invalid_pcr", "open_writers");
 }
 
+/*
+ * Detect file change based on STATX_CHANGE_COOKIE, when supported, and
+ * fallback to detecting file change based on i_version. On filesystems
+ * which do not support either, assume the file changed.
+ */
+static bool ima_detect_file_change(struct ima_iint_cache *iint,
+				   struct inode *inode, struct file *file)
+{
+	struct kstat stat;
+	int result;
+
+	result = vfs_getattr_nosec(&file->f_path, &stat, STATX_CHANGE_COOKIE,
+				   AT_STATX_SYNC_AS_STAT);
+
+	if (!result && stat.result_mask & STATX_CHANGE_COOKIE &&
+	    stat.change_cookie != iint->real_inode.version)
+		return true;
+	else if (!(stat.result_mask & STATX_CHANGE_COOKIE) &&
+		 IS_I_VERSION(inode) &&
+		 !(inode_eq_iversion(inode, iint->real_inode.version)))
+		return true;
+	else if (!(stat.result_mask & STATX_CHANGE_COOKIE) &&
+		 !(IS_I_VERSION(inode)))
+		return true;
+
+	return false;
+}
+
 static void ima_check_last_writer(struct ima_iint_cache *iint,
 				  struct inode *inode, struct file *file)
 {
@@ -191,18 +219,13 @@ static void ima_check_last_writer(struct ima_iint_cache *iint,
 
 	mutex_lock(&iint->mutex);
 	if (atomic_read(&inode->i_writecount) == 1) {
-		struct kstat stat;
-
 		clear_bit(IMA_EMITTED_OPENWRITERS, &iint->atomic_flags);
 
 		update = test_and_clear_bit(IMA_UPDATE_XATTR,
 					    &iint->atomic_flags);
-		if ((iint->flags & IMA_NEW_FILE) ||
-		    vfs_getattr_nosec(&file->f_path, &stat,
-				      STATX_CHANGE_COOKIE,
-				      AT_STATX_SYNC_AS_STAT) ||
-		    !(stat.result_mask & STATX_CHANGE_COOKIE) ||
-		    stat.change_cookie != iint->real_inode.version) {
+
+		if (iint->flags & IMA_NEW_FILE ||
+		    ima_detect_file_change(iint, inode, file)) {
 			iint->flags &= ~(IMA_DONE_MASK | IMA_NEW_FILE);
 			iint->measured_pcrs = 0;
 			if (update)
-- 
2.53.0


