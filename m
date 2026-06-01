Return-Path: <linux-integrity+bounces-9711-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEF6Es2YHWoXcgkAu9opvQ
	(envelope-from <linux-integrity+bounces-9711-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 01 Jun 2026 16:35:57 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEB9620F72
	for <lists+linux-integrity@lfdr.de>; Mon, 01 Jun 2026 16:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD510306A609
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Jun 2026 14:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C483BBA0D;
	Mon,  1 Jun 2026 14:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ZESq/ysx"
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42B43BBA1D;
	Mon,  1 Jun 2026 14:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780324086; cv=none; b=hpjCQJlqLpqr6fwO6NTOGzv/cO4XumAVzsBnINxYK8rsijOXAOqDoXNzribt0cC3VkcNZaLvMjd0/PCjkXUPwtAHhjpN7UDmngvow9aX1cQoaX0RVDXPtaS1IThJT4CZHOOGCiq2Zt5VG45Pmk/o9ByjHH1ljyDZDn9OhAopD2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780324086; c=relaxed/simple;
	bh=mJUHWPRyqmHlfWlZamfWBlnMlvbclKvJFKZA3Ty4VpU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kzQhOkD6UTWy5T6Yr/b1QgomdMHuF9+Z1b3tT/zJTTgTyeBp6rsttdKm3pQqKSGnbTXXAupmJrpo13uGl8yPIHGwIxcqga7T33wmHdLL9IR9lKD7PpCqbtdVGilGRMZ5u1r3H2htlcv9mJgMbVEGr6pAenoCvj0HhrheakOlsCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ZESq/ysx; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F6A2244B;
	Mon,  1 Jun 2026 07:27:59 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 30DE03F632;
	Mon,  1 Jun 2026 07:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780324084; bh=mJUHWPRyqmHlfWlZamfWBlnMlvbclKvJFKZA3Ty4VpU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZESq/ysxB3lri/YAZtGN/2XW0J+X1cj8r2fqEm+UAwDwOPSq3yWWNQ110hU+/+mNb
	 tx4V3htabvA5OwNa23C3QenCzFocPE0Gtgla+KvgjVN/t7J4rkcT0dI0nt9LZDDAs0
	 v+BDycjHCSoDf73YImrpARAwd+Mw2ysDsBDqMfsI=
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
Subject: [PATCH v5 2/4] security: ima: introduce IMA_INIT_LATE_SYNC option
Date: Mon,  1 Jun 2026 15:27:47 +0100
Message-Id: <20260601142749.3379697-3-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260601142749.3379697-1-yeoreum.yun@arm.com>
References: <20260601142749.3379697-1-yeoreum.yun@arm.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[paul-moore.com,linux.ibm.com,huaweicloud.com,earth.li,kernel.org,namei.org,hallyn.com,gmail.com,oracle.com,ziepe.ca,arm.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9711-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yeoreum.yun@arm.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[arm.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,arm.com:mid,arm.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7CEB9620F72
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
device probed deferred.

When this option is enabled, modules that access files in the
initramfs through usermode helper calls such as request_module()
during initcall must not be built-in. Otherwise, IMA may miss
measuring those files [1].

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


