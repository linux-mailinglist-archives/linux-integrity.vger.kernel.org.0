Return-Path: <linux-integrity+bounces-7894-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E62CB397C
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Dec 2025 18:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6540330255B1
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Dec 2025 17:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83078326950;
	Wed, 10 Dec 2025 17:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkWqXsHN"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE77324B3B;
	Wed, 10 Dec 2025 17:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765387235; cv=none; b=TAJ+P+2kCv8zH0WMuBEWL7Ihn51b+cd3tgzMbBZgzmD0L/uyzVXQ71ZI7j2Dc3CI9gsFXYjnW4C5L/Auv2qeAIu9wDfwdDzMwRGnEPVq1SwVU/eV8rzQcH/6AhxwybVZXBcsFQXS8LjB1/RWohFY8uByeAPLch3Bu0S5Fih5BsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765387235; c=relaxed/simple;
	bh=Qta2pvazNSRhM3J0IVWqC87nI/Docta+z1wOPTm5o/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M9kV1YoWI9BQ8zuDN/mI92W0Z3lrXFTHz0mXbfP1UM357x5JLTA7K11nAR2HIZrpSVa39VU947OodsMLTT+g/j2ya3qnbIoMBUAsLsSvumL1OCCQYzjIjYQMB8Oza8VrNnLoEMxcAgQtrBT214vbe36VI7DYozXprW0qnoh41DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PkWqXsHN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43119C4CEF1;
	Wed, 10 Dec 2025 17:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765387234;
	bh=Qta2pvazNSRhM3J0IVWqC87nI/Docta+z1wOPTm5o/Q=;
	h=From:To:Cc:Subject:Date:From;
	b=PkWqXsHNV5TSxPTGVmk09F2zHPJ2Sypi1DZ0X3qCS0L6wiZVCT2+ZpymsiZtkXlOJ
	 dEsfrzp/tarY5EHBQp45Ngm3pMFqN7IgTFbQCIxlIULE+O8Sw7K+mH8zGRvLO4YXnG
	 NEVF/P63EIsc58x4WgduzubW9e4RH3NJpelvngRSELyqMyglo6mvP8pYzEhyEvzGb4
	 KAi+TAiC4CdTs/pXOO2g9TGG4M2iUICD+1YfldV2XIc5J7/PCqrVOpuWDYsL6hAKws
	 b4VVOBDVGy7kKwcxt3RXT76BjC1+MetAfmNvcJrSc4KTgldaM+rrRxmi9YIr8ugyts
	 LGQXuKSzEAAXQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	keyrings@vger.kernel.org (open list:KEYS/KEYRINGS),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 0/8] Streamline TPM2 HMAC sessions
Date: Wed, 10 Dec 2025 19:20:18 +0200
Message-Id: <20251210172027.109938-1-jarkko@kernel.org>
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

Jarkko Sakkinen (8):
  KEYS: trusted: Remove dead branch from tpm2_unseal_cmd
  tpm2-sessions: Define TPM2_NAME_MAX_SIZE
  KEYS: trusted: Re-orchestrate tpm2_read_public() calls
  tpm2-sessions: Remove AUTH_MAX_NAMES
  tpm-buf: Remove tpm_buf_append_handle
  tpm: Orchestrate TPM commands in tpm_get_random()
  tpm: Send only one at most TPM2_GetRandom command
  tpm: In tpm_get_random() replace 'retries' with a zero check

 drivers/char/tpm/tpm-buf.c                |  25 ---
 drivers/char/tpm/tpm-chip.c               |   2 +-
 drivers/char/tpm/tpm-interface.c          | 177 ++++++++++++++++++++--
 drivers/char/tpm/tpm-sysfs.c              |   2 +-
 drivers/char/tpm/tpm.h                    |   2 -
 drivers/char/tpm/tpm1-cmd.c               |  62 --------
 drivers/char/tpm/tpm2-cmd.c               | 102 +------------
 drivers/char/tpm/tpm2-sessions.c          | 130 +++++-----------
 include/linux/tpm.h                       |  51 +++++--
 security/keys/trusted-keys/trusted_tpm1.c |   8 +-
 security/keys/trusted-keys/trusted_tpm2.c | 134 +++++++++-------
 11 files changed, 325 insertions(+), 370 deletions(-)

-- 
2.39.5


