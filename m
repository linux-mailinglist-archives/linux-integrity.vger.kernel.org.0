Return-Path: <linux-integrity+bounces-9220-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wELAALd04mnh6AAAu9opvQ
	(envelope-from <linux-integrity+bounces-9220-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Apr 2026 19:58:15 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B16441DBC2
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Apr 2026 19:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B071330056C4
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Apr 2026 17:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B512430CD82;
	Fri, 17 Apr 2026 17:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="sU2B9iWd"
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B03F2D0614;
	Fri, 17 Apr 2026 17:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776448687; cv=none; b=bNJwh3JsIMeLZq3dy4D7mTtAKE8kRXHe563cGWO8dP4ZxqBN7T6JPm6LCvAw6shc0/tXjygOuFyfN7grCoPDMoINcsjkifQYJNXbRYstrjHehDiZHMzi8InY+nIT5f4UoDPZ9wPdjwhdqG3wpwEo+ev/khVVhWP9h/gdJqZZshI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776448687; c=relaxed/simple;
	bh=tsQy6qMxsa5wjMUuqspAU/D38Z+x2rhzlE1+ZI76oYs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=AIvRU2rGlxaivy46WXgCXsPtU2aogFu0ocXnx8ZjQ/EKiPiXq/E3xXJoLG6bJJZPDsN0YEkPe8AfJ9xcAtceCqaTuNGjWM7NmwMQjjjJEI+cXvlojMTd0KRX+TyxEpXg6Wv4xzYUfxO8pIuzZQvoXNSNgT/KarUKteL7rXfLsa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=sU2B9iWd; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19B381D70;
	Fri, 17 Apr 2026 10:57:59 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 673183F7D8;
	Fri, 17 Apr 2026 10:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1776448684; bh=tsQy6qMxsa5wjMUuqspAU/D38Z+x2rhzlE1+ZI76oYs=;
	h=From:To:Cc:Subject:Date:From;
	b=sU2B9iWdqNy2qZpmdMvrPLtnrYEgCQBpmBdwpnWijSItJl8tytKgc0Jql+QiSx43R
	 zaEjGkUxmpc4kFClz0FjWLjiaBsf06MeWnkNvOGcDCypTryA+GZ5bx9w8Ys/Oexc8C
	 C3l5LnRs2B6aw1babPLRKbfONNLltApGHEBC5a5Q=
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
	peterhuewe@gmx.de,
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
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [RFC PATCH 0/4] fix FF-A call failed with pKVM when ff-a driver is built-in
Date: Fri, 17 Apr 2026 18:57:55 +0100
Message-Id: <20260417175759.3191279-1-yeoreum.yun@arm.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_CC(0.00)[paul-moore.com,namei.org,hallyn.com,linux.ibm.com,huawei.com,gmail.com,oracle.com,gmx.de,kernel.org,ziepe.ca,arm.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9220-lists,linux-integrity=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7B16441DBC2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

commit 0e0546eabcd6 ("firmware: arm_ffa: Change initcall level of ffa_init() to rootfs_initcall")
changed the initcall level of ffa_init() to rootfs_initcall to address
an issue where IMA could not properly recognize the TPM device
when FF-A driver is built as built-in.

However, this introduces another problem: pKVM fails to handle FF-A calls
because it cannot trap the FFA_VERSION call invoked by ffa_init().

To ensure the TPM device is recognized when present in the system,
it is preferable to invoke ima_init() at a later stage.
Deferred probing is resolved by deferred_probe_initcall(),
which runs at the late_initcall level.
Therefore, introduce an LSM initcall at late_initcall_sync and
move ima_init() to this level.

With this change, revert the initcall level of ffa_init() back to
device_initcall. Additionally, to handle the case where ffa_init() runs
before kvm_init(), check whether pKVM has been initialized during ffa_init().
If not, defer initialization to prevent failures of FF-A calls
due to the inability to trap FFA_VERSION and FFA_RXTX_MAP in pKVM.

This patch is based on v7.0

Yeoreum Yun (4):
  security: ima: move ima_init into late_initcall_sync
  tpm: tpm_crb_ffa: revert defered_probed when tpm_crb_ffa is built-in
  firmware: arm_ffa: revert ffa_init() initcall level to device_initcall
  firmware: arm_ffa: check pkvm initailised when initailise ffa driver

 arch/arm64/kvm/arm.c              |  1 +
 drivers/char/tpm/tpm_crb_ffa.c    | 18 +++---------------
 drivers/firmware/arm_ffa/driver.c | 14 +++++++++++++-
 include/linux/lsm_hooks.h         |  2 ++
 security/integrity/ima/ima_main.c |  2 +-
 security/lsm_init.c               | 13 +++++++++++--
 6 files changed, 31 insertions(+), 19 deletions(-)


base-commit: 028ef9c96e96197026887c0f092424679298aae8
--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


