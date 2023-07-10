Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD9974DD0A
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Jul 2023 20:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjGJSFM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 10 Jul 2023 14:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbjGJSFM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Jul 2023 14:05:12 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DB1128
        for <linux-integrity@vger.kernel.org>; Mon, 10 Jul 2023 11:05:09 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-579dfae6855so60538477b3.1
        for <linux-integrity@vger.kernel.org>; Mon, 10 Jul 2023 11:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689012309; x=1691604309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EB5CFdTYWApS8YMHOsiv0TiQQf51kpScKMC8hHDqG8g=;
        b=PRUSckhb2w2tvQVVqKRnAyFmh/xH4DVarLn2tfQUHuZsRmlUdlaoZS4tZ/DtqvuCcC
         vw7wH9gSaid4XnJN8d0feAmFI+jdpMwX19vdHLHSWTT/aaIB+ces3ILY4kHUkuLjXoHQ
         CmEpOHNRRSFnNjUm0goZkW6P579aehUi1pSQtU87E+sxiJeekPKGmihjBe2w1IN/vS5h
         SSeoBmil9Z+t5D3S1+K20tHmPDDQdCz0gPzjlQBkR3Kw6vrkkebxGQd93XdCw+eVSM5A
         bv/ahQVscDhIR+kBLYh6Q/z5/MEcwbba/IK44dTuptfxx2eLDdO7uulqpaNx7DtWj5qb
         B3ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689012309; x=1691604309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EB5CFdTYWApS8YMHOsiv0TiQQf51kpScKMC8hHDqG8g=;
        b=ifl3HdDvT5KxLHjh+YAgHtVOjCmCWGQSnK60XGHMHl2aRc3n9JTyNE6lDBkizWBldc
         YVZj//+nnl1/WRxZpZzpmR7UrJQ2/WQDkIvM9XH106+y4o/PPaapSspllhbbW8sq0sSE
         LGwVPmcwqR1yN472NSSQBzrwaMMiGJPuaFnDikspZSQ085LCQqmTu7Yp3uIt+daFRZ1A
         rqEIMAFCQjEsVSEaE5z1GQ0PJ2kEnHQRbiMNrCo1FsPFe4XkuzQ/YsOh6cWfofXa7TtQ
         1B1fJT8nQVj1bejOKnGGNnzeL1M+mx0+eIrY2JDv9KKuD6ZNP/mgE3+uliV2FpqzBhwm
         sXTg==
X-Gm-Message-State: ABy/qLbnbTZe59v+b1Vr4qp2BfIrDv9As7mJ112bCQRMdi2+qzb3LKWY
        u2QNIsx9zMchJz/Jh6FWl1mgRo9dien9f6Jc5AZm
X-Google-Smtp-Source: APBJJlEXMnAXAqgSe2gS4I8jMdsUlxV2m1S0LePICnU+VtDinyOkis46Y0X2+XrvApiiB580t/Us4PR4QCI8RZeUqGA=
X-Received: by 2002:a0d:cc47:0:b0:577:a46:26e5 with SMTP id
 o68-20020a0dcc47000000b005770a4626e5mr12504009ywd.31.1689012309085; Mon, 10
 Jul 2023 11:05:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230610075738.3273764-2-roberto.sassu@huaweicloud.com>
 <1c8c612d99e202a61e6a6ecf50d4cace.paul@paul-moore.com> <a28c8fce-741b-e088-af5e-8a83daa7e25d@schaufler-ca.com>
 <CAHC9VhSNqzVpHcDw59a2CznaME1078SJWuEcqJx=R5PQgSjTDg@mail.gmail.com>
In-Reply-To: <CAHC9VhSNqzVpHcDw59a2CznaME1078SJWuEcqJx=R5PQgSjTDg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 10 Jul 2023 14:04:58 -0400
Message-ID: <CAHC9VhSFy6wf+7DXrG=6CXZC4RrpTeP2sQezX0BPc95fxGAWxQ@mail.gmail.com>
Subject: Re: [PATCH v12 1/4] security: Allow all LSMs to provide xattrs for
 inode_init_security hook
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        bpf@vger.kernel.org, kpsingh@kernel.org, keescook@chromium.org,
        nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jul 7, 2023 at 5:44=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
