Return-Path: <linux-integrity+bounces-2416-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8368C61A7
	for <lists+linux-integrity@lfdr.de>; Wed, 15 May 2024 09:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A88E1F21355
	for <lists+linux-integrity@lfdr.de>; Wed, 15 May 2024 07:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342104316B;
	Wed, 15 May 2024 07:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ZmPZVsSp"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A843D41C84
	for <linux-integrity@vger.kernel.org>; Wed, 15 May 2024 07:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715757997; cv=none; b=W/KbN2kG7wPpS3xITXqp/NuPU1j9UAXUQF/8XNPq5ItSMgA+ga3t3/EKx0essDm2wDYdiSR9CMnDCn0kBtRqfx7ZipUuaEk6auYYgE1VBDBdu6oDNd5C658Q7oZlHA7fZCvk5g+G7wP8IRtIpcVsHu0DIUNonzyKBzLMdo2Pu7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715757997; c=relaxed/simple;
	bh=pHIDXBNssCBc03cLf2WrSSXPNJV9C69TUOs58UGNXiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PPnO6AB0rfkAijycmBcuiCosq7GE5AH4G8u+J5Tc9FxbA8MadT1mm6Jmfsb7uChqxdPToRGyL/LiI03wx0OQF7ri9Us5qcGnSSTtE7q0cxJBlVpGYZSCNP2yhFnJ5/r2K1YrwCwf6AmOsc6dZYUuA7i7cVAfa6LaaJDlQ1DKCQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ZmPZVsSp; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f489e64eb3so4570319b3a.1
        for <linux-integrity@vger.kernel.org>; Wed, 15 May 2024 00:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1715757995; x=1716362795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZrvNGMUcH8kbhXEijiFcgBH5XmfO0e+fTQFgvwJdcDA=;
        b=ZmPZVsSpAlOrLOzNVMuNGm3E1tubJAyWkLqcvdYvVAK7vZJzS3L6wQ6BuZZJROZPEe
         Ha1THimHGr+6u/jjHA5oDXOQlp1pQBNi7VEeTlyceIccBGCUTm7g61bQaUlk1jE1Nsy4
         9Se0qQqO1dqqSz3MVJQabkMV0Dv8m/z2AhYLSPG+GhSzuHUQoEL7xYwTOCJYV/SY93Xe
         7mXuMw/xavBZwbEdo30lqLS4z5F6fAAIDL+MKF3rDSCA65OOuNXV9JdRKZdS5GiWxQal
         AQjxAk68cu2Re4pM6zdLZFahaN+9sv6cwjHrkzqRtPl4MkCEzclOzihAxVs4L0ogHvB3
         k2jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715757995; x=1716362795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZrvNGMUcH8kbhXEijiFcgBH5XmfO0e+fTQFgvwJdcDA=;
        b=KOxgLXEnAgmkmvsJ3iixjMkgWF2gduwnSSsJs4tJnV8U2E040f8UG/4GIkTX1HtwHj
         vPI72fu7juvWEBSltsFv7bOFnHXGs0Cu5HuDTZkJkuiPZLk75IsEo5hb51kM7SxKQM5m
         6r746rHfURMzVK6+0VvTQ9ED+UuoPBh9Yd2sjzOr3LkD6PlX7d88AILC4XrznCVlg4hP
         PFf5qXr94lAPMc/FLfR8zaff93vuk141EzZD/OTPuJqRlzrtvSKEPl2FlcIxgJfcztsG
         zsestlRFYio5lrwXa2EHO+D7jY0ANkEuC8EZ8gdDfbx/scx3RSTzOyTNe+WC9oA0aVg5
         i/TA==
X-Forwarded-Encrypted: i=1; AJvYcCWNi7tJVQkVsNy0c5GOLmhuF/vfF5YgWttawvzOo68+yoXECc9ad7CLIvftNCRyTbHrYmqhRXMFi0x+E4Lz03Hn51iQxt548DrnKBshmWTB
X-Gm-Message-State: AOJu0Yxx02OhWZbWt7g1wk0L+1x5RpuEsd+f5Q1zJI0xwTnzhiLDV9Lf
	7c19d1XpDph66bryYML07rhwuAS4yG4tWr5zmAWSqHrFy/D1oHOH0Vfap3bcPzgcg8CqTIyh0xS
	2qmM4gyq3+sHdKYdltPTN3mLvrZ5tRMgOcqKfyg==
