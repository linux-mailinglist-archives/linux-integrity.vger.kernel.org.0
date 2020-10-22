Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E720295D8D
	for <lists+linux-integrity@lfdr.de>; Thu, 22 Oct 2020 13:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441517AbgJVLlD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 22 Oct 2020 07:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503032AbgJVLlA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 22 Oct 2020 07:41:00 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3994BC0613D4
        for <linux-integrity@vger.kernel.org>; Thu, 22 Oct 2020 04:41:00 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id h20so1550238lji.9
        for <linux-integrity@vger.kernel.org>; Thu, 22 Oct 2020 04:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5gzlInlR4QMg3ZQ/I04CuQTpDYmT0qaMY9vRAxu4Izc=;
        b=mTKSsn/Q3P3WeHCjoX5IQNxgRPV8RleCVN6AJn7mcrVmanmbBnlGkT50iAk+PxYC5j
         qQp9dWwiw/3KBUeWUcdU8Fz65Z4hbWiPLxYfYlJ2km2Apub6hdQ90j9/EiD63ru4QnUC
         35Uu1f/K8zugcF0ZzbhV7dVmvdFnKt8vmm0OwH+9M+1zea7hY/I8uqan0ceGDBy9koWS
         /SDmF5NqmFjznRTDWV9I8pKTm6iE2ADiCMXGzc9L7H0LAPxeKUHetrcuREUBZUMYa317
         N/Dl8oD6wbmqaIyz6NX3u4V0w3I3OT4GnY6XMDFUUV8EWkgXIogzyJhTUm/ubnNSrbib
         Vy9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5gzlInlR4QMg3ZQ/I04CuQTpDYmT0qaMY9vRAxu4Izc=;
        b=h0093Sp+olyuVqn104Vd+OrVWnnE8257gp5o5nLPPXehJsVy9H6xBSbstbN6WUKVOR
         DtufpGrxdPtYmbmSPKBK34DhAq2R4g0JAgOIFVkviyEON2ZDVi8gAXTIxf6pShm3r6jy
         0TxLzmhgbnvdrOcT3WrgG+TUD7Oma+Gqjlak7O0xiPTVqDzEMQaB8/VxdKKPyWEYNJuQ
         1n7qQeFk4yu1AZRPfiBMcPsiOFTFdIpnw9jkRc78GD0xyoWpuVPGuExqR/ZWlQIhz/O0
         jtbT2JVzn5e3QP4vgKmQEYWhtBcCpW48vXmgIaGP45w1nmfwkVly0x9VPFRUINAHwOHW
         Lb7Q==
X-Gm-Message-State: AOAM53252JjRw2g3+7yR4R3Y/mq4RHjBM8SuTHNnUrgW2D7WpvsCtKVm
        vFJs36AY9C+mms+ILoDzx9HBeWvbpFmVpV2bTYYBiqGm62I=
X-Google-Smtp-Source: ABdhPJxUbvoDDVe1JBLdhgQ6HTPf1Z1n3SNPOWQyCMzodZYqfouUt/OW/JYE6i7f1PkVqM+wnwM+ontG7U00cKi1ihU=
X-Received: by 2002:a2e:b009:: with SMTP id y9mr751337ljk.372.1603366858536;
 Thu, 22 Oct 2020 04:40:58 -0700 (PDT)
MIME-Version: 1.0
References: <1602065268-26017-1-git-send-email-sumit.garg@linaro.org>
 <1602065268-26017-2-git-send-email-sumit.garg@linaro.org> <8e07f9401c9f7e18fb1453b7b290472c0049c6e6.camel@linux.ibm.com>
 <CAFA6WYM7aJwP9j_ayGvbJPu-cyv87rsm9N4Wj2OCOMnmfDx+Rw@mail.gmail.com> <7b2ccd620a9de5c2fd57b8e8aeb41d5476f83b28.camel@linux.ibm.com>
In-Reply-To: <7b2ccd620a9de5c2fd57b8e8aeb41d5476f83b28.camel@linux.ibm.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 22 Oct 2020 17:10:46 +0530
Message-ID: <CAFA6WYMk8g8i+zcEHYsUcZBq4_k5yGwYzLdEOMbRRnobz9xT4A@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] KEYS: trusted: Add generic trusted keys framework
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
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
        linux-security-module@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        op-tee@lists.trustedfirmware.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 21 Oct 2020 at 17:55, Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Wed, 2020-10-21 at 11:16 +0530, Sumit Garg wrote:
