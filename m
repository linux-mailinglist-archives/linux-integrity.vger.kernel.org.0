Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E95ED3B690D
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Jun 2021 21:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234623AbhF1TaK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 28 Jun 2021 15:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234282AbhF1TaJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Jun 2021 15:30:09 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3720C061574
        for <linux-integrity@vger.kernel.org>; Mon, 28 Jun 2021 12:27:42 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id d16so34564282lfn.3
        for <linux-integrity@vger.kernel.org>; Mon, 28 Jun 2021 12:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xwr2D89QU7E+0IXi4VU3X3MD6EsCQWd7tnEnNMHxJlo=;
        b=LvUAnTsGW5X/crAwv/8tMFrYE7g+lmwHbXnj3MVQ/4mCivYnfcOUpcmFcB9YhrqosN
         nh2vU24qY524pzifVlJLe3Y+eHtVxPt01xRum8Sf48OyNsX3+6BpUULxQiTciMny7yvH
         T7aiXmusLjRHYGqPfD0+tS6utaBlCzlgNtxfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xwr2D89QU7E+0IXi4VU3X3MD6EsCQWd7tnEnNMHxJlo=;
        b=XvMNJXEThTPyr3yu3Y52mGkehc7+XA+4oDSGS5cx3mHySi6W10/xH0Dz9md7Ymz/hR
         sccyp377YSauInUTZKxDrhH1CEqBhrUCxoC+6niMvheEqCcMasnnCL7wFULA0VIFf5AS
         PvpEiLHG3erMMFuwz6LkjBchuRE7hDnh3rFwyMNNTo6hmSeGDeFGVyiJlrywxu1yJlFJ
         an755/qAT17gylJWse8NYHHKG7Jh6RPRhR/U4VrAmGNu6qfcbh/4KSQAxxP9EESy4Apj
         uyBgkgAnCS7wSrSnR/2R/VZAfQrNB1IU9N5mh0/D5FkM/FesTfLjTZXGBVPmhYYiYJQi
         ewfg==
X-Gm-Message-State: AOAM530NJTvGuiLtUNusN6XH0OV57OTEobEl7fp8KqbAHsjsZ3+QxQju
        HBz+FuJ47fJJYBUTNvEqhToJktQhRlnCuULj
X-Google-Smtp-Source: ABdhPJxa1pFv/s0L7cet98fPqrlw9xEL4Y3y7WDfV5Isyo4Eto8kaMQK3IDJxKzuH8VvTb9bJK2tBg==
X-Received: by 2002:ac2:43a9:: with SMTP id t9mr20022992lfl.387.1624908460856;
        Mon, 28 Jun 2021 12:27:40 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id v13sm1402864lfo.33.2021.06.28.12.27.40
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 12:27:40 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id r16so27278746ljk.9
        for <linux-integrity@vger.kernel.org>; Mon, 28 Jun 2021 12:27:40 -0700 (PDT)
X-Received: by 2002:a05:651c:32e:: with SMTP id b14mr718622ljp.251.1624908459910;
 Mon, 28 Jun 2021 12:27:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210623135600.n343aglmvu272fsg@kernel.org> <CAHk-=whhEf=xJz=rdcLWNnRU1uR6Ft-mn6xNrOg3OcQ=5cX6BQ@mail.gmail.com>
 <8de9d45e-4389-8316-b0d0-e9a43be9fade@linux.ibm.com> <CAHk-=wibQ3ahmo0m3BynA3bw2Fkhv0OfMJuV0+wEMwg93Fbj0g@mail.gmail.com>
 <d3fd4b64-be6a-2210-5cfa-fc1947aea293@linux.ibm.com>
In-Reply-To: <d3fd4b64-be6a-2210-5cfa-fc1947aea293@linux.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Jun 2021 12:27:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgQJESJ-q-4FNgwpTJTZrEr033gzpXM2gWWviVOHJNnaQ@mail.gmail.com>
Message-ID: <CAHk-=wgQJESJ-q-4FNgwpTJTZrEr033gzpXM2gWWviVOHJNnaQ@mail.gmail.com>
Subject: Re: [GIT PULL] TPM DEVICE DRIVER changes for v5.14
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        James Morris James Morris <jmorris@namei.org>,
        David Howells <dhowells@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jun 28, 2021 at 12:21 PM Stefan Berger <stefanb@linux.ibm.com> wrote:
>
> Correct, and the code (certs/Makefile) is surrounded by the check for
> this particular file here, so it won't touch anything else:

Ahh, I missed that part.

Can we just make it really really obvious, and not use
CONFIG_MODULE_SIG_KEY at all, then?

IOW, make these literally be about "certs/signing_key.pem" and nothing
else, so that when people grep for this, or look at the Makefile, they
don't fall into that trap I fell into?

That also would make it obvious that there are no pathname quoting issues etc.

             Linus
