Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02BD667D11
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Jan 2023 18:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238429AbjALR4U (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Jan 2023 12:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbjALR4Q (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Jan 2023 12:56:16 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BE755673
        for <linux-integrity@vger.kernel.org>; Thu, 12 Jan 2023 09:16:03 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id c85so10998797pfc.8
        for <linux-integrity@vger.kernel.org>; Thu, 12 Jan 2023 09:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nzSuljwXCaXyiAVCXAx1oRKKeIjSI3nJRRGJJx1quUQ=;
        b=MFOcCfEZ7Cjmr3WB5GH4eeEn0165eiypBPdejoqXwokek49v/AySoZEAZw9j2oDcmq
         y4J6DEeYf3KOdxex0i3awGU/lJNKOesgPify/ePlg8mxB+jk23/SKGnDkwfjKWs723G+
         5fTI4dD97IJHbv3KYFmaYeEhLvdEO5RWppT7C9xSdlKh60iFFNFBADUu4kCkp7oLBgpM
         RQWj59jEMMtexCUU92taNzVkPyGJ6EsQ4nGL8WFfh1sHrh7w0DJkEzpsadnRGZ+k5KlX
         9RKXsLyYhkqNOIn6C//zs9Slur/qUqHuCKIuWKiASSuuMe2SyhJoPMmQAvRwAOR8UYA5
         lbew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nzSuljwXCaXyiAVCXAx1oRKKeIjSI3nJRRGJJx1quUQ=;
        b=3PNvJr9VT7mAp/zO4unfSHQNXJTr6mTGAvNRRVyZ+sGJXfg7/455t9WmymO4P/TmgH
         xaX4zkIh1DqLsfdse40jGOJyL5CKLw6VIQwGkGZrvoASZolF3KmKwXvXaW7g4iv9K1vU
         CglW3Sa8dTc8b8xde3u7jwhB67Ht0sRcc/nhECoWsDZTkfVNRCMundK6p8p6f4rFoZlq
         82uPx041BydJaHLVaierGwBkaYbQ7OM+2loHudIVANQOee1PeYMVAxkyTEWYiPRKAPhq
         7cJKDVphOE+ghu3Ymu6GSuuHcvaWgT8fTtIJABFOy9ry7B1WYUSE5UP9amQjFoWkaZDS
         LPMQ==
X-Gm-Message-State: AFqh2kp9uJIYq6FzitiDyd+yIPyatZhNP9gpy6nEx4CPiNx2MOx/rOVC
        +S9+78sXgiW6uT5pex+eXg+JwQp63LgY3bq7rQCk
X-Google-Smtp-Source: AMrXdXsG96vnEjEW68HlbBwvUb9qhZbhASlzXqBntMWFBx7pNvLRL/YHEGdI0X89G0/fteFLqA6mf93dh22GLZtjV5o=
X-Received: by 2002:a62:158f:0:b0:588:e66e:4f05 with SMTP id
 137-20020a62158f000000b00588e66e4f05mr1300557pfv.23.1673543763211; Thu, 12
 Jan 2023 09:16:03 -0800 (PST)
MIME-Version: 1.0
References: <20221201104125.919483-1-roberto.sassu@huaweicloud.com>
In-Reply-To: <20221201104125.919483-1-roberto.sassu@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 12 Jan 2023 12:15:51 -0500
Message-ID: <CAHC9VhS0SnEb46-FBpn2JpC2dJ7OnkeJ2EtLBvVvkOLdfFmcbg@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] evm: Do HMAC of multiple per LSM xattrs for new inodes
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

On Thu, Dec 1, 2022 at 5:42 AM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> One of the major goals of LSM stacking is to run multiple LSMs side by side
> without interfering with each other. The ultimate decision will depend on
> individual LSM decision.
>
> Several changes need to be made to the LSM infrastructure to be able to
> support that. This patch set tackles one of them: gives to each LSM the
> ability to specify one or multiple xattrs to be set at inode creation
> time and, at the same time, gives to EVM the ability to access all those
> xattrs and calculate the HMAC on them.

...

> The patch set has been tested with both the SElinux and Smack test suites.
> Below, there is the summary of the test results:
>
> SELinux Test Suite result (without patches):
> Files=73, Tests=1346, 225 wallclock secs ( 0.43 usr  0.23 sys +  6.11 cusr 58.70 csys = 65.47 CPU)
> Result: FAIL
> Failed 4/73 test programs. 13/1346 subtests failed.
>
> SELinux Test Suite result (with patches):
> Files=73, Tests=1346, 225 wallclock secs ( 0.44 usr  0.22 sys +  6.15 cusr 59.94 csys = 66.75 CPU)
> Result: FAIL
> Failed 4/73 test programs. 13/1346 subtests failed.

Can you provide some more information on which of the
selinux-testsuite tests failed?  That shouldn't be happening and I'm a
little concerned that these test failures, even if unrelated to your
work here, could be masking failures which are related.

-- 
paul-moore.com
