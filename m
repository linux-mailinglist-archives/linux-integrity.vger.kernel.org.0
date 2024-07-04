Return-Path: <linux-integrity+bounces-2996-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8201A92724D
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jul 2024 10:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38C3F1F25476
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jul 2024 08:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340ED16FF3C;
	Thu,  4 Jul 2024 08:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GtNsBPMG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010FE145FE2;
	Thu,  4 Jul 2024 08:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720083445; cv=none; b=ddbsW9eUlqGidbL33XVN/WYe3gwKtLN6NJOhTOS1eyagZZ8pVNWmeQNQFtIO3kJWq/UJzP6sDJFFPHr0I6pNmsUid90maPi+BevxT73MCwYtUer4dGq/wyaLriWOF9LjJ95RnAbmbNKR5szqGhW2B8zfVSa4RUpBSRfggeAJq9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720083445; c=relaxed/simple;
	bh=2SNsrirCRAM+Duro9c+Ph0X+ZRzsiprVuMF6Kwy+zR4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FLcmgo2hWvy7RH4p75zBoLB6RZrCZmKtrTqi+v53jK13L9GEuMriXZxhKZtI4WXBbv+Sz2ACFEmPUMoVLcreRpbCgaAtnwl/MCbi6G6TeHbEYhz7Qac5/n434NWl1/R+MKq9G1A9UdNHY58g+UeX2/iRtYBPB58lYU8b+1rVrVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GtNsBPMG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A321C3277B;
	Thu,  4 Jul 2024 08:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720083444;
	bh=2SNsrirCRAM+Duro9c+Ph0X+ZRzsiprVuMF6Kwy+zR4=;
	h=From:To:Cc:Subject:Date:From;
	b=GtNsBPMGFbKMe/pAZerR6r3Fg9dkhSa5M6O7Xy6sOrM4wQEhKWlpTlaNzIu1Rr7WS
	 /Hyit/oDRhx1bBf9fjQKHLzzEwtS8Sp0TmJ8iZHR0ywI/r0Z+G5rHd58GbaYEuHvnk
	 A80THzVx2Gl806sB3xEDLF2BPqt+TqP/Cd/lkX9rdYcrn36IjzZH1BYNTT77Pzm5xT
	 oH3dGVKBrUbleb+KAB7p2c82+IM1/yN8S1mkxQ1jE114/HVd4YFnD1LnWJKBzlZrC+
	 wy++VZhsyq5rBFEE8mYJiaKVNlJWLAKisJbGT2MK2PQclsgq0TkGxwkAhec3992fBz
	 N6GhqroE8UyTA==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] Address !chip->auth
Date: Thu,  4 Jul 2024 11:57:01 +0300
Message-ID: <20240704085708.661142-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unless tpm2_sessions_init() is called, then chip->auth ends up being a null
pointer, which is ignored by authenticated sessions code. These patches aim
to fully address the bug, and hopefully still make into 6.10-rc7.

Tested on x86-64 with:

- TCG_TPM2_HMAC disabled.
- TCG_TPM2_HMAC enabled.
- TCG_TPM2_HMAC enabled, and "/* rc = tpm2_sessions_init(chip); */".

For drivers that do not initialize with tpm2_chip_bootstrap(), the lack of
auth sessions is reported once per power cycle by:

"tpm tpm0: auth session is not active"

This is expected output for the following drivers:

* tpm_ftpm_tee.c
* tpm_i2c_nuvoton.c
* tpm_ibmvtpm.c
* tpm_tis_i2c_cr50.c
* tpm_vtpm_proxy.c

They need to later on enable auth sessions, if they eager to. This
patch set only fixes any collateral damage of not doing so.

v3
* Address:
  https://lore.kernel.org/linux-integrity/922603265d61011dbb23f18a04525ae973b83ffd.camel@HansenPartnership.com/
* Git: https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/log/?h=auth-null-3
* Did a full QA run given the changes in config flag handling.

v2:
* Rebase to commit 8a9c6c40432e ("Merge tag 'io_uring-6.10-20240703' of git://git.kernel.dk/linux").
* Couple of cosmetic fixes.

Jarkko Sakkinen (3):
  tpm: Address !chip->auth in tpm2_*_auth_session()
  tpm: Address !chip->auth in tpm_buf_append_name()
  tpm: Address !chip->auth in tpm_buf_append_hmac_session*()

 drivers/char/tpm/Makefile        |   2 +-
 drivers/char/tpm/tpm2-sessions.c | 415 ++++++++++++++++++-------------
 include/linux/tpm.h              |  74 ++----
 3 files changed, 257 insertions(+), 234 deletions(-)

-- 
2.45.2


