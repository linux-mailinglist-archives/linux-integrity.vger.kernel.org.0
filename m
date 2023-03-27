Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBD76CB045
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Mar 2023 23:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbjC0VCc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Mar 2023 17:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbjC0VCb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Mar 2023 17:02:31 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC8E268F
        for <linux-integrity@vger.kernel.org>; Mon, 27 Mar 2023 14:02:26 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id k17so12439661ybm.11
        for <linux-integrity@vger.kernel.org>; Mon, 27 Mar 2023 14:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1679950946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V8Lpq/UbJ1ygpO1HHcARIWDPnYOuUleqfSbW7Q7sAPY=;
        b=gjjdcQ2QHVqP2JRZSDuZu17R+oXqD/Gq/eRjiCgQYnbsoNY+V6MADk1PJHUhL7Ipjr
         pDjRs8x8lvNVu00Rf2S5UDtgRKWi5McaJtEypQvQDu2if9mCPAptSx4gtDKSCH08U2Uk
         L9ajVhJy4VFFG7FuUDf3oqEmIvkyYi5Zf+c0y/XQCd7QcPj2Ww4674Q3QdK2JL9seFRR
         FT2dubkTjDRG8l6IDu7peR8Aei+zaghUoMzW+zRUwbuJT0baPKfj1QxDGRFuiPZs4+NL
         VIyAsux8Fi5rEyvP6XtyteyeRCappD/NGsZxFFYjWBOg37/ZGILREIy/zYfZUQMuU0zG
         lEvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679950946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V8Lpq/UbJ1ygpO1HHcARIWDPnYOuUleqfSbW7Q7sAPY=;
        b=e3jq5j0i0aR65Wh/788uwGAvOJncO4xTuBFLED5EvlnNNp49crOC4wOZiJER4TmovM
         JqWDsgnLOygfZId2LfyGJ8Urt9RzBrnWy/mEqI3H5UJm5h3vqPPWI9c6vDh+lGocyI+w
         p8A/TSe0ruNpg9wqwff5hwdNUhaYNVCzNC6w8cFBt1OYPx/PHdU3Agd/vKEXW0X4Oy/w
         0STjXAeu8jeaQ0uh3ETFoGCgj6ImZaLK6BuRHPERBEt6phvQZOZE+Xex6HtHfO6lVQIW
         mBkkqVFp9EKepJ/Ukkuaioa1eRYtmGRnKTlVmENu0N0+zQa409NFTLbKCIviuaSBc4aM
         Xb1w==
X-Gm-Message-State: AAQBX9cacef2RDrkKvwi1W323aXYzC7MGg+r8i4SPO8Spzur36YTYDg/
        LTuPAVc1TxI3FuXPlORgQFlBZrVcjZdeGxx5qVl3
X-Google-Smtp-Source: AKy350YdK0J3ku8LmoHbsw6+4LanRNbdqmYmR5Yex6BIDShq+qo6eRPePEu6PMnGVU4QITpQqvLgeH05fz+qZhaH6Ro=
X-Received: by 2002:a25:db91:0:b0:b75:8ac3:d5d9 with SMTP id
 g139-20020a25db91000000b00b758ac3d5d9mr8054247ybf.3.1679950945806; Mon, 27
 Mar 2023 14:02:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230314081720.4158676-1-roberto.sassu@huaweicloud.com>
 <20230314081720.4158676-5-roberto.sassu@huaweicloud.com> <CAHC9VhTD3EyDiJs9+NQrgp84JcUs_sx8WONtRk2YYH4m1C8nVw@mail.gmail.com>
 <939e6c88662ad90b963993c4cc1b702083e74a7a.camel@huaweicloud.com>
 <ffc86b3907f7b87d3c568ae62bea3cdb3275be4e.camel@huaweicloud.com>
 <CAHC9VhRNjvjMOF5KLM6BoGfk=QpEBs_ur_CgRdGL5R1bA-JAwg@mail.gmail.com> <8b63d00d8ac3f686e51889ea4fc8d83f8ecb300d.camel@huaweicloud.com>
In-Reply-To: <8b63d00d8ac3f686e51889ea4fc8d83f8ecb300d.camel@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 27 Mar 2023 17:02:14 -0400
Message-ID: <CAHC9VhRaKtsM=CuNhDy0Kx0NGSUrVhG+MhwKnHiyJxfgUwx7nA@mail.gmail.com>
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

On Mon, Mar 27, 2023 at 3:30=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> On Fri, 2023-03-24 at 17:39 -0400, Paul Moore wrote:
> > On Fri, Mar 24, 2023 at 9:26=E2=80=AFAM Roberto Sassu
> > <roberto.sassu@huaweicloud.com> wrote:
> > > On Fri, 2023-03-24 at 11:18 +0100, Roberto Sassu wrote:
> > > > On Thu, 2023-03-23 at 20:09 -0400, Paul Moore wrote:
> > > > > On Tue, Mar 14, 2023 at 4:19=E2=80=AFAM Roberto Sassu
> > > > > <roberto.sassu@huaweicloud.com> wrote:
> > > > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > > > >
> > > > > > Currently, security_inode_init_security() supports only one LSM=
 providing
