Return-Path: <linux-integrity+bounces-2245-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D944E8B322B
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Apr 2024 10:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94AF7281809
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Apr 2024 08:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BBC13C8F4;
	Fri, 26 Apr 2024 08:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="obgQPE2p"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE6613C9B0
	for <linux-integrity@vger.kernel.org>; Fri, 26 Apr 2024 08:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714119591; cv=none; b=BUQGefbXv3IiuCc3jyWMl/4dNY94M1WfBR+Kq3o/IgTkgd99r6ck94lcX5wJFaPAjwvg42Go/P62sseC8QRLpHkspVUhl/5RLMHLWgBQylLqLPgG65oIcAQXAmM3c/Y1iDee8kXDBl41j0tWbQrUptPjVQRNdW8Nkeyr6L9wEts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714119591; c=relaxed/simple;
	bh=kv3uHgyGw/JZZTNmwog/H4yWnQwcgVscrnTYwyYSk7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V3FUz25/oLrULo5gKCETZYH/Wu36n2h7yuKaS+a298+eawRNOlNSbe+ErRW/79AGy91cg+DPYmGUw7g2K/wvEusKNusqjXM6L2w9idKoCLWYo2uBba0xK12xSu1Z/9gcd2gHxoP+pEgOnPMhaIlCTf6iML6LLzb55IGj2uY1Na8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=obgQPE2p; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2df78247164so1101431fa.1
        for <linux-integrity@vger.kernel.org>; Fri, 26 Apr 2024 01:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714119588; x=1714724388; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EfSdQv6EjCCLdGOmPdycx3ncAagFAEEu4KvAuGFd2XM=;
        b=obgQPE2p2X+FvV6YaK7ovQQ1WIvjiDxGG9YbiUO8l1kqZh3jWNa6DGBPQXCWlSGM/C
         3gnOUaRZJz462IVeXrixYLGovItruHj3cftEZ94cs0fh/mVaMl4n/y0MIfZm+hCD08+t
         zegZrAFJsrLCPufTJaehHPbBk5n3Hg5HB7RBys41i/VlxkAHypQ/DPMXQG9PXHhpTJAa
         GtMDg/6PJ6jX/DOuo1QZI7+N8Xxq64ts/y8OMYPNWW8oM9/O55UWurpKcDF2cdpKQOSL
         j4w7+J+ybrhNbampjHh+k7mOsbw0rKJpwZhuYT5vJDBpdcBP16b9E2bX4EUO+0tJ8q5P
         BjVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714119588; x=1714724388;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EfSdQv6EjCCLdGOmPdycx3ncAagFAEEu4KvAuGFd2XM=;
        b=lmKs5Xj8t/Fujao+BOoLACsRrm+qlnH1T+dkHXh6DkzRteYpa3OBAG1+ldQTtk6WRy
         zdmDU7JaocXTJsu3YZVaSBsJS4iZh+MZDVTFtemaq4sCZgwzskyU/7RJZ9zN71nkpRI5
         TkHVZ+NQUDi36FcaMQjzHm1H64taQMMfIA+2LJIyYoPM9Nk28lhg33mTHzOh6sgFMYKd
         PtZ/SpxmEi+beehALhfc8O5JLky+TMU5jZuIYzjhQhFnokVIuRMp5YzABVqdNAYc+lBx
         bAwge+OEXkLQ80qBoMQSTkPTM/Z1z++7nFD44o8BSADE1YjrBn1QZdMByM2iZlH0hlbO
         tVeA==
X-Forwarded-Encrypted: i=1; AJvYcCW7IwcBrFP/2YN4+fLj2NoVGUvLj7tnPysNtfnuNFUMlSRPuenp3qw4R5eFvJd+5OlU9JKfx4wGCFouVIv8APrXVCycp0ghjYSYRLN3Rwna
X-Gm-Message-State: AOJu0YxBPha49fETGQT6ZrLJrBqEjtA76Si0Jjx/LJH2XSXGmfLF+dzh
	E08iDJbYoq07/Cure2cE0sDhQW9R0oGFj5KPdZuzwFJShRAO8VQPatoXWGDYB/0=
