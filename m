Return-Path: <linux-integrity+bounces-2563-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D88688CCD95
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2024 10:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 661D1281C82
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2024 08:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F140613CF82;
	Thu, 23 May 2024 07:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOvjj4vW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F6C13CAA4;
	Thu, 23 May 2024 07:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716451171; cv=none; b=KVKRVgpJLQ0FyA8/TVaU5kS7/36qZxNYV/ULzR2wxmQpxbEhZK+x+LUrDvHu7i6YRsPdlVzqld4hZgn5VAwh9OxXxgews6kEjmJ+YuJfAhYCgZeRBdljLpmo+oAevSZeKHPLZ3bHh7dVQ480F87Honr0GWXi52kt7cpnU2kvOTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716451171; c=relaxed/simple;
	bh=WtSnqLqjaolEMd13H+N82n7kj2rcAGt469kIrKiluQM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TmMcvX1RCoVbpYmT5j1xQA0zxf6yj6Pjw7OT2IN+Js9RBQPdYjUAhRy5c6RGJY3SCXbxXGcE2tBf9nPziX2KnJXT8YHVV7TcEbEwIt6MJlLLAlAcxwkuHW7gmt+ukXo+ftZYPtrtzfwCspi4uAmRjSOZet44QKCE5yqzHRtZUds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cOvjj4vW; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2e1fa824504so71431081fa.0;
        Thu, 23 May 2024 00:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716451168; x=1717055968; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WtSnqLqjaolEMd13H+N82n7kj2rcAGt469kIrKiluQM=;
        b=cOvjj4vW/lJwlTx2Qjui0thz8B2ebqwfCFawPUz7kpZ2GwhYOziwNdMh63s1FyKKg0
         PNRZUt7tL3GLulE3SfDBj+GbHg7D2V2pe62yNjW/kwtWQOOe4hVBPONBd7ZQw2a7JE/8
         hL8fQ5GEyE/rdOj7ErvNOeEQdqumqsUyI3RvFPQbqZpqi9sBb2JSTl+AFkDBflwM54EC
         gm96vfIGhkAcXMZd4pb07MQ1xwubBN6oKe5ewCsroiH/40fDTs7pnlfwM4SnlUezI32W
         dCFZ0ZZ9sXeQFxdZc5yDD9iPhwmsKUr3QTdbc0falRnud90o5vh/PFzLSQJxtctI73TG
         xbEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716451168; x=1717055968;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WtSnqLqjaolEMd13H+N82n7kj2rcAGt469kIrKiluQM=;
        b=HLU9teLXlrlnzmOhR2G+z00gxBE1rLfH43aSfo5ZvUnZzMeJ9jUK5gzPDtYkmd9TGQ
         TIB3tIfppnFpSbYhH0P11J2an8tQKgn7PG73JSOSEidIo5ycaQ6cZTbyXrcmK/DbesGR
         Pne7H3fgNpi9FfGWiIoFW6h/VE5S3Ms+CLISfdCDF1JBeUszxlGAdRe13wEnfA3q6fsK
         whhdzdCooSjyVUfkc3zTNwi+g1tgNZWb+NIxE1Hfw9NZyJgir8lmEtNfK3gcX+iGfl+T
         k5zyrehzUmoBtEehF95yhNXihX54VqQll+i/2kmgythmDln7tYi6EeJHiYA4ycbaiF7D
         PR8g==
X-Forwarded-Encrypted: i=1; AJvYcCU90DNY6ELE4iRQhlA3CEmL2uZZFILtPbEskW0wR1DCEQFj9qcXJPOJTw+5oGtJgvNTvhGebDw5KKElCOd5A4cfLWtDPAqreNTVuw88ciAm0XiE8qcUT3HYuHDSgl0FOn+JAgjPoA7cAL4tvmBiC/JirzhJq4wi9EdMimS8N3q1fABm6TVaodTBAXjJBa06mtNyFFzT
X-Gm-Message-State: AOJu0YzhJ5LMFjYutz/ENYoTYwPuuNpUPe+cf7AaVo2j2E2pLKz4ngB0
	n0u2u1em2MwRywROTYQ2ayLSexrGRTQTtAXv5dJx0oDKoxUNf9ZT
