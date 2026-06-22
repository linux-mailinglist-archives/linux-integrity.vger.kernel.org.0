Return-Path: <linux-integrity+bounces-9821-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id t3vfJadWOWpJqwcAu9opvQ
	(envelope-from <linux-integrity+bounces-9821-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Jun 2026 17:37:11 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 309E66B0CBA
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Jun 2026 17:37:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Cz5P5+aI;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9821-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9821-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E61530056DD
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Jun 2026 15:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9EC93911B5;
	Mon, 22 Jun 2026 15:31:24 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58E41F151C;
	Mon, 22 Jun 2026 15:31:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782142284; cv=none; b=uqdauaQ/YuhXojJBwdWL3co4PGkvuIainxocRkqi7Emah+4J0bjbvGy4borluMFA22QlqQnt0BoYFeQPt2O+YPw+5KQXzJyYbGUUvyQep81+d0wLwun77pzlpTql+rVfX+6V5VW5DLp0ajACibUvMI8idjiJLcEV2z6gr3XRppg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782142284; c=relaxed/simple;
	bh=nOSR3j5FtVV9AKW4o7HzuDHxgqC4/BPOOUeUig4T5d8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PuDIdSZu7oaK9Rn18y6irH7lTgPTsBT19WmXYFc28Upy+5bSrpUTT5b69Rswo33V5Jd8QidndaokVHbeB+TX/M+G/w/Hq3hXPukyiyUWLQw+vW2dqFC2SvKOJfBvlkovxoJhwDbHmkSED/u/9oEISk3CGZiHMviKWDTE+bUBn+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cz5P5+aI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id DA5301F000E9;
	Mon, 22 Jun 2026 15:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782142283;
	bh=Tc41Au4Xtg2NZoKNYu/BD/sn49z5aSGF+nPwhYFldMU=;
	h=Date:From:To:Cc:Subject;
	b=Cz5P5+aIml/tmeaHiL5z32Ug5Vj0Gu3yCMQ4On16srjQ+wM4TXIoO4Yv38jvmGbZF
	 c9SwmsqFRMZV9ghZ/RIGTc/B9IZWjKQAARaM6KeI0Nu8RNWUDPFJSMHdF1gmb+Sk3o
	 zzampgasZP4vVg+o6IQd3maewFuKo2cHH+kcZV04XecFeRhbBkLY8GHHC4KaxqCn/X
	 CECEbG6D9XR8Iv+eRt+9I/D6J9LL2aAiWKay58T3RPCXiaQnoHqKSBZh8PE3OnQZRp
	 MWhJwXdK4bpgHH4DO+oaiHLseCjX8+LEujDgNlJHNMox6nK8iIqNSmZVV+NLpfKRtm
	 vJ8MzbTcvXb1Q==
Date: Mon, 22 Jun 2026 18:31:19 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] TPM DEVICE DRIVER: for-next-tpm-7.2-rc1-fixed
Message-ID: <ajlVR8okpQirKw5-@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9821-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:torvalds@linux-foundation.org,m:peterhuewe@gmx.de,m:jgg@ziepe.ca,m:dhowells@redhat.com,m:keyrings@vger.kernel.org,m:linux-integrity@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmx.de,ziepe.ca,redhat.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-integrity];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 309E66B0CBA

The following changes since commit 1a3746ccbb0a97bed3c06ccde6b880013b1dddc1:

  Merge tag 'strncpy-removal-v7.2-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux (2026-06-19 14:56:45 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/for-next-tpm-7.2-rc1-fixed

for you to fetch changes up to 1a58f6115bfb34eabcc7de8a3a9745b219179781:

  tpm: fix event_size output in tpm1_binary_bios_measurements_show (2026-06-21 04:25:28 +0300)

----------------------------------------------------------------
Hi

Correctly rebased version of [1] now that for-next-tpm was mirrored
today to linux-next by Mark today. Contains only bug fixes.

[1] https://lore.kernel.org/linux-integrity/ajc9JcxcH8eGqxbX@kernel.org/T/#t

BR, Jarkko

----------------------------------------------------------------
Baoli Zhang (1):
      tpm: restore timeout for key creation commands

David Windsor (1):
      tpm: svsm: constify tpm_chip_ops

Gunnar Kudrjavets (1):
      tpm: Initialize name_size_alg for non-NULL name in tpm_buf_append_name()

Jarkko Sakkinen (1):
      tpm: tpm_tis_spi: Use wait_woken() in wait_for_tmp_stat()

Jim Broadus (2):
      tpm: tpm_tis: store entire did_vid
      tpm: tpm_tis: Add settle time for some TPMs

Michael Bommarito (1):
      tpm: tpm2-sessions: wait for async KPP completion in tpm_buf_append_salt

Rafael J. Wysocki (1):
      tpm_crb: Check ACPI_COMPANION() against NULL during probe

Thorsten Blum (1):
      tpm: fix event_size output in tpm1_binary_bios_measurements_show

Yeoreum Yun (1):
      tpm: tpm_crb_ffa: revert defered_probed when tpm_crb_ffa is built-in

 drivers/char/tpm/eventlog/tpm1.c |  4 +--
 drivers/char/tpm/tpm2-cmd.c      |  6 ++--
 drivers/char/tpm/tpm2-sessions.c | 56 +++++++++++++++++++++++++----------
 drivers/char/tpm/tpm_crb.c       |  6 +++-
 drivers/char/tpm/tpm_crb_ffa.c   | 18 ++----------
 drivers/char/tpm/tpm_svsm.c      |  2 +-
 drivers/char/tpm/tpm_tis_core.c  | 63 ++++++++++++++++++++++++++--------------
 drivers/char/tpm/tpm_tis_core.h  |  3 +-
 8 files changed, 98 insertions(+), 60 deletions(-)

