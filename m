Return-Path: <linux-integrity+bounces-6410-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 508E4AD53CC
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Jun 2025 13:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D582E3A396B
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Jun 2025 11:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF0025BEF6;
	Wed, 11 Jun 2025 11:24:55 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D012425BEFC;
	Wed, 11 Jun 2025 11:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749641095; cv=none; b=q23reyJcaXx2SPw0duAFz0832uBKpockU0+c9P77uMPFBfcFXo0Gq10EkbzIyuZi7b0ow80Lsi0sBvbLO/HN5nxfKWGRGTNEazOrrwWDdIpsqnUjdO1UyntXdvTvcv0gM5r+X1pMO67oHycUfkFBAnXB0WYZnsdFgaSyG8hEXuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749641095; c=relaxed/simple;
	bh=Rqw0HDk/Ut9k3xDHe9UQuVLXA3BxM14AOIgexJHO3uY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ZQcgSBhzYSy52rmNdvFAkpgcjfbGFQrp248XIXChh88vu6DTTXKSSDFkGtCjTrD5ptedt9mzK37Q2QmCgVnM4O/HOEauku2yM8tYYOIx/MsWi3KhrnP+NNjzONKUBLPAYkOP/yOF9yO/HAEzgJzhOrqSCWMb6VsQKTLWc9zOduU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 75F9E2BCA;
	Wed, 11 Jun 2025 04:24:32 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A94FA3F59E;
	Wed, 11 Jun 2025 04:24:50 -0700 (PDT)
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
Subject: [PATCH v3 0/2] generate boot_aggregate log in IMA with TPM using CRB over FF-A
Date: Wed, 11 Jun 2025 12:24:46 +0100
Message-Id: <20250611112448.17751-1-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

To generate the boot_aggregate log in the IMA subsystem with TPM PCR values,
the TPM driver must be built as built-in and
must be probed before the IMA subsystem is initialized.

However, when the TPM device operates over the FF-A protocol using the CRB interface,
probing fails and returns -EPROBE_DEFER if
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
However, the deferred probe may happen after
the IMA subsystem has already been initialized,
since IMA initialization is performed during late_initcall,
and deferred probing is handled asynchronously via a workqueue.

This patch addresses the issue by ensuring timely probing of
the tpm_crb_ffa device during TPM initialization:

  Patch #1: Change the initcall level of ffa_init() to rootfs_initcall,
            so that the FF-A device is created before any FF-A drivers are loaded.

  Patch #2: When built as built-in, call ffa_register() within tpm_crb_ffa_init()
            to ensure the Secure Partition used by tpm_crb_ffa is already registered
            before the TPM device is probed.

==============
Patch History
==============
  Since v2:
     - rewrite cover letter and commit message:
     - https://lore.kernel.org/all/aEgwpXXftXW6JNRy@e129823.arm.com/

  Since v1:
     - rewrite commit message.
     - https://lore.kernel.org/all/20250606105754.1202649-1-yeoreum.yun@arm.com/


Yeoreum Yun (2):
  firmware: arm_ffa: Change initcall level of ffa_init() to
    rootfs_initcall
  tpm: tpm_crb_ffa: manually register tpm_crb_ffa driver when it's
    built-in

 drivers/char/tpm/tpm_crb_ffa.c    | 22 +++++++++++++++++-----
 drivers/firmware/arm_ffa/driver.c |  2 +-
 2 files changed, 18 insertions(+), 6 deletions(-)

--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


