Return-Path: <linux-integrity+bounces-9451-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EuJCu0c+mkJJgMAu9opvQ
	(envelope-from <linux-integrity+bounces-9451-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 05 May 2026 18:38:05 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D69214D16F9
	for <lists+linux-integrity@lfdr.de>; Tue, 05 May 2026 18:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A8A90308D75F
	for <lists+linux-integrity@lfdr.de>; Tue,  5 May 2026 16:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B648E48C8B4;
	Tue,  5 May 2026 16:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6QaN7/6"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9059948BD27;
	Tue,  5 May 2026 16:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777998741; cv=none; b=nxMXcBple84SfjQs6ERjch3g6B6l67YisrgVTsu6bNGfTUFjg+vCaYerm0TGamy5qdcSV13ucPlcl68xJApFweq/uFNFTn8butN4/X/rTzx9OLP5bt26vtZOZHRbB9EJu6QPv8+Hdho9dHVlM3nkt9q0EK/VIDScd2hKUKUhmqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777998741; c=relaxed/simple;
	bh=WyOQn3tBSFDpBAHnLk6bdPwqlgR7hHM6B3vxBY9JYM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ue/fNvxXFL5nDVoqWFxvtSBpletb/sQh2MiIq3OxLxzgZSeJXw/SYqSKhF/Ti+ADHG282KG2PsKQJHfzc+/6e8n93YqEKwgvEVb6rH0BBQhPoZ3bMrHFTgBjZC8ni1I2mTBgVRwiRaLuki5jhE0ejjzPwrRFaTLGlToVmVmnOtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6QaN7/6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96258C2BCC7;
	Tue,  5 May 2026 16:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777998741;
	bh=WyOQn3tBSFDpBAHnLk6bdPwqlgR7hHM6B3vxBY9JYM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l6QaN7/6Ls6N62Omndx9ZkQPQPHh93G2jiFu5owUcRgmFTRLMg6ukJpHx5Edd4ziG
	 LACt5k7L1bSoxw98UD7EqIFHLj+aq9rmSa40+t8E/aopCsGb4qLKgesvoRpp+BrxJN
	 cbOtYibJBnq/+lcOealAHGJw8tuOq1ECTNSsgTOw3VK1769Kfxa7hB84DAXgqe9MlI
	 HbTpWwMvQASxkZF6mQNiONGBOowFRPdjPlDKc2OLqp1JGQUOCuMFhTSxtawgcrIYKx
	 h43Aa/8uEpfq2JJhGfifjxtuHVurPDS680I1drxkQiXzqKLb+4b8JsG5/ZGm9M4i/U
	 0Fc5jT+9Sn3GA==
Date: Tue, 5 May 2026 17:32:15 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	Sudeep Holla <sudeep.holla@kernel.org>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	jarkko@kernel.org, zohar@linux.ibm.com, roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	maz@kernel.org, oupton@kernel.org, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org
Subject: Re: [RFC PATCH 2/3] firmware: arm_ffa: initialise ff-a after
 finalising pKVM initialisation
Message-ID: <20260505-adaptable-mussel-of-virtuosity-2751db@sudeepholla>
References: <20260505095409.1948371-1-yeoreum.yun@arm.com>
 <20260505095409.1948371-3-yeoreum.yun@arm.com>
 <20260505-super-gecko-of-argument-655030@sudeepholla>
 <afoHizU8NgFWzvYW@e129823.arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afoHizU8NgFWzvYW@e129823.arm.com>
X-Rspamd-Queue-Id: D69214D16F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9451-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,lists.infradead.org,lists.linux.dev,linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,arm.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sudeep.holla@kernel.org,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Tue, May 05, 2026 at 04:06:51PM +0100, Yeoreum Yun wrote:
> Hi Sudeep,
> 
> > On Tue, May 05, 2026 at 10:54:08AM +0100, Yeoreum Yun wrote:
> > > When pKVM is enabled, the FF-A driver must be initialised after pKVM.
> > > Otherwise, pKVM cannot negotiate the FF-A version or obtain the RX/TX
> > > buffer information, leading to failures in FF-A calls.
> > > 
> > > Currently, pKVM initialisation completes at device_initcall_sync,
> > > while ffa_init() runs at the device_initcall level.
> > > 
> > > So far, linker deployes kvm_arm_init() before ffa_init(), and SMCs can
> > > still be trapped even before finalise_pkvm() is invoked.
> > > As a result, this issue has not been observed.
> > > 
> > > However, relying on above stuff is fragile.
> > > Therefore, when pKVM is enabled, the FF-A infrastructure should be
> > > initialised only after pKVM initialisation has been fully finalised.
> > > 
> > > To achieve this, introduce an ffa_root_dev ("arm-ffa") and
> > > a corresponding driver to defer initialisation of the FF-A infrastructure
> > > until pKVM initialisation is complete, and to defer probing of all FF-A devices until then
> > > when pKVM is enabled.
> > > 
> > 
> > I don't like this whole ffa root device design.
> > Two question for now:
> > 1. Can FF-A be a module on systems with pKVM which removes the need for all
> >    this dance done here ?
> 
> But this means we reduce the other feature e.x) IMA with TPM over
> FF-A and pKVM feature. Since IMA must be a built-in, we couldn't avoid
> to build FF-A driver with built-in.
> 
> > 2. If it is a requirement to have this built-in, I prefer to add a probe
> >    and defer it instead of this root ffa device.
> 
> But, How? anyway all of FF-A device & driver couldn't be probed unless
> FF-A initialisation is finished and How can we trigger FF-A initailise
> after pKVM finish its initialisation?
> 
> The problem is ff-a intiailisation happens before pKVM finish its
> initailasation and to do defer probe, it should use dd-model and
> As we discussed in other thread, notifier couldn't be a soluation.
> 
> Could you let me share other way I'm missing?
> 

