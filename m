Return-Path: <linux-integrity+bounces-2403-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 229F68C596B
	for <lists+linux-integrity@lfdr.de>; Tue, 14 May 2024 18:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A70CA1F243F1
	for <lists+linux-integrity@lfdr.de>; Tue, 14 May 2024 16:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF0217EBAE;
	Tue, 14 May 2024 16:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="R9Yqk8AD"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5819F1448F2
	for <linux-integrity@vger.kernel.org>; Tue, 14 May 2024 16:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715702949; cv=none; b=oVsnUPgEJhmm99enUbnzTUEnQr/642Pbm5a4rd6iW25W3hKBm01n4Tl+ziF9FGb1qr+9qELRPKNt3Jw5WSp6AN9VC152vg0D9c1x4YzwoBOPqHn7dwtXMuXSQDAiuEY39XgRoO7ny4EEiPhxxzTNQlBqm8mvauQRCZ0Or3fmv3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715702949; c=relaxed/simple;
	bh=2NaUwO+c1ZDsGQvErbOvxItcWN5Zu9ssbIm5SR9sE/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iMTctCFriVxFsax2z064laEhefVrkTbDy0Al5a7Gn6zekC7GFYHi+9OOURJHC7TyEmtPVXzQUmtn34tNQteU34a/2HNsYIxQmAFNSg8K0mLmteUmGhq0wWR5XChY8ecW6213YzwW0xVeJvzZjiIDB58uML5UtppUucL23vpxv28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=R9Yqk8AD; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2b346712919so4116851a91.2
        for <linux-integrity@vger.kernel.org>; Tue, 14 May 2024 09:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1715702947; x=1716307747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lAA8ABQW5Kp/Vp6EOKwo5QYY73GU6/0kgQ+y5yUiQfk=;
        b=R9Yqk8ADJ+3zPgFFAnTnautQkuSWGkfokRhRfuh2g6w0ApKsmVPE1phfXWMHNdPHcY
         kItrOBsMHc4AkbN/ZEinzT6IyFNwz9DmmNR1cB6IjxI+7A+Eu2doDr/3of0H7dKz4pu/
         rLW1zP/NpDwrqnS+GIwvH0nXjDjbP6dQK6Bvl7KSoBsCPgLWKHZ2uZv4ZLtWXAny94bW
         UeiHbpaAtmGwFWF6tpTGevFbzbtFL+QkhIp3lPoHhO2tuQfObvV/EJL4tP3nPxznSnhH
         Vlxhe6+BG4sVnRk0ZuS8D4J++SV9DLY8HQcJDZ+bDR6hKHlxw4ewrHv4VYSaa46FFqs0
         Dgow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715702947; x=1716307747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lAA8ABQW5Kp/Vp6EOKwo5QYY73GU6/0kgQ+y5yUiQfk=;
        b=aQDtwoXg4/cYYApAbVS1i6GxN1tLdmX3bzFG/NDcNmXRVjoyNb9tVTBiKENy60sst/
         KccnmW2IvCDZB7N6XWZOMcPfPRQEWsjlHtZXSOSAwuTE2KxdAA7fmAdZy0QDQpdDzUCq
         8xv4bk54yV9w5eyZ8cKDIiqJqywbNoYa+zFH+U0ucg5+4Ej/JPemtYhi5H0mThmbcWtu
         sTOQ08evwyP6dF9zkBHLxZwbLzClfbXIqgw6O4KQpHj6AlKCh9pHVcjVAlKc8GHy8IXd
         mi4zqYjuRQeWS/WXz2SD7qygYf8+TbZRFUGpYIQ1F6NpZkuwgPN5nQVr4E+WsWnlLtSP
         uQCQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/qSsZVwyzb7qBJwfQL5zgknHwh1X8lpI8kxaWMO9s2yNR7VgC4s5h2iStVQTWA3+S7y/dRHESslUly493anzSOU3LXNnQHxu3lrVxPXtA
X-Gm-Message-State: AOJu0Ywc+JbuQTaD9gbofAdZLFzqmO2H0K7dnm958ZtOg4akVkwE9vty
	7NMv58vjDPzNx+8l8dwMW5mDVj6yk2NsMd4xphfiFKb3TkX/426udwnfH3KWjSGHIIGWg9MokeF
	5W8Udup9XZvZg/Hnty554sOkTPO7XI7/kXGcWAA==
