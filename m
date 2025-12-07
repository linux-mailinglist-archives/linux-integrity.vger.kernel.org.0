Return-Path: <linux-integrity+bounces-7838-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C30B1CAB30D
	for <lists+linux-integrity@lfdr.de>; Sun, 07 Dec 2025 10:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A44743003047
	for <lists+linux-integrity@lfdr.de>; Sun,  7 Dec 2025 09:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60884265CA6;
	Sun,  7 Dec 2025 09:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pCWGioPM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E50C56B81;
	Sun,  7 Dec 2025 09:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765099151; cv=none; b=MUxXLzLM5hmrKkgeIBuJohfDnt4EGB0yrqI+PCeaFOPzCs4PjPliQG87rQvxRV8RR3ClCd94zfssYkIDR8PLb8KdxTb+i1CHZ3Rrh8YFrEXt4hu0O9DuD6/X/10/xWV/iVg5DHkNH+cabs6/JQrmvOvPTAlo/tHvWfEvfZ2M5Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765099151; c=relaxed/simple;
	bh=d9eLrD5hmsaSD/vtZdQNsy7lSpT4kdLurFjoFbwzOSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t+DC/H+uV792oyATZaPRaK3RDDtPCux2hanCZeE7MltnH3jLSZaACLVVaakICl5jMqs/7cMdc3dgvNyhEm/G5GPy6XpEOmyS1VvKWoi4G6VlhTF/b/d8fUkEV7fpjlqqtl1CaLgXjVWJAtJlSMbj/ki/Mc4gTyrbBBloi6pmy9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pCWGioPM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31626C4CEFB;
	Sun,  7 Dec 2025 09:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765099150;
	bh=d9eLrD5hmsaSD/vtZdQNsy7lSpT4kdLurFjoFbwzOSY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pCWGioPMcQOb5hTP2EvNQYWRvJ2+mKrKrq/gdIwWSsgP996V3NZyp2Ue+Gk1mBxWS
	 n/VBOcnzbwsDk69iZuWLjxl5ycOOmm1DI8Iud7tevy0KOPhbsHwvUpTkPHEXHVT7UR
	 i/SM3s8MQKhhJffZoIACljiUhDrTCfBjN7SY/fVmcrJXKZ4IiaRLz+mICUqduNvrC+
	 6z3T2flWe7LabVtopp40PK2V7KXp5DvLHK13EQXGc6Us1pi9fsJXXfde0OTi6KgqGe
	 Rh/y6aJl3aBtC+86LTpxqrNBeJXUSEytfyapaAFvyjInx3U8/iz7pjjP5rOWU9RY+N
	 OcojLWBJZlqfg==
Date: Sun, 7 Dec 2025 11:19:06 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KEYS-TRUSTED" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH] KEYS: trusted: Re-orchestrate tpm2_read_public() calls
Message-ID: <aTVGiubK5EKitM9u@kernel.org>
References: <20251204223128.435109-1-jarkko@kernel.org>
 <aTIXOr3rpI9xufTl@kernel.org>
 <aTIsFJobEyISTO_y@kernel.org>
 <89d90617ba9b7a5eff1d5fad6bb9773033d3c18c.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <89d90617ba9b7a5eff1d5fad6bb9773033d3c18c.camel@HansenPartnership.com>

On Sun, Dec 07, 2025 at 03:33:17PM +0900, James Bottomley wrote:
> On Fri, 2025-12-05 at 02:49 +0200, Jarkko Sakkinen wrote:
> > On Fri, Dec 05, 2025 at 01:20:30AM +0200, Jarkko Sakkinen wrote:
> > > On Fri, Dec 05, 2025 at 12:31:27AM +0200, Jarkko Sakkinen wrote:
> > > > tpm2_load_cmd() and tpm2_unseal_cmd() use the same parent, and
> > > > calls to
> > > > tpm_buf_append_name() cause the exact same TPM2_ReadPublic
> > > > command to be
> > > > sent to the chip, causing unnecessary traffic.
> > > > 
> > > > 1. Export tpm2_read_public in order to make it callable from
> > > > 'trusted_tpm2'.
> > > > 2. Re-orchestrate tpm2_seal_trusted() and tpm2_unseal_trusted()
> > > > in order to
> > > >    halve the name resolutions required:
> > > > 2a. Move tpm2_read_public() calls into trusted_tpm2.
> > > > 2b. Pass TPM name to tpm_buf_append_name().
> > > > 2c. Rework tpm_buf_append_name() to use the pre-resolved name.
> > > > 
> > > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > 
> > > If ASN.1 blob would contain also name of the parent then zero
> > > tpm2_read_public() calls would be required i.e., the main
> > > bottleneck here inherits from the limitations of the file format
> > > itself.
> > 
> > Along the lines of attached patch.
> 
> Well firstly [6] is already being taken by the creation data proposal,
> so this would introduce an incompatibility between the kernel and the
> spec, but secondly, if you want something like this in the spec before
> it goes to the IETF you really need to propose it now.

What is the mailing list for the working group, or is this still
unclear as of today?

> 
> The problem with this particular addition is that it would be Linux
> Kernel specific.  All the current TSSs already do a cached read public
> under the covers when they add the session wrappings so the user facing
> API they expose has nowhere to insert (or easily extract) a name field
> and thus TSS based implementations would have no incentive to either
> output or consume this field.  That's not to say the standard can't
> have additions for crazy or niche use cases (that's what the rsaParent
> flag is: a one off to support a niche SUSE use case) but it would be
> hard to persuade user implementations to do this so the kernel would
> have to interoperate with the case where it didn't exist anyway.

It is just matter of conditionally calling tpm2_read_public(). Not
a big deal.

> 
> The standard use today is with permanent handles for parents, where the
> parent is created on the fly, so the name is actually returned from
> TPM2_CreatePrimary for this use case.  It should be a simple matter to
> bring the kernel implementation up to doing this as well.

Intercepting TPM2_CreatePrimary does not provide full coverage, as
it does not address persistent keys, which kernel interface does
support.

> 
> Regards,
> 
> James
>   
> 

BR, Jarkko

