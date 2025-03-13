Return-Path: <linux-integrity+bounces-5268-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E12CA5EF88
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Mar 2025 10:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 519C519C10AC
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Mar 2025 09:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCB6263F4F;
	Thu, 13 Mar 2025 09:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SyUGk8yp"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0DB2C80;
	Thu, 13 Mar 2025 09:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741857974; cv=none; b=svlGWjk1QmGiOWltk8+1V1v+nnXo/9sLULoyCgKZVl10pnjqJB06+ZL4YnQJ0GfSZDPsO35V3hIPRgH7ShbO1dUw8G52iQj+FtDUgiacwR6OCJvAv0WSftbBAVXDlJYJJC+NDh9wQRGLjQUTc5W6I3x70BGmyQoAYAdlJyK8GEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741857974; c=relaxed/simple;
	bh=Zi5CdwayLfpbTu+FW1B3QtpWXXMH5McpvDDdKaOoLH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z5Mn//+CL6HX3klCAna4BmHk1sToSxH8/Iis8dem/kPjPb8dcprreMbq2aYTWZUFAFsZKFKTvlsDoUUG5zPdKN7xD9ZDH9QEOdzQSbzzrgshqr73CaPIjWHJvibhwb6pPOq0hoYMS7EAc8c0wGAt+7BYFhMwQYtuHFMkwXBh+Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SyUGk8yp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2C03C4CEEB;
	Thu, 13 Mar 2025 09:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741857973;
	bh=Zi5CdwayLfpbTu+FW1B3QtpWXXMH5McpvDDdKaOoLH4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SyUGk8ypg1sOx97CdpeB64AOQUwNgPsXCgStv2uTbH6FtxFJvJCoAEyTNv/UgUcpp
	 bCQZFOyK2OPXu6j8vPK5HyJKZV7mA1A9MbqVZ5NaXuik1SQahN+xUM/BeA5XP0rVNQ
	 efk5yznuMSeMtY1F8Aaw1q5xz7mj4zC66mGJkBLX3m+cJmCoP369ZPWWnRuPH0uV69
	 QLTc/wYqrFWchggPOs5wilG8QEwfPka6GRa8YZ+Vs5Ukd8x4fEncXjfu2Hn3JO3jDh
	 nFSa4/9ytNO0ceYFSFFClojCIbFNuYhEBO8KUqNQOVGxchc3Sbt+gWL7TAETN2LAoi
	 56ph/EW9KxM9Q==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aaec61d0f65so140670566b.1;
        Thu, 13 Mar 2025 02:26:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVkjtiV3/IgCFbp5wIgVFJtR6TFqt22cSpHHDeSJwxTaGbxz2FOh3Mpg0bNTNtHVFaUxqU/qRg/F4ipLdg/G+zs@vger.kernel.org, AJvYcCWMT1yknkE74sGFNnN/xHFERGNyfx6H9H4AZ2kK6PMe4frFak49s+8FhQ61F4kj1VppbfPQ6nAMMdFd70tF@vger.kernel.org, AJvYcCXgTAOd/zofsTTqAG1OxzEsk75quk2yu5bctvbyHo7ENfoDNSQ8DO51/MM+yxpfl+0azN15b7skL/uqTkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzJL/BraVRmZizMIoMmJuX4gd+/GVIn20gmHIcVh4fHAKBerfc
	DW/sXF78fAMPJQM2G6meYGfU0o5P46dmTKEU2NjvHC7g9NBawYNPu42vjLY4WhOeQlQJIO3Gdra
	ioDRnk5TvWe9xFTxR3HXCpAjIGFw=
X-Google-Smtp-Source: AGHT+IEFkgdRx4Lqq1hH8UK+RojzhFuWHGArJwcsexUdAHEfPhEcGWZIPozZgLbdBa+CJV2H2bxYIYGWPYNAWjh9GRY=
X-Received: by 2002:a17:907:7f92:b0:abf:49de:36de with SMTP id
 a640c23a62f3a-ac2525b9adfmr3206142266b.1.1741857972249; Thu, 13 Mar 2025
 02:26:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313090508.21252-1-zhaoqunqin@loongson.cn>
