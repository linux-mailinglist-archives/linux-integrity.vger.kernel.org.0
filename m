Return-Path: <linux-integrity+bounces-4407-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 928DC9F5A45
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Dec 2024 00:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6363B16108B
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Dec 2024 23:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47BF1F9AB0;
	Tue, 17 Dec 2024 23:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="DqX3yBaX"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2B31DDC3C
	for <linux-integrity@vger.kernel.org>; Tue, 17 Dec 2024 23:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734477411; cv=none; b=DvVTauk8Fa5Oxc3e4w32VtMpyQ7nzuMNl07AH+/F5a7x9CQorIRLuP+Q7U2OxvwI+kl6KpQxtIbEuB+jTvgXLMNnGHl1qMPPb5vq/9maeIfMKvE4rNic7eMBINCVfZnbYeigpjqrmSypWR67kYT8cL4ii2zNWRGGHAz6s0eJb+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734477411; c=relaxed/simple;
	bh=T5IUDsHdqezYhzvwKlYtXQeoWaqVsdrSmr02IZWPqb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kJUKdDzMiHkQwSf6otQeLjvFCZzfnV42K98z8vF2nBx9xxMNJ2aXQ0h6yLlkOEjKHj0BekyucgXN9rFM46fB1ccO0fAJnaWwIr7AhQ762Ajwp44o9pmbo/Oe1Yu7ebRgeTwZzPR+EBHIQwkNj+3Os+Skj1GHiz1gTXu0Jpm353g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=DqX3yBaX; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6f006748fd1so46470017b3.3
        for <linux-integrity@vger.kernel.org>; Tue, 17 Dec 2024 15:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1734477409; x=1735082209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZpZZca6m8n2NS8VtZHu44VsFFmS7EyCvl9umOy8ljM=;
        b=DqX3yBaXG2US0bZqNn3/CHTxIMM0RSPYjArrxUvKf3jWTtIl/B2zRAG9bXpGXHNgn6
         zYtXMQGmYwNsVclrAZusI15chw4YldIwuemVt/Zxm3i67KH+qk7zOXFif7YBrE68M9/Y
         v20bvQlrFpDUV8YzdkLqrQ76BtRHVvlknLzIzg2wFC2RCcLO9Ajm43VHJCH4sKLFiD38
         gBE9T0MgchD00Mh0PfPThETC4/uqeyQUFhp3Is/w1LG3XQ7p6mFRVEpl8+l/TeKCD5Wg
         F6IKXWTQMjad49FaJbqYso5c8ciMp1BNhuvfE4MFUEkwpOlogH24Kds4Vqwm6Z4GyNZ/
         PfLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734477409; x=1735082209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JZpZZca6m8n2NS8VtZHu44VsFFmS7EyCvl9umOy8ljM=;
        b=uQ/yJNXE9uBSBC9hJxzRSrLTjJARB7YMs9RpZ3RuOHsmegexnAkF3S9+8/uaeqVQNo
         zfH6e1Koi4Jlt2Eyd2CYc4+6Qs3KQZ9H9de50lXz0nCi8rRYpodQ/Lnn2eFrDgdI0cE2
         YlfTTgdc4QcIgKiBrrnE6GpoN8RWfgp8cjdqpQSlmd6aDdksO9ziXhza/M5oGOouht6R
         KjSI6yEsTwlBJF4iboQoiZBiuGqvut9w/x4TUO8YMyOEWA0JZVzYlEp/B0e+zddX84ww
         pUsJMg+KwE2UA+p8dnwAUpF5VNsA0ccGo7pVF15mw8R6OhLc+D0DmEXRIVCm/kljfOgZ
         aMNA==
X-Forwarded-Encrypted: i=1; AJvYcCXMX5vFaMPi8NAXA2Z4n9tMZvtA+H0xAkkwquJ08truUe2nigygAWlKx45ZypgSG5SaZIq/2ZKofZYo236XbEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ/7/RfFhVKmvx7KcEVBMmxkXPt6WhhpiXY7AnI3Ci8WIb7rzk
	emreFXXTAycP0+X2aB4k5FjiC+WL+EbN3l1q8ZpWlJXavJ9TzYOWV50q519wqLZlLwfWqaSZKGj
	qWcWLxCSHx7gP3GfKaVROyVNnWxFrpJ95Z5bq
