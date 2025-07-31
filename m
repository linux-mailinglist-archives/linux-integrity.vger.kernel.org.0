Return-Path: <linux-integrity+bounces-6751-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A47B17811
	for <lists+linux-integrity@lfdr.de>; Thu, 31 Jul 2025 23:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A61D93A84EA
	for <lists+linux-integrity@lfdr.de>; Thu, 31 Jul 2025 21:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BFC264615;
	Thu, 31 Jul 2025 21:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SAogXx0q"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C355E2641E3;
	Thu, 31 Jul 2025 21:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753997047; cv=none; b=WByW2zvqk07t/lrHky3b17uFXxDLMHDRT/VFN58dituK3Yo+Kw2UDb5FqOz1h5Yp9gsv85p6ZgZsVGczdV6DuVuizh5LkHu8elV2U9w0OL1+6ClP8rZS8Gn4XW6jZrV3zJdZFGxpd5IbzgkWX1h42RsMxPDIGugpVJEWYaI+Wao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753997047; c=relaxed/simple;
	bh=UL7oPBmm/2o9dRG3W1uktjE4qXZumpiZOugTd+UoTAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s1Q8Ka9hO4YUxWRO5gHZoJUYIPA5UmlQcETVUytwR0cA6UkAyx0Dg5qw1WrlwW1XNpGHpB/we2iXqkNlJp67nxQQmmgWaeD60gjcLekNU39xYA0frfjJ94IQu/G9bQfDRrgsAKSMjOq9fl/3NdZNZSDMAC7nYfy9DLWKXQLNlW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SAogXx0q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03CF4C4CEEF;
	Thu, 31 Jul 2025 21:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753997047;
	bh=UL7oPBmm/2o9dRG3W1uktjE4qXZumpiZOugTd+UoTAQ=;
	h=From:To:Cc:Subject:Date:From;
	b=SAogXx0quX+hQweAx8DxuQrAVA/V6971OG5LXkiv2R7epalX8E57If8GoLpPuyMdg
	 dhMkQ+nLcC6zUfoDVMLnBdWvqNXG6WL12UzA3Cdczy0GpU1kooKv96mpGf63bNxIZL
	 CVo+Iqj9r0LeTVUJWwdj70brdwLYhCC6n3B6a/j5bM3/v6N0OY2ScXeLrY04M+LRTq
	 xUxOCjVn0HuSXd/Pii8IcrCroo3xxqfgm5pCz1s/DUvUQb/Rz13fpAg7rcHC9eDERI
	 GQefiqGY1edTD9pI/Gx80fQlAHjjL255pLY61XE22SZSv/m9wOJ47RWD9Gxwv2+Wi3
	 2pmICkpcCnmsg==
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
Subject: [PATCH 0/3] KEYS: trusted_tpm1: HMAC fix and cleanup
Date: Thu, 31 Jul 2025 14:23:51 -0700
Message-ID: <20250731212354.105044-1-ebiggers@kernel.org>
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

Eric Biggers (3):
  KEYS: trusted_tpm1: Compare HMAC values in constant time
  KEYS: trusted_tpm1: Use SHA-1 library instead of crypto_shash
  KEYS: trusted_tpm1: Move private functionality out of public header

 include/keys/trusted_tpm.h                |  79 ------
 security/keys/trusted-keys/Kconfig        |   5 +-
 security/keys/trusted-keys/trusted_tpm1.c | 284 ++++++++--------------
 3 files changed, 100 insertions(+), 268 deletions(-)


base-commit: d6084bb815c453de27af8071a23163a711586a6c
-- 
2.50.1


