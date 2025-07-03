Return-Path: <linux-integrity+bounces-6605-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A70DAF7325
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Jul 2025 14:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33E06540EEF
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Jul 2025 12:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC2D24DD07;
	Thu,  3 Jul 2025 12:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i3RA8Col"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFA523BCF1
	for <linux-integrity@vger.kernel.org>; Thu,  3 Jul 2025 12:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751544072; cv=none; b=cdQG0PXX7WZuTxfAJZWQmmBvSHfft9jrjr6YvVfdM+wxsZKFoyaDanGuf6eu7Swo/NG8nHc/cbafm7hmERMabI6fT5wYHxF3oYOmh+CVzlS2qbz4VpJN255EOtTwc6rSie1kPsLiiKE7gqzhgQoYqLhZLUXdWMNNnsAR/3RFgXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751544072; c=relaxed/simple;
	bh=BE7NpfSxuT8aRoWOiPKwFaS1w+KBmnJ1TI+18HzW7t0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cqdrklnkyJEeuiSY3vAB75uTvg9YdfGD+esJehD9MxEuFE8XzP6aTUDI+TBrenOpzUMUo/nXP0OneSvIa8Rtt2CpcyO3/poHsUVsi0zxry6xgRHin5aI7VE2F3X9T/GQO+vwRq/DzNs7SoN9uBZGtsnjnV0+p2a16yJMBFIW4b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i3RA8Col; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751544070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bPoX57YK7LoNIu5pswW1pE5MCRhCthGYL+5iTRSZhnI=;
	b=i3RA8Coln6ADqflHsVc2GBtRrt6toqOG1W/bxX+RbBSrUSzwGXygnL2xR09Q9v/UWHuOuM
	iqlMe+VSriXpx+faTzeJCHeVcEciPYSTsOUtRhz3JK4uoJtS4m+jQYHna7OJOtd2vj9VA8
	cTwsrtV2Af3k8+nhXumNuZVLElFLJgA=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-s5idvJVQM5m0IYEIvSWsvQ-1; Thu, 03 Jul 2025 08:01:08 -0400
X-MC-Unique: s5idvJVQM5m0IYEIvSWsvQ-1
X-Mimecast-MFC-AGG-ID: s5idvJVQM5m0IYEIvSWsvQ_1751544067
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-70e5e6ab756so77259927b3.2
        for <linux-integrity@vger.kernel.org>; Thu, 03 Jul 2025 05:01:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751544067; x=1752148867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bPoX57YK7LoNIu5pswW1pE5MCRhCthGYL+5iTRSZhnI=;
        b=oZyXVhtvI6e9GUkOUN5qyosa0IJiyVAsjM+w3jzizXEznO7qQy3G1BCyZxfGbEQfN8
         LuJZeEC1A4eG24lu8QNtYDyIwwRROKpEP+OgJC7bJhQDwYv7cGJ3ci7bndpQnA+sFp2k
         TErXr+6PJiefJTLs9O/u/m77Di2XEwvsnYvRJCKr5S+0+fhNShZ+c9aROmCfK93skNCI
         XnaWv45nUYO7XzaKQ7f2w3EgSsb0ld9Seg3Xw3C259/78k4CTAem9TPgAw7wqYdIQ7/l
         qzojdnW8qykvpT8cEeY8eP5xt+5IVsUH2L44ZDmivzLBGg+F/n9hrOi1zuNk0nYA2Rs0
         Z8mg==
X-Forwarded-Encrypted: i=1; AJvYcCUwcN52tGQZaUW2/PZJnKKkNO9qNwnahUbDnWbsYO9j0DWmnodfLAh7uTvBuY2kTw+W5p0zLNCRKU28RYB1Pnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSJxuXW3tdrB/m0NDhvcQaz/IwAgxvSAnKFJYrcbDIfjefuMig
	MNMgimgAKMnKSUegVZMpsUOILdEJu/9+GOKOahPfaDqGRO9xGIWy8fKksw32CLdlwOsBPx38zQT
	GZq/pjWvUGNucL8vzOCLw/g9O7oEMV25sUxfORuN6Tch1f76Y/Khr4cFYvh+VD0s2DcBx4zPN+h
	sFLoo8IS+lCeEdx8pl+CrwoXDpqjGkPWkES8vnpB7S26ic
X-Gm-Gg: ASbGnctQeKjJKycAuuIBWLon84zAksxbxnYZarpylBhDbFtbkW0YFyr+HljFwBN0KpY
	DuPlZbiOaW3UnRzDueW7NaDB58fNJjnHRU1r71HvhmCEui8ECDvg4JUhIICvgsa4ZDrhq/xo+4O
	bcZDy0+OUgCOlQSuCT1S12w6RujEqOjUIO5MHl
X-Received: by 2002:a05:690c:7012:b0:70f:83af:7dab with SMTP id 00721157ae682-71658fd788cmr43087857b3.4.1751544067531;
        Thu, 03 Jul 2025 05:01:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG26rBqu0QTdXURnTxVDVstDMG//Mh8XuMdlWYtR+O8nu0h4UWT0gOd8dv7a4Atlh4YhzcVtX6p4ARdT4a5lCw=
