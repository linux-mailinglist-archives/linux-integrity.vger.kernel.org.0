Return-Path: <linux-integrity+bounces-5823-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3627CA851AB
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Apr 2025 04:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A20867B2444
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Apr 2025 02:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803DD277030;
	Fri, 11 Apr 2025 02:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="S30PRnNR"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEFD279356
	for <linux-integrity@vger.kernel.org>; Fri, 11 Apr 2025 02:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744339306; cv=none; b=ucFRDzTt1UH49Fx6pZc14YVBElt2KWvqIS2HMf6UMxw/xWjD0VRo7SHhtaPBQ4ThB2MI/UwAt2pPt9waiqTDOmX9Fb5UkW60Ai4RUopmHmKxpGhjifpdJyGjrw2ojgn6hXhHu3/d6iyuGKYLl7py/iqBj2pApiVqNtrYcF/6pfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744339306; c=relaxed/simple;
	bh=as9kSQASNHOZEqVjFgkKcfcacxgPlIJuUo017aL6c5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FAaz/S2rn3TkAL1m0w1GT6hudCR79yMQzruIApD/japXmRvW7Ap80jLJMGz7R33NA9rXDTiJb7bM2+iqmv/nXbsCY64l67SFFBeqDPCVOb8ZMH4Li9m4zw7zrlmzn6q3bBgyQFZmfko4UP879R05cIDiZBl0yndh3WHy5+4kz0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=S30PRnNR; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e6405b5cd9bso1365640276.1
        for <linux-integrity@vger.kernel.org>; Thu, 10 Apr 2025 19:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744339303; x=1744944103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3CwF+ie3M3uU4fIen1I6/2Rgy5lqyQhlFhFk+DF1se8=;
        b=S30PRnNRSvuU9IMAkZaarLZMJWxHbN/EY4RbuvdLB3K7nc5n6hm115VtdZB0w3+wmF
         jkkV9HMoSRNed09lrY3VysuoGz+5MzjdDbtdCcffu/vn4zlnZW68BLmkoCBAv+QB6CPG
         xPhGuPYLyghjUCpKuhkLPIDxiJ6Ts6WMIGjkJIrRk6O//WAPRn0Jp8Ws3lGu4RNnQyjH
         6sFj98j2H1QunBb6W5IsmaTihBXBO5/imtgeh5K8YRLCs4YRNRH6UzoHkmQG7zvBIf2r
         1O1V0XDo3QtyeI0AaBnBzy5u37h20VEPTIRLSJt8nB3fu/oGHbDDcwOczPd722CH8tyK
         s0JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744339303; x=1744944103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3CwF+ie3M3uU4fIen1I6/2Rgy5lqyQhlFhFk+DF1se8=;
        b=gduYRBNHp1iu/CRRQzZWV3S87g+q5q6KcQUAwiRtTTEKhxNrVVqzOlhupNjXrO8Qdb
         W+Y200RC/sly5y4MFgL02e/51/1f+PinuUZIyYAjJJZiLwP6KkcFQvra7k5LafXLLxjW
         AYyNGDS6EolvPsDHktrf9OROitaaCx5VS0fa4D8PZNA3ulssJ+2z/XlJ5guomQdaM9bd
         HPjHnSOFiowGXQBjb8+f2huMJ+gC1MBYZfMXGY9V+GQx6GUCAM05Sml53I18PC25TJ7F
         W6a1Y8jzn/M5cyvS8Ra5LgQNMBQXBK5bBYcBwNvBZTPYGSrP9w9eDq48fdjhFa3X5vlK
         VjEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHSIoFp/dAD4rq7hk3OR9HUIn/k3jLlytp2KgdBgYTBauNiI/NDPUxu5QZbVk3KGN9807IGgfF32CgNzRV7yk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2b1kgRsHzJekw2TRh6/Yd9M9vdfSI89+sCGL2DluXrJ2Ob3HW
	cNH7WrHSV9UdD3o+Nct2ih4G1oeWA0FWcCI8IpUPL5Z4lCsjyZXDLCt2xZf560VO7ih1WLdJjYs
	sz0GDWFftm4WALRN2saI68oAqO4aDyhMJ2yK+
X-Gm-Gg: ASbGncuVzw7ltTodg7lxOuD3PjSgZzLa3Easn/XtYhmuA7BAit7+sw0z/hY8Fbw4Z3o
	2lcR+FDFLqgZwSFQmTGjteQkhVJNFEk+ld9kVuyTS3wi7J2QcwxaT7OTDl5+1OOQwfA9IrMDIWa
	tTbVyfyVIjPsEP1QE+OX9Wug==
X-Google-Smtp-Source: AGHT+IFyF3fZnOWLhxV5JgbmPr2sTVJJVPls46hqxiiCUMkby6GAJYYZggmtKw46ptdM2VMxpFqKc+QvSJIG4R08H8I=
X-Received: by 2002:a05:6902:1545:b0:e5d:f98f:6f33 with SMTP id
 3f1490d57ef6-e703e6de386mr8638189276.10.1744339303036; Thu, 10 Apr 2025
 19:41:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409185019.238841-31-paul@paul-moore.com> <20250409185019.238841-49-paul@paul-moore.com>
 <202504091639.A12E1A853E@keescook> <CAHC9VhTR=ee4SGuvDbFj-dtevVFN3Pm-tVhtMLpHsiYB24Xxcw@mail.gmail.com>
 <202504101915.CA031AE@keescook>
In-Reply-To: <202504101915.CA031AE@keescook>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 10 Apr 2025 22:41:32 -0400
X-Gm-Features: ATxdqUEGP_uYjR2QUaCWVy9WoK8JP8pDyZNvieKfq707AQCl9JSsANJ7Avf5nhA
Message-ID: <CAHC9VhRQ=854kmKnv=gRCUNOk0TK2=-ss8S220yAkwsUP+y-Wg@mail.gmail.com>
Subject: Re: [RFC PATCH 18/29] loadpin: move initcalls to the LSM framework
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

On Thu, Apr 10, 2025 at 10:16=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Thu, Apr 10, 2025 at 09:15:47PM -0400, Paul Moore wrote:
> > On Wed, Apr 9, 2025 at 7:39=E2=80=AFPM Kees Cook <kees@kernel.org> wrot=
e:
> > > On Wed, Apr 09, 2025 at 02:50:03PM -0400, Paul Moore wrote:
> > > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > >
> > > Reviewed-by: Kees Cook <kees@kernel.org>
> >
> > Do you mind if I convert this into an Acked-by?  Generally speaking I
> > put more weight behind a Reviewed-by tag, but in the case of Loadpin
> > you are the maintainer and I'd much prefer an Acked-by.  While I'm
> > always happy to get more reviews on a patch, the primary reason for
> > CC'ing you directly was to get ACKs on the LSMs you maintain :)
>
> Acked-by: Kees Cook <kees@kernel.org>
>
> :)

Thanks :)

--=20
paul-moore.com

