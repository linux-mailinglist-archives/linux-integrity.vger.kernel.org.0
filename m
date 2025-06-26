Return-Path: <linux-integrity+bounces-6555-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6671AAEA5A0
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Jun 2025 20:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9959564A9D
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Jun 2025 18:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D5A2ED86E;
	Thu, 26 Jun 2025 18:45:34 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506612ED860;
	Thu, 26 Jun 2025 18:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750963534; cv=none; b=GmcNn5PrdKijpaIN4mLPw34/yqGpV7zzmsasENYRSbKrbivD2WqIINvX208N541dbW8qhTX+sWwhqGQuYPd0Z0aTYmFyZ4UTRrI7Rt6xzt3Q3MFNZRdkWuU492/SUrnyO/NdRE89DwK94Q7YwPtHj05TyxoLQnPNezFGY23ftN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750963534; c=relaxed/simple;
	bh=1CUSM+lfuLzOsSC+bX+I/lNB4T5n24SrRpc6lG9DhZs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nF9ezh9uvfDljERpN7CwWi1afpNvME7jm3vpKTgcsW340rifiaVOwmK+OVStaOy5Z0TuD6ugLZ6U5a4RbPA98pz9FD8xoRPQgBXKIv+TCWKuZuL8QZgVuvckSKi9KBFzVlX/YdmqaboWH7p+W/CHusWFJfs/6UMsIb1F0plgjm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B39131692;
	Thu, 26 Jun 2025 11:45:13 -0700 (PDT)
Received: from u103485.austin.arm.com (u103485.arm.com [10.118.30.35])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2658D3F66E;
	Thu, 26 Jun 2025 11:45:31 -0700 (PDT)
From: Prachotan Bathi <prachotan.bathi@arm.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Stuart Yoder <stuart.yoder@arm.com>
Cc: linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prachotan Bathi <prachotan.bathi@arm.com>
Subject: [PATCH v8 0/3] tpm_crb_ffa: handle tpm busy return code
Date: Thu, 26 Jun 2025 13:45:18 -0500
Message-ID: <20250626184521.1079507-1-prachotan.bathi@arm.com>
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

Changes in v8:
- Moved memzero macro to a separate patch.
- Changes to inline comments for consistency.

Prachotan Bathi (3):
  tpm_crb_ffa: Fix typos in function name
  tpm_crb_ffa:Introduce memzero macro to replace memset
  tpm_crb_ffa: handle tpm busy return code

 .../admin-guide/kernel-parameters.txt         |  8 +++
 drivers/char/tpm/tpm_crb_ffa.c                | 59 +++++++++++++++----
 2 files changed, 56 insertions(+), 11 deletions(-)

-- 
2.43.0


