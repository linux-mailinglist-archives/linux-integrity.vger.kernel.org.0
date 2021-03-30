Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 942DA34F37A
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Mar 2021 23:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbhC3V3k (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Mar 2021 17:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233288AbhC3V2n (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Mar 2021 17:28:43 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD342C061574;
        Tue, 30 Mar 2021 14:28:42 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 30so8926783qva.9;
        Tue, 30 Mar 2021 14:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ijyhfQ+fdBvGo4/9WEvg+2IXq75NDRW57Oedihv3mO4=;
        b=f9RyZpypffvWmRYdkEcjEkX2s4R4L944gJMfUKX0CN++k1SIfk70wFF/gDxYVi0h4T
         Lsl0f5g5IahBSh9rt22YOw0bB3z4IG2B0T4kCejmxzwUfe6QXE4oT9NMYKrqphGOTV7J
         X6bfKR6Auz7dR2iN+FJ4b3jSZqwkazZcr7SICayUCgbXqfFfId4rVEU/3iaZrX72iUCA
         nQKEyQSVHKAUrV0t/y112eyVhB+KCwgl0NpFuTaxk+seJgVBKtMxGZLlyaNSRXyhUu6F
         3fLvazzscIjhFvfml8YpHbE6uxC0uN2idxGjoEIFNkB/+pOSu8MY1ZXHwHH4U4Wv8kF6
         O+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ijyhfQ+fdBvGo4/9WEvg+2IXq75NDRW57Oedihv3mO4=;
        b=bi0PFpR+0JcoEORmjdZch+Zh4EtG+TNtl7gNQ7eeDLReMGN1PGe0b9fYU6wXuMgOWh
         Ug0qmzxRgwzQaxKiaBYkR8mDul/c+YsvewWM0rDA1iTQZCu5t5mkZHqn2TOIx4uQ/pLI
         s7yzwcQdR0ext1kBq+3EYh+vXka42S64lCPoxb/W4fVgEJA2GQnlnOj0DRTCN00DGosA
         EfELSrRPXiBOWk6LC8oYAZACy/d0lWC3B6KVH5BXvsCWYDbz/4h3M+D0Uw6NbWGwFgYF
         lHxyFby2yrCthFtJKACZj8+AoAJK8ZKqt2OaUk5+qEw1KbjfKduwr6lNrO3k69eyFdUZ
         2NYw==
X-Gm-Message-State: AOAM532oixT7TM2p9YqGh77WHMopIO4MgXsh6JicNZFgmZRAxjXjCieW
        mSH8WGkziJhCHtivFjxNiU3jk3NV7tr8eDjN+qY=
X-Google-Smtp-Source: ABdhPJymiZLPb6oIxk780b6xbiIr9FUKsG5KMDofVApTmjlt2JiL5Jj67ELP7PBU37tlAXdKqHn5FYz9HnOTIyHLcP0=
X-Received: by 2002:a05:6214:9c9:: with SMTP id dp9mr190591qvb.34.1617139721882;
 Tue, 30 Mar 2021 14:28:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.56fff82362af6228372ea82e6bd7e586e23f0966.1615914058.git-series.a.fatoum@pengutronix.de>
 <319e558e1bd19b80ad6447c167a2c3942bdafea2.1615914058.git-series.a.fatoum@pengutronix.de>
 <CAFLxGvxmRcvkweGSRSLGEm5MJDM4M7nzkp9FwOwmhZ+h2RE0vA@mail.gmail.com> <91b01387-1814-0719-8a21-2beb150dfcd6@pengutronix.de>
In-Reply-To: <91b01387-1814-0719-8a21-2beb150dfcd6@pengutronix.de>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Tue, 30 Mar 2021 23:28:30 +0200
Message-ID: <CAFLxGvz9efpWS29f3vabbyDA46KVZ8kb2NNkJvLeafAb-rcXVg@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>, kernel@pengutronix.de,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Udit Agarwal <udit.agarwal@nxp.com>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        David Gstir <david@sigma-star.at>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Sumit Garg <sumit.garg@linaro.org>, keyrings@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Ahmad,

On Wed, Mar 17, 2021 at 3:03 PM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:

> > I didn't closely follow the previous discussions, but is a module
> > parameter really the right approach?
> > Is there also a way to set it via something like device tree?
>
> Compiled-on sources are considered in the order: tpm, tee then caam.
> Module parameters are the only override currently available.

Okay. So in the ideal case only one of these backends is compiled in,
but the list can get long.

I'm asking because David and I currently port another caam-like
mechanism to the most recent
kernel which will also hook in there.
Out driver adds trusted keys support (with caam alike blobs) for i.mx
SoCs that come with DCP
instead of CAAM.
Patches will hopefully materialize soon.

-- 
Thanks,
//richard
