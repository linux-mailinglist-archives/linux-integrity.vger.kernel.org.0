Return-Path: <linux-integrity+bounces-1932-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F238924AE
	for <lists+linux-integrity@lfdr.de>; Fri, 29 Mar 2024 20:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0B791C212A3
	for <lists+linux-integrity@lfdr.de>; Fri, 29 Mar 2024 19:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8792413A89E;
	Fri, 29 Mar 2024 19:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CBUkVwZr"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE4E13A41A
	for <linux-integrity@vger.kernel.org>; Fri, 29 Mar 2024 19:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711742202; cv=none; b=TFgEsEd+SHjFrzbHEb6RXnixw9jIAK96+0WR7LfVD/1EmTGOac9FK0ih9b0V+lMsFMZHP8QzsvZbGbzpR6S0w7bNzZDJE2WUKB4pESlq+USd+uC9GdfyG6tzzKPuCTGVg9B9MAEOyymdzgtQt/MeDZgpZ/FGs9S2KUNQClmPFbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711742202; c=relaxed/simple;
	bh=kl3r4t6JEKPhRbXJ7T+YhSza5u8zPgVfF6ukpjkWUEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j71Tnph1yCogpySi5wj7x7bHmW2mijLyG4D5ypTas+YIuimH166BYR8QoQwrQswRjZBT8jiIEQ51OkBWd1c50vELHfef0SU/Su7T6SLlQKrGhiUVOkGQ4u6e05GjDHxRbyrhK0vhlAcAVKHbI2djvawTPO7vyk5QXwH+IT3tJX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CBUkVwZr; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6143fe736d9so9105347b3.2
        for <linux-integrity@vger.kernel.org>; Fri, 29 Mar 2024 12:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1711742199; x=1712346999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F6A9jbG9CdaDPP1v6fWuwcIQF8qoPPnl16dGzz2qlT0=;
        b=CBUkVwZr6fDdpu1CS2Uchp+UMiOJJcC/5ubPJMrFby2ed8H/XnyFZX6xxLglV1czkg
         jFjntZNznVWUaqtNtoysFOUSv9fdkCv/c8qbMJE3ZDaHsq6bcs4zoWAkoHy9ueZYC+/U
         8IOkRJhBh1jpe5TAhnmnY6ROVaMK/0gJI4Q0Hb67GGwE8HUJxdCcQ8HkURjV20ZZ/B62
         CjDtw0YOQ/2z/R8VUhGf4XJ0REDeKDy11otkkCBXauFEf0MytH0KsL0G+MdbKF1xxh6K
         vSC5m1bC2bPGo7inX9ggy6BxfA8jsn25P8erH6YKdXs1sO4s/7m2XjuxqEyQ7W/rqj2p
         xL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711742199; x=1712346999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F6A9jbG9CdaDPP1v6fWuwcIQF8qoPPnl16dGzz2qlT0=;
        b=q2bvJF9SUaroAPzcVXwAzGeD5SaMcbapHJifWjPTUfOZxtoCJVx28OiVndmymKG/+a
         ORJYPY7lDEZYbh6SJnxfDte49yW3MXPCWAEPu6/iJxD69ZJp0xKphU+KXaZ04eDE3qp3
         TaHGtm2dIiTgodE3MnPIo9vvtlxKF9olpnmc/pUTuLBeT1A5RfaP3g2ey6Lspi1wrTs5
         vc0UEGpDCn2G81NCP+GgnV5zWYLJpVvKSx90GsfBxS1zEkoGminwf0SKsy4eip05T+/G
         vHLPreQZHcLc0+8nMuj1SlSIF2iR2jGOjZ+0oYZyZXsYc/dvJerVCqJh5aUNfXLhvb32
         mrAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUigeKxU1OYVnasJlvCo0LOrVFt8Hi/KktlrMzpGmJwGa3Ujh/juR/88KB+7+Jg2jljBXiaqJAJVfUG8FJ4C6w0mvSvg0FKt5gd3YvyTAOV
X-Gm-Message-State: AOJu0YxWNXjECRfteQ58tdSqiAA8pC5i9VYgAInCjM66KSuJ2zXOUHjS
	EFpaLSvoRPCaq/T7+jyxbIXUOAT6ErX1FdalbDQ8KW6V8hXvx8EeCtmGBy42RGFlIcSbmg7wVhg
	FcHtYwr8Ur54V6DnukOMRGE5GnzIqOFpy/oLx
X-Google-Smtp-Source: AGHT+IFxyLSFxbUR+gusm9UKIGf6amr40sayZYaOUaH9So5UHH1MFJgsFV6241YbxJom5p/x/nu93KVnKL1nyMhNoOY=
X-Received: by 2002:a81:494b:0:b0:60c:bdb0:cd28 with SMTP id
 w72-20020a81494b000000b0060cbdb0cd28mr3336888ywa.6.1711742199706; Fri, 29 Mar
 2024 12:56:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329105609.1566309-1-roberto.sassu@huaweicloud.com>
 <20240329105609.1566309-2-roberto.sassu@huaweicloud.com> <e9181ec0bc07a23fc694d47b4ed49635d1039d89.camel@linux.ibm.com>
 <CAHC9VhS49p-rffsP4gW5C-C6kOqFfBWJhLrfB_zunp7adXe2cQ@mail.gmail.com> <1fe6813db395563be658a9b557931cf4db949100.camel@linux.ibm.com>
In-Reply-To: <1fe6813db395563be658a9b557931cf4db949100.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 29 Mar 2024 15:56:28 -0400
Message-ID: <CAHC9VhQaQErZyqe88wKvVwHKHDdgYB1SR11Z9iZC6VisgmiLpw@mail.gmail.com>
Subject: Re: [PATCH 2/2] ima: evm: Rename *_post_path_mknod() to *_path_post_mknod()
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>, dmitry.kasatkin@gmail.com, 
	eric.snowberg@oracle.com, jmorris@namei.org, serge@hallyn.com, 
	linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-cifs@vger.kernel.org, viro@zeniv.linux.org.uk, pc@manguebit.com, 
	christian@brauner.io, Roberto Sassu <roberto.sassu@huawei.com>, stable@vger.kernel.org, 
	Sasha Levin <sashal@kernel.org>, Greg KH <greg@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 3:28=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
> On Fri, 2024-03-29 at 15:12 -0400, Paul Moore wrote:
> > Another important thing to keep in mind about 'Fixes' tags, unless
> > you've told the stable kernel folks to only take patches that you've
> > explicitly marked for stable, they are likely going to attempt to
> > backport anything with a 'Fixes' tag.
>
> How do we go about doing that?  Do we just send an email to stable?

When I asked for a change to the stable policy, it was an email
exchange with Greg where we setup what is essentially a shell glob to
filter out the files to skip unless explicitly tagged:

https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tre=
e/ignore_list

> Is it disabled for security?

I asked for it to be disabled for the LSM layer, SELinux, and audit.
I sent a note about it last year to the mailing list:

https://lore.kernel.org/linux-security-module/CAHC9VhQgzshziG2tvaQMd9jchAVM=
u39M4Ym9RCComgbXj+WF0Q@mail.gmail.com

> I thought new functionality won't be backported.

One thing I noticed fairly consistently in the trees I maintained is
that commits marked with a 'Fixes' tag were generally backported
regardless of if they were marked for stable.

> Hopefully the changes for making IMA & EVM full fledged LSMs won't be
> automatically backported to stable.

I haven't seen that happening, and I wouldn't expect it in the future
as none of those patches were explicitly marked for stable or had a
'Fixes' tag.

--
paul-moore.com

