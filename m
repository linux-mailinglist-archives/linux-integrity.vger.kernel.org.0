Return-Path: <linux-integrity+bounces-3944-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 985139B7DC6
	for <lists+linux-integrity@lfdr.de>; Thu, 31 Oct 2024 16:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33CFDB20B01
	for <lists+linux-integrity@lfdr.de>; Thu, 31 Oct 2024 15:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E49E19E99C;
	Thu, 31 Oct 2024 15:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XNEyP1wm"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1EA85656
	for <linux-integrity@vger.kernel.org>; Thu, 31 Oct 2024 15:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730387162; cv=none; b=SjJGHohUdlUK67Isl5egHMdfPUebGP8APX5EOREQAd4DGmHzNC8fmykLu6og6CirEbcTamtioCAvwyremLOqTl0AWS0DPw65O+krTBgGdhH+8JzlXs27FlnX7qod7wzmg/RT05zqymrjUwQ3dm0RaBnyatEToFEoF5U8p7Ls7Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730387162; c=relaxed/simple;
	bh=okN6iKADsHDU5G1xc79CsdDuAzz4fO12E3NBBKkipAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iAnpa9yj7iy8XMZvqiH7IqAPlKrUpvN1Sxp3//aXxX0XOgPfl9XJzE/EAWZxciEoemakTsXWru+pgZF13+yaj4B5jkVuphUJCqFhULisW1hfSQKNAhVZ8l4LGv4TY2ulbzFms3/TjnDwuEGuqrjve9HEbtMGGBLAgoIfoE/U3SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XNEyP1wm; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-290d8d5332cso525384fac.2
        for <linux-integrity@vger.kernel.org>; Thu, 31 Oct 2024 08:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730387159; x=1730991959; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p9gmY1X+Z6HaiDqI0rcQKxzw47LjvFY8Hd6hj/Hqn7c=;
        b=XNEyP1wmSQQiBdcR/uEfmgP18Cr2x3O5ite3FrX66XP4mrqvv0bg0yvD83fR7fgypO
         QXDiGnknz1SQ6runJ/idP5UZe5OaHkWTjy5Y2iZzThpOuK0D1eegNdVI7Imp14HavPQF
         xNn4GipGeeN3sYO6cgzfoinIdIlyt3jds1NrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730387159; x=1730991959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p9gmY1X+Z6HaiDqI0rcQKxzw47LjvFY8Hd6hj/Hqn7c=;
        b=GXQNK6amexql65ibpIHqTdYN/Wc+aVjXcvCtMB6/dIv1RdKJKB3W7qduoAUN+LwgKm
         olPCD1zsebGbqhVijdUNYZBuoaKqK1mFrWOv1nZKv5Zcu+bkNRAx9CoHtmzFOXttQLeP
         CheNlIQnWfBpwi5vf3qjaWwGd+FPYiietjBtpDIQLku4g1VgAASj6YMRIXIgzS7vQpew
         GU6TyLjcSrrk5unEmFqoKy1u0zHSizQxfeAhPaDMhxDhUpuuSiZ7Vss6E2iVMaegWv2q
         xWiAUQaj1Kc7TtP66YG6b2sUha4GJpkP3fTsFBrqf4dV8AG2aSqDRLsBDG+T8hMc+1pl
         cgAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHcSIULTZW+XJzepHX7bmLWPhowdzJxOQfgNQ0KoLVnlAjBm2hkGPFgIWJz1KS6O2PeljhjHZBfuGbhmUDs8c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8+alx3588tO+VnOil4Z5aMIm2YQ7zFLDIjCEM+/vsyEkDq87h
	+/+BcQ5ID5KKEESBvJYcH0azVmUlOGN8oSjno45h8lCLsQsyw3gVFGgun8Xv3EKzLP/R7Nm2nI6
	wPdPQ
X-Google-Smtp-Source: AGHT+IEJzpprJHqNrQ5VyeoZEwZ0+VxbSKlEXJDc+P9LfFTzACxeq9jjtpTd5Ma4hrIFCHuw9ty2jA==
X-Received: by 2002:a05:6870:d612:b0:273:cc4a:6d84 with SMTP id 586e51a60fabf-29051d6b942mr17999740fac.29.1730387159332;
        Thu, 31 Oct 2024 08:05:59 -0700 (PDT)
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com. [209.85.166.176])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de048bec14sm325808173.57.2024.10.31.08.05.57
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 08:05:58 -0700 (PDT)
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a3bd5a273bso226695ab.1
        for <linux-integrity@vger.kernel.org>; Thu, 31 Oct 2024 08:05:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW/7degKizV3FbK6zZqAyiRKoCuiereJTZEbcl0XLVH5C9jXTxxH9rkn0HKuOy6jNOApdF+pi5St+mSvbWfl2s=@vger.kernel.org
X-Received: by 2002:a05:6e02:2141:b0:3a0:a3cd:f23d with SMTP id
 e9e14a558f8ab-3a6a9361423mr2927785ab.5.1730387156524; Thu, 31 Oct 2024
 08:05:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910191117.1001581-1-jettrink@chromium.org>
 <D43HINLZGMXS.FYJOK0SVQFQW@kernel.org> <ZxckGbxzpWDuXG_q@google.com> <D59JJFBKKJ14.2KQSUSXP649DE@kernel.org>
In-Reply-To: <D59JJFBKKJ14.2KQSUSXP649DE@kernel.org>
From: Jett Rink <jettrink@chromium.org>
Date: Thu, 31 Oct 2024 09:05:45 -0600
X-Gmail-Original-Message-ID: <CAK+PMK45YwcV9S+nvB-QcjAKete889QATvv5jtVm=TbgRHZW2A@mail.gmail.com>
Message-ID: <CAK+PMK45YwcV9S+nvB-QcjAKete889QATvv5jtVm=TbgRHZW2A@mail.gmail.com>
Subject: Re: [PATCH v6] tpm: Add new device/vendor ID 0x50666666
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-security-module@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, 
	Peter Huewe <peterhuewe@gmx.de>, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Looks good, thank you!

-Jett

On Wed, Oct 30, 2024 at 5:48=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> On Tue Oct 22, 2024 at 7:03 AM EEST, Tzung-Bi Shih wrote:
> > Hi Jarkko,
> >
> > On Wed, Sep 11, 2024 at 04:21:24PM +0300, Jarkko Sakkinen wrote:
> > > I applied this (will push later to my remote tree).
> >
> > I failed to find the patch in [1].  Is it somehow overlooked?
> >
> > [1]: https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd=
.git/log/?h=3Dnext
>
> It is applied to my master branch now:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/lo=
g/
>
> Can you sanity check that it looks good? Thanks and sorry for the
> delay!
>
> BR, Jarkko

