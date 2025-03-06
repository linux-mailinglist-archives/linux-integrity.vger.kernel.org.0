Return-Path: <linux-integrity+bounces-5147-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B295A55983
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Mar 2025 23:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15BD23AF658
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Mar 2025 22:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE46A276D25;
	Thu,  6 Mar 2025 22:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XSJdZh+G"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B9F206F18;
	Thu,  6 Mar 2025 22:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741299339; cv=none; b=XxZFEs3pKO8r8lbtmhwnsuke9jPuhirxWisWwlipOdEM9Y2dzrFXee33Oav45Te9Jw0qcNxwdaPfctzksOU5Z5NlLJFcVUWvDabNBfs/uPwH+KB5vYShlwQSaxbxJYIMDJ3WaWpUJFCpa5wBw6p4nhGHot6TSznd2vrhvfaUiKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741299339; c=relaxed/simple;
	bh=U44FBg9DYbght3ythigprQZcSpstgrbOFTLWPe8Mp5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ur+vdxaPc6AdXRsu8xpncpUXgwpfUlg0dFacMa89YEV4+TZqxnyw0XgE19PZXjHHDuMd828ngbjYbwe8+Hjf2pCWySMY77f9Cl37/xzXLOAHXpPG4GWHN6GFigyEQ5avYfBRZjZjFSjaHs5n93qA2UKssqFV4+laf3OjIIgViYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XSJdZh+G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8C7DC4CEE0;
	Thu,  6 Mar 2025 22:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741299339;
	bh=U44FBg9DYbght3ythigprQZcSpstgrbOFTLWPe8Mp5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XSJdZh+G7Cf4fjIp6ZYJXGRRRYA+fQ5/brfWKxR/BTPM36cnEu861v5hVMj/pfkjT
	 MbMSHjqbxGDrfLhSRrFebmowdHihYYg0YEw13/WImwG4HG7Eayi4jxPjrvwN0MsY0L
	 51E16wj1edpqKHWZc9ZROS4a++NW4UBgx0XPPE7yCccOq1oCOXcrR+T4AWXleTfI8J
	 KsaQdYGcjGmEkw8Say/9fjxFkqr60LZYONOKHXA12Qe4R9cOoGGQe1XCuf2XmP5Dve
	 9/fk+/wIC7wrGhmrei9xmsBZ3IZR+qH2hk+XM7b4PHel7anRW7vmZVYqwnzJS2NSNF
	 BoS7wRPkubqWg==
Date: Fri, 7 Mar 2025 00:15:34 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Thomas Gleixner <tglx@linutronix.de>,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	Peter Huewe <peterhuewe@gmx.de>, x86@kernel.org,
	Dov Murik <dovmurik@linux.ibm.com>, linux-coco@lists.linux.dev,
	Dionna Glaze <dionnaglaze@google.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC PATCH v2 3/6] tpm: add send_recv() ops in tpm_class_ops
Message-ID: <Z8oehuPVMXbgjAxz@kernel.org>
References: <20250228170720.144739-1-sgarzare@redhat.com>
 <20250228170720.144739-4-sgarzare@redhat.com>
 <Z8Jmps6AF_geaHUw@kernel.org>
 <3p5erujbhxw7ozdnfpmresv3dqdh2xszolv6mh4khkagoy3wit@ow5qht4keh4h>
 <0e156883acf95d31b9358831550d6d675e3ce4ff.camel@kernel.org>
 <Z8dg46Mj81Q9Z0WV@kernel.org>
 <jkr5z4thb55gs2jcmtcfipgg6p7z6ikhr6etd6l3nqpf723hf7@3fns3z5cjqk4>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jkr5z4thb55gs2jcmtcfipgg6p7z6ikhr6etd6l3nqpf723hf7@3fns3z5cjqk4>

On Wed, Mar 05, 2025 at 10:04:25AM +0100, Stefano Garzarella wrote:
> On Tue, Mar 04, 2025 at 10:21:55PM +0200, Jarkko Sakkinen wrote:
> > On Tue, Mar 04, 2025 at 06:56:02PM +0200, Jarkko Sakkinen wrote:
> > > On Mon, 2025-03-03 at 17:21 +0100, Stefano Garzarella wrote:
> > > > On Sat, Mar 01, 2025 at 03:45:10AM +0200, Jarkko Sakkinen wrote:
> > > > > On Fri, Feb 28, 2025 at 06:07:17PM +0100, Stefano Garzarella wrote:
> > > > > > +	int (*send_recv)(struct tpm_chip *chip, u8 *buf, size_t
> > > > > > buf_len,
> > > > > > +			 size_t to_send);
> > > > >
> > > > > Please describe the meaning and purpose of to_send.
> > > >
> > > > Sure, I'll add in the commit description.
> > > 
> > > It's always a command, right? So better be more concerete than
> > > "to_send", e.g. "cmd_len".
> 
> Right!
> 
> > > 
> > > I'd do instead:
> > > 
> > > if (!chip->send)
> > > 	goto out_recv;
> > > 
> > > And change recv into:
> > > 
> > > int (*recv)(struct tpm_chip *chip, u8 *buf, size_t buf_len,
> > > 	    cmd_len);
> > 
> > I think I went here over the top, and *if* we need a new callback
> > putting send_recv would be fine. Only thing I'd take from this is to
> > rename to_len as cmd_len.
> 
> Got it.
> 
> > 
> > However, I don't think there are strong enough reasons to add complexity
> > to the callback interface with the basis of this single driver. You
> > should deal with this internally inside the driver instead.
> > 
> > So do something along the lines of, e.g.:
> > 
> > 1. Create dummy send() copying the command to internal
> >   buffer.
> > 2. Create ->status() returning zero, and set req_complete_mask and
> >   req_complete_val to zero.
> > 3. Performan transaction in recv().
> > 
> > How you split send_recv() between send() and recv() is up to you. This
> > was merely showing that we don't need send_recv() desperately.
> 
> We did something similar in v1 [1], but instead of your point 2, we just set
> `chip->flags |= TPM_CHIP_FLAG_IRQ;` in the probe() after we allocated the
> chip.
> 
> Jason suggested the send_recv() ops [2], which I liked, but if you prefer to
> avoid that, I can restore what we did in v1 and replace the
> TPM_CHIP_FLAG_IRQ hack with your point 2 (or use TPM_CHIP_FLAG_IRQ if you
> think it is fine).
> 
> @Jarkko, @Jason, I don't have a strong preference about it, so your choice
> :-)

I'd say, unless you have actual identified blocker, please go with
a driver where the complexity is managed within the driver.

> 
> Thanks,
> Stefano
> 
> [1] https://lore.kernel.org/linux-integrity/20241210143423.101774-2-sgarzare@redhat.com/
> [2] https://lore.kernel.org/linux-integrity/CAGxU2F51EoqDqi6By6eBa7qT+VT006DJ9+V-PANQ6GQrwVWt_Q@mail.gmail.com/


BR, Jarkko

