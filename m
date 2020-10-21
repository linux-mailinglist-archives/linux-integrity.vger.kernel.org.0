Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 690D12947EB
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Oct 2020 07:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408429AbgJUFqq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 21 Oct 2020 01:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408415AbgJUFqq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 21 Oct 2020 01:46:46 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0ABBC0613D3
        for <linux-integrity@vger.kernel.org>; Tue, 20 Oct 2020 22:46:45 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id z2so1489573lfr.1
        for <linux-integrity@vger.kernel.org>; Tue, 20 Oct 2020 22:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WerPUVIarQXcsPG2PPEIuIxUpZ3fOzaM0sErZC8Uvj8=;
        b=Pz25AI/ZgGEoYZmJG/KQ/6e9wJOYkEcM3fU4cxTMhwpnGFVW//s2gikrdXVqqErNVr
         zD9FmFDCaFYR1Obikt6RE99ezJMB6Nf8WZgVS2L2VJfcQ+DQcdEkh+xmbFetH/l0FvsM
         U7csmAljt5FECfKyfs0iXyZp5gz0E4Gl1MqBsnXQq7EPBjlYFF96SpG686vJfM76aMOC
         IM/v4hslOheQCHYYkKLp7gccz1LORYE0fflkTU13vk8YRqO5L4O8erpR/qT0z5qdVZ5y
         CiXeRKaOlNFZdzO15SN513O8dfYcldrkbSWYA0g+QDU26HzaJ6g+8Wyjb03fiR22qpap
         vwHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WerPUVIarQXcsPG2PPEIuIxUpZ3fOzaM0sErZC8Uvj8=;
        b=aV5UqyvfXvj1YLyfGCQCoV7ko+SHH4ciXrbfJs4ptqRFVEyHPtWZd/zPiDc4Aarezp
         ANGpiPfq8EEdjOLk2rn0eUgF+yWjIoBuq5dKKMItip+aR73g09bNEuxkfC06EW0pOoJC
         Ac/oSJO5PmvWJ7p8NtQc/uyz+1GNHhOAyIqldPfLHa5tPgQ2/jGTfj9q2V/KYhc7iuMJ
         iQCcqh/+URxvXoEKRfrB0oBGMbvX38kZpTbStxPsk/+tAgHRODC4fszeDBD6c/TsJ/Y1
         czvVSzBnrNQUjDLneXuaF6hzOhgaBIvLSGqNuvxT5QN6+ql1gtNlPO/766wk3yDsLSRb
         k3Zw==
X-Gm-Message-State: AOAM530c29NffOa0PiwhVKxZy84uQvl5zCNR8GINVlz6fQbcZq4gF/EG
        hX74Sdbt3yT5InfQFNk1Zl++GQB+3HVf7gfBqZBzqA==
X-Google-Smtp-Source: ABdhPJwDV2L1MFODb6ucOjs+0es8WlLMWrbz8e2HdBKFq1wq79tkl40AoAJdlcTyrjoren7MlXPnsTlS6MAnVD3VB0s=
X-Received: by 2002:a19:c88c:: with SMTP id y134mr497757lff.283.1603259204205;
 Tue, 20 Oct 2020 22:46:44 -0700 (PDT)
MIME-Version: 1.0
References: <1602065268-26017-1-git-send-email-sumit.garg@linaro.org>
 <1602065268-26017-2-git-send-email-sumit.garg@linaro.org> <8e07f9401c9f7e18fb1453b7b290472c0049c6e6.camel@linux.ibm.com>
In-Reply-To: <8e07f9401c9f7e18fb1453b7b290472c0049c6e6.camel@linux.ibm.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 21 Oct 2020 11:16:33 +0530
Message-ID: <CAFA6WYM7aJwP9j_ayGvbJPu-cyv87rsm9N4Wj2OCOMnmfDx+Rw@mail.gmail.com>
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

Thanks Mimi for your comments.

On Wed, 21 Oct 2020 at 08:51, Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Wed, 2020-10-07 at 15:37 +0530, Sumit Garg wrote:
>
> > +/*
> > + * trusted_destroy - clear and free the key's payload
> > + */
> > +static void trusted_destroy(struct key *key)
> > +{
> > +     kfree_sensitive(key->payload.data[0]);
> > +}
> > +
> > +struct key_type key_type_trusted = {
> > +     .name = "trusted",
> > +     .instantiate = trusted_instantiate,
> > +     .update = trusted_update,
> > +     .destroy = trusted_destroy,
> > +     .describe = user_describe,
> > +     .read = trusted_read,
> > +};
> > +EXPORT_SYMBOL_GPL(key_type_trusted);
> > +
> > +static int __init init_trusted(void)
> > +{
> > +     int i, ret = 0;
> > +
> > +     for (i = 0; i < ARRAY_SIZE(trusted_key_sources); i++) {
> > +             if (trusted_key_source &&
> > +                 strncmp(trusted_key_source, trusted_key_sources[i].name,
> > +                         strlen(trusted_key_sources[i].name)))
> > +                     continue;
> > +
> > +             trusted_key_ops = trusted_key_sources[i].ops;
> > +
> > +             ret = trusted_key_ops->init();
> > +             if (!ret)
> > +                     break;
> > +     }
>
> In the case when the module paramater isn't specified and both TPM and
> TEE are enabled, trusted_key_ops is set to the last source initialized.

I guess there is some misunderstanding. Here it's only a single trust
source (TPM *or* TEE) is initialized and only that trust source would
be active at runtime. And trusted_key_ops would be initialized to the
first trust source whose initialization is successful (see check: "if
(!ret)").

> After patch 2/4, the last trusted source initialized is TEE.  If the
> intention is to limit it to either TPM or TEE, then trusted_key_ops
> should have a default value, which could be overwritten at runtime.
> That would address Luke Hind's concerns of making the decision at
> compile time.

I think traversing the trust source list with the initial value being
TPM would be default value.

>
> trusted_key_ops should be defined as __ro_after_init, like is currently
> done for other LSM structures.

Sure, will do.

>
> > +
> > +     /*
> > +      * encrypted_keys.ko depends on successful load of this module even if
> > +      * trusted key implementation is not found.
> > +      */
> > +     if (ret == -ENODEV)
> > +             return 0;
> > +
> > +     return ret;
> > +}
> > +
> > +static void __exit cleanup_trusted(void)
> > +{
> > +     trusted_key_ops->exit();
>
> If the intention is really to support both TPM and TEE trusted keys at
> the same time, as James suggested, then the same "for" loop as in
> init_trusted() is needed here and probably elsewhere.

Current intention is to only support a single trust source (TPM or
TEE) at runtime. But in future if there are use-cases then framework
can be extended to support multiple trust sources at runtime as well.

-Sumit

>
> thanks,
>
> Mimi
>