> On Fri, Jul 7, 2023 at 12:54=E2=80=AFPM Casey Schaufler <casey@schaufler-=
ca.com> wrote:
> > On 7/6/2023 6:43 PM, Paul Moore wrote:
> > > On Jun 10, 2023 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> > >> Currently, the LSM infrastructure supports only one LSM providing an=
 xattr
> > >> and EVM calculating the HMAC on that xattr, plus other inode metadat=
a.
> > >>
> > >> Allow all LSMs to provide one or multiple xattrs, by extending the s=
ecurity
> > >> blob reservation mechanism. Introduce the new lbs_xattr_count field =
of the
> > >> lsm_blob_sizes structure, so that each LSM can specify how many xatt=
rs it
> > >> needs, and the LSM infrastructure knows how many xattr slots it shou=
ld
> > >> allocate.
> > >>
> > >> Modify the inode_init_security hook definition, by passing the full
> > >> xattr array allocated in security_inode_init_security(), and the cur=
rent
> > >> number of xattr slots in that array filled by LSMs. The first parame=
ter
> > >> would allow EVM to access and calculate the HMAC on xattrs supplied =
by
> > >> other LSMs, the second to not leave gaps in the xattr array, when an=
 LSM
> > >> requested but did not provide xattrs (e.g. if it is not initialized)=
.
> > >>
> > >> Introduce lsm_get_xattr_slot(), which LSMs can call as many times as=
 the
> > >> number specified in the lbs_xattr_count field of the lsm_blob_sizes
> > >> structure. During each call, lsm_get_xattr_slot() increments the num=
ber of
> > >> filled xattrs, so that at the next invocation it returns the next xa=
ttr
> > >> slot to fill.
> > >>
> > >> Cleanup security_inode_init_security(). Unify the !initxattrs and
> > >> initxattrs case by simply not allocating the new_xattrs array in the
> > >> former. Update the documentation to reflect the changes, and fix the
> > >> description of the xattr name, as it is not allocated anymore.
> > >>
> > >> Adapt both SELinux and Smack to use the new definition of the
> > >> inode_init_security hook, and to call lsm_get_xattr_slot() to obtain=
 and
> > >> fill the reserved slots in the xattr array.
> > >>
> > >> Move the xattr->name assignment after the xattr->value one, so that =
it is
> > >> done only in case of successful memory allocation.
> > >>
> > >> Finally, change the default return value of the inode_init_security =
hook
> > >> from zero to -EOPNOTSUPP, so that BPF LSM correctly follows the hook
> > >> conventions.
> > >>
> > >> Reported-by: Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>
> > >> Link: https://lore.kernel.org/linux-integrity/Y1FTSIo+1x+4X0LS@archl=
inux/
> > >> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > >> ---
> > >>  include/linux/lsm_hook_defs.h |  6 +--
> > >>  include/linux/lsm_hooks.h     | 20 ++++++++++
> > >>  security/security.c           | 71 +++++++++++++++++++++++---------=
---
> > >>  security/selinux/hooks.c      | 17 +++++----
> > >>  security/smack/smack_lsm.c    | 25 ++++++------
> > >>  5 files changed, 92 insertions(+), 47 deletions(-)
> > > Two *very* small suggestions below, but I can make those during the
> > > merge if you are okay with that Roberto?
> > >
> > > I'm also going to assume that Casey is okay with the Smack portion of
> > > this patchset?  It looks fine to me, and considering his ACK on the
> > > other Smack patch in this patchset I'm assuming he is okay with this
> > > one as well ... ?
> >
> > Yes, please feel free to add my Acked-by as needed.
>
> Done.  Thanks Casey.

I'm merging the full patchset into lsm/next right now.  Thanks for all
your work on this Roberto, and a thank you for everyone else who
helped with reviews, testing, etc.

--=20
paul-moore.com
