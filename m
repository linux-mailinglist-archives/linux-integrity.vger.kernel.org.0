Return-Path: <linux-integrity+bounces-7370-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 312FEBB990C
	for <lists+linux-integrity@lfdr.de>; Sun, 05 Oct 2025 17:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02C9A18964ED
	for <lists+linux-integrity@lfdr.de>; Sun,  5 Oct 2025 15:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F736238178;
	Sun,  5 Oct 2025 15:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="alV9jpU5"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EF51F5E6;
	Sun,  5 Oct 2025 15:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759679260; cv=none; b=G/DP8xO+lV21FMWzyNzpa7ajiOgT6jOKiVxsGnqVP/EUcJDkeAA0WKPP8xmYQV4L0vb1tm6PWUgYMdr3n1b3nLqogN+q6BKeQQ9vw8CtAba5NYnm/BcbTNMHShfyUO/2O4yqAcFvrl0oCQDdtM+cQqWQNrN101NmplDYwvlrIG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759679260; c=relaxed/simple;
	bh=qQZnVE+81AP+dQRI5pw0pwda0bl73GCcme8reHoSrN8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FNVy0kN256mwcljWFJhL01amhPqaqBT8dKsVaw+Ux+wHGWnl5ZTT8T4VWPqEhXhU20Xsu+a22WiVHarL0dWyj+Ter9v2crTvt3OxDL203tinl76Zh1nHqfYrYrajAsp1+DOltdgTYAjB4vU/KuH5sm/iE/QERCYo0wWe4TMCszs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=alV9jpU5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF19C4CEF4;
	Sun,  5 Oct 2025 15:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759679258;
	bh=qQZnVE+81AP+dQRI5pw0pwda0bl73GCcme8reHoSrN8=;
	h=Date:From:To:Cc:Subject:From;
	b=alV9jpU5236GQcNL3B5TAeX/OuXXAt0EhNGal1je3eiRpTHLq1Fg5J3/b47yG8yta
	 6OhhyD56Lu9+ngIjdzCbPikf4GxQ6WUH69zbOok/aJr7igmOpftV1jqYc0SOXLa3nQ
	 uVWwkGgX43u6zundGtCMmQyvvQVZjXnfqrrPtAabsRNwii+hhJSqdhWqSU8XFnn9cY
	 b+16dPPDzPw1Glj89G2EjBOyuPqkXJuaeyj5HI1I5+eQ+6weQy5D0uuyKhC9PqHKV4
	 gr6wHeRE3ETEwqciRRkN5O5wpwn/4jivl7mMraL8AR9H1+yjomfob3p3HscYOwOi+0
	 z56sdXQiYL/rQ==
Date: Sun, 5 Oct 2025 18:47:34 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-v6.18
Message-ID: <aOKTFv1vh1cvvcLk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 6093a688a07da07808f0122f9aa2a3eed250d853:

  Merge tag 'char-misc-6.18-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc (2025-10-04 16:26:32 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-next-v6.18

for you to fetch changes up to 642688ae78cf7c6ede28db7884b09c0d242496cb:

  tpm: Require O_EXCL for exclusive /dev/tpm access (2025-10-05 18:36:48 +0300)

----------------------------------------------------------------
Hi,

and apologies for this late pull request. This pull request disables
TCG_TPM2_HMAC from the default configuration as it does not perform well
enough [1].

During the next release cycle I'll prepare gradual improvements to the
aforementioned feature. I delayed my PR because I wanted to consider
whether to include some of them already for 6.18. The end resolution
is that it is better to fully address the feature during the release
cycle and postpone improvements to 6.19.

BR, Jarkko

[1] https://lore.kernel.org/linux-integrity/20250825203223.629515-1-jarkko@kernel.org/

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

Jonathan McDowell (4):
      tpm: Ensure exclusive userspace access when using /dev/tpm<n>
      tpm: Remove tpm_find_get_ops
      tpm: Allow for exclusive TPM access when using /dev/tpm<n>
      tpm: Require O_EXCL for exclusive /dev/tpm access

 drivers/char/tpm/Kconfig          |   3 +-
 drivers/char/tpm/tpm-chip.c       |  90 +++++++++++++--------------
 drivers/char/tpm/tpm-dev-common.c |   8 +--
 drivers/char/tpm/tpm-dev.c        |  27 ++++++--
 drivers/char/tpm/tpm-dev.h        |   1 +
 drivers/char/tpm/tpm-interface.c  |  22 +++++--
 drivers/char/tpm/tpm.h            |   5 +-
 drivers/char/tpm/tpm2-cmd.c       | 127 ++++++++++----------------------------
 drivers/char/tpm/tpm2-sessions.c  | 104 +++++++++----------------------
 drivers/char/tpm/tpm2-space.c     |   5 +-
 drivers/char/tpm/tpm_ppi.c        |  89 +++++++++++++++++++-------
 drivers/char/tpm/tpm_tis_core.c   |   7 +--
 drivers/char/tpm/tpmrm-dev.c      |  20 +++++-
 include/linux/tpm.h               |   8 ++-
 14 files changed, 249 insertions(+), 267 deletions(-)