> > Thanks Mimi for your comments.
> >
> > On Wed, 21 Oct 2020 at 08:51, Mimi Zohar <zohar@linux.ibm.com> wrote:
> > >
> > > On Wed, 2020-10-07 at 15:37 +0530, Sumit Garg wrote:
> > >
> > > > +/*
> > > > + * trusted_destroy - clear and free the key's payload
> > > > + */
> > > > +static void trusted_destroy(struct key *key)
> > > > +{
> > > > +     kfree_sensitive(key->payload.data[0]);
> > > > +}
> > > > +
> > > > +struct key_type key_type_trusted = {
> > > > +     .name = "trusted",
> > > > +     .instantiate = trusted_instantiate,
> > > > +     .update = trusted_update,
> > > > +     .destroy = trusted_destroy,
> > > > +     .describe = user_describe,
> > > > +     .read = trusted_read,
> > > > +};
> > > > +EXPORT_SYMBOL_GPL(key_type_trusted);
> > > > +
> > > > +static int __init init_trusted(void)
> > > > +{
> > > > +     int i, ret = 0;
> > > > +
> > > > +     for (i = 0; i < ARRAY_SIZE(trusted_key_sources); i++) {
> > > > +             if (trusted_key_source &&
> > > > +                 strncmp(trusted_key_source, trusted_key_sources[i].name,
> > > > +                         strlen(trusted_key_sources[i].name)))
> > > > +                     continue;
> > > > +
> > > > +             trusted_key_ops = trusted_key_sources[i].ops;
> > > > +
> > > > +             ret = trusted_key_ops->init();
> > > > +             if (!ret)
> > > > +                     break;
> > > > +     }
> > >
> > > In the case when the module paramater isn't specified and both TPM and
> > > TEE are enabled, trusted_key_ops is set to the last source initialized.
> >
> > I guess there is some misunderstanding. Here it's only a single trust
> > source (TPM *or* TEE) is initialized and only that trust source would
> > be active at runtime. And trusted_key_ops would be initialized to the
> > first trust source whose initialization is successful (see check: "if
> > (!ret)").
>
> My mistake.
>
> >
> > > After patch 2/4, the last trusted source initialized is TEE.  If the
> > > intention is to limit it to either TPM or TEE, then trusted_key_ops
> > > should have a default value, which could be overwritten at runtime.
> > > That would address Luke Hind's concerns of making the decision at
> > > compile time.
> >
> > I think traversing the trust source list with the initial value being
> > TPM would be default value.
>
> Agreed
> >
> > >
> > > trusted_key_ops should be defined as __ro_after_init, like is currently
> > > done for other LSM structures.
> >
> > Sure, will do.
>
> Thanks
> >
> > >
> > > > +
> > > > +     /*
> > > > +      * encrypted_keys.ko depends on successful load of this module even if
> > > > +      * trusted key implementation is not found.
> > > > +      */
> > > > +     if (ret == -ENODEV)
> > > > +             return 0;
> > > > +
> > > > +     return ret;
> > > > +}
> > > > +
> > > > +static void __exit cleanup_trusted(void)
> > > > +{
> > > > +     trusted_key_ops->exit();
> > >
> > > If the intention is really to support both TPM and TEE trusted keys at
> > > the same time, as James suggested, then the same "for" loop as in
> > > init_trusted() is needed here and probably elsewhere.
> >
> > Current intention is to only support a single trust source (TPM or
> > TEE) at runtime. But in future if there are use-cases then framework
> > can be extended to support multiple trust sources at runtime as well.
>
> Ok, the last sentence of the patch description, "Also, add a module
> parameter in order to select a particular trust source in case a
> platform support multiple trust sources.", needs to be expanded to:
> - indicate only one trust source at a time is supported
> - indicate the default, if the module_param is not specified
>

Sure, I will expand that.

> I would also change the word from "add" to "define".

Ack.

>   The new "source"
> module parameter needs to be added to the admin-guide/kernel-parameters
> documentation.

Okay, will update documentation as well.

-Sumit

>
> thanks,
>
> Mimi
>
>
