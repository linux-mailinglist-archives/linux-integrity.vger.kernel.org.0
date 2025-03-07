Return-Path: <linux-integrity+bounces-5178-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E96A56DBA
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Mar 2025 17:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 054BB3B11A3
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Mar 2025 16:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CE223A9A7;
	Fri,  7 Mar 2025 16:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gb8wy99Q"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AD221CC7B;
	Fri,  7 Mar 2025 16:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741365134; cv=none; b=it6Sqgvi9rehKFgd3uSZS6DG/hUFua/P2blKbdXMG5nfxBDuLdNC+V71IMK2/edDqtYGpZNxkkRVXPU94S1P40b2IQb94jax8wvOKHXtByAG9lBHCg75+KXPeItBaEnkgJBc+SFo/HDE+M7yhB93PE3KE7sQyQitSIEeJjlmMA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741365134; c=relaxed/simple;
	bh=Sm2u4lkW9WmjbUbfrUxh0xjfgPJJFZa6w+NyuKr9lJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bOocashLy8/TvayiJFVSEz0LBL+co4xTjaoqYyj78ZGLLxIBvYEOKxn1RELB8wNZ8wQ8tOGj2/EAS1vB+m2y1oXBtcn1CGz/YY6+zmTGxH7+s+K6beEhKXV2kbX6iVngIzioAcZn/2oCgIG3Hrbo6KqHT3SG0Ngj6ziI7rEm7co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gb8wy99Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4084AC4CED1;
	Fri,  7 Mar 2025 16:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741365133;
	bh=Sm2u4lkW9WmjbUbfrUxh0xjfgPJJFZa6w+NyuKr9lJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gb8wy99Qc6kqeeXN0aV5hFK0czGJZEoZK70atA8Arhc9mN247Fr0CgGSYZbK7BwuA
	 rX4UxHHouy1ukcLy9zX/I8JtmRsN02BUw3op93sTEaqaZTV9RNDgPacO5FhrbISqSV
	 Bn07pK6wchQO/8/IKk1JoWHvaaoyEVzwd6mxAQ6rSstQyZKp90Xap1XdvtSNKDCZ3o
	 OKGpsTrxn/LeIlFY5zLadLScHy3UmjBhwQJwFJq5mdgLRVBYFe0xntaWUn9B0Xma+q
	 hg7INV2MtqXhJcoZBMkpzz99TuHZq99x2Ga6Wf6mPbjhUQVe8LgiglY6Mj4g+hh9Tk
	 xFGCHeKjljABA==
Date: Fri, 7 Mar 2025 18:32:08 +0200
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
Message-ID: <Z8sfiDEhsG6RATiQ@kernel.org>
References: <20250228170720.144739-1-sgarzare@redhat.com>
 <20250228170720.144739-4-sgarzare@redhat.com>
 <Z8Jmps6AF_geaHUw@kernel.org>
 <3p5erujbhxw7ozdnfpmresv3dqdh2xszolv6mh4khkagoy3wit@ow5qht4keh4h>
 <0e156883acf95d31b9358831550d6d675e3ce4ff.camel@kernel.org>
 <Z8dg46Mj81Q9Z0WV@kernel.org>
 <jkr5z4thb55gs2jcmtcfipgg6p7z6ikhr6etd6l3nqpf723hf7@3fns3z5cjqk4>
 <20250305190229.GC354403@ziepe.ca>
 <Z8oZLqn4p2-AWQbz@kernel.org>
 <fgxwcfm6fctdsjnzdbf3ecxss453dir3pgaqio7bzazjj5qotj@mdi6wtuzorvn>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fgxwcfm6fctdsjnzdbf3ecxss453dir3pgaqio7bzazjj5qotj@mdi6wtuzorvn>

On Fri, Mar 07, 2025 at 04:37:12PM +0100, Stefano Garzarella wrote:
> On Thu, Mar 06, 2025 at 11:52:46PM +0200, Jarkko Sakkinen wrote:
> > On Wed, Mar 05, 2025 at 03:02:29PM -0400, Jason Gunthorpe wrote:
> > > On Wed, Mar 05, 2025 at 10:04:25AM +0100, Stefano Garzarella wrote:
> > > > Jason suggested the send_recv() ops [2], which I liked, but if you prefer to
> > > > avoid that, I can restore what we did in v1 and replace the
> > > > TPM_CHIP_FLAG_IRQ hack with your point 2 (or use TPM_CHIP_FLAG_IRQ if you
> > > > think it is fine).
> > > 
> > > I think it is a pretty notable simplification for the driver as it
> > > does not need to implement send, status, req_canceled and more ops.
> > > 
> > > Given the small LOC on the core side I'd call that simplification a
> > > win..
> > 
> > I'm sorry to disagree with you on this but adding a callback for
> > one leaf driver is not what I would call "a win" :-)
> 
> IIUC in the ftpm driver (tpm_ftpm_tee.c) we could also use send_recv() and
> save a memcpy() to a temporally buffer (pvt_data->resp_buf) and also that 4k
> buffer allocated with the private data of the driver.
> 
> BTW if you agree, for now I'll do something similar of what we do in the
> ftpm driver (which would be what Jarkko recommended - status() returns 0,
> .req_complete_mask = 0, .req_complete_val = 0) and we can discuss
> send_recv() in a new series where I can include changes for the ftpm driver
> too, to see whether it makes sense or not.
> 
> WDYT?

Yeah, that would work. Althought not related to this callback interface
per se, also tpm-dev-common.c is one example (in a way).

> 
> Thanks,
> Stefano

BR, Jarkko

