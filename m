Return-Path: <linux-integrity+bounces-5083-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AB9A4EE3F
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Mar 2025 21:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E19E218902A3
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Mar 2025 20:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C8F1F941B;
	Tue,  4 Mar 2025 20:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4B4IRRC"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3358D2E3377;
	Tue,  4 Mar 2025 20:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741119721; cv=none; b=K8hIV+jKiPdn8urUF8TsfEEJIB3SXA4bUTlsg/oENPFNd239OcbjwyNXXx0AwC7nXM1mzL4kz8vl95cH5lN92Uo2gQsC7yEhh67As2nVmV3xRQpPVpeKi0WkTI2K+7/XaMNz+2a4E8KypvxRuhXdT7mtHhy7ZHxO0APWdS2XuyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741119721; c=relaxed/simple;
	bh=v+zXX4gxemuvYPYz9gTEXXPj3dauyXTR1ZerFpHGJeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PWlPiXv8FshutgHqaC7yGkTL/W6BlyMSkzQbid5sXR3FP9Rpx3DmcUhHSDykbfy6zDClnEFhYbXPgvhArt7Zv7Qv1kG6VvLDJmfokGN6et79iUpRbuF7ybEkutp5pZgm/QObeLhQCsO2hvvSC4X1t49dgnravMPS8jI4eNwd1yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4B4IRRC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DE65C4CEE5;
	Tue,  4 Mar 2025 20:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741119720;
	bh=v+zXX4gxemuvYPYz9gTEXXPj3dauyXTR1ZerFpHGJeM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c4B4IRRCcNR5JaM1MBUhTbUHG4oSAj6i2aH9q6e1OsmPPsdqLSFU77dAaqt4KsK/H
	 AtMka3WMRkIk7Cxck41bsN5V2+8WcngCIKmnZPDW3GSUEOo1omoMLpKD8+MG/GQ1Jg
	 F3jtHqz6UiGtH/05GlEAwTR40CPiZHv6C3r9ZNZuTA45r76IEdU0g7oJkvzA5io2YP
	 RLGKJTXJWy7YsMMlDyxnphQYcvq22+dw3rKKdRKnIwqwc//MdZwb8LcAbOsf++kwZI
	 QmNrhWMY4bKE9WCyanL4dufi/+Bz+D3fon5pjw9vycpryXy9lOQ5EIYlXmz/D9kLJt
	 shh0s47V8V/Sw==
Date: Tue, 4 Mar 2025 22:21:55 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	Peter Huewe <peterhuewe@gmx.de>, x86@kernel.org,
	Dov Murik <dovmurik@linux.ibm.com>, linux-coco@lists.linux.dev,
	Dionna Glaze <dionnaglaze@google.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC PATCH v2 3/6] tpm: add send_recv() ops in tpm_class_ops
Message-ID: <Z8dg46Mj81Q9Z0WV@kernel.org>
References: <20250228170720.144739-1-sgarzare@redhat.com>
 <20250228170720.144739-4-sgarzare@redhat.com>
 <Z8Jmps6AF_geaHUw@kernel.org>
 <3p5erujbhxw7ozdnfpmresv3dqdh2xszolv6mh4khkagoy3wit@ow5qht4keh4h>
 <0e156883acf95d31b9358831550d6d675e3ce4ff.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e156883acf95d31b9358831550d6d675e3ce4ff.camel@kernel.org>

On Tue, Mar 04, 2025 at 06:56:02PM +0200, Jarkko Sakkinen wrote:
> On Mon, 2025-03-03 at 17:21 +0100, Stefano Garzarella wrote:
> > On Sat, Mar 01, 2025 at 03:45:10AM +0200, Jarkko Sakkinen wrote:
> > > On Fri, Feb 28, 2025 at 06:07:17PM +0100, Stefano Garzarella wrote:
> > > > +	int (*send_recv)(struct tpm_chip *chip, u8 *buf, size_t
> > > > buf_len,
> > > > +			 size_t to_send);
> > > 
> > > Please describe the meaning and purpose of to_send.
> > 
> > Sure, I'll add in the commit description.
> 
> It's always a command, right? So better be more concerete than
> "to_send", e.g. "cmd_len".
> 
> I'd do instead:
> 
> if (!chip->send)
> 	goto out_recv;
> 
> And change recv into:
> 
> int (*recv)(struct tpm_chip *chip, u8 *buf, size_t buf_len,
> 	    cmd_len);

I think I went here over the top, and *if* we need a new callback
putting send_recv would be fine. Only thing I'd take from this is to
rename to_len as cmd_len.

However, I don't think there are strong enough reasons to add complexity
to the callback interface with the basis of this single driver. You
should deal with this internally inside the driver instead.

So do something along the lines of, e.g.:

1. Create dummy send() copying the command to internal
   buffer.
2. Create ->status() returning zero, and set req_complete_mask and
   req_complete_val to zero.
3. Performan transaction in recv().

How you split send_recv() between send() and recv() is up to you. This
was merely showing that we don't need send_recv() desperately.

BR, Jarkko

