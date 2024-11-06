Return-Path: <linux-integrity+bounces-4031-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8759BF54A
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Nov 2024 19:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8276B24B19
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Nov 2024 18:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836C4206950;
	Wed,  6 Nov 2024 18:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkDRv6xT"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4E6202637;
	Wed,  6 Nov 2024 18:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730917944; cv=none; b=CQ9asdhQt7f08QWJKGIergJl2Np+12rxcaQ0dO0i4XhiARz33bXMLWJVBNaR5jhFc0cRSlAoXWYuXctNvWNnFiZ8MtPQmqz00nzdPrMLhsafaFqHupUzqqP2Jg7HpOXjZMi9BFPEHReRnh8R1P47DXWmmQjgkqMq5bZiJa614rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730917944; c=relaxed/simple;
	bh=VZAJqAIJ1C/Lh9DLgBZKS+KRl8i2ROrpVpzHBnbbhE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f7NM+wNhj6m7PziSNubaMKVwDHXSJnX7UAztSMn6Pk89y58pwjkIb/SRxT2Btaxjw0JaJHQh3sWgwP2XGQS8tlyoqcgHcj6vsGGXG11zyBs6HEjSxkkvHGn7ETprJ0N0kWIKjJu20DmIYanotYjBVrv6IYToU/99BXDxzT8Yceg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PkDRv6xT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D862DC4CED7;
	Wed,  6 Nov 2024 18:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730917943;
	bh=VZAJqAIJ1C/Lh9DLgBZKS+KRl8i2ROrpVpzHBnbbhE4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PkDRv6xTRctPUKBiyFgsQSDikbJfwz/A9CYVYQYxhpt4w7Qk9NdT54U9iSLGdv2pb
	 htOJOQD7/rVh/bJBP+dYYZzuG7tkFQ5874OrJWODy/7UAHJu2ZqewmrWhgTPINxHgm
	 SXrggaF2eXjxrc24zsr8cM43in25irJdCQ+P6LfhoRP1shEYTm+QBhZwNN35BmwJ7a
	 Zw8iFmfKfz/JPzuCHlegm3JYdZv9HCOm30CphxdKWrErE9QDI6KjHk5v6yIpdes003
	 DQflz7jGg06FANTss3tbT0q0NKZCEgownWTxkSyIBLDp4xnB3oSpi+If4BDAoyUsd0
	 prTT3GKnN/XIg==
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6e9ba45d67fso592907b3.1;
        Wed, 06 Nov 2024 10:32:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUUYgOLRvLrI69KeZ/vLUTf786eqqRlWb0J/kKWfckkCit4VQjrjWxfiJccuqrpYiPRZLCHIDcNLaSBVf9a7to=@vger.kernel.org, AJvYcCXbakr3vSErO7VY44Fj2rRaN7pwrkXQhrNy1Q+CAd8xPmZRnr+TtsD6h9RQqcj2pEORw33wHLjxFS3tX/nm@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6UWdmGHjz9W9Ma+sVMVqO6R1E227+axnYRWMzdQ/F+znZlZzF
	2R+WXmPWRNl+uOQNA/KVHBu+iO6ir0sdg4CX0TuoUNOd2Em4Si5QE0nF6krgNtKrsP6VPTZ0NA1
	iqrt/y4wRqkTwlr/A/wWfpTOZlw==
X-Google-Smtp-Source: AGHT+IHF7huaas71JDmvvH8NbieYOfzeri2Ws8mw0BHdC5V9CTrAnY0eW9Crx/tJlxy/Vp+n09K9FKAFs2dJs+U2oy4=
X-Received: by 2002:a05:690c:62c6:b0:6e5:9bc2:53a0 with SMTP id
 00721157ae682-6ea3b9831c7mr307446817b3.41.1730917943104; Wed, 06 Nov 2024
 10:32:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702161052.3563599-1-robh@kernel.org> <D2RSWMPFF8KK.X5HZZMHANQMO@iki.fi>
 <D2RT0J8KXY1H.3MEV7KGQXTWHW@iki.fi> <CAL_JsqJDX+uOSoPh6pTNEP0vBLwcP3bKmAW1wCr_0cVr5fsPcg@mail.gmail.com>
 <D2SSH5HSDHQS.2YJSB22W3MHQK@iki.fi> <CAL_JsqLF+gs9e1TL1yi-xAZJRx4Kz7fOk=2wcF8kCqU3vyMWZA@mail.gmail.com>
 <D5FAVRTM32ZJ.1HFCHF3L9I68C@kernel.org> <D5FAXEKQ71ZJ.1U9AE15UVWRT9@kernel.org>
In-Reply-To: <D5FAXEKQ71ZJ.1U9AE15UVWRT9@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Wed, 6 Nov 2024 12:32:12 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJdabUmgOEe29y4o5muOnh83V7rS=YwfXMtZ+Fugcgzdw@mail.gmail.com>
Message-ID: <CAL_JsqJdabUmgOEe29y4o5muOnh83V7rS=YwfXMtZ+Fugcgzdw@mail.gmail.com>
Subject: Re: [PATCH] tpm: atmel: Drop PPC64 specific MMIO setup
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jarkko Sakkinen <jarkko.sakkinen@iki.fi>, Peter Huewe <peterhuewe@gmx.de>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 12:19=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> On Wed Nov 6, 2024 at 8:17 PM EET, Jarkko Sakkinen wrote:
> > > Whatever happened to this? Can you please apply my patch if you don't
> > > have the time for further rework.
> >
> > Sorry unintentional.
> >
> > I applied with
> >
> > -static void __iomem * atmel_get_base_addr(unsigned long *base, int *re=
gion_size)
> > +static void __iomem *atmel_get_base_addr(unsigned long *base, int *reg=
ion_size)
> >
> > as this gives checkpatch error.
>
> See:
> https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/co=
mmit/?id=3Db18ffd5e0faaa02bffda61e19a013573451008d4
>
> If that looks good to you, I can mirror it to -next.

Looks good. Thanks.

Rob

