Return-Path: <linux-integrity+bounces-7368-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FB4BB8F07
	for <lists+linux-integrity@lfdr.de>; Sat, 04 Oct 2025 16:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 92A0F4E3373
	for <lists+linux-integrity@lfdr.de>; Sat,  4 Oct 2025 14:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F41227EA4;
	Sat,  4 Oct 2025 14:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pq5geyj+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A622153E7;
	Sat,  4 Oct 2025 14:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759589207; cv=none; b=nIrwyi3rm98ZMivfJyKWoHx9o6sSKciC7NxiIwOKIIrFx3UdhCwX0tzRWrdwPvfFuHzcc30HplP0UnWrUcLwClmlCj4j6H6/5D/ntqlpIWSfQFxKokQ9qDa1r6HPX38Jl9iivIueqG2arPse6cbpo04qEhe7JhrfmV55EuRINLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759589207; c=relaxed/simple;
	bh=Z3juchlwRA/FAepjF1qkRlq8lUY077dtuthI6jIjqnM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FmLTpY4ua85v+xwg/QgcNCXjYA5rvDOMOoGHHLIiNYWcLF6GKGsDNYw1g+qhyILM9U6rH4TXmTPxndkg1tj8816dlMNWum9/oJNrLuapbLSNlYsgKAbqj75os9J0QdtOoLOCFaJj6VW2jAwpb34oifDiolZScy2Hsr+Q7zz/iKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pq5geyj+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE46C4CEF1;
	Sat,  4 Oct 2025 14:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759589207;
	bh=Z3juchlwRA/FAepjF1qkRlq8lUY077dtuthI6jIjqnM=;
	h=Date:From:To:Cc:Subject:From;
	b=Pq5geyj+tbyZRPRLBgsFxU9dI5n6INQAbgC5cmTpVxFjIidHBjGQbKGXxh9Ct8/gF
	 MfMinmvwmOLO3hj8SDqjrduMFic88aObnBDxEYbDjowE/1hkXwxJ+qPPgasRXKy8Nx
	 KCe6fNB+olv4Aw4iV7B6eLFnNumonFx1SesR/tTFCvNkD1rQDf5q1Ha3sF/49woI7t
	 1dU/CbPqY3zCh5BijwoAcsXzeAjvf3uGV+BpvcJHGdTjXe7F9LKcSZKbzssYTAsUlO
	 Hh7G3wxAVDRsfmtdjswcQt1hwNWx1FpvhY8nHwg/4Ys28Uz4r/eNoKNXrOEOD/SHdm
	 m93E1A7QOLEEA==
Date: Sat, 4 Oct 2025 17:46:43 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org
Subject: [GIT PULL] KEYS: keys-next-6.18
Message-ID: <aOEzU7dRErEmbUqN@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit fec734e8d564d55fb6bd4909ae2e68814d21d0a1:

  Merge tag 'riscv-for-linus-v6.17-rc8' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux (2025-09-26 14:39:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/keys-next-6.18

for you to fetch changes up to 8be70a8fc667c33e69257a72e8092f07c828241e:

  security: keys: use menuconfig for KEYS symbol (2025-10-04 17:25:35 +0300)

----------------------------------------------------------------
Hi,

A few minor updates/fixes for keys.

BR, Jarkko

----------------------------------------------------------------
Eric Biggers (4):
      KEYS: trusted_tpm1: Compare HMAC values in constant time
      KEYS: trusted_tpm1: Use SHA-1 library instead of crypto_shash
      KEYS: trusted_tpm1: Move private functionality out of public header
      KEYS: encrypted: Use SHA-256 library instead of crypto_shash

Randy Dunlap (1):
      security: keys: use menuconfig for KEYS symbol

 include/keys/trusted_tpm.h                |  79 ---------
 security/keys/Kconfig                     |  17 +-
 security/keys/encrypted-keys/encrypted.c  |  63 ++-----
 security/keys/trusted-keys/Kconfig        |   5 +-
 security/keys/trusted-keys/trusted_tpm1.c | 284 +++++++++++-------------------
 5 files changed, 117 insertions(+), 331 deletions(-)

