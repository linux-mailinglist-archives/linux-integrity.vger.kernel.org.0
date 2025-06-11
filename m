Return-Path: <linux-integrity+bounces-6413-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A26DCAD5B30
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Jun 2025 17:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4016517A4BE
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Jun 2025 15:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7291E1A3D;
	Wed, 11 Jun 2025 15:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VoQZRUnc"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5771E0E0B
	for <linux-integrity@vger.kernel.org>; Wed, 11 Jun 2025 15:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749657263; cv=none; b=NX+YfDffXcjePZ63PMAADpE6whoLDHgKe1aVRyvfQmnjf5xQtS8Fx+1N4z+EahUZSl4Zg0Z15eGvw/4G2idvj0/31jLW8Z4ADnrqiFcQNbM7jq3vGQKjfe+K2bVsZLzC3tu4u1o/04CRHBOADEfPRtIZIzqVX2B4qGVBSekmonE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749657263; c=relaxed/simple;
	bh=MNJifaaW2DKC7Ep+EbGEsZeWuZtW79t5zkE61iueUzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YovZbJjkwOESNqE8p/hnNBrIPyD0mar2+zOOJqW7OHgDruPXgFe+cKvXQ3fylIVOFKoqRK4fkWzT26SdEnJGogYvLtoRZ8uOClPXttvAb374BtE1CDkEavTBT9rrtzf/PcyagyxrIWognlxsNF/WX6/nVYgrhII+2z40+YzTPnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VoQZRUnc; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-70e1d8c2dc2so64991557b3.3
        for <linux-integrity@vger.kernel.org>; Wed, 11 Jun 2025 08:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1749657261; x=1750262061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dBhZQu6BqagB3PC5bDYHjkHrfQ+2AWYQFfsjZus8X6I=;
        b=VoQZRUncykxaGZ7NsMVcqtrTcp5nmfGaQziEJb32XqsWTZI6DGMxeVHR1blITt+Qqs
         F4ZIMuJCaM4dIVkrt1JLT6ircWVM4EmwCb32sw80IEIvBznEZ+gNvVax6xGMEsXWgvEB
         e5AHBdIrSwkRtkYcnPm514FFcCfdtbf3xCt0N4er71YLh31wmQS3O8FPjGaM5JI2c/nA
         fIwMS2I5G6xhiEDD/vAZtQKVLzpB0v1l7d0cHEWOMvqaMKYd2Wp+f8F8pPZYKTdolany
         NmSD6Pf7L8yUSJhryERsnSG/SXuFJ6HeKKqIgpj1Rt0a2/R9t/igWvnflEDMXU8BvDcW
         BClw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749657261; x=1750262061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dBhZQu6BqagB3PC5bDYHjkHrfQ+2AWYQFfsjZus8X6I=;
        b=JKvCMg64oADazigHXjshZJ4BIVsAq4zLtayzQHJQWBBB9b8YTv5ncOnv++JvIGzrIy
         hpSo1OEZjB85eA+bK5aAcFSSgl4Ai2IxzSZdU59fWkZvfMjaKHL4JB4eh8mMBNltxCKc
         b3wEQCjw7dfHZWInBQpoKeT9NdDIEeIpiYW8C1q4NyUVcO0MFJ0x2LikY6OghrJgYuH/
         eLzQp0/khUTQMcwQ9YZW8o5JAveN740hH3hSljCyyjdztw485Jhd0DzcElSaWHA/ihRw
         YDw9vlHSjVqXVfFVUX1x2Exl+RMCB1I9VCi4VEqCjM2J5OQFZTYxn7i77ep4xh5d/HnP
         Zm1A==
X-Forwarded-Encrypted: i=1; AJvYcCVY55TRg/+uknA7r3CvBmlMvq9JjS7Tvv4AJMZcNpVqk6enhUe0VRp14L6MF61v80Ck8uThySSy/EYVbuVArD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzACMEl1qkP8009P4cK9Uz7KqwWiXuVj27Adpx+S1IZtwjxbRHV
	YXa72n5XAhV52nbIOTa7OfVL7elGoTTnRPAzN/gRA1OmN8XM9TUgz12VoV0CjsPTLBT6uYCORkX
	rHp4nq9GhPWRLR3ZIPvBonLVX29x2PpVo9onS6RqG
X-Gm-Gg: ASbGnctrhuSWucME+zF1e3sDIG5AtxSs1Shx5hFHSpk2AYJmXTyK3SiSurCqJwUnOPp
	sWPS1xVXgH1E798Vb8rOgiajXj934BBYcTr2NCA+O6X5PY103xQCmTrNmc859aOrWdwFnVfpHLZ
	ApkZFZwNyizliXYxvhyiAgExSSvuvaqxBtpUPVo0Hl5jE=
X-Google-Smtp-Source: AGHT+IEn+kC/BZ+RXwGYxRkP+XLD0tGlRkO0idFv9DQonG8a7gWIJr8vGNDUYR6rx6ZmmovcVVyDmS1thVUaW8UvqdA=
X-Received: by 2002:a05:690c:f8c:b0:70e:7663:8bb4 with SMTP id
 00721157ae682-71140adb8bamr52684357b3.25.1749657261129; Wed, 11 Jun 2025
 08:54:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <301015.1748434697@warthog.procyon.org.uk> <CAHC9VhRn=EGu4+0fYup1bGdgkzWvZYpMPXKoARJf2N+4sy9g2w@mail.gmail.com>
 <aElIgixaHGuHEnb8@gondor.apana.org.au>
In-Reply-To: <aElIgixaHGuHEnb8@gondor.apana.org.au>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 11 Jun 2025 11:54:10 -0400
X-Gm-Features: AX0GCFs9HQfkD829H3Li4br3UccO43H5X5WtKEy278IEIzt6bh6uwIsmTEf8mkI
Message-ID: <CAHC9VhT9k9+DWh14HEnv6V1T3=hDJFY-fOcE-nexPFv0jdL04g@mail.gmail.com>
Subject: Re: [PATCH] KEYS: Invert FINAL_PUT bit
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: David Howells <dhowells@redhat.com>, torvalds@linux-foundation.org, 
	Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 5:12=E2=80=AFAM Herbert Xu <herbert@gondor.apana.or=
g.au> wrote:
> On Tue, Jun 10, 2025 at 08:22:59PM -0400, Paul Moore wrote:
> >
> > It doesn't look like this has made its way to Linus.  David or Jarkko,
> > do one of you want to pick this up into a tree and send this to Linus
> > properly?
>
> I can pick it up for the next merge window.

Great, thanks Herbert.

--=20
paul-moore.com

