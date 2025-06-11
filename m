Return-Path: <linux-integrity+bounces-6423-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4125FAD5EAF
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Jun 2025 20:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00FBD16582A
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Jun 2025 18:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0C9283CA2;
	Wed, 11 Jun 2025 18:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CGUwc5Lc"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435E0195808
	for <linux-integrity@vger.kernel.org>; Wed, 11 Jun 2025 18:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749668382; cv=none; b=JzyQTjJ4yQHz0EQ2b3o8CZrSS9wVvsWiEhNT2rxXYdalJUDX69bsigQTSIwnRAbwM++Bgj+AXploBOd23FUcD75bbkEte8uRuiYYsDcZdsGlPLtZsIPScthh5qW/0VDL4qERXZTHHfMq0TAhxzGrjzxmZ4Njj6KpE3NkjdP2uHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749668382; c=relaxed/simple;
	bh=novuMTuhYNzqynSwAmnzr3dM+uqQhwQCtXMewPa/Wkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C4DkB7BCPB6EHvU4Zl6ecMVQO50FJtsMkBz5gsxH8P8TiWa/lkyqfNPOq7s523e/re4WR5JAYpju4RQFRh0mo7PGLiYxuhdD6wzYyCE4u12QHruGAZh00EZpAs9WB/a0S8v2mp+FjEKNwxjnJ/DB2SE1YcKCWtaRzO8rVRvNrF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CGUwc5Lc; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ade76b8356cso27199766b.2
        for <linux-integrity@vger.kernel.org>; Wed, 11 Jun 2025 11:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1749668378; x=1750273178; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p4nKI6dictu7VKkBmue+gE/ANqM7N/0dOk6jpGABvHA=;
        b=CGUwc5LcY/RKYUQmw1G93Y6GCRtWiXcYG7pedu+cPr622ChpXEu1BMslwTpWid2zPC
         74d1mPILRllHcn9IiEzRHs2eSI3KKNIO8PuLrpQNXeIEtUTGQzBF82oTDwfR59Qskcoe
         jsf3AP1ejl4BxquhUL1OIR3QgRCjcDq9BSDSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749668378; x=1750273178;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p4nKI6dictu7VKkBmue+gE/ANqM7N/0dOk6jpGABvHA=;
        b=QIcjxM5jV1Es9XMF32X41heiCuDjsT7xszMMwOcj9NXWjLfmLIRlttBm3G9S0sAl22
         zsB/OPNBqvbWnRRikiuWvxFyH6yAjaxcCURCZVSEgB1kRxKTvS+W6kPMCtroF3GVzm/X
         O7QtdkMsbqfS2grlN/fixUJNQvuPXgTKs+2+5he4eC9rmysR+ZsRTnPxP3m6WNFKLuDJ
         IErplCRyfSGCVLLkRnqrKOhz0T3/940yNjtOCAJZsaGla20w7VJfH75qIFTXsYl04Svc
         OdFvjtXvEyARLWUzHkl9b1lKFON5dg+x5LMOKrefU7w404YbUsEGm74SqR0erchRZP1y
         vh5A==
X-Forwarded-Encrypted: i=1; AJvYcCXNq/ZjmAvCFPUSUWCV8jjbpAgyVE2HuPWqfXAgemjkJg6QaQSSRMhshF0q/4/LCI/NYg54GD3Uays1zwj8dP0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5khJO05Um4UF6hW0yqMzDKuSCLnQ4/gR+AH2mCW8GWqjXkyCx
	ilmGVI9q+pq1xZhj+pP/nCQCikk2bEwvZwd2hoyDXVzO4zxQRCGr4vfPv/s9GmPjOwmLg7vdD7g
	5q8yVGvs=
X-Gm-Gg: ASbGncuyx+25KCksPuey5ufvdxvPEa0cDjc4CT4QTGKKMvcf5cuQSv9pRZSND3DCh3B
	ofoH5+gWkPNr9TT/H2T83xh2OmkFcrLib9PbhIMtg3vVxzirsjf3BB4DfjL7y9AJHEt8NVsgt4R
	6icKvyf11oG9QEGptsMuakjDk5EN0xMFNLDRkNiNJjupMuyx7+EuXsESSbzqC48f62jRPWl8Qq1
	PeGd11Fm4Np1gLH1UYbE1+9I6ZvP0/UkcZuGAYaL9VNGHxn6YLfhRYfhOGvJ76vEtxyEN2p6R/k
	CLtM/qhL8xNT4m9OrnP2X/8ZTaqujObpJATYJg32xvHjLV9XV1Ho59ut2Dv4vDVqV88I6s80SR9
	3W0TM8gdnIhZBpZKTHbvFHrsGOZkEOZinQQa/
X-Google-Smtp-Source: AGHT+IHMuA7Nq72C8ivdbJ7SJap+IUZy7v9IcQt+s9+CzhojJ2eaP4pw9e93Sv7T8IZoFY5NadsbLA==
X-Received: by 2002:a17:907:2da0:b0:ad8:9645:798c with SMTP id a640c23a62f3a-adea37afbf1mr72963166b.51.1749668378362;
        Wed, 11 Jun 2025 11:59:38 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade31cc25b7sm860351466b.66.2025.06.11.11.59.36
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 11:59:37 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6070293103cso421468a12.0
        for <linux-integrity@vger.kernel.org>; Wed, 11 Jun 2025 11:59:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWras1KlhdTqi3VOhZDLOCvIDyF78FrpePBMjwpNFFLxSZa3XQvyBy35aLlFqr9+Z5aWKUeGBKl1UrUNXROooU=@vger.kernel.org
X-Received: by 2002:a05:6402:2344:b0:607:77ec:fa8c with SMTP id
 4fb4d7f45d1cf-6086382094emr984600a12.1.1749668376614; Wed, 11 Jun 2025
 11:59:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <301015.1748434697@warthog.procyon.org.uk> <CAHC9VhRn=EGu4+0fYup1bGdgkzWvZYpMPXKoARJf2N+4sy9g2w@mail.gmail.com>
 <CAHk-=wjY7b0gDcXiecsimfmOgs0q+aUp_ZxPHvMfdmAG_Ex_1Q@mail.gmail.com> <382106.1749667515@warthog.procyon.org.uk>
In-Reply-To: <382106.1749667515@warthog.procyon.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 11 Jun 2025 11:59:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgBt2=pnDVvH9qnKjxBgm87Q_th4SLzkv9YkcRAp7Bj2A@mail.gmail.com>
X-Gm-Features: AX0GCFtsLno8Yfd-XNr8pAuQD_5-TGkXF-CBKKMqVdzdI6GXK5Wl1KZHm9JyRfA
Message-ID: <CAHk-=wgBt2=pnDVvH9qnKjxBgm87Q_th4SLzkv9YkcRAp7Bj2A@mail.gmail.com>
Subject: Re: [PATCH] KEYS: Invert FINAL_PUT bit
To: David Howells <dhowells@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Jun 2025 at 11:45, David Howells <dhowells@redhat.com> wrote:
>
> Do you want a signed tag and git pull for it?

Particularly during the merge window that makes sense just to make it
trigger my usual "git pull" pattern, but now that I'm more aware of it
I can just take the patch directly.

Anyway - done just to get this behind us. But for next time, just do
it as a signed tag pull request, _particularly_ during the merge
window when most other emails get much lower priority.

             Linus

