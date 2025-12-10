Return-Path: <linux-integrity+bounces-7886-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C44CB32B4
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Dec 2025 15:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5C3CE3014C64
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Dec 2025 14:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BA51E5718;
	Wed, 10 Dec 2025 14:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WzPXrW2L"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE7418787A;
	Wed, 10 Dec 2025 14:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765377586; cv=none; b=oHvlq0cHzBp/h2qjqvpezA5NWU+3/RE4cGkyZ18zsja+KzId9e2n+n1nrJhPaDTkUt+/ly3blikBKpZHj05+JUloPBKB/f1Cjbi2l8roqQ5JBGpjuNcwsE1EM/2Q2ueegCwT1it+PmCX33NCyCXLfyVMJNp45lsV+qLrUB7xsk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765377586; c=relaxed/simple;
	bh=aTB0qCzbxVPWBRYL2iE5Qm1T2NiU3RXr7P7Ued/MXdM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DrIR3bdY6UajmM9frjY0WBCleCEH7hur7eSJj9+A8rz8mLA8oH9NEDt5bBrI1rxHHtOpTb/0kmdw5cwScByyg1MaOAGOjBtDFF1intVf83MRMyUmEyIOHhsp8m76mvHF2T+SnOgwSmNhGlTSTlFfCLz7R+hSow12YLGrwfHfggo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WzPXrW2L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0127C113D0;
	Wed, 10 Dec 2025 14:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765377586;
	bh=aTB0qCzbxVPWBRYL2iE5Qm1T2NiU3RXr7P7Ued/MXdM=;
	h=From:To:Cc:Subject:Date:From;
	b=WzPXrW2L7TJIHcpOzU2o6tNRit8rR4X0/jfDkSbR3XTdfv4r434cxEVLbciIg1hyO
	 Bt++EFNYwFlwYGO/8oOYn3SlKL8/fQ2GSJLYGXhXYacnXC2x0FKyTT5TY8wZVeUM3/
	 tNMUhqPnxRPZWlmgnXLlz0KLuHYD1+rEiXgKRDG1OuLu2xDf+arCVayeiUGY6HqCrN
	 YQmPu/VeYkB+YpHSahaa6uwQADSbvMtkFqQtQJ6aroAHaI0tHoY8jcnFsKu/ajymUF
	 N2JqCffxfyQiZw0viz1+h3bl2JtzfualOmUnuSlmIc49HbRYcFr6NW7nfUwwMfvC+4
	 WT81WryKXi5mA==
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
Subject: [PATCH v3 0/7] Streamline TPM2 HMAC sessions
Date: Wed, 10 Dec 2025 16:39:32 +0200
Message-ID: <20251210143940.264191-1-jarkko@kernel.org>
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

Jarkko Sakkinen (7):
  KEYS: trusted: Remove dead branch from tpm2_unseal_cmd
  tpm2-sessions: Define TPM2_NAME_MAX_SIZE
  KEYS: trusted: Re-orchestrate tpm2_read_public() calls
  tpm2-sessions: Remove AUTH_MAX_NAMES
  tpm-buf: Remove tpm_buf_append_handle
  tpm: Orchestrate TPM commands in tpm_get_random()
  tpm: Send only one TPM command per hwrng request

 drivers/char/tpm/tpm-buf.c                |  25 ----
 drivers/char/tpm/tpm-chip.c               |   2 +-
 drivers/char/tpm/tpm-interface.c          | 174 ++++++++++++++++++++--
 drivers/char/tpm/tpm-sysfs.c              |   2 +-
 drivers/char/tpm/tpm.h                    |   2 -
 drivers/char/tpm/tpm1-cmd.c               |  62 --------
 drivers/char/tpm/tpm2-cmd.c               | 102 +------------
 drivers/char/tpm/tpm2-sessions.c          | 130 +++++-----------
 include/linux/tpm.h                       |  51 +++++--
 security/keys/trusted-keys/trusted_tpm1.c |   8 +-
 security/keys/trusted-keys/trusted_tpm2.c | 134 ++++++++++-------
 11 files changed, 322 insertions(+), 370 deletions(-)

-- 
2.52.0


