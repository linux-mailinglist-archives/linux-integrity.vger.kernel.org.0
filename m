Return-Path: <linux-integrity+bounces-4646-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 686C1A1BEA7
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Jan 2025 23:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB18916E502
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Jan 2025 22:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8091EE7B3;
	Fri, 24 Jan 2025 22:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="b3qaAlIE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3311B1E98E7;
	Fri, 24 Jan 2025 22:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737759358; cv=none; b=Dz2YXwUq3SI/+wKXtkYV6LVe3yjCTM0qgB8WsMUtKcvmApfRy3xpEJFWndGJ6A95dAser9TZEqfgtw8+fYQkvOmXedSfYgYt9jJghCHbj5szJ5OW7lkl5jOxEWVz2/0f/1bnDJd8tEywYyXwhCbpjIrmQg+yIYTulrt412kvP3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737759358; c=relaxed/simple;
	bh=+/vM8Wp0in6MfYqVPUlNCdxA+Ip9RDetizxsc5AYjso=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RozNsp9OBzLPHJHTTEFeVaqlnZPIHJlo+NPZwDGYw9MhmidbSepiQkVYgqbom6RmdMcfErbxki+AIAquwNbXkdSI+MbqQKjPsTyM887kcbgC9ZqO6dD0oRaui87X6adTBb12nAJParfp6YGtJJdE+xyqgWXdF9L2EV54CjEOYwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=b3qaAlIE; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost.localdomain (unknown [167.220.59.4])
	by linux.microsoft.com (Postfix) with ESMTPSA id CC32F210D0D6;
	Fri, 24 Jan 2025 14:55:56 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CC32F210D0D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1737759356;
	bh=bmgLmYsYlhYHbjbOJ7FsAVpXQjF5XYvbaC/P+6RVs/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b3qaAlIE5TdBqVM6JR/Qtp0vmKDLb1W9GTnEY84fqWQxjM549LPyxC4G6KY9LBtF5
	 5jfa5HkJ5F+Rui8ddxVu9nX0MjvWx+2KsA5q7tuylnkI5BNIMETUFKddxRPH1ZC+iA
	 VZGQznF2VBrkAdmGrr1W0FlMHQRVlWgRHdo1T3rQ=
From: steven chen <chenste@linux.microsoft.com>
To: zohar@linux.ibm.com,
	stefanb@linux.ibm.com,
	roberto.sassu@huaweicloud.com,
	petr@tesarici.cz,
	eric.snowberg@oracle.com,
	paul@paul-moore.com,
	code@tyhicks.com,
	nramas@linux.microsoft.com,
	James.Bottomley@HansenPartnership.com,
	madvenka@linux.microsoft.com
Cc: linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chenste@linux.microsoft.com
Subject: [PATCH v6 3/7] ima: kexec: skip IMA segment validation after kexec soft reboot
Date: Fri, 24 Jan 2025 14:55:43 -0800
Message-Id: <20250124225547.22684-4-chenste@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250124225547.22684-1-chenste@linux.microsoft.com>
References: <20250124225547.22684-1-chenste@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kexec_calculate_store_digests() calculates and stores the digest of the
segment at kexec_file_load syscall where the IMA segment is also
allocated.  With this series, the IMA segment will be updated with the
measurement log at kexec soft reboot.  Therefore, it may fail digest
verification in verify_sha256_digest() after kexec soft reboot into the
new Kernel.  Therefore, the digest calculation/verification of the IMA
segment needs to be skipped.

Skip IMA segment from calculating and storing digest in function
kexec_calculate_store_digests() so that it is not added to the
'purgatory_sha_regions'.

Since verify_sha256_digest() only verifies 'purgatory_sha_regions',
no change is needed in verify_sha256_digest() in this context.

With this change, the IMA segment is not included in the digest
calculation, storage, and verification.

Author: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Signed-off-by: steven chen <chenste@linux.microsoft.com>
---
 include/linux/kexec.h              |  3 +++
 kernel/kexec_file.c                | 10 ++++++++++
 security/integrity/ima/ima_kexec.c |  3 +++
 3 files changed, 16 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index f8413ea5c8c8..f3246e881ac8 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -362,6 +362,9 @@ struct kimage {
 
 	phys_addr_t ima_buffer_addr;
 	size_t ima_buffer_size;
+
+	unsigned long ima_segment_index;
+	bool is_ima_segment_index_set;
 #endif
 
 	/* Core ELF header buffer */
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 3eedb8c226ad..4ff3ba0f3e8e 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -764,6 +764,16 @@ static int kexec_calculate_store_digests(struct kimage *image)
 		if (ksegment->kbuf == pi->purgatory_buf)
 			continue;
 
+#ifdef CONFIG_IMA_KEXEC
+		/*
+		 * Skip the segment if ima_segment_index is set and matches
+		 * the current index
+		 */
+		if (image->is_ima_segment_index_set &&
+		    i == image->ima_segment_index)
+			continue;
+#endif
+
 		ret = crypto_shash_update(desc, ksegment->kbuf,
 					  ksegment->bufsz);
 		if (ret)
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index b60a902460e2..283860d20521 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -162,6 +162,7 @@ void ima_add_kexec_buffer(struct kimage *image)
 	kbuf.buffer = kexec_buffer;
 	kbuf.bufsz = kexec_buffer_size;
 	kbuf.memsz = kexec_segment_size;
+	image->is_ima_segment_index_set = false;
 	ret = kexec_add_buffer(&kbuf);
 	if (ret) {
 		pr_err("Error passing over kexec measurement buffer.\n");
@@ -172,6 +173,8 @@ void ima_add_kexec_buffer(struct kimage *image)
 	image->ima_buffer_addr = kbuf.mem;
 	image->ima_buffer_size = kexec_segment_size;
 	image->ima_buffer = kexec_buffer;
+	image->ima_segment_index = image->nr_segments - 1;
+	image->is_ima_segment_index_set = true;
 
 	/*
 	 * kexec owns kexec_buffer after kexec_add_buffer() is called
-- 
2.25.1


