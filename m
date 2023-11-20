Return-Path: <linux-integrity+bounces-132-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0C47F1E82
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Nov 2023 22:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9CC71F2620A
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Nov 2023 21:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8409E32C9A;
	Mon, 20 Nov 2023 21:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YLhyT6Rm"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA66ED
	for <linux-integrity@vger.kernel.org>; Mon, 20 Nov 2023 13:06:21 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-da0cfcb9f40so4774672276.2
        for <linux-integrity@vger.kernel.org>; Mon, 20 Nov 2023 13:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700514380; x=1701119180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NG2FEhp12pFkNfvVzutmm+LjhzXXRny+ltBXXG6QNR4=;
        b=YLhyT6RmzMxgdwWF3OzA1dbTAz8GYwlqdzU9jExIzFo7f7lyo2lc/g5s8M1FPVxNVx
         9xH5Qe/wVsv58MHQpjcvW3LKQcQ5vIb9Aa73yrI/rkqK7MVSaCFxHqne8L13lT5gfTNd
         jrz2ZdVN1Qe3itctMb74xkKwKI6nJ4cxYD4hmugMHvP5aWDW4emrejI+By1/ZbG0f7JT
         cFXvDnsb5rYwIE/fidXu7jWV6ZgD3xHcJYQin5mUIyp4H3oCK5n4tdFaaQXQEZFpoH+G
         SJuLfuXl8Rod2tCYybo07Z13jXhOFKBICD9TAWYrNxzyLdOcfmQ9oJDeTWht/WBRaKY0
         ufgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700514380; x=1701119180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NG2FEhp12pFkNfvVzutmm+LjhzXXRny+ltBXXG6QNR4=;
        b=rQcBdzmXliDttZGS4ln12oUINlt4x0VtnUMt6vVeyyUdYSoC1JqgdOJEl3jxIWypTU
         94+Iw/nXgq5ePXz6xQn6Mpp2Z4MTeUeNkZHZdXjYFKtOaEKqdMfrHG9wlgV1SyHpnmgd
         3fro4WCqr1GHkmWkv3/4u/r1w0peIj2dmEZJ1U3dnVBaJRRJAUD9EEIv5xLEyAetLY2Q
         fqs3M8N3ztmOcQIi+pqYFURhWoH1h0xL2bcY1dk45kpLz2zTJhJlrqDoA22Fr/kIVu3c
         vTOmXlqbLST0TuBp1iJY+y2AkDY3Etn0WTvXrx+6bNXYDHEa2NVZmUG47sO3fLyoJt9a
         79Eg==
X-Gm-Message-State: AOJu0YySr70AVllg1Lbp5RYI8A4RDmocwNsQge7VPfDwwt/0uViUznii
	ref1s1FyY4LzZmHo9Oa7G4RhTGzdXu7qXm7uaha+
X-Google-Smtp-Source: AGHT+IH9dEFOAePFkBv2PMwl9MhCUaQv6Ntac6yIXsmvUTEQCyAzM8wMPOVAFCDufYnlm3OoAXU+qg91wHL5Jm2H0Ok=
X-Received: by 2002:a81:ac17:0:b0:5ca:7629:7a9a with SMTP id
 k23-20020a81ac17000000b005ca76297a9amr4086414ywh.37.1700514380344; Mon, 20
 Nov 2023 13:06:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231107134012.682009-24-roberto.sassu@huaweicloud.com>
 <17befa132379d37977fc854a8af25f6d.paul@paul-moore.com> <2084adba3c27a606cbc5ed7b3214f61427a829dd.camel@huaweicloud.com>
In-Reply-To: <2084adba3c27a606cbc5ed7b3214f61427a829dd.camel@huaweicloud.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 20 Nov 2023 16:06:09 -0500
Message-ID: <CAHC9VhTTKac1o=RnQadu2xqdeKH8C_F+Wh4sY=HkGbCArwc8JQ@mail.gmail.com>
Subject: Re: [PATCH v5 23/23] integrity: Switch from rbtree to LSM-managed
 blob for integrity_iint_cache
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, chuck.lever@oracle.com, 
	jlayton@kernel.org, neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, 
	tom@talpey.com, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, 
	dmitry.kasatkin@gmail.com, dhowells@redhat.com, jarkko@kernel.org, 
	stephen.smalley.work@gmail.com, eparis@parisplace.org, casey@schaufler-ca.com, 
	mic@digikod.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, 
	selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 3:16=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> On Fri, 2023-11-17 at 15:57 -0500, Paul Moore wrote:
