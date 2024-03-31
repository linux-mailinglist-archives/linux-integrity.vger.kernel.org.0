Return-Path: <linux-integrity+bounces-1946-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA8F89352D
	for <lists+linux-integrity@lfdr.de>; Sun, 31 Mar 2024 19:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4FD1287ACF
	for <lists+linux-integrity@lfdr.de>; Sun, 31 Mar 2024 17:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7176145B13;
	Sun, 31 Mar 2024 17:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NfXBnRD8"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB5914534D
	for <linux-integrity@vger.kernel.org>; Sun, 31 Mar 2024 17:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711904491; cv=none; b=SiLGAJssPhMlVx0YjSC9JsEUlUenr+7dVQkhkW860MgbZ6T9abgHvnsC1SK3Hn7DHV6jip4Q16w7yEzppd5XQwBYFBgrcP6letJoGhDrreLoKd9SCSKtaPnDqiApZG2ypIgDaCJEn218ZF35gtoEtl/yVS9K2Vzt6uSCTwuN9Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711904491; c=relaxed/simple;
	bh=6uRCnk6Hmq5Dim0u91a9tFMVKCUDB8cTj8Vol5lOhkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nCKHsMJ/uhtV3GQ0jZJB6mi12TkslZoA6oMocsXaqZIDoSe4u19AYMS86CA6dCtGmkcuKpJ8fITDlG2Uh0OLLBk1vpVvnaoFBymhjtY82kf2cM0+UnB7PHn/PObDtEdGEqoh3L9Mz1q4tfEF6YwrGliCj8LHSoJzeEJaAzfexUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NfXBnRD8; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-515c198e835so3763998e87.3
        for <linux-integrity@vger.kernel.org>; Sun, 31 Mar 2024 10:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1711904488; x=1712509288; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/YqF1343zKRwGc00uFMCul0bKtQh7G+6n9UiA2naOCg=;
        b=NfXBnRD83dnuv9Lw6DneKVlxP/L3r4Uy1eYwMMS7DDS5+TddwFOB6cgO54MlWBl4QH
         o7VEnclPwwxQYbjR23Bj8vHZ5r+ZKjpWENdp7+G+Ut+Qu2oaLZDqbwIhJIponwEJSVTQ
         E+R+RKQLP8jJMIWJkoDBA6eTO6gWKjElSBJwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711904488; x=1712509288;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/YqF1343zKRwGc00uFMCul0bKtQh7G+6n9UiA2naOCg=;
        b=nRzKAV4sqxzh+whiqsZfsMNALzkfjH4wVRLMeMeVJWgdECZ1X0zVeN4tQwoEeowEp/
         P1QLqEStNELBL87Mx9/5e3Vs1P3x3qnQQsPvmKjN/cxGq+7eoqO10F6z0eWddhwG0Dpo
         ck19ARgnPFS9IjEFnQ2/BHhmVPUa1Y/rR/sFoFP/QH02tyNI+GObTIWHfBU5J6NBgvSu
         6C9Pjh612fSFdHm9DRRI4yEw5HQqBmYNMKVvNmLZKpVkOvd82kH2QaxUbx83qPc5BcED
         938Zf3XLQmaL9cCr4/yaHPQNHRG6ICE0PP2A8eL9Ihih7M5nJyqgUxrMq4UnKOrIDrq6
         vbbg==
X-Forwarded-Encrypted: i=1; AJvYcCXbqjF3lXU073A9XDHg5+aZOxUUdaAKQO4ID9aM4kcG0V252ACOZ5zNEYdTke9gzPei678ReI3JsLdxazzTdYGISN3b0TOOGqLWA1jGkwXy
X-Gm-Message-State: AOJu0Ywzep0GM4TvVVhvmZVN1BhZtyZiHEKbu0ZjcxNMfftP3aVgS7Tr
	CtqZCdcpPzDZBCih3AHDwg2gWev6AIMkncaGaCPUAeGnWC3whWSK3pkbKfPDQPAKp7XhTZNL4+U
	CkxY/Fw==
X-Google-Smtp-Source: AGHT+IEEoiZyouNj+RdyPc8clY2fGWQARioPraMLULNBgX798VbHGwN/YAH78iPS0XRO7wfk0CTjrg==
X-Received: by 2002:a05:6512:3052:b0:515:a8f0:221 with SMTP id b18-20020a056512305200b00515a8f00221mr6390269lfb.37.1711904487940;
        Sun, 31 Mar 2024 10:01:27 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id bu6-20020a170907930600b00a4e26aec839sm3995263ejc.197.2024.03.31.10.01.27
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Mar 2024 10:01:27 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56c2b4850d2so3931663a12.2
        for <linux-integrity@vger.kernel.org>; Sun, 31 Mar 2024 10:01:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXSk2LVsVhopH+lEvwSUMaFFxXuk4UYlE3ZuBymyt6go9uppyc5H7U5rhmf8sV3Z/0KfHq8gPiGWCsamaVJyDszu09xLePPBe3LMU3GCIRe
X-Received: by 2002:a17:907:31ca:b0:a4e:44b7:50ef with SMTP id
 xf10-20020a17090731ca00b00a4e44b750efmr3944048ejb.9.1711904486771; Sun, 31
 Mar 2024 10:01:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326143838.15076-1-jarkko@kernel.org> <CAHk-=wgNpPQFJyLe5dwEVH66ubviuiwM1_tjbyzQv4BytPw7dQ@mail.gmail.com>
 <D07PD5NTOXSQ.30D5V19O6KMQS@kernel.org>
In-Reply-To: <D07PD5NTOXSQ.30D5V19O6KMQS@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 31 Mar 2024 10:01:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi-VWatwU5Gi6n74LF66dRWCo4dUozwj_DwTBRO-wDFcA@mail.gmail.com>
Message-ID: <CAHk-=wi-VWatwU5Gi6n74LF66dRWCo4dUozwj_DwTBRO-wDFcA@mail.gmail.com>
Subject: Re: [GIT PULL] tpmdd changes for v6.9-rc2
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: dhowells@redhat.com, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	keyrings@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 30 Mar 2024 at 22:57, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> OK, point taken and it is evolutionary issue really but definitely
> needs to be fixed.
>
> I review and test most of the stuff that goes to keyring but other
> than trusted keys, I usually pick only few patches every now and
> then to my tree.

It's perfectly fine if you send me key updates - you're listed as
maintainer etc, that's not a problem.

But when I get a tag name that says "tpmdd" and a subject that says
"tpmdd", I'm noty expecting to then see key updates in the pull.

So that part of my issue was literally just that your subject line and
tag name didn't match the contents, and that just makes me go "there's
something wrong here".

So keys coming through your tree is fine per se, it's just that I want
the subject line etc to actually make sense.

                    Linus

