Return-Path: <linux-integrity+bounces-9660-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCqOM2oAFGoRIgcAu9opvQ
	(envelope-from <linux-integrity+bounces-9660-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 25 May 2026 09:55:22 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D7A5C7545
	for <lists+linux-integrity@lfdr.de>; Mon, 25 May 2026 09:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD8FA30305F5
	for <lists+linux-integrity@lfdr.de>; Mon, 25 May 2026 07:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9183D1706;
	Mon, 25 May 2026 07:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="o0PnvAO3"
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDC93D5C2C;
	Mon, 25 May 2026 07:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779695659; cv=none; b=KqHyV9QOuqVW7hkz+B7VWq8qv9Hw94jgH6XkUX0ijyUol2EZGNqtlx5KOZ904hs3LT5p4ZyPFLJlqoC00dP7nqPCKD2zPvBHU4JZPZ6SmdFyXBGkd6SnCZSfAgvhdNTVk9AA9USZMayEdD/GR9WYlwudy4c5pAvd40zJPQpE5Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779695659; c=relaxed/simple;
	bh=0hKV6HfJq9R0Q0y5b8EP020wcoHchplmez6CdMHtDBU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fWzCqzqHcKW7Wx1frXxnq9Dx5nWBmBaswc3y+xi+cBw8r8D3d3B3eP9CSybva+G223HP6zKT28l0PZgZTeVBoArz930cmjvU46j7dHBWDi6Mp3bGV/XUIPjO2rwjGV0pnl4ZYHtJ2bFZEVChZTRj/m9z2Sa7qT8mpaI1JI+WlPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=o0PnvAO3; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8EB5354A;
	Mon, 25 May 2026 00:54:11 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B91663F7D8;
	Mon, 25 May 2026 00:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779695656; bh=0hKV6HfJq9R0Q0y5b8EP020wcoHchplmez6CdMHtDBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o0PnvAO3O0Gvlo2Xs1wqzTZztethIO3WHXzOai8z+84PREaKIEBm79MEkC/fnV0j7
	 14rgQAvyNERCWfrLTG3L3e/M4PENQJZQaCH0zGoAqCNIOaU8ff4BvYV/prujVLjzqN
	 4/IQrKWpIsdifDZZeaOA9LPhBXRDRvcxLCWWRuXA=
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org
Cc: paul@paul-moore.com,
	zohar@linux.ibm.com,
	roberto.sassu@huaweicloud.com,
	noodles@earth.li,
	jarkko@kernel.org,
	sudeep.holla@kernel.org,
	jmorris@namei.org,
	serge@hallyn.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	jgg@ziepe.ca,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH v4 2/3] security: ima: introduce IMA_INIT_LATE_SYNC option
Date: Mon, 25 May 2026 08:54:03 +0100
Message-Id: <20260525075404.3480282-3-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260525075404.3480282-1-yeoreum.yun@arm.com>
References: <20260525075404.3480282-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[paul-moore.com,linux.ibm.com,huaweicloud.com,earth.li,kernel.org,namei.org,hallyn.com,gmail.com,oracle.com,ziepe.ca,arm.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9660-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yeoreum.yun@arm.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[arm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,arm.com:email,arm.com:mid,arm.com:dkim]
X-Rspamd-Queue-Id: 35D7A5C7545
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

To generate the boot_aggregate log in the IMA subsystem with TPM PCR values,
the TPM driver must be built as built-in and
must be probed before the IMA subsystem is initialized.

However, when the TPM device operates over the FF-A protocol using
the CRB interface, probing fails and returns -EPROBE_DEFER if
the tpm_crb_ffa device — an FF-A device that provides the communication
interface to the tpm_crb driver — has not yet been probed.

To ensure the TPM device operating over the FF-A protocol with
the CRB interface is probed before IMA initialization,
the following conditions must be met:

1. The corresponding ffa_device must be registered,
   which is done via ffa_init().

2. The tpm_crb_driver must successfully probe this device via
   tpm_crb_ffa_init().

3. The tpm_crb driver using CRB over FF-A can then
   be probed successfully. (See crb_acpi_add() and
   tpm_crb_ffa_init() for reference.)

Unfortunately, ffa_init(), tpm_crb_ffa_init(), and crb_acpi_driver_init() are
all registered with device_initcall, which means crb_acpi_driver_init() may
be invoked before ffa_init() and tpm_crb_ffa_init() are completed.

When this occurs, probing the TPM device is deferred.
However, the deferred probe can happen after the IMA subsystem
has already been initialized, since IMA initialization is performed
during late_initcall, and deferred_probe_initcall() is performed
at the same level.

And the similar situation is reported on TPM devices attached on SPI
bus[0].

To resolve this, introduce IMA_INIT_LATE_SYNC option to initialise
IMA at late_inicall_sync so that IMA is initialized with the TPM
device probed deffered.

When this option is enabled, modules that access files in the
initramfs through usermode helper calls such as request_module()
during initcall must not be built-in. Otherwise, IMA may miss
measuring those files since they're the file accesses before the
initialisation of IMA [1].

Link: https://lore.kernel.org/all/aYXEepLhUouN5f99@earth.li/ [0]
Link: https://lore.kernel.org/all/2b3782398cc17ce9d355490a0c42ebce9120a9ae.camel@linux.ibm.com/ [1]
Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 security/integrity/ima/Kconfig    | 10 ++++++++++
 security/integrity/ima/ima_main.c |  4 ++++
 2 files changed, 14 insertions(+)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 862fbee2b174..75f71401fba3 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -332,4 +332,14 @@ config IMA_KEXEC_EXTRA_MEMORY_KB
 	  If set to the default value of 0, an extra half page of memory for those
 	  additional measurements will be allocated.
 
+config IMA_INIT_LATE_SYNC
+	bool "Initialise IMA at late_initcall_sync"
+	default n
+	help
+	  This option initialises IMA at late_initcall_sync for platforms
+	  where TPM device probing is deferred.
+	  When this option is enabled, modules that access files in the
+	  initramfs through usermode helper calls such as request_module()
+	  during initcall must not be built-in. Otherwise, IMA may miss
+	  file measurements for them.
 endif
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 5cea53fc36df..1cfae4b83dc5 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -1337,5 +1337,9 @@ DEFINE_LSM(ima) = {
 	.order = LSM_ORDER_LAST,
 	.blobs = &ima_blob_sizes,
 	/* Start IMA after the TPM is available */
+#ifndef CONFIG_IMA_INIT_LATE_SYNC
 	.initcall_late = init_ima,
+#else
+	.initcall_late_sync = init_ima,
+#endif
 };
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


