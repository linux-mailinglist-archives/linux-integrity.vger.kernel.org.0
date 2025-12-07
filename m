Return-Path: <linux-integrity+bounces-7843-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FA3CAB89C
	for <lists+linux-integrity@lfdr.de>; Sun, 07 Dec 2025 18:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C5823015ECA
	for <lists+linux-integrity@lfdr.de>; Sun,  7 Dec 2025 17:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2762DE71B;
	Sun,  7 Dec 2025 17:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qyraF6ih"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732412D978C;
	Sun,  7 Dec 2025 17:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765130237; cv=none; b=OUThC0klofXNLgu5aWEQtyhuz74xDsbsGSUguUU5GjTc9Hz3/Q6JN/o0b8BcLf99SEiD7/UqB1xlJeoYvlTCPWlwTz7H4uhKZP1K5ECUlAOzZ6s0vQ5jJnQROzTwnKXCgEgLtp1KGtcMzX5NQmcwVPnRsqBxwba7t1koTcZzhHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765130237; c=relaxed/simple;
	bh=jvLcb6iNug29o2ZmddInrd7h4230gE0btVVKLU+Aze0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GVOxfHGgaJRverXJqG1MeRqkUu57KHdV6EnYmPBfpw6zWshT8DEGh+VdwCvx0qfrE/HseKn4HzsM/nzhf3GuFf7pXylSK/WmnbDm5tXlMJ9Mcis3Gc6lfC9NpjiRoz/RCDAXAVuU2Bv6CdGSAyffndITBE3x+syXqBePuXt2phE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qyraF6ih; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9292CC4CEFB;
	Sun,  7 Dec 2025 17:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765130236;
	bh=jvLcb6iNug29o2ZmddInrd7h4230gE0btVVKLU+Aze0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qyraF6ihyQnuwlE81kHjDAIBAm/Mr/VHxT5QP84s1HTSPKSThHQ9qxor8RxEXoV1F
	 e1sgWibyUrW7/0EOsIDFd/gI1Eus8sjdJ5t05PBJoEfDr9t8TpuHb+hnXCrp0xIuJc
	 1lWxfgzlducMEs58p1zqTjP54L4fk2LEx9CHiG6hwJs6dUDAL5RhAeEl+1x+ldW+KR
	 7BbfGvGhsf9Y9hFsA6uwnICm2G2uu8peU1pcbJiybHMghXDpWM0+362TjVkAl9A8tC
	 GddscUUf7cyrmvaywhREG6hwpOF9XN/oMPvhMscNGrs0rWsXrTE1T+YydGtE4uBPMi
	 UIniuSbW3shZA==
Date: Sun, 7 Dec 2025 19:57:13 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: tpm2@lists.linux.dev, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KEYS-TRUSTED" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v6 2/2] KEYS: trusted: Store parent's name to the encoded
 keys
Message-ID: <aTW_-fv8B6q6TAMx@kernel.org>
References: <20251207173210.93765-1-jarkko@kernel.org>
 <20251207173210.93765-3-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251207173210.93765-3-jarkko@kernel.org>

On Sun, Dec 07, 2025 at 07:32:10PM +0200, Jarkko Sakkinen wrote:
> Extend TPMKey ASN.1 speciication [1] with an optional 'parentName'
> attribute containing TPM name of the parent key (in other words, TPMT_HA
> blob).
> 
> The life-cycle for trusted keys will now proceed as follows:
> 
> 1. Encode parent's name to the 'paretName' during tpm2_key_encode().
> 2. During tpm2_unseal_trusted, read parent's name from 'parentName'. When
>    the attribute is not available, fallback on doing tpm2_read_public().
> 
> In other words, in the common (i.e., not loading a legacy key blob),
> tpm2_read_public() will now only happen at the time when a key is first
> created.
> 
> In addition, move tpm2_read_public() to 'tpm2-cmd.c' and make its body
> unconditional so that the binary format of the saved keys is not dependent
> on kernel configuration.
> 
> [1] https://www.hansenpartnership.com/draft-bottomley-tpm2-keys.txt
> 
> Cc: tpm2@lists.linux.dev
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

As an alternative workaround I think the following could be possibly
done (I need to trial it first though):

1. Maintain a cache where a name gets added at the time of
   tpm2_seal_trusted(). It is from TPMT_HA to TPMT_HA mapping,
   mapping TPMT_HA of the key to the TPMT of the parent.
2. At thet time tpm2_unseal_trusted() retrieve name of thet
   parent from the cache.

Capturing TPM2_CreatePrimary would be essentially duct taping the
spec but I guess this could be more generally applicable. It neither 
addresses persistent keys nor secondary parent keys, which we *have
to support*, as the kernel interface does.

BR, Jarkko




