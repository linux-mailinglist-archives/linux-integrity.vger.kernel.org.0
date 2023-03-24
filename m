Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15906C8762
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Mar 2023 22:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjCXVTb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 24 Mar 2023 17:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbjCXVTX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 24 Mar 2023 17:19:23 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C8417CC6
        for <linux-integrity@vger.kernel.org>; Fri, 24 Mar 2023 14:19:16 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id p203so3839555ybb.13
        for <linux-integrity@vger.kernel.org>; Fri, 24 Mar 2023 14:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1679692756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7pfGfMNBNNsLVUe+iEhmIwYw21/gtsvLqBolqL2cAyY=;
        b=CaEKWRFHReRcMgo31GuglrlmPKa9GYTDdwrQFAlOl0CNjmEJuA/bkmFRzX37Ct+YxJ
         0Dv7+jB6M544jtvOMs0tFZXUOLcgwVIvinby/FcdipnRFhJh4xZoq7hVtmI//lOvaoJ5
         MhcHkK8fUj6y6va8T/lCKFQlzYtI/qJ4XuuoS1TB1xfeYncp2ilf/loYmJlzg50IUL+O
         1Cr/GsuEdTJbNHDmaMSU73mU5WIbPvA0syoXqQE/t9Z8ZB2c9gEXAanBHcbZK7pg+x7l
         SzEOrRl4Wq66Sen2tt8rT7wUZyJCZC9u0KDNFl6w7846cP2gaLeOXeLhdih/7hjX6yUg
         6jbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679692756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7pfGfMNBNNsLVUe+iEhmIwYw21/gtsvLqBolqL2cAyY=;
        b=f99xHVQbmAP66jqcVIugKCAwMi+GkaieQBIkrTeg4/ik0xqbOGW0KPKUqvrKJPhXfH
         Hnj8CaRYie2Rn3Y/Y9O4S9BPTElBq4ShrJyi3QXd06b9FcS0Q1IDZ1PRWXsONM+YcsFT
         GgbTESD8yF7IHeI3489Sxm45NpyAx5TtTPONL0VqpqSvrCJj7rY9AzV3JwgXkHNvWVhN
         6kI+NnXUBGPAyUR2BxIb6E6OiB4kLF7eRAcw/+p4iFRZeeGw1R4WCIGy8pubnWQqyFU+
         90figHgMWr3Vo/0ola8Iq6+LA+PKiAoFUCP9OeMBStYdnJMoYdwukKe7bcfDGgvn1+fY
         8nmg==
X-Gm-Message-State: AAQBX9fqLzTkAc+qqL/2MLd7rL1IkllgEHmTxK/Cc0LHiyU//cRlTEcm
        KqwtIpWvu78Q/9WgLfDPVRRqilF1eG9PerxrzeuS
X-Google-Smtp-Source: AKy350ZdpVT/6244kA+n509C+bZutGl+4rbLtWTPVt0gqlwA/VXZ235IROlMZnmvXpCo3yd2nJvrVuSjH49dkBB5LPA=
X-Received: by 2002:a05:6902:18c7:b0:b72:fff0:2f7f with SMTP id
 ck7-20020a05690218c700b00b72fff02f7fmr3344565ybb.4.1679692755843; Fri, 24 Mar
 2023 14:19:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230314081720.4158676-1-roberto.sassu@huaweicloud.com>
 <20230314081720.4158676-5-roberto.sassu@huaweicloud.com> <CAHC9VhTD3EyDiJs9+NQrgp84JcUs_sx8WONtRk2YYH4m1C8nVw@mail.gmail.com>
 <939e6c88662ad90b963993c4cc1b702083e74a7a.camel@huaweicloud.com>
In-Reply-To: <939e6c88662ad90b963993c4cc1b702083e74a7a.camel@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 24 Mar 2023 17:19:04 -0400
Message-ID: <CAHC9VhQuKYundB6rSTi57hxYzE7+QYzHd75M9m-TgyOddPj5Kg@mail.gmail.com>
Subject: Re: [PATCH v8 4/6] security: Allow all LSMs to provide xattrs for
 inode_init_security hook
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, casey@schaufler-ca.com,
        ocfs2-devel@oss.oracle.com, reiserfs-devel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Mar 24, 2023 at 6:18=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> On Thu, 2023-03-23 at 20:09 -0400, Paul Moore wrote:
> > On Tue, Mar 14, 2023 at 4:19=E2=80=AFAM Roberto Sassu
> > <roberto.sassu@huaweicloud.com> wrote:
> > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > >
> > > Currently, security_inode_init_security() supports only one LSM provi=
ding
> > > an xattr and EVM calculating the HMAC on that xattr, plus other inode
> > > metadata.
> > >
> > > Allow all LSMs to provide one or multiple xattrs, by extending the se=
curity
> > > blob reservation mechanism. Introduce the new lbs_xattr field of the
> > > lsm_blob_sizes structure, so that each LSM can specify how many xattr=
s it
> > > needs, and the LSM infrastructure knows how many xattr slots it shoul=
d
> > > allocate.
> > >
> > > Dynamically allocate the xattrs array to be populated by LSMs with th=
e
> > > inode_init_security hook, and pass it to the latter instead of the
> > > name/value/len triple. Update the documentation accordingly, and fix =
the
> > > description of the xattr name, as it is not allocated anymore.
> > >
> > > Since the LSM infrastructure, at initialization time, updates the num=
ber of
> > > the requested xattrs provided by each LSM with a corresponding offset=
 in
