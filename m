Return-Path: <linux-integrity+bounces-8457-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENvbFdkuhWn49gMAu9opvQ
	(envelope-from <linux-integrity+bounces-8457-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 06 Feb 2026 00:59:21 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE7EF8787
	for <lists+linux-integrity@lfdr.de>; Fri, 06 Feb 2026 00:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C571C30265A5
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Feb 2026 23:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA6F33B6E5;
	Thu,  5 Feb 2026 23:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="YY+56P16"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D39B2C3255;
	Thu,  5 Feb 2026 23:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770335945; cv=none; b=GoxpD+uMXyk7JtqgpNTcDzsC24FcZiNCVGRV08TGLUSFxmFHw7dYxg63lcxrca+j02WXS5JYxeXeQkd3OKMDfWEyMy4XpS6YSTFv0jJMlGYMsfHR9US9LZCYvitRdduMzUzg1TpATV8k05abOYGvK0zmeoHfA64jlLlJEuqkoIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770335945; c=relaxed/simple;
	bh=Qoo20fLVB5hL7SiezW/J5kKKcaNVQMPbLJ207X/e/S0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bQVqymgdL12bD5ouWhotjgLXqBi3AtLh2TKimxVsEBosv0bvWlmnyYgmLFdw3hUdBLtTRKD0Nh/wfbEj5WZVBpFGuwYW80/ifqmCHfJDXE66qX9uDKCt0bS+OX/hrYnwDQe8ghLsJ/+x4KwAwLKFXTCAFX0yBlIBTm9mCZDHGaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=YY+56P16; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from chenste-Virtual-Machine.mshome.net (unknown [131.107.1.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3512F20B716D;
	Thu,  5 Feb 2026 15:59:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3512F20B716D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1770335944;
	bh=hSq2uVGwQwQK28jR9rsi7Mp9gy+zPDYhUdE3iqYWgE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YY+56P16WkvfJlIDiyqvoHg2EALS/UwSV4N1eFgZF+hI1XLH9aDJJ+rR/2uidfS7P
	 EoLUAV5qVqyWfjrT6Up7IqCz9S/MHhKSQ7f5LD+ShgVVwCGLFXdtu+U3yEfvhYhSzW
	 vmuwyP9gAcS14YOkvv1hAwst1S2jpeMV4V5FhI8U=
From: steven chen <chenste@linux.microsoft.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	corbet@lwn.net,
	serge@hallyn.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	linux-security-module@vger.kernel.org,
	anirudhve@linux.microsoft.com,
	chenste@linux.microsoft.com,
	gregorylumen@linux.microsoft.com,
	nramas@linux.microsoft.com,
	sushring@linux.microsoft.com,
	linux-doc@vger.kernel.org
Subject: [PATCH v4 3/3] ima: add new critical data record to measure log trim
Date: Thu,  5 Feb 2026 15:58:48 -0800
Message-ID: <20260205235849.7086-4-chenste@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260205235849.7086-1-chenste@linux.microsoft.com>
References: <20260205235849.7086-1-chenste@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,huawei.com,gmail.com,oracle.com,lwn.net,hallyn.com,paul-moore.com,namei.org,vger.kernel.org,linux.microsoft.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8457-lists,linux-integrity=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenste@linux.microsoft.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:mid,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: EDE7EF8787
X-Rspamd-Action: no action

Add a new critical data record to measure the trimming event when
ima event records are deleted since system boot up.

If all IMA event logs are saved in the userspace, use this log to get total
numbers of records deleted since system boot up at that point.

Signed-off-by: steven chen <chenste@linux.microsoft.com>
---
 security/integrity/ima/ima_fs.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 7f805ab62f6c..1d6befa51044 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -43,6 +43,7 @@ static int valid_policy = 1;
 
 #define IMA_LOG_TRIM_REQ_NUM_LENGTH 15
 #define IMA_LOG_TRIM_REQ_TOTAL_LENGTH 32
+#define IMA_LOG_TRIM_EVENT_LEN 256
 
 static long trimcount;
 /* mutex protects atomicity of trimming measurement list
@@ -364,6 +365,22 @@ static const struct file_operations ima_ascii_measurements_ops = {
 	.release = ima_measurements_release,
 };
 
+static void ima_measure_trim_event(void)
+{
+	char ima_log_trim_event[IMA_LOG_TRIM_EVENT_LEN];
+	struct timespec64 ts;
+	u64 time_ns;
+	int n;
+
+	ktime_get_real_ts64(&ts);
+	time_ns = (u64)ts.tv_sec * 1000000000ULL + ts.tv_nsec;
+	n = scnprintf(ima_log_trim_event, IMA_LOG_TRIM_EVENT_LEN,
+		      "time= %llu; number= %lu;", time_ns, trimcount);
+
+	ima_measure_critical_data("ima_log_trim", "trim ima event logs",
+				  ima_log_trim_event, n, false, NULL, 0);
+}
+
 static int ima_log_trim_open(struct inode *inode, struct file *file)
 {
 	bool write = !!(file->f_mode & FMODE_WRITE);
@@ -438,6 +455,8 @@ static ssize_t ima_log_trim_write(struct file *file,
 		goto out;
 
 	trimcount += ret;
+	if (ret > 0)
+		ima_measure_trim_event();
 
 	ret = datalen;
 out:
-- 
2.43.0


