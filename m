Return-Path: <linux-integrity+bounces-1201-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFD4854D04
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Feb 2024 16:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ED241F21339
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Feb 2024 15:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5695D47E;
	Wed, 14 Feb 2024 15:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KJ9JAEoj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D482D5A4E1
	for <linux-integrity@vger.kernel.org>; Wed, 14 Feb 2024 15:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707925117; cv=none; b=gvTdchQbITPOaijErGOyfe6adZUfai2VXCIwoREOHbv9c3HPrqjdV46MIrKLRFJDkDLfhuKDh2ZlhllqPYDNEK+pwj7uO5jyzD9quq5gDfA0hxmDni+b9KPZQZ8OKu2dAI0vVhmbkXHItWAclqSCQsfZc0VKNAo78RF2cWt/WVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707925117; c=relaxed/simple;
	bh=m4gCm3J16zB805fp6gH1DCk1yV7y2jB5xxHkWeop2Lk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HFgZrqwj/WLrOnUQoIJgBx2prY4wzAen7g0wxZs+o9/18373AvqgjlwzsXzufdHgnC4m40OV6+2kD3djNT4WEK6niG+26CaqNGc0ABQgJY30kvGeaQXKNKIAsFgpm1/I5uGOhGRgAUY45RR4TZseFYk7m1jZ2Ok7gh0FwNy9K/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KJ9JAEoj; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4D8A620B2003;
	Wed, 14 Feb 2024 07:38:35 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4D8A620B2003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1707925115;
	bh=7AfuizgJ5ElWTHZgEiEhqrG4GwZkXPqkkrHChqJjnRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KJ9JAEojMDPIpCYEicWI2Hvf0bgAdnLVRsk0Jo3mrdAf52Wi8BCW/dWl9YKie8pUK
	 8dbavId1j6BOTH15o/t+X7gfydphHDfI4qTuTBJK9GQ+cc0wY1+/nn6zlwzMwv1TWf
	 iuctBCpIy27AhGJWW34NKDsC7pQDBGQn0dX+Y2ZQ=
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
To: zohar@linux.ibm.com,
	roberto.sassu@huaweicloud.com,
	roberto.sassu@huawei.com,
	eric.snowberg@oracle.com,
	stefanb@linux.ibm.com,
	ebiederm@xmission.com,
	noodles@fb.com,
	bauermann@kolabnow.com,
	linux-integrity@vger.kernel.org,
	kexec@lists.infradead.org
Cc: code@tyhicks.com,
	nramas@linux.microsoft.com,
	paul@paul-moore.com
Subject: [PATCH v5 3/8] ima: kexec: skip IMA segment validation after kexec soft reboot
Date: Wed, 14 Feb 2024 07:38:22 -0800
Message-Id: <20240214153827.1087657-4-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240214153827.1087657-1-tusharsu@linux.microsoft.com>
References: <20240214153827.1087657-1-tusharsu@linux.microsoft.com>
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
new Kernel.  Therefore, the digest calculation, storage, and
verification of the IMA segment needs to be skipped.

Skip IMA segment from calculating and storing digest in function
kexec_calculate_store_digests() so that it is not added to the
'purgatory_sha_regions'.

Since verify_sha256_digest() only verifies 'purgatory_sha_regions',
no change is needed in verify_sha256_digest() in this context.

With this change, the IMA segment is not included in the digest
calculation, storage, and verification.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 include/linux/kexec.h              | 3 +++
 kernel/kexec_file.c                | 8 ++++++++
 security/integrity/ima/ima_kexec.c | 3 +++
 3 files changed, 14 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 3145447eb77a..73f0dd0e1787 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -358,6 +358,9 @@ struct kimage {
 
 	phys_addr_t ima_buffer_addr;
 	size_t ima_buffer_size;
+
+	unsigned long ima_segment_index;
+	bool is_ima_segment_index_set;
 #endif
 
 	/* Core ELF header buffer */
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index bef2f6f2571b..0e3689bfb0bb 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -750,6 +750,14 @@ static int kexec_calculate_store_digests(struct kimage *image)
 		if (ksegment->kbuf == pi->purgatory_buf)
 			continue;
 
+		/*
+		 * Skip the segment if ima_segment_index is set and matches
+		 * the current index
+		 */
+		if (image->is_ima_segment_index_set &&
+		    i == image->ima_segment_index)
+			continue;
+
 		ret = crypto_shash_update(desc, ksegment->kbuf,
 					  ksegment->bufsz);
 		if (ret)
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index a9cb5e882e2e..ccb072617c2d 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -161,6 +161,7 @@ void ima_add_kexec_buffer(struct kimage *image)
 	kbuf.buffer = kexec_buffer;
 	kbuf.bufsz = kexec_buffer_size;
 	kbuf.memsz = kexec_segment_size;
+	image->is_ima_segment_index_set = false;
 	ret = kexec_add_buffer(&kbuf);
 	if (ret) {
 		pr_err("Error passing over kexec measurement buffer.\n");
@@ -171,6 +172,8 @@ void ima_add_kexec_buffer(struct kimage *image)
 	image->ima_buffer_addr = kbuf.mem;
 	image->ima_buffer_size = kexec_segment_size;
 	image->ima_buffer = kexec_buffer;
+	image->ima_segment_index = image->nr_segments - 1;
+	image->is_ima_segment_index_set = true;
 
 	/*
 	 * kexec owns kexec_buffer after kexec_add_buffer() is called
-- 
2.25.1