> > > the security blob (in this case the xattr array), it makes straightfo=
rward
> > > for an LSM to access the right position in the xattr array.
> > >
> > > There is still the issue that an LSM might not fill the xattr, even i=
f it
> > > requests it (legitimate case, for example it might have been loaded b=
ut not
> > > initialized with a policy). Since users of the xattr array (e.g. the
> > > initxattrs() callbacks) detect the end of the xattr array by checking=
 if
> > > the xattr name is NULL, not filling an xattr would cause those users =
to
> > > stop scanning xattrs prematurely.
> > >
> > > Solve that issue by introducing security_check_compact_filled_xattrs(=
),
> > > which does a basic check of the xattr array (if the xattr name is fil=
led,
> > > the xattr value should be too, and viceversa), and compacts the xattr=
 array
> > > by removing the holes.
> > >
> > > An alternative solution would be to let users of the xattr array know=
 the
> > > number of elements of that array, so that they don't have to check th=
e
> > > termination. However, this seems more invasive, compared to a simple =
move
> > > of few array elements.
> > >
> > > security_check_compact_filled_xattrs() also determines how many xattr=
s in
> > > the xattr array have been filled. If there is none, skip
> > > evm_inode_init_security() and initxattrs(). Skipping the former also =
avoids
> > > EVM to crash the kernel, as it is expecting a filled xattr.
> > >
> > > Finally, adapt both SELinux and Smack to use the new definition of th=
e
> > > inode_init_security hook, and to correctly fill the designated slots =
in the
> > > xattr array. For Smack, reserve space for the other defined xattrs al=
though
> > > they are not set yet in smack_inode_init_security().
> > >
> > > Reported-by: Nicolas Bouchinet <nicolas.bouchinet@clip-os.org> (EVM c=
rash)
> > > Link: https://lore.kernel.org/linux-integrity/Y1FTSIo+1x+4X0LS@archli=
nux/
> > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> > > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > > ---
> > >  include/linux/lsm_hook_defs.h |   3 +-
> > >  include/linux/lsm_hooks.h     |   1 +
> > >  security/security.c           | 119 +++++++++++++++++++++++++++++---=
--
> > >  security/selinux/hooks.c      |  19 ++++--
> > >  security/smack/smack_lsm.c    |  33 ++++++----
> > >  5 files changed, 137 insertions(+), 38 deletions(-)

...

> > > @@ -1604,33 +1654,66 @@ int security_inode_init_security(struct inode=
 *inode, struct inode *dir,
> > >                                  const struct qstr *qstr,
> > >                                  const initxattrs initxattrs, void *f=
s_data)
> > >  {
> > > -       struct xattr new_xattrs[MAX_LSM_EVM_XATTR + 1];
> > > -       struct xattr *lsm_xattr, *evm_xattr, *xattr;
> > > -       int ret;
> > > +       struct security_hook_list *P;
> > > +       struct xattr *new_xattrs;
> > > +       struct xattr *xattr;
> > > +       int ret =3D -EOPNOTSUPP, num_filled_xattrs =3D 0;
> > >
> > >         if (unlikely(IS_PRIVATE(inode)))
> > >                 return 0;
> > >
> > > +       if (!blob_sizes.lbs_xattr)
> > > +               return 0;
> > > +
> > >         if (!initxattrs)
> > >                 return call_int_hook(inode_init_security, -EOPNOTSUPP=
, inode,
> > > -                                    dir, qstr, NULL, NULL, NULL);
> > > -       memset(new_xattrs, 0, sizeof(new_xattrs));
> > > -       lsm_xattr =3D new_xattrs;
> > > -       ret =3D call_int_hook(inode_init_security, -EOPNOTSUPP, inode=
, dir, qstr,
> > > -                           &lsm_xattr->name,
> > > -                           &lsm_xattr->value,
> > > -                           &lsm_xattr->value_len);
> > > -       if (ret)
> > > +                                   dir, qstr, NULL);
> > > +       /* Allocate +1 for EVM and +1 as terminator. */
> > > +       new_xattrs =3D kcalloc(blob_sizes.lbs_xattr + 2, sizeof(*new_=
xattrs),
> > > +                            GFP_NOFS);
> > > +       if (!new_xattrs)
> > > +               return -ENOMEM;
> > > +
> > > +       hlist_for_each_entry(P, &security_hook_heads.inode_init_secur=
ity,
> > > +                            list) {
> > > +               ret =3D P->hook.inode_init_security(inode, dir, qstr,=
 new_xattrs);
> > > +               if (ret && ret !=3D -EOPNOTSUPP)
> > > +                       goto out;
> > > +               /*
> > > +                * As documented in lsm_hooks.h, -EOPNOTSUPP in this =
context
> > > +                * means that the LSM is not willing to provide an xa=
ttr, not
> > > +                * that it wants to signal an error. Thus, continue t=
o invoke
> > > +                * the remaining LSMs.
> > > +                */
> > > +               if (ret =3D=3D -EOPNOTSUPP)
> > > +                       continue;
> > > +               /*
> > > +                * As the number of xattrs reserved by LSMs is not di=
rectly
> > > +                * available, directly use the total number blob_size=
s.lbs_xattr
> > > +                * to keep the code simple, while being not the most =
efficient
> > > +                * way.
> > > +                */
> >
> > Is there a good reason why the LSM can't return the number of xattrs
> > it is adding to the xattr array?  It seems like it should be fairly
> > trivial for the individual LSMs to determine and it could save a lot
> > of work.  However, given we're at v8 on this patchset I'm sure I'm
> > missing something obvious, can you help me understand why the idea
> > above is crazy stupid? ;)
>
> Ok, I looked back at what I did for v3.
>
> Moving from v3 to v4, I decided to put less burden on LSMs, and to make
> all the processing from the LSM infrastructure side.

