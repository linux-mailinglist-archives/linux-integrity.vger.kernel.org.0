Return-Path: <linux-integrity+bounces-7739-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A87CC9298F
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Nov 2025 17:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B47E4E2040
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Nov 2025 16:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DA626E6E4;
	Fri, 28 Nov 2025 16:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UtSH/Yhm"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E3A79CD;
	Fri, 28 Nov 2025 16:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764348012; cv=none; b=r6pe0UiPM/svU1vCeo1q938KmLUkqEgn6FdP/CtipUmpi/OLtT4LaeLI9+QTLwYduGUYGALAoU4rETOfURF2nou6TaMkKOfJCAYAMCIktNKcOCuWKEeutBQG2DZ43HXIdw1OReI7J4s6IorelBXCKMLHdIoSLaIDJ3awKKjNk0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764348012; c=relaxed/simple;
	bh=WIITyeaHfcIUEkuMfuH8tALf9UXjlh5GS/cjybxdSZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nFQn5dzLztCSv8OdXpZUPpq3KuzfErmblLvO13goHQOs/wDiKMQFJTpI+vu+BXLXVHX7WiymuxUJoUplc0m+89uXQ1iivBLYNaTxEWkMsnkkl6rP0RkVI9tYzvEY1iWvdMp2/c4AO76M1zEBM/omrRlV/0leHSaFTs+UWyQ8qac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UtSH/Yhm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F847C4CEF1;
	Fri, 28 Nov 2025 16:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764348012;
	bh=WIITyeaHfcIUEkuMfuH8tALf9UXjlh5GS/cjybxdSZ8=;
	h=Date:From:To:Cc:Subject:From;
	b=UtSH/Yhm5UmUnsUe4urR2iJnIj3vBeNcL1O0KcUYAeH3tqgwF7uMAlYeau1Ylb1r1
	 NlPBjDyJMqWEA0R/1UGvAOPeat27OqlwfmEn0QkXAcFAPw45iv7j00lIEr+6JvexvW
	 ckIvFj8baFTPUOH94807C4Kw9jWrEDehJjtez2i7cdRbx7sDoaKkVrUDBota9wLkFR
	 Q7tlO3WqtfBED57dsuKM8gOCmdTar/j/o1XDtfxizOMyG48FU3rnIh6ABtuDCGIToC
	 EfreCTG8ntouXVo+03xAl+4WVNO3bnRCh5LNBNwrmrvbuN2+cNesE4VVwFSMrfemP8
	 3MamRbFNQhrbQ==
Date: Fri, 28 Nov 2025 18:40:07 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-6.19-rc1-v2
Message-ID: <aSnQZ4pRWqJai6FW@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit e1afacb68573c3cd0a3785c6b0508876cd3423bc:

  Merge tag 'ceph-for-6.18-rc8' of https://github.com/ceph/ceph-client (2025-11-27 11:11:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-next-6.19-rc1-v2

for you to fetch changes up to 6bd23dd7108d4729a14f4dc287671bc55c462ba0:

  KEYS: trusted: Use tpm_ret_to_err() in trusted_tpm2 (2025-11-28 18:34:22 +0200)

----------------------------------------------------------------
Hi

This pull request includes couple of updates to my previous pull
request:

https://lore.kernel.org/linux-integrity/aSjP_BsakvhxSDYR@kernel.org/T/#u

Changes:

1. Add reviewed-by tag from Roberto.
2. Remove a commit as per request by James:
   https://lore.kernel.org/linux-integrity/86514a6ab364e01f163470a91cacef120e1b8b47.camel@HansenPartnership.com/

BR, Jarkko

----------------------------------------------------------------
Chu Guangqing (1):
      tpm_crb: Fix a spelling mistake

David Laight (1):
      drivers/char/tpm: use min() instead of min_t()

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
 drivers/char/tpm/tpm1-cmd.c               |  7 +-----
 drivers/char/tpm/tpm2-cmd.c               |  8 +++----
 drivers/char/tpm/tpm_crb.c                |  4 +++-
 drivers/char/tpm/tpm_tis_core.c           |  7 +++---
 include/linux/tpm.h                       | 12 +++++++----
 security/keys/trusted-keys/trusted_tpm2.c | 26 ++++++----------------
 tools/testing/selftests/tpm2/tpm2.py      |  4 ++--
 11 files changed, 45 insertions(+), 83 deletions(-)

