Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F40D520FE3
	for <lists+linux-integrity@lfdr.de>; Tue, 10 May 2022 10:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238147AbiEJIrY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 May 2022 04:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbiEJIrW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 May 2022 04:47:22 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E482A2F65;
        Tue, 10 May 2022 01:43:25 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id js14so12163205qvb.12;
        Tue, 10 May 2022 01:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WrMoJrxrZGg5PVkbTdEvYJDSvLwXAN41Hn/TLknZuGE=;
        b=J2x+ncNkddklUrmeq5tRp8U99jTNUPrG3A/KrP2Pz6lNbj24D0eaDOUqpYMIrBAJYF
         KJjr/85bxa7w4f6dYtnPmHGCXjVmevEtrn174z28RYmA0kD9byvcirj72UcdXA2+2f5A
         VIYXnsyklWx6D/43iYqGf78T0L7IGOo/2tcXvkCNkBoYylIqv6xIPnLXB/TcwyuHfe/8
         0++nI8eUIWLgy00E7bxlz93Tm8kaceu162c1Kf/0kwuX+0Du4vK13kQns6+Hcc3Ppx3i
         SJDstXgFYedwOB5TW6FCsZLaYePcn5qWdE8YR0f68dhafqVU8aTPRflNCQcifoX7KyXu
         VnOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WrMoJrxrZGg5PVkbTdEvYJDSvLwXAN41Hn/TLknZuGE=;
        b=Gc0g26z+aboW58atXWm3gwSOZ+8/Vo5Q4rOXC5LH+Es1onfSsuz1nc+8MBNVxJp18Z
         LflMTO3/GB50YgumCQoM+4+rxMjRRmH4PJk8YPweX7oa3IS4k27DIA2NBAJ47hcvXjvt
         7OJRxs+UD+CmeDbIwj0C96x7nlVkb0Epi+EVYGg2VwQgdJu7g8AHp5gSDO3V0BC13+eH
         drIbJpvRNWA18fVOpi5po9Ljmwx2jX0sqyG3Y430jC18UmCvScasXsr7oXNxTeOdfu2B
         spd/HkcLfEnirNN4KajoxuFaaygqQ4O9RXBUBs8ph1PA3fV3ktF6nLGtvB59T6uH8BQr
         HxyQ==
X-Gm-Message-State: AOAM530NhCrMWQ+1evVhzcTwdjXlbwzIC1f+DNPEgDKiPdTIHirt6cRN
        FUFoTTeOGH7sTh2+01GhO1Di8MRE4L09MDw5f94=
X-Google-Smtp-Source: ABdhPJzw1Y/hADhN41+rKcIlTCGO2xFVafAE6uGJ9MUNUIJP3eNBU/jfOI+lt7oQhFLgZN4W6qMd15vCMKLp44u9rQg=
X-Received: by 2002:a05:6214:2409:b0:432:bf34:362f with SMTP id
 fv9-20020a056214240900b00432bf34362fmr16976378qvb.66.1652172204571; Tue, 10
 May 2022 01:43:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220420140633.753772-1-stefanb@linux.ibm.com>
 <20220420140633.753772-2-stefanb@linux.ibm.com> <20220509195414.GA30894@mail.hallyn.com>
 <20220509203618.GA31408@mail.hallyn.com>
In-Reply-To: <20220509203618.GA31408@mail.hallyn.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 10 May 2022 11:43:13 +0300
Message-ID: <CAOQ4uxjJJVRHrsiOqFokR=zFCV46U+tZJJ74cn9vriucbCHRkA@mail.gmail.com>
Subject: Re: [PATCH v12 01/26] securityfs: rework dentry creation
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        containers@lists.linux.dev,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>, jpenumak@redhat.com,
        Christian Brauner <brauner@kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Micah Morton <mortonm@chromium.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Jarkko Sakkinen <jarkko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, May 9, 2022 at 11:36 PM Serge E. Hallyn <serge@hallyn.com> wrote:
