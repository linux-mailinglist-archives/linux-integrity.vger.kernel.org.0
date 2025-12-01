Return-Path: <linux-integrity+bounces-7760-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 995A4C999AB
	for <lists+linux-integrity@lfdr.de>; Tue, 02 Dec 2025 00:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E6573A209F
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Dec 2025 23:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F1628CF66;
	Mon,  1 Dec 2025 23:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7IJbTo9"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F062877E8;
	Mon,  1 Dec 2025 23:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764632290; cv=none; b=rvrZEcnXwZMInCbUArSKVUHhDCTRs1DnK4eDUfbAQyaDqGseaklqfHE4W/uALsRn70TJhMAH9o7SOSA22VEv+5x4XW9Mh9U2bXu4FYw/QlZAbiEv21GIPpm0NNF3s6/eaSVMJQyQEptMpT7dze16p/0SyfZ6ayMZdkUo7QX1HtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764632290; c=relaxed/simple;
	bh=iKZawfC+dUWA6ZbgwWwFnw7uyOuaJlVoAo9HHNNq5pg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Mfk2ZlgfO4PPiZiRzl4HXAYtejAf1HoUyR9S56z+TTpmovxwkFlpHTeiaACam2Gjy5E2CSUppZl58N6JHMTqdwfzZKVkePf3eIHnCL16MpgRuD1rjrO0Q/4ijhGsV5GvrRLo+ZLVptIh2t9BjpGUSNjOWQpvUsAGoxcnGGlnTQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7IJbTo9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19186C4CEF1;
	Mon,  1 Dec 2025 23:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764632289;
	bh=iKZawfC+dUWA6ZbgwWwFnw7uyOuaJlVoAo9HHNNq5pg=;
	h=Date:From:To:Cc:Subject:From;
	b=N7IJbTo9hUdk5GEIIYTSo0bcUypj2+kqiMkqNe+1li2pfyw/ECKLS0b5jTHGw/BV2
	 TG6Xup0V5SQVLGk8eMV2XIYPJVHAInbPfp5KwHYGO1BOqJSSdXRu47r4L28cicUYsb
	 b8uNJOHYS3QloEOy1SHWcLngAqybhhbDanzubhM/HiApU0zBsnW7qaIrRmKT3EFzDM
	 8DEB+akQ3vjj6L6c5AN8M3OiraoT1UTBOe61bDgVYiZCpb29cWNtcTq4cXXUPGCAKZ
	 UhaX8ZdJECyZZzjIBVbucxpAOGZHZL/mJ6rI1REQUMeOPgGcO+ONReNaB1cgNfm4UK
	 WtXVPc3+9ueWA==
Date: Tue, 2 Dec 2025 01:38:05 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-6.19-rc1-v3
Message-ID: <aS4m3QWXzE4nSG1O@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 4664fb427c8fd0080f40109f5e2b2090a6fb0c84:

  Merge tag 'vfs-6.19-rc1.minix' of git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs (2025-12-01 15:22:40 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-next-6.19-rc1-v3

for you to fetch changes up to b8b93e380604ce33e41e78522406df011f07aefe:

  KEYS: trusted: Use tpm_ret_to_err() in trusted_tpm2 (2025-12-02 01:30:23 +0200)

----------------------------------------------------------------
Hi,

This pull request for TPM driver contains changes to unify TPM return
code translation between trusted_tpm2 and TPM driver itself. Other than
that the changes are either bug fixes or minor imrovements.

Removed commits from earlier revisions and associated lore links:

1. "drivers/char/tpm: use min() instead of min_t()"
   https://lore.kernel.org/all/20251201161228.3c09d88a@pumpkin/
2. "Documentation: tpm-security.rst: change title to section"
   https://lore.kernel.org/all/86514a6ab364e01f163470a91cacef120e1b8b47.camel@HansenPartnership.com/

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

 drivers/char/tpm/tpm-chip.c               | 36 -------------------------------
 drivers/char/tpm/tpm-dev-common.c         |  3 ++-
 drivers/char/tpm/tpm-interface.c          | 20 +++++++++++++----
 drivers/char/tpm/tpm.h                    |  1 -
 drivers/char/tpm/tpm1-cmd.c               |  5 -----
 drivers/char/tpm/tpm2-cmd.c               |  8 +++----
 drivers/char/tpm/tpm_crb.c                |  4 +++-
 drivers/char/tpm/tpm_tis_core.c           |  3 +--
 include/linux/tpm.h                       | 12 +++++++----
 security/keys/trusted-keys/trusted_tpm2.c | 26 ++++++----------------
 tools/testing/selftests/tpm2/tpm2.py      |  4 ++--
 11 files changed, 42 insertions(+), 80 deletions(-)

