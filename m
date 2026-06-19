Return-Path: <linux-integrity+bounces-9811-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gHVsG3SUNGrfbwYAu9opvQ
	(envelope-from <linux-integrity+bounces-9811-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Jun 2026 02:59:32 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C84606A37AA
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Jun 2026 02:59:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=QPbkeM8J;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9811-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9811-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5384C300D44F
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Jun 2026 00:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFE91EB9E3;
	Fri, 19 Jun 2026 00:48:33 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2288A1D54FA;
	Fri, 19 Jun 2026 00:48:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781830113; cv=none; b=to+wu9y9WTzZthpz1Vfm96qLfN9BglE4D0sHOlzze503QA8eLTu6ZvxI60+9AC0Wd5ttSJasFV4tK90ADy1v8f7XVEJIluVq1SA2qeXN1QP619Wfi3AK0KiWt4pQggFscjmoqG4iddcoQfTh/jqSoZFmBFqaDw/44la3HKaUXgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781830113; c=relaxed/simple;
	bh=fRgfbVsGkuS+q+6WK5fNrtAqPQUApG9fPIRSYafgWA8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=J8J/oijXDSeTp4x/mHv//wrQjbf/PU3PZCWKoQ9qnFF5QL5MRHJhjQ6/dQ/cthKW2oU/HRKm7SVjOnUqychts33jE6D1YgqlEmDWqA/uDH8Hb664rFiFVHn9ZJovlW2+7v1ckCSC4qw6cqyEuQQ9/9UmB7bnzmlPptDlXY2UhIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QPbkeM8J; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 405741F000E9;
	Fri, 19 Jun 2026 00:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781830111;
	bh=Ybzb4Vw207HqzgtI27H7799f1quWLo9LS+ZJoDGPQYQ=;
	h=Date:From:To:Cc:Subject;
	b=QPbkeM8JIHR8QD8bbOhG0VsMll8uU5iLE+s0C4ChORWqwlfGnK2FvdxlA14IL9+zE
	 tY2PE/gg7J91DnHWsVuGGpA7sIaDHcbbs9FCW/kzBlcWYBkqm/7lF0Cp+5yZWdjp5B
	 sFdOKQBdZVnmNmCPNljanclHWWK+WzB7XIqiylxxla+X4c/YGRH36rJQoho1+dK/01
	 2f7SY+GAl23oQ4TtSZfV8AgLRmpfOg0fiNkY23CbLsKdCGOiiJfs2Vl+rM8zBHlfPp
	 +LFDJxhBg1Juh6y9O/adY7Q1yApKIIaHZoR5+qzfB4npS35VOQaGBl/jboZRrtPSuN
	 sXvdzWkbHTVMA==
Date: Fri, 19 Jun 2026 03:48:27 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] TPM DEVICE DRIVER: for-next-keys-7.2-rc1
Message-ID: <ajSR22PC_X6HWjo2@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-9811-lists,linux-integrity=lfdr.de];
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
X-Rspamd-Queue-Id: C84606A37AA

The following changes since commit 0e0611827f3349d0a2ac121c023a6d3260dcecdb:

  Merge tag 'pull-fixes' of gitolite.kernel.org:pub/scm/linux/kernel/git/viro/vfs (2026-06-15 15:53:57 +0530)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/for-next-keys-7.2-rc1

for you to fetch changes up to 1b9524250996b1f2f49833a1b2ae21c34e486f85:

  keys: keyctl_pkey: replace BUG with return -EOPNOTSUPP (2026-06-15 15:19:13 +0300)

----------------------------------------------------------------
Hi

Please, pull. This pull request contains only fixes.

BR, Jarkko

----------------------------------------------------------------
David Laight (1):
      keys: Replace strcpy(derived_buf, "AUTH_KEY") with strscpy(..., HASH_SIZE)

Eric Biggers (1):
      KEYS: encrypted: Remove unnecessary selection of CRYPTO_RNG

Gui-Dong Han (1):
      KEYS: Use acquire when reading state in keyring search

Jarkko Sakkinen (2):
      KEYS: fix overflow in keyctl_pkey_params_get_2()
      KEYS: trusted: Debugging as a feature

Len Bao (1):
      keys/trusted_keys: mark 'migratable' as __ro_after_init

Mohammed EL Kadiri (3):
      keys: prevent slab cache merging for key_jar
      keys: request_key: replace BUG with return -EINVAL
      keys: keyctl_pkey: replace BUG with return -EOPNOTSUPP

Shaomin Chen (1):
      keys: Pin request_key_auth payload in instantiate paths

Thorsten Blum (1):
      keys: use kmalloc_flex in user_preparse

 Documentation/admin-guide/kernel-parameters.txt | 16 +++++++++
 include/keys/request_key_auth-type.h            |  2 ++
 include/keys/trusted-type.h                     | 21 +++++++-----
 security/keys/Kconfig                           |  1 -
 security/keys/encrypted-keys/encrypted.c        |  4 +--
 security/keys/internal.h                        |  2 ++
 security/keys/key.c                             |  2 +-
 security/keys/keyctl.c                          | 24 ++++++++++----
 security/keys/keyctl_pkey.c                     | 14 ++++++--
 security/keys/keyring.c                         |  2 +-
 security/keys/request_key.c                     |  2 +-
 security/keys/request_key_auth.c                | 33 +++++++++++++++++--
 security/keys/trusted-keys/Kconfig              | 23 +++++++++++++
 security/keys/trusted-keys/trusted_caam.c       |  7 ++--
 security/keys/trusted-keys/trusted_core.c       |  8 ++++-
 security/keys/trusted-keys/trusted_tpm1.c       | 44 ++++++++++++++-----------
 security/keys/user_defined.c                    |  2 +-
 17 files changed, 158 insertions(+), 49 deletions(-)

