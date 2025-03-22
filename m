Return-Path: <linux-integrity+bounces-5380-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E926A6CC2A
	for <lists+linux-integrity@lfdr.de>; Sat, 22 Mar 2025 21:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 704443A7EF8
	for <lists+linux-integrity@lfdr.de>; Sat, 22 Mar 2025 20:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F7C1DDA1E;
	Sat, 22 Mar 2025 20:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJ7Qyioq"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067754C6C;
	Sat, 22 Mar 2025 20:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742674628; cv=none; b=OlohidXNuYeQxvHA4Jnly2A+LLinp63rt+09wUJMXig9A1Xrg/4s99w1opc5rhTFw+kCXaB5fYwng01srFFXd3epPEUzTFJfzjxbeW67AwnTT6hJlu5sHhIO6ooK0JcwUDYGwms+HexbeA9ZczwjqlmZ7nszvaYosQqZve8ff3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742674628; c=relaxed/simple;
	bh=CbPGXZSRddE8tuYZ2t+93jHASg0DsRREKTOYcW5uStc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5Hx2EyGDTb6i/oINniBnHNhSFyJc0LoEOsxXNzcWqrs8XG7EFP3gINbL6fWDegxW2A/5pnj6TRu5j5foGSsq5m5Bca0bQDUPptRjLA2fuUlezFLdZzDo8o7Ta04VFSzHJP+jDdAgOSwAqxoDNAdgOmnuU+B+lvs8EiY5z7rhhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJ7Qyioq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D1F8C4CEDD;
	Sat, 22 Mar 2025 20:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742674627;
	bh=CbPGXZSRddE8tuYZ2t+93jHASg0DsRREKTOYcW5uStc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jJ7QyioqHtC4meGbFzh8pnXG/Ic4GpqbDmVvI2sIHyYtiysvIYgegNVrV62vv70nM
	 yYDBN5LvCXtGKE5UNach+zw0aURrml7OacAI+W2h2PN9vL1ib8Sgg2I8GvEGF6kjS0
	 R7/68SzkS+yqegyMZhpi50OO0CGkdxwQx79QaoKUoW8lrqeh9PddGcfy1NdrAvmhyL
	 qlMjomnbyEWs7wPKc0WeVxoUR96+M71l93RlWe8zaGAI+hNu+toSs5DjMNIFeUt/9M
	 rW0cANLP4tkJP8L+R4wQL5fcsoynfhhwm7skjmzeuoHxGMO1N+dU7VrIjCS8YpvNm9
	 YS52ci7lpG3mw==
Date: Sat, 22 Mar 2025 22:17:03 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org, Dov Murik <dovmurik@linux.ibm.com>,
	Dionna Glaze <dionnaglaze@google.com>, linux-coco@lists.linux.dev,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v3 1/4] x86/sev: add SVSM vTPM probe/send_command
 functions
Message-ID: <Z98av2cbURhSy6Rk@kernel.org>
References: <20250311094225.35129-1-sgarzare@redhat.com>
 <20250311094225.35129-2-sgarzare@redhat.com>
 <d7e5a1d2-5fcc-bf7f-a67d-7871a1627c98@amd.com>
 <Z9glWp6U6vyEmKQa@kernel.org>
 <7kuhiyy7gj4py323g5n2vy3ddlg666zwhtx3mjcklebgtlstdc@xgdyeecifwei>
 <Z9wuLVeP726Cssqp@kernel.org>
 <20250320171619.GOZ9xNY4W54avW2a-u@fat_crate.local>
 <Z9xQw8QpRKk26G6R@kernel.org>
 <rspkz663fg7i7jomvg5ehv3ldr6ayehttb7vgwwzsfsxafzb5y@uhqcadvsmw6f>
 <20250321220520.GFZ93ioO0JtfhXCb1n@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321220520.GFZ93ioO0JtfhXCb1n@fat_crate.local>

On Fri, Mar 21, 2025 at 11:05:20PM +0100, Borislav Petkov wrote:
> On Fri, Mar 21, 2025 at 10:01:17AM +0100, Stefano Garzarella wrote:
> > Just a note, patch 2 adds `include/linux/svsm_vtpm.h`, that file is
> > basically a translation of the AMD SVSM specification into structures and
> > functions used to communicate with SVSM in the way it is defined by the
> > specification.
> > 
> > I realized that the file does not fall under any section of MAINTAINERS.
> > How do you suggest we proceed?
> > 
> > Should we create an SVSM section to maintain it, including the TPM driver
> > and future other drivers,etc.?
> 
> This all belongs to the TPM drivers, right?
> 
> I.e., drivers/char/tpm/
> 
> So I guess add that header to the TPM DEVICE DRIVER section if the gents there
> are fine with it...

It's fine for me but I'd suggest to rename the header as "tpm_svsm.h".
Then this will already provide coverage:

https://web.git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/commit/?id=a2fbcecc7027944a2ce447d4dd72725c5822321f


> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
> 

BR, Jarkko

