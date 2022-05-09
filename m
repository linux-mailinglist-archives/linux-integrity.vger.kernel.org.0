Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86745202D0
	for <lists+linux-integrity@lfdr.de>; Mon,  9 May 2022 18:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239291AbiEIQtU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 May 2022 12:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239282AbiEIQtT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 May 2022 12:49:19 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2611F16C5E1
        for <linux-integrity@vger.kernel.org>; Mon,  9 May 2022 09:45:24 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id q10so658986oia.9
        for <linux-integrity@vger.kernel.org>; Mon, 09 May 2022 09:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IJm8tqFp/0kJcX4DPEzMhsJv1lU8izIHHH4OFpntEsU=;
        b=Qy25jWI1jrH/ESF5nL9X9mAJidez6FmBE0GoGBzEKA0FshCLGq187sNpwBSs3C39OT
         WGAT2i6c9cl2Fem0JBznTEawVUaebk6zRSpVCExOJ4/JL6qtqBH3n5Byz1OrchvpYq2B
         pj1ziH0YWE07Okka7jo/n8GWZOLw2UyCeX9c0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IJm8tqFp/0kJcX4DPEzMhsJv1lU8izIHHH4OFpntEsU=;
        b=VL6lZd9NxkjSRAEd3AN9cRQigKKjotOabjqCKZJp3cVtn6XezNWNAMUizwWCbc3rQj
         8vvaaoJfSc1kB+xoMr4asSa1cUTqz+TLGlxUTBh6g07hJKcrpqcaGPVeNBd9PFKvAvNt
         p/zDpAQBcYA96IcbrJ1w82iTmZ4qfoSk/npevzgtfMFaIyHFC+LrBP+Zdk1Oke07hFki
         odd3wg+6Baenaer/dnEq87mNiYjdta8VBjGc6bJUiuf6eai8l2ooEM3CULx7AKIR/vd2
         xDopO+AoCz7kh4EXvKgIsGJfBvhhLB4RRqMonWj6k6hFc2ZAvliNha/HQOeQQjA6uUR2
         exuw==
X-Gm-Message-State: AOAM53177rpI1RC0IvGbKjjfoWeN8jHWOX6ERbZD9Z+RIgGbBG+e3Y+r
        77mbKuNXHAyxNOmQEZxbQdZ0lW0ru6VR+w==
X-Google-Smtp-Source: ABdhPJzbg1XqrRnHfSbb1xijHEGfaZKR5/zDanih4+TSORhngu16h9KuSH/S5ekgrA6hEXM2huWGxg==
X-Received: by 2002:a05:6808:1294:b0:326:cbe7:2943 with SMTP id a20-20020a056808129400b00326cbe72943mr2603049oiw.261.1652114723446;
        Mon, 09 May 2022 09:45:23 -0700 (PDT)
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com. [209.85.167.171])
        by smtp.gmail.com with ESMTPSA id a9-20020a056808128900b00326d2cba5d3sm764914oiw.8.2022.05.09.09.45.21
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 09:45:22 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id v65so15796338oig.10
        for <linux-integrity@vger.kernel.org>; Mon, 09 May 2022 09:45:21 -0700 (PDT)
X-Received: by 2002:a05:6808:d50:b0:322:fb1d:319d with SMTP id
 w16-20020a0568080d5000b00322fb1d319dmr8015340oik.174.1652114721469; Mon, 09
 May 2022 09:45:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220504232102.469959-1-evgreen@chromium.org> <20220504161439.8.I87952411cf83f2199ff7a4cc8c828d357b8c8ce3@changeid>
 <20220506160820.GB1060@bug>
In-Reply-To: <20220506160820.GB1060@bug>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 9 May 2022 09:44:45 -0700
X-Gmail-Original-Message-ID: <CAE=gft4nE6nYx9gRZuSL1v=8CjGsdtmx+GxPjmdD_hwJs5j-tw@mail.gmail.com>
Message-ID: <CAE=gft4nE6nYx9gRZuSL1v=8CjGsdtmx+GxPjmdD_hwJs5j-tw@mail.gmail.com>
Subject: Re: [PATCH 08/10] PM: hibernate: Mix user key in encrypted hibernate
To:     Pavel Machek <pavel@ucw.cz>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Matthew Garrett <mgarrett@aurora.tech>,
        Daniil Lunev <dlunev@google.com>, zohar@linux.ibm.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-integrity@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        rjw@rjwysocki.net, Gwendal Grignou <gwendal@chromium.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, May 6, 2022 at 9:08 AM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
Hi Pavel!

>
> > One annoyance of the "preloading" scheme is that hibernate image memory
> > is effectively double-allocated: first by the usermode process pulling
> > encrypted contents off of disk and holding it, and second by the kernel
> > in its giant allocation in prepare_image(). An interesting future
> > optimization would be to allow the kernel to accept and store encrypted
> > page data before the user key is available. This would remove the
> > double allocation problem, as usermode could push the encrypted pages
> > loaded from disk immediately without storing them. The kernel could defer
> > decryption of the data until the user key is available, while still
> > knowing the correct page locations to store the encrypted data in.
>
> Um. Dunno. Won't you run out of memory? Hibernation images can be quite big...
>

As you know, with the way the snapshot mechanism works, a hibernation
image can be at most 50% of RAM. If the system was using more than
that at hibernation time, it has to free up the excess via swap before
hibernating. So during this resume period, there's at least 50% of RAM
to play around in and still be able to preload the hibernation image.

What I've been doing in practice is to load as much of the hibernate
image as possible into memory at the login screen while at the same
time ensuring the system maintains a comfortable margin of free
memory. I have to coerce the kernel into doing its giant allocation in
prepare_image() first since it uses GFP_ATOMIC. This might mean I can
only preload some of the image from disk. With the disk I/O being by
far the longest pole in the tent, hiding even some of that latency
behind the password prompt is still great for perceived resume time.


-Evan
