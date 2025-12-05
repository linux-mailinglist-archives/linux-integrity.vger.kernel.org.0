Return-Path: <linux-integrity+bounces-7818-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CE8CA62F4
	for <lists+linux-integrity@lfdr.de>; Fri, 05 Dec 2025 06:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DF4513010940
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Dec 2025 05:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BBA27D77D;
	Fri,  5 Dec 2025 05:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uvAoTI4q"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EF321507F;
	Fri,  5 Dec 2025 05:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764913893; cv=none; b=KQrIYTK0xJ7lZmli6PHuhItCcGC2YIFf1KZB5eH64Y+auz8ZFPb+meh95+nEtfMUFxRT4nP6MthRzp2KqYEW+aSn7Qm3NKsbzZegzvsiuGZl9Uyv5G+djNKi3yXH4wLYFS9JtRTv+jYeHoYv6qdfs7acIvTBlUO7kvt5XFx3iuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764913893; c=relaxed/simple;
	bh=Uk1c+5TG5UsFfwvFpJ15H51J8/yeC+2Spz316930/QY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iRkboJ/7WcbvKwqH2nMCRRex1m+p5wMooQ1oF5BmOe7GRqYUdcT8gok2qMbicaV9XiDKNyUe9nl2OwjOeZE1Clo3Ik5ToMc3KpIIK8QDmNcw7Oom9P48Of4FXftGwL7rk2uZafZ1Swvi9pygJkh6ZXf0yoj5AgLAOapkvpt2uIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uvAoTI4q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58CCC4CEF1;
	Fri,  5 Dec 2025 05:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764913892;
	bh=Uk1c+5TG5UsFfwvFpJ15H51J8/yeC+2Spz316930/QY=;
	h=Date:From:To:Cc:Subject:From;
	b=uvAoTI4qTX46IVmEqsKMDLby+FL00fkAIFcLJQ+vdP25zNBJaf0SUMtn2gVu4Tuai
	 l43HjwSVA+chdMhx4DsXNe5xr0n4sAKtoRD8DhJzN6SlkoCB2UaebkK8XEgEu5jfct
	 7wNKtJTnCap4noSEs6TEocm50UZeDhYz3NJJCbQofeGb0b5otqHvTtiQ1JVXZzmhsW
	 Sd4loPL19Vh3RcbcVj/HjuyJ/rt38TbkCbpe+l2oB/pVtrn/uVCJxzYSbeIVchaa0l
	 HLILDd0KV1aOCUaPYlDdJLPY2AIp1+ugsVCAvSbXtiA8WPM4NepAMFnak7Eru6ObXq
	 qJg60HDLP9Tgw==
Date: Fri, 5 Dec 2025 07:51:27 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] TPM DEVICE DRIVER: tpmdd-sessions-next-6.19-rc1
Message-ID: <aTJy3xx3DEFS5Gr-@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 2061f18ad76ecaddf8ed17df81b8611ea88dbddd:

  Merge tag 'caps-pr-20251204' of git://git.kernel.org/pub/scm/linux/kernel/git/sergeh/linux (2025-12-04 20:10:28 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-sessions-next-6.19-rc1

for you to fetch changes up to b7960b90486139022d2d39caad90db252c469bab:

  tpm2-sessions: Open code tpm_buf_append_hmac_session() (2025-12-05 06:42:51 +0200)

----------------------------------------------------------------
Hi,

This second pull request for 6.19 is targeted for tpm2-sessions updates.

There's two bug fixes and two more cosmetic tweaks for HMAC protected
sessions. They provide a baseine for further improvements to be
implemented during the the course of the release cycle.

BR, Jarkko

----------------------------------------------------------------
Jarkko Sakkinen (4):
      tpm2-sessions: Fix out of range indexing in name_size
      tpm2-sessions: Fix tpm2_read_public range checks
      tpm2-sessions: Remove 'attributes' parameter from tpm_buf_append_auth
      tpm2-sessions: Open code tpm_buf_append_hmac_session()

 drivers/char/tpm/tpm2-cmd.c               |  42 +++++--
 drivers/char/tpm/tpm2-sessions.c          | 199 +++++++++++++++++++-----------
 include/linux/tpm.h                       |  38 ++----
 security/keys/trusted-keys/trusted_tpm2.c |  41 ++++--
 4 files changed, 204 insertions(+), 116 deletions(-)

