Return-Path: <linux-integrity+bounces-9440-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sA/SJ63A+WlADAMAu9opvQ
	(envelope-from <linux-integrity+bounces-9440-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 05 May 2026 12:04:29 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE024CA63E
	for <lists+linux-integrity@lfdr.de>; Tue, 05 May 2026 12:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 30A6730A0F58
	for <lists+linux-integrity@lfdr.de>; Tue,  5 May 2026 09:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E7E33ADA2;
	Tue,  5 May 2026 09:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Yh7SOAi6"
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2776833A6E0;
	Tue,  5 May 2026 09:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777974860; cv=none; b=dxd7JR6P/feHoaNdRWTsqShWd4KcG+KCWysaLaQ2PPPPmu4T2Nqn0CsXjGzjJoZt+uoZggQCQx9SsUE9awnTPY+ECixbxrvoFWjmbPoI3Gl+JsMDISAlTu8DLZab5H0p1cvl4EgNbPI0tqIS4vOfgLyZiOiTBUKiw0wQ5qACqVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777974860; c=relaxed/simple;
	bh=Uc19ZfCIAh0nPkICzdLt7MNyyqOESbRbbejxWvSRJWk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IT/+ICIqD7cQDLnw7omDrWq4wz74vFMONhIJ1hQ2hWZPGPe1W6rk0ESwMeHAFxcfXEEUyvJfj4aDijt4fnx4A+zme7dWaXA6zZr60E9AH9Jqb+p7fKon3PGIL9aSnHmS5j69kFi6usHfsd5u1cHbH6mo8Pn37xObIPY6hFrL1L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Yh7SOAi6; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2BF8C293B;
	Tue,  5 May 2026 02:54:13 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2B4373F836;
	Tue,  5 May 2026 02:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777974858; bh=Uc19ZfCIAh0nPkICzdLt7MNyyqOESbRbbejxWvSRJWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yh7SOAi6kX06Dnx9lbc1gJXI1mfeiNmN1SZ4WwL/IXyj1tx7/AFx48IO8kH5YvkLB
	 ABMje3EqrqQMbVUst6/Q9oehZgRy6pmgWlK5Ctf8WdQMFJgJLmSi44Sdqsjg2xc9iQ
	 s/MgKSa5UGEQuubPn7t/ghbwqytP4mevTJZhcNyw=
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev
Cc: jarkko@kernel.org,
	zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	maz@kernel.org,
	oupton@kernel.org,
	joey.gouly@arm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	sudeep.holla@kernel.org,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [RFC PATCH 1/3] arm64: KVM: defer kvm_init() to finalise_pkvm() when pKVM is enabled
Date: Tue,  5 May 2026 10:54:07 +0100
Message-Id: <20260505095409.1948371-2-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260505095409.1948371-1-yeoreum.yun@arm.com>
References: <20260505095409.1948371-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1BE024CA63E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,arm.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9440-lists,linux-integrity=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yeoreum.yun@arm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-integrity];
	NEURAL_HAM(-0.00)[-0.995];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arm.com:email,arm.com:dkim,arm.com:mid]

This patch is a preparatory change to address dependency issues
between the FF-A driver and pKVM.

kvm_init() should be invoked from finalise_pkvm(),
as this is the point where pKVM initialisation is finalised and
the system transitions into the protected mode.

Deferring kvm_init() ensures that KVM is initialised only after pKVM has
fully established its protected environment.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 arch/arm64/kvm/arm.c  |  8 +++++---
 arch/arm64/kvm/pkvm.c | 15 ++++++++++++++-
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 8bb2c7422cc8..663b1d447a9b 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -3025,9 +3025,11 @@ static __init int kvm_arm_init(void)
 	 * FIXME: Do something reasonable if kvm_init() fails after pKVM
 	 * hypervisor protection is finalized.
 	 */
-	err = kvm_init(sizeof(struct kvm_vcpu), 0, THIS_MODULE);
-	if (err)
-		goto out_subs;
+	if (!is_protected_kvm_enabled()) {
+		err = kvm_init(sizeof(struct kvm_vcpu), 0, THIS_MODULE);
+		if (err)
+			goto out_subs;
+	}
 
 	/*
 	 * This should be called after initialization is done and failure isn't
diff --git a/arch/arm64/kvm/pkvm.c b/arch/arm64/kvm/pkvm.c
index 053e4f733e4b..48b06d384570 100644
--- a/arch/arm64/kvm/pkvm.c
+++ b/arch/arm64/kvm/pkvm.c
@@ -17,6 +17,7 @@
 #include "hyp_constants.h"
 
 DEFINE_STATIC_KEY_FALSE(kvm_protected_mode_initialized);
+EXPORT_SYMBOL_GPL(kvm_protected_mode_initialized);
 
 static struct memblock_region *hyp_memory = kvm_nvhe_sym(hyp_memory);
 static unsigned int *hyp_memblock_nr_ptr = &kvm_nvhe_sym(hyp_memblock_nr);
@@ -289,10 +290,22 @@ static int __init finalize_pkvm(void)
 	kmemleak_free_part(__hyp_rodata_start, __hyp_rodata_end - __hyp_rodata_start);
 	kmemleak_free_part_phys(hyp_mem_base, hyp_mem_size);
 
-	ret = pkvm_drop_host_privileges();
+	ret = kvm_init(sizeof(struct kvm_vcpu), 0, THIS_MODULE);
 	if (ret)
+		goto out_err;
+
+	ret = pkvm_drop_host_privileges();
+	if (ret) {
 		pr_err("Failed to finalize Hyp protection: %d\n", ret);
+		kvm_exit();
+		goto out_err;
+	}
+
+	return 0;
 
+out_err:
+	kvm_unregister_perf_callbacks();
+	kvm_arm_vmid_alloc_free();
 	return ret;
 }
 device_initcall_sync(finalize_pkvm);
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


