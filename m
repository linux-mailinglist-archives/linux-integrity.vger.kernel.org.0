Return-Path: <linux-integrity+bounces-7390-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 074B5BBFA3A
	for <lists+linux-integrity@lfdr.de>; Tue, 07 Oct 2025 00:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7554234BC6C
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Oct 2025 22:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9B18F49;
	Mon,  6 Oct 2025 22:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MQNrYicc"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3835919E7E2
	for <linux-integrity@vger.kernel.org>; Mon,  6 Oct 2025 22:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759788590; cv=none; b=Vnl1d4hYt1xXyKKIYynwA81Nyd77611fJn2OtaC365cVj9e0wkC1P8OLlbsAG6z09UQJJVTBLkqjdIsSg30bYpgV3vgkMPviImGwE/zat6fueE7OJEGPaEpP8OOSD61WXZPw7RUNQ6y2yW9xoXzoaL14A4PI8k5oFpKU24/AL8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759788590; c=relaxed/simple;
	bh=CHD0J+xjJcGVkTXfHKoo2fZhpHdZNaSK3j/FMipOEMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iBt+lSHlm3U+KMFbqxOlZ1Q8KrcXmLY0ldyYuvzAZf7E58AQxEVDjwxl+fy63jgfBmzv8pBjW7b75yoK84s9Kovn4eUbsArLKldMYk68n3NYfzONrKZAyNg7GT+soOB7ILKaHIf2XHC37jlYHFYXWOy3ClKpDLtt+vsHG6IIKmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MQNrYicc; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b2e0513433bso847465666b.1
        for <linux-integrity@vger.kernel.org>; Mon, 06 Oct 2025 15:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759788586; x=1760393386; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6uGao8D5BSZy4tBpGeUoA8r3hr67oWCrLy7wILsVxn4=;
        b=MQNrYiccnbRmVexS/vtUBcAEVKuzNy0x44Z7LGDqdca42nJ6wzsjeWqZXDU0pR0CD/
         3c8fIgeRcw08DgKVoofHRn8YRy0fSkytM+9tvPHn+Y6Z34q+IJtUYGSvTjNotNtI+2nY
         mQwUCtnwALOIyJRlreO7EOQ2bacM5AWVMC0a0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759788586; x=1760393386;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6uGao8D5BSZy4tBpGeUoA8r3hr67oWCrLy7wILsVxn4=;
        b=jj/sqx16EMc/9nA6EMJb1BaEkeZ7LTxApLmcrh4tvFhwYixV3TxvLyTVLLym/0KUEV
         9rQHtj+Sff366yOjU+cjMROhhKh53hy4J/z/IFCKBPNyCg0MZzNMqWuZ5+teOze4hZEc
         DcqOhfnsEmTiHc53TsIf+awb8ypYv//gSbycB/BM1eorOSPcAz4U8GsO1tkVLbkZ7wPz
         e1lersIJ0o19G9tBI1vUD6y2chNiRNXteHuUicxJ/89zTnns6UQpY52FcRcKsk8sc319
         dXoJ7Hj8xguvUzOeSzAuvgkb+h0P8r7+QQR4ZpADz7JRBgg6W3RjVHsHbOPy2TOZByX+
         eG4g==
X-Forwarded-Encrypted: i=1; AJvYcCXHNabM0TVLAU8mwmeGT59m4AC0ENsoVIqYdzHJaoelXHicosunGpE0IuMuz7SNmVqUsuGj+bhZj+FbYtnhVlY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIehSqBofOzdN3TBHvjVYU12x/+3x3SM5yjBKkgfy1Ytz1nu8Y
	1WC6gdLR16YB0623VtY9muqyxdNdbrSmslbXqp6iAglB8XGXD+LHzA7j/HUIT6hR+9Tu6R+PmDF
	eSK9zs3I=
