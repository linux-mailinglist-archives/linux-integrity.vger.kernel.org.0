Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B08923669AF
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Apr 2021 13:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235477AbhDULJC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 21 Apr 2021 07:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbhDULJA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 21 Apr 2021 07:09:00 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5127C06138B
        for <linux-integrity@vger.kernel.org>; Wed, 21 Apr 2021 04:08:26 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id o16so47223580ljp.3
        for <linux-integrity@vger.kernel.org>; Wed, 21 Apr 2021 04:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5vsFMFaKIMkhP70S7ONG1ckJYw2FgvZBNb6u59s1fGc=;
        b=ZBT06dLsvztfw1xjQmmB/pjvhgkf7DMWRfAgP5YYSnz2HDVhcMXMiNOAyBXCcOvoHa
         V0kTOSdtqSAGODZ0r0EZCgc6Z3dGLyQWzrN/d1oU1BQmVR0wIAUcPZVNIa8Af9j1FPYM
         ff+2+S64VEiFGOaBDRgn1ifYr0tUQy7DoZjcCO7OjYHB+8v5tfeiF2ddXgauIwV+uNQ4
         rj1zLdAzdhSiJ40iHxbdOkQzvmD1ONghDlJzZ38ncJ/wqUjHrSUUeE0FpLhLP3aYZ23S
         ATZ5Qgm4/Rry1sJhqvHJ2wj4ouR72yFt8EkiAUtTZQkqxiweqcS7wbvYsQSiNviJUs5+
         QJ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5vsFMFaKIMkhP70S7ONG1ckJYw2FgvZBNb6u59s1fGc=;
        b=EGXnpU07tcq6Lh4hHCxu7Zw971KjfyXZuMg0qhPNb5+Wc+GI7K2ksjQwvKpBNreZf1
         LMuQHp91TweclAK5luhneFSmuN7efDZ5RcT+9o9ETfGiSABE90/yYSyXe6LjKixCu9Xc
         bs/wbK5ZyGMMOzk+Dt7Tk8RMgUNqb5ievCIJ1x+jvJs55Wr67UbEHEnOlNK2TXyWiolf
         xeFYtsk6FZYjOgnxy7q75Tid5c+CEqPCxdxaX7neyeL5itwlimxqBt3HbI3aQxHAQBnU
         Ti+z5iYpAMZBsr77dXPF/7MWk25F+BJbjsZJ6VbtuatlFJbW9BSiZMw3n1PQbbfX68W0
         zAGw==
X-Gm-Message-State: AOAM533GX271fyUFomvDHm9hD46DOUtLHFNB8xGtJ7zeclMQ5bcxfUej
        WJHifys+/EGsHzUtjMBO3axNMpSYMJVkM2ZUtfluiw==
X-Google-Smtp-Source: ABdhPJwaegw70cJJy3Edi5i/4oe70hllUJl1y43pJwLDxP0VjpQewritsMBNzP3BZVbcnnaGSvQftnnQmer4QqTg/zU=
X-Received: by 2002:a2e:9741:: with SMTP id f1mr7648316ljj.226.1619003304914;
 Wed, 21 Apr 2021 04:08:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210301131127.793707-1-sumit.garg@linaro.org>
 <20210301131127.793707-2-sumit.garg@linaro.org> <65dcc9fa28833e6beb1eadf98b0ed3402404d693.camel@linux.ibm.com>
In-Reply-To: <65dcc9fa28833e6beb1eadf98b0ed3402404d693.camel@linux.ibm.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 21 Apr 2021 16:38:13 +0530
Message-ID: <CAFA6WYOzD-qhHrcnzvd9P7iFvEqWwf0NCKXrgrEgvnB5i_-SxQ@mail.gmail.com>
Subject: Re: [PATCH v9 1/4] KEYS: trusted: Add generic trusted keys framework
To:     James Bottomley <jejb@linux.ibm.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
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
        Luke Hinds <lhinds@redhat.com>,
        Elaine Palmer <erpalmer@us.ibm.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
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

Hi James,

On Wed, 21 Apr 2021 at 04:47, James Bottomley <jejb@linux.ibm.com> wrote:
>
> On Mon, 2021-03-01 at 18:41 +0530, Sumit Garg wrote:
> > Current trusted keys framework is tightly coupled to use TPM device
> > as an underlying implementation which makes it difficult for
> > implementations like Trusted Execution Environment (TEE) etc. to
> > provide trusted keys support in case platform doesn't posses a TPM
> > device.
> >
> > Add a generic trusted keys framework where underlying implementations
> > can be easily plugged in. Create struct trusted_key_ops to achieve
> > this, which contains necessary functions of a backend.
> >
> > Also, define a module parameter in order to select a particular trust
> > source in case a platform support multiple trust sources. In case its
> > not specified then implementation itetrates through trust sources
> > list starting with TPM and assign the first trust source as a backend
> > which has initiazed successfully during iteration.
> >
> > Note that current implementation only supports a single trust source
> > at runtime which is either selectable at compile time or during boot
> > via aforementioned module parameter.
>
> You never actually tested this, did you?  I'm now getting EINVAL from
> all the trusted TPM key operations because of this patch.
>

