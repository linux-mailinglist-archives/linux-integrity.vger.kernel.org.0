Return-Path: <linux-integrity+bounces-2560-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A878CC939
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2024 00:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83CFE1C21167
	for <lists+linux-integrity@lfdr.de>; Wed, 22 May 2024 22:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1591494A8;
	Wed, 22 May 2024 22:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cYGB4NaX"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39527CF30
	for <linux-integrity@vger.kernel.org>; Wed, 22 May 2024 22:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716418423; cv=none; b=tUJIEORzz4B1UY1qeVSPbSXAVXDgl3QTMmu1JPBNFIMxGJpJd1UPjBS8/DsXCKnZ6qJzO9Y18eSiOCiylzjBviCcQmrVDs8YNYkiPCYWBwJx2lrJVSs3GQLZlXPtyoUt0yNWDkYmVdIepRXu7bcMTBOX3XJCB3ptdNDFNsb+EuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716418423; c=relaxed/simple;
	bh=s+AFZiWYdfo9LHxXiFDhhaTaz5In1NnrT6e/kTcTOec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pC2wxipJ3Arl37nnfvYgSUTNaYOBVurNlTbuRFYTaAdaybrRbSGYdHEleN5yM0MCUZunBBQYl2GyWXxeu3KU8C9MJtuQCE9n7n/vLe1Aoau7d6DKb7+OZnRMK4BxPECy2oAIbSuyuKjrz6P3Ddu9eIrRzSCnodLy+5iCLAJWdUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cYGB4NaX; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a5a5c930cf6so1067334566b.0
        for <linux-integrity@vger.kernel.org>; Wed, 22 May 2024 15:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716418420; x=1717023220; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5pQI3o2sJHQ9VDDihE2wM0f+XoWWITjrXXHCRcKXU50=;
        b=cYGB4NaXjHoGhca3ct5DdOYiHDbjeYgf/lCZgYEQVXHA4Fd/2rhq6+ihkXNLqF1Vol
         NC60TUEV3/o7Cx0ouNwYyRVjZrvx3ioRVS5Zyzyk5+8acNKiXgb9B6xUj6jbxZl37MsV
         BQv7jYJxwnztR/fVhohWau7RZvr9VvsMl8qlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716418420; x=1717023220;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5pQI3o2sJHQ9VDDihE2wM0f+XoWWITjrXXHCRcKXU50=;
        b=OOz8hsR4ZuAg73HuIxiZcQaOxZme2GsXygqA6cNOSuRc42z3WspwKx0bvQWfeLhNSB
         3sLBs5fY54fLTykiDFVz0dTEpiC4tVcuyUEsRCfLcXqiWbWGpQ72W5UNKz8AqEJn3Pm3
         oSGq76aWrPmE/5XkVLRaVEsfgQodIDz/iMkaebbFY2XuiU92SVDVj34e9V6S2RxrK4XB
         IN2YutcMPQ9+jAMoB41KJrA5l9ncdWqYryhJyflN/DJrdMP6M3w4xaACNCgPkRwm6Lr/
         XT5mMaifix4RwRxNAfnMfKKSMJcRHjMKXBocTH/LfLUfeZBMdjuM9O7HxLHBFV79rm4/
         oNEg==
X-Forwarded-Encrypted: i=1; AJvYcCW8121BVICkdWMacC1tioSAms5pK8tx8iKCW1VzzhufxtkwCfC4PRydhJCP2weTOgM80lzEaxDoN1aeDY9C6n296uWyDFwxcwcJsKV7rRCR
X-Gm-Message-State: AOJu0YyL4XWSdyvLhRaWKSF6og5QT99+R3C5zL0wYw/qq0c3QwwK/D2e
	ED5HLG4ff6OXp1iE91BuEHTEFAooniw53+6/qVOdnr8nbptsZihYWeyPWjwQK/IkGniJv+HS3HS
	pwi650Q==
X-Google-Smtp-Source: AGHT+IE3J6IUDinsWtY1vQ30rv6fQTgARsvQp+ZR16Lf8MBQp2b99Euu+x9Ettu9ebivvaurQlEY9w==
X-Received: by 2002:a17:906:b4a:b0:a60:46a9:7d60 with SMTP id a640c23a62f3a-a6228083ac6mr202929066b.28.1716418420084;
        Wed, 22 May 2024 15:53:40 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a61a00e96c1sm483094666b.151.2024.05.22.15.53.39
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 15:53:39 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a59cc765c29so147140566b.3
        for <linux-integrity@vger.kernel.org>; Wed, 22 May 2024 15:53:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUSLGQff4KfJjHdN2VCnf2+2DiilSBjC/HacfkJvZW6QV+0RGJ1hldEcHgGo266PzpuP9QY/DR1gWNOKRjjLVQwp9ujVETbF/3hqxwe7BuM
X-Received: by 2002:a17:906:6945:b0:a5c:df23:c9c6 with SMTP id
 a640c23a62f3a-a62281673cemr222082266b.47.1716418419345; Wed, 22 May 2024
 15:53:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0d260c2f7a9f67ec8bd2305919636678d06000d1.camel@HansenPartnership.com>
 <CAMj1kXFE_R_x10BVkU+8vrMz0RHiX0+rz-ZL+w08FH2CLQHZXA@mail.gmail.com>
 <66ec985f3ee229135bf748f1b0874d5367a74d7f.camel@HansenPartnership.com>
 <dfb0d930-7cbe-46c5-be19-d132b4906ecf@notapiano> <D1C2NPOBHAHK.20O4IME8OK1FH@kernel.org>
 <20240518043115.GA53815@sol.localdomain> <ZkhS1zrobNwAuANI@gondor.apana.org.au>
 <00bcfa65-384d-46ae-ab8b-30f12487928b@notapiano> <ZkwMnrTR_CbXcjWe@gondor.apana.org.au>
 <07512097-8198-4a84-b166-ef9809c2913b@notapiano> <Zk2Eso--FVsZ5AF3@gondor.apana.org.au>
In-Reply-To: <Zk2Eso--FVsZ5AF3@gondor.apana.org.au>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 22 May 2024 15:53:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi7vwgzD4hdBzMrt1u3L2JyoctB91B7NLq-kVHrYXoTGA@mail.gmail.com>
Message-ID: <CAHk-=wi7vwgzD4hdBzMrt1u3L2JyoctB91B7NLq-kVHrYXoTGA@mail.gmail.com>
Subject: Re: [v3 PATCH] hwrng: core - Remove add_early_randomness
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Eric Biggers <ebiggers@kernel.org>, Jarkko Sakkinen <jarkko@kernel.org>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, linux-integrity@vger.kernel.org, 
	keyrings@vger.kernel.org, regressions@lists.linux.dev, kernel@collabora.com, 
	Tejun Heo <tj@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 21 May 2024 at 22:38, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> In this particular configuration, the deadlock doesn't exist because
> the warning triggered at a point before modules were even available.
> However, the deadlock can be real because any module loaded would
> invoke async_synchronize_full.

I think this crapectomy is good regardless of any deadlock - the
"register this driver" should not just blindly call back into the
driver.

That said, looking at the code in question, there are other oddities
going on. Even the "we found a favorite new rng" case looks rather
strange. The thread we use - nice and asynchronous - seems to sleep
only if the randomness source is emptied.

What if you have a really good source of hw randomness? That looks
like a busy loop to me, but hopefully I'm missing something obvious.

So I think this hw_random code has other serious issues, and I get the
feeling there might be more code that needs looking at..

              Linus

