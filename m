Return-Path: <linux-integrity+bounces-6451-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA49AD98B6
	for <lists+linux-integrity@lfdr.de>; Sat, 14 Jun 2025 01:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93A964A148D
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Jun 2025 23:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5D022F76C;
	Fri, 13 Jun 2025 23:31:52 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC5D1DF258;
	Fri, 13 Jun 2025 23:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749857512; cv=none; b=o5orR0kQoVUYWyyGRPwE/mOATKYFQ77M/cJuDaLv4i2DTzCnSKAlX26mSx+mJgiaWpo6+JnRilN5BNa9K3oROkAaly5lCRWt7IQiCBrU//9/v4kauZSfqn5sqFf1+IxfQXxJfbqPrFoKj5uwPXIGWX2Kk1/uVBla4ix/NLpm7VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749857512; c=relaxed/simple;
	bh=gsYojMPyJ0oQagOCr8PG52brf8VytUgnofN6otC7NfY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GUoelLnSgi6mHNeY9S2AY/HNOgifllykV/Y0iD8nrrEGAAXtBm3aWFT24yM134+UkDA5oZJeIy9RBrJ+vulbn+i4IP52fOnGiOepQI9Kqd9vmaKGNb/rlSBkPid2K63M3VSrgHtFAN2ipKL6Jwd1DAwfhws2hqOPnOy2UCl+GeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DC571C0A;
	Fri, 13 Jun 2025 16:31:28 -0700 (PDT)
Received: from u103485.austin.arm.com (u103485.arm.com [10.118.30.35])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 76AAD3F66E;
	Fri, 13 Jun 2025 16:31:48 -0700 (PDT)
From: Prachotan Bathi <prachotan.bathi@arm.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Stuart Yoder <stuart.yoder@arm.com>
Cc: linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prachotan Bathi <prachotan.bathi@arm.com>
Subject: [PATCH v4 0/1] tpm_crb_ffa: handle tpm busy return code
Date: Fri, 13 Jun 2025 18:31:31 -0500
Message-ID: <20250613233132.4167653-1-prachotan.bathi@arm.com>
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
re-attempt the TPM request until it succeeds or a configurable timeout
(default: 2000 ms) is reached. This ensures reliable TPM access under
shared-SP conditions.

Add a module parameter, `busy_timeout`, which specifies the
maximum amount of time (in milliseconds) to retry on BUSY before giving
up.

This change builds on top of commit a85b55ee64a5, which introduced
support for TPM service communication using the FF-A direct message v2
path, in accordance with section 3.3 of the TPM Service Command
Response Buffer Interface specification.
https://developer.arm.com/documentation/den0138/latest/

Changes in v4:
- Updated commit message to clarify the purpose of the patch.
- Removed comments that state the obvious.

Prachotan Bathi (1):
  tpm_crb_ffa: handle tpm busy return code

 drivers/char/tpm/tpm_crb_ffa.c | 74 +++++++++++++++++++++++-----------
 1 file changed, 50 insertions(+), 24 deletions(-)

-- 
2.43.0


