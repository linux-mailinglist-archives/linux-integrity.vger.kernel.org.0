Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E79A9226E7A
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Jul 2020 20:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbgGTSoT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 Jul 2020 14:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728068AbgGTSoT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Jul 2020 14:44:19 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47556C061794;
        Mon, 20 Jul 2020 11:44:19 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id y9so3387479oot.9;
        Mon, 20 Jul 2020 11:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aCbgyprCpv5zpqintIcYum/YWgpLdnYdNsT160BVscU=;
        b=MqA1QBncRXeHqrSw+D9BJYzKgHEiDmWtVKqX3bSjZgXmBmd6zpF4cQWCzZq10h0CA3
         athEZ1vHT98oFgV1u5Xrq7SIUdYFFDJweUOqE/9dAedg5r1E+1wUR4GCgjrB96tcY/oW
         eRPMgsTx93B4fM1CBPPt+BYnUy+SKpvnDZb84tQzPwV8RrB/O6GPq9FpLKtvGOAsM390
         C7MWF2OlPkVQwDk7XXBKHOaIfJP+cSPOMetp2zdeIqSqvIGGFuwHmUWypGeLDGvbZ5XA
         /LJYfKsKKQ3GagLFgzCqrfWNONB11jIfoxaDh7WFhi8q1GPz+bzP6N2POUhiM43D/SpJ
         PZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aCbgyprCpv5zpqintIcYum/YWgpLdnYdNsT160BVscU=;
        b=LIrWcHEJSXZNux0yE+Og8ay3acuYUIOVCil8DnQqRZOpdUCDlO+ObAcPJwujkNR5FD
         /BoZeS2otxmO2mEzizf5u/zM62Vpj1lCxIuAExWVIYfe4YE07HrY9uSIuonUTi4Mm3DP
         /IFzaukDUxjhz1wICCgqUftlitj6NEVrmv7oQNAnIwA0zcWmUFhgnDeVoUxhlWTP2WIR
         J6qBKaQGAKWfA04u+a2uyrog8gNxGKsBvdU4MjxW+FZNeBWcXngZW1L7XbRYQIic/ntn
         QeXdG8LqELd1onZ5+AdEqfTlAbQlHfDck7WyRveJvoXXrWCjAaXEYBzre7oUj0q48iOM
         sdtA==
X-Gm-Message-State: AOAM530JHQ5TemDWKyvFoMH7pxny39GOsb4YY/0eiZWcZGykTMGt5OBp
        ZzP9epea+Sg0+R/NziaOguzcOCGxepR2n8khmBO6zQ==
X-Google-Smtp-Source: ABdhPJxxdpu7f6maFj8dhB9dVzclW3hoj40UmwmfiLyTPbY4FdQO2aoMX/tGthJiy4XqhpNjr1TPi/shKoe1NFr1EKE=
X-Received: by 2002:a4a:b006:: with SMTP id f6mr20757376oon.13.1595270658680;
 Mon, 20 Jul 2020 11:44:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200717222819.26198-1-nramas@linux.microsoft.com>
 <20200717222819.26198-5-nramas@linux.microsoft.com> <CAEjxPJ7xQtZToF4d2w_o8SXFKG9kPZaWTWTFqyC-7GwBWnQa0A@mail.gmail.com>
 <c0fbfcf3-ec36-872a-c389-b3fea214848c@linux.microsoft.com>
 <CAEjxPJ7VH18bEo6+U1GWrx=tHVGr=6XtF5_ygcfQYgdtZ74J+g@mail.gmail.com>
 <bea0cb52-2e13-fb14-b66c-b57287c23c3f@linux.microsoft.com>
 <CAEjxPJ6Rt7u3shLbxoPRHgr-D=CD9d_eXRB07A9qN7RmJwZAwA@mail.gmail.com>
 <CAEjxPJ6-jHha+CeqSdQ2O0bpyQe_9buj2ENZz6FNj6S87XSSfg@mail.gmail.com> <dccfc56b-c3ab-327e-19b2-7a70d15afe5b@linux.microsoft.com>
In-Reply-To: <dccfc56b-c3ab-327e-19b2-7a70d15afe5b@linux.microsoft.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 20 Jul 2020 14:44:07 -0400
Message-ID: <CAEjxPJ6_pxEh6HG9F3r=4B5ZgEpNPkgLHHfJp6ze=F1wKt4wCw@mail.gmail.com>
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

On Mon, Jul 20, 2020 at 2:27 PM Lakshmi Ramasubramanian
<nramas@linux.microsoft.com> wrote:
>
> On 7/20/20 10:49 AM, Stephen Smalley wrote:
>
> >>>
> >>> Looks like the template used is ima-ng which doesn't include the
> >>> measured buffer. Please set template to "ima-buf" in the policy.
> >>>
> >>> For example,
> >>> measure func=LSM_STATE template=ima-buf
> >>
> >> It seems like one shouldn't need to manually specify it if it is the
> >> only template that yields a useful result for the LSM_STATE function?
> >
> > Actually, if we used ima-ng template for selinux-policy-hash, then
> > instead of needing to hash the policy
> > first and passing the hash to IMA, we could just pass the policy as
> > the buffer and IMA would take care of the hashing, right?
>
> That is correct.
>
> The IMA hook I've added to measure LSM structures is a generic one that
> can be used by any security module (SM). I feel it would be better to
> not have policy or state or any such SM specific logic in IMA, but leave
> that to the individual SM to handle.
>
> What do you think?

It is correct to remain security module agnostic.  However, I think
you can remain LSM-neutral while still avoiding the double hashing of
the policy here.  Can't you just pass in the policy itself as the
buffer and let IMA hash it?  Then you can let the policy author decide
on the template to be used (ima-buf versus ima-ng).  If you want to
support the use of different templates for different "kinds" of LSM
state (e.g. state versus policy) you could either provide two funcs
(LSM_STATE, LSM_POLICY) or otherwise support selection based on some
other attribute.
