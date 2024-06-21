Return-Path: <linux-integrity+bounces-2915-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8BF912F5E
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Jun 2024 23:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 356DCB262CC
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Jun 2024 21:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C2617C22C;
	Fri, 21 Jun 2024 21:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KeNONThH"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B77217C219
	for <linux-integrity@vger.kernel.org>; Fri, 21 Jun 2024 21:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719004769; cv=none; b=RDSLfxkZRoWPguMlduAncmrcgtQOQonwFQt/ioI6r+KBCEbQFnamPXZsk2zdIa69evSiNhTbDDvRD4aHHU1SXpSda9JMf0hPS19UM1f03AzUp7DgyP1mhhXqpQgtR05WkRIqDClV2y2hz8PusmRFiGVABlRQV1GjK07M+wgFWm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719004769; c=relaxed/simple;
	bh=8lr1mwe6kp+kuxQVqcuMU3hSRlGZ/owZFV26zQzK298=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B6TMWbjQwsBrcQYsfVavyxhEzKcqTrPtfFzLfN0sJk/eCyv5lkqQdOAGe+r3cPPWUAJLqAnel3esWzl+c0gplEP7warAI+l/pDEt84aca388ROWXTSfTlwbio1816R3GkB9P4AAkwHxD50uaYUiBmcIOHW/ZK7vSe90Jwu14eC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KeNONThH; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dfe81d54db9so2448796276.2
        for <linux-integrity@vger.kernel.org>; Fri, 21 Jun 2024 14:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1719004765; x=1719609565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uTh4L3BY4iwQCbofoLDyf8SOpU+yU/iGqx41nKNZbog=;
        b=KeNONThHR5rPROY4WGN8GVZ2DfbLUel0xnJPzlL46IgAyJkA1rVEE5Bg/+aFYZm3y9
         mmxKAt42c2ucaHb2WV5v7ADvb0RXZZ/sRJ9GkOeNMUJh2slY1lVGT+hh+7D5w86U+4Kq
         Bovus/SOYTVddU2sC7FBZg80jSGq8+mZ/bYZh3aA6qwKfOaGcylvhLs1k0AGFP0+X8P7
         bl1UXL/+8egdNX+7Z+Ir5kiWxNHVCJFphG40U91lehEwX4FQ9nzpBBtsp00jGL3j5U3J
         B3oOysnh6hx9ztyZRwwJ+BKDmw90b8xo3hO+N8cScniI3/acY7pJWnbExncXlL+cWdQa
         l6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719004765; x=1719609565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uTh4L3BY4iwQCbofoLDyf8SOpU+yU/iGqx41nKNZbog=;
        b=mEsSl+9XAwoWacXngS6cRz0635VG3w+rTzncWDopZfYoReV1vVXy82vcDK4rGjIgHj
         LSbWRPuEYpPjaTTn1eezjBPEKZ4sLL7rBEaEN/KBf/7lZCZqp0uRJThAra293oFvbIBw
         jAAYzF1NWg4QnM5eLrWAFt00SilbUP/rZFXBtEk97RVBXZr9j6tFA5yPSP7/uD9if5XN
         /KCBECwlSilN89SbcjnYkGy4EzKHu6/d3QqBvgPw3Wr0iKgGjDzQqS9JO7rb/aHvMegu
         WdBWhYW5QeHGIuFCzLZ1/PLZyq52GBsgrbK3ddmILTH7iEeh9VZeRCLnpCdV2XTYc29G
         74Bg==
X-Forwarded-Encrypted: i=1; AJvYcCUSyjupSASqwWniTdm0NnBnij8O3GRNJe7L8rSfABTOPWX9tRzH3KYQsAeXDInZwHuKXuWYG5gwgt0/4+HVcq/MoCZOUhD92w0E4eiR1qaM
X-Gm-Message-State: AOJu0YzMr4VMsdqW+CpzeVExLlxY6+25wNg+Cw49nt7wklzHaNJ6mS1q
	8paX30U81phQW7siv9ix5EWC9AdQdz6iSdvBbOx1Sa+/AlY8cfB0cFxHP5w7IqKoMjO/xbZqVPz
	qmcjooNQ0htwg21tMi0zNVrgZRELHzcVC3EEx