X-Google-Smtp-Source: AGHT+IHj83isYx5eRRBpiHrJyvX73GmHx3W8fORWFJYjD+n/EEYdfg/dboaPB2E2XnPdmJx6mCHvbQ==
X-Received: by 2002:a2e:944a:0:b0:2da:50f8:dfab with SMTP id 38308e7fff4ca-2e94944139amr23917821fa.7.1716451168022;
        Thu, 23 May 2024 00:59:28 -0700 (PDT)
Received: from ?IPv6:2001:8a0:e622:f700:5f49:e958:98cd:f4c3? ([2001:8a0:e622:f700:5f49:e958:98cd:f4c3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100f591cbsm17285555e9.22.2024.05.23.00.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 00:59:27 -0700 (PDT)
Message-ID: <3e4bbd0f0fe9f57fd7555a3775e8d71031c0d6c5.camel@gmail.com>
Subject: Re: [PATCH 1/3] tpm: Disable TCG_TPM2_HMAC by default
From: Vitor Soares <ivitro@gmail.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, James Bottomley
	 <James.Bottomley@HansenPartnership.com>, linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>, Jason
 Gunthorpe <jgg@ziepe.ca>, Mimi Zohar <zohar@linux.ibm.com>, David Howells
 <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, James Morris
 <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Date: Thu, 23 May 2024 08:59:26 +0100
In-Reply-To: <D1GAZSIOZVWW.2UZBFHASIG21U@kernel.org>
References: <20240519235122.3380-1-jarkko@kernel.org>
	 <20240519235122.3380-2-jarkko@kernel.org>
	 <850862655008f84ef0b6ecd99750e8dc395304d1.camel@gmail.com>
	 <D1F4V8NMSUNZ.2VCTEKHZZ0LB@kernel.org>
	 <17dc838120b56ce342c34611596c7b46dcd9ab5a.camel@HansenPartnership.com>
	 <2dd8d49516ec9c7cb8c1182b5b8537b1e82d7067.camel@gmail.com>
	 <17a5dcd7aceb356587ef7c8f45b0f6359b2d2a91.camel@HansenPartnership.com>
	 <D1G8HOCIDWTC.2ERVA0CYHLY0B@kernel.org>
	 <0c12c9ea10aa97e246230fc33e6b35c571102b48.camel@gmail.com>
	 <D1GAZSIOZVWW.2UZBFHASIG21U@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-05-22 at 19:11 +0300, Jarkko Sakkinen wrote:
> On Wed May 22, 2024 at 5:58 PM EEST, Vitor Soares wrote:
> > I did run with ftrace, but need some more time to go through it.
> >=20
> > Here the step I did:
> > kernel config:
> > =C2=A0 CONFIG_FUNCTION_TRACER
> > =C2=A0 CONFIG_FUNCTION_GRAPH_TRACER
> >=20
> > ftrace:
> > =C2=A0 # set filters
> > =C2=A0 echo tpm* > set_ftrace_filter
> >=20
> > =C2=A0 # set tracer
> > =C2=A0 echo function_graph > current_tracer
> >=20
> > =C2=A0 # take the sample
> > =C2=A0 echo 1 > tracing_on; time modprobe tpm_tis_spi; echo 0 > tracing=
_on
> >=20
> > regards,
> > Vitor Soares
>=20
> I'm now compiling distro kernel (OpenSUSE) for NUC7 with v6.10 contents.
>=20
> After I have that setup, I'll develop a perf test either with perf or
> bpftrace. I'll come back with the possible CONFIG_* that should be in
> place in your kernel. Might take up until next week as I have some
> conference stuff to prepare but I try to have stuff ready early next
> week.
>=20
> No need to rush with this as long as possible patches go to rc2 or rc3.
> Let's do a proper analysis instead.
>=20
> In the meantime you could check if you get perf and/or bpftrace to=20
> your image that use to boot up your device. Preferably both but
> please inform about this.
>=20

I already have perf running, for the bpftrace I might not be able to help.

Regards,
Vitor Soares

> Fair enough?
>=20
> BR, Jarkko


