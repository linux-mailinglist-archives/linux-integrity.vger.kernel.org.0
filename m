Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 135C8261D35
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Sep 2020 21:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732128AbgIHTdb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 8 Sep 2020 15:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730913AbgIHP6F (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Sep 2020 11:58:05 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B105C061757;
        Tue,  8 Sep 2020 04:58:19 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id n61so6920097ota.10;
        Tue, 08 Sep 2020 04:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RaWHN9Jo7paHemHHjwRTQUV3IWjnykqiJCEfEZHv7v4=;
        b=XQJxy7+drpA1/z007ulMkN1jJfrJxnTwWTH7zUGrIvWJbJN/3LQI4R21MC1hN4WRp6
         4kqIdNmyaIJ8lg2NMqPGV95EHEsf7vWCB6IPgQTTdW7payVALTglDWFIuYyCKnJ6StQI
         PYiEBLEtxx92y+l6XQPXuO1oAM/WKMsCF7R6ovnwoTY14MoJvAMMYLE1Akv7L2YKOJJ4
         +ybd56OJWwmLmy28WsspezZ/bpMcnR3H8ZPlYFqhhXSipTD+pZ7qDP9vHvFKbTo49SaH
         cX1TL6uThBQb90O1HCoWkGJYZ2DkTVE9/WL5LveRkbgFocRBpn+hd0x7ycOMyDmaZSk6
         zZ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RaWHN9Jo7paHemHHjwRTQUV3IWjnykqiJCEfEZHv7v4=;
        b=p2xlqr+1WniT2A6WT+yBhElbaO2UFJcerBkdrkgWhG4m8HXleQ3IYb9YMlMuWbROxy
         9AD99POu9PECdQtZXCl/EcPEt28/86pnDQ0VXr/BvK69eqaTMyMXGeq85ghhyGLsWr/Q
         53ne5+Ciyw5vd7SNv9M9tqSZkCBXBiNSj5WjSm/JfEoOMVyqkUx1rWt0BKHXH/PEjmzV
         DQoDNpq0xlZjpTbTRtYnwGbh79cYbAI8QrHPPbFPqgvBsfrG5Nw+ObYDAkYyAXtEw4uE
         ytmjRs34o9TDnqgsKMA7rgJzxJ8qiMetZZ6GWTbagOw1H48dezVB9dhminMkwb+0wFxP
         SQDQ==
X-Gm-Message-State: AOAM533hfWKFe/muPYheZ9u6ktWf/NZX+g8QIelPhUbtxRZJXqXVxBSl
        f+FH25ZFC1bhjfayZwg6Lf/EwcgY89CAhbHsjkg=
X-Google-Smtp-Source: ABdhPJy4RDBv/VXPUBpaer4WIVk5Krko0ixIBq7GboCRidoUovp5rSQSrsUWSyZ+VjFWU7QoAysy6HdfwaIl6E+FSAk=
X-Received: by 2002:a9d:185:: with SMTP id e5mr18127205ote.135.1599566298111;
 Tue, 08 Sep 2020 04:58:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200907213855.3572-1-nramas@linux.microsoft.com>
 <CAEjxPJ5C64AmmVKuuPmtbfnY06w49ziryRAnARurWxpQumzfow@mail.gmail.com> <7c4e2e9f-54e1-1dee-c33c-64dac0fe9678@linux.microsoft.com>
In-Reply-To: <7c4e2e9f-54e1-1dee-c33c-64dac0fe9678@linux.microsoft.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 8 Sep 2020 07:58:07 -0400
Message-ID: <CAEjxPJ6eGcmbtGX7Kvn8e=ZxBUQD5G=8D+o9-BsVXyDFcyPYMw@mail.gmail.com>
Subject: Re: [PATCH] SELinux: Measure state and hash of policy using IMA
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        tusharsu@linux.microsoft.com, Sasha Levin <sashal@kernel.org>,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Sep 8, 2020 at 12:44 AM Lakshmi Ramasubramanian
<nramas@linux.microsoft.com> wrote:
>
> On 9/7/20 3:32 PM, Stephen Smalley wrote:
>
> >> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> >> Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> >> Reported-by: kernel test robot <lkp@intel.com> # error: implicit declaration of function 'vfree'
> >> Reported-by: kernel test robot <lkp@intel.com> # error: implicit declaration of function 'crypto_alloc_shash'
> >> Reported-by: kernel test robot <lkp@intel.com> # sparse: symbol 'security_read_selinux_policy' was not declared. Should it be static?
> >
> > Not sure these Reported-by lines are useful since they were just on
> > submitted versions of the patch not on an actual merged commit.
>
> I'll remove them when I update the patch.
>
> >
> >> diff --git a/security/selinux/measure.c b/security/selinux/measure.c
> >> new file mode 100644
> >> index 000000000000..caf9107937d9
> >> --- /dev/null
> >> +++ b/security/selinux/measure.c
> > <snip>
> >> +void selinux_measure_state(struct selinux_state *state, bool policy_mutex_held)
> >> +{
> > <snip>
> >> +
> >> +       if (!policy_mutex_held)
> >> +               mutex_lock(&state->policy_mutex);
> >> +
> >> +       rc = security_read_policy_kernel(state, &policy, &policy_len);
> >> +
> >> +       if (!policy_mutex_held)
> >> +               mutex_unlock(&state->policy_mutex);
> >
> > This kind of conditional taking of a mutex is generally frowned upon
> > in my experience.
> > You should likely just always take the mutex in the callers of
> > selinux_measure_state() instead.
> > In some cases, it may be the caller of the caller.  Arguably selinuxfs
> > could be taking it around all state modifying operations (e.g.
> > enforce, checkreqprot) not just policy modifying ones although it
> > isn't strictly for that purpose.
>
> Since currently policy_mutex is not used to synchronize access to state
> variables (enforce, checkreqprot, etc.) I am wondering if
> selinux_measure_state() should measure only state if policy_mutex is not
> held by the caller - similar to how we skip measuring policy if
> initialization is not yet completed.

No, we want to measure policy whenever there is a policy to measure.
Just move the taking of the mutex to the callers of
selinux_measure_state() so that it can be unconditional.
