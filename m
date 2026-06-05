Return-Path: <linux-integrity+bounces-9747-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Uw5vAAviImoZewEAu9opvQ
	(envelope-from <linux-integrity+bounces-9747-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 05 Jun 2026 16:49:47 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A10C2648FB9
	for <lists+linux-integrity@lfdr.de>; Fri, 05 Jun 2026 16:49:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=foss header.b=K17fqBbA;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9747-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9747-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C852330AC608
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jun 2026 14:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF583D47CB;
	Fri,  5 Jun 2026 14:43:47 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2493CFF6C;
	Fri,  5 Jun 2026 14:43:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780670627; cv=none; b=EjbstUmzOOH97NN/01h24VrtFNexwTCEhob1s7xmnnab/hEY3h/1RHVCAwM6kn7BbfT2hnPpnprNn6I/skEbD2A3vQW4qi3FSnpdNfrQ+u3AjLUccp3Yu0TTDW6Ht28kvwtyuRWuv4foPOIbi1DVwvjeYiMpYLBucZ9tmsDO4s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780670627; c=relaxed/simple;
	bh=Q1T/dDNjJpSw5e0YB7HdLHFPMQUq6Qcw8HEO3cVJDsA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o6hVpe8VpmNILrQFHN9tSSMZhxLzO9sCiXTQNtr777JkVO5Xp5KiIBGvCCz27OjdFpTB/8CUu+aHxlMNj8VRDqBiMhuMg994TxddCW+xD+cgGFUZSkcS8P7bFE0hgEUMcDAkR1qyaxz4E1+EAoCMKlhi0nXgu4gAFPmy0HRszq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=K17fqBbA; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 663252BC6;
	Fri,  5 Jun 2026 07:43:38 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2AA5E3F7D8;
	Fri,  5 Jun 2026 07:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780670623; bh=Q1T/dDNjJpSw5e0YB7HdLHFPMQUq6Qcw8HEO3cVJDsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K17fqBbA+wjIoD+vHPRYJ/j9UFEE9i2S3w2yCmfmSwpGhgHZkz3YQ8ceH/w6exmON
	 S4pLLSm2iIa25nAw/qIbWTJKiy7FZb2fLPpDFVVrIkMMjJVdNK7eueI1B5NUNyjrG4
	 lv1roe00Ncxtb/4AGzK6FTRFhLg3K3T2Q++XgyX0=
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
Subject: [PATCH v6 2/4] security: ima: introduce IMA_INIT_LATE_SYNC option
Date: Fri,  5 Jun 2026 15:43:23 +0100
Message-Id: <20260605144325.434436-3-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605144325.434436-1-yeoreum.yun@arm.com>
References: <20260605144325.434436-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[paul-moore.com,linux.ibm.com,huaweicloud.com,earth.li,kernel.org,namei.org,hallyn.com,gmail.com,oracle.com,ziepe.ca,arm.com];
	TAGGED_FROM(0.00)[bounces-9747-lists,linux-integrity=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-security-module@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-integrity@vger.kernel.org,m:paul@paul-moore.com,m:zohar@linux.ibm.com,m:roberto.sassu@huaweicloud.com,m:noodles@earth.li,m:jarkko@kernel.org,m:sudeep.holla@kernel.org,m:jmorris@namei.org,m:serge@hallyn.com,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:jgg@ziepe.ca,m:yeoreum.yun@arm.com,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER(0.00)[yeoreum.yun@arm.com,linux-integrity@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yeoreum.yun@arm.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[arm.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arm.com:mid,arm.com:dkim,arm.com:from_mime,arm.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A10C2648FB9

To generate the boot_aggregate log in the IMA subsystem with
TPM PCR values, the TPM driver must be built as built-in and
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

Unfortunately, ffa_init(), tpm_crb_ffa_init(), and crb_acpi_driver_init()
are all registered with device_initcall, which means
crb_acpi_driver_init() may be invoked before ffa_init() and
tpm_crb_ffa_init() are completed.

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
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
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


