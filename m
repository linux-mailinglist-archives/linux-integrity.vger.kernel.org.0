Return-Path: <linux-integrity+bounces-6456-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75126ADB887
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Jun 2025 20:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D0B416652F
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Jun 2025 18:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52B8288C16;
	Mon, 16 Jun 2025 18:08:49 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C88C2857F1;
	Mon, 16 Jun 2025 18:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750097329; cv=none; b=ZgnpOpeDUwRJtOZoTr3ol5Ehi8wXO4TbQQYXL99YuAZmDVOJmUEjAntHbRlvMvTSqS+p3x779PDCR2RTwsg1IkY2o30ulw+EuqcvTMxGey+k3+qeZF4GHXmBetYmoXceGfFfV/bU7wTfrz8AlfMEk7wvZEytEPo/L9FdJ6oFCO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750097329; c=relaxed/simple;
	bh=yb7O/n22BPc+7XSKKraulcW028Q4prjBBXVvPokfNAU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gurMOyWlkMjTf3UKpDWZc1S28aQeZRAIUeD1zthvF30Lyz276LJf0B3+ozNSJdjtnKIQONxL8iNh4NlgSE0UIQpzssbrCMGKlkI3rPCLRRD+JVkhNDZSKTT7go2jxonJEvDUQH8z4iP2KOklE/HzMcDPNKsMbgyw/q8xRVtKv6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 328E9150C;
	Mon, 16 Jun 2025 11:08:26 -0700 (PDT)
Received: from u103485.austin.arm.com (u103485.arm.com [10.118.30.35])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 689D83F673;
	Mon, 16 Jun 2025 11:08:47 -0700 (PDT)
From: Prachotan Bathi <prachotan.bathi@arm.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Stuart Yoder <stuart.yoder@arm.com>
Cc: linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prachotan Bathi <prachotan.bathi@arm.com>
Subject: [PATCH v5 0/1] tpm_crb_ffa: handle tpm busy return code
Date: Mon, 16 Jun 2025 13:08:31 -0500
Message-ID: <20250616180832.231418-1-prachotan.bathi@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Platforms that support FF-A direct message request v2 can implement
Secure Partitions (SPs) that host multiple services. When the TPM
service shares its SP with other services, message requests from the
driver may fail with a BUSY response if another service is currently
active.

To improve robustness in such scenarios, we need to introduce retry
logic in the driver. When a BUSY error is received, the driver will
re-attempt the TPM request until it succeeds or a run-time configurable 
timeout(default: 2000 ms) is reached. This ensures reliable TPM access 
under shared-SP conditions.

Add a module parameter, `busy_timeout_ms`, which specifies the
maximum amount of time (in milliseconds) to retry on BUSY before giving
up.

This change builds on top of commit a85b55ee64a5, which introduced
support for TPM service communication using the FF-A direct message v2
path, in accordance with section 3.3 of the TPM Service Command
Response Buffer Interface specification.
https://developer.arm.com/documentation/den0138/latest/

This was tested with an FF-A based fTPM currently not publicly available. 
There are plans to open source the fTPM.

Changes in v5:
- Updated variable name to reflect units.
- Added a dev log message to indicate the retry timeout.
- Updated commit message with directions for users to set the timeout.

Prachotan Bathi (1):
  tpm_crb_ffa: handle tpm busy return code

 drivers/char/tpm/tpm_crb_ffa.c | 77 +++++++++++++++++++++++-----------
 1 file changed, 53 insertions(+), 24 deletions(-)

-- 
2.43.0


