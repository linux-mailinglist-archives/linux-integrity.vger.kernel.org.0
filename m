Return-Path: <linux-integrity+bounces-6343-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 010FBAC8574
	for <lists+linux-integrity@lfdr.de>; Fri, 30 May 2025 01:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2CCD189D415
	for <lists+linux-integrity@lfdr.de>; Thu, 29 May 2025 23:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C9E254B18;
	Thu, 29 May 2025 23:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Ma1HFYxb"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269EF21E0B7
	for <linux-integrity@vger.kernel.org>; Thu, 29 May 2025 23:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748562572; cv=none; b=gqfzPvnnXa0GV85B0te7Ylv3c8yJhKILFCq/x6lEB/o2K6nkIJ+Xwsz6e8S4zAinbZafL5bMyXjhm57m7tiLlP9lBLMeCy6xC2IpC/oIktCErCTUbET2Gi5cIJTulMm3RSYeb8xFm7wxmN+BJR05KgDcR2mmamDv1t3ps08YkUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748562572; c=relaxed/simple;
	bh=njDQ8Lhj+rbQY91bCgJ2J/LI6phcjK0rry9e5UVMEYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JopsPCalPYyeJ1sadXA0cGxBpO3SQXPDqr/WCC2Cm8FnYXSjUzNDvCWqmHQmisVJx1DkDyfWOWIeBGmbqrvYd4YNMFTzH4u9Ct8VgP1UjeiPodASnQpYSFC0lQsOPUVF+4jsnbm1Q7axBteGGVHBYZ/N9x/wFo25WUaQ2T6fgOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Ma1HFYxb; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e75668006b9so1370833276.3
        for <linux-integrity@vger.kernel.org>; Thu, 29 May 2025 16:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1748562570; x=1749167370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IzrpMWMfPR3T2gCVNz/ykn1poKsGqIWx4fYMabbDEoU=;
        b=Ma1HFYxbpQWiO5QgZg/176AE28nFmcx4LGBbFEj2ed6gW7KquDE8lkkFg5lYuS5nrp
         ZnVR9EMCcTIn8swlEw8SwbYF+P5CIMZKly1ju8Ciuxn3F/YPKAeyrOKzYF3VzU8XbFts
         xzFAGS5MLLhuTxE41HqMT34c+xEYvWg+D3Vo4Kl7kQRR5jQLjYCpDtTekHmJl6Sq9jH1
         2eNjbNxi6fFmbourM8UwjWyiLUR5V1md3o6lM/AkUKkTxv8DiFoRnC0IAcAW48YBYtCh
         gf9f84AH8h1OHq3Ao5j5Kedgi+GurI7XFxavKxOymPXg1zJA2bMm8RF625x2tb9mwA3e
         DghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748562570; x=1749167370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IzrpMWMfPR3T2gCVNz/ykn1poKsGqIWx4fYMabbDEoU=;
        b=c+TP/RatQyNKgutHsSUk0bHX8dWYM19iUVa7rcMYzOP4UI4aU/6YPk7AIk8cKAU6ZK
         +jihGdccxyzNoXBv2nmMRFfUXGBENeWe1KUbfkIabRRMhCbne/tBo2CFY/8DLeecsD4B
         9jVZkXKqTo54F4QJSXZlZ6ONhiLjVCi7/MApqaTaryAXYIJPpMFjt91G9/TjcJx+PHJX
         kS56Y8C0ZikI/uJrc2EX584oqdm48Kt6JSC0GhtkUr8pi5B9/viwmHtb1o6etyQbG2WR
         uPAkt3hLDb5P/G2cwVViidK7YmDgl/mnbZH67lbslb4/v+/MFOGQ+cW7FVi7kgamkHep
         sz0A==
X-Forwarded-Encrypted: i=1; AJvYcCU+Fznrzz83H1aAOPDRIataluZwwzKNV+CHHPhaE9A9wCNeT8Ti0C+E1mMBtY4PjRYM940IJSAOh61rUq0GuhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIlv0mACFu8akIglFLYc9civQ65Mc0CgzBJ/maFXoGGeKzUl4N
	/wBg4rhrERbjdaBiosiZyA/XDjt0HgWUm47O9lTmQn4IYVA/tvZXZXsKkgvIHQOaZ0P95mKiWom
	y/OMrLlIWmQvgX1H69byuaRig/YaZI/4JyrKF0lNMm6gMspXwkL4=
X-Gm-Gg: ASbGncswpqj8OcePGIZMN/aGD7FJanjhJitowPdNKcc9hXdiBxhRz+3Q9EKLdEXjC2l
	Y3B2/piYlapb5Y69fCZKJIKSktumgAKXZRJVCKvQHBDy0YwJp9n+q+TU25FulUhKhzXwqQV/Qih
	IskypHo+HmwsVFh7KxnLGn5OCGH39nBLUo
