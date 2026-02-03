Return-Path: <linux-integrity+bounces-8410-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMdqOIdFgWnNFAMAu9opvQ
	(envelope-from <linux-integrity+bounces-8410-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 03 Feb 2026 01:47:03 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A45D3200
	for <lists+linux-integrity@lfdr.de>; Tue, 03 Feb 2026 01:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1F32300BDA1
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Feb 2026 00:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADCD1F4174;
	Tue,  3 Feb 2026 00:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SvxHWthq"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B680618D658;
	Tue,  3 Feb 2026 00:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770079618; cv=none; b=iB5gl3eklbwUCii/eNxhEp5RtU48QgbtFfHCFfFHchT47awWr0lKMVSnL3wZAj1t8tx1wS6sSJ6JKbVHoZjqiqhk2Kfb451cxZ/TRfWK+K8hbnQMCkyfprlBFYecsYjLU1SLu6N/bh4nTdD8qKzitvHlEaWrWflS5FYpjizOcRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770079618; c=relaxed/simple;
	bh=wMEb+K7wVxpTfzG0K8oltYhyF9V+GZypbi3NiBA/RHg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=s+cimhSm65RWyDisAt7m5OUPt9+dNb2KiNZe8IlcJhIC2cfMMI/WmoVGJSWPOwZuJg15fV8MMiYgCRuuOdzah9+8ENf+vkxh/XB3fdD/Xn4M9ZurzR0I65y6YFVO9mHzHXOzQNU0yVpku4qlMUtNtATEt9PeExhYqbCj45BpsUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SvxHWthq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA441C116C6;
	Tue,  3 Feb 2026 00:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770079618;
	bh=wMEb+K7wVxpTfzG0K8oltYhyF9V+GZypbi3NiBA/RHg=;
	h=Date:From:To:Cc:Subject:From;
	b=SvxHWthqVurOZ64wkVlP/HInyn6aWgT0MnznocyiRcnTpwSZO539+56RfVRCD6rK0
	 pA13UusCXHXbpI/pQkWNlshA26sjavpvbF4HCyw8q9PXvkZGTqIM2zWr4087xz9usN
	 UEXLNWcnlIgE7VM5CtlBn41Tl5+A4YwljMu/r7fiQ96sNdzPiPC3IHul7SW0mTABnU
	 ozE2R88Zqsxc5ECabW8UCXZ4vwrqa8Sz16MnI3X0tg4QH7gGP9+fsFbwmB4qURDc4T
	 y+JDkrZFo/elADLFvrCvBNZXouvB9ovD2Hw11WtexpDksfQVqrgAZzxfHPI2kgV0Yf
	 zgq8hGqJD3Jdw==
Date: Tue, 3 Feb 2026 02:46:53 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-7.0-rc1
Message-ID: <aYFFfTwGGFFl6hn7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmx.de,ziepe.ca,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8410-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 85A45D3200
X-Rspamd-Action: no action

The following changes since commit dee65f79364c18033cabdf0728c7e7025405cf40:

  Merge tag 'lsm-pr-20260202' of git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm (2026-02-02 09:48:23 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-next-7.0-rc1

for you to fetch changes up to 3e91b44c93ad2871f89fc2a98c5e4fe6ca5db3d9:

  tpm: st33zp24: Fix missing cleanup on get_burstcount() error (2026-02-03 02:36:32 +0200)

----------------------------------------------------------------
Hi,

Here are TPM driver updates for Linux v7.0.

BR, Jarkko

----------------------------------------------------------------
Alper Ak (2):
      tpm: tpm_i2c_infineon: Fix locality leak on get_burstcount() failure
      tpm: st33zp24: Fix missing cleanup on get_burstcount() error

 drivers/char/tpm/st33zp24/st33zp24.c | 6 ++++--
 drivers/char/tpm/tpm_i2c_infineon.c  | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

