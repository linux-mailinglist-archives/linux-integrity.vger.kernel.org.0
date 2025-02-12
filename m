Return-Path: <linux-integrity+bounces-4804-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E85A33202
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Feb 2025 23:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FDB01618CA
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Feb 2025 22:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5643B20550F;
	Wed, 12 Feb 2025 22:06:01 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D44220371E;
	Wed, 12 Feb 2025 22:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739397961; cv=none; b=UpqAUYGoR9TBs9ABtaysWqlCL9bq+ugjm5KEtNEy+0pfdfgmgxcwCWuOKndmdPc74zAkczLdJGefIWHe1h9ahnjCO3wnw7tRv4qxK5KLmEWWswra3GQM2fBWhL8sHebpZ4eFUPdutTXYerHfn39XnKlCkWNb3U8EZaQ4J4DEcfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739397961; c=relaxed/simple;
	bh=CnhDsgs4brTVXhbLyFsnwIkTTYGj418S63o1C6IG1sM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ULVt+vy4tZDcdyGueldvlshAzMR8lZ8KNfy4RZ3RcOU1oqYH5/OrwVMRUFPnKvuunYwK9MehfISZLJ9qj612EfgGcelQ+Wsuiw5prf5hETICKpV8rCE8joFkpkpOfC4jmENuZ9ajH/z3ip35MlGd9J5WtYlRcNQ5CMNIYbBwbS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A344E113E;
	Wed, 12 Feb 2025 14:06:19 -0800 (PST)
Received: from beelzebub.ast.arm.com (u203013-lin.austin.arm.com [10.118.28.29])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id ACEF93F58B;
	Wed, 12 Feb 2025 14:05:58 -0800 (PST)
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
Subject: [PATCH v2 0/5] Add support for the TPM FF-A start method
Date: Wed, 12 Feb 2025 16:05:43 -0600
Message-Id: <20250212220548.400447-1-stuart.yoder@arm.com>
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

Version 2
-updates to cover letter to define FF-A
-added new patch with documentation
-created pull request in ACPIA and added link to the patch
 updating actbl3.h
-added tpm_ prefix to the FF-A CRB driver

Stuart Yoder (5):
  tpm_crb: implement driver compliant to CRB over FF-A
  tpm_crb: refactor check for idle support into TPM into inline function
  ACPICA: add start method for Arm FF-A
  tpm_crb: add support for the Arm FF-A start method
  Documentation: tpm: add documentation for the CRB FF-A interface

 Documentation/security/tpm/tpm_ffa_crb.rst |  65 +++++
 drivers/char/tpm/Kconfig                   |   9 +
 drivers/char/tpm/Makefile                  |   1 +
 drivers/char/tpm/tpm_crb.c                 |  81 +++++-
 drivers/char/tpm/tpm_ffa_crb.c             | 310 +++++++++++++++++++++
 drivers/char/tpm/tpm_ffa_crb.h             |  30 ++
 include/acpi/actbl3.h                      |   1 +
 7 files changed, 491 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/security/tpm/tpm_ffa_crb.rst
 create mode 100644 drivers/char/tpm/tpm_ffa_crb.c
 create mode 100644 drivers/char/tpm/tpm_ffa_crb.h

-- 
2.34.1


