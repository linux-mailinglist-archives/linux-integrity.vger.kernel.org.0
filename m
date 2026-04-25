Return-Path: <linux-integrity+bounces-9339-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBp/D+DY7GksdAAAu9opvQ
	(envelope-from <linux-integrity+bounces-9339-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sat, 25 Apr 2026 17:08:16 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B88F0466AB7
	for <lists+linux-integrity@lfdr.de>; Sat, 25 Apr 2026 17:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ECABF3002B00
	for <lists+linux-integrity@lfdr.de>; Sat, 25 Apr 2026 15:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7432636BCF5;
	Sat, 25 Apr 2026 15:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SAn2u9mf"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB6F337688;
	Sat, 25 Apr 2026 15:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777129693; cv=none; b=oAnxxtK46O4+kt7SaebwzhJKu69dUhaqYiigIxiwxF7X0JvkNspW8/vjfqRbWl//1gOJa+AbYdN7IyliItDYbneo8Tzu9lBSlY1/Reer/VR5Z42xVhCN/DUCii8Fl3zRa5wfcNRSmzvErtL/BHWFTEHsBim0Km4t2erWdN7K8Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777129693; c=relaxed/simple;
	bh=s6YTtDDJV69wZb0GYZh3ZF8m4gmsieyu+q2ASn3r/Pg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Xr0LvlxhT0e65+z7psu8SmkKPsmD8wbkvn5Qc7muag+G6aIemzwcBpLiRLPA2or+XwFLZ2KkOvyJnmwNO/yJC3gsTbWrpoU92p+C0+MWSmOlOPKFvZKn8X4ui6BHW6jd4R4bUqhF4zSl7mjhc18QAYMXlkfox7MQGvvN0P3TuSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SAn2u9mf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4E33C2BCB0;
	Sat, 25 Apr 2026 15:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777129693;
	bh=s6YTtDDJV69wZb0GYZh3ZF8m4gmsieyu+q2ASn3r/Pg=;
	h=Date:From:To:Cc:Subject:From;
	b=SAn2u9mfZf42M2P7WUYiKZQ2kf3xNXhlm/iTo0aL/y18IyomIHH0qAFWFOqwuZzR0
	 E6P6btQEqGYxV8FaFMxhMHDzrM4hrde9qNJWuGRtld52YI27bVTLSDL4VNLuBocIab
	 69hVWR/WH1sNJDOGtZ0mb/fhx2MWGVehVq5P4U3U2ecIVJ8ojeGhY2lkTx0JxXn1zZ
	 7099WYVajP2S8YMU/9p+YVz+rShvweSJTXgX7GhdIozVY1Ij6xPI2aggmO1vo5LzIP
	 At3yrSwR6ZQPbB9ZebkE5vK2iJ0CZOe7JyOmywomu3hy+uIoR1A6VZKy6qosVd1G42
	 dutbX9oB51X1Q==
Date: Sat, 25 Apr 2026 18:08:09 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] TPM DEVICE DRIVER: for-next-tpm-7.1-rc1
Message-ID: <aezY2QpQiSQvnpCf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: B88F0466AB7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmx.de,ziepe.ca,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-9339-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Hi, 

I'll hold with pull request of 'for-next-keys' up until I know the status
of this (in order not to cause unnecessary spam).

BR< Jarkko

The following changes since commit faeab166167f5787719eb8683661fd41a3bb1514:

  Merge tag 'pinctrl-v7.1-1' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl (2026-04-18 16:59:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/for-next-tpm-7.1-rc1

for you to fetch changes up to 949692da7211572fac419b2986b6abc0cd1aeb76:

  tpm: tpm_tis: stop transmit if retries are exhausted (2026-04-21 18:54:29 +0300)

----------------------------------------------------------------
Here are the accumulated fixes for 7.1-rc1 and a single structural worth of
mentioning separately: Rafael's commit converting tpm_crb from ACPI driver
to a platform driver. Starting from this release cycle, the branch with TPM
changes mirrored to next is 'for-next-tpm', and patches for keys have their
own separate 'for-next-keys' branch.

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

