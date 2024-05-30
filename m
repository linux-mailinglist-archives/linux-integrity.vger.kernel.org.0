Return-Path: <linux-integrity+bounces-2706-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A48898D4326
	for <lists+linux-integrity@lfdr.de>; Thu, 30 May 2024 03:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A5EAB22D06
	for <lists+linux-integrity@lfdr.de>; Thu, 30 May 2024 01:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567831BDC3;
	Thu, 30 May 2024 01:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RwtgAkTz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837F8179BD
	for <linux-integrity@vger.kernel.org>; Thu, 30 May 2024 01:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717033632; cv=none; b=TEwFPIfv84/Xvh2iMu07LeneRV3td+cCbla0DLtt19QmLeLf4mS+d7bEXwYEq0T84IwP7dHaI+OQU9GDxWlNcx2I5YLlWXEu/aoHKNJOLOn7ZprM6uALB3c3NdWCQdbp8D/i2EnzsCRxwSeRBAxhQRuSrAI+MP3b73zh3WjCCnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717033632; c=relaxed/simple;
	bh=x1jS0mxgpy/2saLRwCgP0IDOSIhPVz9T5ZHuv9e2c30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mlLLJc4n8WQH129fqbiwOCMa5fEd+zH/XEHAKYHYJxscGy17m9UMu0/aJq8Ua229iVq1P/AcygkD55Q2yhD2brjn7ZZ0W1mhW5ixWbRi33EBAk14cxoMbUnxrLCflDhL9ofusCJq4I4M1vKu5VHnizBrMdQIqdtDnQW1Zbxhs5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RwtgAkTz; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-627e3368394so3280597b3.2
        for <linux-integrity@vger.kernel.org>; Wed, 29 May 2024 18:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1717033629; x=1717638429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GtKBdXnoQfLOHhfUlX9Bxsk6L3lUvasMxrh9oed50QE=;
        b=RwtgAkTzeIe14CmGCyMksSR4l21XcWqOQkKoopcgKO/XLkZUIn4G/0i0q0lKZrcy4x
         xn68e3VSEarmh1mvNflXaLAyT29Gv70J4qQTPiTT05QTrRcMDjhNFl1k0s3cr14tBGG6
         yL71M4rAGeGLtcneYI7oXdXS7scDG95KWbSh3npaBfIrxNpZ9xwjoq1VUJFmfXrn8CRj
         KMEtKZPZrCDtknaqS5rNesrw9qnisExtDi3jgfHhEY7IUV9y1lfeVXDRq8GEYtPqrmkL
         FpMsJap7fFxb8yCjg7PMJWPjGZpfF+3y/IHrgo+lih0Ycse8GFpBMubGKutnNwI4dxvG
         KhSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717033629; x=1717638429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GtKBdXnoQfLOHhfUlX9Bxsk6L3lUvasMxrh9oed50QE=;
        b=xEIeJCSVbDZynPCvrfZp6MaqawXxgblMflNHfp9NHxFmUC86SAdr1B7aGcWy3X6EA3
         KJM0y83EQkF0KqOs0w0Q8ga6tXOjstG6pk0QauwNeN7m4FEglwLZyLCGR0yysU9fKELD
         ra7Vc+YqGvBBlCNAdWPuzYiPn6a3LcqI6WldkD5H8/MTCZzBcC6C5NvNKrguzGJfllJx
         xkPt5+FiwZsUK+OcXXo/LS+lNqbs/h6Xc6GNrlqJBoxDSYXOjoH7xdhORZv7YYxpodZw
         uGRrfmLci/eEnSdVVyPUG6UbD2L0bI4QXjqQ8eU5IMZ4VOgSuAS1ax/PtA++EDYxg+tu
         fDxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLJSAJkz6H6935nXY9si++kXlymwjKc7Z/dgX4LtaDS3OfGR7iIDtyxQz2GpJHQBQlGsP1dHQhPMVUtkXn/tW2Ls8PwuBstOlf4oEY4nU2
X-Gm-Message-State: AOJu0YyKlZTvLpI/Wmj2i199aMqlJ/mLsyeY+HGn8NMtDVkG4y2YdD2V
	MBIqYOIWM8Kb5BgCycOB/3gJw/o05a3VeYHCBQf5Yh7IYk7Cp6/nSzcMP4uWS+U1UQR5F53VpIr
	+vGafHFQEqkOPgIcTOTl+7UMEk+pgdPGwNg1k
X-Google-Smtp-Source: AGHT+IHE8pHh5vgrRzbkNWJnz/7ABaPo+xQvVDp6nIkAadJxWm7yBQS/PqPj3c4uPz54TzSylU9FuipuoCMPbpIsfP8=
X-Received: by 2002:a05:690c:ecc:b0:627:ecd3:6223 with SMTP id
 00721157ae682-62c6bc79ed6mr10295197b3.35.1717033629104; Wed, 29 May 2024
 18:47:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1716583609-21790-1-git-send-email-wufan@linux.microsoft.com> <1716583609-21790-16-git-send-email-wufan@linux.microsoft.com>
