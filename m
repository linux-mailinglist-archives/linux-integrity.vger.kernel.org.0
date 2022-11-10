Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB3B623828
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Nov 2022 01:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbiKJAaR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 9 Nov 2022 19:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbiKJAaP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 9 Nov 2022 19:30:15 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3DB913D18
        for <linux-integrity@vger.kernel.org>; Wed,  9 Nov 2022 16:30:14 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id v17so689232edc.8
        for <linux-integrity@vger.kernel.org>; Wed, 09 Nov 2022 16:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v4yTYtNFCr2DMFGxVYe8BkHHgi9YJBUY78E57QbJ4b4=;
        b=QPh+dXTNNNqvMpbHZ+zyyruTS5AtCQvm6jcqLL2W9v+PwLC7vDe3logqFmZD94dYSP
         j6gODfcUUWJDTpUyk8hmXXMbo328Gv/iEL/11fF5vrLy0rJupS7Hu5DJ6Kbwjs4Fqbwx
         alPJToOLgsVzSGLZWe/LaiY8wv+0RY0qSb1+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v4yTYtNFCr2DMFGxVYe8BkHHgi9YJBUY78E57QbJ4b4=;
        b=vv7+yAlV2U1uugS8DvJ1/kemOHlBEpWsum+6im7jugxAeX8bbJBS2cl/hHsCbvOnCk
         33cg4Me0m0jMNpX+QWBFl6Vuxdvs1B9iGg/8SmQpJnjuk1LwZKvfUeoT3bSPWs9G5ngz
         XCLUS4RTh4NO8mZM6fSsj2XMxAchYEa3cOd3Xp82Lcle2mNfsWanJSl1U1Qu5tRx5npY
         d6t478m0tMc1kGMZc8FnxKpqQSe+tNtk5Z7sRdih3rq8qYukAGUj7CuDP2ViTSBQttFH
         MCLsiTm0mLKz+BxcU5qISOodJW2EiH1bKYe7aTFX5blYQ2EqnCGluByYRW4DWct3wxQP
         K7MQ==
X-Gm-Message-State: ACrzQf3pxFrU4apOjVaM8UVNhgb5K5vw7EGqnCJrs7YcEfucN0vyRYlZ
        zifGnYqYaIlx2/bqkLbqyd49ye85av56rw==
X-Google-Smtp-Source: AMsMyM5TySGQyjwWDUL4iIhDKhtXnZR7zRfqQSdhLk0lco5v5QOx9jxZCb8v+VZckSyHWUKpcA8wOQ==
X-Received: by 2002:a50:ec13:0:b0:461:e3f2:38bc with SMTP id g19-20020a50ec13000000b00461e3f238bcmr1336235edr.149.1668040213341;
        Wed, 09 Nov 2022 16:30:13 -0800 (PST)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id lx8-20020a170906af0800b00782fbb7f5f7sm6454966ejb.113.2022.11.09.16.30.12
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 16:30:12 -0800 (PST)
Received: by mail-wr1-f52.google.com with SMTP id l14so158629wrw.2
        for <linux-integrity@vger.kernel.org>; Wed, 09 Nov 2022 16:30:12 -0800 (PST)
X-Received: by 2002:a5d:6dc3:0:b0:22a:bcc3:21c6 with SMTP id
 d3-20020a5d6dc3000000b0022abcc321c6mr41571850wrz.450.1668040212003; Wed, 09
 Nov 2022 16:30:12 -0800 (PST)
MIME-Version: 1.0
References: <20221103180120.752659-1-evgreen@chromium.org> <20221103105558.v4.7.Ifff11e11797a1bde0297577ecb2f7ebb3f9e2b04@changeid>
 <202211041135.EAC889BA08@keescook>
In-Reply-To: <202211041135.EAC889BA08@keescook>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 9 Nov 2022 16:29:35 -0800
X-Gmail-Original-Message-ID: <CAE=gft5Tw-iX8M1zWc419X-mwYTYvxZJiKxR9Q1He9dY7A3C5w@mail.gmail.com>
Message-ID: <CAE=gft5Tw-iX8M1zWc419X-mwYTYvxZJiKxR9Q1He9dY7A3C5w@mail.gmail.com>
Subject: Re: [PATCH v4 07/11] PM: hibernate: Add kernel-based encryption
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-pm@vger.kernel.org, rjw@rjwysocki.net, gwendal@chromium.org,
        apronin@chromium.org, Pavel Machek <pavel@ucw.cz>,
        Matthew Garrett <mgarrett@aurora.tech>,
        linux-integrity@vger.kernel.org, jejb@linux.ibm.com,
        zohar@linux.ibm.com, dlunev@google.com,
        Eric Biggers <ebiggers@kernel.org>,
        Ben Boeckel <me@benboeckel.net>, jarkko@kernel.org,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Nov 4, 2022 at 11:38 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Nov 03, 2022 at 11:01:15AM -0700, Evan Green wrote:
> > [...]
> > +config ENCRYPTED_HIBERNATION
> > +     bool "Encryption support for userspace snapshots"
> > +     depends on HIBERNATION_SNAPSHOT_DEV
> > +     depends on CRYPTO_AEAD2=y
> > +     default n
>
> "default n" is the, err, default, so this line can be left out.
>
> If someone more familiar with the crypto pieces can review the rest,
> that would be good. :)

Eric and I emailed briefly about it a couple weeks ago, he said he
would try to take a look when he could. I'm optimistic.

-Evan

>
> --
> Kees Cook
