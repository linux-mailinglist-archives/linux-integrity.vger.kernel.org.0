Return-Path: <linux-integrity+bounces-2375-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBD58C45C3
	for <lists+linux-integrity@lfdr.de>; Mon, 13 May 2024 19:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 794C71F2144E
	for <lists+linux-integrity@lfdr.de>; Mon, 13 May 2024 17:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2AE1CAAF;
	Mon, 13 May 2024 17:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="IFWjGER5"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D331CF8D
	for <linux-integrity@vger.kernel.org>; Mon, 13 May 2024 17:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715620294; cv=none; b=QGFeSK/oA0Frj3/6jL+g9L8FqG8AAg2I/0kglqpMMx47O4Ya2Sj5xl1q7jLEFPOLVhUVpiEG2SmvS0Ya76R3u6itc5oT2ogpSTMNN6sgVzyIARTSEKxZT1MPvxhwAguKgrSHoQgDdNjiGO/qFEY6AKn5tsM/6wvBtMKyLSMeSBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715620294; c=relaxed/simple;
	bh=QsU9VcO38mCO6VHiLHRMzidjKsNaDCBvegm7dClhejw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qs617k6S1Y04mcxP0h1iIKCtemONAU4CStMZYHbgj/I5qqrHMHNEdV5qvdKXWXY8Y+PfWTYbKj4om749PUUx8swBj0cna4dwYM4EDTj1bjjzPqzmHkzo0nM8c8qWQ3clLCbgh0BI7CxDpFmqMHPhJWvzEIeQAQRAx2euQCIm2SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=IFWjGER5; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2b27c532e50so3248023a91.2
        for <linux-integrity@vger.kernel.org>; Mon, 13 May 2024 10:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1715620293; x=1716225093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2nC+uuvv/kRsKZflGqdXg7bseQO84xpSJ4IIawyz0U=;
        b=IFWjGER5jHfitMBcU1X+1It5hiaRxvqwPncN+RzvvWT9YfPvUX1yYtlnCky69UhiO5
         0xhYsIQPgF99WkhRIgZycGXgJlb7a4oBD474zo+DuEAor00fjNyS1tvjRd/WfIaC07qJ
         MOw+m6PkTQCDR7Yc/jpPh8yybgmj7Fovh7eyL2l30fbnn8GQ+xRgQB/YAgfaGb4TQXAU
         BctEWZ0G+sRUndZxefYeWdme+8pk8kXa6/+2l/kFyy93dUKjFuM3c/xMTSTvIhaj2tGO
         X+iVjBHSGsHUweqFiqB45xzkYEpxT2fH0JTXJU78Afe0GDpDWpqBvDu6VsSXtQjwQ0NW
         5EEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715620293; x=1716225093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a2nC+uuvv/kRsKZflGqdXg7bseQO84xpSJ4IIawyz0U=;
        b=mnxqjGlHwdFJO165yR7DvS05VxPj3apoem+2sMVgxy/hK0gstF2Ljpe6R6+O42bfgr
         jZdPR36xbwXo2BWzQ1/XNHX5eKJdpfRm3h0rREfWa1rqaTgWUkSDYEjfqVKpbsIIAdYh
         cf2gV969PAyoMGKd+mfJGuOwYnxV6zBd0UnqB9aIHQNYsQREZoB0dN5EPDpk4EX54tGx
         HCCOVVV19S1554KpTn8A1Ss5deYjxLrNkV50j0keuRfohFmb0dhxJyQl58xS8cUHty/r
         CqtYPIu2W858jmPShIrBvxUdB1pZwBBvHm/j7KJQ98lIqtHfm8+DDzEdOxU4TDeX/r9M
         9stQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtoBYEYRA3Idn9Rl1LEE7XbgMzPYGzSjyr7/P4apet45zAP0f1egetnCHlBlDILpHsJGr9OAdXmoNphSjYV891+p+KaqTznIv4YR1TIlfM
X-Gm-Message-State: AOJu0YxKOQkojF9f2SgTuU3M3aCf5djnRETji0XXW2GhClkSnLcjrkiy
	Z+zogcRWzaW+3ORnqNQTotf0oIkETQtdl7esJvVw8HlWef1vblEX4AXWXwcQpSgj5lK8/imB0Gw
	6Oca78vFUzq0T2MWeoVEv1TJwcntNaAOtFu/a8JhCjU821Nw0BpW19Q==
X-Google-Smtp-Source: AGHT+IFTVnywRERo05UfjqnKp/fXeBOJVobi68u/z/rIvk5ypHQIt5iRrvoBgYRgGLWTlmX/7+scABzTI91vJy6uznI=
X-Received: by 2002:a17:90b:3848:b0:2b8:5bf0:115e with SMTP id
 98e67ed59e1d1-2b85bf01370mr7491728a91.5.1715620292566; Mon, 13 May 2024
 10:11:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503221634.44274-1-ignat@cloudflare.com>
