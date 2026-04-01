Return-Path: <linux-integrity+bounces-9117-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNtHLexazWkRcQYAu9opvQ
	(envelope-from <linux-integrity+bounces-9117-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 01 Apr 2026 19:50:36 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6068B37ED4E
	for <lists+linux-integrity@lfdr.de>; Wed, 01 Apr 2026 19:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 401A3306A3DF
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Apr 2026 17:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B217947DD74;
	Wed,  1 Apr 2026 17:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="g7hnIWTG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11E047DD63;
	Wed,  1 Apr 2026 17:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775064933; cv=none; b=LkJDBgeFJvfFJMCPewbIH3In0w/rAY/Q+XX/T8L4neZQlsleZAD4JrMf4zchb+DYh5vKsL8OJe4SJW2WRiS1X98Dwlm6gRi13h+1WkqA5DI2J1mO6wXvwOEP6pIPNeI+5Vzn3BLDc3BXunaOZ97PRVqxhTjAITk8wa/o8+BOF7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775064933; c=relaxed/simple;
	bh=p2BlAl1cHiWF5uyQVgVNIIFDdTAPSXS+s0o8KvTEnXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hXAuKzpo9VUJMWJAKlpSk89ke2WlWa9nb1x2kJDLui36ESGEigEX/MrKrUoD2OoLQ82B2QsXE0jag5lEfZXEK3aU3K6ruz/MYyBsz+ZBvb1G7aKbMsMayD9L3AXFHTWalwUpxXz2dmjUCXBSyvgk3KaRGXtLxfQkvAx1iZwHqOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=g7hnIWTG; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from chenste-Virtual-Machine.mshome.net (unknown [131.107.174.223])
	by linux.microsoft.com (Postfix) with ESMTPSA id 62D1420B7136;
	Wed,  1 Apr 2026 10:35:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 62D1420B7136
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775064929;
	bh=9BtBU2jYiOWXTA437b28t0CclKOCbCsHrWaX38gZQkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g7hnIWTGM5NlS7FZDoCEYG89z9/1aIcCfXZA+heFNl8iMcyO6wQ/DwF+JxPJ6mifS
	 7vSMYJTOPPhcyjsbZSFWAQc+tqZk4mZciaTupJ4dYnuyNOj+8WqTInMxupeSvXlwg1
	 oZLVSg0asjxoIZVIdYnGrrWDVJhr1tWT1072y3wQ=
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
Subject: [PATCH v5 3/3] ima: add new critical data record to measure log trim
Date: Wed,  1 Apr 2026 10:29:55 -0700
Message-ID: <20260401172956.4581-4-chenste@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260401172956.4581-1-chenste@linux.microsoft.com>
References: <20260401172956.4581-1-chenste@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,huawei.com,gmail.com,oracle.com,lwn.net,hallyn.com,paul-moore.com,namei.org,vger.kernel.org,linux.microsoft.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9117-lists,linux-integrity=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:dkim,linux.microsoft.com:mid]
X-Rspamd-Queue-Id: 6068B37ED4E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a new critical data record to measure the trimming event when
ima event records are deleted since system boot up.

If all IMA event logs are saved in the userspace, use this log to get total
numbers of records deleted since system boot up at that point.

Signed-off-by: steven chen <chenste@linux.microsoft.com>
---
 security/integrity/ima/ima_fs.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 8e26e0f34311..38d0a49b587f 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -43,6 +43,7 @@ static int valid_policy = 1;
 
 #define IMA_LOG_TRIM_REQ_NUM_LENGTH 15
 #define IMA_LOG_TRIM_REQ_TOTAL_LENGTH 32
+#define IMA_LOG_TRIM_EVENT_LEN 256
 atomic_long_t ima_number_entries = ATOMIC_LONG_INIT(0);
 static long trimcount;
 /* mutex protects atomicity of trimming measurement list
@@ -52,6 +53,22 @@ static long trimcount;
 static DEFINE_MUTEX(ima_measure_lock);
 static long ima_measure_users;
 
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
 static ssize_t ima_show_htable_value(char __user *buf, size_t count,
 				     loff_t *ppos, atomic_long_t *val)
 {
@@ -436,6 +453,9 @@ static ssize_t ima_log_trim_write(struct file *file,
 	if (ret < 0)
 		goto out;
 
+	if (ret > 0)
+		ima_measure_trim_event();
+
 	trimcount += ret;
 
 	ret = datalen;
-- 
2.43.0


