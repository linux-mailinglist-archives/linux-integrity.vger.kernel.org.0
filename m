Return-Path: <linux-integrity+bounces-9233-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEmmL9PL5GkIZwEAu9opvQ
	(envelope-from <linux-integrity+bounces-9233-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Apr 2026 14:34:27 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 636F8423F34
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Apr 2026 14:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6F47D3004DEE
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Apr 2026 12:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83EBD228CB8;
	Sun, 19 Apr 2026 12:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OsGNviiP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D2C22578D;
	Sun, 19 Apr 2026 12:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776602065; cv=none; b=g46iUTcRUHytadFRaK/lXkldPHbiTWU7Ikeinyw9kDwFe/BX6qln8doE1L5KIK9dRdgI6boyLNEWSlJWqZYDFcUD55+3ynKzT4y0T4S0RKDX9bwjbn8g6ajiVO76J6VLbqE1STlXuLSqeKhRJfGBD/xsOw6z4HcRO9jqLCVjgAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776602065; c=relaxed/simple;
	bh=07q3DFZkPKKyPBCWMzl/ekvXtnWQ2w3JToiHgy0TPW0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=O6GUsctccSieqRUfMKD3nNx4CyByx6zcWiv+79hUKCobAK/Uti9olyZjkV5FEQB6x6DsCSOkveUt3xQ30bZaAAZjJokVNirjaSJ47hFmQ5m3YxEwbrhq68hzkDrpKyVd4XrObdvUrPcGvG7ea8uGhYUQoMoEEcNPN3EziD1wJOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OsGNviiP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 616AEC2BCAF;
	Sun, 19 Apr 2026 12:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776602064;
	bh=07q3DFZkPKKyPBCWMzl/ekvXtnWQ2w3JToiHgy0TPW0=;
	h=Date:From:To:Cc:Subject:From;
	b=OsGNviiP0+tn1hoXqbeQDtMWR3Tn8QPbcNqynrM17LfQuKH8jTcjKmQNb8yEc9Ztm
	 5prbPa7NE3fNdqf1X6+ZGzy+On/gKunFAYmWnpzxEjYD6GjS+MiQmmqtGl02K5oil2
	 zqzw31NthH0vMPLCcbJtBJQqhBThbsz3gJUP5RokD5nCc2lpuy9/HTi/tUG5GH5nZ3
	 PjjWkkeUBBGjT7z5QIYsvlI9SPZf4YljcE6T9E1fNM6jragfr+OwIdmnmYlG6UuxFL
	 1y9+1SO3tC7qsPXSeq8T1ZiSMivKIiAakaV5i/4wmUXq7A2VFCrgkZiQQTDA6WMeby
	 Rzbtx3iT+fFpQ==
Date: Sun, 19 Apr 2026 15:34:20 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org
Subject: [GIT PULL] KEYS: keys-next-7.1-rc1
Message-ID: <aeTLzOgblMZRnDvF@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: aerc
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9233-lists,linux-integrity=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 636F8423F34
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The following changes since commit faeab166167f5787719eb8683661fd41a3bb1514:

  Merge tag 'pinctrl-v7.1-1' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl (2026-04-18 16:59:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/keys-next-7.1-rc1

for you to fetch changes up to 4fb4ce024d06a0b31ab6cdd17ab8cb6aff851067:

  KEYS: trusted: Debugging as a feature (2026-04-19 15:17:03 +0300)

----------------------------------------------------------------
Hi

This pull request mainly sanitizes debug traces in trusted keys to
proper kconfig flags, and makes the whole feature overall a bit safer
by putting it under kernel command-line parameter and setting up a
convention to only use debug level traces.

BR, Jarkko

----------------------------------------------------------------
Eric Biggers (1):
      KEYS: encrypted: Remove unnecessary selection of CRYPTO_RNG

Jarkko Sakkinen (1):
      KEYS: trusted: Debugging as a feature

 Documentation/admin-guide/kernel-parameters.txt | 16 +++++++++
 include/keys/trusted-type.h                     | 21 +++++++-----
 security/keys/Kconfig                           |  1 -
 security/keys/trusted-keys/Kconfig              | 23 +++++++++++++
 security/keys/trusted-keys/trusted_caam.c       |  7 ++--
 security/keys/trusted-keys/trusted_core.c       |  6 ++++
 security/keys/trusted-keys/trusted_tpm1.c       | 44 ++++++++++++++-----------
 7 files changed, 87 insertions(+), 31 deletions(-)

