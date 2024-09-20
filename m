Return-Path: <linux-integrity+bounces-3645-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE7097D8DB
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Sep 2024 19:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE1101C21A41
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Sep 2024 17:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD9317798F;
	Fri, 20 Sep 2024 17:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTrkJjnv"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C03171D2;
	Fri, 20 Sep 2024 17:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726851920; cv=none; b=dIVsREFYqfCAqiJ7QXA00gi36mycK3toluNKNd5NxQKtBFkHXcOqdZX8eLV6LO4y/M9iP5sUdtljbdVadfuzEVWCoZHlApxaUEqTKjyu4hxpI4O2tVBybeyTud84NvnuLTNQFpVdWJ9VShFy6f/75CZ4y3Mw2sAnsGz+skyfXDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726851920; c=relaxed/simple;
	bh=6WEWsawcbQAeIjl22pazBYBHEJFbDlUyRAiS4Rgd7zo=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From; b=MgUeYRkuI2O89YMi9TwFML8rNVYf7yF5MmgKfBuqoe0cXG6PcAH+kyhTiNFz7qEMn/YXxYTlaFAQAFhimAjEmGRW7N/t0r27StC66W2nfyRQfBmQl3OouizdTqw30YVv5JEDHVqdhIC1KbmWVm2tal54RrKaS1szymMsPDOzY6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTrkJjnv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51568C4CEC3;
	Fri, 20 Sep 2024 17:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726851918;
	bh=6WEWsawcbQAeIjl22pazBYBHEJFbDlUyRAiS4Rgd7zo=;
	h=Date:To:Cc:Subject:From:From;
	b=UTrkJjnvUBRMuDeQuNLsNZKSqv8o59T0+otLyNB0/bbBFZ2uZ12qkooIZd5jh/+zN
	 2ApPN2ELxB5E++QLFbA4W3zz95Wm5l2oFqEFzpnKbYwX6vk1lw1XfWihlXJdrA266+
	 4y+dUhTEZLW/1wOYdBsyRnwESamyDr4AoSwHKsArsLgJlkGxCLPy5U8mrWoKlUukTC
	 M7UvSMN8xgnxSBtz9Yf/ge3XFFtjddZ8YTZk91MJ4ZJ7+4MIMt2zBVUz/+RBCG/BaY
	 5+h9b+T2LnoCn5gQrlvexFnFWMZYDqyDlRWnnUXRrBYUYhv2KpTXZ96ccf1x2Hih0W
	 n3gsvfs4YtbhQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Sep 2024 20:05:14 +0300
Message-Id: <D4B9WXZC9B9U.34I6BHWMYXOS2@kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: "David Howells" <dhowells@redhat.com>, "Herbert Xu"
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
 <keyrings@vger.kernel.org>, <linux-integrity@vger.kernel.org>
Subject: [GIT PULL] KEYS: keys-next-6.12-rc1
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.18.2

The following changes since commit baeb9a7d8b60b021d907127509c44507539c15e5=
:

  Merge tag 'sched-rt-2024-09-17' of git://git.kernel.org/pub/scm/linux/ker=
nel/git/tip/tip (2024-09-20 06:04:27 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags=
/keys-next-6.12-rc1

for you to fetch changes up to 558bdc45dfb2669e1741384a0c80be9c82fa052c:

  sign-file,extract-cert: use pkcs11 provider for OPENSSL MAJOR >=3D 3 (202=
4-09-20 19:52:48 +0300)

----------------------------------------------------------------
Hi,

The beef of this pull request is OpenSSL 3.0 compatibility fixes for the
signing and certificates.

BR, Jarkko

----------------------------------------------------------------
Jan Stancek (3):
      sign-file,extract-cert: move common SSL helper functions to a header
      sign-file,extract-cert: avoid using deprecated ERR_get_error_line()
      sign-file,extract-cert: use pkcs11 provider for OPENSSL MAJOR >=3D 3

Roman Smirnov (1):
      KEYS: prevent NULL pointer dereference in find_asymmetric_key()

Yue Haibing (1):
      KEYS: Remove unused declarations

 MAINTAINERS                              |   1 +
 certs/Makefile                           |   2 +-
 certs/extract-cert.c                     | 138 +++++++++++++++++----------=
----
 crypto/asymmetric_keys/asymmetric_type.c |   7 +-
 include/keys/dns_resolver-type.h         |   4 -
 include/linux/key.h                      |   3 -
 scripts/sign-file.c                      | 132 +++++++++++++++------------=
--
 scripts/ssl-common.h                     |  32 +++++++
 8 files changed, 180 insertions(+), 139 deletions(-)
 create mode 100644 scripts/ssl-common.h

