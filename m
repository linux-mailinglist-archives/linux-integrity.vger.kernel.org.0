Return-Path: <linux-integrity+bounces-2409-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 813588C5BF3
	for <lists+linux-integrity@lfdr.de>; Tue, 14 May 2024 21:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 375BB2823C2
	for <lists+linux-integrity@lfdr.de>; Tue, 14 May 2024 19:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2131D18133C;
	Tue, 14 May 2024 19:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BQ5nTcrJ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765B3181338
	for <linux-integrity@vger.kernel.org>; Tue, 14 May 2024 19:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715716515; cv=none; b=N4T3rGs3Sz/2xqaFiPGHGL2BwqjnPF9jy8lZiP4x0AMH2UEX6cBDDL20Du6ObRrasNmOJXtmYXGDV5b0QnQtSJvJBifunPisitX2Uy16mqaiLGU7GApHCA63B0v7uBBdp/anodpLo/W+Ms/B1aQNAAzhn/QSpme3GpsihW4nwps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715716515; c=relaxed/simple;
	bh=Tn7ggDBZ467fewog7X29iTchxNr3w1imZ5QlMHFp0v0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fNZS3q2vcDyN33xgpAzS7P9SCSYzG4TYfn9tEiGVIJqAgysWkevX14uivGQVLPSuDijYQugb9/7zvb+wdfPQ+LqkbayzQN3ggNOZTzsvVLrdz3qRJ5hI/A3sqQWdusSqtGmzZDIajRo3ZjPWqjYi6D/JHfL+yL43Vit4QNwSDsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BQ5nTcrJ; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-de462979e00so6447183276.3
        for <linux-integrity@vger.kernel.org>; Tue, 14 May 2024 12:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1715716512; x=1716321312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5DfaKSvWBjSuruH8QpkzwqbDWxyqIe8ntp5STBjhPE=;
        b=BQ5nTcrJeiDGmJPbk+0RbPTElKvyqninC22tbUnOXLGS1LGq1NMiBlKd/vEdzgWmX3
         J6CyOwcl5ivwV579DFEK3+TPJNedRbX5ta4rufuEGc9PXSFysi/1ahLWwCZ145ht6Uyl
         Bw6LPtcCw4jhHWxePof5VARvVKrO7Gny5IjBXAEBH3jl2fhWU277pEPsN/aRwtFOao6H
         alRLOYOxC3Mw4O3SYM24cutTSjj6riCyqehsqMkh76Ix8NCPvVfYnaoGWhA3ar0CMRBO
         uOblc/Ql1V5KS6OL2dGv81/5AuDDrkYhB4Q5bH42HhK8obCcNSuLZXmuVzWWpy725Av5
         SDxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715716512; x=1716321312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I5DfaKSvWBjSuruH8QpkzwqbDWxyqIe8ntp5STBjhPE=;
        b=olEQNxt+GKwO8V6ovgRf/6IQtXF5wJsiubL6biUVs6NTvf79YyqsTi2o77w/3Pq0Z3
         px/TfSPmCS2vq9LlJoBEJG3sDRw3R5+Svml+Cwyxn7Q3ihfN4VOyXCghADwgHnwG8BS2
         4gsZED0ftQE6T+JImv/a0Z5oFgbhhL+r4/TElk75UO7+vKFtYSvOaVpe1Qn2laqy4j8z
         yBvUFKAXNsnJ4qYmhVdxkNjNvV+YehtoKk9ah4WhsbrTeA0F3+Rw7FqHcfOLsAOyiOIq
         j6T1j6nDQL977wwNfdCmmdxn/0pq9lXA0Z8xSu10CDpCiJ4nnP4GeKBGiuaSkKiZSUB0
         4+Qg==
X-Forwarded-Encrypted: i=1; AJvYcCV5yjv2HtIY0oz+MxuMR69ACNxTkFzXHRFnct8+87xO26NmJh9FxwOWrFJa6FIx7x3RIBRBoEoS7K7LhOx0ERwPLnE1nWbwV4M1pLDrsx6r
X-Gm-Message-State: AOJu0YzTy4+bV2EkSjfdYt0Vkbn0EVIowS+Y/8ZxIGXN2wRBDh7/KSEu
	E96hO7otosDNQC6j/12HGaD1ntFrX7o0X6OCh1k47lWmQFh4bR/s6rh4LwEPG7fdeRwaCrhCVXk
	lBF3g8kfRIxB1pPcINpujR/mGGL5OwxLJbrwa
X-Google-Smtp-Source: AGHT+IGVq5mRXTNrK/KaBwurMBldLnV/6qJN5uwTdGazOX6+s8bWL81rsv23lU+ZbyujJVMk8Qdjk3/8J+Z+jQ3+QZk=
X-Received: by 2002:a25:ad50:0:b0:de4:619a:fbd with SMTP id
 3f1490d57ef6-dee4f2f6cb8mr13359322276.9.1715716512499; Tue, 14 May 2024
 12:55:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1714775551-22384-1-git-send-email-wufan@linux.microsoft.com> <1714775551-22384-17-git-send-email-wufan@linux.microsoft.com>
In-Reply-To: <1714775551-22384-17-git-send-email-wufan@linux.microsoft.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 14 May 2024 15:55:01 -0400
Message-ID: <CAHC9VhTK4WS6BOXqLJ4sNKXR9a17gT3vXJUBc1F11cZ_QaOYBA@mail.gmail.com>
Subject: Re: [PATCH v18 16/21] fsverity: expose verified fsverity built-in
 signatures to LSMs
To: ebiggers@kernel.org
Cc: Fan Wu <wufan@linux.microsoft.com>, corbet@lwn.net, zohar@linux.ibm.com, 
	jmorris@namei.org, serge@hallyn.com, tytso@mit.edu, axboe@kernel.dk, 
	agk@redhat.com, snitzer@kernel.org, eparis@redhat.com, 
	linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, fsverity@lists.linux.dev, 
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Deven Bowers <deven.desai@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 6:32=E2=80=AFPM Fan Wu <wufan@linux.microsoft.com> w=
rote:
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

Eric, are you okay with the fs-verity patches in v18?  If so, it would
be nice to get your ACK on this patch at the very least.

While it looks like there may be a need for an additional respin to
address some new/different feedback from the device-mapper folks, that
shouldn't affect the fs-verity portions of the patchset.

--=20
paul-moore.com

