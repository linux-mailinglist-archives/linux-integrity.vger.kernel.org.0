Return-Path: <linux-integrity+bounces-9439-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EANrBDrB+WngDAMAu9opvQ
	(envelope-from <linux-integrity+bounces-9439-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 05 May 2026 12:06:50 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 192094CA8B0
	for <lists+linux-integrity@lfdr.de>; Tue, 05 May 2026 12:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 10E853047E50
	for <lists+linux-integrity@lfdr.de>; Tue,  5 May 2026 09:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13AFA339719;
	Tue,  5 May 2026 09:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="OroYeXVb"
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B40A3368B7;
	Tue,  5 May 2026 09:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777974858; cv=none; b=l+qHfsJlvmiuE4J50K9thkVa5rBl3eP5YYI4u0yicHjERmLbcCZSoz3ha4+midn9Gyaj4k0k8+kIRpR9zDUxPI9H4+6+ogdAh4DA58BYZAKKaGjpnWR9Wmm0dT27+/bH0qnUjQX936vAiQlMasFVfuGZ1AG4UrPEcNpJz4qcjg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777974858; c=relaxed/simple;
	bh=mZATz5adCxjq+rKLQMa6TL0ztfFjDih5jW0Ffnpg7tA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=bCG33MyR7ueNxSWPzcvR28YeKDTw28bJn9c2htIP0XoQgyH4ASINdn1ORynLqoosogwEmucNcxmDPTIkchrPpeIgT7vlzRySCA4AYA3ZLFlvZczoFw2XYXBy4pdmKZQ5ZdTsXKY2Tuypm0phqpDXcr6VJ58UZGkumJOPdO2BQPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=OroYeXVb; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84CCD2936;
	Tue,  5 May 2026 02:54:09 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8439C3F836;
	Tue,  5 May 2026 02:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777974854; bh=mZATz5adCxjq+rKLQMa6TL0ztfFjDih5jW0Ffnpg7tA=;
	h=From:To:Cc:Subject:Date:From;
	b=OroYeXVbEYXngvWHaW/fKZK/iVp506G7ITZsUT5skzUb/lyh16bF4bNuXqK2hsAk4
	 KHLBmCmRAo8EyvVyzaTbJ96xJ8EXSV+onS6Gun44JBV9cfTfanJdk/xIyQ/g9mRhv3
	 0U5EXk7QZoh+tZoy9yfqywFgFvYyeXEhIxggEoJ0=
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
Subject: [RFC PATCH 0/3] initalise ff-a after finalising pKVM
Date: Tue,  5 May 2026 10:54:06 +0100
Message-Id: <20260505095409.1948371-1-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 192094CA8B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[kernel.org,linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,arm.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9439-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yeoreum.yun@arm.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[arm.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:dkim,arm.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

This patch is split out from the patchset [0] --
fix FF-A call failure with pKVM when the FF-A driver is built-in,
specifically the IMA-related part.

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

This patch is based on v7.1-rc2

Question:

FF-A initialisation can occur at late_initcall. Because it may be deferred,
some FF-A requests cannot be serviced at that stage.
A typical example is the EFI runtime variable service using DIRECT_MSG_REQ.

Depending on the platform, the EFI runtime variable service runs with StandaloneMm
and uses FF-A DIRECT_REQ. However, when pKVM is enabled, FF-A initialisation
may be deferred to late_initcall. In this case, load_uefi_certs()
can fail if it is invoked before the FF-A driver is initialised
via deferred_probe_initcall().

Moving load_uefi_certs() to late_initcall_sync, as in the third patch,
seems not to have any problem since late_initcall and
late_initcall_sync are both of do_basic_setup() and it's before loading
init process. However, it is still unclear whether
it would be better to allow DIRECT_MSG_REQ in kvm_host_ffa_handler()
even before FF-A version negotiation since handler’s purpose seems to hook
certain memory operations, and DIRECT_MSG_REQ has been available
since FF-A specification v1.0.

Any feedback or alternative suggestions would be appreciated!

Link: https://lore.kernel.org/all/20260422162449.1814615-1-yeoreum.yun@arm.com/ [0]

Yeoreum Yun (3):
  arm64: KVM: defer kvm_init() to finalise_pkvm() when pKVM is enabled
  firmware: arm_ffa: initialise ff-a after finalising pKVM
    initialisation
  security: integrity: call load_uefi_certs() at late_initcall_sync

 arch/arm64/kvm/arm.c                          |   8 +-
 arch/arm64/kvm/pkvm.c                         |  15 ++-
 drivers/firmware/arm_ffa/bus.c                | 125 +++++++++++++++++-
 drivers/firmware/arm_ffa/common.h             |  13 +-
 drivers/firmware/arm_ffa/driver.c             |  21 ++-
 drivers/firmware/arm_ffa/smccc.c              |   2 +-
 security/integrity/platform_certs/load_uefi.c |   2 +-
 7 files changed, 166 insertions(+), 20 deletions(-)


base-commit: 7fd2df204f342fc17d1a0bfcd474b24232fb0f32
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


