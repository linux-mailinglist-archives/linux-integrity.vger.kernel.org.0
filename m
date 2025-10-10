Return-Path: <linux-integrity+bounces-7415-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6D1BCDE10
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Oct 2025 17:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E49611886A71
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Oct 2025 15:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B414126A0A7;
	Fri, 10 Oct 2025 15:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZHgOGbbe"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02922609D9
	for <linux-integrity@vger.kernel.org>; Fri, 10 Oct 2025 15:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760111494; cv=none; b=h+x74mqlgZrkRKq1Adn16Qmd+cXzgLpUdLTt7RynRwzjsKXl+BVTag65jbAWq6PqnSevARiGB9IgQlJJorucGY0alyLLaRRu0/3iM6cQXoqyJlHHNN32dgguvEGiAV0ls02j2N56X6UT0wg29bRoYEXA2Bn8KRyBte07qI4OvKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760111494; c=relaxed/simple;
	bh=XDEDQFIBQ5A8m0eHH6XygH67a3FLRj7kfzfNZO/Y+ks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=luhAGutpJLXwDCg/peeaUiYK+PiwuqVdWUKVvN1xdNIQ/VKAMzfZmbLKXXx+vSRJB+GaJTt1o2782YfAJMxRieARm6GfYQrPttEp6xoFjYpWN3GncMP6CjWLxPyYO0q0jkI8gJYGZs81BRAeUwtHnOfwbtdr2VwzucVXJ+8QNNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZHgOGbbe; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so371893966b.3
        for <linux-integrity@vger.kernel.org>; Fri, 10 Oct 2025 08:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1760111491; x=1760716291; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hMHZynW42pdW0SGBO2CIy8IPA/iqePnhTXX2tj/DjpU=;
        b=ZHgOGbbe9XafYiaAAtKkYOU9HwumgXPYAoBVgoMm8ntQaDeeJZqamZX25Glewurto3
         t/SHgt01eOWPz9QZyms+Xr/WmyeWjY4KWv6Dh3mCWJ5VBi2KVrGxvp4eS1HJOaR26hvB
         vH6KRGW8Nh1z/JEvkcBb/JI0/+37d2Ec65uNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760111491; x=1760716291;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hMHZynW42pdW0SGBO2CIy8IPA/iqePnhTXX2tj/DjpU=;
        b=BBSKjnr3LZ9nKkXavPYqx1nTNJpVjmDb5T857/E+DQA+8vgdsahub9PNpYwUopRcn8
         zsXpX/y9gtPfoxtIwGsEwKQk0CBjCsgDV41kD6wqrSFrJYyZka+sOf23CqTzVXHryAld
         9J9gZtQigBRk1Ebp6gaO/Ieo+CFz2hWKTuEI3cmCMO0nveD80MemtTWP39+8vSkpu3qp
         GMq90Z7tNOGLYWR6tsE3TLasiOBwRpmRaVc7bkwYZ38a4ZLLHcNfyBhm8wyEdSciwX80
         rUqNY9nbL8XYq5d1CQ+xpcM/x+xJSN7N4mBXXES1+li/5AC7J7Oad1NlyZ7wm0Gr/jcY
         g/Bg==
X-Forwarded-Encrypted: i=1; AJvYcCWmQJbMt+iRJgahPBSvg5MD+RrSOWMZ1XfmkO8qeqwSQOIDBmKw2fsLP/hL3ZwY21JqOGo6y1UoQfetI/FOQaU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnj8IMMJ8+SLuCJEawZoGJREy7k3w6PKrbhMY257e9rHhRY6lF
	lAWjRAE1/hkrBulQR0UhQoR0AAiHwtRYU7e1oJX61kWxnOyX7A+ma2m1ienS+Gi+Glju309eINe
	x+o6K5Dk=