X-Gm-Gg: ASbGnctEu1RPFLSEf1KKIsZVErze+K0/cDg4qV0GAav8LI8NtzwQSCR86yPg/VRkgqo
	6fLa+GTN5SSbc0kBdlRueIZbTmPOm+N7ujbu8
X-Google-Smtp-Source: AGHT+IFRPfpjDzzrONQwYyV3M5Sx81AcjXWpz+0lyTANLevp6Y2aXdkLr52G7Eh6M0IhlXMXIR8uiYUYIAXFr0z6OAE=
X-Received: by 2002:a05:690c:25c2:b0:6ee:6e71:e6d6 with SMTP id
 00721157ae682-6f3d0e313f0mr5363727b3.23.1734477409076; Tue, 17 Dec 2024
 15:16:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217202525.1802109-1-song@kernel.org> <fc60313a-67b3-4889-b1a6-ba2673b1a67d@schaufler-ca.com>
 <CAHC9VhTAJQJ1zh0EZY6aj2Pv=eMWJgTHm20sh_j9Z4NkX_ga=g@mail.gmail.com>
 <8FCA52F6-F9AB-473F-AC9E-73D2F74AA02E@fb.com> <B1D93B7E-7595-4B84-BC41-298067EAC8DC@fb.com>
In-Reply-To: <B1D93B7E-7595-4B84-BC41-298067EAC8DC@fb.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 17 Dec 2024 18:16:38 -0500
Message-ID: <CAHC9VhRWhbFbeM0aNhatFTxZ+q0qKVKgPGUUKq4GuZMOzR2aJw@mail.gmail.com>
Subject: Re: [RFC 0/2] ima: evm: Add kernel cmdline options to disable IMA/EVM
To: Song Liu <songliubraving@meta.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, Song Liu <song@kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"roberto.sassu@huawei.com" <roberto.sassu@huawei.com>, 
	"dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>, 
	"eric.snowberg@oracle.com" <eric.snowberg@oracle.com>, "jmorris@namei.org" <jmorris@namei.org>, 
	"serge@hallyn.com" <serge@hallyn.com>, Kernel Team <kernel-team@meta.com>, 
	"brauner@kernel.org" <brauner@kernel.org>, "jack@suse.cz" <jack@suse.cz>, 
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 5:47=E2=80=AFPM Song Liu <songliubraving@meta.com> =
wrote:
>
> If we use lsm=3D to control ima and evm, we will need the following
> changes in ordered_lsm_parse(). We still need supporting logic
> in ima and evm side, so that ima and evm are only initialized
> when they are in lsm=3D.
>
> Does this sound the right way forward?

Have you tested it?  What happens?  There is value in going through
the testing process, especially if you haven't played much with the
LSM code.

I'd also want to see a comment line in both places explaining why it
is necessary to mark the LSM as enabled prior to actually adding it to
@ordered_lsms.  Something along the lines of only parsing the
parameter once should be sufficient.

> diff --git i/security/security.c w/security/security.c
> index 09664e09fec9..00271be3b0c1 100644
> --- i/security/security.c
> +++ w/security/security.c
> @@ -365,6 +365,9 @@ static void __init ordered_lsm_parse(const char *orde=
r, const char *origin)
>                         if (strcmp(lsm->name, name) =3D=3D 0) {
>                                 if (lsm->order =3D=3D LSM_ORDER_MUTABLE)
>                                         append_ordered_lsm(lsm, origin);
> +                               else if (lsm->order =3D=3D LSM_ORDER_LAST=
)
> +                                       set_enabled(lsm, true);
> +
>                                 found =3D true;
>                         }
>                 }
> @@ -386,7 +389,7 @@ static void __init ordered_lsm_parse(const char *orde=
r, const char *origin)
>
>         /* LSM_ORDER_LAST is always last. */
>         for (lsm =3D __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> -               if (lsm->order =3D=3D LSM_ORDER_LAST)
> +               if (lsm->order =3D=3D LSM_ORDER_LAST && is_enabled(lsm))
>                         append_ordered_lsm(lsm, "   last");
>         }

--=20
paul-moore.com

