Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB6801ECECE
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jun 2020 13:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbgFCLpj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 3 Jun 2020 07:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbgFCLpf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 3 Jun 2020 07:45:35 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAF2C08C5C3
        for <linux-integrity@vger.kernel.org>; Wed,  3 Jun 2020 04:45:34 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id e125so1129042lfd.1
        for <linux-integrity@vger.kernel.org>; Wed, 03 Jun 2020 04:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R6lEVGZYGJxxHN7lE3eo9NqLzCsnQCicun988jWmqf0=;
        b=CcT9D9lZNg/SMdu0oTdh0D/2xb8iHgHFyH7fmH90WYrNn/U+znPsNUWsM5AsKxoBUC
         vVFKe4LUjup9xTgkizKTwyQ0mp3tl+y8Welh9N/GllG4VLXKlxXHjSr9F6k+N7aS+Mdu
         brRhX1nAh2aZFrsppZeJGN+BzJyK3Lq86tRW/+cuA0RgpK9vhrG7icHwQdZTE/6WgEzE
         i9QfGI97QzeIy4v9j5Ft+ogMFQd85zLlT19K8GDYCEQMP+XrX3bHBWhIxegbA2Ze1qk9
         Tp4ZMNmBt1B0C5WbcpAKgxOqrlvbotQ7CtwkSesdW9/OtKZup/VpnJtb/cWiuTEdTFjl
         3sow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R6lEVGZYGJxxHN7lE3eo9NqLzCsnQCicun988jWmqf0=;
        b=clYr75+lPLtsbssB95s5VGbPddVGnxtj0tSaEjnWPupwWgRLTDZLTbRd20twcz0X5m
         8B86wIJd8QDDzkA37HRdRxlRwXlZXH1ReT7roNtYqkTEUw7Evm4RNwzmnZ1U+iXfBKob
         9k6euKk403z3FZwK4f830iK7gbGy6mBFpKc5gFnt595Iu2lfNO6LOAm522NMlwACHVu1
         3LqUsZ7JXcIQnx0fcsi/lqvX37arVdWiRpzImtm9uIVFwE0Xgny58lIAY451HVpDJVVb
         UJ0rD/6riwVnYxEDzLykD5iXsMOyMlKeUnM8sd4OoVwQcV5xafXI56BEzypCGGstc1vc
         H/+g==
X-Gm-Message-State: AOAM532cAseGYTnlZAwQ/WuCGkyfZmdVx8hxbHDSrrBaqAJZKWxQ3OyY
        uBln28yobvWB7E7AUMMl3YbeknUefegN3NJSZ0j6Sw==
X-Google-Smtp-Source: ABdhPJxrRq5dz8jR0pX7TOEXl5+O6MeJ4s3D9zLb2o4VMf6+9QwUKNjv2xRDI0+UrWAaW8w3feNHDUNL6jPLIkqDsJg=
X-Received: by 2002:ac2:44bb:: with SMTP id c27mr2301161lfm.59.1591184732251;
 Wed, 03 Jun 2020 04:45:32 -0700 (PDT)
MIME-Version: 1.0
References: <1591107505-6030-1-git-send-email-sumit.garg@linaro.org>
 <1591108981.4253.17.camel@linux.ibm.com> <CAFA6WYOoMdLJ2g3gocZBZWdu-7Nfw7LKHnzX8S8FKeC7cuNwYg@mail.gmail.com>
 <CAKrSGQSLKpb8T=H9zUoPP1B6EFrgMTMP3ZX1pEv99JtdPq7H0w@mail.gmail.com>
In-Reply-To: <CAKrSGQSLKpb8T=H9zUoPP1B6EFrgMTMP3ZX1pEv99JtdPq7H0w@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 3 Jun 2020 17:15:20 +0530
Message-ID: <CAFA6WYOFO8YptYp2JrY7nQL0MeM02VLCHvtnxUCEDd5-fb-z+Q@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] Introduce TEE based Trusted Keys support
To:     Luke Hinds <lhinds@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Janne Karhunen <janne.karhunen@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Markus Wamser <Markus.Wamser@mixed-mode.de>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        op-tee@lists.trustedfirmware.org,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 3 Jun 2020 at 14:20, Luke Hinds <lhinds@redhat.com> wrote:
>
>
>
> On Wed, Jun 3, 2020 at 9:08 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>>
>> On Tue, 2 Jun 2020 at 20:14, James Bottomley <jejb@linux.ibm.com> wrote:
>> >
>> > On Tue, 2020-06-02 at 19:48 +0530, Sumit Garg wrote:
>> > > Add support for TEE based trusted keys where TEE provides the
>> > > functionality to seal and unseal trusted keys using hardware unique
>> > > key. Also, this is an alternative in case platform doesn't possess a
>> > > TPM device.
>> >
>> > So here's a meta problem: in the case when the platform possesses both
>> > TEE and TPM  what should it do?
>>
>> IMO, trust source (either a TPM or a TEE) should be unique and
>> carefully chosen as per platform security policy corresponding to a
>> particular threat model.
>>
>> And moreover TEEs have been mostly used in the embedded world where
>> having a hardware TPM is cumbersome given constraints regarding BoM
>> cost and hardware resources.
>>
>> >  Things like this:
>> >
>> > > --- a/security/keys/trusted-keys/trusted_core.c
>> > > +++ b/security/keys/trusted-keys/trusted_core.c
>> > > @@ -25,6 +25,8 @@
>> > >
>> > >  #if defined(CONFIG_TRUSTED_TPM)
>> > >  static struct trusted_key_ops *trusted_key_ops =
>> > > &tpm_trusted_key_ops;
>> > > +#elif defined(CONFIG_TRUSTED_TEE)
>> > > +static struct trusted_key_ops *trusted_key_ops =
>> > > &tee_trusted_key_ops;
>> > >  #else
>> >
>> > Say it's either/or at a Kconfig level: so if you select both TEE and
>> > TPM based trusted keys at compile time, we intall the TPM ops and
>> > ignore the TEE ops, is that right?  Surely this should be runtime
>> > selectable based on what the platform has ...
>>
>> This dynamic selection was already part of v4 patch-set but after
>> objection from Jarrko here [1], I switched to compile time mode
>> instead.
>>
>> [1] https://lkml.org/lkml/2020/6/2/139
>
>
> Unless I have misunderstood, my concerns about compile time are that distributors will be cornered into releasing kernels with an opinionated selection of either TEE or TPM and any users needing the non default will need to compile their own kernel.
>

I echo with your concerns.

Jarrko,

If it's fine with you then I can switch back to dynamic approach again
in the next version.

-Sumit

>>
>>
>> > perhaps it should even be
>> > selectable per key?
>> >
>> > Once it is runtime selectable, what should be selected in the both
>> > case?  Or should we allow the user to decide, if so, how?
>> >
>> > when you pipe a trusted key, I think the subtype (TEE or TPM) should be
>> > part of the piped information, so it loads again seamlessly.  This
>> > would actually be fixed by something like the ASN.1 scheme I'm trying
>> > to upstream, at least for TPM keys, but do TEE keys have a recognized
>> > ASN.1 format?
>> >
>>
>> I guess this is something which we can refine later if there are real
>> platforms that have a particular security requirement to support both
>> TPM and a TEE.
>>
>> -Sumit
>>
>> > James
>> >
>>
>
