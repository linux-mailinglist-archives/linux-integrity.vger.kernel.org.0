Return-Path: <linux-integrity+bounces-4828-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A737A352DB
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Feb 2025 01:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A690188FE94
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Feb 2025 00:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9535378F2E;
	Fri, 14 Feb 2025 00:28:00 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C659CCA4E;
	Fri, 14 Feb 2025 00:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739492880; cv=none; b=qWdhxj53AIYhvGjPOgtNkYhRJ3jpQvYIQmf/Q7xrBTDkYdoeJ8rwQ0/zdnCyfhK+ykQG2l4Viyu2pDClOEFA0FsF2BaJru5MKHA3nmT7YrXLodK6Y7goMAalpT3z32VltFe8Fy1uMhgd5y4wrbGinLH1mDl+OTxMXPfLcrhpoHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739492880; c=relaxed/simple;
	bh=jUSUz00ESf+S26jtK/k3pKofGf7cV8jQzbW7nQEsROM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l+FCfgNwqQRqCBXwsOJ4aUerSjut7UNXHrQ2T0k6GytsU5o34NwA78L/8bKTdFI/nLfYUu+1dHSHeCkYSKjzw7lNyPZoqJ8QmqiS2P7uff9cM4sK0WqDkJRY/EOz6I7hLgkjmfD5ewfr1WrMoAwhZKE1FMpee8dTMRZEuQgbJFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 855F4271B;
	Thu, 13 Feb 2025 16:28:16 -0800 (PST)
Received: from beelzebub.ast.arm.com (u203013-lin.austin.arm.com [10.118.28.29])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F37613F762;
	Thu, 13 Feb 2025 16:27:55 -0800 (PST)
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
Subject: [PATCH v3 5/5] Documentation: tpm: add documentation for the CRB FF-A interface
Date: Thu, 13 Feb 2025 18:27:45 -0600
Message-Id: <20250214002745.878890-6-stuart.yoder@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250214002745.878890-1-stuart.yoder@arm.com>
References: <20250214002745.878890-1-stuart.yoder@arm.com>
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
index 000000000000..0184193da3c7
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
+- The tpm_crb_ffa driver registers with the FF-A subsystem in the kernel
+  with an architected TPM service UUID defined in the CRB over FF-A spec.
+
+- If a TPM service is discovered by FF-A, the probe() function in the
+  tpm_crb_ffa driver runs, and the driver initializes.
+
+- The probing and initialization of the Linux CRB driver is triggered
+  by the discovery of a TPM advertised via ACPI.  The CRB driver can
+  detect the type of TPM through the ACPI 'start' method.  The start
+  method for Arm FF-A was defined in TCG ACPI v1.4 [4]_.
+
+- When the CRB driver performs its normal functions such as signaling 'start'
+  and locality request/relinquish it invokes the tpm_crb_ffa_start() funnction
+  in the tpm_crb_ffa driver which handles the FF-A messaging to the TPM.
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


