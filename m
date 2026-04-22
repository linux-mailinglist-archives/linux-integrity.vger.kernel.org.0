Return-Path: <linux-integrity+bounces-9278-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GgiCfX36GkgSQIAu9opvQ
	(envelope-from <linux-integrity+bounces-9278-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Apr 2026 18:31:49 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8629F448B04
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Apr 2026 18:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E555930A7FC5
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Apr 2026 16:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C26237EFE7;
	Wed, 22 Apr 2026 16:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="aShFwVrm"
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF909382F07;
	Wed, 22 Apr 2026 16:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776875113; cv=none; b=paE1Zd8xRo6tmOu0ETUz6teILT9VumCJkOuWsTuVKjrNXL+81hb0bhezxDezSW6IM4b/9TQjgN6S1wcRrSCqlkIIjA+pC1SExNh1aUY/53i9oU3hbvAuH0Oajc/N+/vo6IoUdWPcJ9Yl4WhtXs7pvhaurYI811HkkNsY+lIoCl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776875113; c=relaxed/simple;
	bh=p1P7064kmMhgtlws9zeKxghPUZ98VVQ0ak9x2NaDMiw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ntdAlB4l2y/xYWpjlgGZuK3BLrbnoMmyZ+nD9aUcaBzRyA+rkcHNj2ANbwnfl7srRBucYt44SzgFJ0+G1ILUPslkziTK5pYnqZ0j7HjWnnIwGAa2WU8tmSNQPasRu43PngM8qLacghohEUe3zns2mD6ZNDay2AOyuOySwyuM5BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=aShFwVrm; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CFD451F60;
	Wed, 22 Apr 2026 09:25:05 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 013153F23F;
	Wed, 22 Apr 2026 09:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1776875111; bh=p1P7064kmMhgtlws9zeKxghPUZ98VVQ0ak9x2NaDMiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aShFwVrmZpdGHDbrtBCooNTPHj2wzfDofoUxl3PVFgAvGLILf1AL/qfoUTgkVUS/3
	 Sa5iE0yFEkxX9Z5zOa2b92Zk0qehhexuvETMwxq/Y5j5U9wFzgxT7vC38/h6AMGphu
	 i8JcqFGf87kMebzHfHTzFKvxM2soY9SlxlxudMoE=
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev
Cc: paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	jarkko@kernel.org,
	jgg@ziepe.ca,
	sudeep.holla@kernel.org,
	maz@kernel.org,
	oupton@kernel.org,
	joey.gouly@arm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	noodles@meta.com,
	sebastianene@google.com,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [RFC PATCH v2 4/4] firmware: arm_ffa: check pkvm initailised when initailise ffa driver
Date: Wed, 22 Apr 2026 17:24:49 +0100
Message-Id: <20260422162449.1814615-5-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260422162449.1814615-1-yeoreum.yun@arm.com>
References: <20260422162449.1814615-1-yeoreum.yun@arm.com>
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
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[paul-moore.com,namei.org,hallyn.com,linux.ibm.com,huawei.com,gmail.com,oracle.com,kernel.org,ziepe.ca,arm.com,meta.com,google.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9278-lists,linux-integrity=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yeoreum.yun@arm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-integrity];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arm.com:email,arm.com:dkim,arm.com:mid]
X-Rspamd-Queue-Id: 8629F448B04
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When pKVM is enabled, the FF-A driver must be initialized after pKVM.
Otherwise, pKVM cannot negotiate the FF-A version or
obtain RX/TX buffer information, leading to failures in FF-A calls.

During FF-A driver initialization, check whether pKVM has been initialized.
If pKVM isn't initailised, register notifier and do initialisation
of FF-A driver when pKVM is initialized.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 arch/arm64/include/asm/virt.h     | 11 ++++++++++
 arch/arm64/kvm/arm.c              | 21 ++++++++++++++++++
 arch/arm64/kvm/pkvm.c             |  2 ++
 drivers/firmware/arm_ffa/common.h |  4 ++--
 drivers/firmware/arm_ffa/driver.c | 36 ++++++++++++++++++++++++++++++-
 drivers/firmware/arm_ffa/smccc.c  |  2 +-
 6 files changed, 72 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
index b51ab6840f9c..ad038a3b8727 100644
--- a/arch/arm64/include/asm/virt.h
+++ b/arch/arm64/include/asm/virt.h
@@ -68,6 +68,8 @@
 #include <asm/sysreg.h>
 #include <asm/cpufeature.h>

+struct notifier_block;
+
 /*
  * __boot_cpu_mode records what mode CPUs were booted in.
  * A correctly-implemented bootloader must start all CPUs in the same mode:
@@ -166,6 +168,15 @@ static inline bool is_hyp_nvhe(void)
 	return is_hyp_mode_available() && !is_kernel_in_hyp_mode();
 }

+enum kvm_arm_event {
+	PKVM_INITIALISED,
+	KVM_ARM_EVENT_MAX,
+};
+
+extern int kvm_arm_event_notifier_call_chain(enum kvm_arm_event event, void *data);
+extern int kvm_arm_event_notifier_register(struct notifier_block *nb);
+extern int kvm_arm_event_notifier_unregister(struct notifier_block *nb);
+
 #endif /* __ASSEMBLER__ */

 #endif /* ! __ASM__VIRT_H */
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 410ffd41fd73..8da10049ab65 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -14,6 +14,7 @@
 #include <linux/vmalloc.h>
 #include <linux/fs.h>
 #include <linux/mman.h>
+#include <linux/notifier.h>
 #include <linux/sched.h>
 #include <linux/kvm.h>
 #include <linux/kvm_irqfd.h>
