Return-Path: <linux-integrity+bounces-3586-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C552D9794F4
	for <lists+linux-integrity@lfdr.de>; Sun, 15 Sep 2024 09:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BA932840C2
	for <lists+linux-integrity@lfdr.de>; Sun, 15 Sep 2024 07:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8446B200DE;
	Sun, 15 Sep 2024 07:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="P/fq2uMY"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3C51B85D2
	for <linux-integrity@vger.kernel.org>; Sun, 15 Sep 2024 07:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726384287; cv=none; b=Qi4TcOR6PdA0cTIsU7Oig0W7j8f5XcV31FJJnjAsHmE715w5hS4KKM60/bbgZILWLOohjCTHX4YUPhMOLOv6jYrUKyIYn1euGpmGRu/KYq8g1UryMJCQvELM62PBb9yFI6aFrD0t7ZebC/sqr9C0lHKA6coHMlbt36e50M3lxAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726384287; c=relaxed/simple;
	bh=xjWojUc1mLB5ktKYpFXYU5sO8vFqeC4TxRTtvNAcNTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GOt2XmaLd+bUPT4lH4h+d9IjJ+299zhUK4sLltaOdXJ5tkKc7efB8/p8Vl8vwVR9+g1wJYbaWLtZQQtxlK6HY0o+MLp6HfS+S4LDOqCHW57dkFuVrgCQ3V/9z4SjlIP8BoZRlKjUAh1SLtnHUuMwT5vvxGIQziwMYEXCEYVft9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=P/fq2uMY; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9018103214so481313566b.3
        for <linux-integrity@vger.kernel.org>; Sun, 15 Sep 2024 00:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1726384283; x=1726989083; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Yc55qxpiIVFj7PWD1KIvBrEfXf3cIQSNj9lFEjAYl9E=;
        b=P/fq2uMY2OirKUSkQvbTUKbCBbw4H9TjGrfCyJbcCwZHruMoOxjhErCxjKdmeHq0uL
         E1tfLbLAOzLSaJMzKfgRD4V/VghnEmF/Oxiaxaak0fUVUaU/VxHKCmXHNkOqH9jWpfl9
         idkg9WKUSYtbObH9KJk082d9XAwkHewTc0uFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726384283; x=1726989083;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yc55qxpiIVFj7PWD1KIvBrEfXf3cIQSNj9lFEjAYl9E=;
        b=up/5TfOJz5wcfZq7W483YeW3WQ7DqqpiQ7IknctLFzgfkQT/TFx0qYhm9b6sB1Ww1s
         //UxnMEkP2xCXoHudZE6gWTf+wCAYF7f3T4kWv/BA8Q3wVOqdQpbch5/RcrXZAPRrfTj
         2hJ/9xpGeNRhCGJ+heeZbW1mDduNoYtR7mATbpBE9Wc3TuhJjism2K2ccoQmoSKr40nq
         AKFEOzwvoqFgtG2L01YQisKZog7R53y4s8vbIunhtqJAEb+22NUXsjH1TtNqKtJX/7em
         S9YN2yPImkJwkZVJDDCnhpLoVimbi2yztjL1NE11B1iGgmnd6q/wpKhYRPcmP1k6Wv2P
         7cUA==
X-Forwarded-Encrypted: i=1; AJvYcCUtgyfXxFju4oIGAsLKluxRKzN6DNzd3mtJEI76pPgbfO/rQHsZVk2MeIqpQ/XqOjUr2umIJbKsYQOJbC504q0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZbDuCWlUnF/El4OKE9L+KpJPV19roW3c6jt8ARJn/rmpzGYTM
	48dvovQ/S+VYkA5s92IshMWLJ9ksFaBe1+AvP3N3q1ZoZezYrDM5fiT1gFzpBVu7dYIN7kqfgIY
	7KgO9PA==
X-Google-Smtp-Source: AGHT+IEDUMyeD8sOAUv+RqUAqvcrGuQdsDbPzTjDfHV+MCTuEYwI08WcYCFTs6z54xltJEk3l0jovQ==
X-Received: by 2002:a17:907:7255:b0:a8a:18f9:269f with SMTP id a640c23a62f3a-a902966f353mr1104160766b.60.1726384282924;
        Sun, 15 Sep 2024 00:11:22 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612df547sm161706966b.153.2024.09.15.00.11.21
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Sep 2024 00:11:21 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c260b19f71so3848083a12.1
        for <linux-integrity@vger.kernel.org>; Sun, 15 Sep 2024 00:11:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX+Tjh8G3xngliiXegAYC9enoMhDDaulNu4fnUZykNiEeZaateeIxSG0pukgyXOWDLqhgk2PD0RnkjTBnA3f7I=@vger.kernel.org
X-Received: by 2002:a05:6402:5193:b0:5c2:7002:7cf8 with SMTP id
 4fb4d7f45d1cf-5c413e1f43bmr8669748a12.17.1726384281208; Sun, 15 Sep 2024
 00:11:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZuPDZL_EIoS60L1a@gondor.apana.org.au> <b4a3e55650a9e9f2302cf093e5cc8e739b4ac98f.camel@huaweicloud.com>
In-Reply-To: <b4a3e55650a9e9f2302cf093e5cc8e739b4ac98f.camel@huaweicloud.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 15 Sep 2024 09:11:04 +0200
X-Gmail-Original-Message-ID: <CAHk-=wiU24MGO7LZ1ZZYpQJr1+CSFG9VnB0Nyy4xZSSc_Zu0rg@mail.gmail.com>
Message-ID: <CAHk-=wiU24MGO7LZ1ZZYpQJr1+CSFG9VnB0Nyy4xZSSc_Zu0rg@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] KEYS: Add support for PGP keys and signatures
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, dhowells@redhat.com, dwmw2@infradead.org, 
	davem@davemloft.net, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
	linux-crypto@vger.kernel.org, zohar@linux.ibm.com, 
	linux-integrity@vger.kernel.org, roberto.sassu@huawei.com, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Sept 2024 at 10:30, Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> On Fri, 2024-09-13 at 12:45 +0800, Herbert Xu wrote:
> >
> > Does this address Linus's objections? If not then we cannot proceed.
>
> I hope to get an answer from him.

So honestly, just the series adding pgp key verification I have no
objection to. The use case where some firmware uses pgp to validate
allowed keys in EFI variables etc sounds like a "ok, then we need to
parse them".

The objections I had were against the whole "start doing policy in
kernel", with what sounded like actually parsing and unpacking rpm
contents and verifying them with a pgp key. *That* still sounds like a
disaster to me, and is the part that made me go "why isn't that done
in user space together with then generating the fsverifty
information"?

The argument that the kernel is the only part of the system you trust
is bogus. The kernel does nothing on its own (apart from device
enumeration etc of course), so if you have no trustworthy user space,
then you might as well just give up entirely. At a *minimum* you have
initrd, and that can then be the start of a chain of user space trust.

Parsing rpm files in the kernel really sounds horrendous. But that
doesn't mean that I hate *this* series that just adds pgp key handling
in case there are other valid uses for it.

But maybe I misunderstood the original suggestion from Roberto.

              Linus

