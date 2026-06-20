Return-Path: <linux-integrity+bounces-9818-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /u1vOJHoNmoqGQcAu9opvQ
	(envelope-from <linux-integrity+bounces-9818-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sat, 20 Jun 2026 21:22:57 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C0C6A9900
	for <lists+linux-integrity@lfdr.de>; Sat, 20 Jun 2026 21:22:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=EBkCufm1;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9818-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9818-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C609D301652A
	for <lists+linux-integrity@lfdr.de>; Sat, 20 Jun 2026 19:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5244936826E;
	Sat, 20 Jun 2026 19:22:55 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395181FBEBC;
	Sat, 20 Jun 2026 19:22:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781983375; cv=none; b=sWs10XSvLWi7ggW+TNShprU/2k3esf7dPdXSGi9SjNtZqPu3QuzEPpH+45HKvDM2ALSKjh9m4rNLs9XVKCPwWVrkq1PmuMHy3nnBe9rvJFyVhm6pqYw0E836Fwuy08bL+FtVms/Lu2f+UveHypFLLxelnA+FR6PHRqeYcHVeBx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781983375; c=relaxed/simple;
	bh=aLXam5u2x1/977in5D7pPay+Ft4nk+rEUAtDYE34Ufc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=czuTnhDjWPyCxOtrDDWWCNdCSligWLtVXdL1BurUeClUaOhpoQedjVYspzi13Ce556ubpM0GUzAimi2ITr6/qB02Qo10fbEhvvDksXe7r2TLQldLA+oZLf2oQCJywwtN6ijIttP1Ds+r8y8YXQoMAPFUtHBUmqpnh8s4hfjx4Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EBkCufm1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 45E391F000E9;
	Sat, 20 Jun 2026 19:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781983373;
	bh=iBuIUlWT6KZz840oFbYozhkMeTNRRTOOsvlentiLnZ8=;
	h=Date:From:To:Cc:Subject;
	b=EBkCufm1l8xJXwQ64JP73Ne84+W28FKnoFq8YQaPXX1XHiTUni7oKcBZH8PAVYQ0F
	 Cq5dCS13BjnSOcq3Lz7N1TumBNp8Ghgd7pK4g35T86Cc38kM9xIMhinYHupXEFaPSr
	 sU9kYE83u3sTQ+RieCEhiaznb9aMxGUpenHGVrobHQgERdUoyGUzazYcvq8WQLd6Qk
	 kQIOEfS8A30N7SDkTBkw60XTut7LVUj+9GbD6ctRPyvWy/5JxDInu5FM+zep7EtmE6
	 2HG5LOTmjrWdGwVDlXkOBn5rOxaiIT4SVGu+gUCncIsVGb+X41hKl3lq0X+ihi0b4i
	 77ddV0CKEysWg==
Date: Sat, 20 Jun 2026 22:22:49 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] TPM DEVICE DRIVER: for-next-tpm-7.2-rc1
Message-ID: <ajboiUkyqgZxHpZS@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9818-lists,linux-integrity=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 48C0C6A9900

The following changes since commit 0e0611827f3349d0a2ac121c023a6d3260dcecdb:

  Merge tag 'pull-fixes' of gitolite.kernel.org:pub/scm/linux/kernel/git/viro/vfs (2026-06-15 15:53:57 +0530)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/for-next-tpm-7.2-rc1

for you to fetch changes up to 67c53887ebcd425f0003e7068de12eab511f80a9:

  tpm: fix event_size output in tpm1_binary_bios_measurements_show (2026-06-15 15:19:45 +0300)

----------------------------------------------------------------
Hi,

Please, pull. This pull request contains only bug fixes.

BR, Jarkko

----------------------------------------------------------------
Baoli Zhang (1):
      tpm: restore timeout for key creation commands

David Laight (1):
      keys: Replace strcpy(derived_buf, "AUTH_KEY") with strscpy(..., HASH_SIZE)

David Windsor (1):
      tpm: svsm: constify tpm_chip_ops

Eric Biggers (1):
      KEYS: encrypted: Remove unnecessary selection of CRYPTO_RNG

Gui-Dong Han (1):
      KEYS: Use acquire when reading state in keyring search

Gunnar Kudrjavets (1):
      tpm: Initialize name_size_alg for non-NULL name in tpm_buf_append_name()

Jarkko Sakkinen (3):
      KEYS: fix overflow in keyctl_pkey_params_get_2()
      KEYS: trusted: Debugging as a feature
      tpm: tpm_tis_spi: Use wait_woken() in wait_for_tmp_stat()

Jim Broadus (2):
      tpm: tpm_tis: store entire did_vid
      tpm: tpm_tis: Add settle time for some TPMs

Len Bao (1):
      keys/trusted_keys: mark 'migratable' as __ro_after_init

Michael Bommarito (1):
      tpm: tpm2-sessions: wait for async KPP completion in tpm_buf_append_salt

Mohammed EL Kadiri (3):
      keys: prevent slab cache merging for key_jar
      keys: request_key: replace BUG with return -EINVAL
      keys: keyctl_pkey: replace BUG with return -EOPNOTSUPP

Rafael J. Wysocki (1):
      tpm_crb: Check ACPI_COMPANION() against NULL during probe

Shaomin Chen (1):
      keys: Pin request_key_auth payload in instantiate paths

Thorsten Blum (2):
      keys: use kmalloc_flex in user_preparse
      tpm: fix event_size output in tpm1_binary_bios_measurements_show

Yeoreum Yun (1):
      tpm: tpm_crb_ffa: revert defered_probed when tpm_crb_ffa is built-in

 Documentation/admin-guide/kernel-parameters.txt | 16 +++++++
 drivers/char/tpm/eventlog/tpm1.c                |  4 +-
 drivers/char/tpm/tpm2-cmd.c                     |  6 +--
 drivers/char/tpm/tpm2-sessions.c                | 56 ++++++++++++++++------
 drivers/char/tpm/tpm_crb.c                      |  6 ++-
 drivers/char/tpm/tpm_crb_ffa.c                  | 18 ++-----
 drivers/char/tpm/tpm_svsm.c                     |  2 +-
 drivers/char/tpm/tpm_tis_core.c                 | 63 ++++++++++++++++---------
 drivers/char/tpm/tpm_tis_core.h                 |  3 +-
 include/keys/request_key_auth-type.h            |  2 +
 include/keys/trusted-type.h                     | 21 +++++----
 security/keys/Kconfig                           |  1 -
 security/keys/encrypted-keys/encrypted.c        |  4 +-
 security/keys/internal.h                        |  2 +
 security/keys/key.c                             |  2 +-
 security/keys/keyctl.c                          | 24 +++++++---
 security/keys/keyctl_pkey.c                     | 14 ++++--
 security/keys/keyring.c                         |  2 +-
 security/keys/request_key.c                     |  2 +-
 security/keys/request_key_auth.c                | 33 ++++++++++++-
 security/keys/trusted-keys/Kconfig              | 23 +++++++++
 security/keys/trusted-keys/trusted_caam.c       |  7 ++-
 security/keys/trusted-keys/trusted_core.c       |  8 +++-
 security/keys/trusted-keys/trusted_tpm1.c       | 44 +++++++++--------
 security/keys/user_defined.c                    |  2 +-
 25 files changed, 256 insertions(+), 109 deletions(-)