X-Gm-Gg: ASbGncufQDQVlA1FnK93y7eDM4C+VtkBOp2rmLHarWOj5hR9Q/vtP46BZrDc7IyQ601
	mBziMwjyRbmRGorzCw9/PVzPjxzdUio9I5pFZPvFPsQXDqH+R9DJjcWXQEXHcLCOhBGSkUm9s6g
	atGS1aUFEtu8K1OddCRq6z+QxbTY6pCBoSzS71NzbHIaGB4qcYfU4qMDlflpd7FJSzVwxO3/u4A
	GIgEjmi35zuOVHJL0gIQMqujlSTdIbzI7/li1879XkUVHgciybSi3i4IgjrfAhMthsJz26O5ep8
	5qe8O/L+RYAgcI62aRI61ZzeSUnJjIhvrHTGLouPvXF4NcFmAIUCrYZTF8/a65xHektt58vxNnE
	s9r2KOnR+LQTjre3ue39DeUacRX7bcs5ib4nwIxLCe7z60OOxC3vJqqsnZzNtcspNVgUkWsmt6o
	AlZz9boBQFimLdLtcE/LOkm/d2L1nJL4KA+jMA
X-Google-Smtp-Source: AGHT+IEYB04uKLTuLxj8mqX2Szt2dQ+GQJgC10d7/MkJhCFVNx4CznwR2bpNQce7ljvvaov6SndVCQ==
X-Received: by 2002:a17:907:7f8a:b0:b43:2a3c:c74a with SMTP id a640c23a62f3a-b50acd28ef1mr1143900066b.60.1760111490665;
        Fri, 10 Oct 2025 08:51:30 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a52b715ffsm2640438a12.22.2025.10.10.08.51.27
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 08:51:30 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6399328ff1fso3769254a12.0
        for <linux-integrity@vger.kernel.org>; Fri, 10 Oct 2025 08:51:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVVkaKp/31ZGhH3NlmPY9yJZ5ryVp/ukeD02nyBlq2sFcHYViVvaqEutpFx/DrFTSZrSzMdl951+luHJKLWooo=@vger.kernel.org
X-Received: by 2002:a05:6402:42c3:b0:639:e7f1:92ef with SMTP id
 4fb4d7f45d1cf-639e7f195dbmr9233647a12.19.1760111486075; Fri, 10 Oct 2025
 08:51:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aOibAOKu_lEsSlC8@kernel.org>
In-Reply-To: <aOibAOKu_lEsSlC8@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 10 Oct 2025 08:51:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=whUUZpENHKMrrVQwqfBgP9Lm=SxW+a3WmoxZR3JObdrUA@mail.gmail.com>
X-Gm-Features: AS18NWDVmzykydf7s6nuNWo79bD8III-oyk_dOxNA4c_F8d-omvq9FosXPkL62U
Message-ID: <CAHk-=whUUZpENHKMrrVQwqfBgP9Lm=SxW+a3WmoxZR3JObdrUA@mail.gmail.com>
Subject: Re: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-v6.18-2
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, David Howells <dhowells@redhat.com>, 
	keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 Oct 2025 at 22:35, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-next-v6.18-2

So I've pulled this, but I'm still unhappy about the explanation.

You tried to explain a one-line single-character change in that pull
request, and even in that explanation you spent most effort on
dismissing other peoples concerns.

That one-liner would have been - and is - sufficiently explained by
"it performs badly and breaks some configurations". There's absolutely
no reason to then go on to describe how *you* don't care about those
configurations.

But lookie here:

 8 files changed, 137 insertions(+), 199 deletions(-)

that's the actual meat of the pull request, and it gets not a peep of
commentary.

I'd also like to point out that Microsoft spent *years* trying to do
the "we require certain typical TPM setups", and people complained
about their idiocy.

For all I know, they still push that crap.

I would certainly are *NOT* that stupid, and we are not going down that path.

So when it comes to TPM, the rule is not "typical cases work".

The rule is "if it causes problems, we acknowledge them and we avoid them".

Thus the whole "disable TCG_TPM2_HMAC" really doesn't merit this kind
of long explanation.

In contrast, the *other* changes are probably much more interesting than that.

             Linus

