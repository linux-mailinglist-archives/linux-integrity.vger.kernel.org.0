Return-Path: <linux-integrity+bounces-5255-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E26A5E6CE
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Mar 2025 22:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC58B3B976F
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Mar 2025 21:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB391EFFA2;
	Wed, 12 Mar 2025 21:58:39 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5D31EB1B3;
	Wed, 12 Mar 2025 21:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741816719; cv=none; b=ZnHIwGAQBv1hRW7M/ezo6aR9qzABkioXK3ALRlRPpu/eihk2Iyky/pAjaQKiVjaKc6rYfnpKCphargDcAEFxB5SUNUWAuSFCttLzNdSQN+M7N+PuH8MlLO+aEZyRTJEk9A5EAjyNQX8c9oRmZTmhx1ytRuArKn2mPcDddGHUVIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741816719; c=relaxed/simple;
	bh=sNzJT+prTqhDB9QFsMekKmeL10/QzJshYFsfaeCzC4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Uf5e/MV6B66uLZaHCR4IGKPAsaVTTkAu3JDVi5Lho3sFN+puG1gTCtp1HcueeGQvRpofjQyBFHGbg4aVHJtJGGQ2E7ZAuA5uEr3Bsv5Mem16Q1Z9jZUEcQn/VnXfU2kmb88E5f53h4woRNCW/TrZ3T4+8xxhX/Onq8+pbc26R9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85D3415A1;
	Wed, 12 Mar 2025 14:58:47 -0700 (PDT)
Received: from beelzebub.ast.arm.com (unknown [10.118.28.29])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D1DE83F5A1;
	Wed, 12 Mar 2025 14:58:36 -0700 (PDT)
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
Subject: tFrom 1dc5533382b9951c70b1a38f02065b41453b175a Mon Sep 17 00:00:00 2001
Date: Wed, 12 Mar 2025 16:58:23 -0500
Message-Id: <20250312215828.664402-1-stuart.yoder@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Firmware Framework for Arm A-profile (FF-A) is a messaging framework
for Arm-based systems, and in the context of the TPM CRB driver is used
to signal 'start' to a CRB-based TPM service which is hosted in an
FF-A secure partition running in TrustZone.

These patches add support for the CRB FF-A start method defined
in the TCG ACPI specification v1.4 and the FF-A ABI defined
in the Arm TPM Service CRB over FF-A (DEN0138) specification:
https://developer.arm.com/documentation/den0138/latest/

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

The fifth patch adds documentation explaining how the CRB driver
and FF-A relate.

Version 8
-all changes made to patch 1:
  -fixed link error when tpm_crb was built-in and tpm_ffa_crb
   was built as module by changing IS_ENABLED() to IS_REACHABLE()
   in tpm_ffa_crb.h
  -cleaned up Kconfig definition for tpm_ffa_crb
  -added Jarkko's Reviewed-by tag
  -added ffa_tpm: to subject

Version 7
-added the tpm_ffa_crb documentation to index.rst

Version 6
-in tpm_crb removed unnecessary brackets from if statement and
 fixed comment style
-noticed and fixed bug in patch 2, polarity of return value
 from tpm_crb_has_idle() was wrong and wasn't caught in past
 testing
-added Reviewed-by tag to patches 2 and 5

Version 5
-tpm_ffa_crb patch: removed module version
-tpm_ffa_crb patch: fixed module description
-tpm_ffa_crb patch: updated comment on mutex declaration
-reworded commit message for patch 2 as per Jarkko's 
 suggestion
-added Acked tag by Sudeep to patch 1 for FF-A changes 
-added Reviewed-by tag to patches 3 and 4

Version 4
-fix warning from kernel test robot in patch 1
-fix warnings from checkpatch.pl --strict
-clean up unnecessary parenthesis usage
-update variable declaration to be reverse tree order
-document exported functions in tpm_crb_ffa driver
-remove unnecessary author and maintainer info in tpm_crb_ffa driver
-fix declaration of variables to be in reverse tree order

Version 3
-changed prefixes used throughout patch series to tpm_crb_ffa*

Version 2
-updates to cover letter to define FF-A
-added new patch with documentation
-created pull request in ACPIA and added link to the patch
 updating actbl3.h
-added tpm_ prefix to the FF-A CRB driver

Stuart Yoder (5):
  tpm_crb: ffa_tpm: implement driver compliant to CRB over FF-A
  tpm_crb: clean-up and refactor check for idle support
  ACPICA: add start method for Arm FF-A
  tpm_crb: add support for the Arm FF-A start method
  Documentation: tpm: add documentation for the CRB FF-A interface

 Documentation/security/tpm/index.rst       |   1 +
 Documentation/security/tpm/tpm_ffa_crb.rst |  65 ++++
 drivers/char/tpm/Kconfig                   |   9 +
 drivers/char/tpm/Makefile                  |   1 +
 drivers/char/tpm/tpm_crb.c                 | 105 +++++--
 drivers/char/tpm/tpm_crb_ffa.c             | 348 +++++++++++++++++++++
 drivers/char/tpm/tpm_crb_ffa.h             |  25 ++
 include/acpi/actbl3.h                      |   1 +
 8 files changed, 536 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/security/tpm/tpm_ffa_crb.rst
 create mode 100644 drivers/char/tpm/tpm_crb_ffa.c
 create mode 100644 drivers/char/tpm/tpm_crb_ffa.h

-- 
2.34.1


