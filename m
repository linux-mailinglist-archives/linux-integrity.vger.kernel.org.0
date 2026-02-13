Return-Path: <linux-integrity+bounces-8500-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIH0E59+jmnJCgEAu9opvQ
	(envelope-from <linux-integrity+bounces-8500-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Feb 2026 02:30:07 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BD51324A4
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Feb 2026 02:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C29C930EDE70
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Feb 2026 01:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9146B21B9F5;
	Fri, 13 Feb 2026 01:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KXxECqw8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kl9tKTxJ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4205222424C
	for <linux-integrity@vger.kernel.org>; Fri, 13 Feb 2026 01:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770946155; cv=none; b=RrDAeVggp26CC8C4MSNq7ibxu58cc/6Cvut43OkjQvzj114v9n47lG0kfca/Cp3VKou+vGlud5gBkEvjK7Jow0VCyxJd4CnJOp0eaQuPkHSXOMGpyDACdIE8NHz8Ikf2fCbiIPGn0oY4QeyJ5SDFr0aqHi8B0p59EQvPXkwWXIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770946155; c=relaxed/simple;
	bh=Vme0Fj5+r+RgqwO7UkH0xUC8lNiShmss8o1nep9nK2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q9HfBWdhY66o50ggc7UsQ9PMWkTu6RaxUDReAH+ptfUpWf9HCisEu2G+D+Qf94OWRyDQn4YhMJQFHsLtYwvo7vlXn0EHhz228pJZFZ9S0RZsdi6sKpXU35wohqNYDx+MsUvYxiwf76bxiaI1oSNkroxudE9D0z5rvvcLXHPT8T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KXxECqw8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kl9tKTxJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770946153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VARgI5OKS/2+wZcl1XvKw6nXtq66m52RIASbt0OFdaQ=;
	b=KXxECqw8ffVneeyR9b//F3Aqlspnug9O/O6CRnV9Sx1RcK6U8LX9HvBNxpz5Chx2n2bdpW
	WZx/B7rSpJi6QXOQhGChEe8RAKVCYqPTIpWnzoobRnRzwk34k6vK3EqyLEZ0nC2fd+PwfY
	vPXdK9BROd+K7WoxhLKxwX02V7T9WEE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-IZb3s8dxPF2Das6l9o0LVQ-1; Thu, 12 Feb 2026 20:29:12 -0500
X-MC-Unique: IZb3s8dxPF2Das6l9o0LVQ-1
X-Mimecast-MFC-AGG-ID: IZb3s8dxPF2Das6l9o0LVQ_1770946151
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-354be486779so1365268a91.0
        for <linux-integrity@vger.kernel.org>; Thu, 12 Feb 2026 17:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770946151; x=1771550951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VARgI5OKS/2+wZcl1XvKw6nXtq66m52RIASbt0OFdaQ=;
        b=Kl9tKTxJQVDf0wRyBxSQXzM7N/3kZhwWwxktNhlAI+N/a9XGas8UqkUfzaPTdldQ2g
         0nvzNpZNTMln92KXtRRZFQjkWCrCSVpmt/A052hlCM5qozZM/jQfQRT9CMJJgJAG2GG0
         JupIkdnC7gpOeG4Nw2DXDZdXZNxFSG0UTrtqrt6E28V0pr/5BxB+dPIPmSszbPeXhEK8
         86HLoO5Bfgv24o2E3Sqg+y9waipqyafyjH1QDHib9Pfz01YuO2GHcr/J/3eCmFN4rg1E
         Y8kityPNCCMtSbuJ5ssqRvKL0qKVnVtmCqwZN5s/FicdOXU04T7/2ebqPeYCprHpSqvZ
         78JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770946151; x=1771550951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VARgI5OKS/2+wZcl1XvKw6nXtq66m52RIASbt0OFdaQ=;
        b=ecv0ecOGpKqp5dd5ALVEcMvrmJS3/Oj55LbnlzlYn7Yt0jjLgv4sZJblxdKscPFUA4
         t/S5l8qglZIrQmnHg7dKGYIRI4cXHjfzl+9g/RH4eIk+FmUeH039WYcToLC7q9e/BDbh
         c0bTBXM/XQ137ueIqViUnJxRZUxoR/I12gGBzushQ15M1v3upbDkV0ANRs1wQbNKNdsB
         QSHGWPuW+w5KZoH+5O1Qis5PtzncLyvsfjd9l75i0CSOUGH3AiLKl4HWl45Pu6jvYHux
         FK4DTikmrz8ZNn2HpDp0tdeQfKnh+Dj5Tx49MADZWHaJ2JVrkwQsE6qHrXjFxpRNoebK
         qgmA==
X-Gm-Message-State: AOJu0YwLaYFL/6XXLV7MFfkn/79xmT2D4dRLF5CscaP2sUct/UCVR8oL
	R6C7bKzBPimu87FY997zXW9XF1jYyH3pYOzMijKmrb1oPgcyxrFvMBieefAdr8GRcBpgAXdVEQT
	5FCY+XJ+hlHJLQUv1K98v6OTS7S+c5bLuapzyBSxkUfTQ23ux1odAz/KxmiLlW28H57lMsrl2mg
	YTeXh78qb8Vl55dnGAf1CIE0R9BvU4oRHAJTNd0+xT2Xi6JfdhVH4=
X-Gm-Gg: AZuq6aIzu1ugvpA4R9/JWGvRCBWuOuE7je/LFlvRCLJhbeHulCHBTyVQXfGN4CXztXM
	t4DUcdOj+pAaw5iTzr6WSHq+sn+iOeJTL7tFMAfJqcyLD0Ka0JrfpGAgBvGyH6FiKEC+P7KAju0
	/x8b7QKCtwMDhxHHjZmJAboIAB2dM6xT6crUh4Upx11MQ6xKdgsD3sL3HOg3sK2b2Z9EP/uHAoN
	XGsDPDRcs6mffCHNC8hXqdmauVph7Liy0SYMbJv7NkudbDMnJRKWP50RmymXu5mFKgb9R5W8t2F
	OXZN7NSb2x8Fn3jNUVpSJ2qhCG5Ruxd9hVNhVL9buhrmrX/tmWWUcFKt66rmkUfJJz74PDzN73e
	FGNOIsrjFh5Tw
X-Received: by 2002:a17:90b:33c4:b0:354:c7f8:6d7b with SMTP id 98e67ed59e1d1-356aad5eedfmr342635a91.27.1770946150736;
        Thu, 12 Feb 2026 17:29:10 -0800 (PST)
X-Received: by 2002:a17:90b:33c4:b0:354:c7f8:6d7b with SMTP id 98e67ed59e1d1-356aad5eedfmr342600a91.27.1770946150252;
        Thu, 12 Feb 2026 17:29:10 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-356a6b5f21csm378811a91.1.2026.02.12.17.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 17:29:09 -0800 (PST)
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
Subject: [PATCH v3 3/3] s390: Drop unnecessary CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT
Date: Fri, 13 Feb 2026 09:28:48 +0800
Message-ID: <20260213012851.2532722-4-coxu@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260213012851.2532722-1-coxu@redhat.com>
References: <20260213012851.2532722-1-coxu@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8500-lists,linux-integrity=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[coxu@redhat.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[11];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E6BD51324A4
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
index cda697a03abf..f6cb528aae5e 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -83,7 +83,6 @@ config S390
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
2.53.0


