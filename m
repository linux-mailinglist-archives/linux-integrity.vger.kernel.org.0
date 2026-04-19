Return-Path: <linux-integrity+bounces-9234-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBKsGODM5GmYZwEAu9opvQ
	(envelope-from <linux-integrity+bounces-9234-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Apr 2026 14:38:56 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F24423F60
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Apr 2026 14:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1372C300CE40
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Apr 2026 12:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C66D261B9B;
	Sun, 19 Apr 2026 12:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQMVuc4q"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0646118BC3D;
	Sun, 19 Apr 2026 12:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776602332; cv=none; b=eyUuEQ9LVT/xaLj0VtVbjv+0IsGwPkaplynFpxUSbGzcaVTA8yuvf2DZLkA6jvezoOi9REsg+2s699qnH+oG2DlBUUWwnCuYlOoHWrRvHxCWX/edjxzVACVO4Yy8DuokBu8iedYQlSyjRekyVUmywab9n/DYCnkqVSWU9V+74DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776602332; c=relaxed/simple;
	bh=kbbbmBOzimS7USWiqfOjMMfXl0aAStRYXstWAfJc1z4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SnYRsm0z5Y5TmWM8QAE0H+OldQbHsSSVF44tODVWFxbOc3K+SNZ5sv5ohSmDK9z1Y/Z6VnUlFnmX847BzQ88Q8H5rmFXB5kscQfG3cnegQwRI0Z5sVaQ8xlMZ5x5DTanQHdIMmTsGEQvGC/k69ujBt2oJabYjcCH/pLI1KN1a24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQMVuc4q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46767C2BCAF;
	Sun, 19 Apr 2026 12:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776602331;
	bh=kbbbmBOzimS7USWiqfOjMMfXl0aAStRYXstWAfJc1z4=;
	h=Date:From:To:Cc:Subject:From;
	b=LQMVuc4q1mHlN1B3EKSwvvAG1iP3PgheAfwzBoQ0D0J6geRE4cTdTb89Yuc5zaXl/
	 Nte6wYs2Mmq+gIpXUAiAqM8OFI5L4DCfB4AcrNu3A9+5smQqSbVqX2qPfLf2RwjY8S
	 cSbvdlFIguo3gObrtqsaUX8RXg5TIyuqXyIK+ADZMLeiNZt7q8x/RmO0N4Ii6vFuDA
	 D7zrCwH8u+TygUEXL48J74ah8bUQl7aT18q0dRPTjdc4C6stt2OiceuvgoseytZ8G/
	 54UZOH9wNbFbjsT4+RSwTTDWd6bPDqzMdZZeUxgsySNqJBX9KhJQszYDGO/fbqi9Ps
	 l0RhIcJiJb/LQ==
Date: Sun, 19 Apr 2026 15:38:48 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-7.1-rc1
Message-ID: <aeTM2CO_mlNYViFU@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmx.de,ziepe.ca,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-9234-lists,linux-integrity=lfdr.de];
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
X-Rspamd-Queue-Id: B5F24423F60
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The following changes since commit faeab166167f5787719eb8683661fd41a3bb1514:

  Merge tag 'pinctrl-v7.1-1' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl (2026-04-18 16:59:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-next-7.1-rc1

for you to fetch changes up to 038c2344756c76b2363e820519ca09fb0fc17a53:

  tpm: tpm_tis: stop transmit if retries are exhausted (2026-04-19 15:35:23 +0300)

----------------------------------------------------------------
Hi

This pull request contains accumulated bug fixes for TPM driver.

BR, Jarkko

----------------------------------------------------------------
Arnd Bergmann (1):
      tpm: avoid -Wunused-but-set-variable

Ethan Luna (1):
      tpm: i2c: atmel: fix block comment formatting

Gunnar Kudrjavets (3):
      tpm: Fix auth session leak in tpm2_get_random() error path
      tpm2-sessions: Fix missing tpm_buf_destroy() in tpm2_read_public()
      tpm: Use kfree_sensitive() to free auth session in tpm_dev_release()

Jacqueline Wong (2):
      tpm: tpm_tis: add error logging for data transfer
      tpm: tpm_tis: stop transmit if retries are exhausted

Krzysztof Kozlowski (1):
      tpm: Make tcpci_pm_ops variable static const

Rafael J. Wysocki (1):
      tpm_crb: Convert ACPI driver to a platform one

 drivers/char/tpm/tpm-chip.c      |  2 +-
 drivers/char/tpm/tpm2-cmd.c      |  8 +++-----
 drivers/char/tpm/tpm2-sessions.c |  5 ++++-
 drivers/char/tpm/tpm_crb.c       | 35 ++++++++++++++++-------------------
 drivers/char/tpm/tpm_i2c_atmel.c | 34 +++++++++++++++++++++++-----------
 drivers/char/tpm/tpm_tis_core.c  | 11 ++++++++++-
 include/linux/tpm_eventlog.h     |  9 +++++++--
 7 files changed, 64 insertions(+), 40 deletions(-)

