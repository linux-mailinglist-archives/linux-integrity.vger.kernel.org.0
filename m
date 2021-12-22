Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 557C047D51F
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Dec 2021 17:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241880AbhLVQcE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 Dec 2021 11:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241856AbhLVQcE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Dec 2021 11:32:04 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A722C061401
        for <linux-integrity@vger.kernel.org>; Wed, 22 Dec 2021 08:32:04 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id i187so702546qkf.5
        for <linux-integrity@vger.kernel.org>; Wed, 22 Dec 2021 08:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GVq0Lkiq1jbxQVK9A6lpW+BwXHCHGEmsYVl2rEAV60Y=;
        b=iv0i8LFszW7AfFHKMoHpVVENR7IkX+qRUoG8cYeDB22IY2avyba2NmJPr4bdYp9TPp
         xYlccU5Dq6xkOR3j9t8IH9Bz3t+AnnLgezD6PhYfPxQFs38nswabHw1wFPhfV6rTNdbz
         WyO2Pp3MJCJjHvt70R+Mnlolk8FiLEha9tLciLluapBneoq3RGZcmrgmkMk/52vHjLlu
         py7bHoFni1qyxynw7XFowlIlgqxAoA1hLjYoR8pl1CstFgICqTsNjbGtyXPjIQzvavPQ
         Dw5k//PbwXPHAV/rvHOrYvuFgfRsIXbiV96jQYpDTveKZIHEtsm7XkcaYx60/Zif0X6l
         fpeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GVq0Lkiq1jbxQVK9A6lpW+BwXHCHGEmsYVl2rEAV60Y=;
        b=CayIVPN3OMl3Yw1btAYHKTLj4379u4lZN9TDoecY7Elixg7YTERy0W2Xv+y15Leyhg
         alVIjHPEprWN1g1VqMc9pGDQY55QXYfcZ/rlksZ9xF2qCOidLSyL3sv7vC+cXsPCDh3s
         XCIQcoLkDbdxD9il8IJ6gteAROWSWN2d66c9vMYwmHbr1LNem1PfGd0nJB+EtqsuW+Py
         mrA2nDJCg0IOX2OlO5I6QxQ+T3z3IQqkl6rTKR+wemEHo5GC+CX2XJoXBZh0TtTI8YWb
         OJjLwTANmNknKm8dNMgQx9+6NookpRXqcIZbSmy2Zznc0F7G1vQOoYer0B3GthJtt2R6
         CkdQ==
X-Gm-Message-State: AOAM5331E74SazWekyldDwrefnxFqZta+Yi7uk1bav8uJUORzqDLoIKT
        qGq1ii7yXy3cg1Bm43TKyEbdH5K9q5i7RaxFy5HU/25uok8VYA==
X-Google-Smtp-Source: ABdhPJxDn4eTGAjkL0ahiBxdGuYS4W5B2EFD8qOqlWwHv0RL2u2pL3vuXz9YL9Pwo2b4hlaPu5CRfvxrwXuFCweqBz0=
X-Received: by 2002:a37:a3c7:: with SMTP id m190mr2513404qke.288.1640190723204;
 Wed, 22 Dec 2021 08:32:03 -0800 (PST)
MIME-Version: 1.0
References: <20211213192030.125091-1-yaelt@google.com> <ec2ec0a9a7ba1adc6e54bbf7051a83ba90a39c0b.camel@linux.ibm.com>
In-Reply-To: <ec2ec0a9a7ba1adc6e54bbf7051a83ba90a39c0b.camel@linux.ibm.com>
From:   Yael Tiomkin <yaelt@google.com>
Date:   Wed, 22 Dec 2021 11:31:51 -0500
Message-ID: <CAKoutNvhYYiKgCLFFqzczuT444TraMhmEhzFwC7u42ALTdSqaQ@mail.gmail.com>
Subject: Re: [PATCH v2] Instantiate key with user-provided decrypted data.
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, jejb@linux.ibm.com,
        Jarkko Sakkinen <jarkko@kernel.org>, corbet@lwn.net,
        dhowells@redhat.com, jmorris@namei.org, serge@hallyn.com,
        keyrings@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Dec 14, 2021 at 7:37 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> Hi Yael,
>
> On Mon, 2021-12-13 at 14:20 -0500, Yael Tiomkin wrote:
> > The encrypted.c class supports instantiation of encrypted keys with
> > either an already-encrypted key material, or by generating new key
> > material based on random numbers. To support encryption of
> > user-provided decrypted data, this patch defines a new datablob
> > format: [<format>] <master-key name> <decrypted data length>
> > <decrypted data>.
> >
> > Signed-off-by: Yael Tiomkin <yaelt@google.com>
>
> Other than the comment below,
>     Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
>
> Could you also provide an LTP test for defining, exporting, and loading
> an encrypted key based on user provided key data?
>
> thanks,
>
> Mimi
>
> > ---
>
> > @@ -303,6 +306,16 @@ Load an encrypted key "evm" from saved blob::
> >      82dbbc55be2a44616e4959430436dc4f2a7a9659aa60bb4652aeb2120f149ed197c564e0
> >      24717c64 5972dcb82ab2dde83376d82b2e3c09ffc
> >
> > +Instantiate an encrypted key "evm" using user-provided decrypted data::
> > +
> > +    $ keyctl add encrypted evm "new default user:kmk 32 `cat evm.blob`" @u
> > +    794890253
>
> The existing references to "evm.blob" refer to the encrypted key data.
> Here "evm.blob" is unencrypted data.  Perhaps name it something like
> "evm.user-provided-data" data.
>
> > +
> > +    $ keyctl print 794890253
> > +    default user:kmk 32 2375725ad57798846a9bbd240de8906f006e66c03af53b1b382d
> > +    bbc55be2a44616e4959430436dc4f2a7a9659aa60bb4652aeb2120f149ed197c564e0247
> > +    17c64 5972dcb82ab2dde83376d82b2e3c09ffc
> > +
>

Hi Mimi,

I have posted the ltp test:
https://lore.kernel.org/all/20211221023721.129689-1-yaelt@google.com/

I will update the documentation per your suggestion.

Thanks,
Yael
