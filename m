Return-Path: <linux-integrity+bounces-8040-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3EFCC07E9
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Dec 2025 02:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 923D130239F5
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Dec 2025 01:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302C22773D8;
	Tue, 16 Dec 2025 01:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SUYNl1lw"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF41244661
	for <linux-integrity@vger.kernel.org>; Tue, 16 Dec 2025 01:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765849774; cv=none; b=WwRriuKmOO+cKPtHvIuzqI7uSKhvnoUSmRhZCym7W2o05Sh4Xrhb+4x0+n79Kiu3te1MLjmWxxIZnDIxmf3Jg3aBqn8mvEVPY92BqDF2samUUOZEX4GGx7tcAuy381x4xMtgJ6KEI4SsvKTXtu+TMbaM4d6QEn2550pGriyF8z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765849774; c=relaxed/simple;
	bh=o3FfkIMFSSDksonP6Am+gRPvAhjSRjCxVxy8pinHUW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V3NVuDAt0Epq9ihBCz2WlpXCZ2joKnHQffAxt/Y/BCi8wLrrGbeQJIIhpohiRU/735mGzzIcP18PMkMTHSCoxvdzRqgGiW3RIwejG5VFkmX1b/ep6k7Kq8B0AzElq69g97tt+7fnUjb6/4SQBIpzsujo/o0HO/oDwzeQd2QkEN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SUYNl1lw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765849771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=POhLhNZ1zpDkvx5NFMn6+BIeJbKdzRv0ACR1cbx1arw=;
	b=SUYNl1lwHSxqSe5sJztkuH+5dmXDbidy4LzopsM0lau+nTwQaK8j3dFgIjmoJAmxcuGsmz
	QG0ZrYw8ZasF9U1B+sVItO3drcOfENcGI/5dcrRBtLdZmevKY+iAcWrTcuK0rsNt0dgifZ
	AL4QG0lzyQmuYRtciY+j7dyWtyn9kvw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-150-OpxS92fXM3yIi2XPyRk4Kg-1; Mon,
 15 Dec 2025 20:49:27 -0500
X-MC-Unique: OpxS92fXM3yIi2XPyRk4Kg-1
X-Mimecast-MFC-AGG-ID: OpxS92fXM3yIi2XPyRk4Kg_1765849766
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9C0A31956094;
	Tue, 16 Dec 2025 01:49:25 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.35])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5D4C9180035A;
	Tue, 16 Dec 2025 01:49:19 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org,
	linux-integrity@vger.kernel.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Alexander Graf <graf@amazon.com>,
	Steven Chen <chenste@linux.microsoft.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCHv3 2/2] kernel/kexec: Fix IMA when allocation happens in CMA area
Date: Tue, 16 Dec 2025 09:48:52 +0800
Message-ID: <20251216014852.8737-2-piliu@redhat.com>
In-Reply-To: <20251216014852.8737-1-piliu@redhat.com>
References: <20251216014852.8737-1-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

*** Bug description ***

When I tested kexec with the latest kernel, I ran into the following warning:

[   40.712410] ------------[ cut here ]------------
[   40.712576] WARNING: CPU: 2 PID: 1562 at kernel/kexec_core.c:1001 kimage_map_segment+0x144/0x198
[...]
[   40.816047] Call trace:
[   40.818498]  kimage_map_segment+0x144/0x198 (P)
[   40.823221]  ima_kexec_post_load+0x58/0xc0
[   40.827246]  __do_sys_kexec_file_load+0x29c/0x368
[...]
[   40.855423] ---[ end trace 0000000000000000 ]---

*** How to reproduce ***

This bug is only triggered when the kexec target address is allocated in
the CMA area. If no CMA area is reserved in the kernel, use the "cma="
option in the kernel command line to reserve one.

*** Root cause ***
The commit 07d24902977e ("kexec: enable CMA based contiguous
allocation") allocates the kexec target address directly on the CMA area
to avoid copying during the jump. In this case, there is no IND_SOURCE
for the kexec segment.  But the current implementation of
kimage_map_segment() assumes that IND_SOURCE pages exist and map them
into a contiguous virtual address by vmap().

*** Solution ***
If IMA segment is allocated in the CMA area, use its page_address()
directly.

Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")
Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Alexander Graf <graf@amazon.com>
Cc: Steven Chen <chenste@linux.microsoft.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: <stable@vger.kernel.org>
To: kexec@lists.infradead.org
---
v2 -> v3
  improve commit log

 kernel/kexec_core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 1a79c5b18d8f..95c585c6ddc3 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -960,13 +960,17 @@ void *kimage_map_segment(struct kimage *image, int idx)
 	kimage_entry_t *ptr, entry;
 	struct page **src_pages;
 	unsigned int npages;
+	struct page *cma;
 	void *vaddr = NULL;
 	int i;
 
+	cma = image->segment_cma[idx];
+	if (cma)
+		return page_address(cma);
+
 	addr = image->segment[idx].mem;
 	size = image->segment[idx].memsz;
 	eaddr = addr + size;
-
 	/*
 	 * Collect the source pages and map them in a contiguous VA range.
 	 */
@@ -1007,7 +1011,8 @@ void *kimage_map_segment(struct kimage *image, int idx)
 
 void kimage_unmap_segment(void *segment_buffer)
 {
-	vunmap(segment_buffer);
+	if (is_vmalloc_addr(segment_buffer))
+		vunmap(segment_buffer);
 }
 
 struct kexec_load_limit {
-- 
2.49.0


