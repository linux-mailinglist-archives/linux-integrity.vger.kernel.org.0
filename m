Return-Path: <linux-integrity+bounces-2415-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA5C8C60F7
	for <lists+linux-integrity@lfdr.de>; Wed, 15 May 2024 08:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE2B21C20D9B
	for <lists+linux-integrity@lfdr.de>; Wed, 15 May 2024 06:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B963D962;
	Wed, 15 May 2024 06:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Kztt4isx"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A260A3A8D0
	for <linux-integrity@vger.kernel.org>; Wed, 15 May 2024 06:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715755461; cv=none; b=qmfcFrLpMgEcgQUvg2O9T8swoOcMTQGQ4/U1lmtHu883H64nrSj5yN5WlvaXrPieIcq61rVeQPNnE7gK/y1iJzeSa8MaxKHpjq5GAxY0/mj2tnVrZKtxPqFLHu+zturC3ILWPMRI8gNOZkkzB10q4jwjW9ZcPx8HnYSZindO3KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715755461; c=relaxed/simple;
	bh=Fajia5z7P12kLeYYIqCKzSxxUzjVfBhm34t9XrY0/yk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZuQgsSQeIKT+gSTiflcHv5jA1/CMhhf+vAxZv6DxL/RwqgqxKfbjGgyq/VHX7AdM2WKhA010OEJiGrH/HkXr5PrVPV0b4JrnYORBAdyBlIYM1Eq0AHYnKgDgGpupFyqh7kH7SVeq6bcwdO+jRRkq4uWkqOXFcnEaQARsFT0793s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Kztt4isx; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5ce2aada130so4599037a12.1
        for <linux-integrity@vger.kernel.org>; Tue, 14 May 2024 23:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1715755459; x=1716360259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHt6iIdLhW0U7BUX4DS9zeBTZluih3jaSJ3akZl6570=;
        b=Kztt4isx1Mubyl8Fpbrxwcx7WVR/jnojP6TJ/5wHuCSUbd3W7go/1zLZOGFd7EYr9B
         2JRFvVaeSeLQgeDmG7DQyoVaGjJ5idyNDN/T6gM4R5QII+2aOfhgucxc5udCRHCFDnlm
         8HhhrDV2Jel12WEzipoWc1i9V/Cxd04w1SjiDtZezIW34m2ccc3ubDhYaf+5rs4tCpzC
         NPzztGmKeDVXxO1oSGH3VHw6OOR39bwCNEL/xN1cjxn7tTp8aRIBLjuBln8QmhZed7Gt
         hIP1mGuDVx+q0kUb0BGcRBsBSn9hDLcQDmbTtvYsnJz7bH+teVKQAWJLm1VzM8nZaDo1
         pJBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715755459; x=1716360259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cHt6iIdLhW0U7BUX4DS9zeBTZluih3jaSJ3akZl6570=;
        b=pVyUjHvc19kQypXP8PNT5bwyfqoLIR/AhU8S6H3GfujKQWLawTf5npKxJnoUtJNWsG
         l/0cx2PqP7EKqvwkpiN85M/q5xFVf1vEry3ngh3Qs3RrXADGNLNHJs/Xu9i/Z5EHWiBc
         yn9JPTXwEYTXjNU+ErrSFEqixQX51ekOdPG18AzpmEPRr4dNMayUsyZzUJJyNVyBb8E4
         HZVI+jOF5N8keqqGIKBdKPMB9/6uxYeFQZI1xrI0R9sjNt0T+G4d6m6a+V1Bdm4brSSt
         tqSxpGRZlk/T8t2Ni6COrFIqP9oVK3deQX6qY0MbVlgDGQNAteRKHmM+KCiBzH7fRIP5
         HYpw==
X-Forwarded-Encrypted: i=1; AJvYcCXNJQ7jJtGdwKYoWa7xDKRpE6n06CxcCRPtT7U8xCUPDKP5WY8addRarn8Jll1PBNbACNTMHSMZl7rgBSAxbif8vQZaLTkuVmF6jp3fJ0Te
X-Gm-Message-State: AOJu0YzGuNIXHPSZMqGouPTkemTyWBqsqFaqpGOgj8+1Tml6R8pzO6yv
	oZBxazPE+8JHUBxmJNBRuatvGkGTjBy30MfUYVWID0obn2ncPC+y13G5j0J9/hJ0FgRno85/JBD
	BKD0tcr6zbf6FS4WHKhl1Sjsj/xJPAvvcBfjcwcTFA7WtPZtg+B4=