X-Google-Smtp-Source: AGHT+IH3dmdyHallXCVdxeMNdlicZ1dK8HZ6VAkn0dTMFFhhdJk11v+SFUlYIwiiSPc4lireyO7nGZTI2WmMinVlE0k=
X-Received: by 2002:a17:90a:bd8d:b0:2b9:a299:918f with SMTP id
 98e67ed59e1d1-2b9a29992dcmr1249853a91.6.1715702947417; Tue, 14 May 2024
 09:09:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503221634.44274-1-ignat@cloudflare.com> <CALrw=nGhgRrhJ5mWWC6sV2WYWoijvD9WgFzMfOe6mHmqnza-Hw@mail.gmail.com>
 <D18XXJ373C2V.2M6AOMKD1B89W@kernel.org> <CALrw=nHGLN=dn3fbyAcXsBufw0tAWUT1PKVHDK5RZkHcdd3CUw@mail.gmail.com>
 <D19CUF0H9Q3S.3L5Y5S9553S5@kernel.org> <CALrw=nEZ07U9VhbGsnpchOYw1icUZCnuoHHXkJLzhFqSPe9_fQ@mail.gmail.com>
 <D19F74M6B8UC.2VEOOZHGOS87V@kernel.org> <D19FUGDA2CUO.16EF7U9ZEZ4SD@kernel.org>
 <D19GWXHYP2VC.1OY7BOW5LNXVF@kernel.org> <D19H0UVF3R0O.3N4GLZWFRZ2DO@kernel.org>
 <CALrw=nE7ga6wxSqrJBTOaj+pPXhi4+-Rn4ePRC9vXL-8Qd3GrA@mail.gmail.com> <D19HDMZ1OKN9.2PX2FJVY4WZ09@kernel.org>
In-Reply-To: <D19HDMZ1OKN9.2PX2FJVY4WZ09@kernel.org>
From: Ignat Korchagin <ignat@cloudflare.com>
Date: Tue, 14 May 2024 17:08:56 +0100
Message-ID: <CALrw=nF53qsmBp06qDerh3++0VYm-OZJ8k-Es3+2AAQFRjY-9w@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] TPM derived keys
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, serge@hallyn.com, linux-integrity@vger.kernel.org, 
	keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 4:43=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> On Tue May 14, 2024 at 6:30 PM EEST, Ignat Korchagin wrote:
> > On Tue, May 14, 2024 at 4:26=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.=
org> wrote:
> > >
> > > On Tue May 14, 2024 at 6:21 PM EEST, Jarkko Sakkinen wrote:
> > > > On Tue May 14, 2024 at 5:30 PM EEST, Jarkko Sakkinen wrote:
> > > > > On Tue May 14, 2024 at 5:00 PM EEST, Jarkko Sakkinen wrote:
> > > > > > On Tue May 14, 2024 at 4:11 PM EEST, Ignat Korchagin wrote:
> > > > > > > For example, a cheap NAS box with no internal storage (disks =
connected
> > > > > > > externally via USB). We want:
> > > > > > >   * disks to be encrypted and decryptable only by this NAS bo=
x
> > > > > >
> > > > > > So how this differs from LUKS2 style, which also systemd suppor=
ts where
> > > > > > the encryption key is anchored to PCR's? If I took hard drive o=
ut of my
> > > > > > Linux box, I could not decrypt it in another machine because of=
 this.
> > > > >
> > > > > Maybe you could replace the real LUKS2 header with a dummy LUKS2
> > > > > header, which would need to be able the describe "do not use this=
" and
> > > > > e.g. SHA256 of the actual header. And then treat the looked up he=
ader as
> > > > > the header when the drive is mounted.
> > > > >
> > > > > LUKS2 would also need to be able to have pre-defined (e.g. kernel
> > > > > command-line or bootconfig) small internal storage, which would b=
e
> > > > > also encrypted with TPM's PRCs containing an array of LUKS2 heade=
r
> > > > > and then look up that with SHA256 as the key.
> > > > >
> > > > > Without knowing LUKS2 implementation to me these do not sound rea=
ching
> > > > > the impossible engineer problems so maybe this would be worth of
> > > > > investigating...
> > > >
> > > > Or why you could not just encrypt the whole header with another key
> > > > that is only in that device? Then it would appear as random full
> > > > length.
> > > >
> > > > I.e. unsealing
> > > >
> > > > 1. Decrypt LUKS2 header with TPM2 key
> > > > 2. Use the new resulting header as it was in the place of encrypted
> > > >    stored to the external drive.
> > > > 3. Decrypt key from the LUK2S header etc.
> > >
> > > Maybe something like:
> > >
> > > 1. Asymmetric for LUKS2 (just like it is)
> > > 2. Additional symmetric key, which is created as non-migratable and s=
tored
> > >    to the TPM2 chip. This deciphers the header, i.e. takes the random
> > >    away.
> >
> > This could work, but you still have the problem of - if the header
> > gets wiped, all the data is lost.
> > As for storing things on the TPM chip - that doesn't scale. Today you
> > only think about disk encryption, tomorrow there is a new application,
> > which wants to do the same thing and so on. One of the features of
> > derived keys - you don't store anything, just recreate/derive when
> > needed and it scales infinitely.
>
> OK, so now I know the problem at least and that is probably the
> most important thing in this discussion, right?

Yes, I think so.

> So make a better story, now you also probably have better idea,
> also split the patch properly by subsystem, send the patch set,

I'm actually not super clear on this part - I have two patches: one
for TPM header definitions and another one for the keyring subsystem?
Any other subsystems in play here?

> and I'll promise to revisit.

Thanks. Would probably take some time as I want to think more on the
open questions I raised in the description, try to address some
comments from James B from other replies (key rotation for example)
and rebase on recently merged TPM encrypted sessions. But since this
is an RFC I would like to continue the discussion and gather opinions
from folks here, if there are any more concerns.

> Fair enough? :-)
>
> BR, Jarkko

