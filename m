Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 997C926F671
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Sep 2020 09:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgIRHDb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 18 Sep 2020 03:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgIRHDa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 Sep 2020 03:03:30 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB30C06174A
        for <linux-integrity@vger.kernel.org>; Fri, 18 Sep 2020 00:03:30 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id z19so4987738lfr.4
        for <linux-integrity@vger.kernel.org>; Fri, 18 Sep 2020 00:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NmmjmHcBY8BbhioV7WK8K+GOMybyd/oBkZZKD/aKF+E=;
        b=aYMkTBVEhpmeibkJNMW8F0pM9TM7QFOuWu/3srU31dDTGy8DT7vhwP20g1CaVTkKED
         tln3quJTl/JUFcaUYDO+GW1fOyC7OZcRlLfOjlVvUTecHce9SzjaOVjHH1Pqyll8JB4K
         GqE11kfv6p9VAaMUrG+NvXu5AnHWPGGxmemtz02FxTVDSwd33MMwzBDPoL9q+VRvzXk+
         isfXxEhOGHr08L0zlwQO0PZI+6DtNPGih9FniPrTlrkE3HHi3NudmVg7zO+gZMdIjknU
         /+Ovorz6Sc/96FRDNZIJAVDrUI0mfOkt3rPTpKfRJ8iuKXg0vYQRu9k7jw//2ksgPGnd
         Hekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NmmjmHcBY8BbhioV7WK8K+GOMybyd/oBkZZKD/aKF+E=;
        b=lR+QLOHZZ+RVZWxeOcMzg8qRjvoROjpGy9m3o0uaFNwqB2tuKx9DsIRuVDFDu7ieVR
         l89vkRT51WELnvIrmRUU6BNjLj0h7sjPdW560Ag1ywUCmMVpIP9L4NDo+H0hDQVyVGo6
         mIJKQCxRw7zXvorX69W6ToMlqPd7qSykG3jLPSxeFDFIX45jsLsgEsP6W7CY6IGSlghP
         AK5AxdwxVFo8SMvGSosqmPdNX4MtrQh2ayV1IBVXVEtHIXR8l80p+Ua1WiKmfp00Mksl
         Wxu2mmxHrUHN1E/AF9KGQ1tkYOeYWshynNDyBOPdGd5RS1KVdGF1s3Xc8npv1howQ5CL
         7dNA==
X-Gm-Message-State: AOAM531mjYebeHGbSfNnh0CbEe2GW81Hl5drjAtsg4bkWDb9BtYDtNEJ
        lzjA2P9+3EB3jsfOzGoNofFn2PYi5Hdd/NphJI+XmQ==
X-Google-Smtp-Source: ABdhPJz6k7WIbUShytMLjZXYouPFD4sNGIoslozx6Fxb93jmSonJHYJ1qWh6s2afHrjoNsg/kefS7+OKREWfMI/SpYc=
X-Received: by 2002:a05:6512:2e5:: with SMTP id m5mr9808120lfq.598.1600412608442;
 Fri, 18 Sep 2020 00:03:28 -0700 (PDT)
MIME-Version: 1.0
References: <1600350398-4813-1-git-send-email-sumit.garg@linaro.org>
 <1600350398-4813-2-git-send-email-sumit.garg@linaro.org> <20200917162142.GB9750@linux.intel.com>
 <20200917162506.GC9750@linux.intel.com>
In-Reply-To: <20200917162506.GC9750@linux.intel.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 18 Sep 2020 12:33:17 +0530
Message-ID: <CAFA6WYNR2rMkEskJooDjQuu+dQ_zwVq-_9paW=zBgXmqM1GJqA@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] KEYS: trusted: Add generic trusted keys framework
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
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

