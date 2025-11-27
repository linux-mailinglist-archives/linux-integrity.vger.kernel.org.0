Return-Path: <linux-integrity+bounces-7689-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D04A2C8EA79
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Nov 2025 14:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25BA13B6574
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Nov 2025 13:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1163B330323;
	Thu, 27 Nov 2025 13:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="joKI+B33"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91DF32C93C
	for <linux-integrity@vger.kernel.org>; Thu, 27 Nov 2025 13:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764251692; cv=none; b=cZskAbQEgKOR4gY3vjadOpLQwWBkHnwEHrJPYtHJ9Bi6vBFLvI4f0q1FOoFqq2J8PuM2wlOZoSpULFdsBj4Wi1vbkVT/bYavn9Z2f8hWHcnvEdUHm++zsOQmRF4beoq5Tas4N5rOV2NkWZvGdlcbjerU/cxSCsyFgJeTqyFLUcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764251692; c=relaxed/simple;
	bh=w+N87en27rsJ3NJ8h8Yka8oSv3mpvx4ldcbDQkyBU5I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cpmCaQm3IHUNDZ56nCSKct3ULu1qy+heRy7Vfnub2cZh6G7ZwuES+jUnkAypxIDF6ihGbMvCyRhcC+of5KRyPDVjHbbdDqUT45+TfFZFfEoIARJCOyCidH+ZBPF2z3wYt9o5mPesHo4sboP+Vv9B+u7yl/stvav2lZ5RykSvvrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=joKI+B33; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA247C4CEF8;
	Thu, 27 Nov 2025 13:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764251692;
	bh=w+N87en27rsJ3NJ8h8Yka8oSv3mpvx4ldcbDQkyBU5I=;
	h=From:To:Cc:Subject:Date:From;
	b=joKI+B33wwgcgZJ10giW0OEneq5zRoJlEc0hEv9KjFinmrkB6ktgpJwu9JR9D0x53
	 ZlnxJc+tVg8FdO0UZ6r5fJa7mKKDsUhePcs5dLIOgOG/t1vjTy4rY48/FbGDyHB5kk
	 KAqr+6dg4boRLfToMjc2ityuR32DPHsif/+FUUmNbsKZqXVGpF/Q3G51RMXFEsb38z
	 41nR4qQsvHvJlEWXsolaFBGEU8cGmlJlO+EZ9pclVXHmMssPPK60uJEgkzfJHpaonZ
	 pArgSssWIXf2OVXvv/3mZG9sY/B0Jg5xJL4ftM9tU8h76QS5A8RDbQxOS9Ij5bx1tL
	 +qI/15k6G7o5A==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: ross.philipson@oracle.com,
	Jonathan McDowell <noodles@earth.li>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH v7 00/11] Prepare TPM driver for Trenchboot
Date: Thu, 27 Nov 2025 15:54:32 +0200
Message-ID: <20251127135445.2141241-1-jarkko@kernel.org>
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
 drivers/char/tpm/tpm-chip.c               |  13 +-
 drivers/char/tpm/tpm-sysfs.c              |  21 +-
 drivers/char/tpm/tpm.h                    |   2 -
 drivers/char/tpm/tpm1-cmd.c               | 185 +++++-------
 drivers/char/tpm/tpm2-cmd.c               | 332 +++++++++++-----------
 drivers/char/tpm/tpm2-sessions.c          | 129 ++++-----
 drivers/char/tpm/tpm2-space.c             |  44 ++-
 drivers/char/tpm/tpm_vtpm_proxy.c         |  30 +-
 include/linux/tpm.h                       |  74 ++---
 security/keys/trusted-keys/trusted_tpm1.c |  36 +--
 security/keys/trusted-keys/trusted_tpm2.c | 291 ++++++++-----------
 12 files changed, 584 insertions(+), 716 deletions(-)

-- 
2.52.0


