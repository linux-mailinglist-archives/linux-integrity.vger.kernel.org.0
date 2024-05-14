Return-Path: <linux-integrity+bounces-2386-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C295E8C4F34
	for <lists+linux-integrity@lfdr.de>; Tue, 14 May 2024 12:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF8061F212E7
	for <lists+linux-integrity@lfdr.de>; Tue, 14 May 2024 10:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C29113D2BD;
	Tue, 14 May 2024 10:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="JIv1rqb1"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0213A5B5D3
	for <linux-integrity@vger.kernel.org>; Tue, 14 May 2024 10:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715681173; cv=none; b=uNQyLXxA9WV2iucAyUUCKD8lxmv4CFxGkUDT8gO+j3HGvNGcS40cHzv1G1OuEOOkysU3jIXZ++oqEX91ozvXeHhO/S2YW5sZvTgmz4HD8GyADGYzTtQezbkqX/6YRCT6P81+czte0qBim7e4ewsu0YXIx3JFbYXd1DvQiFOaPv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715681173; c=relaxed/simple;
	bh=JJMnPw1emDY+HwY78xe2ASFo8bdc3Bqhb6kfo40H6t0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DQ0mpMIJTcaqu3GEj7oDexk0BwJpJ/DmuAugk0dg7cuAut7zpqDmHZZju5mci5fmTbqKrgPr18BcM8lkW/lwIc56SLfsWRK6PU7/pwX5aXX1KwcFu6LhiIewbu0MdETqVO5ngVf6JztcA5Hh6Ek84T2CYyRX4XhjncxIPgcsSBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=JIv1rqb1; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-61f2dc31be4so4405111a12.1
        for <linux-integrity@vger.kernel.org>; Tue, 14 May 2024 03:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1715681171; x=1716285971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJMnPw1emDY+HwY78xe2ASFo8bdc3Bqhb6kfo40H6t0=;
        b=JIv1rqb1rvdYaUxCnNpMc9FPtDhIid1ji4rmyovP+X/GQTAOHCYRsPLOpJaz2obu2n
         BS97JrPlcm6LK0E5B8vnJslMZgBHZrImpDilNKis3RbK6g57jRS0CJVnlqS+4fnV+1ZB
         /H0wiLAiaokwVaMPHLh5UTPrSp0vMwG5WONeD/aR4wTK6GWbJ4pBk1oqXAnhg4QnAKWg
         OGZO8lYQ1xGg5jBDyDXteqVq4oRj8larJjSBu+MGZTvRuj4OPqsLqKW/5MGkvX1vM+RL
         k5feM2qnqIIPk5PNXOb8hYF9JR22/3OKxgGsbN9trPQEuPRGbGHPG0/oeAgAZPkYVzUL
         8x4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715681171; x=1716285971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJMnPw1emDY+HwY78xe2ASFo8bdc3Bqhb6kfo40H6t0=;
        b=DrLqjP5LL3OV5/XHgcFeXBkU0pn+Jwvj8uAVCR3kiwPxXfkiXa3miAbMGRUnUMQBJy
         /yflUaoYNrioXV2I0QWTrqXWKfytvm7PDOn4lPr7BU4M0JG3JYGVplVhc4Q2bH52rgRV
         YUV62L4yp2hfVgYaMKCAWThq76Wx6i41Df0nGXHax6L0Bq+ed7HO0sLO7w75XWV576RI
         VLpC26xmcKuofcAr3o7NHZj91s8/9PLwSpeiLMtGQAwofu+qis43p6e3XvqJp/5WM7Yg
         BmWR9MC8LGrZ335r8xdSvXsIsO5zVzi+dAHTFi/m+il4XC7F0wTyhJcL2SYqAu+Q6oGR
         n7jw==
X-Forwarded-Encrypted: i=1; AJvYcCUT7UXLLEbUzZFMPYfhQs3M/wHcnSDDoH/vcd0G/Gdy8h5VmD4Itc7RUSqAVTNZmSyUhimD1bcnAxvKqqWXQEt3vcUDfI3W2pYObiURuHFh
X-Gm-Message-State: AOJu0Yybu3e3tHzGYHdxxRyL6/7jfNLMX5N1KUjLazkrITNAJIunSl6L
	3KzvENlHQEWR8DehWnhrKyI35n8tupRfupR2PWqswxx1X7t9GIeLbwz65fR07rqhNgbVRJCvsFD
	w200gCt4iaVw82Cx8/3j6zIWeiPkk9fR3SOH1jQ==
