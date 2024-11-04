Return-Path: <linux-integrity+bounces-4011-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A209BB3C8
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Nov 2024 12:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7933F1C211CC
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Nov 2024 11:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128A61B21AF;
	Mon,  4 Nov 2024 11:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dDZHcWCC"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFB51B0F2C;
	Mon,  4 Nov 2024 11:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730720840; cv=none; b=P8azDktK3LIDDOnl4VAevHxYTnI7RUDGEdUpDDJFoLk9PbbvamocGBn/PHNnndbAtcPXcLObLaje/TaOECGbNBveESvgylVsOirwfbqcRB+XSxfn2NN5mOdSv9U5cpPW1AocIdwp6ulqEsbz2x0fof+u3rJiDw81V+gUa9Iwzf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730720840; c=relaxed/simple;
	bh=MrZ3jPCIRs3oxdcsqPmsna3mUN7Tl+hPWvs4gZVJGYM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=CWNBKCxAPrpVtTubaLY9NWgH9ragPQy/Q7daSv3mCOhdanLHKm3yPQttXnJsHmUJvm+Ycm2o/9/lN1AywSciHqlpvmaSiCSshGXTqPkEe5cebLqbjK34QzQQU0TLfqwYqMVsk8zLUEDgjcFQk3r2BA/5y+yO5lPWLgrO0wojils=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dDZHcWCC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 518E4C4CED1;
	Mon,  4 Nov 2024 11:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730720839;
	bh=MrZ3jPCIRs3oxdcsqPmsna3mUN7Tl+hPWvs4gZVJGYM=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=dDZHcWCCdzRJUVuv0I6KxnSfG6hnWnlBT87cQ7aO5sW436myXIKmPh9Wc5yWrfE8J
	 9fla5qD7e07y23YWg9d0OUFNEdIZvoSLD79VnmmGTQmIkGciY1YVbAIkENKBNtIRAf
	 XK+KoV5KuvedjFkHKt2yk0kdnt6svjI70ljYOyoOGtl4+cX/PwyPdFi+yQ9TA6bhYL
	 PTZnQKLTtuCfgAdNgGuMyj+nOM6J83qiJ4NSaHGC5MA7BElKB+pZMYPI92mZbGiCeg
	 Y5FdQu9ehdc8pFw48fZSs3ldFIJjrTGr/qd/yl++bbspwulGm1SL+3jbfBxRp7i4vR
	 D0QfIKG6E4M7w==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 04 Nov 2024 13:47:15 +0200
Message-Id: <D5DDBZEIMMUR.1ZIY3TRJRMPKO@kernel.org>
Cc: "Daniel P. Smith" <dpsmith@apertussolutions.com>, <x86@kernel.org>,
 "Ross Philipson" <ross.philipson@oracle.com>, "Thomas Gleixner"
 <tglx@linutronix.de>, "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe"
 <jgg@ziepe.ca>, "open list:TPM DEVICE DRIVER"
 <linux-integrity@vger.kernel.org>, "open list"
 <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/4] Alternative TPM patches for Trenchboot
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Ard Biesheuvel" <ardb@kernel.org>
X-Mailer: aerc 0.18.2
References: <20241102152226.2593598-1-jarkko@kernel.org>
 <D5BW0P0HH0QL.7Y4HBLJGEDL8@kernel.org>
 <e745226d-4722-43ed-86ad-89428f56fcba@apertussolutions.com>
 <D5DCPWBQ2M7H.GAUEVUKGC3G0@kernel.org>
 <CAMj1kXGd5KAXiFr3rEq3cQK=_970b=eRT4X6YKVSj2PhN6ACrw@mail.gmail.com>
In-Reply-To: <CAMj1kXGd5KAXiFr3rEq3cQK=_970b=eRT4X6YKVSj2PhN6ACrw@mail.gmail.com>

On Mon Nov 4, 2024 at 1:27 PM EET, Ard Biesheuvel wrote:
> On Mon, 4 Nov 2024 at 12:18, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > On Mon Nov 4, 2024 at 12:57 PM EET, Daniel P. Smith wrote:
> > > On 11/2/24 14:00, Jarkko Sakkinen wrote:
> > > > On Sat Nov 2, 2024 at 5:22 PM EET, Jarkko Sakkinen wrote:
> > > >> It is not really my problem but I'm also wondering how the
> > > >> initialization order is managed. What if e.g. IMA happens to
> > > >> initialize before slmodule?
> > > >
> > > > The first obvious observation from Trenchboot implementation is tha=
t it
> > > > is 9/10 times worst idea ever to have splitted root of trust. Here =
it
> > > > is realized by an LKM for slmodule.
> > >
> > > First, there is no conflict between IMA and slmodule. With your chang=
e
> > > to make locality switching a one shot, the only issue would be if IMA
> > > were to run first and issue a locality switch to Locality 0, thus
> > > blocking slmodule from switching to Locality 2. As for PCR usage, IMA
> > > uses the SRTM PCRs, which are completely accessible under Locality 2.
> >
> > Just pointing out a possible problem (e.g. with  TPM2_PolicyLocality).
> >
> > > Honestly, a better path forward would be to revisit the issue that is
> > > driving most of that logic existing, which is the lack of a TPM
> > > interface code in the setup kernel. As a reminder, this issue is due =
to
> > > the TPM maintainers position that the only TPM code in the kernel can=
 be
> > > the mainline driver. Which, unless something has changed, is impossib=
le
> > > to compile into the setup kernel due to its use of mainline kernel
> > > constructs not present in the setup kernel.
> >
> > I don't categorically reject adding some code to early setup. We have
> > some shared code EFI stub but you have to explain your changes
> > proeprly. Getting rejection in some early version to some approach,
> > and being still pissed about that years forward is not really way
> > to go IMHO.
> >
>
> Daniel has been nothing but courteous and patient, and you've waited
> 11 revision to come up with some bikeshedding patches that don't
> materially improve anything.
>
> So commenting on Daniel's approach here is uncalled for.
>
> Can we please converge on this?
>
> Daniel - if no component can be built as a module, there should be no
> reason for the set_default_locality() hook to be exported to modules
> right? And do we even need a sysfs node to expose this information?

I provided patches with my sob's and spent time on making the delta
absolute minimal to what exists already. If those are picked, I'm
good. They are essentially drop-in replicas to the existing patches.

BR, Jarkko

