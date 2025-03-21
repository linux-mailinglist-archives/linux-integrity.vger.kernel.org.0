Return-Path: <linux-integrity+bounces-5371-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D80A6C2F2
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Mar 2025 20:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A09423BA9A8
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Mar 2025 19:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651341DEFF3;
	Fri, 21 Mar 2025 19:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LYfNvBHc"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C156D154426
	for <linux-integrity@vger.kernel.org>; Fri, 21 Mar 2025 19:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742583955; cv=none; b=fG7yhr8+kozJ2CHy/uL/TK3O0TPZ7ZHGuwAenD6Z/w41nvwKHxAI4GSHl4RYXJ8XxSvSFsVR6vh15qtHGev5AZLocnB4FsxDhOu8bhPj0GUkJ4EdqyPIoCxtSKHvOCSRp59TMe2M3BKqUf3o/RELpJsGpf0iyLXHdL0eiZSv14w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742583955; c=relaxed/simple;
	bh=sPA3YMc7zB5fmsVIwEgENpeTURZ/iV7aheO5rZV+wXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RWn8kT4RpPgrOu5DQQftQVA8+51N+7eUOHgL8xXr38Nu/wOw6fodW2J5OiAk5CClUp1wq3T+EW+aign8OyWpc8Fo2FCLuXJp6ufKUYzy7W5WR5Rj6cCiWQtBKLDoqXQjBuYQ/sPD3LgZTOQb5/GLjUIykZnsiDx7bNkPlZT+iu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LYfNvBHc; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e5ad75ca787so2175201276.0
        for <linux-integrity@vger.kernel.org>; Fri, 21 Mar 2025 12:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1742583952; x=1743188752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4nSFzAgQaMCuwvxmSdJkfWwEiaWngP9LwXhsN0dSMzo=;
        b=LYfNvBHcrT0Twh/h79VFfV6pTncGLRT2OXfQx0dxcGexZl8o3l/+abHgjwQigE6hBx
         g2PckWi37/irZP2YUVb0x2V1pd0kOoJPb086j4KxHypUVjs2R4gclXTXV1U9fMZ5ykvd
         NN6NfhnRSV63fxKWIfi7wlbMlj0Y65SwF2eOM7JD73Njw1B61wOBOgkPuTokfWYMjLzX
         YNUItr5j5chQ4RwTPSS1ag87rxYp3Hx3Nddok+Jm0EPi3w6T2sug8XndHFKqcxcxk0I/
         IwMiPB/S1gehGoYU9DulhHKph1ZH5wVOX1ddnyaS+jDYEMtbf9kQ1EROICKu3TW8ua24
         aa9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742583952; x=1743188752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4nSFzAgQaMCuwvxmSdJkfWwEiaWngP9LwXhsN0dSMzo=;
        b=riyCev4gPcWB7yxYRLHMa+bB877o3/Ily0U/p720ole3M0nV7C64pA7qW0WG4TPUFQ
         5jOjzGwTIzdZq8HEFSYkf3WRWdz1x7nrLQHlzRmMS9P8Pvcn2+CpIk8VWPofXuBXjYKN
         7AeT5bBPkO489c8pmdfcsNNMeXPIiN3RDw+GKF5ElkRqCdPSxmIIaB3YXzgii2DebiiG
         +PEghY4gC2MV1MUmWJtJrBzcpOAcQDvIXBPbAGUcDujEJRNIEkxNP6ClzaYmaYp4cHtB
         zYLHzceVv1D2jy6X5lukM0CCH97FxzlwYtS4JU4JBsW+CWnKUMf3TbVNlpSlSNlXZJi4
         66WQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLUMKmaAbx/JwUqYcSKxtBe/cdIhYwhXHMQtKa9SCemozuDYIaSat7kg9lvrlURb23DPzR7/ZdN9ynPuJQDE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjZcKx5WtSJo5PehVRzCxI8oHEizU6oaUcykpGHbxXysKb3uUp
	dmNNiwPn3WcU8f9wrqmYyxiTSYeXUAXELxDquCAXcaakca9gWW+pMyJBp2GlWMalk0z76g35SW1
	ZtiikTIOiFU8p5nS0zVshwAV1958vOdsxY19H
X-Gm-Gg: ASbGnct8OSrphIepjlNSQ8yJGJtJua6UaFmYBa5JusH40gGsi8IH7T2f/Y1mMdx/HvU
	0c8cZtzD+ASfyQujUpilLHZDPH3wF1N0MCDKlw84fUMMhjThY+Do7ChmWAyDxQ5B0EpHy8xtY/w
	M3PHkxzKPS/sD4IMpHFpOxmpFMOw==
