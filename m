Return-Path: <linux-integrity+bounces-6081-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A5BAA45FD
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Apr 2025 10:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 085EF4C4DE0
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Apr 2025 08:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5F3213E61;
	Wed, 30 Apr 2025 08:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QszeG2Me"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24662DC768;
	Wed, 30 Apr 2025 08:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746003217; cv=none; b=XVDGF+OaHf8Yb9/hCTUBkDfwWQmtp68n7LP0sW2I8V3oZBUGuEJOEJokXDPagwhaydtdzwyblugfRj0Aa/KnyiIwA3r+79i6R3pcPk+F0NfHwt54B7czCMk/slYl1mTJ22/6PTx8cQ8uFNj0u06/b8Z7hJk7UkBcCuqymrZQp7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746003217; c=relaxed/simple;
	bh=f15OCVR+EgVtXpxgYG3btvR5hejOsTSTYr4Nk2wEQaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YVD4ykXwTjRaW5vWpBhaMGWH2z6kEi6kWooWcpSZdbhexSfMRlrrmYkYfIGSSuDMjh4o+WGpXrSr2SGhDT56ZUN8NET4Uz78I0aOtYx2q7KfyrWDrgnHoF927jNe4G7IL+4RfnsGo0TVp98Jy6ff6ogUKHIkPtOjK9Yxg7FVYg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QszeG2Me; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B5B2C4CEED;
	Wed, 30 Apr 2025 08:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746003216;
	bh=f15OCVR+EgVtXpxgYG3btvR5hejOsTSTYr4Nk2wEQaE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QszeG2MeJl8fAxvFg34GTAR/9H/i9BOOgrn/A0bd6zfjNkn4N5C5aUpYaivD6IxKP
	 GJ6mmMqc9jTm/IcWhGNoms5AkOCbR1Fycg//B0nm4nZ3blndkfUNCDWO6chWuSZGud
	 LwCONqLWOKzyu5Acp7NY2yAaTUYWSxBKdOXLvhCIsX7UBS9G5a4swthMHdJ79IHTkK
	 p6kZbaQdCmrHFpOKFdj3RygNQ07qDou8u5YXWVFNdcM8ns+6S3fP+As/3EGJdaibRt
	 hC4SCKFh83cfiCpsXrYaDDYV4+WLJCg3x0cVD85MKq/96afUbxNd3bo9j7FshZ6zLh
	 SXqxbGqfKCCdQ==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac2dfdf3c38so1218574466b.3;
        Wed, 30 Apr 2025 01:53:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW2meCuXOtq1hZMjqx8dpQZ8lpeILJgY5PFakgBGOWOvEvyp7ndZJMzneGIk+njxnocRlBpIqXSlLDA4D8=@vger.kernel.org, AJvYcCWp5Tit3r5b4IsXqpAu5jM36odJ2qvdklVkwIpzj6CJqQwAt4KJfAEQAp8jOYVXgZnLeXwD1S3vVqEgJ+0ucYCh@vger.kernel.org, AJvYcCXwsOL2mdMQv8IznrPqkSIkb8b5KCkOyhQAIP6dxTBef0ToWQPG6yH5r7rpimkBQfXAmFMhKzGVbzYp8e1I@vger.kernel.org
X-Gm-Message-State: AOJu0YyStbFOhJJ6g9liBrmLGlJFr7F6QKdB7AqMhJ5Haad9vOnPNUYM
	5CTEBDYv/1WxYKi2st/doPfoYKX213x2N2zThPLLJZflK1Ld6rDkj4lWrs/TzLqvA32qghqh2HO
	grJtPOWaDFneHvuS6Z8T4nhYbH7c=
X-Google-Smtp-Source: AGHT+IH5ByFw77cLNg27eGSh6LJj24+g4XbE5qVSCGhzY8q8WePZkEcf91AFPzp7kbTaKwjZoUiQ7bhI3SukVRGZdLQ=
X-Received: by 2002:a17:907:c23:b0:ac2:d0e6:2b99 with SMTP id
 a640c23a62f3a-acee2404095mr189166066b.36.1746003215050; Wed, 30 Apr 2025
 01:53:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418093506.1349-1-zhaoqunqin@loongson.cn> <CAAhV-H608_ddH0g0gyFCZSTVxYHOBqLXrtGYxZ1eoXX6eCcEuA@mail.gmail.com>
 <75bb29fa-6d77-6f95-eec4-ee183190da17@loongson.cn> <aBHc2tT2-Duj3_-A@gondor.apana.org.au>
 <6b7385ce-d8ad-1be9-4503-55460f40fe72@loongson.cn>
In-Reply-To: <6b7385ce-d8ad-1be9-4503-55460f40fe72@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 30 Apr 2025 16:53:24 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6ku=imPGqaFrey6hCMwXSL4Qsoif9Rv=Gko2R1CBtGmw@mail.gmail.com>
X-Gm-Features: ATxdqUHnwMshS9EfXAJbKH-dQtSwy2AQDOhU27KHQ7tHY_jE1Jkc_BiUaRaUdVM
Message-ID: <CAAhV-H6ku=imPGqaFrey6hCMwXSL4Qsoif9Rv=Gko2R1CBtGmw@mail.gmail.com>
Subject: Re: [PATCH v8 0/5] Add Loongson Security Engine chip driver
To: Qunqin Zhao <zhaoqunqin@loongson.cn>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net, peterhuewe@gmx.de, 
	jarkko@kernel.org, linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-crypto@vger.kernel.org, jgg@ziepe.ca, linux-integrity@vger.kernel.org, 
	pmenzel@molgen.mpg.de, Lee Jones <lee@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 4:47=E2=80=AFPM Qunqin Zhao <zhaoqunqin@loongson.cn=
> wrote:
>
>
> =E5=9C=A8 2025/4/30 =E4=B8=8B=E5=8D=884:18, Herbert Xu =E5=86=99=E9=81=93=
:
> > On Wed, Apr 30, 2025 at 04:14:40PM +0800, Qunqin Zhao wrote:
> >> Sorry to bother you, may i ask is it fine to move  the Security Engine=
 base
> >> driver[Patch v8 1/5] to drivers/crypto ?
> >>
> >> The base driver uses MFD  interface  to register child device(tpm, rng=
) , as
> >> done in
> >>
> >> "drivers/iio/common/ssp_sensors/ssp_dev.c" and
> >> "drivers/firmware/xilinx/zynqmp.c".
> >>
> >> Thank you, and I look forward to hearing from you.
> > I don't mind at this point in time.  But if this driver were to
> > develop features way outside of the Crypto API in future then I
> > may change my mind.
>
> Hi, Herbert, thanks for your reply.
>
> In future it just add child platform devices  name(sm2, sm3, sm4) to
> "struct  mfd_cell engines".
>
>
> Hi, Huaci
>
> Let's go via Herbert's crypto tree for the base driver patch under
> drivers/crypto/loongson/,
>
> What do you think of it?
In my opinion drivers/mfd is better, because another user is in
drivers/char rather than drivers/crypto.

But if moving to drivers/crypto is what Lee Jones wants, then everything is=
 OK.

Huacai

>
>
> BR, Qunqin.
>
> >
> > Thanks,
>
>