X-Received: by 2002:a05:690c:7012:b0:70f:83af:7dab with SMTP id
 00721157ae682-71658fd788cmr43087407b3.4.1751544066997; Thu, 03 Jul 2025
 05:01:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702202851.33344-1-daleksan@redhat.com> <aGW2wabMXtdBEQxR@kernel.org>
 <CAG+gbFfKLCQND-TT8DEZ09T=Nhb39_CJfM5imv341Pen03bHjw@mail.gmail.com>
In-Reply-To: <CAG+gbFfKLCQND-TT8DEZ09T=Nhb39_CJfM5imv341Pen03bHjw@mail.gmail.com>
From: Denis Aleksandrov <daleksan@redhat.com>
Date: Thu, 3 Jul 2025 08:00:54 -0400
X-Gm-Features: Ac12FXxLLeO8nKN6jrfnmu9Ej8R3Z4PfPKr86w8SuKNqc2v8fZ4sdQeKB9noZtQ
Message-ID: <CAG+gbFfLP1Y=HgRfzjhT4uJ121keQ0ZKo=4saB3uqnZYyoV8JA@mail.gmail.com>
Subject: Re: [PATCH] tpm: prevents local DOS via tpm/tpm0/ppi/*operations
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org, 
	Jan Stancek <jstancek@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jarkko,

Thank you for the review. I'll add your Reviewed-by tag to my local commit.
Please let me know if you would like me to send a v2 version of the
patch with your tag included.

Best,
Denis


On Thu, Jul 3, 2025 at 7:56=E2=80=AFAM Denis Aleksandrov <daleksan@redhat.c=
om> wrote:
>
> Hi Jarkko,
>
> Thank you for the review. I'll add your Reviewed-by tag to my local commi=
t.
> Please let me know if you would like me to send a v2 version of the patch=
 with your tag included.
>
> Best,
> Denis
>
> On Wed, Jul 2, 2025 at 6:46=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org=
> wrote:
>>
>> On Wed, Jul 02, 2025 at 04:28:51PM -0400, Denis Aleksandrov wrote:
>> > This bug is not seen on most machines. Reads on tpm/tpm0/ppi/*operatio=
ns
>> > can become very long on misconfigured systems. Reading the TPM is a
>> > blocking operation, thus a user could effectively trigger a DOS.
>> >
>> > Resolve this by restricting unprivileged user from reading the
>> > above-mentioned device files.
>>
>> I suppose we can do this. I'm going to holiday for one week next
>> week so I'll hold for additional feedback for that period and
>> apply this if nothing comes up.
>>
>> There's no use case for unprivileged user, or app that stops
>> working because of this. If you cut hairs, with patch shifting
>> uapi you have to we always prepared that tree falls down
>> somewhere but I'm willing to take risk with this :-)
>>
>>
>> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
>>
>> >
>> > Reported-by: Jan Stancek <jstancek@redhat.com>
>> > Signed-off-by: Denis Aleksandrov <daleksan@redhat.com>
>> > ---
>> >
>> > Running scripts/checkpatch.pl suggested that the permissions be
>> > changed to octal format. What do the maintainers think of this?
>> > The rest of the permissions in the file are macros.
>> >
>> > Lastly, this bug was reproduced and the fix was tested accordingly.
>> >
>> >  drivers/char/tpm/tpm_ppi.c | 4 ++--
>> >  1 file changed, 2 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/char/tpm/tpm_ppi.c b/drivers/char/tpm/tpm_ppi.c
>> > index bc7b1b4501b3..ac6e0aee566e 100644
>> > --- a/drivers/char/tpm/tpm_ppi.c
>> > +++ b/drivers/char/tpm/tpm_ppi.c
>> > @@ -347,8 +347,8 @@ static DEVICE_ATTR(request, S_IRUGO | S_IWUSR | S_=
IWGRP,
>> >  static DEVICE_ATTR(transition_action, S_IRUGO,
>> >                  tpm_show_ppi_transition_action, NULL);
>> >  static DEVICE_ATTR(response, S_IRUGO, tpm_show_ppi_response, NULL);
>> > -static DEVICE_ATTR(tcg_operations, S_IRUGO, tpm_show_ppi_tcg_operatio=
ns, NULL);
>> > -static DEVICE_ATTR(vs_operations, S_IRUGO, tpm_show_ppi_vs_operations=
, NULL);
>> > +static DEVICE_ATTR(tcg_operations, S_IRUSR | S_IRGRP, tpm_show_ppi_tc=
g_operations, NULL);
>> > +static DEVICE_ATTR(vs_operations, S_IRUSR | S_IRGRP, tpm_show_ppi_vs_=
operations, NULL);
>> >
>> >  static struct attribute *ppi_attrs[] =3D {
>> >       &dev_attr_version.attr,
>> > --
>> > 2.48.1
>> >
>>
>> BR, Jarkko
>>


