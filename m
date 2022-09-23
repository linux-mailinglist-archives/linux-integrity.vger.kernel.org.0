Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE9F5E7CFB
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Sep 2022 16:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbiIWO1S (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 23 Sep 2022 10:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbiIWO0t (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 23 Sep 2022 10:26:49 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2C913A38C
        for <linux-integrity@vger.kernel.org>; Fri, 23 Sep 2022 07:26:47 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id t62so16568344oie.10
        for <linux-integrity@vger.kernel.org>; Fri, 23 Sep 2022 07:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=hD02gfgJ/qWSS3EkhoA6drXQajCJVbBQ6k/Vx/E2/30=;
        b=GdgV59MmX6vS2XQhzUDNik7edXa5o5JdqAoxYgV5uT9nDpCSzuXJDsSDbSMweJiMFg
         SXHaB94wD0PoSsXXWgeo/PR6vGDM2C+aUyw92yzSA9NqV7oPSCLV9RGfvSdelir1Fvri
         ftuK20KqejohHx+u8NoiLnEthSBXbNHdCBlXR2FTYlZyTgTy5mW3oLVwioIaDnaprhBg
         lKX9E42SiMRrzUfWgW0ectGGftX0gELqdpxNfKxULgFmpDAAxsN/AI6fy/NuGT+zvimr
         Uzsi7bSuBk4ll5AVw0ChXfmA/LMkBYM4CHpPhicNp4Xjwf1T8r98BthgrCaxBoju8nDh
         CPCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=hD02gfgJ/qWSS3EkhoA6drXQajCJVbBQ6k/Vx/E2/30=;
        b=qxSV4DsF1OkxW7D6Iel9pLldICcBvl353Ido4C653bVM8u/1wpUhNfrUb3zBHRZkp9
         rJQvPgnbRIkccUhJpGmnFjVGZKjkxhKXfTEmy7GDq+3ObCalCBppcmg5EinVPvuLGGUh
         r0GkaRPWAtUEmgUAKvD6+9SVt8tXPNOp9CNx1uyxwPbvVq6y+1igzaZaJ/+u6ns1MSH6
         zH8p1OSurf9SAiN0lVx54jnjUVKYdFfBtrzIhZs5+LSrHX0+fePP5oqcLmHg4b8pcMGR
         CRw60tacVIXZrUZ5WQvL50EL3YIMzMmJe5vVUJhrBwxUnh8m0xZDzGnM/TQFMoZJCT/y
         tDmA==
X-Gm-Message-State: ACrzQf3S0bTqLOvbP0vEkl2E2GjCXlfAGt/EyQe+X3dPco8kKpnb5f8x
        Ou1MNZ/l9KVe2jVaD1MgM5vmWTOHnOIy9f/HAFao5c6pqQ==
X-Google-Smtp-Source: AMsMyM4xRXt9QXQbneaCb4NqZTTgEOsPgSrDxYM2+RxUrKP0GrDbLB2HDGYI1LB9nFEPn90dVFI+rFA2FPl6st0ZEA8=
X-Received: by 2002:a05:6808:144b:b0:350:a06a:f8cb with SMTP id
 x11-20020a056808144b00b00350a06af8cbmr9063888oiv.51.1663943206402; Fri, 23
 Sep 2022 07:26:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220922151728.1557914-1-brauner@kernel.org> <20220922151728.1557914-11-brauner@kernel.org>
 <CAHC9VhS7gEbngqYPMya52EMS5iZYQ_7pPgQiEfRqwPCgzhDbwA@mail.gmail.com>
 <20220923064707.GD16489@lst.de> <20220923075752.nmloqf2aj5yhoe34@wittgenstein>
In-Reply-To: <20220923075752.nmloqf2aj5yhoe34@wittgenstein>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 23 Sep 2022 10:26:35 -0400
Message-ID: <CAHC9VhS3NWfMk3uHxZSZMtDay4FqOYzTf9mKCy1=Rb22r-2P4A@mail.gmail.com>
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

On Fri, Sep 23, 2022 at 3:57 AM Christian Brauner <brauner@kernel.org> wrote:
> On Fri, Sep 23, 2022 at 08:47:07AM +0200, Christoph Hellwig wrote:
> > On Thu, Sep 22, 2022 at 01:16:57PM -0400, Paul Moore wrote:
> > > properly review the changes, but one thing immediately jumped out at
> > > me when looking at this: why is the LSM hook
> > > "security_inode_set_acl()" when we are passing a dentry instead of an
> > > inode?  We don't have a lot of them, but there are
> > > `security_dentry_*()` LSM hooks in the existing kernel code.
> >
> > I'm no LSM expert, but isn't the inode vs dentry for if it is
> > related to an inode operation or dentry operation, not about that
> > the first argument is?
>
> Indeed. For example ...

If the goal is for this LSM hook to operate on an inode and not a
dentry, let's pass it an inode instead.  This should help prevent
misuse and I suspect the individual implementations will be quicker
for it anyway (it should be the case for SELinux, and while I'm not a
Smack expert it looks to be true for Smack as well).  There is the
potential for some additional work in the case where the inode needs
to be revalidated (I believe this is only a SELinux issue at the
moment) as well as if an audit event needs to be generated, but these
should both happen infrequently enough that I don't believe they are a
real concern.

-- 
paul-moore.com
