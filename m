Return-Path: <linux-integrity+bounces-4355-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8445A9ED257
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Dec 2024 17:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DCA51889853
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Dec 2024 16:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D8A1DDC14;
	Wed, 11 Dec 2024 16:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hb9USl7V"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D7F1D9A6F
	for <linux-integrity@vger.kernel.org>; Wed, 11 Dec 2024 16:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733935343; cv=none; b=UeOvv7yP+5KO+wdh6jwppNJFxU0iPTsw/0c7NVsFUWZJXS4NlzD5sXGngy9a8VLfMjsIgcn1bpJciase/GBghoNKLPa4S2QLngEzJTlHiqmoTWihGOVPcZcHzNiz0QKs5Yjw28AGkJzuQQe7EcThS0BOBvsinC1oB027CrZPwm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733935343; c=relaxed/simple;
	bh=ZWKFASmhjwAGqbYokVzWZLsYyd33PT09aF7jLzAdQVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=avDEusUzN8NLvYKUcM/33O2R+zHakTj7zwL30xGoWbhAZaTZOiBEdiqDKh+iMeEGDDz+4wYKAN9OudLiYIaUtZThJSdImcu++Z4E9GS90K3GZo/yfB1IRsAuYbIL7munml0wLEmKV7YtTwppDp3zcBRffx3qIQdj8v8z/h6pdcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hb9USl7V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733935340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZWKFASmhjwAGqbYokVzWZLsYyd33PT09aF7jLzAdQVw=;
	b=hb9USl7VE6DLO09D0wSoCteH0oa8JuUdHnktNBWqP+7/HSL6sWkVGkFeVPvS/NtAhyUfIc
	XApa1byH6WbKo/AKypUjmDT4jqOWs2d1ukGp1PgXNnMQB4BuW5BUcBhEiTV/G746HrY9vH
	4QlOVm6LQOz9ie5obRB6l/jOVzlRVPI=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-CSZHxTe9PvGVqWzu_RUfcw-1; Wed, 11 Dec 2024 11:42:19 -0500
X-MC-Unique: CSZHxTe9PvGVqWzu_RUfcw-1
X-Mimecast-MFC-AGG-ID: CSZHxTe9PvGVqWzu_RUfcw
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-6efed4768cdso44045667b3.3
        for <linux-integrity@vger.kernel.org>; Wed, 11 Dec 2024 08:42:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733935339; x=1734540139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZWKFASmhjwAGqbYokVzWZLsYyd33PT09aF7jLzAdQVw=;
        b=cGKlSk7LRwHqfhxgR9+olwcFZ+X/Y8oc1s2/4Sr4+Dl27nYH7Y/FPxRtlAKiEQz4x4
         Jn6BTc0Jh2yx7hfPyjJUFS8WJxCBbRPB4fcG53PoroIeU5WPI+TWoGqdSjUlJb8E+Vd9
         5qob/Pr2KxW04SVLxiLh1QwMAPouIrJwOVIlfHhfk2QMfwILa3/zMT6MecNn17TLMg2j
         FG4dUkr8moR80UEmNDZXeBEjOjTvjI6ztONZ4ERhWoiark1uTco98vJ6T/lPqO3bxmSj
         m8YECoMNenI07hrcsFZjCSFTmE18e2qTy8ttsv9xwWVHonTv5OU4r5uxM5rqdLv09LK+
         rZqw==
X-Forwarded-Encrypted: i=1; AJvYcCVg9aqGaUo2IVCjbmabexhJ01HRWYN2n+HdJIMOV2Y05eV3rtXQN9ELd6mZPYUxsz5iePzIUxU/rB+RVQqtoGI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxrpz9kmqXEDz9bltU1XeCtWOT3aEgPC+/87N8TRMIl/SAhzm8
	bi3KMaPJu5/w3inoenqlIY3DmyoIP/TZLLzcIMFJAZvIuHZnXHZo79ardMVVBalmdgMpNEtJ5wf
	eawpmGgdsckurVJoiFIHpB+qYn5Yo9UI0XS55C2ZfpnGo/tVdx93cBnBxuV3fQzobTJFeyu+mX3
	CGEBeY9MKG9Olwri+jQTkhSvz2s4nbnFVNZN3dYhZq
X-Gm-Gg: ASbGncsUAMS8DsM7NOK/sAd+ousJc9JgAVIZRh/cXEv1y2RO5+3EsmASiEF6zAGw45s
	t6sbE4fGXNvd8uBY9ix0pIMZIDqgxnauqQw==
X-Received: by 2002:a05:690c:7209:b0:6ef:4696:f1cc with SMTP id 00721157ae682-6f19e507948mr1535007b3.22.1733935337418;
        Wed, 11 Dec 2024 08:42:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/XJy9SvqHMi5QS9auWTLUBW5pkqCymbkP9cFTfBTmSyV+DzOhB5ok1fIsYYsnyOBoX0jGlj/OTH7H/+3usaY=
X-Received: by 2002:a05:690c:7209:b0:6ef:4696:f1cc with SMTP id
 00721157ae682-6f19e507948mr1533757b3.22.1733935335549; Wed, 11 Dec 2024
 08:42:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210143423.101774-1-sgarzare@redhat.com> <20241210143423.101774-4-sgarzare@redhat.com>
 <20241210144025.GG1888283@ziepe.ca> <50a2e1d29b065498146f459035e447851a518d1a.camel@HansenPartnership.com>
 <20241210150413.GI1888283@ziepe.ca> <CAGxU2F6yzqb0o_pQDakBbCj3RdKy_XfZfzGsiywnYL65g6WeGg@mail.gmail.com>
 <20241211150048.GJ1888283@ziepe.ca> <CAGxU2F5NSqMbA1Lep3+16GoZXR23q0OP8dFVVRJ6DG5sF20R3Q@mail.gmail.com>
 <20241211155358.GK1888283@ziepe.ca>
In-Reply-To: <20241211155358.GK1888283@ziepe.ca>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed, 11 Dec 2024 17:42:03 +0100
Message-ID: <CAGxU2F51EoqDqi6By6eBa7qT+VT006DJ9+V-PANQ6GQrwVWt_Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] x86/sev: add a SVSM vTPM platform device
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, linux-coco@lists.linux.dev, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Peter Huewe <peterhuewe@gmx.de>, "H. Peter Anvin" <hpa@zytor.com>, linux-integrity@vger.kernel.org, 
	x86@kernel.org, Joerg Roedel <jroedel@suse.de>, Jarkko Sakkinen <jarkko@kernel.org>, 
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Claudio Carvalho <cclaudio@linux.ibm.com>, 
	Dov Murik <dovmurik@linux.ibm.com>, Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 4:54=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Wed, Dec 11, 2024 at 04:38:29PM +0100, Stefano Garzarella wrote:
>
> > Except for the call to pops->sendrcv(buffer) the rest depends on how
> > the TCG TPM reference implementation [1] expects the request/response
> > to be formatted (we refer to this protocol with MSSIM).
>
> Make a small inline helper to do the reformatting? Much better than a
> layered driver.
>
> > That is why I was saying to create a header with helpers that create
> > the request/parse the response as TCG TPM expects.
>
> Yes helpers sound better

Ack, I'll do in v2 (together with send_recv op) if there are no
objections or other ideas.

Thanks,
Stefano