X-Google-Smtp-Source: AGHT+IHn3pUNjIBBIMlJ0pok0kVfWRxuRyYjBgVu6C3raaq1xokZeUacw6WmroFVNdIv0/AHQ+7r7w==
X-Received: by 2002:a2e:9e07:0:b0:2de:4cb4:2601 with SMTP id e7-20020a2e9e07000000b002de4cb42601mr1185461ljk.43.1714119587462;
        Fri, 26 Apr 2024 01:19:47 -0700 (PDT)
Received: from nuoska (87-100-245-199.bb.dnainternet.fi. [87.100.245.199])
        by smtp.gmail.com with ESMTPSA id z1-20020a2e9641000000b002d6bc956deesm2599855ljh.99.2024.04.26.01.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 01:19:46 -0700 (PDT)
Date: Fri, 26 Apr 2024 11:19:44 +0300
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Lennart Poettering <mzxreary@0pointer.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH] efi: expose TPM event log to userspace via sysfs
Message-ID: <ZitjoLvggYB7vR0O@nuoska>
References: <CAC_iWjKA-xRH=3FK+=woXsB8AW4+_mVhJhUQnL8iFKxGzOwKiA@mail.gmail.com>
 <e3038141413e25350f0e53496f7a7af1bf8419cf.camel@HansenPartnership.com>
 <CAC_iWj+zbs2tq_nMASDX6pgCAP23+PpctJFiu9=mgOVDz8Trzw@mail.gmail.com>
 <e1da76ca4c7fe9319aaac5f8ff6eb46db433ec60.camel@HansenPartnership.com>
 <CAC_iWjLH=SDoTw_Pgr2hOKHkjEp_dKqwpUe9j6a=_WNW9UcxKw@mail.gmail.com>
 <CAMj1kXGHT2wULF2zwNM_QxD29dRW_dtFX2sOvsLahPiRVB61qg@mail.gmail.com>
 <ZiopXE6-AucAB9NM@gardel-login>
 <D0T9BM4E1F5C.2TZMIRSHCKCQ2@kernel.org>
 <D0TVQWEDNZO0.PN96CXJOTN1B@kernel.org>
 <D0TVUC3PEG7K.1XYIAGIM2T0UQ@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D0TVUC3PEG7K.1XYIAGIM2T0UQ@kernel.org>

Hi,

On Fri, Apr 26, 2024 at 10:40:20AM +0300, Jarkko Sakkinen wrote:
> On Fri Apr 26, 2024 at 10:35 AM EEST, Jarkko Sakkinen wrote:
> > On Thu Apr 25, 2024 at 5:01 PM EEST, Jarkko Sakkinen wrote:
> > > On Thu Apr 25, 2024 at 12:58 PM EEST, Lennart Poettering wrote:
> > > > General purpose distros typically don't build all TPM drivers into the
> > > > kernel, but ship some in the initrd instead. Then, udev is responsible
> > > > for iterating all buses/devices and auto-loading the necessary
> > > > drivers. Each loaded bus driver might make more devices available for
> > >
> > > I've had since day 0 that I've worked with TPM driver (i.e. since 2013
> >
> > - had the opinion (typo)
> 
> Tbh, I have zero idea what this discussion is about anyway because the
> original thread *was not* CC'd to linux-integrity and I'm not subscribed
> to linux-efi. So next time put all the relevant mailing lists. I.e.
> definitive NAK for this patch.

Sorry for not including linux-integrity. I added maintainers and lists
proposed by scripts/get_maintainers.pl for the change which did not touch
drivers/char/tpm/ though TPM event log APIs are clearly there.

The full thread starts from here:

https://lore.kernel.org/all/20240422112711.362779-1-mikko.rapeli@linaro.org/T/#u

Cheers,

-Mikko

