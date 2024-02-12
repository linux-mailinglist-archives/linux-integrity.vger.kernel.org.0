Return-Path: <linux-integrity+bounces-1154-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E21BC851F6B
	for <lists+linux-integrity@lfdr.de>; Mon, 12 Feb 2024 22:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71B15B213F7
	for <lists+linux-integrity@lfdr.de>; Mon, 12 Feb 2024 21:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4846C4E1CC;
	Mon, 12 Feb 2024 21:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="aXaB4ioj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C7F4DA06
	for <linux-integrity@vger.kernel.org>; Mon, 12 Feb 2024 21:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707772634; cv=none; b=O/5A534XoG+e1Aw+T+GnM0+TYDoy882zUp+HjmDqcdVeesH9PPetwF/NU2VUwi2nvi4G1nOc4tiaSw3V4bMN0M0fOQrF9nofqH9WYjBUpKSnvQP4GMX8NHFZfnIrtMaskKGaCp3jg052QoologfugjX9+w3/7Ku+61q10FKZv6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707772634; c=relaxed/simple;
	bh=sKyYv3h5LS/Xc+JkhqC/7H32Ejapjycaf0b1D5xsxdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TA9+Pt+eFaKRRt1N5zfSxH9Tmye7Cx7RYAwMaKZJCq1ibuwOWJSIOr/oe/eGPnYOsVPLvJEh+up66dubA5hzEpMOgsX5AWlQdA0/CfUV/W4y++FaiA77YmAGKFnjK2WbS3MJhC+iW1GnnlL1v8pCnyoaLiCW8nOCUje6utapbCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=aXaB4ioj; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6077444cb51so5954717b3.1
        for <linux-integrity@vger.kernel.org>; Mon, 12 Feb 2024 13:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1707772630; x=1708377430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZsnFwrkSPFxLZoShd+G+bJFEOcLvvtQSuD3i6JLjUWA=;
        b=aXaB4iojMUi4axEelhZ0stCsfoeKjXkqyvnfbZrFMOcXTy3lf8VtkFY2Ko0RCxA8hK
         gUOqXp9eCWzlicRERGuZaZIrFN3wWQn1ZdWqtOkFPlaofdV/+HODU8yTjxURHdlFqtLv
         ZLO7i2Hdcr3WEQAjn7Qo3jo6Dh1fnT7Ju+gGTnMTUEW1Lq3b+GAmGjkBLvTcyNsb7IvX
         C9X4aDlG/kdcKibBXcjX14+uys8CEASKUh7LIF5o1Eddxy2q+ucLTtVrCoHVOmmNl6pL
         wO0CWg7c5gxyx8NczGZwqKRgGSDYgUCPFjEjc2NIjT43UEFxYtnTeKv4KEY/kly5y2Il
         CPqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707772630; x=1708377430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZsnFwrkSPFxLZoShd+G+bJFEOcLvvtQSuD3i6JLjUWA=;
        b=VUH23u40VmV8k9G+PA35u5Jz+m5XMtJ6f7BWIyPxHsAZDZe1TR2v+WJ1/hoU04Ba4n
         YAtCrMYwRANNFBsP8qcrmEB/2Vp4c2DU9qr9SZKisjftM68oVyTXUsWRYuAp1qoa4kwI
         zd/UkvfuAU0XfRoKgpgzlxV5wjATA23xO7hMFNGkZqOBhDil1n6EM1neQ1S9/Aqjp3BA
         mVmCZ/mnakc0nxHKncc+WU2CYxIElWOVlUFVlPWSbeibHW9PTsVyeKKS28OLqfpMS6Hi
         DTayi0wlz3mByDMSrj6kGuE4GcS6idReM7LOxD00zFUDH0xbbmct9aA/5bzFLm3WKh81
         Bq7A==
X-Gm-Message-State: AOJu0YyP19BGvPKJuS6Ba5OWsO1BvlXMRqFCS+vc+1Dv86NUProxRUQq
	Tzx3p5J9AOMdnkWI0aJ0MzARFK2zg1PTQh7tPlve/ZMoGxz/m4I7Lrz6DcUkFYfZqWqPsXg+V6r
	BEgjcml9wxO30RXjFDxZ85pcFms9a2nJt+wxK
X-Google-Smtp-Source: AGHT+IEOi98MZdQxOtaW3bif3LCitIRo8nxqZzxmxH4vbtrZo7RwV5CIap8rAl9zZwh9y87ZH2fwVGa5f+4Y+dV/RGg=
X-Received: by 2002:a81:4e10:0:b0:604:541d:9d54 with SMTP id
 c16-20020a814e10000000b00604541d9d54mr598093ywb.21.1707772629971; Mon, 12 Feb
 2024 13:17:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115181809.885385-1-roberto.sassu@huaweicloud.com>
 <20240115181809.885385-13-roberto.sassu@huaweicloud.com> <305cd1291a73d788c497fe8f78b574d771b8ba41.camel@linux.ibm.com>
In-Reply-To: <305cd1291a73d788c497fe8f78b574d771b8ba41.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 12 Feb 2024 16:16:59 -0500
Message-ID: <CAHC9VhQ7DgPJtNTRCYneu_XnpRmuwfPCW+FqVuS=k6U5-F6pJw@mail.gmail.com>
Subject: Re: [PATCH v9 12/25] security: Introduce file_post_open hook
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de, 
	kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com, jmorris@namei.org, 
	serge@hallyn.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, 
	dhowells@redhat.com, jarkko@kernel.org, stephen.smalley.work@gmail.com, 
	eparis@parisplace.org, casey@schaufler-ca.com, shuah@kernel.org, 
	mic@digikod.net, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Roberto Sassu <roberto.sassu@huawei.com>, Stefan Berger <stefanb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 4:06=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
>
> Hi Roberto,
>
>
> > diff --git a/security/security.c b/security/security.c
> > index d9d2636104db..f3d92bffd02f 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -2972,6 +2972,23 @@ int security_file_open(struct file *file)
> >       return fsnotify_perm(file, MAY_OPEN);  <=3D=3D=3D  Conflict
>
> Replace with "return fsnotify_open_perm(file);"
>
> >  }
> >
>
> The patch set doesn't apply cleaning to 6.8-rcX without this change.  Unl=
ess
> there are other issues, I can make the change.

I take it this means you want to pull this via the IMA/EVM tree?

--=20
paul-moore.com

