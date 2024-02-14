Return-Path: <linux-integrity+bounces-1214-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF1E85549F
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Feb 2024 22:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9931B23BCA
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Feb 2024 21:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2557F13EFF3;
	Wed, 14 Feb 2024 21:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bPl+nWhq"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3633C13DB8A
	for <linux-integrity@vger.kernel.org>; Wed, 14 Feb 2024 21:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707945719; cv=none; b=KusHpCg7hAfgRqLQJSuIJna4lnsW+k9Uml+4MW7SWMBtEj3Slp7Xdbr2reDgb2qeNEZ1qdwfzR4H7a4DWS0QFXpiIpfRsMJz+72CK1a5Y/BzHAum6ekIqQSEn8tm+sCJNeLN8JJr8eOL8e4+/k1UlxNX/JOxO1ZIVn8F34w31aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707945719; c=relaxed/simple;
	bh=b0xMIcRt9SLSL0Q4PzKXSxEAiCcZcUoeIRlPO4qsUAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VrubVh9b6WzV9wskAaG+N1EuTqcDzTuTM7iBhHCvhOtDybtp6PISxC2zBnGk5wxCxRyDQNQsbkOqHD6+osZv1vxLClqJaPy1M5It6yeRwQ5hhW+ZrnR2gcUm8kNJECNJOjsUYfaMiVrKWbU4hB9Ycj5upomIPcvLGM1spPSmzzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bPl+nWhq; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-603fd31f5c2so11429277b3.0
        for <linux-integrity@vger.kernel.org>; Wed, 14 Feb 2024 13:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1707945716; x=1708550516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ludDExKUqMptEvphl/NE5ulFWudwk9xh8twHjzhcpOg=;
        b=bPl+nWhq6aBeZ7cbSJ46V+E5Gzs5+Wt/QU83LXFm47Uest2ir9SF6GisGm3KrjiFRw
         D/VxIEHk0xY7G+MC6kz3Zq2Ffx4j2naZg03wkFHINrhZIvIAud2kHg2CKffL+Jnzr6uo
         Vsnc9KxYhGX1ThowbdztncNBEkBoVQmIR4Eix3MJ/GteXiiIhYohtfRC81+ITlAuNFUv
         VaiOE2AYJ8gmwvtgctO9+OhI2e17f3H39B+IVWSGeLDDdOY63tFQ0gZlA7lvg4E+HOA7
         N41/f0I/9sQkEquBGt7IAQ+ubz2r3MNGY4xg2usprjiJZlfWc4EyxeFhR9tMpzcTCiOu
         O2QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707945716; x=1708550516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ludDExKUqMptEvphl/NE5ulFWudwk9xh8twHjzhcpOg=;
        b=usHSGhYpw8BgUASdV5MPKDLuHz4fLyCfwCsXAzygQJCyRUyF35Yc4mj/i60DiDe69Z
         V6UDHH+AVVOYU87Ixf22IQf5uhra7fpZb32NaKLrd4kk8/ZlPfJYgo71F+EVhdK21yqP
         H4fJu6OXdulVwKXzDSois8icA9aQQcRUoh26FcKeuQ9f1REc8Xs7o7R1N9LaP9LPJ3iI
         r1N3xTBOqmQ8nWnLfAB4t9smJSLgHzxaH86By/I+WLn900AiGJB9AAEyU6H950xb8GVP
         iF4qBViLMc0bFT0mXxuXaL/Qo0R3eD3dYsPGDBI8+3Pwx7eYok4+kKG3/5J211zJSk+1
         Qfzg==
X-Forwarded-Encrypted: i=1; AJvYcCUAB7xkUBsxte4bNN1AxJIgomKDTf4ICkRafiL8y99tRhniLqG2lwz29QJgbC0VCbUXAVHum+jlmIpgLZxBmGIK9heIkhi49XDt6UH79Khy
X-Gm-Message-State: AOJu0YwOvdfGe9UXSWYF9jIhc5xVqAuwRpmawcGGtAUcpvCF7WWgBB9o
	E/yIwGBvcsoovfOf4lPuyJRmwM/lKDFMiCmHJdLNR+2EJc9osA7IGUuTmSwVTV3azt64jdpUTZk
	Pp3J91uxcvqEjahxTqSV8RE6ZqqCaLY3rpiU7
