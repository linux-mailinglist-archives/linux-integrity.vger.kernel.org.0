Return-Path: <linux-integrity+bounces-2890-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE808910DAB
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Jun 2024 18:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74225282688
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Jun 2024 16:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB321B3725;
	Thu, 20 Jun 2024 16:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ODwvZO3o"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462311B3721
	for <linux-integrity@vger.kernel.org>; Thu, 20 Jun 2024 16:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718902480; cv=none; b=g6B3/m0q/xmGVHunvsngm2G8q8z32xXZ36J0YU6QKVNnku8/6sNjVVyU08wpqOA/xSdOs23dt2b41BXy8ZEvxtih7HM0+YWIXY+ND5SoeW/JIDpEDjR7ubGRRVGEsK/8aKdf9MQnnULqBwpnqMx440QxU/qeEZW8vJcw744XG/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718902480; c=relaxed/simple;
	bh=Wqp9vZOjGXxNeztCTRhZXaV/kM8U5SAYlJJa2Su7aFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bd/8VYpvByWTcSrTLwyqhSbvTpWvauKJAMQ5V5jbjAJlRe0jUC+eYQHZUQU4iDw1hbcbEWjM57Zk3Ss94OGtslBtYTEwUBhyGOY1i4PwbYrHO1JgDxj6ftllW1SxcHmouUUYwqb8ji7D1gFezIhYEFS00IZycSzAJR0P88JWoYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ODwvZO3o; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dff06b3f413so1056444276.3
        for <linux-integrity@vger.kernel.org>; Thu, 20 Jun 2024 09:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1718902478; x=1719507278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nU32yJqLVWlauO1MOjGbdfeZvhkP3RdEVxn5gIXcZPk=;
        b=ODwvZO3ogo2UMLwhPrtupguu3JIurgoLDcMxA3oKU5Abw+okdMRfgtCpGq/ZXLgioB
         uOrWl3X5Nx/efGnBlUSulgfd1mMyhre+nyHhLGGWqQZLYDcjzsR/P3Z9/JlNPEDopCSt
         clKO17sS7CI7lKviTQzMbOF+eQyR9ZsZVz1fwZsszoAdTpRvKmPWLrNWge3HgVIYGrVi
         W1tHg6pRNkmKQtgr2XBVMJZNBjbHi1iFyaoG0dIGmdc9ydgy3CC+Qw0F+/sYAuIfd1pM
         UyY2j6tb97KGh8EWdo7ooBHSuX5ETEyz8HAdf4dsJMQPIGQjW8wcIGZg4qOuQctnNEi/
         TB5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718902478; x=1719507278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nU32yJqLVWlauO1MOjGbdfeZvhkP3RdEVxn5gIXcZPk=;
        b=hbFGJnwjjwmMS4EFkzbtWcIKOfRQNWPxQV2IDyIJrAbEfFxcX/H80jh593A0ByzzTH
         3NwJ9scSrnlxK/rP/7NXn5shDCzbAGmFp+AzeicrKS8hranEZpcSNCNaHWZAhboKVPF2
         9vlLGutA51JqTtDJYafeEreka/O0O64PMnYE2TX/XYYpmRSfxv/u6L4UISx4O7VWyA81
         aigOgP3T2EZM9gMhQgreviDoMv6h5KGOZ/LfHQZPWlA5iPr5433B/5I3V7TUmBUf7JwD
         6Q2oo1FJDBcwwJw7C4DVNXtFvvMYHGhsFRjkXtRtGqRAp5HF9CkRSnL1vA5LryW5UYOy
         9bjw==
X-Forwarded-Encrypted: i=1; AJvYcCVxnDcTqK6YXLF35rJ1PIjCcIf0JAfZXyi6b/PQ1suBl8VAeISlI9n4mQC1nGI+wbe6XaVaMX4WENu8QK/ymQ5nhZ/WON8W/CJIAhQZJhbM
X-Gm-Message-State: AOJu0Yx7uiyOKOQl13UiRWNefAuHpaXkGsIyW9iTqtNsJy+Fx7lDuMol
	a3bQ0R0RaJPaAMhNclTxAsHxXsVWq99UOq63P3JGVOURoUBZEQjeu2VvAUQzn/nqbysw1V/cZNO
	q4gQUaNgKJTzme83XOUDh7igAjbJHGKN4uEaNyinvalaW/rk=
X-Google-Smtp-Source: AGHT+IF13BHpoNYPwS4PQPx7j7170Xyxvk6ucDaOXGDhfaS1JKo7NId9A6sAy7bCJmw3neQ25h0P/Cwv0uX6xpzNWNQ=
X-Received: by 2002:a25:7442:0:b0:dfe:3e88:3649 with SMTP id
 3f1490d57ef6-e02be13b1e3mr6638405276.20.1718902478328; Thu, 20 Jun 2024
 09:54:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606-md-trusted-v3-0-42716f15e66e@quicinc.com>
 <20240606-md-trusted-v3-1-42716f15e66e@quicinc.com> <D24EWHXV14EM.S0NQ3H51R892@kernel.org>
In-Reply-To: <D24EWHXV14EM.S0NQ3H51R892@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 20 Jun 2024 12:54:26 -0400
Message-ID: <CAHC9VhSVSS46oCAz_NrUUGstmG3j0NVk70-SwwtCTVJ-R1Z+OA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] KEYS: trusted: add missing MODULE_DESCRIPTION()
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	David Howells <dhowells@redhat.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-integrity@vger.kernel.org, 
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 8:19=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
> On Fri Jun 7, 2024 at 4:47 AM EEST, Jeff Johnson wrote:
> > kbuild reports:
> >
> > WARNING: modpost: missing MODULE_DESCRIPTION() in security/keys/trusted=
-keys/trusted.o
> >
> > Add the missing MODULE_DESCRIPTION() macro invocation.
> >
> > Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> > ---
> >  security/keys/trusted-keys/trusted_core.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/=
trusted-keys/trusted_core.c
> > index 5113aeae5628..e2d9644efde1 100644
> > --- a/security/keys/trusted-keys/trusted_core.c
> > +++ b/security/keys/trusted-keys/trusted_core.c
> > @@ -395,4 +395,5 @@ static void __exit cleanup_trusted(void)
> >  late_initcall(init_trusted);
> >  module_exit(cleanup_trusted);
> >
> > +MODULE_DESCRIPTION("Trusted Key type");
> >  MODULE_LICENSE("GPL");
>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Are you planning on taking these patches Jarkko?

--=20
paul-moore.com

