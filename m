Return-Path: <linux-integrity+bounces-9658-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AF4GLSkAFGquIQcAu9opvQ
	(envelope-from <linux-integrity+bounces-9658-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 25 May 2026 09:54:17 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4DD5C7500
	for <lists+linux-integrity@lfdr.de>; Mon, 25 May 2026 09:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9D36300D45B
	for <lists+linux-integrity@lfdr.de>; Mon, 25 May 2026 07:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB613D47CB;
	Mon, 25 May 2026 07:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lPJAJ7Er"
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B0A3D1706;
	Mon, 25 May 2026 07:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779695654; cv=none; b=VZexVEimQpPYRtNDb4zgSAdj9jD1Q+n0HoWJ7bboHioC+4VexfvFWZIoMoMgl3rWR47wnMQ3L1lsW4ESgAfvUp1ed247P5KBvic16fraCPkEIq+lRIAP07btkv49dTL7rm4j1lkfKrM40eKO769i0mTUCm5tpu1312SfUZFgxpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779695654; c=relaxed/simple;
	bh=irMduKgaG0+E5hOjs8Hx9fmDyL4PqS4kMRNA3KBCc0c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=FyZZ8oz+KIuJzDSWF0IEG0PaPTkLv8mtQ50+jla5WCNGHhAgN9tCfJ4dH7JgC7Inp0nG8qRU2eSh5RLus1S5pExvUD9cXeciG9RIbOWMqtElMyCdspYWBjn7SOSJuS8Tl0wzpvlVIGAo3je9X4B+NXNmkAnniQ2geSfwRYO6kl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lPJAJ7Er; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0BAB1A9A;
	Mon, 25 May 2026 00:54:06 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CC9503F7D8;
	Mon, 25 May 2026 00:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779695651; bh=irMduKgaG0+E5hOjs8Hx9fmDyL4PqS4kMRNA3KBCc0c=;
	h=From:To:Cc:Subject:Date:From;
	b=lPJAJ7ErdWWWjyEScpiAg9zLqg9pKYp/zd2lXLTbjvQ3zPQTqUjlA02vuQogq2394
	 CA5crt1OgdR0rwtNGpd/OSUU5c+sM/YLLC/esTHkejhBBbDR/myAxay89rZEEd+TRq
	 Nfy0Jbz6r/9db63lB6a/7ek/XYUbWW7Vy1zLiC28=
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
Subject: [PATCH v4 0/3] introduce IMA_INIT_LATE_SYNC option
Date: Mon, 25 May 2026 08:54:01 +0100
Message-Id: <20260525075404.3480282-1-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
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
	TAGGED_FROM(0.00)[bounces-9658-lists,linux-integrity=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,arm.com:mid,arm.com:dkim]
X-Rspamd-Queue-Id: 0D4DD5C7500
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
device probed defered.

When this option is enabled, modules that access files in the
initramfs through usermode helper calls such as request_module()
during initcall must not be built-in. Otherwise, IMA may miss
measuring those files since they're the file accesses before the
initialisation of IMA [1].

Link: https://lore.kernel.org/all/aYXEepLhUouN5f99@earth.li/ [0]
Link: https://lore.kernel.org/all/2b3782398cc17ce9d355490a0c42ebce9120a9ae.camel@linux.ibm.com/ [1]

Patch history
=============
from v3 to v4:
  - rebase on v7.1-rc5
  - introduce IMA_INIT_LATE_SYNC option to control IMA initailisation.
  - https://lore.kernel.org/all/cover.1777036497.git.noodles@meta.com/

from v2 to v3:
  - Drop ff-a/pKVM diff (this seems to have a separate set of
    discussion)
  - Rework IMA delayed initialisation to avoid delaying when unnecessary
  - Ensure IMA log clearly indicates when we've initialised late
  - https://lore.kernel.org/all/20260422162449.1814615-1-yeoreum.yun@arm.com/

from v1 to v2:
  - add notifier to make ffa-driver pkvm initialised.
  - modify to try initailisation again when IMA coudln't find proper TPM device.
  - https://lore.kernel.org/all/20260417175759.3191279-1-yeoreum.yun@arm.com/#t


Yeoreum Yun (3):
  security: lsm: Allow LSMs to register for late_initcall_sync init
  security: ima: introduce IMA_INIT_LATE_SYNC option
  tpm: tpm_crb_ffa: revert defered_probed when tpm_crb_ffa is built-in

 drivers/char/tpm/tpm_crb_ffa.c    | 18 +++---------------
 include/linux/lsm_hooks.h         |  2 ++
 security/integrity/ima/Kconfig    | 10 ++++++++++
 security/integrity/ima/ima_main.c |  4 ++++
 security/lsm_init.c               | 13 +++++++++++--
 5 files changed, 30 insertions(+), 17 deletions(-)


base-commit: e7ae89a0c97ce2b68b0983cd01eda67cf373517d
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


