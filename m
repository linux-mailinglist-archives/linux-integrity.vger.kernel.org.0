Return-Path: <linux-integrity+bounces-7787-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 90607CA1A68
	for <lists+linux-integrity@lfdr.de>; Wed, 03 Dec 2025 22:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F0EA30076A7
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Dec 2025 21:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64ABC220F2A;
	Wed,  3 Dec 2025 21:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0GY4Yng"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CC5158535;
	Wed,  3 Dec 2025 21:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764796709; cv=none; b=ulCggqwQXukZS+T1uFC/IFS0qbi/45yLGvh1s/PX874Zr/R1RSxSmZIiy6SfUBIxS9riDjlsXpVV6TT3Vyo5JlhawsDRhv3upSTm/ODXqeAE/xN9y9a4VmLtKwtPPXaOcvp2q2sIeOk8XUyrKt6BY3S8g1esXRhgweFaZWYoc3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764796709; c=relaxed/simple;
	bh=FvZ1WcnbLbrO5w4sL1hdHRILuURg/6bIKgQW02rpFfI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rTwn9x2IuaR8YY7A3K3cOev2rnzFv4f13pUqJ4lrrNoUR+nPf3d0E5QF02CC+pd6nKQbyHuIcLF2vMg6boV/AEzjbw4YgzmztmKCvHHSdhxKVkTlJG4IYQCgNho3MFCA5xGJ8YIlwLG2ID4ZJ1wSpyekMLAQg6NQIGiK1hso9BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0GY4Yng; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36C29C4CEF5;
	Wed,  3 Dec 2025 21:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764796708;
	bh=FvZ1WcnbLbrO5w4sL1hdHRILuURg/6bIKgQW02rpFfI=;
	h=Date:From:To:Cc:Subject:From;
	b=Y0GY4YngImGg1nKs0bBsmmT+o65eotakbjWJa/NUVFutOx7drL+WGW4EctXBvzb6U
	 bzzAGWi7XSAl4U7pIp9yZdJRhwi9rbdlRVWf5cL3vOmZ4ag6jdcvHl9OjgbcfpSbvC
	 QdSAq1TBcCTPfKKsgFGrRcsoouIOSXtvGJ/OP+7TSVDI1Oi0TdFTgJEV3ckjZwXYI7
	 RaMTo3AO45/OitEbhU7qWE0lU6XGRtRpOfvkNrF2ba2lJIaoNG8CEz0ucAzAVax8Ud
	 Lx+Tv1m8oYThnL4r3gLscYI4Kl0yMs5lwff6LS9C86s48gMGR3W8M6U1dwBf7hSu5X
	 3Hpf+2holmPpQ==
Date: Wed, 3 Dec 2025 23:18:24 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-6.19-rc1-v4
Message-ID: <aTCpIL6H1eBlnnY_@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit a619fe35ab41fded440d3762d4fbad84ff86a4d4:

  Merge tag 'v6.19-p1' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6 (2025-12-03 11:28:38 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-next-6.19-rc1-v4

for you to fetch changes up to 09b71a58ee355ae09f302bd0875a29ffbcbbe3ac:

  KEYS: trusted: Use tpm_ret_to_err() in trusted_tpm2 (2025-12-03 22:55:28 +0200)

----------------------------------------------------------------
Hi,

This pull request for TPM driver contains changes to unify TPM return
code translation between trusted_tpm2 and TPM driver itself. Other than
that the changes are either bug fixes or minor imrovements.

Change log that should explain the previous iterations:

1. "Documentation: tpm-security.rst: change title to section"
   https://lore.kernel.org/all/86514a6ab364e01f163470a91cacef120e1b8b47.camel@HansenPartnership.com/
2. "drivers/char/tpm: use min() instead of min_t()"
   https://lore.kernel.org/all/20251201161228.3c09d88a@pumpkin/
3. Removed spurious kfree(): https://lore.kernel.org/linux-integrity/aS+K5nO2MP7N+kxQ@ly-workstation/

BR, Jarkko

----------------------------------------------------------------
Chu Guangqing (1):
      tpm_crb: Fix a spelling mistake

Jarkko Sakkinen (3):
      tpm: Cap the number of PCR banks
      tpm: Use -EPERM as fallback error code in tpm_ret_to_err
      KEYS: trusted: Use tpm_ret_to_err() in trusted_tpm2

Jonathan McDowell (1):
      tpm: Remove tpm_find_get_ops

Marco Crivellari (1):
      tpm: add WQ_PERCPU to alloc_workqueue users

Maurice Hieronymus (1):
      selftests: tpm2: Fix ill defined assertions

Stuart Yoder (1):
      tpm_crb: add missing loc parameter to kerneldoc

 drivers/char/tpm/tpm-chip.c               | 37 -------------------------------
 drivers/char/tpm/tpm-dev-common.c         |  3 ++-
 drivers/char/tpm/tpm-interface.c          | 20 +++++++++++++----
 drivers/char/tpm/tpm.h                    |  1 -
 drivers/char/tpm/tpm1-cmd.c               |  5 -----
 drivers/char/tpm/tpm2-cmd.c               |  8 +++----
 drivers/char/tpm/tpm_crb.c                |  4 +++-
 drivers/char/tpm/tpm_tis_core.c           |  3 +--
 include/linux/tpm.h                       | 12 ++++++----
 security/keys/trusted-keys/trusted_tpm2.c | 26 ++++++----------------
 tools/testing/selftests/tpm2/tpm2.py      |  4 ++--
 11 files changed, 42 insertions(+), 81 deletions(-)

