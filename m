Return-Path: <linux-integrity+bounces-5876-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E34EA891DA
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Apr 2025 04:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCCC81897202
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Apr 2025 02:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2683520A5C4;
	Tue, 15 Apr 2025 02:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="UOBF5qgU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946AA1FDE0E;
	Tue, 15 Apr 2025 02:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744684168; cv=none; b=nafFkf8cY9l+oSfaEsHTVyhXmAEl+fL0iZXUT1olhHB8tLy/xNgieBvlH5I50q0hk+szCM4LTCxlhytpmXx7I9QYGJyAu6qO2bblf51s2httSEOSURXvGSL1KPqbZPY79q/QZ/uAAPgjJhaOdsXj2xk44d5c/RNBVCcOdEq1hGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744684168; c=relaxed/simple;
	bh=IKU6Qb+kBzJ54L019CZz25CsicBiV3uCHWGimerKnJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=msAtpNt1rK6A2RAOjP7VUakF3pDmqdxb4aXDb58FMtEYfvntjlKMfbMC2C0lAPRueXvFuw2PxDLJ9OqReEmbeRLHHpawx9X74yr8dXepmsT2U3YFGmDZzhbSyGveJnV8SREd8y5sHlza9yiw7gORPKOQs1aNDhJM0/cQEhr6ipM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=UOBF5qgU; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1744684152;
	bh=f46e8OJcLSMwZOF10s1IepTisBkvS0J5YqUsuzBjERM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=UOBF5qgUF9bF1POhfz/V8Gv3m7YelFKiuJy7Jx4TCJaBk2NHM6XweMgcsM2JrBmb9
	 N2JHwD5agndyXcEz3mkkOBnpFzqjPR8KuvuS1bTNusVATRDejlAB5drNupAVYJdPGS
	 /BV0syBfXWyeYS4HEFyzzHOBxiS80gWyk80qT0cY=
X-QQ-mid: izesmtp89t1744684150t5b98e8e7
X-QQ-Originating-IP: CbKM56VlnN35SnjKkJXcNQlcwIaZUveRcpvd3DlDse4=
Received: from mail-yw1-f173.google.com ( [209.85.128.173])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 15 Apr 2025 10:29:08 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2680915399491069799
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6feab7c5f96so47589867b3.3;
        Mon, 14 Apr 2025 19:29:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUVS37wK+VB5AQvXhV9x63HGFbDlCp8ZqxotEj6L0kr3+UuehsVWqDOi+ROt1rbh358VBSTluru2iNpA698AAk=@vger.kernel.org, AJvYcCVwRd+rlgKS3eOdOLBU8P5bwus/NlY+VVAxh1ngon9SeL87d1rTlnLrpUqNQZEwx16w8uQjKqIAIcGplSpO@vger.kernel.org
X-Gm-Message-State: AOJu0Yytic0huSpBk1dpVTXXCoxje0VTABkQ2dJDAvicoEo+85cU7Fzi
	Gn3e78QAhrE4303R74yJCaHk6n0uvOwnk43tdg2wP+PE1grxEGgjXIOr7+Qee2iDtLhhZaR4NEf
	f5ubrNLOOVctKQu39nSozDpjkGO8=
X-Google-Smtp-Source: AGHT+IFQrgGS1sh77TF059IBfHyoj/jrS2JhQmD+cDwDyubrjXtjfJiyDKjNOFZDYfHY6s1kPv1lWSJ++g56nslhxtA=
X-Received: by 2002:a05:690c:d1b:b0:6ef:9e74:c09b with SMTP id
 00721157ae682-70559ae2cd5mr230434557b3.33.1744684147434; Mon, 14 Apr 2025
 19:29:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <31F42D8141CDD2D0+20250411105142.89296-1-chenlinxuan@uniontech.com>
 <20250411105459.90782-1-chenlinxuan@uniontech.com> <D513EE4F40467A51+20250411105459.90782-6-chenlinxuan@uniontech.com>
 <Z_m4I3iaHj453ZM0@kernel.org>