>
> On Mon, May 09, 2022 at 02:54:14PM -0500, Serge E. Hallyn wrote:
> > On Wed, Apr 20, 2022 at 10:06:08AM -0400, Stefan Berger wrote:
> > > From: Christian Brauner <brauner@kernel.org>
> > >
> > > When securityfs creates a new file or directory via
> > > securityfs_create_dentry() it will take an additional reference on the
> > > newly created dentry after it has attached the new inode to the new
> > > dentry and added it to the hashqueues.
> > > If we contrast this with debugfs which has the same underlying logic as
> > > securityfs. It uses a similar pairing as securityfs. Where securityfs
> > > has the securityfs_create_dentry() and securityfs_remove() pairing,
> > > debugfs has the __debugfs_create_file() and debugfs_remove() pairing.
> > >
> > > In contrast to securityfs, debugfs doesn't take an additional reference
> > > on the newly created dentry in __debugfs_create_file() which would need
> > > to be put in debugfs_remove().
> > >
> > > The additional dget() isn't a problem per se. In the current
> > > implementation of securityfs each created dentry pins the filesystem via
> >
> > Is 'via' an extra word here or is there a missing word?
> >
> > I'll delay the rest of my response as the missing word may answer my
> > remaining question :)
> >
> > > until it is removed. Since it is virtually guaranteed that there is at
> > > least one user of securityfs that has created dentries the initial
> > > securityfs mount cannot go away until all dentries have been removed.
> > >
> > > Since most of the users of the initial securityfs mount don't go away
> > > until the system is shutdown the initial securityfs won't go away when
> > > unmounted. Instead a mount will usually surface the same superblock as
> > > before. The additional dget() doesn't matter in this scenario since it
> > > is required that all dentries have been cleaned up by the respective
> > > users before the superblock can be destroyed, i.e. superblock shutdown
> > > is tied to the lifetime of the associated dentries.
> > >
> > > However, in order to support ima namespaces we need to extend securityfs
> > > to support being mounted outside of the initial user namespace. For
> > > namespaced users the pinning logic doesn't make sense. Whereas in the
> > > initial namespace the securityfs instance and the associated data
> > > structures of its users can't go away for reason explained earlier users
> > > of non-initial securityfs instances do go away when the last users of
> > > the namespace are gone.
> > >
> > > So for those users we neither want to duplicate the pinning logic nor
> > > make the global securityfs instance display different information based
> > > on the namespace. Both options would be really messy and hacky.
> > >
> > > Instead we will simply give each namespace its own securityfs instance
> > > similar to how each ipc namespace has its own mqueue instance and all
> > > entries in there are cleaned up on umount or when the last user of the
> > > associated namespace is gone.
> > >
> > > This means that the superblock's lifetime isn't tied to the dentries.
> > > Instead the last umount, without any fds kept open, will trigger a clean
> > > shutdown. But now the additional dget() gets in the way. Instead of
> > > being able to rely on the generic superblock shutdown logic we would
> > > need to drop the additional dentry reference during superblock shutdown
> > > for all associated users. That would force the use of a generic
> > > coordination mechanism for current and future users of securityfs which
> > > is unnecessary. Simply remove the additional dget() in
> > > securityfs_dentry_create().
> > >
> > > In securityfs_remove() we will call dget() to take an additional
> > > reference on the dentry about to be removed. After simple_unlink() or
> > > simple_rmdir() have dropped the dentry refcount we can call d_delete()
> > > which will either turn the dentry into negative dentry if our earlier
> > > dget() is the only reference to the dentry, i.e. it has no other users,
> > > or remove it from the hashqueues in case there are additional users.
> > >

The first case (turn negative) cannot happen because the function is
entered with at least 1 refcount and increments it by 1.
So you can follow commit 46c46f8df9aa ("devpts_pty_kill(): don't bother
with d_delete()") and use d_drop() instead.

> > > All of these changes should not have any effect on the userspace
> > > semantics of the initial securityfs mount.
> > >
> > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > Cc: John Johansen <john.johansen@canonical.com>
> > > Cc: Matthew Garrett <mjg59@srcf.ucam.org>
> > > Cc: Micah Morton <mortonm@chromium.org>
> > > Cc: Kentaro Takeda <takedakn@nttdata.co.jp>
> > > Cc: James Morris <jmorris@namei.org>
> > > Cc: Jarkko Sakkinen <jarkko@kernel.org>
> > > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > > ---
> > >  security/inode.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/security/inode.c b/security/inode.c
> > > index 6c326939750d..13e6780c4444 100644
> > > --- a/security/inode.c
> > > +++ b/security/inode.c
> > > @@ -159,7 +159,6 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
> > >             inode->i_fop = fops;
> > >     }
> > >     d_instantiate(dentry, inode);
> > > -   dget(dentry);
> > >     inode_unlock(dir);
> > >     return dentry;
> > >
> > > @@ -302,10 +301,12 @@ void securityfs_remove(struct dentry *dentry)
> > >     dir = d_inode(dentry->d_parent);
> > >     inode_lock(dir);
> > >     if (simple_positive(dentry)) {
> > > +           dget(dentry);
> > >             if (d_is_dir(dentry))
> > >                     simple_rmdir(dir, dentry);
>
> Hm, so I realize your patch isn't introducing this, but is the
> fact that we ignore the possible -ENOTEMPTY return value of
> simple_rmdir() not a problem?

As long as we are using debugfs as a reference code, wouldn't
securityfs need to use simple_recursive_removal()?
Can we guaranty that modules always cleanup all entries in
correct order?

>
> > >             else
> > >                     simple_unlink(dir, dentry);
> > > +           d_delete(dentry);
>

d_drop() (see comment above)

> I'm mostly trying to convince myself that the fact that there is not
> a matching dput being removed (to match the dget being removed above)
> is ok.  I do think it is, but that belief seems to dictate that right
> now dentries must never be being released.
>
> Otherwise, it seems like there must be cases where the next dput could
> be called on a dentry that has been freed.
>
> > >             dput(dentry);

Huh? There must be a ref to dentry when entering this function
and there is dget() added above so balance is not lost.

Thanks,
Amir.
