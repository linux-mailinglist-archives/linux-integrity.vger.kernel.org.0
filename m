Return-Path: <linux-integrity+bounces-1806-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AABB08807FF
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Mar 2024 00:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62B752840EF
	for <lists+linux-integrity@lfdr.de>; Tue, 19 Mar 2024 23:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745315FBAA;
	Tue, 19 Mar 2024 23:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="b+qbfDO7"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EED5FB8B
	for <linux-integrity@vger.kernel.org>; Tue, 19 Mar 2024 23:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710889257; cv=none; b=qUuxXEedXJy0aMQ7HpkOkfw23JqSW8fIUlTGo1O81yn17wgZT2EMkI5HD/U4/D65cA0deCe15HQekELnoERuLmfHX+y9tVK1OqxS+LWRa59yZmIbZpgW9JAXhpsWOFyKMHRSeqcfJjPbR9XQE65g5Z+0W/DGChdtdKsc2EhHsRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710889257; c=relaxed/simple;
	bh=SI71iR5Y7Um8R7vAzXhLobI13BqpnZIrQxroXe8te6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gPUWOLZBgw9ucOOHFGbne67zKYnLspgQN4x36qaVc26IslwVpQo4QBfbaCwNmsLToBNo1UD1i6j8AW0t2NT6juZ4wvqsgOOtaQiMmI2MQpuRtvJFxoIgXIzKlqarHpwbXEZ4eFrZ57Z5oQIMAmRUXU05vvVKAxDBlM9dO8VtgUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=b+qbfDO7; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dc742543119so5692197276.0
        for <linux-integrity@vger.kernel.org>; Tue, 19 Mar 2024 16:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1710889254; x=1711494054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PhNnIPgHxerhIOr4RTfHPmKF6x9l0/Ckh/RvMFabA+Y=;
        b=b+qbfDO7wmcG8jPLrK6zidKtZ6Fo29Rscdsdd3YbzTtIeUXDZOo+yyn7PVBsOjad+Z
         5/9iOmrr9C7sPCy+W4tQBgX8KOZyxyQ9S9ZsH6HelkObSIxJA9T3K1aw/SsRRvbpHnNu
         XRY6oI2u8zOQHfzaRwO6XXKzVmZfRFguA1xcsvLxTxHRJwef3e8wVTwJhjyts00x+FSZ
         zqFvQbeq2rYMq6cfP04ZCxaOcUwTVbyTXP3O3gKxtb23tf5mcZHIeUAI0JbC4YCTblTv
         HhfBcKaA3IV4OQO74ICVeAf4IaSmLHpRC/amkw7YIRMJMOnW6VVQ7SAkicE3cP5qMjiE
         bCUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710889254; x=1711494054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PhNnIPgHxerhIOr4RTfHPmKF6x9l0/Ckh/RvMFabA+Y=;
        b=uwQFDgcJRoHttKj8AtVIT7pNggvTm3Se7ViVFCftr2yiG/YG6L3Qb1UEClyQfT/WSo
         cRCBc8dI6LQbqnRh73KXb9bUqevB5X/f+A363I2x3IPhcDnjOyImn3jOyBhvJs7bD5XQ
         6ng2YBS7RtqRauq/LMs6qFGcIJDC+4k3PPKdZNBWPSbHEQ9WNsDfJkyFzDgRlXzySvIg
         ALelJNtOvUPRwIoaQNDzssvqGnK+O0wgfFujg/ue2Z8EACkwLQbvzD3S3/DFYPYxsueh
         7egBUqTmkf3k9o6JFF0R0MHAvjvcFloDEEuO4FezccOqjd6iVwVW1RQEOMwWZsoCex62
         zpUQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8KFEAGzIGnZWnUENZ/soxACe9raIwwNyMY1xF+Xe8WAffKtcGEwpvr9Pu3kPYhiyHHXW3xjlwTEvCUXrmdaIXs42t3qPrHnXS+iPH6vP3
X-Gm-Message-State: AOJu0Yx2TAI8M3OkgvpWAeXczVYZZ/PupLPQzSjVXX3Zj2AEALXygG+7
	7H3OBGKgQWTbo7LpAw7ZLK1+IlC+yggIYpQbojOFf6kqsLLtpUoNtyBG7PH0nOU80CQxagKT+R4
	/SY0eLZaUt9snbzhKfn6mmz+pQjVny/lVf0qu
