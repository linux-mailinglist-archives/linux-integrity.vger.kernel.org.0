Return-Path: <linux-integrity+bounces-4594-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AAE1A17A6A
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Jan 2025 10:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C0B27A170B
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Jan 2025 09:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA181C07F3;
	Tue, 21 Jan 2025 09:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DW7XO9XY"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9519A1BB6BC;
	Tue, 21 Jan 2025 09:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737452618; cv=none; b=DlkNcKWv24RVsvdI028RDRrh5K/qV9BOs6A6jWAxTxfcIJD0LAKb0I2iQKyT5iuzgue6dfF6E0q0xJve1pE8mGtjdi0itUHvXOhKL+AOYHZ1zIahVHMeIUmx4QzImR1UUPTAj8MXS2k5KhbhsCUUwAM0zQQkXIvA/o0//kbjLYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737452618; c=relaxed/simple;
	bh=pXuvGtKyfKyw0MKrMkW2iIhKbWrdeF4tEoF9Pkd2JTE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To; b=VVWI1XNlPpiSjtDhefOZuA1XX6nw2KDMgKJtZciiTlFWZ5kV5ASaj/mp6Y9PIJY7yR9TXN/IrmUInlRWtE12wq1ysG/9nBahaU0WS0ygR2sve29eJllCBWgY/uj6U0jB+juVR1n3LlZ2h97RFrL1qZdXo50N3QbLTftVIEVzRlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DW7XO9XY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A34FCC4CEDF;
	Tue, 21 Jan 2025 09:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737452618;
	bh=pXuvGtKyfKyw0MKrMkW2iIhKbWrdeF4tEoF9Pkd2JTE=;
	h=Date:Cc:Subject:From:To:From;
	b=DW7XO9XYUDravOyAzstah3KdihPKf81h6WmBq8pVmca/13iVkuyM213TmfPIB1m/x
	 5Yse4AunKtqFxui8BWkGnKy9/9CJxzg9rnbTs3yA4BOhS5mLPuqPafPy4o8ExEr2e3
	 V9mdhXkkhVcMIEv+mU3o7gGyvpCYKc0WK4kKmCNNRddCiBAuMAzGLx/hty/GOXJjQn
	 gzXOSTg9gGpeDlxo3GNeTvdOGz1+Dd6xPJxvCKR+LPLbaF9tGwyybiia2iwgHCoZw1
	 uH8bzItntedBhG4LdQEu38+TdWE8RLh6/dvqqLxrUivR3UPdXNXX8cceCyBm+AT7GZ
	 FJzL8AMmba0CQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Jan 2025 11:43:34 +0200
Message-Id: <D77NJS1N025A.3305QBZZWJQYE@kernel.org>
Cc: "David Howells" <dhowells@redhat.com>, "Herbert Xu"
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
 <keyrings@vger.kernel.org>, <linux-integrity@vger.kernel.org>
Subject: [GIT PULL] KEYS: keys-next-6.14-rc1
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-Mailer: aerc 0.18.2

The following changes since commit 95ec54a420b8f445e04a7ca0ea8deb72c51fe1d3=
:

  Merge tag 'powerpc-6.14-1' of git://git.kernel.org/pub/scm/linux/kernel/g=
it/powerpc/linux (2025-01-20 21:40:19 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags=
/keys-next-6.14-rc1

for you to fetch changes up to e8d9fab39d1f87b52932646b2f1e7877aa3fc0f4:

  KEYS: trusted: dcp: fix improper sg use with CONFIG_VMAP_STACK=3Dy (2025-=
01-21 11:25:23 +0200)

----------------------------------------------------------------
Hi,

Here's the keys changes for 6.14-rc1.

BR, Jarkko

----------------------------------------------------------------
Christian G=C3=B6ttsche (1):
      keys: drop shadowing dead prototype

David Gstir (1):
      KEYS: trusted: dcp: fix improper sg use with CONFIG_VMAP_STACK=3Dy

 include/keys/system_keyring.h            |  2 +-
 security/keys/trusted-keys/trusted_dcp.c | 22 ++++++++++++++++++----
 2 files changed, 19 insertions(+), 5 deletions(-)

