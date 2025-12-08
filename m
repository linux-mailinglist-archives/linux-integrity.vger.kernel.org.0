Return-Path: <linux-integrity+bounces-7847-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9A9CAC0B4
	for <lists+linux-integrity@lfdr.de>; Mon, 08 Dec 2025 06:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7C0BC3007DAF
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Dec 2025 05:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6292923A9B0;
	Mon,  8 Dec 2025 05:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SEcWf81n"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323A01F5EA;
	Mon,  8 Dec 2025 05:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765170386; cv=none; b=HNVpxuoGy2BW1eQ2oCnQnXBw/DF6deQT4efstXPVT6Z118JmjzxGHiy0Y3mLbOIBtfg6ARvT717BFgX4gBQDQeAEOJ/bbDBiEtPikCflE0FlpeBVBa75QkxZcArsp/50DRbBj0U6gMAaXWfCinohT9aSYKapQ19U0Cf+l5m0WTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765170386; c=relaxed/simple;
	bh=NFYtWFj2HRXw0mhexPN2cpE5XCGt348dy3AXyVMMLss=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f7ML/wzAzDn5UIOzjCC0GKCzZRIaH0vKS4q4NfD/YXERCOWTs3R2ak5UhL0sBGwawsdGW2x67uTacZ7sQQUbsZ5dvtKg328t9bixsdIsNi/kypJiN72vqG4TXmY7Vb83aGcfvi0+1qofhrhIQHD1fPMZb7CkH2qhOJlUQpg56mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SEcWf81n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 630C6C4CEF1;
	Mon,  8 Dec 2025 05:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765170386;
	bh=NFYtWFj2HRXw0mhexPN2cpE5XCGt348dy3AXyVMMLss=;
	h=From:To:Cc:Subject:Date:From;
	b=SEcWf81naz1pZKDKzrGILNR8lr5NCzQ8/JUQ7y31hlUc8u/GOWELA6Bn2Dj2EkzlF
	 351vq9CoJIek71Gk/pws48iTHFE4+2gWqVkgM8xK2nmENBNz+PUQrguMhm05krg8IY
	 QxGZpVwcpsb2tnC80F2sf7JqFuOxED5e9CGK2K8hv9LdG4tP0XqsjRZIYhWC1oKLyb
	 sSeD6XRXOwa5UxTvELIhd+eDDpi4jEh33WmCFFd9unnxuNMwQFa4J0Kximp4fOGOc8
	 kZRepecDI3yEUM/iaMUsBFCNfjt2wvDOv+NYlpfMkI0lGLwYVQPORi5csJxjyZnsaE
	 seR11TKeWlBVg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: tpm2@lists.linux.dev,
	Jarkko Sakkinen <jarkko@kernel.org>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	keyrings@vger.kernel.org (open list:KEYS-TRUSTED),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v7 0/3] Optimize tpm2_read_public() calls
Date: Mon,  8 Dec 2025 07:06:16 +0200
Message-Id: <20251208050620.339408-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The main goal is fairly straight-forwrd here.

The aim of these patches is optimize the number of tpm2_read_public() calls
to the bare minimum. 

## About dropping 'parentName' attribute for ASN.1 keys from the patch set

I wrote this section as a remainder as I have facts fresh in my mind so 
that I can return them as soon as there is working group for the ASN.1 
specification. We really need to have this in the spec.

I dropped [1] given that [2] is landing shortly to IETF draft process,
according to James Bottomley [3]. We will return to [1] as soon as draft
process is open for comments. Still, that attribute is super important,
and here is why.

This will cause a overhead as tpm2_unseal_trusted needs to do an
unnecessary (from pure technical perspective) TPM2_ReadPublic command to
acquire TPM name of the parent. This is obviously known at the time of
creation of a key but the information is not stored anywhere by the
key format.

It also aligns badly with TCG specifications as Table 6 of architecture
spec explicitly defines a reference (or name) for transient keys,
persistent keys and NV indexes to be TPM_ALG_ID concatenated together
with the hash of TPMT_PUBLIC. I.e. the file format is using exactly
the opposite what should be use as reference for keys than what it 
should use.

Other benefits are of course auto-discovery of parent for a key file,
which is nasty to do without the name pre-stored.

[1] https://lore.kernel.org/linux-integrity/20251207173210.93765-3-jarkko@kernel.org/
[2] https://www.hansenpartnership.com/draft-bottomley-tpm2-keys.txt
[3] https://lore.kernel.org/linux-integrity/89d90617ba9b7a5eff1d5fad6bb9773033d3c18c.camel@HansenPartnership.com/

Jarkko Sakkinen (3):
  tpm2-sessions: Define TPM2_NAME_MAX_SIZE
  KEYS: trusted: Re-orchestrate tpm2_read_public() calls
  tpm2-sessions: Remove AUTH_MAX_NAMES

 drivers/char/tpm/tpm2-cmd.c               |   3 +-
 drivers/char/tpm/tpm2-sessions.c          | 116 ++++++--------------
 include/linux/tpm.h                       |  19 +++-
 security/keys/trusted-keys/trusted_tpm2.c | 124 ++++++++++++++--------
 4 files changed, 133 insertions(+), 129 deletions(-)

-- 
2.39.5


