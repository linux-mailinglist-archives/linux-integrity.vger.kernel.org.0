Return-Path: <linux-integrity+bounces-2954-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C674F91E467
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Jul 2024 17:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 038B41C2350A
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Jul 2024 15:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5037C16D4E0;
	Mon,  1 Jul 2024 15:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="owBdrfEO"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2851B16D4D9;
	Mon,  1 Jul 2024 15:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719848619; cv=none; b=TSWm4najCSIMnOBAcBk9HVfZIa0hLMyFJW9g96du/Ej62JoZ0PRUZGbgPwMrkQdvqEIAS4EhiJWOscl+Diis9WwPcOIbKYn0GpBlmZls8Iv9CPt4rV5uUpd4rYHHTxyxhaFS2DVOiy7D+UAYm9wMDP586tVV9axowXr3NG4Z/rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719848619; c=relaxed/simple;
	bh=YsUgt36OdyahuJnlkpqtUaLJ2L7SEtLLncIuYn+XjX8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To; b=MkVlaNqaxuQh98I0xmRr31JG2Lsn5hpl46t6Fxw8wLWyzZ+Ipd1uc+cNjrXjrc08iQdJcKpv0UN2tOoO7XttUGu8il4Sxtt2vVBLz7hlSzJ72cVLSXvTNEowSu4U4zjG9qGqwRBSJvS00y9IjgnN9paNcnoguc+cycespSqenYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=owBdrfEO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BD1CC32781;
	Mon,  1 Jul 2024 15:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719848618;
	bh=YsUgt36OdyahuJnlkpqtUaLJ2L7SEtLLncIuYn+XjX8=;
	h=Date:Cc:Subject:From:To:From;
	b=owBdrfEOGt0a7S3ZhcRrUAY2gS4AhT/8qJGFZyite4gIUFOzczA4RcVnmdckcHd/U
	 B0vjE9Cq+Ogc7V3VrkJ3Ixo4XeDHFLxTMuxpAhLx/hrSvCc8E6f5vC+2aL4+0gW8oY
	 EETycZrWYT8kime7Hmw6ggrfyT7iPQiZg98eGezhAwa6rs7oJOjFLiygfvgfSH9ya6
	 li3pZqgkSW6TcDy5jskS+OVCuPrBaBrArpubTPPIvOIHMP/OzRpNyhkFAzz5LtImCn
	 6SjeLF1csj6HgR7aRL8hi9bPbO/9YSo4B9URUOFa7ZxeaiA9+R0z2HTDU3YAOWAO/y
	 NF0ttgT6d1vpg==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Jul 2024 15:43:35 +0000
Message-Id: <D2EBGASKUM3T.23IIXSBIQPIKB@kernel.org>
Cc: "David Howells" <dhowells@redhat.com>, "Herbert Xu"
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
 <keyrings@vger.kernel.org>, <linux-integrity@vger.kernel.org>
Subject: [GIT PULL] KEYS: keys-next-6.11-rc1
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-Mailer: aerc 0.17.0

The following changes since commit 22a40d14b572deb80c0648557f4bd502d7e83826=
:

  Linux 6.10-rc6 (2024-06-30 14:40:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags=
/keys-next-6.11-rc1

for you to fetch changes up to 84edd7adcc9de7c37d1d5f856601aa159a184c74:

  KEYS: encrypted: add missing MODULE_DESCRIPTION() (2024-07-01 14:16:54 +0=
000)

----------------------------------------------------------------
Hi,

Contains cosmetic fixes only.

BR, Jarkko

----------------------------------------------------------------
Jeff Johnson (2):
      KEYS: trusted: add missing MODULE_DESCRIPTION()
      KEYS: encrypted: add missing MODULE_DESCRIPTION()

 security/keys/encrypted-keys/encrypted.c  | 1 +
 security/keys/trusted-keys/trusted_core.c | 1 +
 2 files changed, 2 insertions(+)