In-Reply-To: <Z_m4I3iaHj453ZM0@kernel.org>
From: Chen Linxuan <chenlinxuan@uniontech.com>
Date: Tue, 15 Apr 2025 10:28:56 +0800
X-Gmail-Original-Message-ID: <04B52F0F64D3E9DB+CAC1kPDM4QfqLduSYG2bT21kCbAQzThRyErZOED+Rw1=i-X8dmA@mail.gmail.com>
X-Gm-Features: ATxdqUHN9zsn08g-BNavkA8wjuJoXeyk-t-hLAAx1VjkfMnwbXrN-6EvWpV7938
Message-ID: <CAC1kPDM4QfqLduSYG2bT21kCbAQzThRyErZOED+Rw1=i-X8dmA@mail.gmail.com>
Subject: Re: [RFC PATCH 6/7] tpm: add __always_inline for tpm_is_hwrng_enabled
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Chen Linxuan <chenlinxuan@uniontech.com>, Peter Huewe <peterhuewe@gmx.de>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Winston Wen <wentao@uniontech.com>, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-QQ-SENDSIZE: 520
Feedback-ID: izesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: OH/oXo99N/TGUXfndzgFKOmZgT99rcZr+hpToUkcwoj+7+C3rUJ6SUJ2
	X4n9kA5T3WnQb0yX9N5unQGpKSE4OIejNUhIlxbj5jtuf4pYxo54jOwhaOcmhTO8M3BS8vr
	XC7wK0qVDEamYo0jCPCuJ7SEuLv05hhrq7zOZA6OgSEI28vpGZd9H4Sgd1/vpb2PRlQCGn4
	SFFZT2kY/RO3EpULcEAOUjoINkwnyVbMY/FJXWrAdGow3UvR3enxOYyyBVaxkjKRpR8IAop
	VDUeBKK2Khz92fW5ffvA6S8LbxK3T0cuCfxFC/klPHiN5ygJI6sDzydOnBL0dpqYO34Mxzi
	0Fx2SF2kd0CDAZWc55AOJseqIoLZfqsdc9VmvlzULSgoAAupKX0CgMwOyrJyDSVrEUjyIOq
	2AF+n2b+EsS8GSe0wORuGwoHquklHhlpKRcaNh+MmWc4XziRpEeDycJrODH23NYyfJCxBXk
	EmISFD8Lk0HXHSv0UO8XUsepLZkkZOERWv5R3IaeY2sRQVFtS2CWQRUQlhsEI8cQo2kAZeF
	t90QNA+9SdaR5ndWIAKJJLQOUA0RvfgQTQwlmNLEdVGXfZ8m/xiHkC34qeunqOCtrv9Fpxk
	/5jn3dkzTyoHPZF0rKVNtKLoc+htPsfjLc7f30YxA39V3ren6s/325ebkCTNWH7w3LKMNt8
	g4ZP7qhOr2FVN1iR8bN4QN7H5WmCEJySJqKiT9YfPDgSrQKqr8L9fSdjI7EpvFuYi/zzR0Y
	ssCwcL5F8DK7MIXDcLXcQ7LZGmJHcUEDUfZ3LnUdiDDnfvw0NJtPpAAQHivLUVqlXnUCryk
	Y28wx1VGP4OcnjVZSb7bHB3fOxkPbz6h/J7Xq6Su5crwf65xal+iqu/D3eED0mo+J8lsgzi
	4gNXVf93diksUL4s3xzK+jCsJ4Odte6L9P1Ixwe610N5TjDh4KIzDu1/w80gmeJB1LGJw0x
	y7j4ORrmObWd3t/wczALcddpRJDOCETGXQ8R5B0UsPOH6toC+o649mDXc4UcQDCVTEOB/95
	qyusgRUw==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

Jarkko Sakkinen <jarkko@kernel.org> =E4=BA=8E2025=E5=B9=B44=E6=9C=8812=E6=
=97=A5=E5=91=A8=E5=85=AD 08:47=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Apr 11, 2025 at 06:54:54PM +0800, Chen Linxuan wrote:
> > From: Winston Wen <wentao@uniontech.com>
> >
> > On x86_64 with gcc version 13.3.0, I compile kernel with:
>
> Use passive:
>
> "Presume that kernel is compiled for x86_64 with gcc version 13.3.0:"
>
> >
> >   make defconfig
> >   ./scripts/kconfig/merge_config.sh .config <(
> >     echo CONFIG_TCG_TPM=3Dy
> >     echo CONFIG_HW_RANDOM=3Dm
> >   )
> >   make KCFLAGS=3D"-fno-inline-small-functions -fno-inline-functions-cal=
led-once"
> >
> > Then I get a link error:
>
> "This results a link error:"
>

I will update commit message when I send v2.

