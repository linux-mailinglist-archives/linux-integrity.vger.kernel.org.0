Return-Path: <linux-integrity+bounces-2930-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD69E915A38
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Jun 2024 01:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D1401F2205D
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Jun 2024 23:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2296A1A2554;
	Mon, 24 Jun 2024 23:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TKboMAQT"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875E81A0B06
	for <linux-integrity@vger.kernel.org>; Mon, 24 Jun 2024 23:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719270336; cv=none; b=Nvh1JaqQS6fEYftkbiaQ44fYk/nsvQ8Svu1qDCbZAWyuVyeJw+DU637RjZle6wLryLTSrP4BeZBbMr4gZ94jb5rHxDeuGEaAW96ewb9C8daRnuES4VS5jdAUxbKyLkP8nful32ynEAo6TZx1+wxwXDjYJcf2U22o5p5O1rDpdBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719270336; c=relaxed/simple;
	bh=OtH2JoAV4vBXTgbN7e1+QwkmxK4daRuHMXHxaV/v2wE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qeEfw0XfYwb5JP0RjUgMafkDGsl+Z65GL8bByWI7atEFlFXBOSwzTetWsQBPq06bHu5DRcKAqHRTTpipWHVvUZXbVZQUBNwgalVKTOuBnc8whByIRO2yXaeojcpUEc9sceCL0g3xa00AKjYTYPM4hiNf9DgEShlqXVc4/pA2gt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TKboMAQT; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-63f7d53bd88so34455067b3.2
        for <linux-integrity@vger.kernel.org>; Mon, 24 Jun 2024 16:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1719270333; x=1719875133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XW5+fVV5b9RRu0etBewMQ9MGKZwxCgLymWBm1d1OwDw=;
        b=TKboMAQTuIGPHvwXrT35HTbhRC9LcDt9/I4psNzDqrwFx6WM04Rjy3LEddGMpddeSb
         8+yDpGr0dFkajmpJxkv4t9dsskUeulTAN0RUjPq5QvsY04FfrJ170IFC8caJ+lTp/ss4
         a6qePThEJXdWVVCGSuUTgG9/RAeGbPw+YGcG66TDQwjMkkug9CNUpy9htqtQJ10UPKtO
         vi/eydnNmbFiC30m8F7DQiE16/DmvGDN7/KguI0K1YOchsbsQmCaASssU/9KNxTEjunZ
         SnV7yyzbTrD1iAIuAWah0WRyYNuVsKywSuPcfpXA2YxzOWnaAFP5F64EhCZpbSAed9ma
         GOqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719270333; x=1719875133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XW5+fVV5b9RRu0etBewMQ9MGKZwxCgLymWBm1d1OwDw=;
        b=clNSXgV7GiZQtoV817v72X5J6iKv1aAv7jKL08xVhs4mWD7Dw13X8drpJ6Xfbl5Z60
         gx2EUV18cDY9dqx43Tkk3WqvdKkQEq/Rftuu2Nyi6VqpgwSK4QRb9TmEW55cqICJRvfZ
         igp8KQj09FUMUmWJzxIy5BmfE1l/D7r9zqqzqT5/g9LfzneIP2EXfXabAVX2k+ZAzf+Y
         lGBugN654g9y8XKmp0P7biMrDKNHBt58uK4GR5cDB9uUI6UQpeUiNacJA297OWwZi4M1
         0Wt1Oi7sjtz3TivklqKq+BZMWdYTZxd9k8q5DVA+7WBetaNjPFC0449Fqte8fXXS6S4I
         +CcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWggC/Ejg/JA+9dIO0jP/84yDO36aV41kJH422qxoOme7snHIajoWNc6cWc5FjIigvm3pYQt2E80FznxPUYKBepUQ0VtLq1Mt8qaOqHzz4x
X-Gm-Message-State: AOJu0Ywl9b3bSc9a8nE9PKi6rTZ+g2yK5UmaJsfrHnK3V7aop5lN/SBF
	/Sq5AbJ2Gu02MtcjFsqH2AWWcu0FXP4LCrUGQpCADCDDvs0jfQ68T4zRET+LkREYOc2OIvMeWJf
	I+hCp8z5apNx3K64onCinUjqhuRQLker+mc8A