X-Google-Smtp-Source: AGHT+IH/+vybMPgjTy+Q/lR+WQGG9I7BYYRaZ8XGvbeWqhA0zAi7QHXEcXle+vpl3pUGz1AEgz4oOGz9sgmGVmlf3/8=
X-Received: by 2002:a05:6902:4a8d:b0:e66:a274:7fff with SMTP id
 3f1490d57ef6-e66a2748117mr6225899276.21.1742583948895; Fri, 21 Mar 2025
 12:05:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <FD501FB8-72D2-4B10-A03A-F52FC5B67646@oracle.com>
 <CAHC9VhR961uTFueovLXXaOf-3ZAnvQCWOTfw-wCRuAKOKPAOKw@mail.gmail.com>
 <73B78CE7-1BB8-4065-9EBA-FB69E327725E@oracle.com> <CAHC9VhRMUkzLVT5GT5c5hgpfaaKubzcPOTWFDpOmhNne0sswPA@mail.gmail.com>
 <1A222B45-FCC4-4BBD-8E17-D92697FE467D@oracle.com> <CAHC9VhTObTee95SwZ+C4EwPotovE9R3vy0gVXf+kATtP3vfXrg@mail.gmail.com>
 <EB757F96-E152-4EAB-B3F7-75C1DBE3A03B@oracle.com> <1956e7f9d60.28a7.85c95baa4474aabc7814e68940a78392@paul-moore.com>
 <A3A29FB9-E015-4C87-B5F0-190A4C779CB3@oracle.com> <CAHC9VhQMN6cgWbxdAgBNffpCAo=ogGdm4qBGS_kKdDmiT8b3cw@mail.gmail.com>
 <Z92gTQj6QkedbH0K@kernel.org>
In-Reply-To: <Z92gTQj6QkedbH0K@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 21 Mar 2025 15:05:38 -0400
X-Gm-Features: AQ5f1JoCVuy6gH5pZ3qt9eL4_YTiGz_EbkGoV-AHORqyWmdnqKeKo0JNC59Hn0c
Message-ID: <CAHC9VhSi06azJ+b5YgLuDM6xff2401ArMM6LoP0vsqsUgz6VNA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/13] Clavis LSM
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Eric Snowberg <eric.snowberg@oracle.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	David Howells <dhowells@redhat.com>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, 
	David Woodhouse <dwmw2@infradead.org>, 
	"herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>, "davem@davemloft.net" <davem@davemloft.net>, 
	Ard Biesheuvel <ardb@kernel.org>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	"casey@schaufler-ca.com" <casey@schaufler-ca.com>, Stefan Berger <stefanb@linux.ibm.com>, 
	"ebiggers@kernel.org" <ebiggers@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, 
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, 
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, 
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 1:22=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
> On Thu, Mar 20, 2025 at 05:36:41PM -0400, Paul Moore wrote:

...

> > I want to address two things, the first, and most important, is that
> > while I am currently employed by Microsoft, I do not speak for
> > Microsoft and the decisions and actions I take as an upstream Linux
> > kernel maintainer are not vetted by Microsoft in any way.  I think you
> > will find that many upstream kernel maintainers operate in a similar
> > way for a variety of very good reasons.
>
> This is understood. If one takes a kernel maintainer role, one should
> unconditionally disobey any vetting by the employer (even at the cost of
> the job, or alternatively at the cost of giving up the maintainership).
>
> And with you in particular I don't think anyone has any trust issues,
> no matter which group of villains you might be employed by ;-)

Haha :D

> > The second issue is that my main focus is on ensuring we have a
> > secure, safe, and well maintained LSM subsystem within the upstream
> > Linux kernel.  While I do care about downstream efforts, e.g. UEFI
> > Secure Boot, those efforts are largely outside the scope of the
> > upstream Linux kernel and not my first concern.  If the developer
> > groups who are focused on things like UEFI SB want to rely on
> > functionality within the upstream Linux kernel they should be prepared
> > to stand up and contribute/maintain those features or else they may go
> > away at some point in the future.  In very blunt terms, contribute
> > upstream or Lockdown dies.
>
> Could Lockdown functionality be re-implemented with that eBPF LSM? I
> have not really looked into it so far...

I haven't looked at it too closely, but the kernel code is very
simplistic so I would be surprised if it couldn't be implemented in
eBPF, although there might be some issues about *very* early boot
(Lockdown can run as an "early" LSM) and integrity which would need to
be addressed (there is work ongoing in that are, see the recent Hornet
posting as one example of that work).  Beyond that there are
policy/political issues around that would need to be worked out;
nothing that couldn't be done, but it would be something that we would
need to sort out.

However, as I mentioned earlier, with Lockdown already present in the
kernel, deprecation and removal is really only an option of last
resort, and I'm hopeful we won't come to that.  We've seen some proper
Lockdown patches submitted overnight (!!!) and I'm discussing
maintainer roles with a couple of people off-list; with a bit of luck
I'm thinking Lockdown might be properly maintained after this upcoming
merge window.  Fingers crossed :)

--=20
paul-moore.com

