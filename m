Return-Path: <linux-integrity+bounces-4009-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6568E9BB35C
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Nov 2024 12:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27F29284F79
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Nov 2024 11:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67ECC1B393B;
	Mon,  4 Nov 2024 11:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kBCU5f19"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6771B21AF;
	Mon,  4 Nov 2024 11:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730719660; cv=none; b=VDEkcNAKIJ858PJWbxwjqWNI155wnnokGnxd/Qpt9GrA0w3rB1FZNn0V8dp4lJPJaiTv//YbAuu9xSVuLSAe94ruQjjUPXSusdwTwYX62CxYNKZw64Qzg2sQCtAHGZTIOohPnyKSJOHlaURSZIrgdW1fc+xaiGC4MP9WWMdV6sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730719660; c=relaxed/simple;
	bh=Q0oHyC5HFwQtHnr3tahD/Xozp4rdR/kHqgtAU1qaQwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sTULC/dcR7HonxT+FtvLyJhfBarIHXckrv8I2HQFgPsTAmwN+J6UhgplrDGp9YsU2ip+sSHbcUdwlqp5AJDAesn/7rKrg38WjGyydGzlBSZH4qiCHDTFsscIGNpOnknaKD6GQC9Ywbh9Ezxgjy9EwWYC0OvsQlQTKOZ09kAbVK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kBCU5f19; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE546C4CED1;
	Mon,  4 Nov 2024 11:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730719659;
	bh=Q0oHyC5HFwQtHnr3tahD/Xozp4rdR/kHqgtAU1qaQwo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kBCU5f19ECTzy9hRq7MsIYZ0NJ5jvwWoDRQTrjY88d3uIHkQD3/ut4jBUcLFOKHLq
	 P+7+G5UzPPG0pTZj6e/ofteRdgCepmDKEeKve/6rEgmdK64ulCrvcfKhSqnoJoNpUW
	 kbkNlycqs9IADd3hC8BGXajQsaB9LxIt9U3NgEXcoMZHHD4YdRNHdDSnWKMac7DAcP
	 jm0eAnMhxI6Dx4vqK4N/v7mIzPR6fqR+2XsGDywF9jh6nWzOa980V6AFt4RChT9hCk
	 xNeXlHSIlIYBrlM3AYxfSdxdR8XCwlliFlIkH7j2nfevLYtZnCigkcrqSkpnO7BtOD
	 Od4oBqnfeWu/A==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539f4d8ef84so5251923e87.0;
        Mon, 04 Nov 2024 03:27:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW4oTvSMZ1dbujtzc/MUBc03JiLoZ8+uYcEgqnG2MH2kqiLv6XEwH7TiZUk9C4U2u4a4CghuKk5eRfqzG1c@vger.kernel.org, AJvYcCWUc5yMctT/lTxpPXLYupstr3jZP1u54Y0aK1VIYTP7nA9rWmysKtb2uPuvTz03nyN8RiJgss9ahDBqHp1QkrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzudnN87zFGf1VOZuvToo6CGFvcC2m0Z95E0bgqj0RDsbT6LY+y
	pRYvIdx5X6nivuZ5f3JWj4u0wCGqEJJBM5muDsPdsLChHQ5lzq36npkTpLOPlzJmw8IGDREQbhH
	f1cQ/hPTVBGX0U/HrB1tlob7+8Eo=
X-Google-Smtp-Source: AGHT+IFdvw0jqvwZDocTHlobM+8JX4jnwc2ccfnmUN8Bw+DRPfsZrTSFKld5E8msl1vzuiUzbFwWqAbSrpxMn8zwp1M=
X-Received: by 2002:a05:6512:15a5:b0:539:f7de:df84 with SMTP id
 2adb3069b0e04-53c79e15806mr7101954e87.10.1730719658212; Mon, 04 Nov 2024
 03:27:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241102152226.2593598-1-jarkko@kernel.org> <D5BW0P0HH0QL.7Y4HBLJGEDL8@kernel.org>
 <e745226d-4722-43ed-86ad-89428f56fcba@apertussolutions.com> <D5DCPWBQ2M7H.GAUEVUKGC3G0@kernel.org>
In-Reply-To: <D5DCPWBQ2M7H.GAUEVUKGC3G0@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 4 Nov 2024 12:27:26 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGd5KAXiFr3rEq3cQK=_970b=eRT4X6YKVSj2PhN6ACrw@mail.gmail.com>
Message-ID: <CAMj1kXGd5KAXiFr3rEq3cQK=_970b=eRT4X6YKVSj2PhN6ACrw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] Alternative TPM patches for Trenchboot
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: "Daniel P. Smith" <dpsmith@apertussolutions.com>, x86@kernel.org, 
	Ross Philipson <ross.philipson@oracle.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	"open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Nov 2024 at 12:18, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Mon Nov 4, 2024 at 12:57 PM EET, Daniel P. Smith wrote:
> > On 11/2/24 14:00, Jarkko Sakkinen wrote:
> > > On Sat Nov 2, 2024 at 5:22 PM EET, Jarkko Sakkinen wrote:
> > >> It is not really my problem but I'm also wondering how the
> > >> initialization order is managed. What if e.g. IMA happens to
> > >> initialize before slmodule?
> > >
> > > The first obvious observation from Trenchboot implementation is that it
> > > is 9/10 times worst idea ever to have splitted root of trust. Here it
> > > is realized by an LKM for slmodule.
> >
> > First, there is no conflict between IMA and slmodule. With your change
> > to make locality switching a one shot, the only issue would be if IMA
> > were to run first and issue a locality switch to Locality 0, thus
> > blocking slmodule from switching to Locality 2. As for PCR usage, IMA
> > uses the SRTM PCRs, which are completely accessible under Locality 2.
>
> Just pointing out a possible problem (e.g. with  TPM2_PolicyLocality).
>
> > Honestly, a better path forward would be to revisit the issue that is
> > driving most of that logic existing, which is the lack of a TPM
> > interface code in the setup kernel. As a reminder, this issue is due to
> > the TPM maintainers position that the only TPM code in the kernel can be
> > the mainline driver. Which, unless something has changed, is impossible
> > to compile into the setup kernel due to its use of mainline kernel
> > constructs not present in the setup kernel.
>
> I don't categorically reject adding some code to early setup. We have
> some shared code EFI stub but you have to explain your changes
> proeprly. Getting rejection in some early version to some approach,
> and being still pissed about that years forward is not really way
> to go IMHO.
>

Daniel has been nothing but courteous and patient, and you've waited
11 revision to come up with some bikeshedding patches that don't
materially improve anything.

So commenting on Daniel's approach here is uncalled for.

Can we please converge on this?

Daniel - if no component can be built as a module, there should be no
reason for the set_default_locality() hook to be exported to modules
right? And do we even need a sysfs node to expose this information?

