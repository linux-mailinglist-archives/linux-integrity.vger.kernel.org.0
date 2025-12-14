Return-Path: <linux-integrity+bounces-7964-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48738CBBCA5
	for <lists+linux-integrity@lfdr.de>; Sun, 14 Dec 2025 16:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3D9B3007686
	for <lists+linux-integrity@lfdr.de>; Sun, 14 Dec 2025 15:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D82280329;
	Sun, 14 Dec 2025 15:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1z4LpgS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689B2F9E8;
	Sun, 14 Dec 2025 15:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765726700; cv=none; b=DFeFUZ49rMnn470cXzq3hJSulHKLfDICx30g1EYHnP0BiF7WTbFuYDJPJ7ZSH8o+D4TleBXMEbNGSHjSVGYzCdI0NcmNYwoCKubWiNyoBO9O3AXPRm4ka4bdd3awqi/0bxjunSoTW+rmTbvtgf04W0Uct+za38Li6TMCcXc6y2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765726700; c=relaxed/simple;
	bh=mfZGFvYwB00afGsmpwACn3i/RJ0xUJQPL20YF5j8CKs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q1y1wOJvdnbLxIrqkr2+MC0BAo1tzskh2uwQsJqgRMKvVaD77T7VOQbez/WKCKU8Xq7/YurrD/QtdHDb6EUBL8a9MzxExTi3v3cl26VEkWVozAGz+0TnIRxxdtxO8lnRx61c8GKXsxPnwF71uHqOmS7EGAkSzjutUr17Drc48hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1z4LpgS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E9E9C4CEF1;
	Sun, 14 Dec 2025 15:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765726700;
	bh=mfZGFvYwB00afGsmpwACn3i/RJ0xUJQPL20YF5j8CKs=;
	h=From:To:Cc:Subject:Date:From;
	b=O1z4LpgSyuHt6f1u5JO+wX3BsNUB/lkmLbMq3HydGJLazehfw7iqwfYIZLsc9fu9y
	 YAC6tH2fovFqbNsjdi6RwJEZQIXkby6fe8ZPL9KaGjeEcA5s7yXvQLTD8ekuAEZOkF
	 puzlQzlxWA7VSK6os/M3cXj45IIu08NjOPGI+8NtazTOxvvSFvMF/3UrZLtwM9aFKa
	 H2Jyqxwk+xSCca3rs7IsErZc9gy54QlnT9u7H8AGZ4Q44toPkaa5Hp2EtgqgCK1eiP
	 XMDkkiz/nzeS1AXBDJndoPxmNoaiJB4D20E1+AVb87DQZKndSjdI+pVkjrwD9TqIBl
	 Y//uDYad24n0g==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Ross Philipson <ross.philipson@oracle.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	keyrings@vger.kernel.org (open list:KEYS/KEYRINGS),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 00/11]  Streamline TPM2 HMAC sessions
Date: Sun, 14 Dec 2025 17:37:57 +0200
Message-Id: <20251214153808.73831-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since we cannot at this point cache names of the keys given limitations
of the ASN.1 file format, I'll start a fresh patch set. Let's fixup what
we can right now.

This patch set addresses two major issues in the feature:

1. Dynamic resolution without gain. All kernel sites have at most single
   handle to authorize. Even if this changes some day this is how it is
   as of today and we definitely do not want to dictate the future but
   instead downscale code to the metrics that we have as of today.
2. Eliminate at least one unnnecessary tpm2_read_public() call.

Change Log
==========

v6:
- OK, so I decided to send one more update with managed allocations
  moved to the tail so that it does not block reviewing more trivial
  patches.
- Trimmed some of the patches and improved commit messages.
v5:
- I decided to add the managed allocation patch to this and take it from
  the master branch for the time being, as it needs more eyes despite
  having already one reviewed-by tag (especially tested-by tags).

Jarkko Sakkinen (11):
  tpm2-sessions: Define TPM2_NAME_MAX_SIZE
  KEYS: trusted: Open code tpm2_buf_append()
  KEYS: trusted: Remove dead branch from tpm2_unseal_cmd
  KEYS: trusted: Re-orchestrate tpm2_read_public() calls
  tpm2-sessions: Remove AUTH_MAX_NAMES
  tpm: Orchestrate TPM commands in tpm_get_random()
  tpm: Send only one at most TPM2_GetRandom command
  tpm: In tpm_get_random() replace 'retries' with a zero check
  tpm-buf: Merge TPM_BUF_BOUNDARY_ERROR and TPM_BUF_OVERFLOW
  tpm-buf: Implement managed allocations
  tpm-buf: Remove tpm_buf_append_handle

 drivers/char/tpm/tpm-buf.c                | 154 ++++-----
 drivers/char/tpm/tpm-chip.c               |   2 +-
 drivers/char/tpm/tpm-interface.c          | 177 ++++++++++-
 drivers/char/tpm/tpm-sysfs.c              |  23 +-
 drivers/char/tpm/tpm.h                    |   3 -
 drivers/char/tpm/tpm1-cmd.c               | 198 ++++--------
 drivers/char/tpm/tpm2-cmd.c               | 371 +++++++---------------
 drivers/char/tpm/tpm2-sessions.c          | 272 ++++++----------
 drivers/char/tpm/tpm2-space.c             |  44 ++-
 drivers/char/tpm/tpm_vtpm_proxy.c         |  30 +-
 include/linux/tpm.h                       |  79 +++--
 security/keys/trusted-keys/trusted_tpm1.c |  44 +--
 security/keys/trusted-keys/trusted_tpm2.c | 329 ++++++++++---------
 13 files changed, 799 insertions(+), 927 deletions(-)

-- 
2.39.5


