Return-Path: <linux-integrity+bounces-3313-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 151049511B7
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Aug 2024 03:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B6081F24E0C
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Aug 2024 01:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4061E1CD31;
	Wed, 14 Aug 2024 01:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KBsEdR2t"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5199718059
	for <linux-integrity@vger.kernel.org>; Wed, 14 Aug 2024 01:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723600438; cv=none; b=KAHWysgx71O04ZnQWnrGEJmfeJwhR/SaVb23J96GSOl61VvXnZ72PP6qH7KWrQinKhddAEiIgJC8nKrMHa6C3T1AwLrorMQOS+fV0S6Fbo4CDpNJAJSrDQIXOI31i/YGKvf5xs9ZSWE37ZIO88YRzvAriS5MkYI+fLANbY//o88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723600438; c=relaxed/simple;
	bh=ge9OCe6p9CdisLeskHvVtpoC1MjOcmdSYUlZQVLG7yA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BOEdH1OXOaI2zg/EosyQ/FWykZPTu2nAS48w/m4i4VE8AGgyzFqkzDgTPut3iJKy9d2xnWnG+oOiO1DT7rh1qomy/VEDBD7xhgAxFUJt+Jug9bLnhgAQov9N09T4oPDx8L8E53Ki8oXVVcqz2LaUWqE3iiCPzb1ZUmRFfJVC2Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KBsEdR2t; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e0e88873825so6050402276.2
        for <linux-integrity@vger.kernel.org>; Tue, 13 Aug 2024 18:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1723600435; x=1724205235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4BMhf+QP+vZrCE9Emw8zcn7tG5k24e14A1z1v4Cf/zo=;
        b=KBsEdR2t9WA4dOKCy6h7cW+DspYRvLSjSR7nwpYx9ejkCy1Is3S/8XV3GfQeP4n+bw
         DgZORAYEOvcDhI+LWG8I6cw4VeVCqcf5f9UwFezcg5+aUZJRKdCz+iAvnRZhBu0FaCJN
         BxUublanhyyBoQTLD5Q3+oKR7XdopSIPHHCu37GEZZ19R9g0GueYKSXDwov4zgZoa6mR
         1FF3erH3HtexQK4CHdIcjgRuf3Mdm0iBaOYoXQGXuyGE0/FD+qVtS1OU7Mn971RZi6UI
         SCoHld79UFiDrxf0lY/wTzfjt+/ubKqOAzg4dOTOJBbExPO255tdujaZOvkU09b2Pm3E
         LTKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723600435; x=1724205235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4BMhf+QP+vZrCE9Emw8zcn7tG5k24e14A1z1v4Cf/zo=;
        b=Jp9Ju+zh12IxZbv1ELeUjir1n7CZrfxE4Pi4ddmd2tuPdmWksIsRWjulxfINv2TOwP
         9Ht7bbRd5d3EqoACN67GiNWCTRPp5qplnxg6QaxfkR0v61fg4eu+KAAQKM/qLXrnHC+l
         he9jOyyZ7T2omsRx5Flv9Byv0vAjeY8vDoEYeonq29j6HkngqDvNAis3PCMyMMreBfwi
         zvb1Hxs5QOMHPwLxafgjtqjBHEljYUcjJVfc+Ak8rKo+89v71mKJxAIaQpYLg93g7+PR
         ybDFpLGQLf7VgEO5fSKKj31rEBXTEBpEayH9+r2uT0pSeU04e0HNgWa3ccahZIxAQsDC
         rhKw==
X-Forwarded-Encrypted: i=1; AJvYcCUXeC8rpQxCPzU8ObvsEoKtMg+wiio4a0g6+EhnOpaNrrrg4YJelEKZ1onA+R3QhAIiMy6O1WxTw1U9XTP2/Kz5LqGgAhR76r9rwM/pvi1n
X-Gm-Message-State: AOJu0YyIS8RL437WVBBlR61idhmFcrfJYR638JvnaFAVOSmMMe3YzHHi
	TkoQHYw4Vw5HSbfE7Bw6AnFl6jpag4O/HUXJ0WnWEzeVzLyQ8MOKzQZk1cM2l9YxpAQYxu83g/s
	ylnW/3y3qTg8geChcer2ugtlPiaYJYdRVVIZq
