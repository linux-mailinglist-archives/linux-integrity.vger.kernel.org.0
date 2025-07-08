Return-Path: <linux-integrity+bounces-6641-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9495EAFDB62
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Jul 2025 00:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1F12584F11
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Jul 2025 22:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A92E22330F;
	Tue,  8 Jul 2025 22:52:12 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7569B22837F;
	Tue,  8 Jul 2025 22:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752015132; cv=none; b=NMDhB8Nn7lLW/XvD44jr9floxHNa59l7uu20gT3nmivkVhIaKDcKLB4ewnOL36lRjpthQGm3VJh9sSnitYxLelkM/vq5N/pXTrB2kTFHMFXa0XBmriqOkoUNa4RwT5WAWf4NHCDJ5NPmi9nJkon0rcozPfXBcVdKfaBAlR6qNCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752015132; c=relaxed/simple;
	bh=FB/+V8gOHRNj6pHB9NtlmfRtB1ltOygiacGDjow9PLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gklqy07HPkDmhP031tQnC8OJsPbUw/p+857YNz57v037iwaezYBEi2JhgPFG/GhpOgTwpxzH4TCmlBKDUje5pvXHv2ZJfDsy2UKGUDWZgJiuni9Ar8MAuuTIn6az77JXHSSUMInB7tU70qbAZnYgKz3V+c7rAfWMzs1QMqO/S5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 954A01764;
	Tue,  8 Jul 2025 15:51:56 -0700 (PDT)
Received: from u103485.austin.arm.com (u103485.arm.com [10.118.30.35])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3DAD23F66E;
	Tue,  8 Jul 2025 15:52:08 -0700 (PDT)
From: Prachotan Bathi <prachotan.bathi@arm.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Stuart Yoder <stuart.yoder@arm.com>
Cc: linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prachotan Bathi <prachotan.bathi@arm.com>
Subject: [PATCH v9 0/3] tpm_crb_ffa: handle tpm busy return code
Date: Tue,  8 Jul 2025 17:51:48 -0500
Message-ID: <20250708225151.2473657-1-prachotan.bathi@arm.com>
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
Changes in v9:
- Removed memset usage, introduced designated initialization for
  `tpm_crb_ffa_data` structure.
- Code formatting changes for consistency.

Prachotan Bathi (3):
  tpm_crb_ffa: Fix typos in function name
  tpm_crb_ffa:Remove memset usage
  tpm_crb_ffa: handle tpm busy return code

 .../admin-guide/kernel-parameters.txt         |  8 +++
 drivers/char/tpm/tpm_crb_ffa.c                | 72 +++++++++++++------
 2 files changed, 57 insertions(+), 23 deletions(-)

-- 
2.43.0


