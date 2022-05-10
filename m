Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB245220A7
	for <lists+linux-integrity@lfdr.de>; Tue, 10 May 2022 18:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347037AbiEJQJG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 May 2022 12:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348649AbiEJQIh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 May 2022 12:08:37 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A301A811A
        for <linux-integrity@vger.kernel.org>; Tue, 10 May 2022 09:02:45 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id q73-20020a4a334c000000b0035eb110dd0dso3227270ooq.10
        for <linux-integrity@vger.kernel.org>; Tue, 10 May 2022 09:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zhBW/QZ9WLpe9WezLcn3aKzSucX9nibbJXLdrWe1QD0=;
        b=Q3uO0hvaemzNACMdjxoNJVZBQcjQolZ8coZpTwOBYW9FqQ/lnFZk5spW8h1reJxS9z
         pXwAb97g/kiYfYz4LyN/X7TL+IqLj8ggrJHdGlh1gZ5h734lHFv+tNwBvBXwbe6zD1wN
         PsvUTDvKJgj/fdz7ryNWu4xJ4jfLDHFhoPZGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zhBW/QZ9WLpe9WezLcn3aKzSucX9nibbJXLdrWe1QD0=;
        b=jrqhPIZkJrWKhhdShgWBMJUXy6TPK0qGKEokh9YUIUVpA1FCLcAc+9D8JWdzQsrDD+
         sg8bbbBdj59ejVvQdBYj3SG6zjcaI+SomzDETOZQShUDbHgwbXG3lz84x78/Vu+0akIk
         f1qA0sl3W8gF+8eP1F8SArglCGNob9DQ45rKSSzS+5QFuvZRwhG/Fc1F+VlmUsDWwtUN
         JftCA57g4IwKRGZWGtVUfxxtWhL/Rj26u58lk700Jgeh7P5mAHHXl71iC/QLk44g6DV+
         itvQzzpjJY5v0/n+2dpKtIKJ5jNFrWs3GqRRDXl5LLWz7PlHYv0n4O9Ot4j28DFdzV9t
         LGCQ==
X-Gm-Message-State: AOAM530r6vrXTg+d4kWZCyXL1VjJ+JqWWSynAxR4Kwm9yeTprFybCk8C
        SblTm5kLn6DVCCoUeI/MKL9wB1HnwBXxyA==
X-Google-Smtp-Source: ABdhPJx1E0cMZ2Y5UYngeF+aYHAnevw+5Zi2L0gTlxmkITtpwnGSznlic5AssVUyNYP1hxNfkkuydg==
X-Received: by 2002:a9d:6c87:0:b0:606:1000:bf5a with SMTP id c7-20020a9d6c87000000b006061000bf5amr8442393otr.7.1652198564649;
        Tue, 10 May 2022 09:02:44 -0700 (PDT)
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com. [209.85.167.173])
        by smtp.gmail.com with ESMTPSA id b14-20020a4aac8e000000b0035eb4e5a6bcsm6310807oon.18.2022.05.10.09.02.42
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 09:02:44 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id v65so19003482oig.10
        for <linux-integrity@vger.kernel.org>; Tue, 10 May 2022 09:02:42 -0700 (PDT)
X-Received: by 2002:a05:6808:238f:b0:326:d4e1:a4b6 with SMTP id
 bp15-20020a056808238f00b00326d4e1a4b6mr373653oib.241.1652198562489; Tue, 10
 May 2022 09:02:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220504232102.469959-1-evgreen@chromium.org> <20220504161439.8.I87952411cf83f2199ff7a4cc8c828d357b8c8ce3@changeid>
 <20220506160820.GB1060@bug> <CAE=gft4nE6nYx9gRZuSL1v=8CjGsdtmx+GxPjmdD_hwJs5j-tw@mail.gmail.com>
 <20220510122927.GA19328@amd>
In-Reply-To: <20220510122927.GA19328@amd>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 10 May 2022 09:02:06 -0700
X-Gmail-Original-Message-ID: <CAE=gft6rV2LhmXAq-t4B=Cyhc14vYG_yMTiz73kW0eBchkcBKQ@mail.gmail.com>
Message-ID: <CAE=gft6rV2LhmXAq-t4B=Cyhc14vYG_yMTiz73kW0eBchkcBKQ@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, May 10, 2022 at 5:29 AM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> > > > One annoyance of the "preloading" scheme is that hibernate image memory
> > > > is effectively double-allocated: first by the usermode process pulling
> > > > encrypted contents off of disk and holding it, and second by the kernel
> > > > in its giant allocation in prepare_image(). An interesting future
> > > > optimization would be to allow the kernel to accept and store encrypted
> > > > page data before the user key is available. This would remove the
> > > > double allocation problem, as usermode could push the encrypted pages
> > > > loaded from disk immediately without storing them. The kernel could defer
> > > > decryption of the data until the user key is available, while still
> > > > knowing the correct page locations to store the encrypted data in.
> > >
> > > Um. Dunno. Won't you run out of memory? Hibernation images can be quite big...
> > >
> >
> > As you know, with the way the snapshot mechanism works, a hibernation
> > image can be at most 50% of RAM. If the system was using more than
>
> There used to be 50% of RAM limit, but it was removed.

I'm confused. My mental model of the way this works is that to create
the snapshot, we create a copy of every page in use. So if every used
page needs another page for its snapshot copy, isn't the theoretical
max usage at snapshot time 50%? (Plus or minus some wiggle room for
asking the system to shrink a bit, ignoring nosave regions, and
leaving a bit of extra working space).

Setting aside my potential misunderstanding of the max image size,
frontloading as much of the slow I/O work as we can pack into memory
is still useful for us in terms of user experience. I was originally
planning to include this "deferred user keys" patch in the series, but
it started getting a little unpleasant between a) having to keep the
auth tags around somewhere since they aren't consumed yet, and b)
dealing with highmem and the staging area during replay when the keys
finally did come in. So I opted to stop for now and get feedback
before going any deeper.

-Evan