> >
> >   ld: vmlinux.o: in function `tpm_add_hwrng':
> >   tpm-chip.c:(.text+0x6c5924): undefined reference to `hwrng_register'
> >   ld: vmlinux.o: in function `tpm_chip_unregister':
> >   (.text+0x6c5bc9): undefined reference to `hwrng_unregister'
> >   ld: vmlinux.o: in function `tpm_chip_register':
> >   (.text+0x6c5c9b): undefined reference to `hwrng_unregister'
>
> The resolution is lacking i.e., why adding __always_inline addresses
> the linking problem.

Regarding your comment about the resolution,
here=E2=80=99s a detailed explanation of
 why adding the `__always_inline` attribute addresses the linking issue:

With `CONFIG_TCG_TPM=3Dy` and `CONFIG_HW_RANDOM=3Dm`,
the functions `tpm_add_hwrng`, `tpm_chip_unregister`, and
`tpm_chip_register` are compiled into `vmlinux.o`
and reference the symbols `hwrng_register` and `hwrng_unregister`.
These symbols, however, are compiled into `rng-core.ko`, which results
in the linking error.

I am not sure but I think this weird linking error only arises when
auto inlining is disabled because of some dead code elimination.

`CONFIG_TCG_TPM=3Dy` and `CONFIG_HW_RANDOM=3Dm` set `CONFIG_HW_RANDOM_TPM=
=3Dn`.
This causes the function `tpm_is_hwrng_enabled` to always return
`false`, as shown below:

```c
static bool tpm_is_hwrng_enabled(struct tpm_chip *chip)
{
    if (!IS_ENABLED(CONFIG_HW_RANDOM_TPM))
        return false;
    if (tpm_is_firmware_upgrade(chip))
        return false;
    if (chip->flags & TPM_CHIP_FLAG_HWRNG_DISABLED)
        return false;
    return true;
}
```

When `tpm_is_hwrng_enabled` is inlined, dead code elimination
optimizations are applied and the reference to the `hwrng_*` functions
will been removed.
For instance, in the `tpm_chip_unregister` function:

```c
void tpm_chip_unregister(struct tpm_chip *chip)
{
#ifdef CONFIG_TCG_TPM2_HMAC
    int rc;

    rc =3D tpm_try_get_ops(chip);
    if (!rc) {
        tpm2_end_auth_session(chip);
        tpm_put_ops(chip);
    }
#endif

    tpm_del_legacy_sysfs(chip);
    if (tpm_is_hwrng_enabled(chip))
        hwrng_unregister(&chip->hwrng);
    tpm_bios_log_teardown(chip);
    if (chip->flags & TPM_CHIP_FLAG_TPM2 && !tpm_is_firmware_upgrade(chip))
        tpm_devs_remove(chip);
    tpm_del_char_device(chip);
}
```

When `tpm_is_hwrng_enabled` is inlined and always returns `false`,
the call to `hwrng_unregister` is effectively part of a `if (false)` block,
which I guess that will be then optimized out.

However, when the `-fno-inline-small-functions` and
`-fno-inline-functions-called-once` flags are used,
tpm_is_hwrng_enabled is not inline.

And this optimization some how cannot occur,
leading to the undefined reference errors during linking.

Adding the `__always_inline` attribute ensures that
`tpm_is_hwrng_enabled` is inlined regardless of the compiler flags.
This allows the dead code elimination to proceed as expected,
resolving the linking issue.

There might be better ways to fix this.
But it is directly caused by adding `-fno-inline-small-functions` and
`-fno-inline-functions-called-once` flags,
I think add `__always_inline` is good enough.

>
> >
> > Signed-off-by: Winston Wen <wentao@uniontech.com>
> > Co-Developed-by: Chen Linxuan <chenlinxuan@uniontech.com>
> > Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
> > ---
> >  drivers/char/tpm/tpm-chip.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> > index e25daf2396d3..48cc74d84247 100644
> > --- a/drivers/char/tpm/tpm-chip.c
> > +++ b/drivers/char/tpm/tpm-chip.c
> > @@ -534,7 +534,7 @@ static int tpm_hwrng_read(struct hwrng *rng, void *=
data, size_t max, bool wait)
> >       return tpm_get_random(chip, data, max);
> >  }
> >
> > -static bool tpm_is_hwrng_enabled(struct tpm_chip *chip)
> > +static __always_inline bool tpm_is_hwrng_enabled(struct tpm_chip *chip=
)
> >  {
> >       if (!IS_ENABLED(CONFIG_HW_RANDOM_TPM))
> >               return false;
> > --
> > 2.48.1
> >
>
> BR, Jarkko
>
>

