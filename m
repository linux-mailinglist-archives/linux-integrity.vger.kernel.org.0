Return-Path: <linux-integrity+bounces-7723-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C0AC90A96
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Nov 2025 03:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A313934C06F
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Nov 2025 02:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C6A2868A9;
	Fri, 28 Nov 2025 02:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YXIt+PeB"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2271D285CBC
	for <linux-integrity@vger.kernel.org>; Fri, 28 Nov 2025 02:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764298457; cv=none; b=ogyMXAKd4/Ib+O3H8FV3XSX6rIBK9UnzxHuNE6KMWsFOzm1uiuvVQbRoEfyZUA1f3EDJ/USSI2UphiVJIhakvtAWT4fgX9X31IW0k+w2tjhIsahBVq0MLhShKPpxy8G61r8x4HU83bLCgJtCEYGROth1GQAKiZtYCNXjdi7CZRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764298457; c=relaxed/simple;
	bh=7pY8lnEz9opqkve/tK4DPGuyG4b5CKHfaRYlfdFPMvs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UOn25+L0VJEFiMAbWh/l78s5dBUjf1xS6NhjVjTH51Gajs6HOt6gbSZmTLlhVlQUHoq1hSZu+qGNSBOyCKtHplJmTNh8TG2Ojv9v6URV+5rSSRx4cDRLKuq30F5MoPpmD9lvEEQs60ohK3yfSy2TQDr5+q1pBbKUU0QeZzfIpjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YXIt+PeB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B9FC4CEF8;
	Fri, 28 Nov 2025 02:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764298456;
	bh=7pY8lnEz9opqkve/tK4DPGuyG4b5CKHfaRYlfdFPMvs=;
	h=From:To:Cc:Subject:Date:From;
	b=YXIt+PeBMrSLXNsgLJu1S4cidRY4D72+F5Ea6HkmZARuEhpxqkSGEaxn1z+iBz1K2
	 eb2FvDOMqjpY7vYXcGDiy6JdvvC2+yIA+gzuRGjM1/kI8rJjxZleKVAgTsIYmu93cM
	 zeuDostwCxPnQkQJvwqpOSa0fnqtoY3fOdPCyslg4oH05qYxfK/KNnU+fjsHp1RWaz
	 Liq++pHrs/bkal5KFcOTfajmDKw9LX7ysmPlzVi0ZSYfNLfp+StKaKN9R/gK/Kxuso
	 XBRvq/Xy1lrjyC9tL6F+YYRUaK243DjBkZqkxauOzeUFCZCbZvOH/0D8uViVO+7hFP
	 wuxNGgnkqw8Xw==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: ross.philipson@oracle.com,
	Jonathan McDowell <noodles@earth.li>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH v9 0/8] Prepare TPM driver for Trenchboot
Date: Fri, 28 Nov 2025 04:53:52 +0200
Message-ID: <20251128025402.4147024-1-jarkko@kernel.org>
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

v9:
- Dropped patches that went into 6.19 pull request (and that is main
  reason for sending update so quickly).
- I went through the commit message and polished a bit most of them
- Simplified the patch fixing memory leak in  tpm2_load_cmd.
v8:
- Fixed reported issues.
- Did some focused testing on TPM 1.2 using swtpm to make sure that
  it is working correctly.
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

Jarkko Sakkinen (8):
  tpm2-sessions: Remove 'attributes' parameter from tpm_buf_append_auth
  tpm2-sessions: Open code tpm_buf_append_hmac_session()
  KEYS: trusted: Replace a redundant instance of tpm2_hash_map
  KEYS: trusted: Fix a memory leak in tpm2_load_cmd
  KEYS: trusted: Open code tpm2_buf_append()
  tpm-buf: Merge TPM_BUF_BOUNDARY_ERROR and TPM_BUF_OVERFLOW
  tpm-buf: Remove chip parameter from tpm_buf_append_handle
  tpm-buf: Enable managed and stack allocations.

 drivers/char/tpm/tpm-buf.c                | 143 ++++++----
 drivers/char/tpm/tpm-sysfs.c              |  21 +-
 drivers/char/tpm/tpm.h                    |   1 -
 drivers/char/tpm/tpm1-cmd.c               | 162 +++++------
 drivers/char/tpm/tpm2-cmd.c               | 319 +++++++++++-----------
 drivers/char/tpm/tpm2-sessions.c          | 129 +++++----
 drivers/char/tpm/tpm2-space.c             |  44 ++-
 drivers/char/tpm/tpm_vtpm_proxy.c         |  30 +-
 include/linux/tpm.h                       |  56 ++--
 security/keys/trusted-keys/trusted_tpm1.c |  36 +--
 security/keys/trusted-keys/trusted_tpm2.c | 245 +++++++----------
 11 files changed, 544 insertions(+), 642 deletions(-)

-- 
2.52.0


