Return-Path: <linux-integrity+bounces-5073-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDC6A4EA05
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Mar 2025 18:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D999A1650F7
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Mar 2025 17:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70AA4283699;
	Tue,  4 Mar 2025 17:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLlI11vX"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43556283695;
	Tue,  4 Mar 2025 17:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741109255; cv=none; b=aHl3cxbj+j7CfoousTPbMHtn8rKmWNHcL7C0H7/3A7TwtaLGmCu8LDH1wCQwGbhnGANMrsbkBtC7Gj4nso9bVXOQC3GIsw2N+t3LvfGdn4lKh8069zyax0uQmlFaUVYiqaviCJzOUilY3rHaUjc08HUn0YfL2JqSUUWfwCqjQlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741109255; c=relaxed/simple;
	bh=Z28VHjHcIMGjF7QPclk1fZqZmK04rbwR4LrYiI79iLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QNGQhBkQOiqWW9FU7Nqj/kXMi3pplkbGN64lR1HDUYArfll/3t/DJBuJfDgglYe13EimU8+GM30jJXtSxMYsLev8PknJ8nqO1PuqZ/c5/6yka2DAW8D7SZTm5T4x80IWHWZgcZv9bi9TpBfGble50vd78MJ7YyttGMDhNHVdj8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLlI11vX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12754C4CEE8;
	Tue,  4 Mar 2025 17:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741109254;
	bh=Z28VHjHcIMGjF7QPclk1fZqZmK04rbwR4LrYiI79iLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KLlI11vXZONgKcMZiIus4AdRR6dxmZvLmJMQLIdPFBQ19ZflHqyntwpZeT6JCOQpe
	 v46NLz+/x/tQtSHgI1L62hFroe1Wy//E6X02JAEY+gUiT+m811xplLVjQjiXYFq25q
	 CwkR6vKZVZNE16Y+YB0d0uml8MvFPOYJaFYe4M960IcmBKsZecPmd8JQYnAGYjFKPJ
	 eyHgnqyQftgNiKR4I5EtDm1ZQr7YvfRpewB5/NJiKTPojoisH09tVuki066BAWRJ2M
	 6tIhBXPgrW6/Q4FlWtpBSk8a5wySEo8w8IDa5k7jLLJG8K24FUM4hQJT8sFvH1frTO
	 zYGOdBuuKNJYw==
Date: Tue, 4 Mar 2025 19:27:30 +0200
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
Subject: Re: [RFC PATCH v2 5/6] tpm: add SNP SVSM vTPM driver
Message-ID: <Z8c4Avw2y7k4JODe@kernel.org>
References: <20250228170720.144739-1-sgarzare@redhat.com>
 <20250228170720.144739-6-sgarzare@redhat.com>
 <Z8JoMrUm9Dnoqgoi@kernel.org>
 <tpi74sl22zqngutzbqp7ajz7khwom2fgth2n3i77houwdqc3gl@obkhgfcagubh>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tpi74sl22zqngutzbqp7ajz7khwom2fgth2n3i77houwdqc3gl@obkhgfcagubh>

On Mon, Mar 03, 2025 at 05:46:16PM +0100, Stefano Garzarella wrote:
> On Sat, Mar 01, 2025 at 03:51:46AM +0200, Jarkko Sakkinen wrote:
> > On Fri, Feb 28, 2025 at 06:07:19PM +0100, Stefano Garzarella wrote:
> > > Add driver for the vTPM defined by the AMD SVSM spec [1].
> > > 
> > > The specification defines a protocol that a SEV-SNP guest OS can use to
> > > discover and talk to a vTPM emulated by the Secure VM Service Module (SVSM)
> > > in the guest context, but at a more privileged level (VMPL0).
> > > 
> > > The new tpm-svsm platform driver uses two functions exposed by x86/sev
> > > to verify that the device is actually emulated by the platform and to
> > > send commands and receive responses.
> > > 
> > > The vTPM is emulated through the TCG reference implementation, so this
> > > driver leverages tpm_tcgsim.h to fill commands and parse responses.
> > 
> > Why? Please don't.
> 
> You mean it's better not to have the external header and have all the
> functions here to prepare commands and parse responses?
> 
> As I mentioned, I did this because there may be other future drivers that
> could use it to talk to emulated devices in the same way, that is, through
> the TCG TPM reference implementation,

Sorry about harsh comment. I think we discussed this (MS simulator
caused confusion). Anchor this to SVSM spec and we're fine.

BR, Jarkko