Unfortunately, I don't possess a development machine with a TPM
device. So mine testing was entirely based on TEE as a backend which
doesn't support any optional parameters. And that being the reason I
didn't catch this issue at first instance.

Is there any TPM emulation environment available that I can use for testing?

> The reason is quite simple:  this function:
>
> > index 000000000000..0db86b44605d
> > --- /dev/null
> > +++ b/security/keys/trusted-keys/trusted_core.c
> [...]
> > +static int datablob_parse(char *datablob, struct trusted_key_payload
> > *p)
> > +{
> > +     substring_t args[MAX_OPT_ARGS];
> > +     long keylen;
> > +     int ret = -EINVAL;
> > +     int key_cmd;
> > +     char *c;
> > +
> > +     /* main command */
> > +     c = strsep(&datablob, " \t");
>
> Modifies its argument to consume tokens and separates them with NULL.
>
> so the arguments for
>
> keyctl add trusted kmk "new 34 keyhandle=0x81000001"
>
> Go into this function as
>
> datablob="new 34 keyhandle=0x81000001"
>
> After we leave it, it looks like
>
> datablob="new\034\0keyhandle=0x81000001"
>
> However here:
>
> > +static int trusted_instantiate(struct key *key,
> > +                            struct key_preparsed_payload *prep)
> > +{
> > +     struct trusted_key_payload *payload = NULL;
> > +     size_t datalen = prep->datalen;
> > +     char *datablob;
> > +     int ret = 0;
> > +     int key_cmd;
> > +     size_t key_len;
> > +
> > +     if (datalen <= 0 || datalen > 32767 || !prep->data)
> > +             return -EINVAL;
> > +
> > +     datablob = kmalloc(datalen + 1, GFP_KERNEL);
> > +     if (!datablob)
> > +             return -ENOMEM;
> > +     memcpy(datablob, prep->data, datalen);
> > +     datablob[datalen] = '\0';
> > +
> > +     payload = trusted_payload_alloc(key);
> > +     if (!payload) {
> > +             ret = -ENOMEM;
> > +             goto out;
> > +     }
> > +
> > +     key_cmd = datablob_parse(datablob, payload);
> > +     if (key_cmd < 0) {
> > +             ret = key_cmd;
> > +             goto out;
> > +     }
> > +
> > +     dump_payload(payload);
> > +
> > +     switch (key_cmd) {
> > +     case Opt_load:
> > +             ret = static_call(trusted_key_unseal)(payload,
> > datablob);
>
> We're passing the unmodified
>
> datablob="new\034\0keyhandle=0x81000001"
>
> Into the tpm trusted_key_unseal function.  However, it only sees "new"
> and promply gives EINVAL because you've removed the ability to process
> the new option from it.  What should have happened is you should have
> moved data blob up to passed the consumed tokens, so it actually reads
>
> datablob="keyhandle=0x81000001"
>
> However, to do that you'd have to have the updated pointer passed out
> of your datablob_parse() above.

Thanks for the detailed explanation.

>
> There's also a lost !tpm2 in the check for options->keyhandle, but I
> suspect Jarkko lost that merging the two patches.  I think what's below
> fixes all of this, so if you can test it for trusted_tee, I'll package
> it up as two separate patches fixing all of this.
>

Below fixes look good to me and I have tested them using TEE as a
backend too. So feel free to add:

Tested-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> James
>
> ---
>
> diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
> index ec3a066a4b42..7c636212429b 100644
> --- a/security/keys/trusted-keys/trusted_core.c
> +++ b/security/keys/trusted-keys/trusted_core.c
> @@ -62,7 +62,7 @@ static const match_table_t key_tokens = {
>   *
>   * On success returns 0, otherwise -EINVAL.
>   */
> -static int datablob_parse(char *datablob, struct trusted_key_payload *p)
> +static int datablob_parse(char **datablob, struct trusted_key_payload *p)
>  {
>         substring_t args[MAX_OPT_ARGS];
>         long keylen;
> @@ -71,14 +71,14 @@ static int datablob_parse(char *datablob, struct trusted_key_payload *p)
>         char *c;
>
>         /* main command */
> -       c = strsep(&datablob, " \t");
> +       c = strsep(datablob, " \t");
>         if (!c)
>                 return -EINVAL;
>         key_cmd = match_token(c, key_tokens, args);
>         switch (key_cmd) {
>         case Opt_new:
>                 /* first argument is key size */
> -               c = strsep(&datablob, " \t");
> +               c = strsep(datablob, " \t");
>                 if (!c)
>                         return -EINVAL;
>                 ret = kstrtol(c, 10, &keylen);
> @@ -89,7 +89,7 @@ static int datablob_parse(char *datablob, struct trusted_key_payload *p)
>                 break;
>         case Opt_load:
>                 /* first argument is sealed blob */
> -               c = strsep(&datablob, " \t");
> +               c = strsep(datablob, " \t");
>                 if (!c)
>                         return -EINVAL;
>                 p->blob_len = strlen(c) / 2;
> @@ -138,7 +138,7 @@ static int trusted_instantiate(struct key *key,
>  {
>         struct trusted_key_payload *payload = NULL;
>         size_t datalen = prep->datalen;
> -       char *datablob;
> +       char *datablob, *orig_datablob;
>         int ret = 0;
>         int key_cmd;
>         size_t key_len;
> @@ -146,7 +146,7 @@ static int trusted_instantiate(struct key *key,
>         if (datalen <= 0 || datalen > 32767 || !prep->data)
>                 return -EINVAL;
>
> -       datablob = kmalloc(datalen + 1, GFP_KERNEL);
> +       orig_datablob = datablob = kmalloc(datalen + 1, GFP_KERNEL);
>         if (!datablob)
>                 return -ENOMEM;
>         memcpy(datablob, prep->data, datalen);
> @@ -158,7 +158,7 @@ static int trusted_instantiate(struct key *key,
>                 goto out;
>         }
>
> -       key_cmd = datablob_parse(datablob, payload);
> +       key_cmd = datablob_parse(&datablob, payload);
>         if (key_cmd < 0) {
>                 ret = key_cmd;
>                 goto out;
> @@ -194,7 +194,7 @@ static int trusted_instantiate(struct key *key,
>                 ret = -EINVAL;
>         }
>  out:
> -       kfree_sensitive(datablob);
> +       kfree_sensitive(orig_datablob);
>         if (!ret)
>                 rcu_assign_keypointer(key, payload);
>         else
> @@ -218,7 +218,7 @@ static int trusted_update(struct key *key, struct key_preparsed_payload *prep)
>         struct trusted_key_payload *p;
>         struct trusted_key_payload *new_p;
>         size_t datalen = prep->datalen;
> -       char *datablob;
> +       char *datablob, *orig_datablob;
>         int ret = 0;
>
>         if (key_is_negative(key))
> @@ -229,7 +229,7 @@ static int trusted_update(struct key *key, struct key_preparsed_payload *prep)
>         if (datalen <= 0 || datalen > 32767 || !prep->data)
>                 return -EINVAL;
>
> -       datablob = kmalloc(datalen + 1, GFP_KERNEL);
> +       orig_datablob = datablob = kmalloc(datalen + 1, GFP_KERNEL);
>         if (!datablob)
>                 return -ENOMEM;
>
> @@ -241,7 +241,7 @@ static int trusted_update(struct key *key, struct key_preparsed_payload *prep)
>
>         memcpy(datablob, prep->data, datalen);
>         datablob[datalen] = '\0';
> -       ret = datablob_parse(datablob, new_p);
> +       ret = datablob_parse(&datablob, new_p);
>         if (ret != Opt_update) {
>                 ret = -EINVAL;
>                 kfree_sensitive(new_p);
> @@ -265,7 +265,7 @@ static int trusted_update(struct key *key, struct key_preparsed_payload *prep)
>         rcu_assign_keypointer(key, new_p);
>         call_rcu(&p->rcu, trusted_rcu_free);
>  out:
> -       kfree_sensitive(datablob);
> +       kfree_sensitive(orig_datablob);
>         return ret;
>  }
>
> diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
> index 4e5c50138f92..bc702ba0a596 100644
> --- a/security/keys/trusted-keys/trusted_tpm1.c
> +++ b/security/keys/trusted-keys/trusted_tpm1.c
> @@ -747,6 +747,9 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
>
>         opt->hash = tpm2 ? HASH_ALGO_SHA256 : HASH_ALGO_SHA1;
>
> +       if (!c)
> +               return 0;
> +
>         while ((p = strsep(&c, " \t"))) {
>                 if (*p == '\0' || *p == ' ' || *p == '\t')
>                         continue;
> @@ -944,7 +947,7 @@ static int trusted_tpm_unseal(struct trusted_key_payload *p, char *datablob)
>                 goto out;
>         dump_options(options);
>
> -       if (!options->keyhandle) {
> +       if (!options->keyhandle && !tpm2) {
>                 ret = -EINVAL;
>                 goto out;
>         }
>
>
