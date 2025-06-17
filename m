Return-Path: <linux-integrity+bounces-6461-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BD9ADD539
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Jun 2025 18:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3B32194586B
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Jun 2025 16:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C4F2ECEA9;
	Tue, 17 Jun 2025 16:05:57 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2372ECE90;
	Tue, 17 Jun 2025 16:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176357; cv=none; b=PUvjgGIVbEe6dFvAq5dJbMod5w2Y9oNmwjs10rPwTO/WI/15G5ZEVhjvv7P3vAxiPE89M5x62qn6UXFguMqi6YGhGMMbhXgAwqP3IYiT5Pnbxsdvv9pTLKiughR/sp5coHD+k2N4mfoEkCMXr8zeaNdeRQ06LDcDF6w9Z2+ie0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176357; c=relaxed/simple;
	bh=/u//Ad1jDTkQ1ypTWwUqaw4fj2DPdYTou2KtqckTitQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kryQlvTncgNRrHE/jo6H8XCE7TOBT0wWebSO769W1Y9iqVXcFLYSEJrju6Kt+jTSUh39eNeSONukRtVxIw+S9k+cu8KResRMwEVwMEXBF8Mdq2VQL+Dg4Oy0tcBYxyEOyiIfUwF5kD6C49VUwKWff+D7CvIhfwurvLD5oy0ug/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0028150C;
	Tue, 17 Jun 2025 09:05:34 -0700 (PDT)
Received: from u103485.austin.arm.com (u103485.arm.com [10.118.30.35])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 73F3E3F58B;
	Tue, 17 Jun 2025 09:05:55 -0700 (PDT)
From: Prachotan Bathi <prachotan.bathi@arm.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Stuart Yoder <stuart.yoder@arm.com>
Cc: linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prachotan Bathi <prachotan.bathi@arm.com>
Subject: [PATCH v6 0/2] tpm_crb_ffa: handle tpm busy return code
Date: Tue, 17 Jun 2025 11:05:42 -0500
Message-ID: <20250617160544.444321-1-prachotan.bathi@arm.com>
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

Changes in v6:
- Typo fixes in function name.
- Introduce __tpm_crb_ffa_try_send_receive.
- Modify tpm_crb_ffa_send_receive to use the new function with retry logic.
- Use memzero() macro instead of memset() for clearing buffers.

Prachotan Bathi (2):
  tpm_crb_ffa: Fix typos in function name
  tpm_crb_ffa: handle tpm busy return code

 drivers/char/tpm/tpm_crb_ffa.c | 70 ++++++++++++++++++++++++++--------
 1 file changed, 55 insertions(+), 15 deletions(-)

-- 
2.43.0


