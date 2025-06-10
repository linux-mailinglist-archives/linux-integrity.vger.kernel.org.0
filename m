Return-Path: <linux-integrity+bounces-6388-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A587AD2DA9
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Jun 2025 08:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4294A3A42DA
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Jun 2025 06:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CC225F961;
	Tue, 10 Jun 2025 06:03:42 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE95720FAA9;
	Tue, 10 Jun 2025 06:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749535422; cv=none; b=m7iAlLKwqNSSJuXqf4jlUYBaZVoEKdaEY8ACfzY0QMYb7CwVV6EdMmNWwo7OqaphtwpOo1HWlg+8WQ4y8phn4r6fRR9vzSkpzHLi7eaHB4QTRdps/Vv8G7Y4gVM5JXYYUdhUtCM96S896YORj/Vf9OMrsMnLpbhCnAMsYIvlIbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749535422; c=relaxed/simple;
	bh=YE2mf6Sb+q+4PO44KeGcuQ9OT2URo1FnNIp3xLcaWog=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=gfUhU/EGIwjx6wofNnyQRs5e+kfSGYnOjX4X8cGgRmTGKvmoDp/XETI1u9Fkw5Y5T0tSI21aAWfdpaUd+7YMbgYr7a6tHNTTrKCRA2Wyr77+fgzQQgZCtabaJ5GyE5BuaM6ZpTfrXO8TRmE8LBNeEwF7fDCgiJCT4g+Je9T1iac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0786314BF;
	Mon,  9 Jun 2025 23:03:21 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A993B3F673;
	Mon,  9 Jun 2025 23:03:38 -0700 (PDT)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: jarkko@kernel.org,
	sudeep.holla@arm.com,
	peterhuewe@gmx.de,
	jgg@ziepe.ca,
	stuart.yoder@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH v2 0/2] fix failure of integration IMA with tpm_crb_ffa
Date: Tue, 10 Jun 2025 07:03:32 +0100
Message-Id: <20250610060334.2149041-1-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

To integrate a TPM device that uses CRB over FF-A with the IMA subsystem,
both the tpm_crb and tpm_crb_ffa drivers must be built as built-in
(i.e., ARM_FFA_TRANSPORT=y, CONFIG_TCG_CRB=y, and CONFIG_TCG_CRB_FFA=y),
because IMA itself is built-in and the TPM device must be probed
before ima_init() is invoked during IMA subsystem initialization.

To ensure this works correctly, the following initcalls must be executed in order:
	1.	ffa_init()
	2.	tpm_crb_ffa_driver_init()
	3.	crb_acpi_driver_init()

Unfortunately, the order of these device initcalls cannot be strictly controlled.
As a result:
	1.	ffa_init() may be called after tpm_crb_ffa_driver_init()
	2.	tpm_crb_ffa_driver_init() may be called after crb_acpi_driver_init()

For example, the following initcall sequence may occur:
  0000000000000888 l  .initcall6.init>  crb_acpi_driver_init
  000000000000088c l  .initcall6.init>  tpm_crb_ffa_driver_init
  0000000000000a9c l  .initcall6.init>  ffa_init

In this situation, the IMA subsystem fails to integrate with the TPM device
because the TPM was not available at the time ima_init() was called.
As a result, you may see the following message in the kernel log:

  | ima: No TPM chip found, activating TPM-bypass!

To resolve this issue:
  Patch #1: change the initcall level of ffa_init() to rootfs_initcall,
            so that the FF-A device is created before any FF-A drivers are loaded.

  Patch #2: call ffa_register() in tpm_crb_ffa_init() when it is built as built-in,
            ensuring that the Secure Partition used by tpm_crb_ffa
            is already registered when the TPM device is probed.

==============
Patch History
==============
  Since v1:
     - rewrite commit message.
     - https://lore.kernel.org/all/20250606105754.1202649-1-yeoreum.yun@arm.com/


Yeoreum Yun (2):
  firmware: arm_ffa: Change initcall level of ffa_init() to
    rootfs_initcall
  tpm: tpm_crb_ffa: maunally register tpm_crb_ffa driver when it's
    built-in

 drivers/char/tpm/tpm_crb_ffa.c    | 22 +++++++++++++++++-----
 drivers/firmware/arm_ffa/driver.c |  2 +-
 2 files changed, 18 insertions(+), 6 deletions(-)

--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


