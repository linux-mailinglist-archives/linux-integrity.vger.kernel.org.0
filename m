Return-Path: <linux-integrity+bounces-7017-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C09E5B43FEE
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Sep 2025 17:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F9555A7340
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Sep 2025 15:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B693002C3;
	Thu,  4 Sep 2025 15:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="aFgTvYM4"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F4A3043DC
	for <linux-integrity@vger.kernel.org>; Thu,  4 Sep 2025 15:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756998154; cv=none; b=PUmJUAX04Cd1pjlExQGY3L80ErIToZNN6vH8Kz9fI9iqjcGh8jYH2oeSJKwqQOhJhBtwk4rp1olqFkiyBuss6seUk25xC63axuN92aAWkg6iABlViQg8SWR9lCsvcCUh9J/alc8lueTAaywx0erJH3sBNaeTBSZxn9tc6TGyxCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756998154; c=relaxed/simple;
	bh=rQOdX11fY/fHZi+K6bP2GDUn5CrvijThfPeD38NULhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H3Kk6fVK6zAvS78JhUtxyJIqYx3/wqulyNFc0MRvqMKmW6+S3pG1FfGwI0XmthALgzvcHyls87QP0GlBzL3vGy2GN7xRtGmmXNPGDOja8qnRT5+DFzZyGjdn2+3vvfJHvzmR7FhaZmR+BgEASOU9FWgtNYckhHhPDB5zVvTEsLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=aFgTvYM4; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3297a168470so1028865a91.3
        for <linux-integrity@vger.kernel.org>; Thu, 04 Sep 2025 08:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1756998152; x=1757602952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NxzYkAAG6UMXz1rkSuT85nC3lEMgcvO7jfMiH2T8sZ4=;
        b=aFgTvYM46urrRm5ftnbSp3MRQ9PEZy54WdzIwcXg5Nlt3jwlWh+22oAN/md0qmjnyS
         ui52aM00/N4PDSUgCeXUgC86RfpBAOQZBqeLnLBuMMI3b2nU7F83J8yMG9NM1oyOWbsV
         m223mZEJES0Awb4MNGeNpSAiR6uZLPgFd9dDm6YpD66sW/2ONtPd/DMqBU4GFKQ+PpjO
         lyI1xsNzySudvDIN1nwM9b0JxyWND+H3L9q6XKtU1W8xbxPW0n0DiJwyTH1g7YW0NsVO
         tOITLXiwSgnDJugc4lzJlcwNakhYqzakp6j/1pf6B1GNOk1ZPqE7lhpTAA9Kr7EYD/32
         ZMDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756998152; x=1757602952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NxzYkAAG6UMXz1rkSuT85nC3lEMgcvO7jfMiH2T8sZ4=;
        b=Fa/AmLrYTfyCUwQwz4pJSb+EkAp9Ns3iWUlqZvewivS5gj6IqZssQmaWcC/XowL7AR
         4/YGZth+K5Kes9CVibFObEn1CIIJ+2UZDK1y6GJ1q/Js6q8bJ2mUtuAmCLPEDvP0n7xO
         R5gcWT0FV8ZrUHOA472KBg2AfV/fQcOLpHZhDAMaFSLjxgF5zEiOJP6xPa9kXSrHEnIO
         ggJz8hepDBC29B3JHOTYm8PATWJ1A0W40SYq953PrMq7XFxi5n+TYY4pV0UVK93jqGsi
         LbZ6A+fd0OB+i0OfJPjWpcKbikVOfQS62tVd2g4ESuRZcf3Cnj+wIeNA3aZhTWIFAJGy
         AsYw==
X-Forwarded-Encrypted: i=1; AJvYcCXFB6VlbgYErBbWyfF0mh0ViD6Kj6P6LHHoC/Wt8jUK/RnfsSBeO/Vq/eu4FUe3kQKaBAZ3gXkx4vbFgp8Req4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1algQxeo99s2A6pH4tdzPB38X8RE7Qz92Ttp1Ww9qsvoAp85N
	nDu0PCtMlS/NfxKK3ICxNrnjE7EX3148O5kvcNsMAI+svt1EHSg/+Zdh1VTwQ2jusC29FwkgxYr
	fcXFA66vM/hN7BuJKYDtqoKkf0ZJxr5YnEW0/ei5X
X-Gm-Gg: ASbGncv4Tvsp/8/qwxDIkssOkzegsL/BbZYfrOJ5MYDoSuYUcaX0Hyupc8Owyywezk9
	mNkt1DAhaj+dGczEr2oygKGZ00HqAmEv55VgDNUVKXdVeUuLQcP9lerF4DrbqtpamOEVLk6jXsa
	9ygp8ki9UXhoX0VbH30zgZxTIPOsTAsh+uEoI0e6INKbE77mQMBrUaeoWIsjYGWfCSYnxNOtxXU
	inYV7oRXnQr+e4k2Q==
X-Google-Smtp-Source: AGHT+IEAZoSNI5gmsQNLG4iinYBMixnV3r+PQLV6m7zWI3vUPz0UY1/ZKtvhUIgn9uhbzTEGs0/nEBkt1LBYLBY/o3I=
X-Received: by 2002:a17:90b:3f8c:b0:32b:656f:5a66 with SMTP id
 98e67ed59e1d1-32b656f5bebmr7026394a91.27.1756998150183; Thu, 04 Sep 2025
 08:02:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814225159.275901-36-paul@paul-moore.com> <20250814225159.275901-63-paul@paul-moore.com>
 <CAHC9VhSf=zo0BkTc_=Qqq59OMVHsMUs_OqcmSUK501LYpAdMYg@mail.gmail.com> <3be8c5b7-a5d1-497d-8fbd-c74c1e22034f@I-love.SAKURA.ne.jp>
In-Reply-To: <3be8c5b7-a5d1-497d-8fbd-c74c1e22034f@I-love.SAKURA.ne.jp>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 4 Sep 2025 11:02:18 -0400
X-Gm-Features: Ac12FXwxDMTMo82EEp1hf0-OQH3hr6NRJdWpeIuq7lmxwN7eWIeeqwp0bLdTBH8
Message-ID: <CAHC9VhTJp91zfyz4C2jU8WFDH50V0mnEVGLcZKGhaVm6XQ_L8Q@mail.gmail.com>
Subject: Re: [PATCH v3 27/34] tomoyo: move initcalls to the LSM framework
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: linux-security-module@vger.kernel.org, 
	John Johansen <john.johansen@canonical.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 5:53=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2025/09/04 5:32, Paul Moore wrote:
> > On Thu, Aug 14, 2025 at 6:54=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> >>
> >> Reviewed-by: Kees Cook <kees@kernel.org>
> >> Signed-off-by: Paul Moore <paul@paul-moore.com>
> >> ---
> >>  security/tomoyo/common.h        | 2 ++
> >>  security/tomoyo/securityfs_if.c | 4 +---
> >>  security/tomoyo/tomoyo.c        | 1 +
> >>  3 files changed, 4 insertions(+), 3 deletions(-)
> >
> > Tetsuo, does this look okay to you?
> >
>
> Yes.

Thanks for reviewing, may I add your ACK?

--=20
paul-moore.com