X-Google-Smtp-Source: AGHT+IGpDAmB1ikTVU1E5KjthEFFmc/sTniREdzcyKzjsKUMtOXwCK5kuZpdwNzeTiBcIUEmSY5KYid4S5OCYvYRXxc=
X-Received: by 2002:a0d:d7c4:0:b0:607:75e7:a66a with SMTP id
 z187-20020a0dd7c4000000b0060775e7a66amr2644503ywd.22.1707945716175; Wed, 14
 Feb 2024 13:21:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115181809.885385-1-roberto.sassu@huaweicloud.com>
 <20240115181809.885385-13-roberto.sassu@huaweicloud.com> <305cd1291a73d788c497fe8f78b574d771b8ba41.camel@linux.ibm.com>
 <CAHC9VhQ7DgPJtNTRCYneu_XnpRmuwfPCW+FqVuS=k6U5-F6pJw@mail.gmail.com>
 <05ad625b0f5a0e6c095abee5507801da255b36cd.camel@huaweicloud.com>
 <CAHC9VhR2M_MWHs34kn-WH3Wr0sgT09WKveecy7onkFhUb1-gEg@mail.gmail.com> <63afc94126521629bb7656b6e6783d6614ee898a.camel@linux.ibm.com>
In-Reply-To: <63afc94126521629bb7656b6e6783d6614ee898a.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 14 Feb 2024 16:21:45 -0500
Message-ID: <CAHC9VhQGiSq2LTm7TBvCwDB_NcMe_JjORLbuHVfC4UpJQi_N4g@mail.gmail.com>
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

On Wed, Feb 14, 2024 at 3:07=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
> On Tue, 2024-02-13 at 10:33 -0500, Paul Moore wrote:
> > On Tue, Feb 13, 2024 at 7:59=E2=80=AFAM Roberto Sassu
> > <roberto.sassu@huaweicloud.com> wrote:
> > > On Mon, 2024-02-12 at 16:16 -0500, Paul Moore wrote:
> > > > On Mon, Feb 12, 2024 at 4:06=E2=80=AFPM Mimi Zohar <zohar@linux.ibm=
.com> wrote:
> > > > > Hi Roberto,
> > > > >
> > > > >
> > > > > > diff --git a/security/security.c b/security/security.c
> > > > > > index d9d2636104db..f3d92bffd02f 100644
> > > > > > --- a/security/security.c
> > > > > > +++ b/security/security.c
> > > > > > @@ -2972,6 +2972,23 @@ int security_file_open(struct file *file=
)
> > > > > >       return fsnotify_perm(file, MAY_OPEN);  <=3D=3D=3D  Confli=
ct
> > > > >
> > > > > Replace with "return fsnotify_open_perm(file);"
> > > > >
> > > > > >  }
> > > > > >
> > > > >
> > > > > The patch set doesn't apply cleaning to 6.8-rcX without this
> > > > > change.  Unless
> > > > > there are other issues, I can make the change.
> > > >
> > > > I take it this means you want to pull this via the IMA/EVM tree?
> > >
> > > Not sure about that, but I have enough changes to do to make a v10.
>
> @Roberto:  please add my "Reviewed-by" to the remaining patches.
>
> >
> > Sorry, I should have been more clear, the point I was trying to
> > resolve was who was going to take this patchset (eventually).  There
> > are other patches destined for the LSM tree that touch the LSM hooks
> > in a way which will cause conflicts with this patchset, and if
> > you/Mimi are going to take this via the IMA/EVM tree - which is fine
> > with me - I need to take that into account when merging things in the
> > LSM tree during this cycle.  It's not a big deal either way, it would
> > just be nice to get an answer on that within the next week.
>
> Similarly there are other changes for IMA and EVM.  If you're willing to =
create
> a topic branch for just the v10 patch set that can be merged into your tr=
ee and
> into my tree, I'm fine with your upstreaming v10. (I'll wait to send my p=
ull
> request after yours.)  Roberto will add my Ack's to the integrity, IMA, a=
nd EVM
> related patches.  However if you're not willing to create a topic branch,=
 I'll
> upstream the v10 patch set.

I'm not a big fan of sharing topic branches across different subsystem
trees, I'd much rather just agree that one tree or another takes the
patchset and the others plan accordingly.  Based on our previous
discussions I was under the impression that you wanted me to merge
this patchset into lsm/dev, but it looks like that is no longer the
case - which is okay by me.

Assuming Roberto gets a v10 out soon, do you expect to merge the v10
patchset and send it up during the upcoming merge window (for v6.9),
or are you expecting to wait until after the upcoming merge window
closes and target v6.10?  Once again, either is fine, I'm just trying
to coordinate this with other patches.

--=20
paul-moore.com