In-Reply-To: <20240503221634.44274-1-ignat@cloudflare.com>
From: Ignat Korchagin <ignat@cloudflare.com>
Date: Mon, 13 May 2024 18:11:21 +0100
Message-ID: <CALrw=nGhgRrhJ5mWWC6sV2WYWoijvD9WgFzMfOe6mHmqnza-Hw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] TPM derived keys
To: James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, 
	David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, serge@hallyn.com, linux-integrity@vger.kernel.org, 
	keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 11:16=E2=80=AFPM Ignat Korchagin <ignat@cloudflare.c=
om> wrote:
>
> TPM derived keys get their payload from an HMAC primary key in the owner
> hierarchy mixed with some metadata from the requesting process.
>
> They are similar to trusted keys in the sense that the key security is ro=
oted
> in the TPM, but may provide easier key management for some use-cases.
>
> One inconvenience with trusted keys is that the cryptographic material sh=
ould
> be provided externally. This means either wrapping the key to the TPM on =
the

I would like to point out to myself I was wrong: it is possible to ask
the kernel to generate a trusted key inside the kernel locally with
"keyctl add trusted kmk "new 32" @u"

> executing system (which briefly exposes plaintext cryptographic material =
to
> userspace) or creating the wrapped blob externally, but then we need to g=
ather
> and transfer the TPM public key to the remote system, which may be a logi=
stical
> problem sometimes.
>
> Moreover, we need to store the wrapped key blob somewhere, and if we lose=
 it,
> the application cannot recover its data anymore.
>
> TPM derived keys may make key management for applications easier, especia=
lly on
> stateless systems as the application can always recreate its keys and the
> encrypted data is bound to the device and its TPM. They allow the applica=
tion
> to wrap/unwrap some data to the device without worrying too much about ke=
y
> management and provisioning. They are similar in a sense to device unique=
 keys
> present on many mobile devices and some IoT systems, but even better as e=
very
> application has its own unique device key.
>
> It is also easy to quickly "wipe" all the application keys by just resett=
ing
> the TPM owner hierarchy.
>
> It is worth mentioning that this functionality can be implemented in user=
space
> as a /sbin/request-key plugin. However, the advantage of the in-kernel
> implementation is that the derived key material never leaves the kernel s=
pace
> (unless explicitly read into userspace with proper permissions).
>
> Current implementation supports two modes (as demonstrated by the keyctl
> userspace tool):
>   1. keyctl add derived test '32 path' - will derive a 32 byte key based =
on
>      the TPM seed and the filesystem path of the requesting application. =
That
>      is /usr/bin/keyctl and /opt/bin/keyctl would generate different keys=
.
>
>   2. keyctl add derived test '32 csum' - will derive a 32 byte key based =
on the
>      TPM seed and the IMA measurement of the requesting application. That=
 is
>      /usr/bin/keyctl and /opt/bin/keyctl would generate the same key IFF =
their
>      code exactly matches bit for bit. The implementation does not measur=
e the
>      requesting binary itself, but rather relies on already available
>      measurement. This means for this mode to work IMA needs to be enable=
d and
>      configured for requesting applications. For example:
>        # echo 'audit func=3DBPRM_CHECK' > \
>          /sys/kernel/security/integrity/ima/policy
>
> Open questions (apart from the obvious "is this useful?"):
>   * should any other modes/derivation parameters be considered?
>   * apparently in checksum mode, when calling keyring syscalls from scrip=
ts,
>     we mix in the measurement of the interpreter, not the script itself. =
Is
>     there any way to improve this?
>
>
> Ignat Korchagin (2):
>   tpm: add some algorithm and constant definitions from the TPM spec
>   KEYS: implement derived keys
>
>  include/linux/tpm.h                     |  16 +-
>  security/keys/Kconfig                   |  16 ++
>  security/keys/Makefile                  |   1 +
>  security/keys/derived-keys/Makefile     |   8 +
>  security/keys/derived-keys/derived.c    | 226 +++++++++++++++++++++
>  security/keys/derived-keys/derived.h    |   4 +
>  security/keys/derived-keys/tpm2_shash.c | 257 ++++++++++++++++++++++++
>  7 files changed, 524 insertions(+), 4 deletions(-)
>  create mode 100644 security/keys/derived-keys/Makefile
>  create mode 100644 security/keys/derived-keys/derived.c
>  create mode 100644 security/keys/derived-keys/derived.h
>  create mode 100644 security/keys/derived-keys/tpm2_shash.c
>
> --
> 2.39.2
>

