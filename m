Return-Path: <linux-integrity+bounces-3588-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE6C9795CC
	for <lists+linux-integrity@lfdr.de>; Sun, 15 Sep 2024 10:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C36BEB22216
	for <lists+linux-integrity@lfdr.de>; Sun, 15 Sep 2024 08:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B3019884C;
	Sun, 15 Sep 2024 08:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="F6yRrWLa"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4719117579
	for <linux-integrity@vger.kernel.org>; Sun, 15 Sep 2024 08:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726389638; cv=none; b=ZA9eKQT8wBGaPbhn+/SyUshCV60Vl4GwuElvr96Nb5lx2oiPGwpiXwymYQ53oYxRMjTpWEtV272gPWQc3mUeNXKoTKCUX/u5z9gs8CA0qeHUQf1Y3UF0sHoiGBJBVqkz+EjVzf7P7iyWs6/sm8xz2DGaqkjFLyB20QK///DxveA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726389638; c=relaxed/simple;
	bh=7W4dXzHo6ZsXChruk3vokDJnvUK3D1xdySswkG1oy0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TUL3hc3WJsW5fiFCG9Uog93uQY/dLYBSTtL0oxM8lqf5xqabTu4ov0TnhZ0rxnf41zZcrKgOJhA4hkQiGMTH9dpb5KQlY8KDfvOetkntbkcmmNvCCe1AURRvXAoq41dK0v8jmIu9c5quWo3VKsREwWYKaD3QKieR3umTu8shguQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=F6yRrWLa; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c26311c6f0so4756663a12.3
        for <linux-integrity@vger.kernel.org>; Sun, 15 Sep 2024 01:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1726389634; x=1726994434; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IDDAsPUl2QeVKALO8ENGYLR9AUDsg9hKmMIPotwlIM8=;
        b=F6yRrWLam+fKgeR8gbnXbOQcBeZmm7nZWbGY1/8XCIL1LcDP7Ym11iXQHIGZ5jG+Mz
         Nd9Q0eR3d8VAXQKbGVZee7rzvRgnW402q591O3vhT06YLYc5z7zfG0e498R0eMC71Ys7
         Yh4bchsDMMZJfK4FC/QsY54d2QeUBSu5JZ1SQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726389634; x=1726994434;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IDDAsPUl2QeVKALO8ENGYLR9AUDsg9hKmMIPotwlIM8=;
        b=AIiX7jroURHIKn/ZfEjpI2Y3ZBJz4BY3/vYXlwiHjxYDeLIAZuZFiFIycBkT/zXtji
         FoUTkMh0RiHOktSqKjcO1kcd73nsOBxQZ0rUfNUy4Rvtv7x4T5LjiOPHisQ6fEewNjnR
         VvpN1DGXYGyk86PkrbwYII0gdjHNDnQS+7wo4uBEAGNSwyuAZ76U0UOhjs5lkIlyopSh
         DkbQHzZSbBYdGjsXG8QI9QBUyru8z6SYXNqRPti3hoHD4pzwoyUIFrJ+tIQQSdxJM+wY
         gfm+Frsws9SjmMFFRy4aGsMlKFJQ82FPS3kqqFRSNb2QkY4kuWklsugfMH6ROnmCQ0Yk
         uy3w==
X-Forwarded-Encrypted: i=1; AJvYcCXlkqGQHr+UlesJA10PiGsWuz7YYYxrF1o3OBtxiCvDHPWbjxqkLw8S9X/l+r3EmqalsehYBH5NRRe82UcjZXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA3kB7PhvFhEBaxZnYBQfAcuyzvfZA1NUeDMaaBEcxunQJw06D
	Y4vNobLG5QITDkWPoijMxeW2GIsxMJyQCgQPUq8P2Kb7jZaOHEDlHrQHT0N8PyKdaVXvoI6LBWn
	4swLyKw==
X-Google-Smtp-Source: AGHT+IEbwmevG43Jp1Prat85DHvfvI48Z2HRijkIfrWL423kqb1j2NwA7x7VzxJX/0M/9xTYB1qghQ==
X-Received: by 2002:a17:906:c151:b0:a8d:5d28:8e0d with SMTP id a640c23a62f3a-a90296175a4mr1368430966b.45.1726389634289;
        Sun, 15 Sep 2024 01:40:34 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612b38c8sm169344166b.103.2024.09.15.01.40.32
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Sep 2024 01:40:33 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c413cf5de5so4671541a12.0
        for <linux-integrity@vger.kernel.org>; Sun, 15 Sep 2024 01:40:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVaMFqiYfJI47yrqkedT1a3Kpka67qJDZLSh8QIih2a5m37Aw2Y5lDQ9z9qn7l/pf3DcrYUFDKYVQZHcfLot1w=@vger.kernel.org
X-Received: by 2002:a50:9b57:0:b0:5c2:58f7:fe95 with SMTP id
 4fb4d7f45d1cf-5c413e5164emr9626495a12.31.1726389632541; Sun, 15 Sep 2024
 01:40:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZuPDZL_EIoS60L1a@gondor.apana.org.au> <b4a3e55650a9e9f2302cf093e5cc8e739b4ac98f.camel@huaweicloud.com>
 <CAHk-=wiU24MGO7LZ1ZZYpQJr1+CSFG9VnB0Nyy4xZSSc_Zu0rg@mail.gmail.com> <ZuaVzQqkwwjbUHSh@gondor.apana.org.au>
In-Reply-To: <ZuaVzQqkwwjbUHSh@gondor.apana.org.au>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 15 Sep 2024 10:40:15 +0200
X-Gmail-Original-Message-ID: <CAHk-=wgnG+C3fVB+dwZYi_ZEErnd_jFbrkN+xc__om3d=7optQ@mail.gmail.com>
Message-ID: <CAHk-=wgnG+C3fVB+dwZYi_ZEErnd_jFbrkN+xc__om3d=7optQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] KEYS: Add support for PGP keys and signatures
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>, dhowells@redhat.com, dwmw2@infradead.org, 
	davem@davemloft.net, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
	linux-crypto@vger.kernel.org, zohar@linux.ibm.com, 
	linux-integrity@vger.kernel.org, roberto.sassu@huawei.com, 
	linux-security-module@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 15 Sept 2024 at 10:08, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> If the aformentioned EFI use-case is bogus, then distro package
> verification is going to be the only application for PGP keys in
> the kernel.

So I haven't actually seen _that_ series, but as mentioned it does
smell pretty conceptually broken to me.

But hey, code talks, bullshit walks. People can most certainly try to
convince me.

                   Linus