X-Google-Smtp-Source: AGHT+IHMUIIIwsUIMpmgPc4Sro0qw/3fx6zM2LSAJ369atAEbEsfSVNxqySeZsH++rtDdEJkgBUDk7WxQwVaCN1faZ4=
X-Received: by 2002:a25:f40c:0:b0:dc7:2401:df4e with SMTP id
 q12-20020a25f40c000000b00dc72401df4emr12122020ybd.39.1710889254575; Tue, 19
 Mar 2024 16:00:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1710560151-28904-1-git-send-email-wufan@linux.microsoft.com>
 <1710560151-28904-18-git-send-email-wufan@linux.microsoft.com> <20240318052937.GC63337@sol.localdomain>
In-Reply-To: <20240318052937.GC63337@sol.localdomain>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 19 Mar 2024 19:00:43 -0400
Message-ID: <CAHC9VhTZ+xAiApjXqz9V_HHwQ0RdW7mWLGjm9zK=ZuhPqb1tgg@mail.gmail.com>
Subject: Re: [RFC PATCH v15 17/21] fsverity: consume builtin signature via LSM hook
To: Eric Biggers <ebiggers@kernel.org>
Cc: Fan Wu <wufan@linux.microsoft.com>, corbet@lwn.net, zohar@linux.ibm.com, 
	jmorris@namei.org, serge@hallyn.com, tytso@mit.edu, axboe@kernel.dk, 
	agk@redhat.com, snitzer@kernel.org, eparis@redhat.com, 
	linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, fsverity@lists.linux.dev, 
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Deven Bowers <deven.desai@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 1:29=E2=80=AFAM Eric Biggers <ebiggers@kernel.org> =
wrote:
> On Fri, Mar 15, 2024 at 08:35:47PM -0700, Fan Wu wrote:
> > fsverity represents a mechanism to support both integrity and
> > authenticity protection of a file, supporting both signed and unsigned
> > digests.

...

> > diff --git a/fs/verity/signature.c b/fs/verity/signature.c
> > index 90c07573dd77..d4ed03a114e9 100644
> > --- a/fs/verity/signature.c
> > +++ b/fs/verity/signature.c
> > @@ -41,7 +41,10 @@ static struct key *fsverity_keyring;
> >   * @sig_size: size of signature in bytes, or 0 if no signature
> >   *
> >   * If the file includes a signature of its fs-verity file digest, veri=
fy it
> > - * against the certificates in the fs-verity keyring.
> > + * against the certificates in the fs-verity keyring. Note that verifi=
cation
> > + * happens as long as the file's signature exists regardless of the st=
ate of
> > + * fsverity_require_signatures, and the IPE LSM relies on this behavio=
r
> > + * to save the verified file signature of the file into security blobs=
.
>
> "save the verified file signature of the file into security blobs" isn't =
what
> IPE actually does, though.  And even if it was, it would not explain why =
IPE
> expects the signature to be verified.

We probably need to abstract away the IPE specific comments here as
these are general LSM hooks and could be used by additional LSMs in
the future.  How about something like the following?

"Note that signatures are verified regardless of the state of the
'fsverity_require_signatures' variable and the LSM subsystem relies
on this behavior to help enforce file integrity policies.  Please
discuss changes with the LSM list (thank you!)."

> > diff --git a/include/linux/security.h b/include/linux/security.h
> > index 0885866b261e..edd12c0a673a 100644
> > --- a/include/linux/security.h
> > +++ b/include/linux/security.h
> > @@ -86,6 +86,7 @@ enum lsm_event {
> >  enum lsm_intgr_type {
> >       LSM_INTGR_DMV_SIG,
> >       LSM_INTGR_DMV_ROOTHASH,
> > +     LSM_INTGR_FSV_SIG,
> >       __LSM_INTGR_MAX
> >  };
>
> These are hard to understand because they are abbreviated too much.  And =
again,
> there are multiple type of fsverity signatures.  How about:
>
> enum lsm_integrity_type {
>         LSM_INTEGRITY_DM_VERITY_SIG,
>         LSM_INTEGRITY_DM_VERITY_ROOT_HASH,
>         LSM_INTEGRITY_FS_VERITY_BUILTIN_SIG,
>         __LSM_INTEGRITY_MAX
> };

Ugh.  I'm willing to concede that the existing enums are probably a
bit too terse, but the suggestions above are a bit too long for my
tastes (and my typin' fingers).  How about a compromise like that
below?

  enum lsm_integrity_type {
    LSM_INT_DMVERITY_SIG,
    LSM_INT_DMVERITY_ROOTHASH,
    LSM_INT_FSVERITY_BUILTINSIG,
  };

--=20
paul-moore.com