In-Reply-To: <1716583609-21790-16-git-send-email-wufan@linux.microsoft.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 29 May 2024 21:46:57 -0400
Message-ID: <CAHC9VhRsnGjZATBj7-evK6Gdryr54raTTKMYO_vup8AGXLwjQg@mail.gmail.com>
Subject: Re: [PATCH v19 15/20] fsverity: expose verified fsverity built-in
 signatures to LSMs
To: ebiggers@kernel.org, Fan Wu <wufan@linux.microsoft.com>
Cc: corbet@lwn.net, zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com, 
	tytso@mit.edu, axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org, 
	mpatocka@redhat.com, eparis@redhat.com, linux-doc@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	fsverity@lists.linux.dev, linux-block@vger.kernel.org, 
	dm-devel@lists.linux.dev, audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Deven Bowers <deven.desai@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 4:46=E2=80=AFPM Fan Wu <wufan@linux.microsoft.com> =
wrote:
>
> This patch enhances fsverity's capabilities to support both integrity and
> authenticity protection by introducing the exposure of built-in
> signatures through a new LSM hook. This functionality allows LSMs,
> e.g. IPE, to enforce policies based on the authenticity and integrity of
> files, specifically focusing on built-in fsverity signatures. It enables
> a policy enforcement layer within LSMs for fsverity, offering granular
> control over the usage of authenticity claims. For instance, a policy
> could be established to permit the execution of all files with verified
> built-in fsverity signatures while restricting kernel module loading
> from specified fsverity files via fsverity digests.
>
> The introduction of a security_inode_setintegrity() hook call within
> fsverity's workflow ensures that the verified built-in signature of a fil=
e
> is exposed to LSMs. This enables LSMs to recognize and label fsverity fil=
es
> that contain a verified built-in fsverity signature. This hook is invoked
> subsequent to the fsverity_verify_signature() process, guaranteeing the
> signature's verification against fsverity's keyring. This mechanism is
> crucial for maintaining system security, as it operates in kernel space,
> effectively thwarting attempts by malicious binaries to bypass user space
> stack interactions.
>
> The second to last commit in this patch set will add a link to the IPE
> documentation in fsverity.rst.
>
> Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
> Signed-off-by: Fan Wu <wufan@linux.microsoft.com>
>
> ---
> v1-v6:
>   + Not present
>
> v7:
>   Introduced
>
> v8:
>   + Split fs/verity/ changes and security/ changes into separate patches
>   + Change signature of fsverity_create_info to accept non-const inode
>   + Change signature of fsverity_verify_signature to accept non-const ino=
de
>   + Don't cast-away const from inode.
>   + Digest functionality dropped in favor of:
>     ("fs-verity: define a function to return the integrity protected
>       file digest")
>   + Reworded commit description and title to match changes.
>   + Fix a bug wherein no LSM implements the particular fsverity @name
>     (or LSM is disabled), and returns -EOPNOTSUPP, causing errors.
>
> v9:
>   + No changes
>
> v10:
>   + Rename the signature blob key
>   + Cleanup redundant code
>   + Make the hook call depends on CONFIG_FS_VERITY_BUILTIN_SIGNATURES
>
> v11:
>   + No changes
>
> v12:
>   + Add constification to the hook call
>
> v13:
>   + No changes
>
> v14:
>   + Add doc/comment to built-in signature verification
>
> v15:
>   + Add more docs related to IPE
>   + Switch the hook call to security_inode_setintegrity()
>
> v16:
>   + Explicitly mention "fsverity builtin signatures" in the commit
>     message
>   + Amend documentation in fsverity.rst
>   + Fix format issue
>   + Change enum name
>
> v17:
>   + Fix various documentation issues
>   + Use new enum name LSM_INT_FSVERITY_BUILTINSIG_VALID
>
> v18:
>   + Fix typos
>   + Move the inode_setintegrity hook call into fsverity_verify_signature(=
)
>
> v19:
>   + Cleanup code w.r.t inode_setintegrity hook refactoring
> ---
>  Documentation/filesystems/fsverity.rst | 23 +++++++++++++++++++++--
>  fs/verity/signature.c                  | 18 +++++++++++++++++-
>  include/linux/security.h               |  1 +
>  3 files changed, 39 insertions(+), 3 deletions(-)

Eric, can you give this patch in particular a look to make sure you
are okay with everything?  I believe Fan has addressed all of your
previous comments and it would be nice to have your Ack/Review tag if
you are okay with the current revision.

--=20
paul-moore.com