On Thu, 17 Sep 2020 at 21:55, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Thu, Sep 17, 2020 at 07:21:49PM +0300, Jarkko Sakkinen wrote:
> > On Thu, Sep 17, 2020 at 07:16:35PM +0530, Sumit Garg wrote:
> > > Current trusted keys framework is tightly coupled to use TPM device as
> > > an underlying implementation which makes it difficult for implementations
> > > like Trusted Execution Environment (TEE) etc. to provide trusted keys
> > > support in case platform doesn't posses a TPM device.
> > >
> > > So this patch tries to add generic trusted keys framework where underlying
> > > implementations like TPM, TEE etc. could be easily plugged-in.
> >
> > I would rephrase this a bit:
> >
> > "Add a generic trusted keys framework where underlying implementations
> > can be easily plugged in. Create struct trusted_key_ops to achieve this,
> > which contains necessary functions of a backend."
> >

Okay, will use it instead.

> > I remember asking about this approach that what if there was just a
> > header for trusted key functions and a compile time decision, which C
> > file to include instead of ops struct. I don't remember if these was a
> > conclusion on this or not.

This approach was implemented as part of v5 and we concluded here [1]
to revert back to the dynamic approach as distro vendors won't like to
make opinionated selection at compile time which could rather be
achieved dynamically based on platform capability.

[1] https://www.spinics.net/lists/keyrings/msg08161.html

> >
> > E.g. lets say you have a device with TEE and TPM, should you be able
> > to be use both at run-time? I might play along how this works now but
> > somehow, in the commit message preferably, it should be conclude why
> > one alternative is chosen over another.
>

Okay, so how about adding a kernel module parameter which can enforce
the user's preference about which trust source to use at runtime? And
we should only check availability for that trust source if preference
is provided otherwise by default we can traverse the trust sources
list.

See following change, if this approach looks sane, I can include it in
next version:

diff --git a/include/keys/trusted-type.h b/include/keys/trusted-type.h
index edd635a..a566451 100644
--- a/include/keys/trusted-type.h
+++ b/include/keys/trusted-type.h
@@ -63,6 +63,11 @@ struct trusted_key_ops {
        void (*exit)(void);
 };

+struct trusted_key_source {
+       char *name;
+       struct trusted_key_ops *ops;
+};
+
 extern struct key_type key_type_trusted;

 #define TRUSTED_DEBUG 0
diff --git a/security/keys/trusted-keys/trusted_core.c
b/security/keys/trusted-keys/trusted_core.c
index 83a6a15..74a3d80 100644
--- a/security/keys/trusted-keys/trusted_core.c
+++ b/security/keys/trusted-keys/trusted_core.c
@@ -21,12 +21,16 @@
 #include <linux/string.h>
 #include <linux/uaccess.h>

-static struct trusted_key_ops *available_trusted_key_ops[] = {
+static char *trusted_key_source;
+module_param_named(source, trusted_key_source, charp, 0);
+MODULE_PARM_DESC(source, "Select trusted keys source (tpm or tee)");
+
+static struct trusted_key_source trusted_key_sources[] = {
 #if defined(CONFIG_TCG_TPM)
-       &tpm_trusted_key_ops,
+       { "tpm", &tpm_trusted_key_ops },
 #endif
 #if defined(CONFIG_TEE)
-       &tee_trusted_key_ops,
+       { "tee", &tee_trusted_key_ops },
 #endif
 };
 static struct trusted_key_ops *trusted_key_ops;
@@ -296,8 +300,13 @@ static int __init init_trusted(void)
 {
        int i, ret = 0;

-       for (i = 0; i < sizeof(available_trusted_key_ops); i++) {
-               trusted_key_ops = available_trusted_key_ops[i];
+       for (i = 0; i < ARRAY_SIZE(trusted_key_sources); i++) {
+               if (trusted_key_source &&
+                   strncmp(trusted_key_source, trusted_key_sources[i].name,
+                           strlen(trusted_key_sources[i].name)))
+                       continue;
+
+               trusted_key_ops = trusted_key_sources[i].ops;

                ret = trusted_key_ops->init();
                if (!ret)

> We must somehow seal this discussion because the other changes are
> based on this decision.
>
> I don't think tail of this patch set takes a long time spin. This
> is the main architectural decision.

Agree.

-Sumit

>
> /Jarkko
