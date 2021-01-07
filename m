Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 296002ED33F
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Jan 2021 16:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbhAGPJh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 Jan 2021 10:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbhAGPJh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Jan 2021 10:09:37 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C376BC0612F4
        for <linux-integrity@vger.kernel.org>; Thu,  7 Jan 2021 07:08:56 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id 6so10140962ejz.5
        for <linux-integrity@vger.kernel.org>; Thu, 07 Jan 2021 07:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=puiterwijk.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=10vX/2le5XVmd1inMDtCHSic9VWRII/kDUQvR+RtNow=;
        b=BYUnc584Cg1E9ioDE5GolW7FPZ6O0kyQt0aXh67BKcWs6nyJW2voRlmN/UYcjDs1+E
         zEz2EZLltE9FUjeU3HGW8qrhMb7iiQUm9fdnyYspS4QN5kmkm1yVDhv0K/xwsJ8qobt3
         MA6rdKrYHGPvaDUGPLDkkApXi0REXFHBFIBSJH5S2jqn+wJGiOkwULs9zWjKf8sM89v0
         Rwut2D06h4lj1bvXllGfEbf359JcvHcgpLPcmEYQrulELrDOiRIGw2SkuNdixq/gHJSq
         hFg1xVmXgLfsPgTAzV+Tk4cdeeaGGyPzx/MnJ2mHs6Un/QWYZizaPKfnTU3GMlRnG82z
         N+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=10vX/2le5XVmd1inMDtCHSic9VWRII/kDUQvR+RtNow=;
        b=sMDyD0AVhaKWNhBw6wOx24yVE8vSUp5+VZJPWW7iBEcrmuOd0tBEmmPuf8GVv4pFwB
         lE5yJLGOIgn2kOo1FBWaT+drQsXicjQQokyK4vPhJa7DX66yjkDTa8YoUSoiA9z/A3wl
         dp0JPso/5qe3RRLkgJ1sJD57LAowheQAup83QfTbGskqwWiJycn5wU81sbHulL0fHpAm
         cWbiVyMNRFLY5yMFsSJHZ6TxT0/fCMbwcFCxkub/257gnqU5Wjg7WuK6+udtgGk/vqp/
         3JrBNPvQ7jo+JJK/ys4HIU3p7WAtEQFlySduFxRroTAuJcBwdT/HCkzqU9k07auph50x
         wUEw==
X-Gm-Message-State: AOAM532Sc2m40oBySZmZng7mcpyaBNqEGf0Dt0OAlF1VCyZiyu0rFHmj
        Uaqgu+lDfjgNMRb9unePtYjOLKudD7Cc+rcbs9VUhA==
X-Google-Smtp-Source: ABdhPJxVWd/j+2fzyAFI4AZwWG2vqVdAwMaJrQlwql588nApWL+Km+CgQ8I34oi+E75bFZ1sKVRc36pNH0XYzr15Ef8=
X-Received: by 2002:a17:906:e291:: with SMTP id gg17mr6703316ejb.31.1610032135400;
 Thu, 07 Jan 2021 07:08:55 -0800 (PST)
MIME-Version: 1.0
References: <20210106094335.3178261-1-patrick@puiterwijk.org>
 <20210106094335.3178261-3-patrick@puiterwijk.org> <021868cb0faadd4a61440974808880ff520f9bd6.camel@linux.ibm.com>
 <20210107125359.flz7qupax2bhynzy@altlinux.org>
In-Reply-To: <20210107125359.flz7qupax2bhynzy@altlinux.org>
From:   Patrick Uiterwijk <patrick@puiterwijk.org>
Date:   Thu, 7 Jan 2021 16:08:44 +0100
Message-ID: <CAJweMdYiZY8AQ-vLTUfHrv3FkKxDZaTHx2TzjLQyRYqpGWVdKw@mail.gmail.com>
Subject: Re: [PATCH 2/2] Add test for using sign_hash API
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        pbrobinson@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jan 7, 2021 at 1:54 PM Vitaly Chikunov <vt@altlinux.org> wrote:
>
> On Thu, Jan 07, 2021 at 07:25:03AM -0500, Mimi Zohar wrote:
> > > diff --git a/tests/sign_verify.apitest.c b/tests/sign_verify.apitest.c
> > > new file mode 100644
> > > index 0000000..20e2160
> > > --- /dev/null
> > > +++ b/tests/sign_verify.apitest.c
> > > @@ -0,0 +1,55 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * sign_verify.apitest: Test program for verifying sign_hash
> > > + *
> > > + * Copyright (C) 2020 Patrick Uiterwijk <patrick@puiterwijk.org>
> > > + * Copyright (C) 2013,2014 Samsung Electronics
> > > + * Copyright (C) 2011,2012,2013 Intel Corporation
> > > + * Copyright (C) 2011 Nokia Corporation
> > > + * Copyright (C) 2010 Cyril Hrubis <chrubis@suse.cz>
> > > + */
>
> Woah, so much copyright for a simple sign_hash() call?

I basically copied the copyright statements from evmctl.c (and put
them in the reversed order as per the new syntax as Mimi did in
utils.c as a fix to my previous patchset).
This was because the "int main" function started out as a copy of
"sign_ima" from evmctl.c.
The Samsung, Intel and Nokia entries are all from Dmitry Kasatkin.
Cyril's entry is there because I initially copied hex2bin from utils.c
before just linking against it, I'll remove that one in a next
version.

>
> >
> > Looking at the history, Dmitry Kasatkin must have been involved.  From
> > which software package is this from?
