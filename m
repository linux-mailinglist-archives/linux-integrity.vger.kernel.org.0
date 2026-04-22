Return-Path: <linux-integrity+bounces-9274-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAlND2r36GkgSQIAu9opvQ
	(envelope-from <linux-integrity+bounces-9274-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Apr 2026 18:29:30 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0839448A77
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Apr 2026 18:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 44AF630080B2
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Apr 2026 16:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C85E37DE8E;
	Wed, 22 Apr 2026 16:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ri+Pg4M4"
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602A937CD5A;
	Wed, 22 Apr 2026 16:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776875099; cv=none; b=ESWf8wrF11YX26th7oUvVWE7WsGrhCy2JUC0bprikTIYPNEopeVG/Q8uUmzqWK028tx7HWICLzpfeLu4TcPAosKKOG3NOX2UB0xi41Oe4DKIFlqqw80EPDUrk9/vHE2dhwDH56I8R5LVUmlRuAIjkfbGtSe91eI+bRx7qrynogs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776875099; c=relaxed/simple;
	bh=YneOUU9ZJjo8b1CP73adb7MQ16w1JI8gyH1SCX8PE4o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=J9dv4LwsjccwS06emuUwEeuQOqfkEjiYQEnaYDfebSWrAyS8WMj4+0CqFpxKdIN6XD9CaxradTxorFhE6hnexTuifKa06K6kHU6+4UyOsA4MckudT6yQFUMItQGbC2l2XUNsaE9Swbe30WG/t6hOEGBbUdkPe4UEL0MwbR1/cF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ri+Pg4M4; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EAB471F37;
	Wed, 22 Apr 2026 09:24:50 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 185453F23F;
	Wed, 22 Apr 2026 09:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1776875096; bh=YneOUU9ZJjo8b1CP73adb7MQ16w1JI8gyH1SCX8PE4o=;
	h=From:To:Cc:Subject:Date:From;
	b=ri+Pg4M4D91Zwrp8WAgDJA+A3Jg0pjYVdEYkkDMsBjf6Pv5z40ncNrw4236rjI1xq
	 /LiLmtWgBmErBMn/Z9beVAm2Y5e7v5TNwcfpS2vDfw+s2WDYcSXoTetd3wmS+xz3a/
	 uaOUpICPZ1PbbLOISYucqQsePojADxqiVhh9U0Sk=
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
Subject: [RFC PATCH v2 0/4] fix FF-A call failed with pKVM when ff-a driver is built-in
Date: Wed, 22 Apr 2026 17:24:45 +0100
Message-Id: <20260422162449.1814615-1-yeoreum.yun@arm.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_CC(0.00)[paul-moore.com,namei.org,hallyn.com,linux.ibm.com,huawei.com,gmail.com,oracle.com,kernel.org,ziepe.ca,arm.com,meta.com,google.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9274-lists,linux-integrity=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arm.com:dkim,arm.com:mid]
X-Rspamd-Queue-Id: A0839448A77
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

commit 0e0546eabcd6 ("firmware: arm_ffa: Change initcall level of ffa_init() to rootfs_initcall")
changed the initcall level of ffa_init() to rootfs_initcall to address
an issue where IMA could not properly recognize the TPM device
when FF-A driver is built as built-in.

However, this introduces another problem: pKVM fails to handle FF-A calls
because it cannot trap the FFA_VERSION call invoked by ffa_init().

To ensure the TPM device is recognized when present in the system,
it is preferable to invoke again ima_init() at a later stage.
Deferred probing is resolved by deferred_probe_initcall(),
which runs at the late_initcall level.
Therefore, introduce an LSM initcall at late_initcall_sync and
invode ima_init() again to this level in case of TPM is probed yet
at the late_initcall stage.

With this change, revert the initcall level of ffa_init() back to
device_initcall. Additionally, to handle the case where ffa_init() runs
before kvm_init(), check whether pKVM has been initialized during ffa_init().
If not, defer initialization to prevent failures of FF-A calls
due to the inability to trap FFA_VERSION and FFA_RXTX_MAP in pKVM.

This patch is based on v7.0

Patch History
=============
from v1 to v2:
  - add notifier to make ffa-driver pkvm initialised.
  - modify to try initailisation again when IMA coudln't find proper TPM device.
  - https://lore.kernel.org/all/20260417175759.3191279-1-yeoreum.yun@arm.com/#t

Yeoreum Yun (4):
  security: ima: call ima_init() again at late_initcall_sync for defered
    TPM
  tpm: tpm_crb_ffa: revert defered_probed when tpm_crb_ffa is built-in
  firmware: arm_ffa: revert ffa_init() initcall level to device_initcall
  firmware: arm_ffa: check pkvm initailised when initailise ffa driver

 arch/arm64/include/asm/virt.h       | 11 +++++
 arch/arm64/kvm/arm.c                | 21 ++++++++
 arch/arm64/kvm/pkvm.c               |  2 +
 drivers/char/tpm/tpm_crb_ffa.c      | 18 ++-----
 drivers/firmware/arm_ffa/common.h   |  4 +-
 drivers/firmware/arm_ffa/driver.c   | 38 ++++++++++++++-
 drivers/firmware/arm_ffa/smccc.c    |  2 +-
 include/linux/lsm_hooks.h           |  2 +
 security/integrity/ima/ima.h        |  4 +-
 security/integrity/ima/ima_init.c   | 10 +++-
 security/integrity/ima/ima_main.c   | 76 +++++++++++++++++++++++------
 security/integrity/ima/ima_policy.c |  3 ++
 security/lsm_init.c                 | 13 ++++-
 13 files changed, 163 insertions(+), 41 deletions(-)


base-commit: 028ef9c96e96197026887c0f092424679298aae8
--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