X-Google-Smtp-Source: AGHT+IHB113GJo/Rn2X/NGXeXW2H8kobdAD498o2N36iaLt+j07rl2BNDKs7iuampjJQJpWHgw4is6cXxwQOKy7hDtE=
X-Received: by 2002:a05:6902:1b92:b0:e0b:e550:4e5c with SMTP id
 3f1490d57ef6-e1155ae63a8mr1592199276.26.1723600435327; Tue, 13 Aug 2024
 18:53:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1722665314-21156-1-git-send-email-wufan@linux.microsoft.com>
 <1722665314-21156-3-git-send-email-wufan@linux.microsoft.com>
 <20240810155000.GA35219@mail.hallyn.com> <e1dd4dcf-8e2e-4e7b-9d40-533efd123103@linux.microsoft.com>
In-Reply-To: <e1dd4dcf-8e2e-4e7b-9d40-533efd123103@linux.microsoft.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 13 Aug 2024 21:53:44 -0400
Message-ID: <CAHC9VhTYT3RTG1FbnZQ2F68a16gU9_QJ-=LSGbroP-40tpRTiw@mail.gmail.com>
Subject: Re: [PATCH v20 02/20] ipe: add policy parser
To: Fan Wu <wufan@linux.microsoft.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, corbet@lwn.net, zohar@linux.ibm.com, 
	jmorris@namei.org, tytso@mit.edu, ebiggers@kernel.org, axboe@kernel.dk, 
	agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com, eparis@redhat.com, 
	linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, fsverity@lists.linux.dev, 
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Deven Bowers <deven.desai@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 1:54=E2=80=AFPM Fan Wu <wufan@linux.microsoft.com> =
wrote:
> On 8/10/2024 8:50 AM, Serge E. Hallyn wrote:
> > On Fri, Aug 02, 2024 at 11:08:16PM -0700, Fan Wu wrote:
> >> From: Deven Bowers <deven.desai@linux.microsoft.com>
> >>
> >> IPE's interpretation of the what the user trusts is accomplished throu=
gh
> >
> > nit: "of what the user trusts" (drop the extra 'the')
> >
> >> its policy. IPE's design is to not provide support for a single trust
> >> provider, but to support multiple providers to enable the end-user to
> >> choose the best one to seek their needs.
> >>
> >> This requires the policy to be rather flexible and modular so that
> >> integrity providers, like fs-verity, dm-verity, or some other system,
> >> can plug into the policy with minimal code changes.
> >>
> >> Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
> >> Signed-off-by: Fan Wu <wufan@linux.microsoft.com>
> >
> > This all looks fine.  Just one comment below.
> >
> Thank you for reviewing this!
>
> >
> >> +/**
> >> + * parse_rule() - parse a policy rule line.
> >> + * @line: Supplies rule line to be parsed.
> >> + * @p: Supplies the partial parsed policy.
> >> + *
> >> + * Return:
> >> + * * 0              - Success
> >> + * * %-ENOMEM       - Out of memory (OOM)
> >> + * * %-EBADMSG      - Policy syntax error
> >> + */
> >> +static int parse_rule(char *line, struct ipe_parsed_policy *p)
> >> +{
> >> +    enum ipe_action_type action =3D IPE_ACTION_INVALID;
> >> +    enum ipe_op_type op =3D IPE_OP_INVALID;
> >> +    bool is_default_rule =3D false;
> >> +    struct ipe_rule *r =3D NULL;
> >> +    bool first_token =3D true;
> >> +    bool op_parsed =3D false;
> >> +    int rc =3D 0;
> >> +    char *t;
> >> +
> >> +    r =3D kzalloc(sizeof(*r), GFP_KERNEL);
> >> +    if (!r)
> >> +            return -ENOMEM;
> >> +
> >> +    INIT_LIST_HEAD(&r->next);
> >> +    INIT_LIST_HEAD(&r->props);
> >> +
> >> +    while (t =3D strsep(&line, IPE_POLICY_DELIM), line) {
> >
> > If line is passed in as NULL, t will be NULL on the first test.  Then
> > you'll break out and call parse_action(NULL), which calls
> > match_token(NULL, ...), which I do not think is safe.
> >
> > I realize the current caller won't pass in NULL, but it seems worth
> > checking for here in case some future caller is added by someone
> > who's unaware.
> >
> > Or, maybe add 'line must not be null' to the function description.
>
> Yes, I agree that adding a NULL check would be better. I will include it
> in the next version.

We're still waiting to hear back from the device-mapper devs, but if
this is the only change required to the patchset I can add a NULL
check when I merge the patchset as it seems silly to resend the entire
patchset for this.  Fan, do you want to share the code snippet with
the NULL check so Serge can take a look?

--=20
paul-moore.com

