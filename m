Return-Path: <linux-integrity+bounces-6329-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA86FAC661B
	for <lists+linux-integrity@lfdr.de>; Wed, 28 May 2025 11:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C13BE188EBE7
	for <lists+linux-integrity@lfdr.de>; Wed, 28 May 2025 09:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D7927815C;
	Wed, 28 May 2025 09:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EPzg7pbW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4892777FE
	for <linux-integrity@vger.kernel.org>; Wed, 28 May 2025 09:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748425015; cv=none; b=CTcetk37dH8YRsXtlNdUPncqLy7RFee878vHh7UK3o5iSrdK9zOp0rRvwKoNoQRXaXFnmFG8vbYGwtjhBdDv/iOG5m4CpD2i311zwuuIVWGIupsafAH28B1wQoNTUheKZzaVqLRX6TW1P/E6/aegSZLiQIPKRUH3YgC6yuC+WuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748425015; c=relaxed/simple;
	bh=vDWBFnGA0k389540wW0TxBm2BDLauq2fIsIA6VzBngM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UzLTkLLSslUEb7r6dT19vwFw5ZbUzdnLM8llLl/pTmviqdCje+Kgf9CbMjECBBuQG3sEy3UfzXBRkaGzs6yFOkUbMHxY3ZCI/7H1sNfNcX0Mkx1eKoZvfVEcekBz3YZllWaxRgrxhATgH7CRARn9newGNAQashlxbQONtduHND0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EPzg7pbW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748425012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=85Gu31AX4i+RipKK9PhYFJqj5Wm69Shqzwvkaki3CxA=;
	b=EPzg7pbWVIEIjQE4LiXxN0KE0vcD5KYOiLP5bSMXlRgHFrCijhIjtzYIRmzQ8HsERc0Jif
	T9UoAvkm62aO+eRtzu+HQC6GzrPuHAS7fOh6/PhI+c8kVQhBqj9wdFpRRX22vIfi/k4wEZ
	i1AxMEwSReNfuZ+aYTThON+JKfBx1cc=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-3hVY1SusNtOsCSpm0P9ymQ-1; Wed, 28 May 2025 05:36:50 -0400
X-MC-Unique: 3hVY1SusNtOsCSpm0P9ymQ-1
X-Mimecast-MFC-AGG-ID: 3hVY1SusNtOsCSpm0P9ymQ_1748425010
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-70e4e62caa7so12744767b3.1
        for <linux-integrity@vger.kernel.org>; Wed, 28 May 2025 02:36:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748425010; x=1749029810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=85Gu31AX4i+RipKK9PhYFJqj5Wm69Shqzwvkaki3CxA=;
        b=jVbUBj9lXJLwR69N1/T931JNlc122iiVTIoLMfE668R5PJMTHCz3RWxyfkPUoBdbvD
         ZwM7ipxNUjeYb6lf9FAl/YtxGOWA7+0lQG0AnGZYkJ49hMggNad+yeb4Y6xYCxHFyPkH
         kJrdmEY8TcTnI4197XXFQI4NFfitKeRjO8jxehZt6iICN+uubNqXBEkKjhuYWCGrOqyu
         1rI9t2N3oQQxaO4p+W1mZNQyfml+PsIHdDiOrUfp2s377w7fE9TwrfFpla3NIEhPjW4o
         gIK+l7xUnB+lKR7+9GXFKrB2xxDovGVyunl8uyjke94tHppkbHIvxB2YOedXYsmvLqyz
         29Ow==
X-Forwarded-Encrypted: i=1; AJvYcCWU/aAkQoKxWImdFp50U+VKDLJpaGT04iBs+HhV20knMu6NIMH8hFVQ5u7mzgMLXpu1btgxTd63JKRwi2Yb/bc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCDHZeiROAXpGoBW51Cc5dPMA7TbOyJkjP7RCMxlAfyDECv6T9
	tAuC67CtmQ6EM0MS1nRC7pD0qSqw6jNCgBBUHhVnGD0V1ezk6c6nevVshEDH4nJs5ze4IsTTQib
	cP1uJP363JRtaBs0FHB/eqP9WloGLGJXTsaugwEpX5t0Snu9P57C2MoUWPybIVLY3s2WXfCU8BK
	0LoG/ME30K3h+21De1UovP3LYbTcLeBciE1xJzrBTjdYVA
X-Gm-Gg: ASbGncue1UlQkkyY2i5SBaVtEciPS8kvA7wjVrouQ64cEYgNHOv4qvx1fXJUyZb0tYd
	yUQHWOPN0FZyjCdsUmQ7qpOdP8Tulos5R2SJfvxJCHRwDoinXCgpImZV7XL6OIApbTA4=
X-Received: by 2002:a05:690c:f8d:b0:70e:77df:f2f9 with SMTP id 00721157ae682-70e834b6b4cmr57425647b3.15.1748425009826;
        Wed, 28 May 2025 02:36:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXA1MoCQlDKMj/vjnxFoa9Ixenafk5qpgMmQxoP02dNiKS+DPrf0CqCmu1prslFonOyD8BjXzpdP7DqDLgz1I=
