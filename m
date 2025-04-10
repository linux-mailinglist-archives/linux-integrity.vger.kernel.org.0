Return-Path: <linux-integrity+bounces-5808-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E86A84F7D
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Apr 2025 00:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B08C9C2E20
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 22:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812E520C48F;
	Thu, 10 Apr 2025 22:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OD9Qo8sv"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA95A20C48E
	for <linux-integrity@vger.kernel.org>; Thu, 10 Apr 2025 22:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744322693; cv=none; b=kKhlm8AMdQO9FGqM4mqBQBd8u9MgfaZHqzKQ56By/vIpOR2vW1hA2w1JGPMXZaV6O08RcPEqeZJfl+RK7YozePcwC+J/j4E7tNfj1JBl7sjIvdW8lDxvnAVXJjFLGhcYqjMFR2ydiKyPg1k+PPA2KnswsaS6H+uhG53InouTqA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744322693; c=relaxed/simple;
	bh=lR4MKuu340RWszf0Guxd0jymAu7e7DxV0vQyiIB8too=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C1fJ0cLKOA07Q/OMnX+xuphI3xmHsNwdffNjefdREkOHGmULp+4Punyh62YvQe49rVAWhrVVGU65wFz6U/zQgqa2Kzw9762j16cIRy20wfPAMq3jLiNRCkLL+TnQXB2XFGgskAAhGtSP5pfe0qyvTHpqOqkDD9r+CHlix/2E+b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=OD9Qo8sv; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e694601f624so914229276.1
        for <linux-integrity@vger.kernel.org>; Thu, 10 Apr 2025 15:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744322690; x=1744927490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ThJA9RCffpGJB52cdB/k9+6Gib3Kw1fb/e4rgWap2ag=;
        b=OD9Qo8svGjjZW4e2ydgv1rnw6ylHh/bhgyXDadI+SwJjgZtglkhNHuq/HSIS2BppBE
         6pxSS56HMESgghA24v0Aw7OF+F8QWq/sa6x9GR5jtQqjFkGiYhERZf/MaVvMsK0psux6
         +p1Oh7rxCpwHSJdGh3/1QZ6/nPKDy4IOwVw+aJWm2iTdN39W0vh7Rh65YJp0R1qCHO2M
         72QPXd/LItl3gcPY8d3gBznLCW15Q45hxsNE2rpMe68K4gJz+q2bq2v/MZIGlk/dYHFi
         z+NdjnuXs/VtXzomjtOjYFx+R/KfBWpyX1GQczOZXgV2t6KSiLYTBtceNoQW0VXhz+67
         p/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744322690; x=1744927490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ThJA9RCffpGJB52cdB/k9+6Gib3Kw1fb/e4rgWap2ag=;
        b=BO+IF7RhEHme8WZtC+1Hl79elVZxw2PDiQHkdEOm4TTVLPks3eNyTG9f1jRmbUuwdA
         SnYeATSOmSxY7/D/wa3UYOWdYUX3UxWII49JZYRzt2tCXQCeRHsi66up07+ToWewtzhV
         9DQTguqSwyj/Y1+aY0kRBpvh3RY+nXSRjm0tA7ww4LM+GhuvRxtOhTH1YRmuG6ovPxU5
         Slh8rylivsDbYqY2byMe+D5J/gLJe8S1A035D2XnfxaBhav3/SC2gXUGXqbKzeeEtuff
         bbxxcsmbrqYy8idk9GIPTzeHdRjKwvfryREmnLruqJDjH8gqE90Mk2uCearCJGpiHOhG
         /TYA==
X-Forwarded-Encrypted: i=1; AJvYcCVkbfWI2326TKcbF3g+iQLwN2VXDyCah2hTZUSboE8tCJ8C7OMGX3OBRvJsNp3p93HM8It8TvPbGpUhF7cM7gY=@vger.kernel.org
X-Gm-Message-State: AOJu0YygRfctwIaqv8UzGqkGVWnUcqfAONcX1yOHFkaD6KTZs9F0gBYy
	MrDHY/ZJQzs25kjID1UtwSiOyL1RczRNa9grbkLzkbpUmA2CdXYBNXz+iUQzMZrDbcLXkmM+Ty0
	bXyfldCGgn9wFoGFnBI2iJ68rieROqrbWSS0N
X-Gm-Gg: ASbGnctQF8fdxzWxs+QEG+8UudqPvYTioYeJr3Aa1gWoVJPQa17W1a0ZYBJhIcLL5Rm
	Nm4N+iauL1ef7jzFDooWT8kbmV7+U2BbAWEtdHK28fWQajCtXrY+PC2sPMhdOKwVxCcUp+0KDFm
	OQizLgOZDtA+azUfxurKYCPQ==
X-Google-Smtp-Source: AGHT+IGu9blHBtA3CEBz2LkZkg/e7jSU3qWOp94YzjozDX5VWYKwsBrkCM0y59Kq8Fo/PoEfVbgmMOpFZRD+yGBpMsQ=
X-Received: by 2002:a05:6902:1b02:b0:e61:1c56:d65e with SMTP id
 3f1490d57ef6-e704df3ae64mr1115328276.39.1744322689832; Thu, 10 Apr 2025
 15:04:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409185019.238841-31-paul@paul-moore.com> <20250409185019.238841-38-paul@paul-moore.com>
 <202504091603.107B41F4@keescook>
In-Reply-To: <202504091603.107B41F4@keescook>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 10 Apr 2025 18:04:38 -0400
X-Gm-Features: ATxdqUHFxuT5USi8IiIkSasG6nEMfemcLUEOIyHb3nrfcVUUbanf7KB9GsqSVvI
Message-ID: <CAHC9VhT+yr=Pf=sSpFAO7RbAGejRgQhKPDLppCeOmydfhds5qQ@mail.gmail.com>
Subject: Re: [RFC PATCH 07/29] lsm: rework lsm_active_cnt and lsm_idlist[]
To: Kees Cook <kees@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Fan Wu <wufan@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Micah Morton <mortonm@chromium.org>, Casey Schaufler <casey@schaufler-ca.com>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 7:06=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
> On Wed, Apr 09, 2025 at 02:49:52PM -0400, Paul Moore wrote:

...

> > diff --git a/security/lsm_init.c b/security/lsm_init.c
> > index edf2f4140eaa..981ddb20f48e 100644
> > --- a/security/lsm_init.c
> > +++ b/security/lsm_init.c
> > @@ -22,8 +22,8 @@ static __initdata const char *lsm_order_cmdline;
> >  static __initdata const char *lsm_order_legacy;
> >
> >  /* Ordered list of LSMs to initialize. */
> > -static __initdata struct lsm_info *lsm_order[MAX_LSM_COUNT + 1];
> >  static __initdata struct lsm_info *lsm_exclusive;
> > +static __initdata struct lsm_info *lsm_order[MAX_LSM_COUNT + 1];
>
> I don't care either way, but why re-order these? Just local reverse
> xmas-tree?

Sure?

Honestly can't say for certain, at this point in the development
process I had somewhat resigned myself to having a mess of a patchset
so I figured this was an opportunity to make it look "nice" (er?) in
my mind, and I suppose at that point that looked better to me ... ?

--=20
paul-moore.com