X-Google-Smtp-Source: AGHT+IFEtAJZ2VfYRn/ENkTjxi26mgbfcvdMy4KCuQ8gQasIEb6jSLE6aTIv+LC20CsuGZBINyFevEeFRMr7E7pWuzI=
X-Received: by 2002:a17:90b:3715:b0:2b3:9ce8:1239 with SMTP id
 98e67ed59e1d1-2b6cc1438dbmr12551957a91.6.1715755458902; Tue, 14 May 2024
 23:44:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503221634.44274-1-ignat@cloudflare.com> <20240503221634.44274-3-ignat@cloudflare.com>
 <D19QW70177QG.2YC9XL0FT7VME@kernel.org> <D19RM0OV7YUW.1ZEI72XQUREMQ@kernel.org>
In-Reply-To: <D19RM0OV7YUW.1ZEI72XQUREMQ@kernel.org>
From: Ignat Korchagin <ignat@cloudflare.com>
Date: Wed, 15 May 2024 07:44:07 +0100
Message-ID: <CALrw=nEnqBCBQKhK9ACc7tbicqkXaDD+Bjc1d90xizMvbb--oA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] KEYS: implement derived keys
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, serge@hallyn.com, linux-integrity@vger.kernel.org, 
	keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 12:44=E2=80=AFAM Jarkko Sakkinen <jarkko@kernel.org=
> wrote:
>
> On Wed May 15, 2024 at 2:10 AM EEST, Jarkko Sakkinen wrote:
> > On Sat May 4, 2024 at 1:16 AM EEST, Ignat Korchagin wrote:
> > > Derived keys are similar to user keys, but their payload is derived f=
rom the
> > > primary TPM seed and some metadata of the requesting process. This wa=
y every
> >
> > What is exactly "some metadata"?
> >
> > > application can get a unique secret/key, which is cryptographically b=
ound to
> >
> > What is "cryptographically bound". Please go straight to the point and
> > cut out *all* white paper'ish phrases. We do not need it and will make
> > painful to backtrack this commit once in the mainline.
> >
> > > the TPM without the need to provide the key material externally (unli=
ke trusted
> > > keys). Also, the whole key derivation process is deterministic, so as=
 long as
> >
> > Why trusted keys is inside braces. It is not important for the point
> > you are trying to make here?
> >
> > > the TPM is available, applications can always recover their keys, whi=
ch may
> > > allow for easier key management on stateless systems.
> >
> > Please drop "stateless system" unless you provide a rigid definition
> > what it is. I have no idea what you mean by it. Probably not that
> > important, right?
> >
> > >
> > > In this implementation the following factors will be used as a key de=
rivation
> > > factor:
> > >   * requested key length
> > >   * requesting process effective user id
> > >   * either the application executable path or the application integri=
ty
> > >     metadata (if available)
> >
> > NAK for path for any possible key derivation. They are racy and
> > and ambiguous.
> >
> > This should have been in the beginning instead of "some data". What
> > other implementations exist. For me "this implementation" implies
> > that this one competing alternative to multiple implementations
> > of the same thing.
> >
> > I do not like this science/white paper style at all. Just express
> > short, open code everything right at start when you need and cut
> > extras like "stateless system" unless you can provide exact, sound
> > and unambiguous definiton of it.
> >
> > Just want to underline how this really needs a complete rewrite with
> > clear and concise explanation :-) This won't ever work.
> >
> > >
> > > Key length is used so requests for keys with different sizes result i=
n keys
> > > with different cryptographic material.
> >
> > What is "key length"? Please refer the exact attribute.
> >
> > >
> > > User id is mixed, so different users get different keys even when exe=
cuting the
> >
> > First of all it would be more clear to just s/User id/UID/
> >
> > And make obvious whether we are talking about ruid or euid and how
> > this interacts with GIDs.
> >
> > I'll look at the code change next round if the commit message starts
> > making any sense.
>
> Right and neither UIDs and GIDs are applicable for key derivation for
> quite obvious reasons. So NAK for that too.

Can you, please, clarify a bit here? Not very obvious for me. I added
euid for two reasons:
  * an unprivileged user might run a normally privileged application,
for example /usr/sbin/sshd, and depending on the code could "leak" the
key
  * without it and with unprivileged user namespaces it is possible to
create an unprivileged container with code at the same path as a
privileged application

Why do you think UIDs/GIDs are not applicable as mixins?

Ignat

> You can make them point out unlimited different identities...
>
> BR, Jarkko

