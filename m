Return-Path: <linux-integrity+bounces-6404-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D5EAD44DB
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Jun 2025 23:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A18C17C8B3
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Jun 2025 21:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6347284B25;
	Tue, 10 Jun 2025 21:35:26 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0781523958C;
	Tue, 10 Jun 2025 21:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749591326; cv=none; b=rT1tQkkAbkCajkxCWOnCZP8O80Xo7ExROWc36XnX95j8Ux3M6Bw8azK2W6HKW/eAO1YsUQz52O2/C0I4QqQY03a57epDYmD8KrD8gp7MaCNKdlOCHsFxij9/VaNOg5HpQw9NWlSHHS9wHvqUfVp1s3RhNV1aTe447DgbGnwrYtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749591326; c=relaxed/simple;
	bh=gwZKgBazCZ+DbEVttYPYlqT2KBc+VzDMd1ePAXW88l4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PPtpHGVR+CEsHgK/XWfr6Xd61NvOhOVZrQd9l++fOhXQW5mXAbFc3MwLtaz1HeC3mq22rEk5iiLiPb120/i4Im6M8YS2loBsq7YvIA+1fAeJ0O5XKB1s5SF0iR2gOcOgvzQyNbUpGjNjlWUUvpVeRzyL3l8imyOZ4lZrnt5u8lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C55E6168F;
	Tue, 10 Jun 2025 14:35:04 -0700 (PDT)
Received: from u103485.austin.arm.com (u103485.arm.com [10.118.30.35])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED6BB3F66E;
	Tue, 10 Jun 2025 14:35:23 -0700 (PDT)
From: Prachotan Bathi <prachotan.bathi@arm.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Stuart Yoder <stuart.yoder@arm.com>
Cc: linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prachotan Bathi <prachotan.bathi@arm.com>
Subject: [PATCH v2 0/1] tpm_crb_ffa: handle tpm busy return code
Date: Tue, 10 Jun 2025 16:35:04 -0500
Message-ID: <20250610213505.3881352-1-prachotan.bathi@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Platforms supporting direct message request v2 can
support SPs that support multiple services.
If the TPM service is sharing the SP with another service,
it could get an error code of BUSY if the other service is
in process.
We need a way for the driver to retry sending the message
to the TPM service until it succeeds or we know that no forward progress
can be made.
This adds a parameterized variable (default 2000ms)
that indicates the maximum time to keep retrying for.

This is building on top of commit a85b55ee64a5da58c6e2c69e2648023189210eae.
A tpm service can be accessed by the driver using direct message request v2 
interface according to chapter 3.3, TPM Service Command Response Buffer 
Interface Over FF-A specificationi v1.0 EAC.

Prachotan Bathi (1):
  tpm_crb_ffa: handle tpm busy return code

 drivers/char/tpm/tpm_crb_ffa.c | 78 +++++++++++++++++++++++-----------
 1 file changed, 54 insertions(+), 24 deletions(-)

-- 
2.43.0