X-Google-Smtp-Source: AGHT+IHmOuOmHCchjHXU2jCwzoStz/35kzwzquQ2QHwla05oTUhkXx6uO4OZA9uzJcH+HTmgnliwYkn0neML4w+Ycww=
X-Received: by 2002:a05:690c:6401:b0:63b:d711:e722 with SMTP id
 00721157ae682-643a990a5ddmr63316397b3.1.1719270333576; Mon, 24 Jun 2024
 16:05:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215221636.105680-1-casey@schaufler-ca.com>
 <20231215221636.105680-2-casey@schaufler-ca.com> <CAHC9VhT+QUuwH9Dv2PA9vUrx4ovA_HZsJ4ijTMEk9BVE4tLy8g@mail.gmail.com>
 <CAHC9VhSY2NyqTD35H7yb8qJtJF5+1=Z4MHy_ZpP_b7YDT-Mmtw@mail.gmail.com>
 <fbf7f344c518d70833398c2365bb2029480bd628.camel@linux.ibm.com>
 <d953fac4-9dbe-42a0-82eb-35eac862ca6a@huaweicloud.com> <CAHC9VhRKmkAPgQRt0YXrF4hLXCp7RyCSkG0K9ZchJ6x4bKKhEw@mail.gmail.com>
 <aecad5ea129946dbf9cf5013331f9368ceb84326.camel@huaweicloud.com>
 <52bffc64dc7db2cc1912544514008eada1e058a7.camel@linux.ibm.com>
 <CAHC9VhS8mC0NC=-gbK_xBq2Ry6Be76ARZSg9Zm3y0bsocGEtTQ@mail.gmail.com> <40c8ec3f-32fc-4bff-a50c-c1a868fcc776@schaufler-ca.com>
In-Reply-To: <40c8ec3f-32fc-4bff-a50c-c1a868fcc776@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 24 Jun 2024 19:05:22 -0400
Message-ID: <CAHC9VhTFOLeoQjXk_fMq8NDoG69wU5KV=Db7m20V02bto6NHNg@mail.gmail.com>
Subject: Re: [PATCH v39 01/42] integrity: disassociate ima_filter_rule from security_audit_rule
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huaweicloud.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, linux-security-module@vger.kernel.org, 
	jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, 
	john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, 
	stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, mic@digikod.net, 
	linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 6:19=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
> On 6/24/2024 3:03 PM, Paul Moore wrote:
> > On Mon, Jun 24, 2024 at 9:57=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.com=
> wrote:
> >> On Mon, 2024-06-24 at 10:45 +0200, Roberto Sassu wrote:
> >>> My only comment would be that I would not call the new functions with
> >>> the ima_ prefix, being those in security.c, which is LSM agnostic, bu=
t
> >>> I would rather use a name that more resembles the differences, if any=
.
> >> Commit 4af4662fa4a9 ("integrity: IMA policy") originally referred to t=
hese hooks
> >> as security_filter_rule_XXXX, but commit b8867eedcf76 ("ima: Rename in=
ternal
> >> filter rule functions") renamed the function to ima_filter_rule_XXX) t=
o avoid
> >> security namespace polution.
> >>
> >> If these were regular security hooks, the hooks would be named:
> >> filter_rule_init, filter_rule_free, filter_rule_match with the matchin=
g
> >> "security" prefix functions. Audit and IMA would then register the hoo=
ks.
> >>
> >> I agree these functions should probably be renamed again, probably to
> >> security_ima_filter_rule_XXXX.
> > It's funny, my mind saw that the patch was removing those preprocessor
> > macros and was so happy it must have shut off, because we already have
> > security_XXX functions for these :)
> >
> > See security_audit_rule_init(), security_audit_rule_free(), and
> > security_audit_rule_match().
> >
> > Casey, do you want to respin this patch to use the existing LSM
> > functions?
>
> If you want to use shared functions they shouldn't be security_audit_blah=
().
> I like Mimi's suggestion. Rename security_audit_filter_rule_init() to
> security_filter_rule_init() and use that in both places.

They are currently shared, the preprocessor macros just hide that fact
(which is not a good thing, IMO).  Renaming the existing LSM functions
to drop the "audit" in the name doesn't really solve the problem as
you still end up with "Audit_equal", etc. constants (which are awful
for multiple reasons, some having nothing to do with the LSM) in the
callers.

... and let me just get ahead of this, please do not do a macro-based
rename of "Audit_equal" to something else to "fix" that problem;
that's just as bad as what we have now.

Properly fixing this may be worthwhile, but I think it's an
unnecessary distraction at this point from improving that state of
multiple LSMs.  If you aren't comfortable submitting a patch that just
does a "/ima_filter_rule_match/security_audit_rule_match/" style
rename, or if Mimi and Roberto aren't supportive of that, you might as
well just drop this from the patchset.

--
paul-moore.com

