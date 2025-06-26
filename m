Return-Path: <linux-integrity+bounces-6551-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EEEAEA4EE
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Jun 2025 20:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FDD51C283C6
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Jun 2025 18:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A7F2ECE81;
	Thu, 26 Jun 2025 18:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FkO822WF"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67F31AAA1E;
	Thu, 26 Jun 2025 18:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750961465; cv=none; b=k9ISqaw5KVpUMw2Ajp7LkemNhxO+ijEOkJeZ8oEZYtVXcFa2ZWjrbiBSgsbriFWmb+jeEEXy8kdtnsWzmXMTMzKswH6/60stB1rppavJD0caZgvN5QRljvMWYq2MYif6AKFHXD1jn4HByqva/XwsdlyLw0n2P3Z209sL/t6u/2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750961465; c=relaxed/simple;
	bh=PxAcIrqmGmqwU3Y8X7ft3eKTZBKCnF5idEDFJGKQBqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kGcTUzmp6veVYX1b9QaE2d7T3yeD9tmRkuZE1Mq5u/CHGOcc0ZBFrSfDOi5ALSc7F8uIPCLuUAzVO586po76bV2lfiUMJkWUiMgmV/UNWAoVLpIOJklIfT3BhqbAFDva6vXuzZxVQNJVjlej5rjLKU9qj+fUy2uj7TESjocf+2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FkO822WF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF81AC4CEEB;
	Thu, 26 Jun 2025 18:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750961465;
	bh=PxAcIrqmGmqwU3Y8X7ft3eKTZBKCnF5idEDFJGKQBqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FkO822WFqYKKTkPqWs0+pa9rfGkGnpqmaKhPmb4Jk9ec2PRiDnJQPjxNy59VX48MV
	 4oQjoD8Zs8ZxwP3kLlSnT7VcLWMsnNt6ljhoCibRdIWKL4z8CPL7DQoDNXD7SI23Og
	 vexcA+5QBmKZJIpqiMMqaS3VITE6HtzpSjIK4os5E6ICTb7t6JDKj56101LBTgbb36
	 9nOpLE9cacP2QCxMLSyzOVxZPI/3+QcUlNzs3Yx1ZkZjhVZD5G6r2/GfDHQ5ooPPCi
	 vqkOi1NP9UDIvTZfYSoGwk5CPn3JQUSnaUGyz1KCj3mdm962f7Tc4p4VW8AW01ig6b
	 1QZvx5m/m4Q1w==
Date: Thu, 26 Jun 2025 21:11:00 +0300
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
Message-ID: <aF2NNHilFfZwBoxA@kernel.org>
References: <20250626101935.1007898-1-jarkko@kernel.org>
 <6a70dbdba3cef9f7ec580ce0147b1c89feb28074.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6a70dbdba3cef9f7ec580ce0147b1c89feb28074.camel@HansenPartnership.com>

On Thu, Jun 26, 2025 at 10:50:22AM -0400, James Bottomley wrote:
> On Thu, 2025-06-26 at 13:19 +0300, Jarkko Sakkinen wrote:
> > From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> > 
> > Create a cleanup class for struct tpm_buf using DEFINE_CLASS(), which
> > will guarantee that the heap allocated memory will be freed
> > automatically for the transient instances of this structure, when
> > they go out of scope.
> > 
> > Wrap this all into help macro CLASS_TPM_BUF().
> > 
> > A TPM buffer can now be declared trivially:
> > 
> >     CLASS_TPM_BUF(buf, buf_size);
> 
> Well, that's not all ... you're also adding a size to the API that we
> didn't have before, which should at least be documented in the commit
> message and probably be a separate patch.
> 
> What is the reason for this, though?  The reason we currently use a
> page is that it's easy for the OS to manage (no slab fragmentation
> issues).  The TCG reference platform defines this to be just under 4k
> (actually 4096-0x80) precisely because TPM implementations don't do
> scatter gather, so they don't want it going over an ARM page, so
> there's no danger of us ever needing more than a page.

Thanks for the valuable feedback.

I can drop "buf_size" parameter. It is not a priority, and I also
agree with your comments.

> 
> Regards,
> 
> James

BR, Jarkko

