Return-Path: <linux-integrity+bounces-2394-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C688C5850
	for <lists+linux-integrity@lfdr.de>; Tue, 14 May 2024 16:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 744FA1F23650
	for <lists+linux-integrity@lfdr.de>; Tue, 14 May 2024 14:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BFD17BB37;
	Tue, 14 May 2024 14:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="YRJ6+luM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A81117BB2F
	for <linux-integrity@vger.kernel.org>; Tue, 14 May 2024 14:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715698454; cv=none; b=EKpSTHTm+F7kH2GnLFdxXAPb8dgJLa7jKKwHCiC704vnn0gmA7MNlpoFZ2ezUq+9wWUXPmF4WQpFQH7hvpo+0Vhl2wussNr3H+u+bnRDQL+RYrtBH/Yv6BxLsATECZomppgIf2L6xXOC4usBQLjiMjZpYOvzdpHrWKtBqvdwimg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715698454; c=relaxed/simple;
	bh=MJ+z3nFXsNvqU4RpICcjSdTIlE37ym0IdiJZ2gNDNrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B4BqR/DbutsV3VgWYKak7Sjb3JaTWtpFWsuA04qQGs3GXUmLn86k2Kz/5zWcJuymHnqlff070m6lPMG1ZhEoTQLz57zeq86WHaR7bwyOyoxY05BR692AU1PngURfrgBZIb0onAsr9am9qBNo5VLtH9REYA8UsqYxEhfos3htysE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=YRJ6+luM; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6f0e379096fso2183275a34.1
        for <linux-integrity@vger.kernel.org>; Tue, 14 May 2024 07:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1715698452; x=1716303252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wpwk5gqnxfMpdpFSeAltyRUGvYXRaQMydwK8u+++1cM=;
        b=YRJ6+luMPQe4TxEilwXUUqerihrapxMPF0jtum2jm9aGFq05XB0zGEvqtrxV38Z8xy
         6zREwpSNh+cnixUCPiBdLBFWtBvraKHsDkcDHf5gqB6F6jPmjHsU1kPYsh2u+YQvDjb6
         ZzLkonFwzICJk/51fioQ+9Rw7PcNXoC1OQcfy5J2psK3T1ZdOqvjqa2oV0mLDSbRVMJY
         v350K7jwIKB6HRtPZ4N0Su7SqVsfKSYskqUNcrKLhbz9731E9GzfMcoERM6EG6sRoI0Y
         z4BEBMIgIXRHUTGrXxWqzuOBb42w4fUfA2F4rW3KD73Ns57U4aRnOUQAsJAt9AGLmiKS
         kErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715698452; x=1716303252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wpwk5gqnxfMpdpFSeAltyRUGvYXRaQMydwK8u+++1cM=;
        b=Cs8+PGGGluBvRXZTv5Ir6M4LuFVc8CuUCZRYlT+JrekQbCnVZkA7R2FTEX1IdK6RGf
         +WFHreQVpVauRxPmVik1bMUNZFwfDx5hGvXBwa7wiI8oVUfbGggWviSltr4j4E3QhzD5
         T1kCa73rKllBP6mqoaBhYh6BSiCDYiqxrCJvZtMmRb9TO/moNetx1CHPGROHVwcv7R6t
         oOQk514oWdRFApSFKe/vPjII04rk4Z4GFEAbiXI8rPKwqFdfWenB+Ph5r6nv/B8/e3Jj
         rYcJ+EsW9bpsB2QQnB248DbWbQ152H6pEKleE/MtngauRNsMWuviPL53p2XrVcK6i5M0
         n7oQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLgiR6znMW0rQla6YLAZnIpcMcAyEXc30zfQMuyU2wfVf42BHUIuBt9ntR/z798Eov4I1lkGGIVa03rvSzb47E3SbyPLo/kIGefzdEER5X
X-Gm-Message-State: AOJu0YwyOn6bVBhvmb4BilUGW84JNqmu9cVvblbPyLExRDFtAKUWvyZJ
	3+mAZBnxKi92uFuChQWwZD4Zy2IYLJB1KM/bXf3o27WbKH0RrL0aagjCUHpKEPvzg1QPsdxshaA
	y/om8EAAKxyua24BXPv7dZt04qRSTnkVwYMtWLQ==
