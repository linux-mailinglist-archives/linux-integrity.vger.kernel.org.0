Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A09E5E6A10
	for <lists+linux-integrity@lfdr.de>; Thu, 22 Sep 2022 19:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbiIVR6D (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 22 Sep 2022 13:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiIVR6A (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 22 Sep 2022 13:58:00 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB622F3903
        for <linux-integrity@vger.kernel.org>; Thu, 22 Sep 2022 10:57:59 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id m81so13377699oia.1
        for <linux-integrity@vger.kernel.org>; Thu, 22 Sep 2022 10:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=TgDgY+ntTJT5LrRO/2yKf3PhPIjqGDJ5ckxVAeXb9pM=;
        b=EzxJCwqj8SUwpLATOCTQCPXxDArAx6jFOBINEfe0RkA59zcTvCk63VJoJ1bzwwuIVb
         V1mD5vSARYHIY+JC4SPQ/okkb4NfsVbzqL94CXKsz3w9yhvAfHII3L0jSoZFPnLVF9K/
         b96T0Tc7ngdEn6LxvZQF4QI0CBnLRHl8wFXus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=TgDgY+ntTJT5LrRO/2yKf3PhPIjqGDJ5ckxVAeXb9pM=;
        b=IzTCiB2tXrTJoumAE9V0GFTMh69wZE+6ycbkUFnJYfNR/XAoFWlsdCz4rZTBZBPuQ1
         +J5Bb7GaP5wRg1Toy4I8K/ZHSjdtqEfSCzNvDjRmjIADWtFA/oZFET3SyCdgZfVhJv33
         xZpOmBm4wBLzapGcYs00E6dzsk2XQ+LJVfi03Mz0j0a0ZYFyGswIOiONJdcgEfPWefdr
         fdCIyScq03tkYZZxudXk+JZRKteeCu8BIRqnWvVKVZ7KaRlzQHfTR38E+p23b/zwDchp
         vfx9TVme0ARu6R7OUQtE+B+qMg0Zcc8UeZRtUpXA8796JkkZ39eDAz6xP5SFQB27IPu+
         nAoQ==
X-Gm-Message-State: ACrzQf3CBWeBKoXTp+mJOQetDscngtRQy7R3PnQ7gHqwjeMUNf6InlrA
        9Rl6M/dWmJCmNh4j90mNkDMvyVr65IL19A==
X-Google-Smtp-Source: AMsMyM4+qRitHMXhtJ4l2bs4shsNtU8D5LqzMGReqVS4AyQk8QEz0GMgKKY+n0iKEclxXbt5DAQWLA==
X-Received: by 2002:a05:6808:202:b0:34f:7065:84d4 with SMTP id l2-20020a056808020200b0034f706584d4mr2366470oie.298.1663869478623;
        Thu, 22 Sep 2022 10:57:58 -0700 (PDT)
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com. [209.85.160.47])
        by smtp.gmail.com with ESMTPSA id d7-20020a05680805c700b00342d207e68bsm2686398oij.37.2022.09.22.10.57.54
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 10:57:55 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-127dca21a7dso14925069fac.12
        for <linux-integrity@vger.kernel.org>; Thu, 22 Sep 2022 10:57:54 -0700 (PDT)
X-Received: by 2002:a05:6870:c0c9:b0:127:c4df:5b50 with SMTP id
 e9-20020a056870c0c900b00127c4df5b50mr2732855oad.126.1663869474518; Thu, 22
 Sep 2022 10:57:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220922151728.1557914-1-brauner@kernel.org> <d74030ae-4b9a-5b39-c203-4b813decd9eb@schaufler-ca.com>
In-Reply-To: <d74030ae-4b9a-5b39-c203-4b813decd9eb@schaufler-ca.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 22 Sep 2022 10:57:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=whLbq9oX5HDaMpC59qurmwj6geteNcNOtQtb5JN9J0qFw@mail.gmail.com>
Message-ID: <CAHk-=whLbq9oX5HDaMpC59qurmwj6geteNcNOtQtb5JN9J0qFw@mail.gmail.com>
Subject: Re: [RFC PATCH 00/29] acl: add vfs posix acl api
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        v9fs-developer@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Sep 22, 2022 at 9:27 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Could we please see the entire patch set on the LSM list?

While I don't think that's necessarily wrong, I would like to point
out that the gitweb interface actually does make it fairly easy to
just see the whole patch-set.

IOW, that

  https://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git/log/?h=fs.acl.rework

that Christian pointed to is not a horrible way to see it all. Go to
the top-most commit, and it's easy to follow the parent links.

It's a bit more work to see them in another order, but I find the
easiest way is actually to just follow the parent links to get the
overview of what is going on (reading just the commit messages), and
then after that you "reverse course" and use the browser back button
to just go the other way while looking at the details of the patches.

And I suspect a lot of people are happier *without* large patch-sets
being posted to the mailing lists when most patches aren't necessarily
at all relevant to that mailing list except as context.

                 Linus
