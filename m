Return-Path: <linux-integrity+bounces-6421-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E53EAD5D7C
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Jun 2025 19:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34CA7189361F
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Jun 2025 17:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F209523817D;
	Wed, 11 Jun 2025 17:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RI0tmLNY"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC162230993
	for <linux-integrity@vger.kernel.org>; Wed, 11 Jun 2025 17:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749664268; cv=none; b=NHU+GyuOsPUhUnpGNlbZvR8SpnoEeM8RZxUmPgEuI5MeiVCyy05vkeIye/At4fHBn6J/s59c6aaMWAN5XxCAt8YDfOtXf4pbiz23uEnXJjkHZA869dNRxYB5f2xQTGx5okIe4r1o+N2MNYPtFcRkeggIAcDSIweqN4adLYlMTJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749664268; c=relaxed/simple;
	bh=eGNFqynuBIFAxQfgXXE+O2+YXzwRJnVxUyYET5WrhRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tPPevGIhpwbVO/ev49hJ0JW9OEtb8Wq1ROHzpWXIzcUsI53qVcz5X4pwWenPdkoNNm3VqJ6C4k6NAgy0O15s8sUALXm9lXp+4Pc/AisBJPKQ2Um0Gc2of8OIIqk/ctlSRtPrmx4fxwiQqsbB70LCModZLdLcFsysCt9dXElSUyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RI0tmLNY; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6084dfb4cd5so2081057a12.0
        for <linux-integrity@vger.kernel.org>; Wed, 11 Jun 2025 10:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1749664265; x=1750269065; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sNMRIvDjI5OxxkQoJ1BipcgVGMNLMdRP7oKxRHfqUb4=;
        b=RI0tmLNY5QEW5WNz0qYhzTduHbXV9A7XSCW+/T1xDaZ6lNU7X9SCDyLEhST7TaBc93
         MBdGjX86j6RXXcx9PTiIpK8iMo2omJxdB92F3S09lzu5yMNukm6D9AMlFRyK0V3slTz4
         kDPPlWnT2G+ZnNf68deFFKwujeMXh5uhZpsYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749664265; x=1750269065;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sNMRIvDjI5OxxkQoJ1BipcgVGMNLMdRP7oKxRHfqUb4=;
        b=hGrtkIQRKP+4vv3m8PMnrm2xO/6T82qAApL8B7//eMSuHuIi1sVM3oT8qA/GGMjbeH
         dGzE7bCaTHyn+todoXwPeebszag8TitY8vbV5wK/CqqyA6PwdWTrjeuex8OOaSm4qHYe
         TZ5r1SSObjTd+rj9x3sCWGSPQ3ZGbZL9i8kz8X3yhQf4g3qbFaFT6+F+nlR8ifjXut/p
         mTpMvgsudMV2r+rTEKcWl9HaFqxMYV1rNmiX+S5aj2YtGjsqiVa1r57CmBqB67ARDy02
         D7vDtc1Nr1M2uXwGEWPWoRgzmqmsNG/yngR9dO3OOIRzaMbMrG2Dd+CqT8w1XL7QY+iQ
         yHxA==
X-Forwarded-Encrypted: i=1; AJvYcCVhj/uHTnbRrooLhiAv8R7qamofO9+hTPVddwaEC2llOPbSKhINqCyQ27eVFTnjVx68933PuwHq3NJsr1Edqm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkTvsrJIcjOsWIhg/e2qUzGDib0F4P5ejPLcXLDbrzlQRaDhDc
	CLGKBDM6QhJtzbn33WdLsnrKlvHplXSgXR3XVyKsoEKdDcBBusHR3EOnyWyeVA1nVT4OeDDUzyu
	uyT4Jmrk=
X-Gm-Gg: ASbGncusjX56g0Ku1SZVxhKO44VKM6eoHE8ABTgspL4SSFXLMMWw9C6jSFuhRM1T9g7
	dMU0LEhECEyySMmZbucbLi7SKrsdYY2MmlRqmxncJ6UfwX/zOBSLh1CJn1UUfvAkBSvvTxFadIb
	kQj4/BycaMtopvBTAea6rvVU4s6BZvMoXbvdz9ZyF+2wnhAo21Zbp5IgGdvJLO+QKBl41sQz7ba
	eYI3L1svt3C0+4WUNYDKI7M/+MqYsU/sMxRfk/Pvaev7ywkcvWZKI/lJ1SJrNj7i1jNQeEEulJk
	WSYKfD8xPEoZcG37NOr/uu/qtiT/H7UrykVLjWoJPEbd8B9+qqcydJIKUcC9ghLmQhUbzOd8MIp
	oxYg4XfY4gZTW21CdAQlCIrzkQxyP+ew43qHF
X-Google-Smtp-Source: AGHT+IFlj97W0sjtPP9lTDOoZhIBzEj+oFrDh8B2VK1zAueJNdj7WeAgOKBu5VybjaYqbRrk+Ae6wA==
X-Received: by 2002:a05:6402:518e:b0:607:bf5:233a with SMTP id 4fb4d7f45d1cf-608666975c8mr354419a12.10.1749664264951;
        Wed, 11 Jun 2025 10:51:04 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1dc1c6c3sm936027066b.91.2025.06.11.10.51.03
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 10:51:04 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-604f26055c6so2267447a12.1
        for <linux-integrity@vger.kernel.org>; Wed, 11 Jun 2025 10:51:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWM5CATeF3lB1gGUxqswK3+rvPGe0CrQ+kYdfeIz4Xk7l/vIq6/rBDfmL4d7toKKAzddsqcbiP+pqqAS74Pw78=@vger.kernel.org
X-Received: by 2002:a05:6402:430a:b0:602:a0:1f2c with SMTP id
 4fb4d7f45d1cf-608666342e7mr349953a12.9.1749664263059; Wed, 11 Jun 2025
 10:51:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <301015.1748434697@warthog.procyon.org.uk> <CAHC9VhRn=EGu4+0fYup1bGdgkzWvZYpMPXKoARJf2N+4sy9g2w@mail.gmail.com>
In-Reply-To: <CAHC9VhRn=EGu4+0fYup1bGdgkzWvZYpMPXKoARJf2N+4sy9g2w@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 11 Jun 2025 10:50:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjY7b0gDcXiecsimfmOgs0q+aUp_ZxPHvMfdmAG_Ex_1Q@mail.gmail.com>
X-Gm-Features: AX0GCFvhYmOiGos_n7MIyKSpEE5Y2P1Gb8BenhLqBoBcFZYUdrTRYSzOg_XV1WU
Message-ID: <CAHk-=wjY7b0gDcXiecsimfmOgs0q+aUp_ZxPHvMfdmAG_Ex_1Q@mail.gmail.com>
Subject: Re: [PATCH] KEYS: Invert FINAL_PUT bit
To: Paul Moore <paul@paul-moore.com>
Cc: David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Jun 2025 at 17:23, Paul Moore <paul@paul-moore.com> wrote:
>
> It doesn't look like this has made its way to Linus.

Bah. It "made it" in the sense that sure, it's in my inbox.

But particularly during the the early merge window I end up heavily
limiting my emails to pull requests. And then it ended up composted at
the bottom of my endless pile of emails.

I guess I can still take it if people just say "do it".

            Linus

