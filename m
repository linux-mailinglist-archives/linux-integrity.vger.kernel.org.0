Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 739ED226D4D
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Jul 2020 19:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730647AbgGTRlG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 Jul 2020 13:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728876AbgGTRlF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Jul 2020 13:41:05 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71F8C061794;
        Mon, 20 Jul 2020 10:41:05 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id n24so12847671otr.13;
        Mon, 20 Jul 2020 10:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mdh7aaQO3fTgP8bprJCk07MNirNdtGLOsGXoOk/ABZc=;
        b=ZK7xQhCMjjUAUEzYRVR/d2z4PdrUMiWkEwlhkLAYriZTx873OuHzgZXk11s1mNWxZK
         5n16AMmLp3lSI5G/IumA9/wCX3AEiP74GVIGt2MLXWVzJrcFDhhtZCZYRCcHHFBU0Pvr
         hR4sHyHq2qJal5p/mk3Xm7GcY2bh5/QPWDkt42G4QXVdaljxIswo7tSQ1vShGJ1pMF6/
         8CYoHfivClk17aaPK8IOzBfO7qoktBKHI0kZdHsZD5AnCzulYRCiXzGHhwkU7M/itC1t
         ul6ohoB0Y3pcAyEW+3UMzibh7tFjPnrYRVt13+Xs+aUWO+S187fIiLVuY+Eo0KAEfdUY
         oDQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mdh7aaQO3fTgP8bprJCk07MNirNdtGLOsGXoOk/ABZc=;
        b=KTxZl91hMClanGcLi8WPM0wWOc77L02zI3ShY38Wz+N6/C99+ek0Ul25AY4D7Llnk+
         hdEEzDPxBkqyc52k0nlJnXG6ks7nxKf2yJKug8Q3b2LAtGJECmOGkvnIHPnQtQ9n/6ps
         SZbteuEvwBHlFnig1o9tBiNC0+3IBLaHx66KGENWzO1Qf6rJVB10dcG3Fx3R0mRxATp9
         tp04kUFrwLggLmfAjnaBNI76mo8Zg9VMN1kGXAu25Tcbj8fq/zaHdmT6AxzKMqWVn0sR
         NKsyGx/RoGob2G7BT2IqTDu2aoJa9W7Gc+s3e4auH8cuLQaPVscXprqDoY3zUHZR/y86
         gSyg==
X-Gm-Message-State: AOAM530EsrZ8XzRZsd9H3O8C2zcV8E2dHLW2Lt0P+YsF2VmWF9lnj+II
        QYtFMBYQn8p3QD4ii7guWk7yBLF4v4h/jA9PlOqlAQ==
X-Google-Smtp-Source: ABdhPJyNSsutBkqiXagUluHJ47Cw4MCx5LYPC9K6Vlp38BJaUiFviCgYEgVwcaMK8SD1/+1m0D7kyZXyoTFBvruGE6g=
X-Received: by 2002:a05:6830:1db5:: with SMTP id z21mr21309304oti.162.1595266865020;
 Mon, 20 Jul 2020 10:41:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200717222819.26198-1-nramas@linux.microsoft.com>
 <20200717222819.26198-5-nramas@linux.microsoft.com> <CAEjxPJ7xQtZToF4d2w_o8SXFKG9kPZaWTWTFqyC-7GwBWnQa0A@mail.gmail.com>
 <c0fbfcf3-ec36-872a-c389-b3fea214848c@linux.microsoft.com>
 <CAEjxPJ7VH18bEo6+U1GWrx=tHVGr=6XtF5_ygcfQYgdtZ74J+g@mail.gmail.com> <bea0cb52-2e13-fb14-b66c-b57287c23c3f@linux.microsoft.com>
In-Reply-To: <bea0cb52-2e13-fb14-b66c-b57287c23c3f@linux.microsoft.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 20 Jul 2020 13:40:54 -0400
Message-ID: <CAEjxPJ6Rt7u3shLbxoPRHgr-D=CD9d_eXRB07A9qN7RmJwZAwA@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] LSM: Define SELinux function to measure security state
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
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

On Mon, Jul 20, 2020 at 1:34 PM Lakshmi Ramasubramanian
<nramas@linux.microsoft.com> wrote:
>
> On 7/20/20 10:06 AM, Stephen Smalley wrote:
>
> >> The above will ensure the following sequence will be measured:
> >>    #1 State A - Measured
> >>    #2 Change from State A to State B - Measured
> >>    #3 Change from State B back to State A - Since the measured data is
> >> same as in #1, the change will be measured only if the event name is
> >> different between #1 and #3
> >
> > Perhaps the timestamp / sequence number should be part of the hashed
> > data instead of the event name?
>
> If the timestamp/seqno is part of the hashed data, on every call to
> measure IMA will add a new entry in the IMA log. This would fill up the
> IMA log - even when there is no change in the measured data.
>
> To avoid that I keep the last measurement in SELinux and measure only
> when there is a change with the timestamp in the event name.
>
> > I can see the appraiser wanting to know two things:
> > 1) The current state of the system (e.g. is it enforcing, is the
> > currently loaded policy the expected one?).
> > 2) Has the system ever been in an unexpected state (e.g. was it
> > temporarily switched to permissive or had an unexpected policy
> > loaded?)
>
> Yes - you are right.
> The appraiser will have to look at the entire IMA log (and the
> corresponding TPM PCR data) to know the above.
>
> Time t0 => State of the system measured
> Time tn => State changed and the new state measured
> Time tm => State changed again and the new state measured.
>
> Say, the measurement at "Time tn" was an illegal change, the appraiser
> would know.
>
> >
> > I applied the patch series on top of the next-integrity branch, added
> > measure func=LSM_STATE to ima-policy, and booted that kernel.  I get
> > the following entries in ascii_runtime_measurements, but seemingly
> > missing the final field:
> >
> > 10 8a09c48af4f8a817f59b495bd82971e096e2e367 ima-ng
> > sha256:21c3d7b09b62b4d0b3ed15ba990f816b94808f90b76787bfae755c4b3a44cd24
> > selinux-state
> > 10 e610908931d70990a2855ddb33c16af2d82ce56a ima-ng
> > sha256:c8898652afd5527ef4eaf8d85f5fee1d91fcccee34bc97f6e55b96746bedb318
> > selinux-policy-hash
> >
> > Thus, I cannot verify. What am I missing?
> >
>
> Looks like the template used is ima-ng which doesn't include the
> measured buffer. Please set template to "ima-buf" in the policy.
>
> For example,
> measure func=LSM_STATE template=ima-buf

It seems like one shouldn't need to manually specify it if it is the
only template that yields a useful result for the LSM_STATE function?
