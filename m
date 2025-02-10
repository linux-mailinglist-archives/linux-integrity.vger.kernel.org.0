Return-Path: <linux-integrity+bounces-4775-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD2EA2FE55
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Feb 2025 00:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C4277A2682
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Feb 2025 23:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEE226138F;
	Mon, 10 Feb 2025 23:22:43 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57865253F16;
	Mon, 10 Feb 2025 23:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739229763; cv=none; b=VzxuVamlro9QDJ596VRRcNPZ6NWC7ujh2zXuUxu35AehCoIkXH8jaoqdCJEaBlfZY8InPfV1CLzKWC+NbVWdBwkI5TDXE2q8qL1E54prIZzT62aaPL3jXlhn2rM9NPRc8V7YcuivB32K6E4JQkxbdtiR6oMJMQ+ejpjLS5Iyu68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739229763; c=relaxed/simple;
	bh=qS8cBMVZdMwBjCEPPy69jB7alNbKE0vfzadmD5By+ss=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F63KWMyO/WWHPPuYWsRv1/ZJb2jfFyeWBH2fsenWj1//d+alaCTSZjfCR4Wdrc3Ed5BNb/xGvXBbYTQbWSPxaO8b8d+RDo5yw/l1+hMlqvWhzI9Vw8oFRC+6QoZNv3NJDnoJqdU+9DFE3QxeE3HPi14VHhHgThlgl+8tG5K+ORI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BBA2D1477;
	Mon, 10 Feb 2025 15:23:00 -0800 (PST)
Received: from beelzebub.ast.arm.com (unknown [10.118.29.240])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CFBB63F6A8;
	Mon, 10 Feb 2025 15:22:38 -0800 (PST)
From: Stuart Yoder <stuart.yoder@arm.com>
To: linux-integrity@vger.kernel.org,
	jarkko@kernel.org,
	peterhuewe@gmx.de,
	jgg@ziepe.ca,
	sudeep.holla@arm.com,
	rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Add support for the TPM FF-A start method
Date: Mon, 10 Feb 2025 17:22:23 -0600
Message-Id: <20250210232227.97761-1-stuart.yoder@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These patches add support for the CRB FF-A start method defined
in the TCG ACPI specification v1.4 and the FF-A ABI defined
in the Arm TPM Service CRB over FF-A (DEN0138) specification. 
(https://developer.arm.com/documentation/den0138/latest/)

FF-A is a messaging framework for Arm-based systems and in the
context of the TPM driver is used to signal 'start' to a CRB-based
TPM service which is hosted in an FF-A secure partition running in
TrustZone.

The first patch adds an FF-A driver to handle the FF-A messaging when
communicating with a CRB-based TPM secure partition built on FF-A.
The driver is probed when the TPM secure partition is discovered by
the Linux FF-A infrastructure.

The second patch consolidates the check for idle support in the CRB
driver to one place.

The third patch defines the new ACPI start method enumeration for
CRB over FF-A.

The fourth patch adds support for the FF-A ACPI start method to
the TPM crb driver.

Stuart Yoder (4):
  tpm_crb: implement driver compliant to CRB over FF-A
  tpm_crb: refactor check for idle support into TPM into inline function
  ACPICA: add start method for Arm FF-A
  tpm_crb: add support for the Arm FF-A start method

 drivers/char/tpm/Kconfig   |   9 ++
 drivers/char/tpm/Makefile  |   1 +
 drivers/char/tpm/ffa_crb.c | 310 +++++++++++++++++++++++++++++++++++++
 drivers/char/tpm/ffa_crb.h |  30 ++++
 drivers/char/tpm/tpm_crb.c |  81 +++++++++-
 include/acpi/actbl3.h      |   1 +
 6 files changed, 426 insertions(+), 6 deletions(-)
 create mode 100644 drivers/char/tpm/ffa_crb.c
 create mode 100644 drivers/char/tpm/ffa_crb.h

-- 
2.34.1