@@ -111,6 +112,8 @@ DECLARE_KVM_NVHE_PER_CPU(struct kvm_nvhe_init_params, kvm_init_params);

 DECLARE_KVM_NVHE_PER_CPU(struct kvm_cpu_context, kvm_hyp_ctxt);

+BLOCKING_NOTIFIER_HEAD(kvm_arm_event_notifier_head);
+
 static bool vgic_present, kvm_arm_initialised;

 static DEFINE_PER_CPU(unsigned char, kvm_hyp_initialized);
@@ -3064,4 +3067,22 @@ enum kvm_mode kvm_get_mode(void)
 	return kvm_mode;
 }

+int kvm_arm_event_notifier_call_chain(enum kvm_arm_event event, void *data)
+{
+	return blocking_notifier_call_chain(&kvm_arm_event_notifier_head,
+					    event, data);
+}
+
+int kvm_arm_event_notifier_register(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&kvm_arm_event_notifier_head, nb);
+}
+EXPORT_SYMBOL_GPL(kvm_arm_event_notifier_register);
+
+int kvm_arm_event_notifier_unregister(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&kvm_arm_event_notifier_head, nb);
+}
+EXPORT_SYMBOL_GPL(kvm_arm_event_notifier_unregister);
+
 module_init(kvm_arm_init);
diff --git a/arch/arm64/kvm/pkvm.c b/arch/arm64/kvm/pkvm.c
index d7a0f69a9982..e76562b0a45a 100644
--- a/arch/arm64/kvm/pkvm.c
+++ b/arch/arm64/kvm/pkvm.c
@@ -280,6 +280,8 @@ static int __init finalize_pkvm(void)
 	ret = pkvm_drop_host_privileges();
 	if (ret)
 		pr_err("Failed to finalize Hyp protection: %d\n", ret);
+	else
+		kvm_arm_event_notifier_call_chain(PKVM_INITIALISED, NULL);

 	return ret;
 }
diff --git a/drivers/firmware/arm_ffa/common.h b/drivers/firmware/arm_ffa/common.h
index 9c6425a81d0d..5cdf4bd222c6 100644
--- a/drivers/firmware/arm_ffa/common.h
+++ b/drivers/firmware/arm_ffa/common.h
@@ -18,9 +18,9 @@ bool ffa_device_is_valid(struct ffa_device *ffa_dev);
 void ffa_device_match_uuid(struct ffa_device *ffa_dev, const uuid_t *uuid);

 #ifdef CONFIG_ARM_FFA_SMCCC
-int __init ffa_transport_init(ffa_fn **invoke_ffa_fn);
+int ffa_transport_init(ffa_fn **invoke_ffa_fn);
 #else
-static inline int __init ffa_transport_init(ffa_fn **invoke_ffa_fn)
+static inline int ffa_transport_init(ffa_fn **invoke_ffa_fn)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 02c76ac1570b..67df053e65b8 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -35,6 +35,7 @@
 #include <linux/module.h>
 #include <linux/mm.h>
 #include <linux/mutex.h>
+#include <linux/notifier.h>
 #include <linux/of_irq.h>
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
@@ -42,6 +43,8 @@
 #include <linux/uuid.h>
 #include <linux/xarray.h>

+#include <asm/virt.h>
+
 #include "common.h"

 #define FFA_DRIVER_VERSION	FFA_VERSION_1_2
@@ -2029,7 +2032,7 @@ static void ffa_notifications_setup(void)
 	ffa_notifications_cleanup();
 }

-static int __init ffa_init(void)
+static int __ffa_init(void)
 {
 	int ret;
 	u32 buf_sz;
@@ -2105,11 +2108,42 @@ static int __init ffa_init(void)
 free_drv_info:
 	kfree(drv_info);
 	return ret;
+
+}
+
+static int ffa_kvm_arm_event_handler(struct notifier_block *nb,
+				     unsigned long event, void *unused)
+{
+	if (event == PKVM_INITIALISED)
+		__ffa_init();
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block ffa_kvm_arm_event_notifier = {
+	.notifier_call = ffa_kvm_arm_event_handler,
+};
+
+static int __init ffa_init(void)
+{
+	/*
+	 * When pKVM is enabled, the FF-A driver must be initialized
+	 * after pKVM initialization. Otherwise, pKVM cannot negotiate
+	 * the FF-A version or obtain RX/TX buffer information,
+	 * which leads to failures in FF-A calls.
+	 */
+	if (IS_ENABLED(CONFIG_KVM) && is_protected_kvm_enabled() &&
+	    !is_pkvm_initialized())
+		return kvm_arm_event_notifier_register(&ffa_kvm_arm_event_notifier);
+
+	return __ffa_init();
 }
 device_initcall(ffa_init);

 static void __exit ffa_exit(void)
 {
+	if (IS_ENABLED(CONFIG_KVM))
+		kvm_arm_event_notifier_unregister(&ffa_kvm_arm_event_notifier);
 	ffa_notifications_cleanup();
 	ffa_partitions_cleanup();
 	ffa_rxtx_unmap();
diff --git a/drivers/firmware/arm_ffa/smccc.c b/drivers/firmware/arm_ffa/smccc.c
index 4d85bfff0a4e..e6125dd9f58f 100644
--- a/drivers/firmware/arm_ffa/smccc.c
+++ b/drivers/firmware/arm_ffa/smccc.c
@@ -17,7 +17,7 @@ static void __arm_ffa_fn_hvc(ffa_value_t args, ffa_value_t *res)
 	arm_smccc_1_2_hvc(&args, res);
 }

-int __init ffa_transport_init(ffa_fn **invoke_ffa_fn)
+int ffa_transport_init(ffa_fn **invoke_ffa_fn)
 {
 	enum arm_smccc_conduit conduit;

--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


