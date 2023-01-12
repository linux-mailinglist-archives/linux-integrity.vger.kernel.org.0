Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42F9667D3E
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Jan 2023 19:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240030AbjALSCC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Jan 2023 13:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232594AbjALSBO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Jan 2023 13:01:14 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C869D13CF4
        for <linux-integrity@vger.kernel.org>; Thu, 12 Jan 2023 09:22:08 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso24339864pjt.0
        for <linux-integrity@vger.kernel.org>; Thu, 12 Jan 2023 09:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0xDr4QknDNxPi2cT8FrUuwNvsQNO379ZboIpi4mwvIk=;
        b=Fiy522RNvvYxq4nWHpNZeEHiH1/P9P8SLmCZIIqj2T5uix0e9SLinDtq8qjCWr3RvO
         M++tjLHwR63OcuftzaEi1ChHQB/nAHWAlphG1r3019blrCX5ANTv/XcoJVZFBBzi6aUe
         MvLJxuqoSKKFHXXwDx19ZDLhPn5pfMZSOuEkIskLBENuvcoYcn3D/7ZnF+V0JdJj2ozl
         w3ZMpd9CGXnSWHPtu6A4IicaLCensH+4iBwQSp85GIynWT/+gTgkDRA2xQ+ry9YEolgp
         /TFO++DWjtppIUWlzcQtHMiWEruGd66Jn+076IgtMtnBQOtWeZNPvs9hxtIGRLFYmktV
         Etnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0xDr4QknDNxPi2cT8FrUuwNvsQNO379ZboIpi4mwvIk=;
        b=62OLgIrOOMwrhk7HyMnSGijhcvBofRST+73i6gKQvJBf0u6Zhta08maDZSAoULJ9Kq
         JC/0DHsvlFugCQZXSNmiHp7Jyx8TOdtXHNlyVrzOFmGTeeshOhW67YtSo9TSq3n78/oN
         UAvbYUhI+5/LCexUeYvssX8JEeeIwwipPSrmik5Ul52KMZWiLRgutkOKlQlIOZ3YE6CF
         3IdZYQq4AAJPsCWRK7iKF14TzfXQHIfP9x2kTju2gXfU81vG4JmS+l4JR9qXKdPwnI01
         vbZ/wOWa2oXT5+9OsdoePAm01NONUYrhdW4YXkiX2VGdBD5XkcsuxpvCbLQs9AdOXj6n
         Pjlg==
X-Gm-Message-State: AFqh2kqTzktbCtIMl30ksCMsSaaY3lRlgf0hQjCNCYj4foUhVRTyE1Kh
        M6bWVSzRQs6y8ZzNLZHx+jDVREfU7137/91EUFCc
X-Google-Smtp-Source: AMrXdXu2M2VDaYhrvTSfy4I4j0IQ3Wj0M50ON3uTCXgABm7WK5YXNWc5b+Li6BFUEvojgI035C9WkWYZx2mqYyqriPo=
X-Received: by 2002:a17:902:cec8:b0:192:6675:8636 with SMTP id
 d8-20020a170902cec800b0019266758636mr4530544plg.15.1673544128229; Thu, 12 Jan
 2023 09:22:08 -0800 (PST)
MIME-Version: 1.0
References: <20221201104125.919483-1-roberto.sassu@huaweicloud.com>
 <20221201104125.919483-3-roberto.sassu@huaweicloud.com> <6905166125130c22c244ebf234723d1587a01ae8.camel@huaweicloud.com>
In-Reply-To: <6905166125130c22c244ebf234723d1587a01ae8.camel@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 12 Jan 2023 12:21:57 -0500
Message-ID: <CAHC9VhRu_pdEur4XDkwMETAQEd-8=13k+qvpMEgW=hiYMCKw2A@mail.gmail.com>
Subject: Re: [PATCH v7 2/6] ocfs2: Switch to security_inode_init_security()
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jan 10, 2023 at 3:56 AM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> On Thu, 2022-12-01 at 11:41 +0100, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> >
> > In preparation for removing security_old_inode_init_security(), switch to
> > security_inode_init_security().
> >
> > Extend the existing ocfs2_initxattrs() to take the
> > ocfs2_security_xattr_info structure from fs_info, and populate the
> > name/value/len triple with the first xattr provided by LSMs.
>
> Hi Mark, Joel, Joseph
>
> some time ago I sent this patch set to switch to the newer
> function security_inode_init_security(). Almost all the other parts of
> this patch set have been reviewed, and the patch set itself should be
> ready to be merged.
>
> I kindly ask if you could have a look at this patch and give your
> Reviewed-by, so that Paul could take the patch set.

I've been pushing to clean up some of the LSM interfaces to try and
simplify things and remove as many special cases as possible,
Roberto's work in this patchset is part of that.  I would really
appreciate it if the vfs/ocfs2 folks could give patch 2/6 a quick look
to make sure you are okay with the changes.

I realize that the various end-of-year holidays tend to slow things
down a bit, but this patchset has been on the lists for over a month
now; if I don't hear anything in the next week or two I'll assume you
folks are okay with these patches ...

-- 
paul-moore.com
