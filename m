Return-Path: <linux-integrity+bounces-7708-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B680EC90336
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Nov 2025 22:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36DA13A9506
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Nov 2025 21:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B23C30AAB3;
	Thu, 27 Nov 2025 21:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQ5gAfk7"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA372E92B7
	for <linux-integrity@vger.kernel.org>; Thu, 27 Nov 2025 21:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764279707; cv=none; b=pbLAHTg7T4DNUimND7UiH4asZe6TH9nZfwirJA+0BppQeWXOyG54pdrUL3pDtU1AjcICnAO5qb1jdyhaZv/LLrveQmSAwxmVEOAH5Cci/slaKKwJRLAAwh4AVVLL/YDfAi0PPDkjAmjprfAuqzI8yBIrWyPBLHDdD5BR1IyfuUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764279707; c=relaxed/simple;
	bh=3yC/J7+bFc09Jgri9TPu8LZgpYXgAkk/COf8JvqdrJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KhccjTrZJUgcH0eySr/MNT3kQ8lSBgvpjydOjjYb7sfyodjsvG0VrHwyxKPJIOlZ3GMCsVWUfcmDCxesP0Ox4KRaK0ZLlqFlxlvCwvj6VMes047+JHX1/JNELd8T6qcsblZ/z2Ug/j0GRhVQPaXMywfgmR1RYZCcGdSF43g+Vu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQ5gAfk7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00EDCC4CEF8;
	Thu, 27 Nov 2025 21:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764279706;
	bh=3yC/J7+bFc09Jgri9TPu8LZgpYXgAkk/COf8JvqdrJ0=;
	h=From:To:Cc:Subject:Date:From;
	b=OQ5gAfk7RfvXrfXlGRaXT6FP7CKkbO/HUD+0IMBNh7aC3P64TFVrme6phw01KcMpu
	 BhbJDDEnKLDBHOKl5Y7OtDrnpPSCURAFMY5oFJW1RUIWCngM7rUqeGZHVOFgmSUOQX
	 h3s8rcjZ766dtCZUr58SNGevED2WZ+E+KYFRvKDhw1KF5dQosSB6mSN4wJIGj9P3Lw
	 k40hNcu3JKSca7fFI+HPV6jdEBBhAY71MxByNTGKudKVTY96d08CRQBO6mAiGM6maT
	 EdE2rrFkppimI1MP6YYlYr7CkpQ8LzNYiTIbLRr6wlHe1Qnag8rjyzz5EI/d+zj3+5
	 fWzxzeCjqa1SA==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: ross.philipson@oracle.com,
	Jonathan McDowell <noodles@earth.li>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH v8 00/11] Prepare TPM driver for Trenchboot
Date: Thu, 27 Nov 2025 23:41:25 +0200
Message-ID: <20251127214138.3760029-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Overview
========

Start preparing TPM driver for Trenchboot by decoupling tpm_buf from
driver and memory allocation.

Backlog (of stuff that will end up to a follow-up patch sets):

1. Static flat duration table for TPM 1.2. Such feature already landed
   in v6.17 for TPM 2.0. We probably can figure out some sane roof
   values for the legacy standard, right? This allows to share more
   code "via data".
2. Not a blocker for sending subsequent versions of Trenchboot patch set
   but we could look at slicing tpm_tis code at some point of future.
   It could be even that redundant parts could be "merged" after the
   feature lands but this is neither a promise (depends on how things
   look overall).

This patch set does not do a lot heavy-lifting but is beefed enough that
it is better not fatten it up too much anymore. Sane buffering is a
great starting point.

v8:
- Fixed reported issues.
- Did some focused testing on TPM 1.2 using swtpm to make sure that
  it is working correctly.
- For previous there were some issues on testing side that I failed
  to notice. Fixed a bug with tpm2_find_hash_alg found after
  addressing this.
v7:
- Fixed reported issues.
v6:
- Fixed a memory leak that I found trom trusted keys.
v5:
- Order sobs correctly.
- Fixed a minor glitch in 9/9.
v4:
- PCR patch has been removed because it does not fly without Trenchboot
  context.
v3:
- I think 6.19 is a better goal for this and thus expanded the series to
  be a generic Trenchboot enablers series. This version also consolidates
  my two separate ongoing series.
v2:
- While including fixes from v1, this patch set has a refocus in order to
  do minimal changes to make code base more compatible  Trenchboot.

Jarkko Sakkinen (11):
  tpm: Cap the number of PCR banks
  tpm: Use -EPERM as fallback error code in tpm_ret_to_err
  KEYS: trusted: remove redundant instance of tpm2_hash_map
  KEYS: trusted: Fix memory leak in tpm2_load()
  KEYS: trusted: Use tpm_ret_to_err() in trusted_tpm2
  tpm2-sessions: Remove 'attributes' from tpm_buf_append_auth
  tpm2-sessions: Unmask tpm_buf_append_hmac_session()
  KEYS: trusted: Open code tpm2_buf_append()
  tpm-buf: unify TPM_BUF_BOUNDARY_ERROR and TPM_BUF_OVERFLOW
  tpm-buf: Remove chip parameter from tpm_buf_append_handle
  tpm-buf: Enable managed and stack allocations.

 drivers/char/tpm/tpm-buf.c                | 143 ++++++----
 drivers/char/tpm/tpm-sysfs.c              |  21 +-
 drivers/char/tpm/tpm.h                    |   1 -
 drivers/char/tpm/tpm1-cmd.c               | 165 +++++------
 drivers/char/tpm/tpm2-cmd.c               | 327 +++++++++++-----------
 drivers/char/tpm/tpm2-sessions.c          | 129 ++++-----
 drivers/char/tpm/tpm2-space.c             |  44 ++-
 drivers/char/tpm/tpm_vtpm_proxy.c         |  30 +-
 include/linux/tpm.h                       |  68 ++---
 security/keys/trusted-keys/trusted_tpm1.c |  36 +--
 security/keys/trusted-keys/trusted_tpm2.c | 289 ++++++++-----------
 11 files changed, 569 insertions(+), 684 deletions(-)

-- 
2.52.0


