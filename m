Return-Path: <linux-integrity+bounces-8172-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5909ACF66B4
	for <lists+linux-integrity@lfdr.de>; Tue, 06 Jan 2026 03:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EC3D30393D9
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Jan 2026 02:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EDE53E0B;
	Tue,  6 Jan 2026 02:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OMM+Fs/x"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC567226CEB;
	Tue,  6 Jan 2026 02:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767665250; cv=none; b=otK3mMMAaCgBCuxNJvy7CowX1p9fr8YOZd9Z5D/r4XRXet7K+4zhbrWTWnfNfZsN9kYhzyFp3JemkasF9G74xiV56XMEFK5Ejvdv5AEodQFvh8jkGkwQoAchtY3s0JsavCzJKvlKx4bOfPl68L3KlIl9saRSjoOaaM6DENyTjD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767665250; c=relaxed/simple;
	bh=ReKDJWLsmPxVtRgonAxUuaCrmZxK0By2pg9RbEbNda4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LhwRcWFMZsiUDGZezA9Kq7TqYxcD1SlSN+CPdu1TUA0pYs3OXbgwd1aFxHSvZBREVcF0yXXfrX9lnXaowZyqhKI7hU4NXRWHDiF8lxe57xYX2bmaTOjANLSkqK44/e5Lk+9Ojmfm0z5zAD1/fh8rWPc5+CQ0SXEO9wtDklEUw0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OMM+Fs/x; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from chenste-Virtual-Machine.mshome.net (unknown [50.168.180.218])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0046F2126884;
	Mon,  5 Jan 2026 18:07:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0046F2126884
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1767665248;
	bh=pYpOXis9U8F/JF8jxXEwMopb+uSTVFbJv2L6MNYu6BI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OMM+Fs/xMEqxWQM3FUcCIfJV0hZ6BEODxolxPOJyrx4pzBRwTP7Fr8C9BGrBNuzrO
	 ScZhHU5e09j6msbINHAHC7QCFg81ooAUh5hTPVk8/3hfDrlIS4qU5z/RaNog2eotVx
	 ELir47rRl8x/zxyZwwiVGZeUsN6WODgID/FQcMwY=
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
Subject: [PATCH v3 3/3] ima: add new critical data record to measure log trimming
Date: Mon,  5 Jan 2026 18:07:12 -0800
Message-ID: <20260106020713.3994-4-chenste@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106020713.3994-1-chenste@linux.microsoft.com>
References: <20260106020713.3994-1-chenste@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new critical data record to measure the trimming event when
ima event records are deleted for this time.

If all IMA event logs are saved in the userspace, use this type of
logs to get total numbers of records deleted from beginning.

Signed-off-by: steven chen <chenste@linux.microsoft.com>
---
 security/integrity/ima/ima_fs.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 67ff0cfc3d3f..6d3d34d07b2b 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -364,6 +364,22 @@ static const struct file_operations ima_ascii_measurements_ops = {
 	.release = ima_measurements_release,
 };
 
+static void ima_measure_trim_event(const long number_logs)
+{
+	char ima_log_trim_event[IMA_LOG_TRIM_EVENT_LEN];
+	struct timespec64 ts;
+	u64 time_ns;
+	int n;
+
+	ktime_get_real_ts64(&ts);
+	time_ns = (u64)ts.tv_sec * 1000000000ULL + ts.tv_nsec;
+	n = scnprintf(ima_log_trim_event, IMA_LOG_TRIM_EVENT_LEN,
+		      "time= %llu; number= %lu;", time_ns, number_logs);
+
+	ima_measure_critical_data("ima_log_trim", "trim ima event logs",
+				  ima_log_trim_event, n, false, NULL, 0);
+}
+
 static int ima_log_trim_open(struct inode *inode, struct file *file)
 {
 	bool write = !!(file->f_mode & FMODE_WRITE);
@@ -407,6 +423,8 @@ static ssize_t ima_log_trim_write(struct file *file,
 		goto out;
 
 	trimcount = ret;
+	if (trimcount > 0)
+		ima_measure_trim_event(trimcount);
 
 	ret = datalen;
 out:
-- 
2.43.0