> > > > > > an xattr and EVM calculating the HMAC on that xattr, plus other=
 inode
> > > > > > metadata.
> > > > > >
> > > > > > Allow all LSMs to provide one or multiple xattrs, by extending =
the security
> > > > > > blob reservation mechanism. Introduce the new lbs_xattr field o=
f the
> > > > > > lsm_blob_sizes structure, so that each LSM can specify how many=
 xattrs it
> > > > > > needs, and the LSM infrastructure knows how many xattr slots it=
 should
> > > > > > allocate.
> > > > > >
> > > > > > Dynamically allocate the xattrs array to be populated by LSMs w=
ith the
> > > > > > inode_init_security hook, and pass it to the latter instead of =
the
> > > > > > name/value/len triple. Update the documentation accordingly, an=
d fix the
> > > > > > description of the xattr name, as it is not allocated anymore.
> > > > > >
> > > > > > Since the LSM infrastructure, at initialization time, updates t=
he number of
> > > > > > the requested xattrs provided by each LSM with a corresponding =
offset in
> > > > > > the security blob (in this case the xattr array), it makes stra=
ightforward
> > > > > > for an LSM to access the right position in the xattr array.
> > > > > >
> > > > > > There is still the issue that an LSM might not fill the xattr, =
even if it
> > > > > > requests it (legitimate case, for example it might have been lo=
aded but not
> > > > > > initialized with a policy). Since users of the xattr array (e.g=
. the
> > > > > > initxattrs() callbacks) detect the end of the xattr array by ch=
ecking if
> > > > > > the xattr name is NULL, not filling an xattr would cause those =
users to
> > > > > > stop scanning xattrs prematurely.
> > > > > >
> > > > > > Solve that issue by introducing security_check_compact_filled_x=
attrs(),
> > > > > > which does a basic check of the xattr array (if the xattr name =
is filled,
> > > > > > the xattr value should be too, and viceversa), and compacts the=
 xattr array
> > > > > > by removing the holes.
> > > > > >
> > > > > > An alternative solution would be to let users of the xattr arra=
y know the
> > > > > > number of elements of that array, so that they don't have to ch=
eck the
> > > > > > termination. However, this seems more invasive, compared to a s=
imple move
> > > > > > of few array elements.
> > > > > >
> > > > > > security_check_compact_filled_xattrs() also determines how many=
 xattrs in
> > > > > > the xattr array have been filled. If there is none, skip
> > > > > > evm_inode_init_security() and initxattrs(). Skipping the former=
 also avoids
> > > > > > EVM to crash the kernel, as it is expecting a filled xattr.
> > > > > >
> > > > > > Finally, adapt both SELinux and Smack to use the new definition=
 of the
