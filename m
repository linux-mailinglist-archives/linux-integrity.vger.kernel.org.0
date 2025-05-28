Return-Path: <linux-integrity+bounces-6331-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33656AC66E8
	for <lists+linux-integrity@lfdr.de>; Wed, 28 May 2025 12:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD482A22949
	for <lists+linux-integrity@lfdr.de>; Wed, 28 May 2025 10:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101B02749DE;
	Wed, 28 May 2025 10:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WwF1Y6Pg"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D50214229;
	Wed, 28 May 2025 10:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748427914; cv=none; b=bZwqaI3YWpPoIrDDRkuI2tbVxlMnL65j+fpl4xBARyrFgGrF0DkM/YbM2j8yuphhx0RI4jwuRdjtob0CLhDt0YrnViLL3VTQwLHJczXx2Vo1eJjZKiXHay5/zdtOMTbrLhN51NqCi8guUNqOGtYmmYqIN5Q8hLxeBNUQ1q7Ziag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748427914; c=relaxed/simple;
	bh=LIOi3dndS8s1nCiZiSl6vDayk7Pb84g5JnDJyZlqFBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RyRuCSnUj6BY9pHVOLmuKr3eUKIJW3fuq10NBiK28gEF+HDNWhjBMivnetKetAkp+DDJ+WjZf7K2/R/LThhBeyfvA1MMx/+IOV9fAQZdfhRBwArFzN21LCetaSmi694TAjXEueZEiJD26Ew/HgKfROinHKXaEmwXS1iA9Qnvt/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WwF1Y6Pg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A661C4CEEB;
	Wed, 28 May 2025 10:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748427914;
	bh=LIOi3dndS8s1nCiZiSl6vDayk7Pb84g5JnDJyZlqFBc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WwF1Y6Pgx07N4IHmEht4KvHtaFDFCXdIRjCLcBQM0vAMt7nfuNKKGk2N9aIkJxMNR
	 c8uD4nxRwhY35mkUYEB6BuxGYbUPy2PJ+ZFLzu53Kko+6bfc7Sp7DzFecCgjHr9nDC
	 0oPdgTKrPVfQ6J228yqd6e9sUEC3q6wK+4xekoHJeeG5gNEk+7sM4Mk5hgZNMbanW9
	 kCj9r+ya5T+Rr6nAGtTOnndPG5QyZN+UDp4wYayDjUyzqoDybD1hM5ga8SQ4CCMRP4
	 zh+tqor8DBWu+q9ucD5NZJBA3I8U+miEeKzEp8wpsV2u1RtFKfNgNW0jLcVsgw2HTo
	 mDIptO3dJpE1w==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6049431b0e9so4508735a12.0;
        Wed, 28 May 2025 03:25:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUoXRF/roCTFp+oABmJg7TPQaSokUOC6xLa2SiRhn4h9WMASUdDpbAl+uSh7wRIhVj/P9JiJ2SePXkiG14=@vger.kernel.org, AJvYcCXGVcGqWUvHaBiKnb+6Q0XSMRvrhlC1pmL7pF1YshhPBQvyncCbP9QdHLQn5RGXS4RsP2p6eHkQQfG+jp26@vger.kernel.org, AJvYcCXbqMv7JZF71GQpnMJlxilWEw62AcC0F0cUlWdKef9q3Bgz6rh+Oyv4Qdfr9pmLRfZfWL9VixsR3hPxaqAxAr+G@vger.kernel.org
X-Gm-Message-State: AOJu0YykD88yXTfANlSy7fnnuUKiO0hS2GoXDQPqX8pbNrLB9DGtGr+m
	ZiYWRaGcA2ePI4cBwx94Px49/DXKk55s30Rsc5ESpBMRlHVBAqhibN4X8gf8W+iy991AcLd1NRg
	3hziz3nzGYT5G6/sGsTO23f438IQvtOM=
X-Google-Smtp-Source: AGHT+IGDHiTwGJRagnogeg3ewv6dw7u75sF89so1xzMF1zhmt53vyAE51gY9xZM/y+SFsY6wONjEbQnz9Jore+K4BjA=
X-Received: by 2002:a05:6402:2713:b0:5f8:e6e5:54ac with SMTP id
 4fb4d7f45d1cf-602d934d18fmr12369031a12.14.1748427912970; Wed, 28 May 2025
 03:25:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528065944.4511-1-zhaoqunqin@loongson.cn> <CAAhV-H7hBksA2P+vfMbpDVnbjW1Mo09Out_wOQLgLRXPLaFCfA@mail.gmail.com>
 <cda7ef56-87b3-6594-c2b6-2a4f5a1b63ce@loongson.cn> <CAAhV-H557CLtoF23nbRQaoDPdzuM5xgsS-+-1p_VeX0OreG2vQ@mail.gmail.com>
 <0b328692-f333-4bba-9572-6f3c86dbed29@linux.dev>
In-Reply-To: <0b328692-f333-4bba-9572-6f3c86dbed29@linux.dev>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 28 May 2025 18:25:00 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4voq8HgwOgxObj-wOzBA0+Wv=8x+oVsR3++01i2NAHTQ@mail.gmail.com>
X-Gm-Features: AX0GCFvKzI2jSyUtQ0kx2nTZcGobH-pL8xGqTAba7znizU98oerpW-343mbJqLY
Message-ID: <CAAhV-H4voq8HgwOgxObj-wOzBA0+Wv=8x+oVsR3++01i2NAHTQ@mail.gmail.com>
Subject: Re: [PATCH v10 0/5] Add Loongson Security Engine chip driver
To: Yanteng Si <si.yanteng@linux.dev>
Cc: Qunqin Zhao <zhaoqunqin@loongson.cn>, lee@kernel.org, herbert@gondor.apana.org.au, 
	jarkko@kernel.org, linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	davem@davemloft.net, linux-crypto@vger.kernel.org, peterhuewe@gmx.de, 
	jgg@ziepe.ca, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 5:15=E2=80=AFPM Yanteng Si <si.yanteng@linux.dev> w=
rote:
>
> =E5=9C=A8 5/28/25 4:17 PM, Huacai Chen =E5=86=99=E9=81=93:
> > On Wed, May 28, 2025 at 4:06=E2=80=AFPM Qunqin Zhao <zhaoqunqin@loongso=
n.cn> wrote:
> >>
> >>
> >> =E5=9C=A8 2025/5/28 =E4=B8=8B=E5=8D=883:17, Huacai Chen =E5=86=99=E9=
=81=93:
> >>> Hi, Qunqin,
> >>>
> >>> As I said before, why the patch "MAINTAINERS: Add entry for Loongson
> >>> Security Module driver" is missing?
> >>
> >> Hi, Huacai
> >>
> >> https://lore.kernel.org/all/8e55801a-a46e-58d5-cf84-2ee8a733df9a@loong=
son.cn/
> > Sorry, I missed this email. But if you put all files in one entry, you
> > can merge Patch-3 and Patch-5 as the last patch (then you will also
> > not meet the 5 patches limit).
>
> We are cutting the foot to fit the shoe. Sigh...
No, the two patches really need to be squashed.

Huacai

>
>
> Thanks,
> Yanteng
> >
> > Huacai
> >
> >>
> >> Thanks,
> >>
> >> Qunqin.
> >>
> >>>
> >>> Huacai

