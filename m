Return-Path: <linux-integrity+bounces-4365-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0C29EE8FE
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Dec 2024 15:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BCC3188446F
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Dec 2024 14:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A792156EA;
	Thu, 12 Dec 2024 14:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="QvdsJ27z";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="QvdsJ27z"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4877421506B;
	Thu, 12 Dec 2024 14:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734014152; cv=none; b=IjS6CDUCqGrQLhXX8wUWuilrANZrYPWTnDzfLZPO9cUcHUK3B4rECBkT/+p5nmgWICVsl2fyKCsj5OJbGM6LF+14u1/scg4Zl80c/Y0/mWSE51yExrLTxugBYwLedNNsbDuXwwjChUXOgFhLEA0bacdhPzKzDY0JRBTQ7nFtvjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734014152; c=relaxed/simple;
	bh=/BRyeJOSctv9s1dQvG8sTNwD6gQGaxrOOiPNVZ+2V7Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kwT0VMjWbh9dPbeDX5dhAJjAv0KOHMaXg9ghVSYid9lURXQdlX9KRuUPS/ZKljZVtA7iLQgQdP9oGyqaei291rBA4cP8FR3vNjfNexp+xn+KIlvSELiPIE5nK5r7F7s25z/iynHTJ0R2Tv7jv3nlxRmZp94WK/4u5CZGZYqXyZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=QvdsJ27z; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=QvdsJ27z; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1734014149;
	bh=/BRyeJOSctv9s1dQvG8sTNwD6gQGaxrOOiPNVZ+2V7Q=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=QvdsJ27z5wkJCJ5m43ZyRYBnzb7b+SoX2jhwxvSLRL24QScwT0W6YeZt4C56j3YhO
	 eO8Q8rwjhEx2Rp0089mTePmHhllRLT6X/lJ+wWz3NMtgwqWRnsFEcMb/DJC4n/TVPx
	 jx166VNefKJRiDQFJ6Upoeh2u7CRYTepsIYgDZi0=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id E708312879AF;
	Thu, 12 Dec 2024 09:35:49 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id qTv-JLffv6fG; Thu, 12 Dec 2024 09:35:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1734014149;
	bh=/BRyeJOSctv9s1dQvG8sTNwD6gQGaxrOOiPNVZ+2V7Q=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=QvdsJ27z5wkJCJ5m43ZyRYBnzb7b+SoX2jhwxvSLRL24QScwT0W6YeZt4C56j3YhO
	 eO8Q8rwjhEx2Rp0089mTePmHhllRLT6X/lJ+wWz3NMtgwqWRnsFEcMb/DJC4n/TVPx
	 jx166VNefKJRiDQFJ6Upoeh2u7CRYTepsIYgDZi0=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 2BDBB1286F1F;
	Thu, 12 Dec 2024 09:35:48 -0500 (EST)
Message-ID: <b92113a11f121dc4d485b5ba522c8c8c0781d1be.camel@HansenPartnership.com>
Subject: Re: [PATCH 1/3] tpm: add generic platform device
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Claudio Carvalho
	 <cclaudio@linux.ibm.com>, Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-coco@lists.linux.dev, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, Peter Huewe <peterhuewe@gmx.de>, "H. Peter
 Anvin" <hpa@zytor.com>, linux-integrity@vger.kernel.org, x86@kernel.org,
 Joerg Roedel <jroedel@suse.de>, Jason Gunthorpe <jgg@ziepe.ca>, Jarkko
 Sakkinen <jarkko@kernel.org>, linux-kernel@vger.kernel.org, Ingo Molnar
 <mingo@redhat.com>,  Thomas Gleixner <tglx@linutronix.de>, Dov Murik
 <dovmurik@linux.ibm.com>, Oliver Steffen <osteffen@redhat.com>
Date: Thu, 12 Dec 2024 09:35:46 -0500
In-Reply-To: <zzi3fvbo2rnb2d76soseuekwaqe22ifnrhhjplqhvw6x26lbb4@nmcqylrenzyj>
References: <20241210143423.101774-1-sgarzare@redhat.com>
	 <20241210143423.101774-2-sgarzare@redhat.com>
	 <zzi3fvbo2rnb2d76soseuekwaqe22ifnrhhjplqhvw6x26lbb4@nmcqylrenzyj>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2024-12-12 at 10:51 +0100, Stefano Garzarella wrote:
> On Tue, Dec 10, 2024 at 03:34:21PM +0100, Stefano Garzarella wrote:
[...]
> > +static int tpm_platform_recv(struct tpm_chip *chip, u8 *buf,
> > size_t len)
> > +{
> > +       struct tpm_resp *resp = (struct tpm_resp *)buffer;
> > +
> > +       if (resp->size < 0)
> > +               return resp->size;
> 
> While reviewing Oliver's work for the driver in edk2[1], I noticed
> that
> there wasn't this check and asked to add it, but talking to him and
> looking in the code/spec, we realized that it's strange that
> tpm_resp.size field is signed.
> 
>  From SVSM spec it looks like it can't be negative:
> 
>      Table 17: TPM_SEND_COMMAND Response Structure
> 
>      Byte     Size        Meaning
>      Offset   (Bytes)
>      0x000    4           Response size (in bytes)
>      0x004    Variable    Variable Response
> 
> And also Coconut SVSM remap it to the `responseSize` of the TCG TPM
> implementation which is unsigned:
> 
>      LIB_EXPORT void _plat__RunCommand(
>          uint32_t        requestSize,   // IN: command buffer size
>          unsigned char*  request,       // IN: command buffer
>          uint32_t*       responseSize,  // IN/OUT: response buffer
> size
>          unsigned char** response       // IN/OUT: response buffer
>      )
> 
> @James, @Claudio, @Tom, should we use u32 for tpm_resp.size?

The original idea was to allow the protocol to return an error (like
out of memory or something) before the command ever got to the TPM
rather than having to wrap it up in a TPM error.  However, that's done
in the actual return from the SVSM call, which the sendrecv routine
checks, so I agree this can be removed and a u32 done for the length. 
Dov did recommend we should check the returned length against the
maximum allowable:

https://lore.kernel.org/linux-coco/f7d0bd07-ba1b-894e-5e39-15fb1817bc8b@linux.ibm.com/

Regards,

James