> > On Nov  7, 2023 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> > >
> > > Before the security field of kernel objects could be shared among LSM=
s with
> > > the LSM stacking feature, IMA and EVM had to rely on an alternative s=
torage
> > > of inode metadata. The association between inode metadata and inode i=
s
> > > maintained through an rbtree.
> > >
> > > Because of this alternative storage mechanism, there was no need to u=
se
> > > disjoint inode metadata, so IMA and EVM today still share them.
> > >
> > > With the reservation mechanism offered by the LSM infrastructure, the
> > > rbtree is no longer necessary, as each LSM could reserve a space in t=
he
> > > security blob for each inode. However, since IMA and EVM share the
> > > inode metadata, they cannot directly reserve the space for them.
> > >
> > > Instead, request from the 'integrity' LSM a space in the security blo=
b for
> > > the pointer of inode metadata (integrity_iint_cache structure). The o=
ther
> > > reason for keeping the 'integrity' LSM is to preserve the original or=
dering
> > > of IMA and EVM functions as when they were hardcoded.
> > >
> > > Prefer reserving space for a pointer to allocating the integrity_iint=
_cache
> > > structure directly, as IMA would require it only for a subset of inod=
es.
> > > Always allocating it would cause a waste of memory.
> > >
> > > Introduce two primitives for getting and setting the pointer of
> > > integrity_iint_cache in the security blob, respectively
> > > integrity_inode_get_iint() and integrity_inode_set_iint(). This would=
 make
> > > the code more understandable, as they directly replace rbtree operati=
ons.
> > >
> > > Locking is not needed, as access to inode metadata is not shared, it =
is per
> > > inode.
> > >
> > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> > > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > > ---
> > >  security/integrity/iint.c      | 71 +++++---------------------------=
--
> > >  security/integrity/integrity.h | 20 +++++++++-
> > >  2 files changed, 29 insertions(+), 62 deletions(-)
> > >
> > > diff --git a/security/integrity/iint.c b/security/integrity/iint.c
> > > index 882fde2a2607..a5edd3c70784 100644
> > > --- a/security/integrity/iint.c
> > > +++ b/security/integrity/iint.c
> > > @@ -231,6 +175,10 @@ static int __init integrity_lsm_init(void)
> > >     return 0;
> > >  }
> > >
> > > +struct lsm_blob_sizes integrity_blob_sizes __ro_after_init =3D {
> > > +   .lbs_inode =3D sizeof(struct integrity_iint_cache *),
> > > +};
> >
> > I'll admit that I'm likely missing an important detail, but is there
> > a reason why you couldn't stash the integrity_iint_cache struct
> > directly in the inode's security blob instead of the pointer?  For
> > example:
> >
> >   struct lsm_blob_sizes ... =3D {
> >     .lbs_inode =3D sizeof(struct integrity_iint_cache),
> >   };
> >
> >   struct integrity_iint_cache *integrity_inode_get(inode)
> >   {
> >     if (unlikely(!inode->isecurity))
> >       return NULL;
> >     return inode->i_security + integrity_blob_sizes.lbs_inode;
> >   }
>
> It would increase memory occupation. Sometimes the IMA policy
> encompasses a small subset of the inodes. Allocating the full
> integrity_iint_cache would be a waste of memory, I guess?

Perhaps, but if it allows us to remove another layer of dynamic memory
I would argue that it may be worth the cost.  It's also worth
considering the size of integrity_iint_cache, while it isn't small, it
isn't exactly huge either.

> On the other hand... (did not think fully about that) if we embed the
> full structure in the security blob, we already have a mutex available
> to use, and we don't need to take the inode lock (?).

That would be excellent, getting rid of a layer of locking would be signifi=
cant.

> I'm fully convinced that we can improve the implementation
> significantly. I just was really hoping to go step by step and not
> accumulating improvements as dependency for moving IMA and EVM to the
> LSM infrastructure.

I understand, and I agree that an iterative approach is a good idea, I
just want to make sure we keep things tidy from a user perspective,
i.e. not exposing the "integrity" LSM when it isn't required.

--
paul-moore.com

