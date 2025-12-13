Return-Path: <linux-integrity+bounces-7951-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE85CBB333
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Dec 2025 21:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7231300980B
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Dec 2025 20:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F77C481B1;
	Sat, 13 Dec 2025 20:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sM50s8NL"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2FD3B8D75;
	Sat, 13 Dec 2025 20:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765657954; cv=none; b=EDscINzlZZXyT5ZS7xwvue1dKQC4NAylhZzceW0XBmy1MiNRtYhto+bsFsXiikf5SQQc65G0SGMMFIaWAmnnb6fNAy1a1uUXmH+1P/vt/db1Bo/18+4SySVvO2rqGjtys6QExowITQxfDKayEu6R+xDhbI9bYzb4kngdYIIjzgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765657954; c=relaxed/simple;
	bh=6wGdvHLxntMErasleA4cfnTVhcRhIIh86AzeOeaJkpY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qpqwUXyuiowixD/3bRqfSdENwCne2Mf9UK1jh4wSD750jEtRMzcrzXxoUHSHAbwZnDoocTtY3K/DEpBauBILOgKDkseb4d24a3oWIS+/iVQRnXT+X+PfsBxoSV20Jsbn7SGNzFBvLlDlYq+7dBLMkoayUMMJy1FuEzk1Sy+w9dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sM50s8NL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A75C4CEF7;
	Sat, 13 Dec 2025 20:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765657953;
	bh=6wGdvHLxntMErasleA4cfnTVhcRhIIh86AzeOeaJkpY=;
	h=From:To:Cc:Subject:Date:From;
	b=sM50s8NL8PLOjro2Rq/fjoqOC6Z5rq1DRUrfNa5zHqz30AdPksqqymyMzj1zOHd0N
	 ehK6/emIR/S6EF8wouGURpmJX4VDVK+wN+PvCfF5KTIFcTB6qMqVj7TImjpVY1BrS6
	 9+mITA5DaELrS3lnXce9xgzUenO5Uu+NkaVcZIfpA3ReFE5aIW9crqPiUmfFeY9+lW
	 xQqxliY3y9WfzcYffQNVs/VU54xvUiN08CtzCKbXWUfRj1y9os/qzbd/hJTxPN+d8k
	 DSvZfRfjEdKhbZAca+IGCq703oh0D/JUT1xKN2Pm8pM5VGltXhiWujaquoVCdeJXeo
	 WbIvAeADW1Rfw==
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
Subject: [PATCH v5 00/12] Streamline TPM2 HMAC sessions
Date: Sat, 13 Dec 2025 22:32:07 +0200
Message-Id: <20251213203220.317498-1-jarkko@kernel.org>
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

v5:
- I decided to add the managed allocation patch to this and take it from
  the master branch for the time being, as it needs more eyes despite
  having already one reviewed-by tag (especially tested-by tags).

Jarkko Sakkinen (12):
  KEYS: trusted: Open code tpm2_buf_append()
  KEYS: trusted: Remove dead branch from tpm2_unseal_cmd
  tpm2-sessions: Define TPM2_NAME_MAX_SIZE
  tpm-buf: Merge TPM_BUF_BOUNDARY_ERROR and TPM_BUF_OVERFLOW
  tpm-buf: Remove chip parameter from tpm_buf_append_handle
  tpm-buf: Implement managed allocations
  KEYS: trusted: Re-orchestrate tpm2_read_public() calls
  tpm2-sessions: Remove AUTH_MAX_NAMES
  tpm-buf: Remove tpm_buf_append_handle
  tpm: Orchestrate TPM commands in tpm_get_random()
  tpm: Send only one at most TPM2_GetRandom command
  tpm: In tpm_get_random() replace 'retries' with a zero check

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
 security/keys/trusted-keys/trusted_tpm2.c | 341 ++++++++++----------
 13 files changed, 802 insertions(+), 936 deletions(-)

-- 
2.39.5


