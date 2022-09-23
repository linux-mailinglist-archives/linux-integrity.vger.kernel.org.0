Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293315E80C9
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Sep 2022 19:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbiIWRfX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 23 Sep 2022 13:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbiIWRfV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 23 Sep 2022 13:35:21 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9F3E10AD
        for <linux-integrity@vger.kernel.org>; Fri, 23 Sep 2022 10:35:20 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-127ba06d03fso1232477fac.3
        for <linux-integrity@vger.kernel.org>; Fri, 23 Sep 2022 10:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=0AevkT37/WKGCdruw5s43CVba51BXF1Pz6fyi3ihIHI=;
        b=oiSss/iMctFrMaY1tzmj3lWm6se7e3A8tKVZegNbJZ73/VCdICqga8Rpu3n28djpYs
         ML4Bkw8yL28Mup66Q4wvqV+OM9EkY6OrIIGqvnASd0Hm1pNcKQWXcjHa9UF3WzSlCF1U
         MS5mA8F6tSMBEeELLHC7mG2/73EsJRYV3zzCJkdW6pNKeXD76TOwsKr7aorqIdGgFuHq
         t6w2Ypl56kOWrl5NnVO6evSpfYtPyH01bOSZtcXF+e/ZOipvKc9ufXIyXM/WJYHDQHKK
         AddeYHLZC8LOjCFFITnxzukUmN3xJZmBQRDfIL7ndtuWgcwy2Zh7pVc+2h2SUoLHwU1l
         Q4jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=0AevkT37/WKGCdruw5s43CVba51BXF1Pz6fyi3ihIHI=;
        b=3wb83+75gFClAouM3pGR7S4UmE9brpUtM8dgpi+IIH9caLYcpmfOniHKVBM/FHJekI
         2doip3kJi4kY7rHh39CIARbcZb4zfloM/dKHzIHjPk1nVIh6ytfM1V4R7mMGxlIkrvni
         2XCAKGDFofxsCkKZ0yPwJlK1atofRfZEVvIr2WqRJC9HCg50yv9CLdBlQBYEujhu7G/w
         fKBui6jG+LbyUuRKerXhO0F1JTccB7ss3cjF02hpXn+kymhO7y2uZvbgdgQ+Ot7cbXvt
         gI8MfNVPs1YN1SKe6GxBY5K6iZmUHWFX4xIHKKCqL+2Sp1bhGFWDuVQev2tZJ3DkTTFh
         Ygow==
X-Gm-Message-State: ACrzQf0s99oQqnWfSNuF2nRQRMRoFRQ7oLxxWChrcSBdroq064mNYL4g
        Jmf2HO4JLoZL6Tu+nMFMKqbPROrx2EF5Rk/GreEf
X-Google-Smtp-Source: AMsMyM7v80CDou94dOksLbioCL+Ac/R5MPMRH6V7MWbGz2mfDrtvQ6XoZxgz0G4THyESrajI65dzxGhgSEqun8bKnEE=
X-Received: by 2002:a05:6870:15c9:b0:101:e18b:d12d with SMTP id
 k9-20020a05687015c900b00101e18bd12dmr12089334oad.51.1663954519817; Fri, 23
 Sep 2022 10:35:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220922151728.1557914-1-brauner@kernel.org> <20220922151728.1557914-11-brauner@kernel.org>
 <CAHC9VhS7gEbngqYPMya52EMS5iZYQ_7pPgQiEfRqwPCgzhDbwA@mail.gmail.com>
 <20220923064707.GD16489@lst.de> <20220923075752.nmloqf2aj5yhoe34@wittgenstein>
 <CAHC9VhS3NWfMk3uHxZSZMtDay4FqOYzTf9mKCy1=Rb22r-2P4A@mail.gmail.com> <20220923143540.howryhuygxi2hsj3@wittgenstein>
In-Reply-To: <20220923143540.howryhuygxi2hsj3@wittgenstein>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 23 Sep 2022 13:35:08 -0400
Message-ID: <CAHC9VhRZf+OAzc96=c2s3NqkizNh2tZbLF8OFPHbFFuFXEZ8sA@mail.gmail.com>
Subject: Re: [PATCH 10/29] selinux: implement set acl hook
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        Seth Forshee <sforshee@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-integrity@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Sep 23, 2022 at 10:35 AM Christian Brauner <brauner@kernel.org> wrote:
> On Fri, Sep 23, 2022 at 10:26:35AM -0400, Paul Moore wrote:
> > On Fri, Sep 23, 2022 at 3:57 AM Christian Brauner <brauner@kernel.org> wrote:
> > > On Fri, Sep 23, 2022 at 08:47:07AM +0200, Christoph Hellwig wrote:
> > > > On Thu, Sep 22, 2022 at 01:16:57PM -0400, Paul Moore wrote:
> > > > > properly review the changes, but one thing immediately jumped out at
> > > > > me when looking at this: why is the LSM hook
> > > > > "security_inode_set_acl()" when we are passing a dentry instead of an
> > > > > inode?  We don't have a lot of them, but there are
> > > > > `security_dentry_*()` LSM hooks in the existing kernel code.
> > > >
> > > > I'm no LSM expert, but isn't the inode vs dentry for if it is
> > > > related to an inode operation or dentry operation, not about that
> > > > the first argument is?
> > >
> > > Indeed. For example ...
> >
> > If the goal is for this LSM hook to operate on an inode and not a
> > dentry, let's pass it an inode instead.  This should help prevent
>
> I would be ok with that but EVM requires a dentry being passed and as
> evm is called from security_inode_set_acl() exactly like it is from
> security_inode_setxattr() and similar the hook has to take a dentry.

If a dentry is truly needed by EVM (a quick look indicates that it may
just be for the VFS getxattr API, but I haven't traced the full code
path), then I'm having a hard time reconciling that this isn't a
dentry operation.  Yes, I get that the ACLs belong to the inode and
not the dentry, but then why do we need the dentry?  It seems like the
interfaces are broken slightly, or at least a little odd ... <shrug>

> And I want to minimize - ideally get rid of at some point - separate
> calls to security_*() and evm_*() or ima_() in the vfs. So the evm hook
> should please stay in there.

For the record, I want to get rid of the IMA and EVM specific hooks in
the kernel.  They were a necessity back when there could only be one
LSM active at a given time, but with that no longer the case I see
little reason why IMA/EVM/etc. remain separate; it makes the code
worse and complicates a lot of things both at the LSM layer as well as
the rest of the kernel.  I've mentioned this to a few people,
including Mimi, and it came up during at talk at LPC this year.

-- 
paul-moore.com