Will something like below work ? If we add DT bindings, then we can add
of_match_table and drop the platform device creation. Also we can adjust
the parent device the way you have done by a simple change(not done in
this untested/not compiled change).

Regards,
Sudeep

-->8

firmware: arm_ffa: Register core as a platform driver

Move the FF-A core bring-up and teardown paths into platform driver
probe and remove callbacks, and register a synthetic arm-ffa platform
device to bind the driver.

This makes the FF-A core lifetime follow the driver model while keeping
the device creation internal to the FF-A core. The probe path can now
return normal driver-model errors, including probe deferral when pKVM is
enabled but not yet initialized.

Since the transport selection now happens from the platform probe path,
drop the __init annotation from ffa_transport_init().

Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
---
 drivers/firmware/arm_ffa/common.h |  4 +--
 drivers/firmware/arm_ffa/driver.c | 55 +++++++++++++++++++++++++++----
 drivers/firmware/arm_ffa/smccc.c  |  2 +-
 3 files changed, 52 insertions(+), 9 deletions(-)

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
index eb2782848283..d000727889f4 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -36,6 +36,7 @@
 #include <linux/mm.h>
 #include <linux/mutex.h>
 #include <linux/of_irq.h>
+#include <linux/platform_device.h>
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
 #include <linux/smp.h>
@@ -46,6 +47,7 @@
 
 #define FFA_DRIVER_VERSION	FFA_VERSION_1_2
 #define FFA_MIN_VERSION		FFA_VERSION_1_0
+#define FFA_PLATFORM_NAME	"arm-ffa"
 
 #define SENDER_ID_MASK		GENMASK(31, 16)
 #define RECEIVER_ID_MASK	GENMASK(15, 0)
@@ -114,6 +116,7 @@ struct ffa_drv_info {
 };
 
 static struct ffa_drv_info *drv_info;
+static struct platform_device *ffa_pdev;
 
 /*
  * The driver must be able to support all the versions from the earliest
@@ -2029,12 +2032,15 @@ static void ffa_notifications_setup(void)
 	ffa_notifications_cleanup();
 }
 
-static int __init ffa_init(void)
+static int ffa_probe(struct platform_device *pdev)
 {
 	int ret;
 	u32 buf_sz;
 	size_t rxtx_bufsz = SZ_4K;
 
+	if (is_protected_kvm_enabled() && !is_pkvm_initialized())
+		return -EPROBE_DEFER;
+
 	ret = ffa_transport_init(&invoke_ffa_fn);
 	if (ret)
 		return ret;
@@ -2042,6 +2048,7 @@ static int __init ffa_init(void)
 	drv_info = kzalloc_obj(*drv_info);
 	if (!drv_info)
 		return -ENOMEM;
+	platform_set_drvdata(pdev, drv_info);
 
 	ret = ffa_version_check(&drv_info->version);
 	if (ret)
@@ -2103,19 +2110,55 @@ static int __init ffa_init(void)
 		free_pages_exact(drv_info->tx_buffer, rxtx_bufsz);
 	free_pages_exact(drv_info->rx_buffer, rxtx_bufsz);
 free_drv_info:
+	platform_set_drvdata(pdev, NULL);
 	kfree(drv_info);
+	drv_info = NULL;
 	return ret;
 }
-rootfs_initcall(ffa_init);
 
-static void __exit ffa_exit(void)
+static void ffa_remove(struct platform_device *pdev)
 {
+	struct ffa_drv_info *info = platform_get_drvdata(pdev);
+
 	ffa_notifications_cleanup();
 	ffa_partitions_cleanup();
 	ffa_rxtx_unmap();
-	free_pages_exact(drv_info->tx_buffer, drv_info->rxtx_bufsz);
-	free_pages_exact(drv_info->rx_buffer, drv_info->rxtx_bufsz);
-	kfree(drv_info);
+	free_pages_exact(info->tx_buffer, info->rxtx_bufsz);
+	free_pages_exact(info->rx_buffer, info->rxtx_bufsz);
+	kfree(info);
+	platform_set_drvdata(pdev, NULL);
+	drv_info = NULL;
+}
+
+static struct platform_driver ffa_driver = {
+	.remove = ffa_remove,
+	.driver = {
+		.name = FFA_PLATFORM_NAME,
+	},
+};
+
+static int __init ffa_init(void)
+{
+	int ret;
+
+	ffa_pdev = platform_device_register_simple(FFA_PLATFORM_NAME,
+						   PLATFORM_DEVID_NONE,
+						   NULL, 0);
+	if (IS_ERR(ffa_pdev))
+		return PTR_ERR(ffa_pdev);
+
+	ret = platform_driver_probe(&ffa_driver, ffa_probe);
+	if (ret)
+		platform_device_unregister(ffa_pdev);
+
+	return ret;
+}
+module_init(ffa_init);
+
+static void __exit ffa_exit(void)
+{
+	platform_device_unregister(ffa_pdev);
+	platform_driver_unregister(&ffa_driver);
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
2.43.0


