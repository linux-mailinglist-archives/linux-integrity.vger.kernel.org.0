Return-Path: <linux-integrity+bounces-4808-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA46A33211
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Feb 2025 23:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B766188B0AE
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Feb 2025 22:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965562638B9;
	Wed, 12 Feb 2025 22:06:03 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51B021324C;
	Wed, 12 Feb 2025 22:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739397963; cv=none; b=VGjTnXuOV9EFJKNlEd0YRG7fk0k+VWoaTOafiUgnnwTC97EH0WQH1MMxEqXNQ4dbVmws41ZvMov7H76X2ieEf2QY2YtQPDOft9CUDhre1cOruadLCorcsoE7mS3ydu8zb+dEIBw/00GN9QrjF+ebtDdTl2TUU2o8e2Hshvta1EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739397963; c=relaxed/simple;
	bh=HhdPSqYLpQ5lQYR81NNcgP62jGp4ZtCGPJT7J3P3ZEo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hsWvJgYl6YK/p1PiBSVqdcyQDazy9CKY6PVQYi+Jp0WtEgdzOsTXjHb4xFEajwg8+lcOyYjVT8nh1WSijRZW8zHpwq8ZFcMo7L+IDZ7fAGhOhWynONUQkpyMdc9h7b1/o75RMSGIUMC7RulqXggP+0GDBdquXRku0Zgvk7pGxbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A4332659;
	Wed, 12 Feb 2025 14:06:20 -0800 (PST)
Received: from beelzebub.ast.arm.com (u203013-lin.austin.arm.com [10.118.28.29])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 262153F792;
	Wed, 12 Feb 2025 14:05:59 -0800 (PST)
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
Subject: [PATCH v2 5/5] Documentation: tpm: add documentation for the CRB FF-A interface
Date: Wed, 12 Feb 2025 16:05:48 -0600
Message-Id: <20250212220548.400447-6-stuart.yoder@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250212220548.400447-1-stuart.yoder@arm.com>
References: <20250212220548.400447-1-stuart.yoder@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add documentation providing details of how the CRB driver interacts
with FF-A.

Signed-off-by: Stuart Yoder <stuart.yoder@arm.com>
---
 Documentation/security/tpm/tpm_ffa_crb.rst | 65 ++++++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/security/tpm/tpm_ffa_crb.rst

diff --git a/Documentation/security/tpm/tpm_ffa_crb.rst b/Documentation/security/tpm/tpm_ffa_crb.rst
new file mode 100644
index 000000000000..c70f8904a93d
--- /dev/null
+++ b/Documentation/security/tpm/tpm_ffa_crb.rst
@@ -0,0 +1,65 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+========================
+TPM CRB over FF-A Driver
+========================
+
+The TPM Command Response Buffer (CRB) interface is a standard TPM interface
+defined in the TCG PC Client Platform TPM Profile (PTP) Specification [1]_.
+The CRB provides a structured set of control registers a client uses when
+interacting with a TPM as well as a data buffer for storing TPM commands and
+responses. A CRB interface can be implemented in:
+
+- hardware registers in a discrete TPM chip
+
+- in memory for a TPM running in isolated environment where shared memory
+  allows a client to interact with the TPM
+
+The Firmware Framework for Arm A-profile (FF-A) [2]_ is a specification
+that defines interfaces and protocols for the following purposes:
+
+- Compartmentalize firmware into software partitions that run in the Arm
+  Secure world environment (also know as TrustZone)
+
+- Provide a standard interface for software components in the Non-secure
+  state, for example OS and Hypervisors, to communicate with this firmware.
+
+A TPM can be implemented as an FF-A secure service.  This could be a firmware
+TPM or could potentially be a TPM service that acts as a proxy to a discrete
+TPM chip. An FF-A based TPM abstracts hardware details (e.g. bus controller
+and chip selects) away from the OS and can protect locality 4 from access
+by an OS.  The TCG-defined CRB interface is used by clients to interact
+with the TPM service.
+
+The Arm TPM Service Command Response Buffer Interface Over FF-A [3]_
+specification defines FF-A messages that can be used by a client to signal
+when updates have been made to the CRB.
+
+How the Linux CRB driver interacts with FF-A is summarized below:
+
+- The tpm_ffa_crb driver registers with the FF-A subsystem in the kernel
+  with an architected TPM service UUID defined in the CRB over FF-A spec.
+
+- If a TPM service is discovered by FF-A, the probe() function in the
+  tpm_ffa_crb driver runs, and the driver initializes.
+
+- The probing and initialization of the Linux CRB driver is triggered
+  by the discovery of a TPM advertised via ACPI.  The CRB driver can
+  detect the type of TPM through the ACPI 'start' method.  The start
+  method for Arm FF-A was defined in TCG ACPI v1.4 [4]_.
+
+- When the CRB driver performs its normal functions such as signaling 'start'
+  and locality request/relinquish it invokes the ffa_crb_start() funnction
+  in the tpm_ffa_crb driver which handles the FF-A messaging to the TPM.
+
+References
+==========
+
+.. [1] **TCG PC Client Platform TPM Profile (PTP) Specification**
+   https://trustedcomputinggroup.org/resource/pc-client-platform-tpm-profile-ptp-specification/
+.. [2] **Arm Firmware Framework for Arm A-profile (FF-A)**
+   https://developer.arm.com/documentation/den0077/latest/
+.. [3] **Arm TPM Service Command Response Buffer Interface Over FF-A**
+   https://developer.arm.com/documentation/den0138/latest/
+.. [4] **TCG ACPI Specification**
+   https://trustedcomputinggroup.org/resource/tcg-acpi-specification/
-- 
2.34.1


