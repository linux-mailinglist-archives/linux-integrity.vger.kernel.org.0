Return-Path: <linux-integrity+bounces-8415-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GO1AAFp2gWkYGgMAu9opvQ
	(envelope-from <linux-integrity+bounces-8415-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 03 Feb 2026 05:15:22 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 86748D45C2
	for <lists+linux-integrity@lfdr.de>; Tue, 03 Feb 2026 05:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C9DCE3045A1B
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Feb 2026 04:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5AC322C78;
	Tue,  3 Feb 2026 04:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SkLjgWmh";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="L5I5bvja"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6432D130C
	for <linux-integrity@vger.kernel.org>; Tue,  3 Feb 2026 04:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770092102; cv=none; b=LoKo4E20jNjwNpT+2ZHsnmcJvyxIsdQzjMjgVZcBMogD48hCVo/W8/ye5kMjVwdIhDWQ3fjMnXHaAm7cj/HEIsHl3xS84OWg/ny2EQYMkcrklEwYcChEx6Om+VMnqMdQxVytG4rBhJ8ZhK/yBmfYa46a8fy7WXT2PkCJgTfc8V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770092102; c=relaxed/simple;
	bh=6V5x4eZjC0hFctwCre+f1/5kPFFASW1PwXbyC2KH1uI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b1V2krGI1b+4Yun7Au3vScUdzKGgawtavUQhTp7/cEAQQ5IglyUPyt05Yn/CWUe0T4B++oZr8srsJZNo08DAcmlkPsGdW0fN0TJpflHS27iPp4mwmb9a3iI2gK71J816MnrBsO69ONcTp2lm2Ql2T9ZPKVEPUizcJmGRl7rHrmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SkLjgWmh; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=L5I5bvja; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770092099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X4Upg9+MeOzlqdVPPGSlv7n6ggK/vlBPBgeg9qsgORs=;
	b=SkLjgWmhXAmj0xHsF6zPJLDQd5FlZjzH3rm1hMKo4W/zJPd/6cVeaJmyHTA2872ogEMxBS
	XAw4IidgNTq3u652n15+YoiEzve1rKcYjwxGqSAOjDTE5IhwmkD8FpsBULvIH5h4YsS/Sj
	aF39LTlgaOB5spFr1QG1biTt5xoic5s=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-hpshjgmlPBu-RuqOv_NO9w-1; Mon, 02 Feb 2026 23:14:58 -0500
X-MC-Unique: hpshjgmlPBu-RuqOv_NO9w-1
X-Mimecast-MFC-AGG-ID: hpshjgmlPBu-RuqOv_NO9w_1770092098
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-81f48cec0ccso4333341b3a.0
        for <linux-integrity@vger.kernel.org>; Mon, 02 Feb 2026 20:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770092097; x=1770696897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X4Upg9+MeOzlqdVPPGSlv7n6ggK/vlBPBgeg9qsgORs=;
        b=L5I5bvjaVZysA5Q34weL4+mT45JriWkl4hZiO9bXOANvr/0CV5Y9p/cQyz9Oar4rD1
         pgmnSE9MvrdJP8oiXi0Hf+HjhxQ8stWVhM/miDGenQoh3wJBvPvjwC9lCVe209omPkGw
         TLL2KWmRie/yorsStHvMvIj4hnq1O8uDwCpdd9ObVCaJBdbT87dIi1l0SFGb7CIivQzU
         JITKGRmjIF4EHW3AhfPxvVpTGbz0XYrAJdTtPQWcEJR8U1LczpaOYIyXzeeNXqF038HV
         3Gn+13GcyOp3/cKKZIaSKjdv2phu4Rq28HYY+r3gaDElTd6lbs1uvD+yt41IeFUzV5YM
         h4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770092097; x=1770696897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X4Upg9+MeOzlqdVPPGSlv7n6ggK/vlBPBgeg9qsgORs=;
        b=O82RgMnsz5OMtxYmBl+VXdbZ/dEbypX5r29kLTzguDlIj9z2QjOCinAKUgo7N3XbSC
         nLGWv5oNzuLgGHXtFs9bWziU2abrZ8l1ry3o8BmhvHE7jL/WhrQKZGAkJPtLiN5+cqmu
         ++2/aiNe43M4uXijfDqprYmuYyCs+fOnU7oyKAZ+5Y6VzWkawcstIIZOUjYIL5+Q8G+t
         VGYl2p8/BUipDZ4BHYPcFN1S4MbhUkwMQUpRqSk7nURwn6vMxTDLL/alkF2w4y1Tv26r
         Nku6qwp/xf4FzeJsqOUHmlL+RMo58bYhYgF6eKZOjklArZ0/Ro8pKTyHY59P3iG0OdXP
         p56g==
X-Gm-Message-State: AOJu0YxpCJToFoRfbYwgyAWYiTsmd69p0IQ02REPG3uO9Key1Zhjz7WR
	gotjpQ4cDFofSJa8uoeVLMR9WmyEFd6jRaCosj67NFlstsvVMvUDH1VMk9BRrmmdHsPGbpLFXK6
	S34RLPHNqHcNgWF7M1gGYl9yXjzCBkW+iaeNa3w6KTXxK3D2/9eT0NMInRG1EC/VgSUU5FOH5h3
	HLr5Tufe2gl9l+TGYj4oQOfax+NxrDNTZUk//uIptSA0yEJHCjH6k=
X-Gm-Gg: AZuq6aLx/TeS8D10vIvyjSYptsYUXXSjK18hRszdqINPYA2xwYaw7TLI7LxLq7N0ghq
	4d1+5nwFmW6M9TPEiK2K+d43FMo1cmy9nsyRtvqDu58AlIESYZL0CuEBUHb07si3PliS/+r54vD
	v4LDEO5igoz94UgS4Yv3KaebNQo54YoWPasGb6TS8k3gItbzT2mrQVxkwaMeGKj2i6dxI1VPIr5
	waGbPQ1ZIYxxVog3uyKOYaQfNYoRgHN4+dU550Gho12hYbppIvlczqGjGLl4krIkCebhpotNR58
	Xzczq5al3wrxS8JYQh+VNRuiamAthW7/K6W0ScwwFzgRPTQD8Z1dhRNQNWUMZ+beYO0NwoHKOOi
	s
X-Received: by 2002:a05:6a00:248f:b0:81f:d605:b2c with SMTP id d2e1a72fcca58-823ab873c6emr9784952b3a.48.1770092097340;
        Mon, 02 Feb 2026 20:14:57 -0800 (PST)
X-Received: by 2002:a05:6a00:248f:b0:81f:d605:b2c with SMTP id d2e1a72fcca58-823ab873c6emr9784922b3a.48.1770092096753;
        Mon, 02 Feb 2026 20:14:56 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379c64b4esm17118955b3a.69.2026.02.02.20.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 20:14:56 -0800 (PST)
From: Coiby Xu <coxu@redhat.com>
To: linux-integrity@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
	Alexander Egorenkov <egorenar@linux.ibm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	linux-s390@vger.kernel.org (open list:S390 ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 3/3] s390: Drop unnecessary CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT
Date: Tue,  3 Feb 2026 12:14:31 +0800
Message-ID: <20260203041434.872784-4-coxu@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203041434.872784-1-coxu@redhat.com>
References: <20260203041434.872784-1-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8415-lists,linux-integrity=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[coxu@redhat.com,linux-integrity@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_RCPT(0.00)[linux-integrity];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 86748D45C2
X-Rspamd-Action: no action

Commit b5ca117365d9 ("ima: prevent kexec_load syscall based on runtime
secureboot flag") and commit 268a78404973 ("s390/kexec_file: Disable
kexec_load when IPLed secure") disabled the kexec_load syscall based
on the secureboot mode. Commit 9e2b4be377f0 ("ima: add a new CONFIG
for loading arch-specific policies") needed to detect the secure boot
mode, not to load an IMA architecture specific policy. Since there is
the new CONFIG_INTEGRITY_SECURE_BOOT, drop
CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT for s390.

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 arch/s390/Kconfig           | 1 -
 arch/s390/kernel/Makefile   | 1 -
 arch/s390/kernel/ima_arch.c | 8 --------
 3 files changed, 10 deletions(-)
 delete mode 100644 arch/s390/kernel/ima_arch.c

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 0e5fad5f06ca..d8e62c67d1ad 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -77,7 +77,6 @@ config S390
 	#
 	# Note: keep this list sorted alphabetically
 	#
-	imply IMA_SECURE_AND_OR_TRUSTED_BOOT
 	select ALTERNATE_USER_ADDRESS_SPACE
 	select ARCH_32BIT_USTAT_F_TINODE
 	select ARCH_CORRECT_STACKTRACE_ON_KRETPROBE
diff --git a/arch/s390/kernel/Makefile b/arch/s390/kernel/Makefile
index 42c83d60d6fa..89a2c8078fe7 100644
--- a/arch/s390/kernel/Makefile
+++ b/arch/s390/kernel/Makefile
@@ -71,7 +71,6 @@ obj-$(CONFIG_STACKPROTECTOR)	+= stackprotector.o
 obj-$(CONFIG_KEXEC_FILE)	+= machine_kexec_file.o kexec_image.o
 obj-$(CONFIG_KEXEC_FILE)	+= kexec_elf.o
 obj-$(CONFIG_CERT_STORE)	+= cert_store.o
-obj-$(CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT)	+= ima_arch.o
 
 obj-$(CONFIG_PERF_EVENTS)	+= perf_event.o
 obj-$(CONFIG_PERF_EVENTS)	+= perf_cpum_cf.o perf_cpum_sf.o
diff --git a/arch/s390/kernel/ima_arch.c b/arch/s390/kernel/ima_arch.c
deleted file mode 100644
index 6ccbe34ce408..000000000000
--- a/arch/s390/kernel/ima_arch.c
+++ /dev/null
@@ -1,8 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <linux/ima.h>
-
-const char * const *arch_get_ima_policy(void)
-{
-	return NULL;
-}
-- 
2.52.0