X-Gm-Gg: ASbGncudLiTmYis9ubkZegoSBU/qJg8yrcVy7ZI8oFF4+IG8522xQMS4K7CRFgLsONP
	ez5u5MXyClzJ8KYHXDYIQ+C3Nb5LHj22kSMo/T/FgEhvYrBdZGIL2wSDLlavtlf+A5vkfMEaS9q
	KWfjqaeY/ljiP7mUD+bzx1kfjdbQZGr0NnvrRfL3m5SUUi/cKNQQmN5rQwmxfwmh9zfqO+5sxml
	3r8bMjwdNNQqBxoXwB6nqGs7ON6DmUHhfBcazvsTQmu6kDP4G7phnyu+35+/KVAiyGXWNb9vYRs
	SZ9J2pwsdn5aiGtSwRKzK+1nyfLQep98MVXBBafFiOpsDvK+kfxINS0EeOvRu7oszRC2rWXyRUS
	aipcsZwbiIYTtpbDkO7oQD0aF+NmnESRwAoT0JiZTYfWmstPoPrR9Yq+sWWFqABZMOl4tbyNwK+
	urLd18nw1OTy6V3fARl7/C
X-Google-Smtp-Source: AGHT+IHQBtQtI7r39tWn+pLgdNLjX417IlhSK2z3be84raVL6h4jTCN1X1cDcmaWptc76Hp4vCtNZA==
X-Received: by 2002:a17:906:c14f:b0:b41:abc9:613c with SMTP id a640c23a62f3a-b49c3d68af2mr1749313166b.51.1759788586244;
        Mon, 06 Oct 2025 15:09:46 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652aa04bsm1245503266b.6.2025.10.06.15.09.45
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 15:09:45 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-637ef0137f7so9007137a12.1
        for <linux-integrity@vger.kernel.org>; Mon, 06 Oct 2025 15:09:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVPbwUk2w+9rZ3CSbJLCppxUhDDA+yZugkbnRZWSiJgoxz/EkqfRB4uUQGgqmu8TIx8gCdx28BvuG8+VSA5QJo=@vger.kernel.org
X-Received: by 2002:a05:6402:34c6:b0:638:1599:6c34 with SMTP id
 4fb4d7f45d1cf-63939c24f04mr14265679a12.21.1759788584720; Mon, 06 Oct 2025
 15:09:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aOKTFv1vh1cvvcLk@kernel.org> <CAHk-=whSe9AGigVydkwo=ewE6_GFTJ_rU=XzO=v1N1sWyfVmAw@mail.gmail.com>
 <aOO3NKegSrUQ4ewg@kernel.org> <aOQ3V6M-wWQxxCWK@earth.li>
In-Reply-To: <aOQ3V6M-wWQxxCWK@earth.li>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 6 Oct 2025 15:09:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgEszQD56Q2EZ83EhzJK+OnqPaAkUavfPWako2rA8Z4uA@mail.gmail.com>
X-Gm-Features: AS18NWC-seoJUwFefSk_kijwQa6IpywQiR1JR3Kf97fiLCY3_kM93cgcwAVjtWw
Message-ID: <CAHk-=wgEszQD56Q2EZ83EhzJK+OnqPaAkUavfPWako2rA8Z4uA@mail.gmail.com>
Subject: Re: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-v6.18
To: Jonathan McDowell <noodles@earth.li>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jonathan McDowell <noodles@meta.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 6 Oct 2025 at 14:40, Jonathan McDowell <noodles@earth.li> wrote:
>
> I'm not sure _reads_ make sense for the TPM device files at all. It's a
> command + response interface.

Yeah, I won't disagree. My main worry was one of "existing users doing
odd things shouldn't then get new semantics"

I don't actually _expect_ people to do odd things wrt /dev/tpm and
friends, but I've so often been surprised by the odd things that do
happen that...

> What should we do if we get O_EXCL and O_RDONLY? Return an error? Ignore
> the O_EXCL flag?

Either of those likely is perfectly fine. Just ignoring it is the one
that adds the smallest possible ABI change, so in that sense it's the
"safer" option.

But you are probably right that there aren't any users that open that
thing read-only in the first place, much less then using O_EXCL.

Except I've seen programs that "work" by virtue of having done
entirely the wrong thing that just happened to work. Things like using
the wrong values entirely for 'flags' to open(), but the bits we cared
about happened to be ok, so...

And we have *traditionally* very much ignored O_EXCL when not paired
with O_CREAT (and even then it's iffy with NFS).

So people might just have random crud in the flags. That's why I
reacted originally: O_EXCL does make sense as a "open exclusively"
based on the name, but realistically we never actually *use* it that
way except for block devices.

So we *have* had those semantics for block devices, and they make
sense, and I don't mind the change at all per se.

But this is the kind of thing that I react to just because we have had
unexpected behavior in the past when a bit goes from "don't care" to
"meaningful".

Put another way: I'm probably just being unreasonably worried.

                     Linus

