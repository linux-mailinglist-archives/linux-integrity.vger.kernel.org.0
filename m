Return-Path: <linux-integrity+bounces-6561-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 692AFAEA9B7
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Jun 2025 00:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 165BA17226C
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Jun 2025 22:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488DC21ADB9;
	Thu, 26 Jun 2025 22:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HX+eokZn"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DEE2F1FC9;
	Thu, 26 Jun 2025 22:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750977362; cv=none; b=mNXc1Uso0p8VIgkjuhjrP8F6bLqc2pLxaNVGowrLPIgVxMj3YrY1Vkl0piCr4cKVRLvhRqcrxjm1KHp0wpejGNPtJXkBDlRHnmwdMrY/jKV0zxG4sLplQrH0PfKTnx94HqBIMx2KYBnoETv2tVjPfmzkfrDo4PD4DvoX5OFYV6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750977362; c=relaxed/simple;
	bh=H1rfMDwf9pZjSftI60w8pVVvv8SLrC7CTgYtTp0yft0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DcpRpYe251rG9GkziKBboD+7PpxNICuya48f71n5sGVRMzV5RRaTDQwAbSFneekCP5PEM76Yssxvu5+E0AC//kJWH+Jr+9pgTkK70lwYJIiFX4NVFI/rnsjyk9dkeCMSWMnC5yUjksnRDbBEUS5d4fZjtN+7qtyPOGxg6zaGfa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HX+eokZn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18F2AC4CEEB;
	Thu, 26 Jun 2025 22:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750977361;
	bh=H1rfMDwf9pZjSftI60w8pVVvv8SLrC7CTgYtTp0yft0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HX+eokZntsqP0VcgXZBS6TfN95r9PfAMWyWcXOlK4FzVTWb1kA7RPcqgEEjUvksDu
	 00wyRrqXFqmZiLXjlsxT7hrDX5ZTERnVHUflQnzA01fO9ntKlTgLurEFxS3GuY1nLY
	 qgh5TjReihiDJOf3TteVgZnjtf/ah4LbmAoJGTZMmyG3bSlo1Z+prZomTUfwnaX2PV
	 bXhYGMuBVnnLAW/BPBhyi/AaW4cpGhDNvHfv2gEtoJ72JQ+CF4ZTZwRv7vEBB+YqO8
	 EFfmNrXRXs0ZjUVlmu9Npol1zjZsMdAS+OiuIWIFmhT4yISqaVasAQGwK9VPG+a5AC
	 OsKagqRrjko5w==
Date: Fri, 27 Jun 2025 01:35:57 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v2] tpm: Cleanup class for tpm_buf
Message-ID: <aF3LTXgI2uV6k2js@kernel.org>
References: <20250626101935.1007898-1-jarkko@kernel.org>
 <6a70dbdba3cef9f7ec580ce0147b1c89feb28074.camel@HansenPartnership.com>
 <aF2NNHilFfZwBoxA@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aF2NNHilFfZwBoxA@kernel.org>

On Thu, Jun 26, 2025 at 09:11:05PM +0300, Jarkko Sakkinen wrote:
> On Thu, Jun 26, 2025 at 10:50:22AM -0400, James Bottomley wrote:
> > On Thu, 2025-06-26 at 13:19 +0300, Jarkko Sakkinen wrote:
> > > From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> > > 
> > > Create a cleanup class for struct tpm_buf using DEFINE_CLASS(), which
> > > will guarantee that the heap allocated memory will be freed
> > > automatically for the transient instances of this structure, when
> > > they go out of scope.
> > > 
> > > Wrap this all into help macro CLASS_TPM_BUF().
> > > 
> > > A TPM buffer can now be declared trivially:
> > > 
> > >     CLASS_TPM_BUF(buf, buf_size);
> > 
> > Well, that's not all ... you're also adding a size to the API that we
> > didn't have before, which should at least be documented in the commit
> > message and probably be a separate patch.
> > 
> > What is the reason for this, though?  The reason we currently use a
> > page is that it's easy for the OS to manage (no slab fragmentation
> > issues).  The TCG reference platform defines this to be just under 4k
> > (actually 4096-0x80) precisely because TPM implementations don't do
> > scatter gather, so they don't want it going over an ARM page, so
> > there's no danger of us ever needing more than a page.
> 
> Thanks for the valuable feedback.
> 
> I can drop "buf_size" parameter. It is not a priority, and I also
> agree with your comments.

I also noticed that I had changed one log message in tpm2-sessions.c. It
was unintended i.e. a spurious change. I'll revert that one too.

I'll split this into more reasonable portions for next version so these
should be easier to review then.

BR, Jarkko

