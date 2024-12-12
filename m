Return-Path: <linux-integrity+bounces-4368-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C2F9EED62
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Dec 2024 16:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F25841660BB
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Dec 2024 15:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B972210D6;
	Thu, 12 Dec 2024 15:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="OOV9IzEh";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="OOV9IzEh"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B684F218;
	Thu, 12 Dec 2024 15:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734018106; cv=none; b=ara4FVfFVBcbtZqOL6ULjED9WcEHm1/uLL4zHYUPDsCY43qnRlHJrPL+4pEz1qTeO4BJ1XhI3XeZgV7wJmpCdGF6JDbTC7rwatX2yXcjZzN16MgNMk67xBfQuX5L7knl+OE3rrQWEiMm3ZapsP4cT1yhghJFtWpqHDQf+V6Ldu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734018106; c=relaxed/simple;
	bh=Y4hfRV5JAL5Zf/G0FNRWVrMda1GQ3RgDyZg7dpGJlgU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OKzmCHAm6XVY8INQKBkQ47qdfpyM8LmDOSxRYP5G/Syb703aADLwOiJWABAjdC/OV1Jq5sCrJ2SXbamjxmfI79HBcohKXOR0DTNbUV11yXCPln7pzvdmPhJuJYlg0oaPY9u6Hb1OPjfgnV1ZecAlo4CGFoiFlU8XqPmtBTDq1no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=OOV9IzEh; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=OOV9IzEh; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1734018103;
	bh=Y4hfRV5JAL5Zf/G0FNRWVrMda1GQ3RgDyZg7dpGJlgU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=OOV9IzEhgnfoak6Q87cxXM3y0LlIqY8ls0KitsjP4Mo2cf5qW8CuFMg/Tj3qTo+Nj
	 /NBbs0+U3PRRAnE8kQxkDfIamPHJWLKqnmZMOddlydhbu3ZkEsVvuUP57Yvt19x1m6
	 YxjWfOAKB8hHTw6j5QJiIVN9cmhb3NFpndfXzRAI=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id C1B14128B0C0;
	Thu, 12 Dec 2024 10:41:43 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id 7aKhnxa6fKry; Thu, 12 Dec 2024 10:41:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1734018103;
	bh=Y4hfRV5JAL5Zf/G0FNRWVrMda1GQ3RgDyZg7dpGJlgU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=OOV9IzEhgnfoak6Q87cxXM3y0LlIqY8ls0KitsjP4Mo2cf5qW8CuFMg/Tj3qTo+Nj
	 /NBbs0+U3PRRAnE8kQxkDfIamPHJWLKqnmZMOddlydhbu3ZkEsVvuUP57Yvt19x1m6
	 YxjWfOAKB8hHTw6j5QJiIVN9cmhb3NFpndfXzRAI=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 3F90E12801E8;
	Thu, 12 Dec 2024 10:41:42 -0500 (EST)
Message-ID: <d84a9a960e419cf8cbfd086e8210b6c4a112d04f.camel@HansenPartnership.com>
Subject: Re: [PATCH 1/3] tpm: add generic platform device
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Claudio Carvalho <cclaudio@linux.ibm.com>, Tom Lendacky
 <thomas.lendacky@amd.com>, linux-coco@lists.linux.dev, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Huewe
 <peterhuewe@gmx.de>, "H. Peter Anvin" <hpa@zytor.com>, 
 linux-integrity@vger.kernel.org, x86@kernel.org, Joerg Roedel
 <jroedel@suse.de>,  Jason Gunthorpe <jgg@ziepe.ca>, Jarkko Sakkinen
 <jarkko@kernel.org>,  linux-kernel@vger.kernel.org, Ingo Molnar
 <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Dov Murik
 <dovmurik@linux.ibm.com>, Oliver Steffen <osteffen@redhat.com>
Date: Thu, 12 Dec 2024 10:41:40 -0500
In-Reply-To: <cnq6nzhvrsas6ud7t4woybktpesepm7a3sq5sd5yldq4hr5kyl@ezm4xi3o7eax>
References: <20241210143423.101774-1-sgarzare@redhat.com>
	 <20241210143423.101774-2-sgarzare@redhat.com>
	 <zzi3fvbo2rnb2d76soseuekwaqe22ifnrhhjplqhvw6x26lbb4@nmcqylrenzyj>
	 <b92113a11f121dc4d485b5ba522c8c8c0781d1be.camel@HansenPartnership.com>
	 <cnq6nzhvrsas6ud7t4woybktpesepm7a3sq5sd5yldq4hr5kyl@ezm4xi3o7eax>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2024-12-12 at 16:30 +0100, Stefano Garzarella wrote:
> On Thu, Dec 12, 2024 at 09:35:46AM -0500, James Bottomley wrote:
> > On Thu, 2024-12-12 at 10:51 +0100, Stefano Garzarella wrote:
> > > On Tue, Dec 10, 2024 at 03:34:21PM +0100, Stefano Garzarella
> > > wrote:
> > [...]
> > > > +static int tpm_platform_recv(struct tpm_chip *chip, u8 *buf,
> > > > size_t len)
> > > > +{
> > > > +       struct tpm_resp *resp = (struct tpm_resp *)buffer;
> > > > +
> > > > +       if (resp->size < 0)
> > > > +               return resp->size;
> > > 
> > > While reviewing Oliver's work for the driver in edk2[1], I
> > > noticed that there wasn't this check and asked to add it, but
> > > talking to him and looking in the code/spec, we realized that
> > > it's strange that tpm_resp.size field is signed.
> > > 
> > >  From SVSM spec it looks like it can't be negative:
> > > 
> > >      Table 17: TPM_SEND_COMMAND Response Structure
> > > 
> > >      Byte     Size        Meaning
> > >      Offset   (Bytes)
> > >      0x000    4           Response size (in bytes)
> > >      0x004    Variable    Variable Response
> > > 
> > > And also Coconut SVSM remap it to the `responseSize` of the TCG
> > > TPM implementation which is unsigned:
> > > 
> > >      LIB_EXPORT void _plat__RunCommand(
> > >          uint32_t        requestSize,   // IN: command buffer size
> > >          unsigned char*  request,       // IN: command buffer
> > >          uint32_t*       responseSize,  // IN/OUT: response buffer
> > > size
> > >          unsigned char** response       // IN/OUT: response buffer
> > >      )
> > > 
> > > @James, @Claudio, @Tom, should we use u32 for tpm_resp.size?
> > 
> > The original idea was to allow the protocol to return an error
> > (like out of memory or something) before the command ever got to
> > the TPM rather than having to wrap it up in a TPM error.  However,
> > that's done in the actual return from the SVSM call, which the
> > sendrecv routine checks, so I agree this can be removed and a u32
> > done for the length.
> 
> Thanks for the details!
> I'll fix it in v2 and put a comment also in the edk2 PR.
> 
> > Dov did recommend we should check the returned length against the
> > maximum allowable:
> > 
> > https://lore.kernel.org/linux-coco/f7d0bd07-ba1b-894e-5e39-15fb1817bc8b@linux.ibm.com/
> 
> I added in this version the check he suggested:
> 
>         if (resp->size > TPM_PLATFORM_MAX_BUFFER - sizeof(*resp))
>                 return -EINVAL;  // Invalid response from the
> platform TPM
> 
> Were you referring to that?

Yes, the theory being that we're required to provide a buffer of this
length for the response, but if someone can inject a bogus response
they could induce us to copy beyond the end of the buffer we provided.

Regards,

James