As a general rule I think it's a good goal to keep the LSM layer as
small as possible; I believe it allows us to be more flexible with the
LSMs and it keeps the LSM as simple as possible.  I mean less code,
less bugs, amirite? ... ;)

> v3 had some safeguards to prevent some programming mistakes by LSMs,
> which maybe made the code less understandable.
>
> However, if we say we keep things as simple as possible and assume that
> LSMs implement this correctly, we can just pass num_filled_xattrs to
> them and they simply increment it.
>
> The EVM bug should not arise (accessing xattr->name =3D NULL), even if
> BPF LSM alone returns zero, due to the check of num_filled_xattrs
> before calling evm_inode_init_security().
>
> Patch 6 (at the end) will prevent the bug from arising when EVM is
> moved to the LSM infrastructure (no num_filled_xattrs check anymore).
> There is a loop that stops if xattr->name is NULL, so
> evm_protected_xattr() will not be called.
>
> Or, like you suggested, we just return a positive value from LSMs and
> we keep num_filled_xattrs in security_inode_init_security().

I like the idea of individual LSMs simply reporting the number of
xattrs they've generated instead of incrementing the num_filled_xattrs
variable.

It seems like returning the xattr count as a positive return value
should work just fine, leaving negative values for errors, but if you
run into problems you can always pass the value back in a new
parameter pointer if needed.

> > > @@ -2868,11 +2870,11 @@ static int selinux_dentry_create_files_as(str=
uct dentry *dentry, int mode,
> > >
> > >  static int selinux_inode_init_security(struct inode *inode, struct i=
node *dir,
> > >                                        const struct qstr *qstr,
> > > -                                      const char **name,
> > > -                                      void **value, size_t *len)
> > > +                                      struct xattr *xattrs)
> > >  {
> > >         const struct task_security_struct *tsec =3D selinux_cred(curr=
ent_cred());
> > >         struct superblock_security_struct *sbsec;
> > > +       struct xattr *xattr =3D NULL;
> > >         u32 newsid, clen;
> > >         int rc;
> > >         char *context;
> > > @@ -2899,16 +2901,18 @@ static int selinux_inode_init_security(struct=
 inode *inode, struct inode *dir,
> > >             !(sbsec->flags & SBLABEL_MNT))
> > >                 return -EOPNOTSUPP;
> > >
> > > -       if (name)
> > > -               *name =3D XATTR_SELINUX_SUFFIX;
> > > +       if (xattrs)
> > > +               xattr =3D xattrs + selinux_blob_sizes.lbs_xattr;
> >
> > Please abstract that away to an inline function similar to
> > selinux_cred(), selinux_file(), selinux_inode(), etc.
>
> Ok.
>
> > > +       if (xattr) {
> > > +               xattr->name =3D XATTR_SELINUX_SUFFIX;
> >
> > I'm guessing the xattr->name assignment is always done, regardless of
> > if security_sid_to_context_force() is successful, due to the -EINVAL
> > check in security_check_compact_filled_xattrs()?  If yes, it would be
> > good to make note of that here in the code.  If not, it would be nice
> > to move this down the function to go with the other xattr->XXX
> > assignments, unless there is another reason for its placement that I'm
> > missing.
>
> Uhm, if an LSM returns an error, security_inode_init_security() stops
> and does the cleanup. It should not matter if xattr->name was set.

Okay, I thought I might be missing something during the review.  Since
there is no special reason for putting the xattr->name assignment up
there, please move it down below with the other xattr->XXX
assignments.

Thanks.

--=20
paul-moore.com
