Return-Path: <linux-integrity+bounces-7406-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A71BCBB9F
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Oct 2025 07:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 03B6635117C
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Oct 2025 05:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6091F03D8;
	Fri, 10 Oct 2025 05:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9nEE65B"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B701547F2;
	Fri, 10 Oct 2025 05:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760074500; cv=none; b=kkrR0xRKv3G7HVqTRPUWObBCUEFA+U53lBbPsBWKQvKG12ULkt9iWLxpfBl0u3o9YexRiWJQUF3ntnH47nMzvRSeIt2Hf8xCapeyL14dUGqHEXtPBZprYhFmixaevFE6+XZ9pJ06XGutVmXqMI42PuSYAovOqY6+NGzgsJNSip8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760074500; c=relaxed/simple;
	bh=lM58MpWdmSETT+79z7f98iKjDJs4/2IzUXemQDA/MaM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YgZ8Q+VIfQeJABCJcNSeOB7kmdVE8o6J0SLPdoVtHsA0vshIcFUa1Wa/cvj9SoikFBZRedi6jexefT48c7WRRlEVs8BlgGPf0R1foCqNl/yIP6uXLOpbvQ6YSgPcP651yC+PP8nMNqJmbBIbeCxG8mjwDqJzc3ltT1hzO1HA8TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A9nEE65B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B58C4CEF1;
	Fri, 10 Oct 2025 05:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760074499;
	bh=lM58MpWdmSETT+79z7f98iKjDJs4/2IzUXemQDA/MaM=;
	h=Date:From:To:Cc:Subject:From;
	b=A9nEE65BBvsF7XgPgUXbgliTaphESNamBxLLgc1G9FQtAhYsqKtZhZsZSnZYoWNp5
	 zgKzkyxYIwi/v9dzfNpfoidlyMEXXCLzU7m6qLdmWPSjjcGL6npgcpVuy07T3cbYfB
	 UGOHKJRYvq2uNXHr7j3N1ctyWws3EYXyQfwsq0MLN7gF1VfxMimfD3B4t3PFNDpAM8
	 wKygFL2NYTXSkgPYGJk8CridfJ6JJiIqbwgL2paPBLl+iBYqb9AK5mFp7SJjMKzuB7
	 MCRhLxY/brQ2yPqAyDvHp1lUl1xQ+cJlfmYh0efRYnQ9t+nRthZab+XeA7H6qTs+01
	 M0nkGlIC5GokA==
Date: Fri, 10 Oct 2025 08:34:56 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-v6.18-2
Message-ID: <aOibAOKu_lEsSlC8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 5472d60c129f75282d94ae5ad072ee6dfb7c7246:

  Merge tag 'trace-v6.18-2' of git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace (2025-10-09 12:18:22 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-next-v6.18-2

for you to fetch changes up to a29ad21b988652dc60aa99c6d3b1e3d52dc69c30:

  tpm: Prevent local DOS via tpm/tpm0/ppi/*operations (2025-10-10 08:21:45 +0300)

----------------------------------------------------------------
Hi,

Round #2.

O_EXCL patches will be postponed to 6.19 as they need some restructuring.
E.g., there's in-between series regression breaking the user space as lack
of O_EXCL flag handling causes obviously unconditional O_EXCL.

As per Chris' feedback, commands fail because it is based on Google's a
non-standard proprietary TPM alike implementation. And the issue is not
PC Client Profile specific. "typical profiles" are fine when they become
"typical profiles".

The null key can be verified with vendor certificate tied keys, and there's
challenge-response process using them for certifying any other key by a
remote party.

Performance hit on generation aside, if really starting to cut hairs null
keys are the most secure option, and it's a non-debatable fact: they have
shortest expiration times as seed changes per power cycle.

Based on this TCG_TPM2_HMAC is disabled from defconfig exactly for the sake
of the performance issues.

BR, Jarkko

----------------------------------------------------------------
Denis Aleksandrov (1):
      tpm: Prevent local DOS via tpm/tpm0/ppi/*operations

Eric Biggers (2):
      tpm: Compare HMAC values in constant time
      tpm: Use HMAC-SHA256 library instead of open-coded HMAC

Gunnar Kudrjavets (1):
      tpm_tis: Fix incorrect arguments in tpm_tis_probe_irq_single

Jarkko Sakkinen (2):
      tpm: Disable TPM2_TCG_HMAC by default
      tpm: use a map for tpm2_calc_ordinal_duration()

 drivers/char/tpm/Kconfig         |   3 +-
 drivers/char/tpm/tpm-interface.c |   2 +-
 drivers/char/tpm/tpm.h           |   2 +-
 drivers/char/tpm/tpm2-cmd.c      | 127 ++++++++++-----------------------------
 drivers/char/tpm/tpm2-sessions.c | 104 +++++++++-----------------------
 drivers/char/tpm/tpm_ppi.c       |  89 ++++++++++++++++++++-------
 drivers/char/tpm/tpm_tis_core.c  |   4 +-
 include/linux/tpm.h              |   5 +-
 8 files changed, 137 insertions(+), 199 deletions(-)