X-Google-Smtp-Source: AGHT+IGQnTMYr06AevH4jz+0Hl80twZxNa0hBXvLSl9Vls1Uucyej7vIQSvyuP6fpP8+OmTmyPVjz5InylwD098Z7Ak=
X-Received: by 2002:a05:6830:1e72:b0:6f1:1946:9c6d with SMTP id
 46e09a7af769-6f11946a5fbmr772361a34.13.1715698452263; Tue, 14 May 2024
 07:54:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503221634.44274-1-ignat@cloudflare.com> <D10FIGJ84Q71.2VT5MH1VUDP0R@kernel.org>
 <ZjY-UU8pROnwlTuH@farprobe> <D10Y0V64JXG8.1F6S3OZDACCGF@kernel.org>
 <D10YYQKT9P1S.25CE053K7MQKI@kernel.org> <CALrw=nFLa5=bPbYKijNsEo0Kk77_TEpdPmPe3CJ3VJqGNMmBeg@mail.gmail.com>
 <44cd50b60a0a4e376d01544d25187556b8badf94.camel@HansenPartnership.com>
 <CALrw=nFOh0=TXGx-z_oTkLWshVU_AfGRQzcC3zxVTzcRbuRqQQ@mail.gmail.com> <b53f9fa263e65cd6b23677d9f7a385e5eb85cfdd.camel@HansenPartnership.com>
In-Reply-To: <b53f9fa263e65cd6b23677d9f7a385e5eb85cfdd.camel@HansenPartnership.com>
From: Ignat Korchagin <ignat@cloudflare.com>
Date: Tue, 14 May 2024 15:54:00 +0100
Message-ID: <CALrw=nGg7c39Hsb7nX5hCM23_qqeWFMTRJWmvyu+rKgyC75LPg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] TPM derived keys
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, Ben Boeckel <me@benboeckel.net>, 
	Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, serge@hallyn.com, 
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 3:11=E2=80=AFPM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Tue, 2024-05-14 at 10:50 +0100, Ignat Korchagin wrote:
> > On Mon, May 13, 2024 at 11:33=E2=80=AFPM James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote:
> > >
> > > On Mon, 2024-05-13 at 18:09 +0100, Ignat Korchagin wrote:
> > > [...]
> > > > TPM derived keys attempt to address the above use cases by
> > > > allowing applications to deterministically derive unique
> > > > cryptographic keys for their own purposes directly from the TPM
> > > > seed in the owner hierarchy. The idea is that when an application
> > > > requests a new key, instead of generating a random key and
> > > > wrapping it with the TPM, the implementation generates a key via
> > > > KDF(hierarchy seed, application specific info). Therefore, the
> > > > resulting keys will always be cryptographically bound to the
> > > > application itself and the device they were generated on.
> > >
> > > So I think what confuses me is what the expected cryptographic
> > > secrecy properties of the derived keys are.  I get they're a KDF of
> > > seed and deterministic properties, but if those mixing values are
> > > well known (as the path or binary checksum cases) then anyone with
> > > access to the TPM can derive the key from user space because they
> > > can easily obtain the mixing parameters and there's no protection
> > > to the TPM keyed hash operation.
> > >
> > > Consider the use case where two users are using derived keys on the
> > > same system (so same TPM).  Assuming they use them to protect
> > > sensitive information, what prevents user1 from simply deriving
> > > user2's key and getting the information, or am I missing the point
> > > of this?
> >
> > You are correct: it is possible, but in practice it would be limited
> > only to privileged users/applications. I remember there was a push to
> > set a 666 mask for the TPM device file, but it is not how it is done
> > today by default.
>
> No, it's 660, but in consequence of that every user of the TPM is a
> member of the tpm group which, since TPM use from userspace is growing,
> is everyone, so it might as well have been 666.  In other words relying
> on access restrictions to the TPM itself is largely useless.
>
> >  Also I think the same applies to trusted keys as well, at least
> > without any additional authorizations or PCR restrictions on the blob
> > (I remember I could manually unwrap a trusted key blob in userspace
> > as root).
>
> Well, that's correct, but a TPM key file without policy still has two
> protections: the file itself (so the key owner can choose what
> permissions and where it is) and the key authority (or password)
> although for the mechanical (unsupervised insertion) use case keys tend
> not to have an authority.
>
> > It would be fixed if we could limit access to some TPM ops only from
> > the kernel, but I remember from one of your presentations that it is
> > generally a hard problem and that some solution was in the works (was
> > it based on limiting access to a resettable PCR?). I'm happy to
> > consider adopting it here as well somehow.
>
> Well, that was based on constructing a policy that meant only the
> kernel could access the data (so it requires PCR policy).
>
> In addition to the expected secrecy property question which I don't
> think is fully answered I did think of another issue: what if the
> application needs to rotate keys because of a suspected compromise?
> For sealed keys, we just generate a new one an use that in place of the
> old, but for your derived keys we'd have to change one of the mixing
> values, which all look to be based on fairly permanent properties of
> the system.

For our current (non-TPM based) derived key hierarchy we do allow
applications to specify a "freeform" mixing value, which in practice
may contain a key version, like "v1"/"v2" etc. This also allows
applications to derive multiple different keys for different purposes.
Perhaps, we can do the same here, for example keyctl add derived test
"<key len> (path|csum) <the rest is used as is as another mixin>". We
can also "just ship" a new version of the code (for the csum case),
which would rotate the key. Another option could be using some
optional xattr as a mixin, which can specify the version of the key or
just be a freeform input.

> James
>