In-Reply-To: <20250313090508.21252-1-zhaoqunqin@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 13 Mar 2025 17:26:00 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5f1k4_bVybMcK9QXhaVxLOM=b_8n0sA+0r=gyCP4YQRA@mail.gmail.com>
X-Gm-Features: AQ5f1JrOvE_lpnr7QXpbsHNsBtKqDY2pcat5n23R5svAqVqhsGgSekvEA7HZN6A
Message-ID: <CAAhV-H5f1k4_bVybMcK9QXhaVxLOM=b_8n0sA+0r=gyCP4YQRA@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] Drivers for Loongson security engine
To: Qunqin Zhao <zhaoqunqin@loongson.cn>
Cc: lee@kernel.org, herbert@gondor.apana.org.au, davem@davemloft.net, 
	peterhuewe@gmx.de, jarkko@kernel.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-crypto@vger.kernel.org, jgg@ziepe.ca, 
	linux-integrity@vger.kernel.org, pmenzel@molgen.mpg.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

You haven't seen my comments in previous version?

https://lore.kernel.org/loongarch/CAAhV-H5xyRrF1_=3DE7rLM3dHeYAEBdMufYQvgox=
Aq6+d6s5U4Eg@mail.gmail.com/

Huacai

On Thu, Mar 13, 2025 at 5:05=E2=80=AFPM Qunqin Zhao <zhaoqunqin@loongson.cn=
> wrote:
>
> Loongson security engine supports random number generation, hash,
> symmetric encryption and asymmetric encryption. Based on these
> encryption functions, TPM2 have been implemented in it.
>
> mfd is the baser driver, crypto and tpm are users.
>
> v5: Registered "ls6000se-rng" device in mfd driver.
> v4: Please look at changelog in tpm and MAINTAINERS. No changes to mfd
>     and crypto.
> v3: Put the updates to the MAINTAINERS in a separate patch.
> v2: Removed misc driver. Added tpm driver.
>
> Qunqin Zhao (6):
>   mfd: Add support for Loongson Security Module
>   MAINTAINERS: Add entry for Loongson Security Module driver
>   crypto: loongson - add Loongson RNG driver support
>   MAINTAINERS: Add entry for Loongson RNG driver
>   tpm: Add a driver for Loongson TPM device
>   MAINTAINERS: Add tpm_lsse.c to LOONGSON CRYPTO DRIVER entry
>
>  MAINTAINERS                            |  14 +
>  drivers/char/tpm/Kconfig               |   9 +
>  drivers/char/tpm/Makefile              |   1 +
>  drivers/char/tpm/tpm_lsse.c            | 103 +++++++
>  drivers/crypto/Kconfig                 |   1 +
>  drivers/crypto/Makefile                |   1 +
>  drivers/crypto/loongson/Kconfig        |   6 +
>  drivers/crypto/loongson/Makefile       |   2 +
>  drivers/crypto/loongson/ls6000se-rng.c | 190 +++++++++++++
>  drivers/mfd/Kconfig                    |  10 +
>  drivers/mfd/Makefile                   |   2 +
>  drivers/mfd/ls6000se.c                 | 374 +++++++++++++++++++++++++
>  include/linux/mfd/ls6000se.h           |  75 +++++
>  13 files changed, 788 insertions(+)
>  create mode 100644 drivers/char/tpm/tpm_lsse.c
>  create mode 100644 drivers/crypto/loongson/Kconfig
>  create mode 100644 drivers/crypto/loongson/Makefile
>  create mode 100644 drivers/crypto/loongson/ls6000se-rng.c
>  create mode 100644 drivers/mfd/ls6000se.c
>  create mode 100644 include/linux/mfd/ls6000se.h
>
>
> base-commit: 6a8f122c5f073c8610c32636663f2512514b1270
> --
> 2.43.0
>
>

