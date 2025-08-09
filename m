Return-Path: <linux-integrity+bounces-6792-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 324B3B1F58D
	for <lists+linux-integrity@lfdr.de>; Sat,  9 Aug 2025 19:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EA34561AD2
	for <lists+linux-integrity@lfdr.de>; Sat,  9 Aug 2025 17:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C959277804;
	Sat,  9 Aug 2025 17:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDOEwLcU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553C1274651;
	Sat,  9 Aug 2025 17:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754760001; cv=none; b=lTATp9Dt3x2Ml7Xs43FtkmRsaqvKjsEvERn/cdWhm7dulwjU3YjCyls99NoE/uPEhCBZUkJy6hDM7b6N8GaRoajFprweZEWVTy/H1KpAiT2A+5gFUgD5xxp5GH3TLDEmM1arAukgvOcST2AiEiuJ22agacf74Bs9H/dFNd4g3HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754760001; c=relaxed/simple;
	bh=jy1L8By3ZUXoLNzWl7uNdMfFV8Bs+40J0T0Ek0GNVZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u/8p7OByzRjHWnTJ5eGq3JvVvWe05Zc6KxbUG6MmlH3sZDTxDcADSxpMF+VDXFmbUytwsJRf8vRJ4JdVIPj2INmSIZbQr9cQNrw+GicCqDljZSXOSFSqCNuzHSwib/bucTakNCNa87bZPT1+TMit1RaPJzAfcmqJ/gSsJxMMUgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UDOEwLcU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E248C4CEE7;
	Sat,  9 Aug 2025 17:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754760000;
	bh=jy1L8By3ZUXoLNzWl7uNdMfFV8Bs+40J0T0Ek0GNVZY=;
	h=From:To:Cc:Subject:Date:From;
	b=UDOEwLcUSFwwBqt1xrSWuXZkl9RIKgGeKV2a7F400EkjleWGWBytKUy+jAy9qbmbZ
	 0yu8+bqqmwFR9wZbpBuaTeP+KjXk1eiHxWVzMyXzoqKb2YRsGfMpxfmL9AjPMyQEKc
	 5PUCrh+JZfidhWgCSLTL/HO6H1xDSW9BUBsWHki3O/8UcA7a6erHi6igOsYBkZU5Uf
	 ZPy+67RJZVip38YExmMdZJ1lSYaCLzMhmcdcG6HZi7yx9d3aWpFL9dTQsO2Vt8A8CE
	 DhS0rv+jJK3SaqFNV7Pm7FiXAzCqW0ag9XjeLH9TydELNnQvfbkO4uGA7aam0CpJ0G
	 lmZqzqwd+ZoGA==
From: Eric Biggers <ebiggers@kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	keyrings@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	linux-integrity@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v2 0/3] KEYS: trusted_tpm1: HMAC fix and cleanup
Date: Sat,  9 Aug 2025 10:19:38 -0700
Message-ID: <20250809171941.5497-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 fixes the HMAC-SHA1 comparison in trusted_tpm1 to be
constant-time.

Patch 2 simplifies the SHA-1 and HMAC-SHA1 computation in trusted_tpm1
by using library APIs instead of crypto_shash.  Note that this depends
on the SHA-1 and HMAC-SHA1 library APIs that were merged for v6.17-rc1.

Patch 3 is a trusted_tpm1 cleanup that moves private functionality out
of a public header.

Changed in v2:
    - Added the requested note to the commit message of patch 1.
    - Added a Reviewed-by tag

Eric Biggers (3):
  KEYS: trusted_tpm1: Compare HMAC values in constant time
  KEYS: trusted_tpm1: Use SHA-1 library instead of crypto_shash
  KEYS: trusted_tpm1: Move private functionality out of public header

 include/keys/trusted_tpm.h                |  79 ------
 security/keys/trusted-keys/Kconfig        |   5 +-
 security/keys/trusted-keys/trusted_tpm1.c | 284 ++++++++--------------
 3 files changed, 100 insertions(+), 268 deletions(-)


base-commit: 561c80369df0733ba0574882a1635287b20f9de2
-- 
2.50.1


