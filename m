Return-Path: <linux-integrity+bounces-1968-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39462895D96
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Apr 2024 22:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF5D8284F78
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Apr 2024 20:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0003215D5D8;
	Tue,  2 Apr 2024 20:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CW9yCGB4"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BB95914D
	for <linux-integrity@vger.kernel.org>; Tue,  2 Apr 2024 20:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712089705; cv=none; b=Ul2U9y/tPB7l2e9+re6myE/aE8OfTCaux6+Tys8v1QeduHMRZpMNpo7RuyjE8RVKALj934bW9i5Jy6JDMY7NSDnPkrVzwr2sU1EzdgAGwLrP30GOxQ4Og50myofAHUGiQtlkx/5+w+HqdwVRAKNMdUue46VFf8pMpQ6is+nLbxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712089705; c=relaxed/simple;
	bh=LfVYX8aS+uGvfYiFPza5xfpJggy3wA1TMy/HX9tJed4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LQ+JjT5SLIw1c4OX4+xNK9lzD2uvcthyp6gg4RlsPd7tIXlL47/Jv+7tixico6IDvaII1CVT8MQo52gi9wMOyzW0WRqimbAgJ+cAunX6RU6KiD/1DRl5mHWu+tZwwLnaFyfdn5Yn2iV+hj3CbR0oDLn1pkVcwOl2M2ZYXJgUoHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CW9yCGB4; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6147942ae18so34006517b3.2
        for <linux-integrity@vger.kernel.org>; Tue, 02 Apr 2024 13:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1712089702; x=1712694502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CoSv33fHX+PiwFO/k1mr+DGe32nj0k4cYvUK0De9J/g=;
        b=CW9yCGB4NsT7Ls+jy9a6DbYdVWYC6HEPWhP+LRjpxT8xZbfmT/2MlJpXWm41hFvCdP
         zJcJJbaBAJUmVDzLx+hbesZBDJqjxEXn44gC0Jz6qf5Q1jK9t7SmMdIWQtYqGGSg6nTt
         hwsNtV1wVZp12mAgDmTDKqNY/9b/yc+RBs82dlEuWi5kyKpFqVzlmrnUqznGfzPQ/XU8
         ntcMqkXDQamfcIVrut1I+Siwehow7GjMTqsb50uULbCq0hX9vWVPwwhvE3vqZJ2UU+hZ
         wlpdv5vqjuG+5w4Tik6p1gB66uVC+iXGqaJAmKZVpCoep2DV72fT3+g61GehW+I14v7W
         F4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712089702; x=1712694502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CoSv33fHX+PiwFO/k1mr+DGe32nj0k4cYvUK0De9J/g=;
        b=q3litAAn4G5Xf1PgZUaMZ4f6h/o79AxO9ux0gvtpQCWLW1iO/CwiJe+rOSw+3fKj2u
         W0xYHeJSkplqAA5WffNKsTcvXFrvEQYEUFe1owcfz0O6SGG4Tb73foAqIi7urVLRNgoI
         eA6yyTY89vXfAy20IozjvANJqOQYvzk36TmM7OLm6+9wpRYmSkNRWcy8jya7b3GMUqlz
         LxrOye1fiW9Qk+q3+7f5PaZChIfrzuh873gcAOBcyQ/W62Z7g+hrJ/9SvTNWrT5Q4HBU
         kEL/qLW29vip81Z5G3rXQQrWuT4ZNgKgby9YvN02yfkFeZBO7b8oj96cdOk49ofczFtI
         Jm8w==
X-Forwarded-Encrypted: i=1; AJvYcCXhuU4KxBEt7Ao1d00FtixbNjWmIc1jnWUNrZZReeZW4eKs9MQ+0H46tgAPw5MmaCOud8STYhRzGMDDHPAMiutfvAQjeD0RoiXltgl9chA/
X-Gm-Message-State: AOJu0YwWo6BGZqjELJTE8sDEKWpSluRJRmDgKajMt9iLzX72qAIQQvsG
	RkQ2PX6gX1hwqQIrk6NLMFG36t7YxVtdWe3j04jJrpa5CXpMbdJJRz1GFyuRo+O2cKJd4gO5yES
	83ZGglVNFMUZ+KxLdtF1Ssr1pSZT+ZcK44T8k
X-Google-Smtp-Source: AGHT+IEVBN+nZl8MKEmvtUo5GMbK7xeKkzls5qXpx0s2OutO7Jvpps2qS6SsUR1HM2jxzRpzT7CFKW3Wf3o/srFXHhw=
X-Received: by 2002:a81:5342:0:b0:611:2eb4:2402 with SMTP id
 h63-20020a815342000000b006112eb42402mr12634897ywb.21.1712089702684; Tue, 02
 Apr 2024 13:28:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402141145.2685631-1-roberto.sassu@huaweicloud.com>
 <CAHk-=wgepVMJCYj9s7J50_Tpb5BWq9buBoF0J5HAa1xjet6B8A@mail.gmail.com> <CAHC9VhTt71JUeef5W8LCASKoH8DvstJr+kEZn2wqOaBGSiiprw@mail.gmail.com>
In-Reply-To: <CAHC9VhTt71JUeef5W8LCASKoH8DvstJr+kEZn2wqOaBGSiiprw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 2 Apr 2024 16:28:12 -0400
Message-ID: <CAHC9VhSt0GkTe8ho2yyP8Bp1rbtiFbp6dNY6m93cvBXJ=aKtSQ@mail.gmail.com>
Subject: Re: [GIT PULL] security changes for v6.9-rc3
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 4:27=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
> On Tue, Apr 2, 2024 at 3:39=E2=80=AFPM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
>
> ...
>
> > But if we really want to do this ("if mknod creates a positive dentry,
> > I won't see it in lookup, so I want to appraise it now"), then we
> > should just deal with this in the generic layer with some hack like
> > this:
> >
> >   --- a/security/security.c
> >   +++ b/security/security.c
> >   @@ -1801,7 +1801,8 @@ EXPORT_SYMBOL(security_path_mknod);
> >     */
> >    void security_path_post_mknod(struct mnt_idmap *idmap, struct dentry=
 *dentry)
> >    {
> >   -     if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
> >   +     struct inode *inode =3D d_backing_inode(dentry);
> >   +     if (unlikely(!inode || IS_PRIVATE(inode)))
> >                 return;
> >         call_void_hook(path_post_mknod, idmap, dentry);
> >    }
>
> Other than your snippet wrapping both the inode/NULL and
> inode/IS_PRIVATE checks with an unlikely(), that's what Roberto
> submitted (his patch only wrapped the inode/IS_PRIVATE with unlikely).

Nevermind, I missed the obvious OR / AND diff ... sorry for the noise.

--=20
paul-moore.com