> > > > > > inode_init_security hook, and to correctly fill the designated =
slots in the
> > > > > > xattr array. For Smack, reserve space for the other defined xat=
trs although
> > > > > > they are not set yet in smack_inode_init_security().
> > > > > >
> > > > > > Reported-by: Nicolas Bouchinet <nicolas.bouchinet@clip-os.org> =
(EVM crash)
> > > > > > Link: https://lore.kernel.org/linux-integrity/Y1FTSIo+1x+4X0LS@=
archlinux/
> > > > > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > > > > Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> > > > > > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > > > > > ---
> > > > > >  include/linux/lsm_hook_defs.h |   3 +-
> > > > > >  include/linux/lsm_hooks.h     |   1 +
> > > > > >  security/security.c           | 119 ++++++++++++++++++++++++++=
+++-----
> > > > > >  security/selinux/hooks.c      |  19 ++++--
> > > > > >  security/smack/smack_lsm.c    |  33 ++++++----
> > > > > >  5 files changed, 137 insertions(+), 38 deletions(-)
> >
> > ...
> >
> > > > > > @@ -1604,33 +1654,66 @@ int security_inode_init_security(struct=
 inode *inode, struct inode *dir,
> > > > > >                                  const struct qstr *qstr,
> > > > > >                                  const initxattrs initxattrs, v=
oid *fs_data)
> > > > > >  {
> > > > > > -       struct xattr new_xattrs[MAX_LSM_EVM_XATTR + 1];
> > > > > > -       struct xattr *lsm_xattr, *evm_xattr, *xattr;
> > > > > > -       int ret;
> > > > > > +       struct security_hook_list *P;
> > > > > > +       struct xattr *new_xattrs;
> > > > > > +       struct xattr *xattr;
> > > > > > +       int ret =3D -EOPNOTSUPP, num_filled_xattrs =3D 0;
> > > > > >
> > > > > >         if (unlikely(IS_PRIVATE(inode)))
> > > > > >                 return 0;
> > > > > >
> > > > > > +       if (!blob_sizes.lbs_xattr)
> > > > > > +               return 0;
> > > > > > +
> > > > > >         if (!initxattrs)
> > > > > >                 return call_int_hook(inode_init_security, -EOPN=
OTSUPP, inode,
> > > > > > -                                    dir, qstr, NULL, NULL, NUL=
L);
> > > > > > -       memset(new_xattrs, 0, sizeof(new_xattrs));
> > > > > > -       lsm_xattr =3D new_xattrs;
> > > > > > -       ret =3D call_int_hook(inode_init_security, -EOPNOTSUPP,=
 inode, dir, qstr,
> > > > > > -                           &lsm_xattr->name,
> > > > > > -                           &lsm_xattr->value,
> > > > > > -                           &lsm_xattr->value_len);
> > > > > > -       if (ret)
> > > > > > +                                   dir, qstr, NULL);
> > > > > > +       /* Allocate +1 for EVM and +1 as terminator. */
> > > > > > +       new_xattrs =3D kcalloc(blob_sizes.lbs_xattr + 2, sizeof=
(*new_xattrs),
> > > > > > +                            GFP_NOFS);
> > > > > > +       if (!new_xattrs)
> > > > > > +               return -ENOMEM;
> > > > > > +
> > > > > > +       hlist_for_each_entry(P, &security_hook_heads.inode_init=
_security,
> > > > > > +                            list) {
> > > > > > +               ret =3D P->hook.inode_init_security(inode, dir,=
 qstr, new_xattrs);
> > > > > > +               if (ret && ret !=3D -EOPNOTSUPP)
> > > > > > +                       goto out;
> > > > > > +               /*
> > > > > > +                * As documented in lsm_hooks.h, -EOPNOTSUPP in=
 this context
> > > > > > +                * means that the LSM is not willing to provide=
 an xattr, not
> > > > > > +                * that it wants to signal an error. Thus, cont=
inue to invoke
> > > > > > +                * the remaining LSMs.
> > > > > > +                */
> > > > > > +               if (ret =3D=3D -EOPNOTSUPP)
> > > > > > +                       continue;
> > > > > > +               /*
> > > > > > +                * As the number of xattrs reserved by LSMs is =
not directly
> > > > > > +                * available, directly use the total number blo=
b_sizes.lbs_xattr
> > > > > > +                * to keep the code simple, while being not the=
 most efficient
> > > > > > +                * way.
> > > > > > +                */
> > > > >
> > > > > Is there a good reason why the LSM can't return the number of xat=
trs
> > > > > it is adding to the xattr array?  It seems like it should be fair=
ly
> > > > > trivial for the individual LSMs to determine and it could save a =
lot
> > > > > of work.  However, given we're at v8 on this patchset I'm sure I'=
m
> > > > > missing something obvious, can you help me understand why the ide=
a
> > > > > above is crazy stupid? ;)
> > >
> > > Much simple answer. Yes, LSMs could return the number of xattrs set,
> > > but security_check_compact_filled_xattrs() also needs to know from
> > > which offset (the lbs_xattr of each LSM) it should start compacting.
> > >
> > > Example: suppose that you have three LSMs with:
> > >
> > > LSM#1: lbs_xattr 1
> > > LSM#2: lbs_xattr 2 (disabled)
> > > LSM#3: lbs_xattr 1
> > >
> > > The current compaction interval is: already compacted xattrs - end of
> > > new_xattr array.
> > >
> > > When the security_inode_init_security() loop calls LSM#3, the
> > > compaction interval is: 1 - 2 (LSM#2 returns 0), which clearly isn't
> > > right. The correct compaction interval should be: 3 - 4.
> > >
> > > Going to the end of new_xattrs is an approximation, but it ensures
> > > that security_check_compact_filled_xattrs() reaches the xattr set by
> > > LSM#3.
> > >
> > > The alternative I was mentioning of passing num_filled_xattrs to LSMs
> > > goes again in the direction of doing on-the-fly compaction, while LSM=
s
> > > are more familiar with using the lbs_* fields.
> >
> > I guess I was thinking of the case where the LSM layer, i.e.
> > security_inode_init_security(), allocates an xattr array like it does
> > now based on the maximum number of xattrs possible using the
> > lsm_blob_sizes values and passes a pointer to the individual LSMs
> > which is incremented based on how many xattrs are created by the
> > individual LSMs.  Here is some *very* rough pseudo code:
> >
> > int security_inode_init_security(...)
> > {
> >
> >   /* allocate an xattr array */
> >   xattrs =3D kcalloc(blob_sizes, sizeof(*xattrs), GFP_BLAH);
> >
> >   /* loop on the lsms */
> >   xa_cnt =3D 0;
> >   while (lsm_hooks) {
> >     rc =3D call_hook(lsm_hook, &xattrs[xa_cnt]);
> >     if (rc > 0)
> >       xa_cnt +=3D rc;
> >   }
> >
> >   /* evm magic */
> >   evm_inode_init_security(...)
> > }
> >
> > Does that work?  Am I missing something?
>
> Oh, unfortunately not. EVM needs to see all xattrs (when it is moved to
> the LSM infrastructure).

Okay, that's fair, but we could still pass the full xattrs array and a
reference to the current count which could be both read and updated by
the individual LSMs, right?

The issue is that the separate compaction stage is not something we
want to have to do if we can avoid it.  Maybe we're stuck with it, but
I'm not yet convinced that we can't make some minor changes to the
LSMs to avoid the compaction step.

--=20
paul-moore.com
