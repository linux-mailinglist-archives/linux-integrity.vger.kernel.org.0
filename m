Return-Path: <linux-integrity+bounces-7867-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBE1CAF8C8
	for <lists+linux-integrity@lfdr.de>; Tue, 09 Dec 2025 11:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0B1F23000B50
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Dec 2025 10:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34EC328263;
	Tue,  9 Dec 2025 10:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5rdXR+4"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DE7328251;
	Tue,  9 Dec 2025 10:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765274746; cv=none; b=TaUHICZh0VCusY9knATCUulecw1/7dkxvpCS8NR424nrOt/0gZfFmcq0DMha73PbcY75o89BYih1saNU1LxLJwvI/1xOFSQTFR2U8aGgjryzpsmDqr7DXpgQhzPquPLMLkQA7D2+Pup5yUn9kzL3g+3bjp7l6/SCvCbyomzxgkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765274746; c=relaxed/simple;
	bh=oE+dWh7raBljNqzFEEiZq5W8NQaCOIJje7uZwrEM5pk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YEY5z8P5M6zqa7mWsDYBiLmkMNBQDHcTrQ5JhyXzj0/KSWUWDAaRibzwBZiiw7VU/bPMNtwsNoR2wsNqGOkvuCBn1l7HtNuZVl7JdRXcdZY/FvdZgz58NBsCauEDQdZsi4Oq3Jnwp3+ZWwcq0Hyf1EkS3wZafY/11tJjFZtQJaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5rdXR+4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC8FC4CEF5;
	Tue,  9 Dec 2025 10:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765274746;
	bh=oE+dWh7raBljNqzFEEiZq5W8NQaCOIJje7uZwrEM5pk=;
	h=From:To:Cc:Subject:Date:From;
	b=L5rdXR+4K5Ngu0TyGcSNPsLBghWR/0TY/PljxUAZZ9RWeye3LJuVXtOSbR2N1NR8b
	 FvkBGZZoH5oQObJFRL8HSfzjVfimXI197xmRyIX5pf4n3TzTn7YpbMO8ZW3HF/+5cq
	 vkbRuuHamipl61VHKPR+m6OutXykZOPWf/66Uppv0CfJyUDHqu3rv5NWWcUFbHkaxH
	 aPvVzIPbkbCma7oXXPSy42VMDXYBDPJ2HvDMCINGAvXa7rcDRqyvhtaL9ZPe1pfzPI
	 OcHkot7CrM3dWF71KmFiApJWrS1g7DsG6QO6wCLw2cqAV7ym2/s8pM5I3+/mLmVl7+
	 /GzLLT2EL6cbg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 0/5] Streamline TPM2 HMAC sessions
Date: Tue,  9 Dec 2025 12:05:23 +0200
Message-ID: <20251209100529.1700779-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.52.0
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

Jarkko Sakkinen (5):
  KEYS: trusted: Remove dead branch from tpm2_unseal_cmd
  tpm2-sessions: Define TPM2_NAME_MAX_SIZE
  KEYS: trusted: Re-orchestrate tpm2_read_public() calls
  tpm2-sessions: Remove AUTH_MAX_NAMES
  tpm-buf: Remove tpm_buf_append_handle

 drivers/char/tpm/tpm-buf.c                |  25 ----
 drivers/char/tpm/tpm-sysfs.c              |   2 +-
 drivers/char/tpm/tpm2-cmd.c               |   9 +-
 drivers/char/tpm/tpm2-sessions.c          | 130 ++++++---------------
 include/linux/tpm.h                       |  49 +++++---
 security/keys/trusted-keys/trusted_tpm2.c | 134 +++++++++++++---------
 6 files changed, 155 insertions(+), 194 deletions(-)

-- 
2.52.0