X-Google-Smtp-Source: AGHT+IGhztxCAK3YTRu6P4h6gxYqvuSLD7WfoNzyStJqIFYGaHOmc7yQwpS7nzoIzkVnhQPYk9/qIXwf6pJLAlBDxC0=
X-Received: by 2002:a05:6902:330b:b0:e7d:6a68:f572 with SMTP id
 3f1490d57ef6-e7f81bb773dmr2259538276.10.1748562570009; Thu, 29 May 2025
 16:49:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521140121.591482-1-git@nightmared.fr> <20250521140121.591482-10-git@nightmared.fr>
 <CAHC9VhR-80zxgo+q07Aw8HqK+qiPdnuXC0axONGac0e9JxXvmw@mail.gmail.com> <4939d8ab-3911-4759-b8d6-cb57ff9f9cda@nightmared.fr>
In-Reply-To: <4939d8ab-3911-4759-b8d6-cb57ff9f9cda@nightmared.fr>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 29 May 2025 19:49:19 -0400
X-Gm-Features: AX0GCFt-dubQ8zjyvLFIAb7yxjUrHx2vekSE7cPMRUm7dhYCysWfX-kgOpwdxLI
Message-ID: <CAHC9VhT5JrhzGhRnJ4VNo6e941o-xdAG-FC-Q6wDbSZhgSUWOQ@mail.gmail.com>
Subject: Re: [RFC PATCH 9/9] Loadpol LSM: add a minimal documentation
To: Simon Thoby <git@nightmared.fr>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-doc@vger.kernel.org, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 5:23=E2=80=AFAM Simon Thoby <git@nightmared.fr> wro=
te:
> On 5/21/25 23:31, Paul Moore wrote:
> > On Wed, May 21, 2025 at 10:03=E2=80=AFAM Simon THOBY <git@nightmared.fr=
> wrote:
> >>
> >> Introduce a minimal documentation for Loadpol, presenting the policy
> >> format and the two user interfaces: the securityfs policy file and the
> >> sysctl.
> >>
> >> Signed-off-by: Simon THOBY <git@nightmared.fr>
> >> ---
> >>  Documentation/admin-guide/LSM/Loadpol.rst | 81 ++++++++++++++++++++++=
+
> >>  Documentation/admin-guide/LSM/index.rst   |  1 +
> >>  2 files changed, 82 insertions(+)
> >>  create mode 100644 Documentation/admin-guide/LSM/Loadpol.rst
> >>
> >> diff --git a/Documentation/admin-guide/LSM/Loadpol.rst b/Documentation=
/admin-guide/LSM/Loadpol.rst
> >> new file mode 100644
> >> index 000000000000..0aa24a8d393c
> >> --- /dev/null
> >> +++ b/Documentation/admin-guide/LSM/Loadpol.rst
> >> @@ -0,0 +1,81 @@
> >> +.. SPDX-License-Identifier: GPL-2.0
> >> +
> >> +=3D=3D=3D=3D=3D=3D=3D
> >> +Loadpol
> >> +=3D=3D=3D=3D=3D=3D=3D
> >> +
> >> +Loadpol is a Linux Security Module that enforces a user-provided poli=
cy
> >> +when decided whether a dynamic module can be loaded or not.
> >
> > Considering the relatively small scope of Loadpol, I have to ask if
> > you've considered augmenting other LSMs to meet your needs?  While
> > LoadPin is different from what you are proposing here, it does
> > similarly limit its scope to kernel module load operations, and given
> > the current simplicity of LoadPin I imagine one could find a creative
> > way to extend it to support what you are trying to do.
>
> I indeed felt a bit ridiculous introducing a new LSM for a limited featur=
e
> like that!

Please don't feel bad about it, often simply doing "something" is what
makes things happen, even if that original "something" turns out not
to be the final "thing" :)

> What's more, I don't see it being extended much in the future - we could
> always imagine things like signed policy updates, but other than that it'=
s
> probably "feature-complete", as the feature itself is fairly small.
> The difficulty with LoadPin is that it rely relies on the notion of
> filesystem (which is coupled with the origin of the kernel modules) to en=
sure
> that modules are valid. On a general-purpose distributions, the modules
> would be stored on the same (non-integrity-verified) filesystem, so
> segregating the modules by filesystem is not really possible there.
> Extending LoadPin to provide the same features is probably possible, but =
I
> fear this would add complexity to loading by trying to make it do two
> slightly different jobs at once.

My thinking around possible augmentation of LoadPin is that both
LoadPin and Loadpol share a similar, limited focus of controlling
access to kernel module loading and Loadpol has support for a basic
loadable policy, a policy that could likely be extended to support a
LoadPin-esque construct that limit module loading based on filesystem
pinning.  It probably makes more sense to think of adding LoadPin
support to Loadpol, rather than augmenting LoadPin to support the
Loadpol concepts, but for consistency with upstream we probably need
to speak in terms of the latter.

> CC-ing Kees Cook as he is the maintainer of the LoadPin module, he may ha=
ve
> opinions on what features may or may not fit inside LoadPin.

Of course, the combination, or not, of LoadPin and Loadpol is really
up to the two of you.

> As for other LSMs, I don't really see one that tries to provide similar
> features, but I someone is open to extending an existing LSM for that, I
> would be happy to help.

I think LoadPin is the obvious choice.

--=20
paul-moore.com