X-Google-Smtp-Source: AGHT+IHre9CZfrwCr+2Zr/doXN48B0LmWFsKXYVStPNCfzBqck4HKosJJb8s7ck5ghhRK6GFB6aXt07XzMJmGo22k+4=
X-Received: by 2002:a17:90a:a108:b0:2b0:e497:56f2 with SMTP id
 98e67ed59e1d1-2b6c70faab7mr18694886a91.10.1715681171194; Tue, 14 May 2024
 03:06:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503221634.44274-1-ignat@cloudflare.com> <CALrw=nGhgRrhJ5mWWC6sV2WYWoijvD9WgFzMfOe6mHmqnza-Hw@mail.gmail.com>
 <D18XXJ373C2V.2M6AOMKD1B89W@kernel.org>
In-Reply-To: <D18XXJ373C2V.2M6AOMKD1B89W@kernel.org>
From: Ignat Korchagin <ignat@cloudflare.com>
Date: Tue, 14 May 2024 11:05:59 +0100
Message-ID: <CALrw=nHGLN=dn3fbyAcXsBufw0tAWUT1PKVHDK5RZkHcdd3CUw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] TPM derived keys
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, serge@hallyn.com, linux-integrity@vger.kernel.org, 
	keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 1:28=E2=80=AFAM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> On Mon May 13, 2024 at 8:11 PM EEST, Ignat Korchagin wrote:
> > On Fri, May 3, 2024 at 11:16=E2=80=AFPM Ignat Korchagin <ignat@cloudfla=
re.com> wrote:
> > I would like to point out to myself I was wrong: it is possible to ask
> > the kernel to generate a trusted key inside the kernel locally with
> > "keyctl add trusted kmk "new 32" @u"
>
> Not in a full-time kernel position ATM as I'm working as contract
> researcher up until beginning of Oct (took some industry break after
> a startup went down of business), so please, politely asking, write
> a bit more compact descriptions ;-) I'm trying to find a new position by
> the beginning of Oct but right now I'd appreciate a bit more thought out
> text descriptions.
>
> I'm working out a small patch set with James Prestwood to add asymmetric
> TPM2 keys based on his old patch set [1] but laid out on top of the
> existing baseline.
>
> I did already the key type shenanigans etc. for it and James P is laying
> his pre-existing RSA code and new ECDSA on top of that. So this will

This is great. Perhaps we can finally have ECDSA software signature
support as well, which I have been trying to get in for some time now
[1]

> give x.509 compatibility [2]. This patch set will be out soon and likely
> part of 6.11 (or almost guaranteed as most of it is done).
>
> So by plain guess this might be along the lines what you might want?

I don't think so. I have seen this patchset, but unless the new
version is fundamentally different, it looks to me that the asymmetric
TPM keys are the same as trusted keys except they are asymmetric
instead of being symmetric. That is, they are still of limited use on
stateless systems and are subject to the same restrictions I described
in my revised cover description.

On top of that I'm not sure they would be widely used as "leaf" keys
by applications, maybe more as root/intermediate keys in some kind of
key hierarchy. TPMs are slow and I don't see a high-performance
web-server, for example, using asymmetric TPM keys for TLS operations.
Also, as we learned the hard way operating many TPMs in production,
some TPMs are quite unreliable and fail really fast, if you "spam"
them with a lot of crypto ops. I understand this is a HW/TPM vendor
problem, but in practice we're trying to build systems, where TPM is
used to protect/generate other keys, but most of the "leaf" crypto
operations are done in software, so we don't make the TPM do too much
crypto.

Just to clarify - I'm not arguing about the usefulness of TPM
asymmetric keys in the kernel. I would really want to see this
building block available as well, but I think it just serves a
different purpose/use case from what I'm trying to figure out in this
RFC thread.

> [1] https://lore.kernel.org/all/20200518172704.29608-1-prestwoj@gmail.com=
/
> [2] https://datatracker.ietf.org/doc/draft-woodhouse-cert-best-practice/
>
> BR, Jarkko

[1] https://lore.kernel.org/lkml/20221014100737.94742-2-ignat@cloudflare.co=
m/T/