X-Received: by 2002:a05:690c:f8d:b0:70e:77df:f2f9 with SMTP id
 00721157ae682-70e834b6b4cmr57425497b3.15.1748425009457; Wed, 28 May 2025
 02:36:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528065944.4511-1-zhaoqunqin@loongson.cn> <20250528065944.4511-5-zhaoqunqin@loongson.cn>
 <7ifsmhpubkedbiivcnfrxlrhriti5ksb4lbgrdwhwfxtp5ledc@z2jf6sz4vdgd>
 <afaeb91a-afb4-428a-2c17-3ea5f098da22@loongson.cn> <gymx5tbghi55gm76ydtuzzd6r522expft36twwtvpkbgcl266a@zelnthnhu7kq>
 <ccb1927d-c06a-9fde-6cbb-652974464f4b@loongson.cn>
In-Reply-To: <ccb1927d-c06a-9fde-6cbb-652974464f4b@loongson.cn>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed, 28 May 2025 11:36:38 +0200
X-Gm-Features: AX0GCFuU5sV9AGKLfPstLyLN5Vgt-467_AuqFJUq4Wo-VbvNceizn1yYcjklrNo
Message-ID: <CAGxU2F44BTLzY9T+7yYo+XqPuZky5nHd9+BtUy4QFnoVsehpDg@mail.gmail.com>
Subject: Re: [PATCH v10 4/5] tpm: Add a driver for Loongson TPM device
To: Qunqin Zhao <zhaoqunqin@loongson.cn>
Cc: lee@kernel.org, herbert@gondor.apana.org.au, jarkko@kernel.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, davem@davemloft.net, 
	linux-crypto@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca, 
	linux-integrity@vger.kernel.org, Yinggang Gu <guyinggang@loongson.cn>, 
	Huacai Chen <chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 28 May 2025 at 11:25, Qunqin Zhao <zhaoqunqin@loongson.cn> wrote:
>
>
> =E5=9C=A8 2025/5/28 =E4=B8=8B=E5=8D=885:00, Stefano Garzarella =E5=86=99=
=E9=81=93:
> > On Wed, May 28, 2025 at 04:42:05PM +0800, Qunqin Zhao wrote:
> >>
> >> =E5=9C=A8 2025/5/28 =E4=B8=8B=E5=8D=883:57, Stefano Garzarella =E5=86=
=99=E9=81=93:
> >>>> +    chip =3D tpmm_chip_alloc(dev, &tpm_loongson_ops);
> >>>> +    if (IS_ERR(chip))
> >>>> +        return PTR_ERR(chip);
> >>>> +    chip->flags =3D TPM_CHIP_FLAG_TPM2 | TPM_CHIP_FLAG_IRQ;
> >>>
> >>> Why setting TPM_CHIP_FLAG_IRQ?
> >>
> >> When tpm_engine completes  TPM_CC* command,
> >>
> >> the hardware will indeed trigger an interrupt to the kernel.
> >
> > IIUC that is hidden by loongson_se_send_engine_cmd(), that for this
> > driver is completely synchronous, no?
> >
> >>
> >>>
> >>> IIUC this driver is similar to ftpm and svsm where the send is
> >>> synchronous so having .status, .cancel, etc. set to 0 should be
> >>> enough to call .recv() just after send() in tpm_try_transmit(). See
> >>> commit 980a573621ea ("tpm: Make chip->{status,cancel,req_canceled}
> >>> opt")
> >> The send callback would wait until the TPM_CC* command complete. We
> >> don't need a poll.
> >
> > Right, that's what I was saying too, send() is synchronous (as in ftpm
> > and svsm). The polling in tpm_try_transmit() is already skipped since
> > we are setting .status =3D 0, .req_complete_mask =3D 0, .req_complete_v=
al
> > =3D 0, etc. so IMHO this is exactly the same of ftpm and svsm, so we
> > don't need to set TPM_CHIP_FLAG_IRQ.
>
> I see,  but why not skip polling directly in "if (chip->flags &
> TPM_CHIP_FLAG_IRQ)"  instead of do while?

This is exactly what I'm doing in the series I linked before [1] but
without leveraging TPM_CHIP_FLAG_IRQ's hack

>
> And TPM_CHIP_FLAG_IRQ flag can remind us this hardware is "IRQ" not "POLL=
".

But you're not handling IRQ through this driver, so for the tpm
interface sending tpm commands through this driver is not interrupt
based or needs polling, but it's synchronous, so this is why I'm
adding TPM_CHIP_FLAG_SYNC in [1] and I think I can include the changes
I did for ftpm and svsm also for this driver in that series.

So my suggestion in this patch is to do something similar of what we
already have for those driver, and we can set TPM_CHIP_FLAG_SYNC when
my series will be merged (or I'll include the changes if this series
will go first).

Thanks,
Stefano

[1] https://lore.kernel.org/linux-integrity/20250514134630.137621-1-sgarzar=
e@redhat.com/

>
> Thanks,
>
> Qunqin.
>
> >
> > Thanks,
> > Stefano
>


