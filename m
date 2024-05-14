Return-Path: <linux-integrity+bounces-2392-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE05F8C582A
	for <lists+linux-integrity@lfdr.de>; Tue, 14 May 2024 16:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A85F62845D3
	for <lists+linux-integrity@lfdr.de>; Tue, 14 May 2024 14:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D04617BB2F;
	Tue, 14 May 2024 14:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ahPzsI+y"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF2D158213
	for <linux-integrity@vger.kernel.org>; Tue, 14 May 2024 14:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715697724; cv=none; b=bEe69ZKPSEcZZnvDLGfcDdCr0ltdfqBT9Ji8IaGzL2EPfBRjnqoa8Ap2G31L6RlEAJCo66rtDeuepaxeoFCPacnG1VQBa2M1dOGNduyL9hIRe1vocdsfGSxCcIBEolwWApsXqx+8CAmUCEIsLIaMGe4wuQLgSMvP46PRPhpCt1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715697724; c=relaxed/simple;
	bh=cL6om3Frdqvkmjt2cViIjCpSlw/JksZfeTaan2+L4Ek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gD80WbM62kXcLhrd7mskCKdkskD4SNiAk833E3ZwXts9ceqhL8YNyI8g0vC0Rxg03BCVRHkttmz+qxP5EidqHJU0v/VWwSVX/cgRT0Jqur37kLLMonUhkAk72tSqxTY/u5Kga+lvBChI4I1UQgPPtvO0ftitcTXFMfldArrLGZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ahPzsI+y; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6f0fd87da53so1782216a34.2
        for <linux-integrity@vger.kernel.org>; Tue, 14 May 2024 07:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1715697722; x=1716302522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TV3+UMiVWq7CksEqEGh2EzKR9H0sUTyC5OVKuFe6yD8=;
        b=ahPzsI+y8yRGSReKmAnejjLYwAxwXKmfjciMP9//NnfbIRj6aJQAE77bQO3QoDvBb9
         7Iiw4zK/nj4VYeCSWjgz0o53tBSu90gbEEtg7ftKCw5LVs/JkK96QPSehY9so7IsOuZi
         7W8U7KWG/1abFd+zrjPiiLEY5MbZoAlKw4i1GIrYW6oqXOn/uNhQZi8tW3g7kffJlmrE
         z50dfy/FbmklCmQoxdvGcb8P4hYvokLsNIs7XZm+m8ZuHMUglE70qUFil+iosDh6VJr7
         lIhAlLeBJaGSBtnfgXRM/owehx1O8cvesxlW3L4JjeymNCjAWBrh1lnNQGhn91AzQ8RD
         79DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715697722; x=1716302522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TV3+UMiVWq7CksEqEGh2EzKR9H0sUTyC5OVKuFe6yD8=;
        b=gzocoEYFxrL1aL9BQYfP4IjG7h5AadamKQ+DJQJc0HukkLcq65IDxYzN9NYzY8a6U6
         rBRtilmwbVs4TLo/fi/IE9MsRQky4PmkuXWkemDi5QSvWVvTxKV/eOne8JiHPQLrlsjp
         W4p9pn6XeCixGcMFLFdNaFUYeejOMaqSQjV5TYb8HQCrngqAQ4OrG5dmcoW5SBqW5khK
         KoXNVIL6Z44PuDSxHNyxhNCIqWXP/lyoWc/RR6N8U+MHCftTMudBNSODoWCRSuU8xaok
         KYhgFJ+OE4Af5qivDFQyqnK1COOTTesPfMNX0yCpvIfVafFAvsZXu+Q3TCQncTocbxP/
         Zazw==
X-Forwarded-Encrypted: i=1; AJvYcCU0nSIsD2WO/xtJDTUuA7kjDtNJL8A4HEkr/RgdlgURyAz4QkQhI6dd4aLybayLsclbPWQeiLZBkrcdsH9HKDTZepH89wOkoe+LQsPOX3Ll
X-Gm-Message-State: AOJu0YxPFnaKK+S9HnHK4+bIaNRJ57WrukPnVeBeKm1XrxQDJJPh3RQz
	gyRKjqNi6iBtFjXbQUc6+3aTRSqXyYEaqWkA2PvnjPviwwX604kzcO9TXFx/rcQD3dffWNMnra+
	6djZI7HHxnU6xVJA5Kko2ZzK6n+66x2ucmv42ig==
X-Google-Smtp-Source: AGHT+IGujis+OmK7qSGQIW3T6NzRMyAUeKIZKKlP8Yp3YXrxyht4lP+EfPBkY6NMjND/8JoX8seUVvgaMvO1hBkRSr4=
X-Received: by 2002:a05:6830:18e7:b0:6f0:4847:a984 with SMTP id
 46e09a7af769-6f0e9145ed3mr14588590a34.21.1715697721967; Tue, 14 May 2024
 07:42:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503221634.44274-1-ignat@cloudflare.com> <CALrw=nGhgRrhJ5mWWC6sV2WYWoijvD9WgFzMfOe6mHmqnza-Hw@mail.gmail.com>
 <D18XXJ373C2V.2M6AOMKD1B89W@kernel.org> <CALrw=nHGLN=dn3fbyAcXsBufw0tAWUT1PKVHDK5RZkHcdd3CUw@mail.gmail.com>
 <D19CUF0H9Q3S.3L5Y5S9553S5@kernel.org> <CALrw=nEZ07U9VhbGsnpchOYw1icUZCnuoHHXkJLzhFqSPe9_fQ@mail.gmail.com>
 <D19F74M6B8UC.2VEOOZHGOS87V@kernel.org>
In-Reply-To: <D19F74M6B8UC.2VEOOZHGOS87V@kernel.org>
From: Ignat Korchagin <ignat@cloudflare.com>
Date: Tue, 14 May 2024 15:41:50 +0100
Message-ID: <CALrw=nE_sV=1DnCx1eM8Sgno-di0yCaWHX467ZEf1Fddwg7_rA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] TPM derived keys
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, serge@hallyn.com, linux-integrity@vger.kernel.org, 
	keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 3:00=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> On Tue May 14, 2024 at 4:11 PM EEST, Ignat Korchagin wrote:
> > For example, a cheap NAS box with no internal storage (disks connected
> > externally via USB). We want:
> >   * disks to be encrypted and decryptable only by this NAS box
>
> So how this differs from LUKS2 style, which also systemd supports where
> the encryption key is anchored to PCR's? If I took hard drive out of my
> Linux box, I could not decrypt it in another machine because of this.

It differs with the fact that the disk has a clearly identifiable
LUKS2 header, which tells an adversary that this is a disk with some
data that is encrypted. With derived keys and plain dm-crypt mode
there is no LUKS header, so it is not possible to tell if it is an
encrypted disk or a disk with just random data. Additionally, if I
accidentally wipe the sector with the LUKS2 header - all my data is
lost (because the data encryption key from the header is lost). With
derived keys I can always decrypt at least some data, if the disk is
available.

> >   * if someone steals one of the disks - we don't want them to see it
> > has encrypted data (no LUKS header)
>
> So what happens when you reconnect?

We recover/derive the encryption key and unlock the disk again.

> > Additionally we may want to SSH into the NAS for configuration and we
> > don't want the SSH server key to change after each boot (regardless if
> > disks are connected or not).
>
> Right, interesting use case. Begin before any technical jargon exactly
> with a great example like this. Then it is easier to start to anchoring
> stuff and not be misleaded.
>
> BR, Jarkko

