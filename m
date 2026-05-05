Return-Path: <linux-integrity+bounces-9441-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEN4GbbA+WlADAMAu9opvQ
	(envelope-from <linux-integrity+bounces-9441-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 05 May 2026 12:04:38 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE744CA65B
	for <lists+linux-integrity@lfdr.de>; Tue, 05 May 2026 12:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D7593057271
	for <lists+linux-integrity@lfdr.de>; Tue,  5 May 2026 09:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC7A33B6DF;
	Tue,  5 May 2026 09:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="B/Sqmf9D"
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C8434166B;
	Tue,  5 May 2026 09:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777974865; cv=none; b=aZIotFNUChO3lbw6C+JEWXDAVmu9UuKAerAItEqUMerDLsxbzxHENXAEZcZS+z1yjBrE7EEQ2ChO2ycQDnnigRaNbgjAyfWEM8wPyYkUrWNxZvvBzWa+95JgSVjnBz6t3xEwQMN1vzy3qEZ4KikgxI47PjpU9FewGhElYFVvuEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777974865; c=relaxed/simple;
	bh=0tcBr9vn16J+l1sCPfUyD1pBA+fekMLt2qOzTtka3GI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b/y+//dfsENDdXAtH6dTDXmziWgwDE5rTygZziDzfkufqCoajBwFWb6o9haAtQxVC2EsqFG/pIgcV5hZyXWIhDwvez3ud3PwaNaXN0QhpmO4iFY+NIlSr6aH65fO7iV5MrE0kqf8ySr7HOVPOIEZzbTL6SropyPnPswgZFUgPkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=B/Sqmf9D; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C20DA2E8E;
	Tue,  5 May 2026 02:54:16 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C4FA83F836;
	Tue,  5 May 2026 02:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777974862; bh=0tcBr9vn16J+l1sCPfUyD1pBA+fekMLt2qOzTtka3GI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B/Sqmf9DUprce2cJFGnJbbo8v5h84ov0D1/FCnEMKSh3PY7argzpfHutGiRkx4YrH
	 jj4AfX7IoL77lM8vqTL5yJMMBAZfWUA09SqyfydC8TasOsc4+cqVX4fmyGkImYI7lr
	 EyV1oaAGfo5b/APPKGpIUuv6SsCoKIy7LOvGauSA=
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
Subject: [RFC PATCH 2/3] firmware: arm_ffa: initialise ff-a after finalising pKVM initialisation
Date: Tue,  5 May 2026 10:54:08 +0100
Message-Id: <20260505095409.1948371-3-yeoreum.yun@arm.com>
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
X-Rspamd-Queue-Id: CEE744CA65B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	FREEMAIL_CC(0.00)[kernel.org,linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,arm.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9441-lists,linux-integrity=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.995];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arm.com:email,arm.com:dkim,arm.com:mid]

When pKVM is enabled, the FF-A driver must be initialised after pKVM.
Otherwise, pKVM cannot negotiate the FF-A version or obtain the RX/TX
buffer information, leading to failures in FF-A calls.

Currently, pKVM initialisation completes at device_initcall_sync,
while ffa_init() runs at the device_initcall level.

So far, linker deployes kvm_arm_init() before ffa_init(), and SMCs can
still be trapped even before finalise_pkvm() is invoked.
As a result, this issue has not been observed.

However, relying on above stuff is fragile.
Therefore, when pKVM is enabled, the FF-A infrastructure should be
initialised only after pKVM initialisation has been fully finalised.

To achieve this, introduce an ffa_root_dev ("arm-ffa") and
a corresponding driver to defer initialisation of the FF-A infrastructure
until pKVM initialisation is complete, and to defer probing of all FF-A devices until then
when pKVM is enabled.

This change slightly alters the sysfs layout.

Previously, all FF-A devices were located directly under /sys/devices/,
for example:

  ls /sys/devices/
  ...
  arm-ffa-1
  arm-ffa-2
  arm-ffa-3
  ...

