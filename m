Return-Path: <linux-integrity+bounces-6424-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6344AD5F17
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Jun 2025 21:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D5603A9DCD
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Jun 2025 19:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAC46FBF;
	Wed, 11 Jun 2025 19:30:28 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75EC0380;
	Wed, 11 Jun 2025 19:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749670228; cv=none; b=E7XOsjQAs1j0mvAA+MQ21uJH1ScQdiR5mwYdX9yCNWkAfO482Do1js2V2D36bMlxGKF6MpMg1JnIPZZtVLbAkg3lX/RtMv+r17TTmnoH0qOzum8Iyjcvxpdppr2FMuuPCSk0m5WVt0otWHltpfB2lj01MfsR1CcJmfKddtBqs+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749670228; c=relaxed/simple;
	bh=lspRD+EjNUrsQwv/Fb2PcH05AzLXWNdx6wZjaqjsLAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MSPndk/JmmxJzryjZogqFvdWQJ3978OjQSgX/MYv6i/qPAUsMGrsXj5h5TfDW8XZomaNp43h0/ZmJxUue/63BZY4bH3U13wCe4LmAY7U+9wAJHoc3vQYTVEWq+eCO3Hkm1BidgdwfzOGLYlsRNZsC6e9YfieZANpZSQLLEFB9ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACEA01688;
	Wed, 11 Jun 2025 12:30:05 -0700 (PDT)
Received: from u103485.austin.arm.com (u103485.arm.com [10.118.30.35])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 301F53F66E;
	Wed, 11 Jun 2025 12:30:25 -0700 (PDT)
From: Prachotan Bathi <prachotan.bathi@arm.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Stuart Yoder <stuart.yoder@arm.com>
Cc: linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prachotan Bathi <prachotan.bathi@arm.com>
Subject: [PATCH v3 0/1] tpm_crb_ffa: handle tpm busy return code
Date: Wed, 11 Jun 2025 14:30:08 -0500
Message-ID: <20250611193009.3941971-1-prachotan.bathi@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Platforms supporting direct message request v2 can
support Secure Partitions (SPs) that support multiple services.
If the TPM service is sharing the SP with another service,
it could get an error code of BUSY if the other service is
in process.
We need a way for the driver to retry sending the message
to the TPM service until it succeeds or we know that no forward progress
can be made.
This adds a parameterized variable (default 2000ms)
that indicates the maximum time to keep retrying for.

This is building on top of commit a85b55ee64a5.
A tpm service can be accessed by the driver using direct message 
request v2 interface according to chapter 3.3, TPM 
Service Command Response Buffer Interface Over FF-A 
specificationi v1.0 EAC.
See:
https://developer.arm.com/documentation/den0138/latest/

Changes in v3:
- Comments re-written per kernel coding style.

Prachotan Bathi (1):
  tpm_crb_ffa: handle tpm busy return code

 drivers/char/tpm/tpm_crb_ffa.c | 78 +++++++++++++++++++++++-----------
 1 file changed, 54 insertions(+), 24 deletions(-)

-- 
2.43.0


