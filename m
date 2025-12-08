Return-Path: <linux-integrity+bounces-7851-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 048C7CAC105
	for <lists+linux-integrity@lfdr.de>; Mon, 08 Dec 2025 06:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3CBE3020C43
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Dec 2025 05:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F282FE078;
	Mon,  8 Dec 2025 05:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LTmiKVLh"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B45C2F7AD2;
	Mon,  8 Dec 2025 05:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765170928; cv=none; b=kVYZc/nhfTGbRNnt4FGwFjtF78Ulk7yWkvrqp34vhsxrwe2Nkmsj6piAbKMI6CLibb49HHEEfy688SfxG7h6+lhSzVpISx4x01l4xajrvFKystafzVh8rvYACkmNF/TzmXVlncz784oWFNN98KRIUSXI2Mb3ceWKJj3D1n98CHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765170928; c=relaxed/simple;
	bh=EO+eptpophDK8ioaheMldpxHkJcTDL7LQ7oJpU0cLgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NKBCfspdNrIEnFe4ebGhY0pCEQsyhXIbCZutl8mnJvaHyQMvfGgI57CSVT4WgsyteDNRt8N9O2x3CigBCeya3EmXYhcvmV77wLg0ju5O5PULgh30DscunsWxBLdn1XEXdd2JPzo8pwmTHUJFnEwiJmrj8ao43JXuA4N1LjpTEq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LTmiKVLh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54AB4C4CEF1;
	Mon,  8 Dec 2025 05:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765170927;
	bh=EO+eptpophDK8ioaheMldpxHkJcTDL7LQ7oJpU0cLgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LTmiKVLhqtrjVxcUzPpAYJd5xZKFse4XGvNTDHtvrGd5IlUChTCQ4s3+adal2jfVb
	 7BPsTQq3YzJWGry4sFtxHd/j6CpQ2eweY2WRfaYF8OFoJutMdYkx+6gxze8gBI0BiV
	 2yl6ugutCK7uvyLuFvy6B+2SBQM1NI0+Hwknm6l7AQerFtiIqWGcS+r7OaNIcGUv+i
	 7RiHUrpDCiBNasIv36ez/A0rR//TmDUTJypTuk7Ch+smKC0H1EE9VrnujvmC695b8H
	 u3ZhbBYxfQGFC/bIm6xJPpor/p505J5T69M5EyTFAZKAeVUDaEdON+A6t6+2ASjF3s
	 q7ewO6PRFUgjg==
Date: Mon, 8 Dec 2025 07:15:23 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: tpm2@lists.linux.dev,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"open list:KEYS-TRUSTED" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 0/3] Optimize tpm2_read_public() calls
Message-ID: <aTZe65tllY4u2YT5@kernel.org>
References: <20251208050620.339408-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208050620.339408-1-jarkko@kernel.org>

On Mon, Dec 08, 2025 at 07:06:16AM +0200, Jarkko Sakkinen wrote:
> The main goal is fairly straight-forwrd here.
> 
> The aim of these patches is optimize the number of tpm2_read_public() calls
> to the bare minimum. 
> 
> ## About dropping 'parentName' attribute for ASN.1 keys from the patch set
> 
> I wrote this section as a remainder as I have facts fresh in my mind so 
> that I can return them as soon as there is working group for the ASN.1 
> specification. We really need to have this in the spec.
> 
> I dropped [1] given that [2] is landing shortly to IETF draft process,
> according to James Bottomley [3]. We will return to [1] as soon as draft
> process is open for comments. Still, that attribute is super important,
> and here is why.
> 
> This will cause a overhead as tpm2_unseal_trusted needs to do an
> unnecessary (from pure technical perspective) TPM2_ReadPublic command to
> acquire TPM name of the parent. This is obviously known at the time of
> creation of a key but the information is not stored anywhere by the
> key format.
> 
> It also aligns badly with TCG specifications as Table 6 of architecture
> spec explicitly defines a reference (or name) for transient keys,
> persistent keys and NV indexes to be TPM_ALG_ID concatenated together
> with the hash of TPMT_PUBLIC. I.e. the file format is using exactly
> the opposite what should be use as reference for keys than what it 
> should use.
> 
> Other benefits are of course auto-discovery of parent for a key file,
> which is nasty to do without the name pre-stored.

Right and TPMT_HA is calculated everytime when a trusted key is
created, and right after that the already calculated data is simply
thrown into dumpster. And we are talking about spec compliant way
to refer other keys here, and only 66 bytes of extra payload.

I don't get it. And neither do I get how anyone would want to fix 
this issue with TPM2_CreatePrimary interception.

BR, Jarkko