X-Google-Smtp-Source: AGHT+IFkuxJNBNByOn4dn/O0DmpomBqME3HUvwwIwYCPNWgsW8k2PYZmU2A6Yq68xZdjZJus/8N9Nb7AiHdNU5pwdUo=
X-Received: by 2002:a05:6a20:12d4:b0:1a5:6a85:8ce9 with SMTP id
 adf61e73a8af0-1afde0a8da9mr16307857637.12.1715757994863; Wed, 15 May 2024
 00:26:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503221634.44274-1-ignat@cloudflare.com> <20240503221634.44274-3-ignat@cloudflare.com>
 <D19QW70177QG.2YC9XL0FT7VME@kernel.org>
In-Reply-To: <D19QW70177QG.2YC9XL0FT7VME@kernel.org>
From: Ignat Korchagin <ignat@cloudflare.com>
Date: Wed, 15 May 2024 08:26:23 +0100
Message-ID: <CALrw=nFsjiGTZDN3vYCN+GC9R3eQ3ix6_u2x0xo3jcpHqWjs3A@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] KEYS: implement derived keys
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, serge@hallyn.com, linux-integrity@vger.kernel.org, 
	keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 12:10=E2=80=AFAM Jarkko Sakkinen <jarkko@kernel.org=
> wrote:
>
> On Sat May 4, 2024 at 1:16 AM EEST, Ignat Korchagin wrote:
> > Derived keys are similar to user keys, but their payload is derived fro=
m the
> > primary TPM seed and some metadata of the requesting process. This way =
every
>
> What is exactly "some metadata"?
>
> > application can get a unique secret/key, which is cryptographically bou=
nd to
>
> What is "cryptographically bound". Please go straight to the point and
> cut out *all* white paper'ish phrases. We do not need it and will make
> painful to backtrack this commit once in the mainline.
>
> > the TPM without the need to provide the key material externally (unlike=
 trusted
> > keys). Also, the whole key derivation process is deterministic, so as l=
ong as
>
> Why trusted keys is inside braces. It is not important for the point
> you are trying to make here?
>
> > the TPM is available, applications can always recover their keys, which=
 may
> > allow for easier key management on stateless systems.
>
> Please drop "stateless system" unless you provide a rigid definition
> what it is. I have no idea what you mean by it. Probably not that
> important, right?
>
> >
> > In this implementation the following factors will be used as a key deri=
vation
> > factor:
> >   * requested key length
> >   * requesting process effective user id
> >   * either the application executable path or the application integrity
> >     metadata (if available)
>
> NAK for path for any possible key derivation. They are racy and
> and ambiguous.

Can you elaborate here? What kind of a problem you see specifically?
(This is exactly what I want to get from this discussion)

> This should have been in the beginning instead of "some data". What
> other implementations exist. For me "this implementation" implies
> that this one competing alternative to multiple implementations
> of the same thing.

With "this implementation" I meant the current RFC patchset because I
do expect there would be more iterations and just wanted to solicit
comments.

> I do not like this science/white paper style at all. Just express
> short, open code everything right at start when you need and cut
> extras like "stateless system" unless you can provide exact, sound
> and unambiguous definiton of it.
>
> Just want to underline how this really needs a complete rewrite with
> clear and concise explanation :-) This won't ever work.

Understood.

> >
> > Key length is used so requests for keys with different sizes result in =
keys
> > with different cryptographic material.
>
> What is "key length"? Please refer the exact attribute.
>
> >
> > User id is mixed, so different users get different keys even when execu=
ting the
>
> First of all it would be more clear to just s/User id/UID/
>
> And make obvious whether we are talking about ruid or euid and how
> this interacts with GIDs.
>
> I'll look at the code change next round if the commit message starts
> making any sense.
>
> BR, Jarkko
>

