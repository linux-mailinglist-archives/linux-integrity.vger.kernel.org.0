Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A76E431BA1D
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Feb 2021 14:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhBONQi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 15 Feb 2021 08:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbhBONQa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 15 Feb 2021 08:16:30 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79957C061786
        for <linux-integrity@vger.kernel.org>; Mon, 15 Feb 2021 05:15:49 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id b8so1371066oti.7
        for <linux-integrity@vger.kernel.org>; Mon, 15 Feb 2021 05:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wjkmpaYZoqx/V1g1zz+czC2mkPWLKmCPi8XRW5kwt2k=;
        b=sW8ddk78wC92DDQQdxE8WF+dOauJhXi1LbD1xIXzT6L1YeF1OG9PSiXLJ0pVRUassZ
         dkR4Jxwt2bfAYmV87Q3MIbnrxZkmgVcFXUMxOrvB6cM1KZAnI7iqktTl+6FNUyou8uX6
         OVE0SphXFSKygugrXvX0O+t41AHttbMULv+EfvxXs/UZ8nvUaQyxrpykGo11CFLnP9gC
         xt1g6oPutDrbKADy0Szff2ibMI8j8swDJi2rp+WnIbSdbdRRIXYLDH5c1hnqpcBsPUMJ
         Bt19yLZnIb8aIZy+5emYaaoaw3wU/dPAygvn0+NsMifvG9dUjrzlCubaTReLbWD9JMCI
         pNpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wjkmpaYZoqx/V1g1zz+czC2mkPWLKmCPi8XRW5kwt2k=;
        b=kgH0TKKwy1oC1zowYZ6WojO6FQd3Cxqm2QtyZN097cacPtHlikMjbadbhMB9zQ47uz
         2sIPu/UdKJbkTw3I76TuKOYqP7jajghJvEAoxOn7KvYhMbcVDJi/P3HZdpvnI5xBJVLn
         erNgDoq449Ku+BVm31XDUQEh8GIHvSl/bPqPxWdIJg9o5dEKlG5QlIGVIrGhRA6xN0B/
         2KP+mCYlb/N8Dd1ZJFjK4kqtfuwZJxAQI7+uhHTc+tdgz0G3x3tBePk7vH4f346zAGEz
         Cwu/SU+7R1iY18fOQEa9Y6SdTbAFidYdMEj9FBDujh+hDjH1OnmVquAMyax0NizailuG
         sJUQ==
X-Gm-Message-State: AOAM530SMlnzD/Y74O7mOSycQBEsT2JrFKXfh7p0B2x9qR8nhE5YR7NA
        r8VljpaPhLM8UoJCrv5YzamssLC4bgIlxun8OxcNJw==
X-Google-Smtp-Source: ABdhPJz+NdmUWLoic5UHuHWoJUetVrsNxk5tUkDarWb7HobYfKENt4CK5ToR507PIEx8KQnsL2oGfCTAfzhZ6h7Mfe0=
X-Received: by 2002:a9d:701c:: with SMTP id k28mr12052248otj.79.1613394948898;
 Mon, 15 Feb 2021 05:15:48 -0800 (PST)
MIME-Version: 1.0
References: <1604419306-26105-1-git-send-email-sumit.garg@linaro.org>
 <1604419306-26105-2-git-send-email-sumit.garg@linaro.org> <YCQRPo0o6MZ0pcUa@kernel.org>
In-Reply-To: <YCQRPo0o6MZ0pcUa@kernel.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 15 Feb 2021 18:45:37 +0530
Message-ID: <CAFA6WYPrNPMZFA+u0fMo8T1DBFxu6XAVC4KySP53BarjDhfBQA@mail.gmail.com>
Subject: Re: [PATCH v8 1/4] KEYS: trusted: Add generic trusted keys framework
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <jejb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Janne Karhunen <janne.karhunen@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Markus Wamser <Markus.Wamser@mixed-mode.de>,
        Luke Hinds <lhinds@redhat.com>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        op-tee@lists.trustedfirmware.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 10 Feb 2021 at 22:30, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Tue, Nov 03, 2020 at 09:31:43PM +0530, Sumit Garg wrote:
> > +     case Opt_new:
> > +             key_len = payload->key_len;
> > +             ret = static_call(trusted_key_get_random)(payload->key,
> > +                                                       key_len);
> > +             if (ret != key_len) {
> > +                     pr_info("trusted_key: key_create failed (%d)\n", ret);
> > +                     goto out;
> > +             }
>
> This repeats a regression in existing code, i.e. does not check
> "ret < 0" condition. I noticed this now when I rebased the code
> on top of my fixes.
>
> I.e. it's fixed in my master branch, which caused a merge conflict,
> and I found this.
>

Okay, I will rebase the next version to your master branch.

-Sumit

> /Jarkko
