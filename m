Return-Path: <linux-integrity+bounces-5905-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F2FA8ADE9
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Apr 2025 04:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC17A17178B
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Apr 2025 02:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5A922A4C2;
	Wed, 16 Apr 2025 02:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="C4l5eqAq"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6357A22A1C0;
	Wed, 16 Apr 2025 02:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744769457; cv=none; b=FWxllNT89iz+u1MtK8ohWj33tqyAy70CbJZIoARVomM1El53dlAgEPwB3W5ZPPW2hvMjwenFER7AsEcRErSOKwD1ALhR1n1NafSFvVZM11Hs8z2pqMRokXCo3FGF5IKz4iwq/Ck9q4CQc7BxnHSG7duNVTzwuUNjEzW2PhqnCXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744769457; c=relaxed/simple;
	bh=13Z/bUVD3aCXNxsjL3OfaaKL3EKFLJIssiFnJggTQ+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ABt/rc45FdieZmEPIorhF+tsNjnUOYz3l1eu9GTs+qYCWm8Ud+f2nDKS9bQUblTM2bRqZANPjWxNqkXeKXKe8YhW7lHDIsRmmE7RLIWciL9/yGwF/AZ7qeyYRb/vdx8aeSmjkc91U+BN4qLwE/BWo/OrKrFDwKq8Nn6K8m5ipto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=C4l5eqAq; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from DESKTOP-VOT081N.hsd1.ga.comcast.net (unknown [172.200.70.13])
	by linux.microsoft.com (Postfix) with ESMTPSA id E618A210C459;
	Tue, 15 Apr 2025 19:10:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E618A210C459
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744769456;
	bh=HvthFO8LCO7AsYxeb/FYT8qI95ecDogbw/W4n/TsLTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C4l5eqAqZuEFpaSRRYyNRZW386Y4kiMFPL/lsWiNS3UMBzRShfTfiNXBIGfp3TPM9
	 Qd0qC1YW96T8cmA+9dGRjrQMM5/qMvjsvmM8EwUVzEmh2Sob+hkmjUr/K4nbzWFZO0
	 pg9DvwePzb/F2nkTUmt7beepu8PIFgFroVTDd8Lc=
From: steven chen <chenste@linux.microsoft.com>
To: zohar@linux.ibm.com,
	stefanb@linux.ibm.com,
	roberto.sassu@huaweicloud.com,
	roberto.sassu@huawei.com,
	eric.snowberg@oracle.com,
	ebiederm@xmission.com,
	paul@paul-moore.com,
	code@tyhicks.com,
	bauermann@kolabnow.com,
	linux-integrity@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com,
	nramas@linux.microsoft.com,
	James.Bottomley@HansenPartnership.com,
	bhe@redhat.com,
	vgoyal@redhat.com,
	dyoung@redhat.com
Subject: [PATCH v12 4/9] ima: kexec: skip IMA segment validation after kexec soft reboot
Date: Tue, 15 Apr 2025 19:10:22 -0700
Message-ID: <20250416021028.1403-5-chenste@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250416021028.1403-1-chenste@linux.microsoft.com>
References: <20250416021028.1403-1-chenste@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Steven Chen <chenste@linux.microsoft.com>

Currently, the function kexec_calculate_store_digests() calculates and
stores the digest of the segment during the kexec_file_load syscall,
where the  IMA segment is also allocated.

Later, the IMA segment will be updated with the measurement log at the
kexec execute stage when a kexec reboot is initiated. Therefore, the
digests should be updated for the IMA segment in the  normal case. The
problem is that the content of memory segments carried over to the new
kernel during the kexec systemcall can be changed at kexec 'execute'
stage, but the size and the location of the memory segments cannot be
changed at kexec 'execute' stage.

To address this, skip the calculation and storage of the digest for the
IMA segment in kexec_calculate_store_digests() so that it is not added 
to the purgatory_sha_regions.

With this change, the IMA segment is not included in the digest
calculation, storage, and verification.

Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Baoquan He <bhe@redhat.com> 
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Signed-off-by: Steven Chen <chenste@linux.microsoft.com>
---
 include/linux/kexec.h              |  3 +++
 kernel/kexec_file.c                | 22 ++++++++++++++++++++++
 security/integrity/ima/ima_kexec.c |  3 +++
 3 files changed, 28 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 7d6b12f8b8d0..107e726f2ef3 100644
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
index 3eedb8c226ad..606132253c79 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -38,6 +38,21 @@ void set_kexec_sig_enforced(void)
 }
 #endif
 
+#ifdef CONFIG_IMA_KEXEC
+static bool check_ima_segment_index(struct kimage *image, int i)
+{
+	if (image->is_ima_segment_index_set && i == image->ima_segment_index)
+		return true;
+	else
+		return false;
+}
+#else
+static bool check_ima_segment_index(struct kimage *image, int i)
+{
+	return false;
+}
+#endif
+
 static int kexec_calculate_store_digests(struct kimage *image);
 
 /* Maximum size in bytes for kernel/initrd files. */
@@ -764,6 +779,13 @@ static int kexec_calculate_store_digests(struct kimage *image)
 		if (ksegment->kbuf == pi->purgatory_buf)
 			continue;
 
+		/*
+		 * Skip the segment if ima_segment_index is set and matches
+		 * the current index
+		 */
+		if (check_ima_segment_index(image, i))
+			continue;
+
 		ret = crypto_shash_update(desc, ksegment->kbuf,
 					  ksegment->bufsz);
 		if (ret)
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index b12ac3619b8f..7e0a19c3483f 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -145,6 +145,7 @@ void ima_add_kexec_buffer(struct kimage *image)
 	kbuf.buffer = kexec_buffer;
 	kbuf.bufsz = kexec_buffer_size;
 	kbuf.memsz = kexec_segment_size;
+	image->is_ima_segment_index_set = false;
 	ret = kexec_add_buffer(&kbuf);
 	if (ret) {
 		pr_err("Error passing over kexec measurement buffer.\n");
@@ -155,6 +156,8 @@ void ima_add_kexec_buffer(struct kimage *image)
 	image->ima_buffer_addr = kbuf.mem;
 	image->ima_buffer_size = kexec_segment_size;
 	image->ima_buffer = kexec_buffer;
+	image->ima_segment_index = image->nr_segments - 1;
+	image->is_ima_segment_index_set = true;
 
 	kexec_dprintk("kexec measurement buffer for the loaded kernel at 0x%lx.\n",
 		      kbuf.mem);
-- 
2.43.0