After this patch, all FF-A devices are placed under the FF-A root device
/sys/devices/arm-ffa/:

  ls /sys/devices/arm-ffa/
  ...
  arm-ffa-1
  arm-ffa-2
  arm-ffa-3
  ...

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 drivers/firmware/arm_ffa/bus.c    | 125 ++++++++++++++++++++++++++++--
 drivers/firmware/arm_ffa/common.h |  13 +++-
 drivers/firmware/arm_ffa/driver.c |  21 +++--
 drivers/firmware/arm_ffa/smccc.c  |   2 +-
 4 files changed, 146 insertions(+), 15 deletions(-)

diff --git a/drivers/firmware/arm_ffa/bus.c b/drivers/firmware/arm_ffa/bus.c
index 9576862d89c4..ddb352806d59 100644
--- a/drivers/firmware/arm_ffa/bus.c
+++ b/drivers/firmware/arm_ffa/bus.c
@@ -13,11 +13,14 @@
 #include <linux/slab.h>
 #include <linux/types.h>
 
+#include <asm/virt.h>
+
 #include "common.h"
 
 #define FFA_UEVENT_MODALIAS_FMT	"arm_ffa:%04x:%pUb"
 
 static DEFINE_IDA(ffa_bus_id);
+static struct ffa_device *ffa_root_dev;
 
 static int ffa_device_match(struct device *dev, const struct device_driver *drv)
 {
@@ -27,7 +30,13 @@ static int ffa_device_match(struct device *dev, const struct device_driver *drv)
 	id_table = to_ffa_driver(drv)->id_table;
 	ffa_dev = to_ffa_dev(dev);
 
-	while (!uuid_is_null(&id_table->uuid)) {
+	if (is_ffa_root_device(ffa_dev)) {
+		if (!id_table)
+			return 1;
+		return 0;
+	}
+
+	while (id_table && !uuid_is_null(&id_table->uuid)) {
 		/*
 		 * FF-A v1.0 doesn't provide discovery of UUIDs, just the
 		 * partition IDs, so match it unconditionally here and handle
@@ -50,7 +59,7 @@ static int ffa_device_probe(struct device *dev)
 	struct ffa_device *ffa_dev = to_ffa_dev(dev);
 
 	/* UUID can be still NULL with FF-A v1.0, so just skip probing them */
-	if (uuid_is_null(&ffa_dev->uuid))
+	if (!is_ffa_root_device(ffa_dev) && uuid_is_null(&ffa_dev->uuid))
 		return -ENODEV;
 
 	return ffa_drv->probe(ffa_dev);
@@ -68,6 +77,9 @@ static int ffa_device_uevent(const struct device *dev, struct kobj_uevent_env *e
 {
 	const struct ffa_device *ffa_dev = to_ffa_dev(dev);
 
+	if (is_ffa_root_device(ffa_dev))
+		return 0;
+
 	return add_uevent_var(env, "MODALIAS=" FFA_UEVENT_MODALIAS_FMT,
 			      ffa_dev->vm_id, &ffa_dev->uuid);
 }
@@ -114,7 +126,6 @@ const struct bus_type ffa_bus_type = {
 	.probe		= ffa_device_probe,
 	.remove		= ffa_device_remove,
 	.uevent		= ffa_device_uevent,
-	.dev_groups	= ffa_device_attributes_groups,
 };
 EXPORT_SYMBOL_GPL(ffa_bus_type);
 
@@ -149,13 +160,18 @@ static void ffa_release_device(struct device *dev)
 {
 	struct ffa_device *ffa_dev = to_ffa_dev(dev);
 
-	ida_free(&ffa_bus_id, ffa_dev->id);
+	if (!is_ffa_root_device(ffa_dev))
+		ida_free(&ffa_bus_id, ffa_dev->id);
 	kfree(ffa_dev);
 }
 
 static int __ffa_devices_unregister(struct device *dev, void *data)
 {
-	device_unregister(dev);
+	struct ffa_device *ffa_dev = to_ffa_dev(dev);
+
+	/* ffa_root_dev will be removed in arm_ffa_bus_exit(). */
+	if (!is_ffa_root_device(ffa_dev))
+		device_unregister(dev);
 
 	return 0;
 }
@@ -195,6 +211,10 @@ ffa_device_register(const struct ffa_partition_info *part_info,
 	int id, ret;
 	struct device *dev;
 	struct ffa_device *ffa_dev;
+	struct device_link *link;
+
+	if (!ffa_root_dev)
+		return NULL;
 
 	if (!part_info)
 		return NULL;
@@ -213,6 +233,8 @@ ffa_device_register(const struct ffa_partition_info *part_info,
 	dev->bus = &ffa_bus_type;
 	dev->release = ffa_release_device;
 	dev->dma_mask = &dev->coherent_dma_mask;
+	dev->parent = &ffa_root_dev->dev;
+	dev->groups = ffa_device_attributes_groups;
 	dev_set_name(&ffa_dev->dev, "arm-ffa-%d", id);
 
 	ffa_dev->id = id;
@@ -221,7 +243,18 @@ ffa_device_register(const struct ffa_partition_info *part_info,
 	ffa_dev->ops = ops;
 	uuid_copy(&ffa_dev->uuid, &part_info->uuid);
 
-	ret = device_register(&ffa_dev->dev);
+	device_initialize(dev);
+
+	link = device_link_add(dev, &ffa_root_dev->dev,
+			       DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOPROBE_CONSUMER);
+	if (!link) {
+		dev_err(dev, "unable to link device %s\n", dev_name(dev));
+		device_link_del(link);
+		put_device(dev);
+		return NULL;
+	}
+
+	ret = device_add(dev);
 	if (ret) {
 		dev_err(dev, "unable to register device %s err=%d\n",
 			dev_name(dev), ret);
@@ -242,15 +275,93 @@ void ffa_device_unregister(struct ffa_device *ffa_dev)
 }
 EXPORT_SYMBOL_GPL(ffa_device_unregister);
 
+static int __init ffa_root_device_register(void)
+{
+	int ret;
+	struct device *dev;
+	struct ffa_device *ffa_dev;
+
+	ffa_dev = kzalloc_obj(*ffa_dev);
+	if (!ffa_dev) {
+		return -ENOMEM;
+	}
+
+	dev = &ffa_dev->dev;
+	dev->bus = &ffa_bus_type;
+	dev->release = ffa_release_device;
+	dev->dma_mask = &dev->coherent_dma_mask;
+	dev_set_name(&ffa_dev->dev, "%s", "arm-ffa");
+
+	ffa_dev->id = FFA_ROOT_DEV_ID;
+
+	ret = device_register(&ffa_dev->dev);
+	if (ret) {
+		dev_err(dev, "unable to register root device. err=%d\n", ret);
+		put_device(dev);
+		return ret;
+	}
+
+	ffa_root_dev = ffa_dev;
+
+	return 0;
+}
+
+static void ffa_root_device_unregister(void)
+{
+	ffa_device_unregister(ffa_root_dev);
+	ffa_root_dev = NULL;
+}
+
+static int ffa_root_device_probe(struct ffa_device *ffa_dev)
+{
+	if (!is_ffa_root_device(ffa_dev))
+		return -EINVAL;
+
+	if (is_protected_kvm_enabled() && !is_pkvm_initialized())
+		return -EPROBE_DEFER;
+
+	return ffa_core_init();
+}
+
+static struct ffa_driver ffa_root_dev_driver = {
+	.name = "arm-ffa",
+	.probe = ffa_root_device_probe,
+	.id_table = NULL,
+};
+
+int ffa_root_device_driver_register(void)
+{
+	return ffa_driver_register(&ffa_root_dev_driver, THIS_MODULE, KBUILD_MODNAME);
+}
+
+static void ffa_root_device_driver_unregister(void)
+{
+	ffa_driver_unregister(&ffa_root_dev_driver);
+}
+
 static int __init arm_ffa_bus_init(void)
 {
-	return bus_register(&ffa_bus_type);
+	int ret;
+
+	ret = bus_register(&ffa_bus_type);
+	if (ret)
+		return ret;
+
+	ret = ffa_root_device_register();
+	if (ret) {
+		bus_unregister(&ffa_bus_type);
+		return ret;
+	}
+
+	return 0;
 }
 subsys_initcall(arm_ffa_bus_init);
 
 static void __exit arm_ffa_bus_exit(void)
 {
 	ffa_devices_unregister();
+	ffa_root_device_unregister();
+	ffa_root_device_driver_unregister();
 	bus_unregister(&ffa_bus_type);
 	ida_destroy(&ffa_bus_id);
 }
diff --git a/drivers/firmware/arm_ffa/common.h b/drivers/firmware/arm_ffa/common.h
index 9c6425a81d0d..32ffe41c3cfc 100644
--- a/drivers/firmware/arm_ffa/common.h
+++ b/drivers/firmware/arm_ffa/common.h
@@ -10,17 +10,26 @@
 #include <linux/arm-smccc.h>
 #include <linux/err.h>
 
+#define FFA_ROOT_DEV_ID	(0)
+
 typedef struct arm_smccc_1_2_regs ffa_value_t;
 
 typedef void (ffa_fn)(ffa_value_t, ffa_value_t *);
 
 bool ffa_device_is_valid(struct ffa_device *ffa_dev);
 void ffa_device_match_uuid(struct ffa_device *ffa_dev, const uuid_t *uuid);
+int ffa_root_device_driver_register(void);
+int ffa_core_init(void);
+
+static __always_inline bool is_ffa_root_device(const struct ffa_device *ffa_dev)
+{
+	return ffa_dev->id == FFA_ROOT_DEV_ID;
+}
 
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
index eb2782848283..c41e7ed4eac8 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -1610,6 +1610,9 @@ ffa_bus_notifier(struct notifier_block *nb, unsigned long action, void *data)
 		struct ffa_driver *ffa_drv = to_ffa_driver(dev->driver);
 		const struct ffa_device_id *id_table = ffa_drv->id_table;
 
+		if (is_ffa_root_device(fdev))
+			return NOTIFY_DONE;
+
 		/*
 		 * FF-A v1.1 provides UUID for each partition as part of the
 		 * discovery API, the discovered UUID must be populated in the
@@ -2029,7 +2032,7 @@ static void ffa_notifications_setup(void)
 	ffa_notifications_cleanup();
 }
 
-static int __init ffa_init(void)
+int ffa_core_init(void)
 {
 	int ret;
 	u32 buf_sz;
@@ -2106,16 +2109,24 @@ static int __init ffa_init(void)
 	kfree(drv_info);
 	return ret;
 }
-rootfs_initcall(ffa_init);
+
+static int __init ffa_init(void)
+{
+	return ffa_root_device_driver_register();
+}
+device_initcall(ffa_init);
 
 static void __exit ffa_exit(void)
 {
 	ffa_notifications_cleanup();
 	ffa_partitions_cleanup();
 	ffa_rxtx_unmap();
-	free_pages_exact(drv_info->tx_buffer, drv_info->rxtx_bufsz);
-	free_pages_exact(drv_info->rx_buffer, drv_info->rxtx_bufsz);
-	kfree(drv_info);
+
+	if (drv_info) {
+		free_pages_exact(drv_info->tx_buffer, drv_info->rxtx_bufsz);
+		free_pages_exact(drv_info->rx_buffer, drv_info->rxtx_bufsz);
+		kfree(drv_info);
+	}
 }
 module_exit(ffa_exit);
 
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


