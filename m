Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F719243EB6
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Aug 2020 20:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbgHMSN4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Aug 2020 14:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgHMSN4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Aug 2020 14:13:56 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A336C061757;
        Thu, 13 Aug 2020 11:13:56 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id v6so5515320ota.13;
        Thu, 13 Aug 2020 11:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dhX3aJX3q4KBRZHuwYhUlB8a3PTx5z3GZT2mRKIefQc=;
        b=O70/K86V7BRLmfBGJE0TH9C17/lVqUl4Lgy4S0kS11tInrJK2MOBahhZD2luu4L8QQ
         +mFX9nukGFqBDAURjkNYl9uME9J8fpbZ0loY5lzHCGEiu29BMFoeGSoYuDPxjQBFmsTv
         TraI5M07RpmktvbsMNmwNKLaXXs1ir5UoqkrQZIjR/DeBEfvPqV19C1r3/oSU0SmNTkM
         3z8gWjAlkB76ZE0s69wJUEZNwLCPb9rhlJfeywQ/wKQlyZip1VjzrhM8DHSp6d5mAUE2
         XJwMJx0dkfmqgLk6Rd+sl4QPO/hPHSfXENlg9CM7nFxXgUxI96OjqBdbLI/IjjJcH3eQ
         ut7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dhX3aJX3q4KBRZHuwYhUlB8a3PTx5z3GZT2mRKIefQc=;
        b=HCoLhQS/WJCOiitamNUFnfGZt15r7ZSGP60kn8Z3xzDKjZDkH3IFBPl8sG37GNr/Ub
         /4DwCMym1LZCqaeS+Y0pX0vgXww0l26Iuk/aFStj9pYkNxET2bekxLsWtLAaX4ELn7lt
         EVtLRlyc/x+VN0QaIoILHJmatISVBw0laDrKqabDYl9ieNQZH0RGom+KozAqG3HSPxhM
         9tjH6BAMYOZUsijG4UKtCl2e3OQanA/mWosoPVmP0/WcYWXcXMrDKRHFStwGbev1H8ro
         ofKZ+K9WZKczddx0SaNMt8cgYwib8ISs2ZgROQ3O8gF2ZL2IC4Y6kzzqo3ljEf8zrVOv
         mfLA==
X-Gm-Message-State: AOAM532bwXiiH7S9cOzbzQ45BHfgRv7QD/MxrpiRTuxPTt5LaHxgJpQ+
        ZsyItQoRptFrDSRY+BpZeof2X1jZ01T8aCp/WIQ=
X-Google-Smtp-Source: ABdhPJx2bvI3Rcu75oszf3a1VUhxpWcU0mTJSg09XxObt4VR5yVboneZks0z+JwshzLZrQqB8p8Tq/1r4jOxjCUOnY0=
X-Received: by 2002:a05:6830:16d8:: with SMTP id l24mr5198130otr.89.1597342435667;
 Thu, 13 Aug 2020 11:13:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200813170707.2659-1-nramas@linux.microsoft.com>
 <20200813170707.2659-3-nramas@linux.microsoft.com> <5f738fd8-fe28-5358-b3d8-b671b45caa7f@gmail.com>
 <7315b7e8-2c53-2555-bc2e-aae42e16aaa2@linux.microsoft.com>
 <CAEjxPJ6sZdm2w=bbkL0uJyEkHw0gCT_y812WQBZPtLCJzO6r3A@mail.gmail.com> <e935c06f-09e2-a2f7-f97f-768bc017f477@linux.microsoft.com>
In-Reply-To: <e935c06f-09e2-a2f7-f97f-768bc017f477@linux.microsoft.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 13 Aug 2020 14:13:44 -0400
Message-ID: <CAEjxPJ7uWee5jjALtQ3azMvKRMk8pxFiYByWmYVhjgJiMNZ8ww@mail.gmail.com>
Subject: Re: [PATCH 2/2] SELinux: Measure state and hash of policy using IMA
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        tusharsu@linux.microsoft.com, sashal@kernel.org,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Aug 13, 2020 at 2:03 PM Lakshmi Ramasubramanian
<nramas@linux.microsoft.com> wrote:
>
> On 8/13/20 10:58 AM, Stephen Smalley wrote:
> > On Thu, Aug 13, 2020 at 1:52 PM Lakshmi Ramasubramanian
> > <nramas@linux.microsoft.com> wrote:
> >>
> >> On 8/13/20 10:42 AM, Stephen Smalley wrote:
> >>
> >>>> diff --git a/security/selinux/measure.c b/security/selinux/measure.c
> >>>> new file mode 100644
> >>>> index 000000000000..f21b7de4e2ae
> >>>> --- /dev/null
> >>>> +++ b/security/selinux/measure.c
> >>>> @@ -0,0 +1,204 @@
> >>>> +static int selinux_hash_buffer(void *buf, size_t buf_len,
> >>>> +                   void **buf_hash, int *buf_hash_len)
> >>>> +{
> >>>> +    struct crypto_shash *tfm;
> >>>> +    struct shash_desc *desc = NULL;
> >>>> +    void *digest = NULL;
> >>>> +    int desc_size;
> >>>> +    int digest_size;
> >>>> +    int ret = 0;
> >>>> +
> >>>> +    tfm = crypto_alloc_shash("sha256", 0, 0);
> >>>> +    if (IS_ERR(tfm))
> >>>> +        return PTR_ERR(tfm);
> >>> Can we make the algorithm selectable via kernel parameter and/or writing
> >>> to a new selinuxfs node?
> >>
> >> I can add a kernel parameter to select this hash algorithm.
> >
> > Also can we provide a Kconfig option for the default value like IMA does?
> >
>
> Would we need both - Kconfig and kernel param?
>
> The other option is to provide an IMA function to return the current
> hash algorithm used for measurement. That way a consistent hash
> algorithm can be employed by both IMA and the callers. Would that be better?

This is why I preferred just passing the serialized policy buffer to
IMA and letting it handle the hashing.  But apparently that approach
wouldn't fly.  IMA appears to support both a Kconfig option for
selecting a default algorithm and a kernel parameter for overriding
it.  I assume the idea is that the distros can pick a reasonable
default and then the end users can override that if they have specific
requirements.  I'd want the same for SELinux.  If IMA is willing to
export its hash algorithm to external components, then I'm willing to
reuse that but not sure if that's a layering violation.