X-Google-Smtp-Source: AGHT+IEO3bU6Bkwuyqrkdth6ewbR+7IHhepu1IYoa73UuwczNOTdI9rtJb2IzNy/CVVXrmq3jsM8cCXNxJAJ4+XXpKo=
X-Received: by 2002:a25:ad06:0:b0:dff:2ef1:e3d5 with SMTP id
 3f1490d57ef6-e02be227615mr8816096276.63.1719004765371; Fri, 21 Jun 2024
 14:19:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215221636.105680-1-casey@schaufler-ca.com>
 <20231215221636.105680-2-casey@schaufler-ca.com> <CAHC9VhT+QUuwH9Dv2PA9vUrx4ovA_HZsJ4ijTMEk9BVE4tLy8g@mail.gmail.com>
 <CAHC9VhSY2NyqTD35H7yb8qJtJF5+1=Z4MHy_ZpP_b7YDT-Mmtw@mail.gmail.com>
 <fbf7f344c518d70833398c2365bb2029480bd628.camel@linux.ibm.com> <d953fac4-9dbe-42a0-82eb-35eac862ca6a@huaweicloud.com>
In-Reply-To: <d953fac4-9dbe-42a0-82eb-35eac862ca6a@huaweicloud.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 21 Jun 2024 17:19:14 -0400
Message-ID: <CAHC9VhRKmkAPgQRt0YXrF4hLXCp7RyCSkG0K9ZchJ6x4bKKhEw@mail.gmail.com>
Subject: Re: [PATCH v39 01/42] integrity: disassociate ima_filter_rule from security_audit_rule
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	linux-security-module@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, 
	keescook@chromium.org, john.johansen@canonical.com, 
	penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, 
	linux-kernel@vger.kernel.org, mic@digikod.net, 
	linux-integrity@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 4:34=E2=80=AFPM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> On 6/21/2024 10:23 PM, Mimi Zohar wrote:
> > On Fri, 2024-06-21 at 15:07 -0400, Paul Moore wrote:
> >> On Fri, Jun 21, 2024 at 12:50=E2=80=AFPM Paul Moore <paul@paul-moore.c=
om> wrote:
> >>> On Fri, Dec 15, 2023 at 5:16=E2=80=AFPM Casey Schaufler <casey@schauf=
ler-ca.com> wrote:
> >>>> Create real functions for the ima_filter_rule interfaces.
> >>>> These replace #defines that obscure the reuse of audit
> >>>> interfaces. The new functions are put in security.c because
> >>>> they use security module registered hooks that we don't
> >>>> want exported.
> >>>>
> >>>> Acked-by: Paul Moore <paul@paul-moore.com>
> >>>> Reviewed-by: John Johansen <john.johansen@canonical.com>
> >>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >>>> To: Mimi Zohar <zohar@linux.ibm.com>
> >>>> Cc: linux-integrity@vger.kernel.org
> >>>> ---
> >>>>   include/linux/security.h     | 24 ++++++++++++++++++++++++
> >>>>   security/integrity/ima/ima.h | 26 --------------------------
> >>>>   security/security.c          | 21 +++++++++++++++++++++
> >>>>   3 files changed, 45 insertions(+), 26 deletions(-)
> >>>
> >>> Mimi, Roberto, are you both okay if I merge this into the lsm/dev
> >>> branch?  The #define approach taken with the ima_filter_rule_XXX
> >>> macros likely contributed to the recent problem where the build
> >>> problem caused by the new gfp_t parameter was missed during review;
> >>> I'd like to get this into an upstream tree independent of the larger
> >>> stacking effort as I believe it has standalone value.
> >>
> >> ... and I just realized neither Mimi or Roberto were directly CC'd on
> >> that last email, oops.  Fixed.
> >
> > Paul, I do see things posted on the linux-integrity mailing list pretty=
 quickly.
> > Unfortunately, something came up midday and I'm just seeing this now.  =
As for
> > Roberto, it's probably a time zone issue.
>
> Will review/check it first thing Monday morning.

Thanks Roberto, no rush.

--=20
paul-moore.com

