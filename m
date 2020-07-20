Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7EA226D8A
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Jul 2020 19:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgGTRtz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 Jul 2020 13:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgGTRty (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Jul 2020 13:49:54 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB883C061794;
        Mon, 20 Jul 2020 10:49:54 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id t4so15027610oij.9;
        Mon, 20 Jul 2020 10:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E/WF9LmUo71c0bgV0jc9EPEVEVSzt8bdBdlMxd+6u9o=;
        b=N49dDLbtcc8GbCc/rK6VzmC408aRyQNWvV2bsAzf2369GrbLTIqe/8AIHtgH8i6iaW
         h/LY7IMO/tCttISFJNT44Z/7d4MHx61mUdhl7VwwPWWqMa7MU4SX9WD9axAZXlQyrzoC
         kN4uyoHIBMFMYgKDZWHQFOJZ5bQvHz38NdxFbHVTQlijvrcuRDRDpXxVewmi8WAAd8cX
         A5VIQvWKJvdLBpNbj2tA13i1Dq+V0c71YItqmQR+p3kOTaJbFHiqfuJ+RzS4PiX7/7NZ
         WdNXkAuLJ9mudeJFNhLM5OsCtgF1Sjtk58ZvJJlZLVt9S8IjPNtMd7P0ghmaYvKCIW6K
         E8pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E/WF9LmUo71c0bgV0jc9EPEVEVSzt8bdBdlMxd+6u9o=;
        b=COKKPd7ki6sFuMgWhtMAt5skMZoXs2N0z4k8cXCVZsvozpX2jHHJ5ctanYp+dXzAco
         loNEuzpjZLGfe9/kn4NtLArzZq6k1yymTefgF/eXuwISlmObRNyqQzNvp5pRnPqgdDYB
         zTMG4DrE3M/F6pSCXdm3eZHEHvMRURzH5jVyGKyS+rEXCa1iCfKeqlpjowexysAeTiPS
         IOKXwo7qPU25sV/bPXJtHsu+aDDh6nVdA3/Sw1lEKdFCzO4IHofDIWwmRLv6YeVEJw6Q
         Nctk5ONNlDjbicOWFV2Yg8VuDTDyRrPrgHQ0ncZBkfStIXJt2qcBb1xUYqyc9WKhcatr
         YHrg==
X-Gm-Message-State: AOAM5320/3+d1YFo05t2kp/eCMSY5YdGlGJiDvWrpE4HUeSS4sqG/+FE
        PBEq++8rz1o4EnMOz6OTzbQt2GwTYJSq+Z43Y81MVA==
X-Google-Smtp-Source: ABdhPJw1Ddg81VAJhNmhtE0Qulu8T/IcFBqzefZSxTWJ1RiLL7hGzoUJLJYUNL3KckdDR7CVcAzOxVuv71RyuDv3w+0=
X-Received: by 2002:aca:2807:: with SMTP id 7mr374627oix.140.1595267394146;
 Mon, 20 Jul 2020 10:49:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200717222819.26198-1-nramas@linux.microsoft.com>
 <20200717222819.26198-5-nramas@linux.microsoft.com> <CAEjxPJ7xQtZToF4d2w_o8SXFKG9kPZaWTWTFqyC-7GwBWnQa0A@mail.gmail.com>
 <c0fbfcf3-ec36-872a-c389-b3fea214848c@linux.microsoft.com>
 <CAEjxPJ7VH18bEo6+U1GWrx=tHVGr=6XtF5_ygcfQYgdtZ74J+g@mail.gmail.com>
 <bea0cb52-2e13-fb14-b66c-b57287c23c3f@linux.microsoft.com> <CAEjxPJ6Rt7u3shLbxoPRHgr-D=CD9d_eXRB07A9qN7RmJwZAwA@mail.gmail.com>
In-Reply-To: <CAEjxPJ6Rt7u3shLbxoPRHgr-D=CD9d_eXRB07A9qN7RmJwZAwA@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 20 Jul 2020 13:49:43 -0400
Message-ID: <CAEjxPJ6-jHha+CeqSdQ2O0bpyQe_9buj2ENZz6FNj6S87XSSfg@mail.gmail.com>
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

On Mon, Jul 20, 2020 at 1:40 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Jul 20, 2020 at 1:34 PM Lakshmi Ramasubramanian
> <nramas@linux.microsoft.com> wrote:
> >
> > On 7/20/20 10:06 AM, Stephen Smalley wrote:
> >
> > >> The above will ensure the following sequence will be measured:
> > >>    #1 State A - Measured
> > >>    #2 Change from State A to State B - Measured
> > >>    #3 Change from State B back to State A - Since the measured data is
> > >> same as in #1, the change will be measured only if the event name is
> > >> different between #1 and #3
> > >
> > > Perhaps the timestamp / sequence number should be part of the hashed
> > > data instead of the event name?
> >
> > If the timestamp/seqno is part of the hashed data, on every call to
> > measure IMA will add a new entry in the IMA log. This would fill up the
> > IMA log - even when there is no change in the measured data.
> >
> > To avoid that I keep the last measurement in SELinux and measure only
> > when there is a change with the timestamp in the event name.
> >
> > > I can see the appraiser wanting to know two things:
> > > 1) The current state of the system (e.g. is it enforcing, is the
> > > currently loaded policy the expected one?).
> > > 2) Has the system ever been in an unexpected state (e.g. was it
> > > temporarily switched to permissive or had an unexpected policy
> > > loaded?)
> >
> > Yes - you are right.
> > The appraiser will have to look at the entire IMA log (and the
> > corresponding TPM PCR data) to know the above.
> >
> > Time t0 => State of the system measured
> > Time tn => State changed and the new state measured
> > Time tm => State changed again and the new state measured.
> >
> > Say, the measurement at "Time tn" was an illegal change, the appraiser
> > would know.
> >
> > >
> > > I applied the patch series on top of the next-integrity branch, added
> > > measure func=LSM_STATE to ima-policy, and booted that kernel.  I get
> > > the following entries in ascii_runtime_measurements, but seemingly
> > > missing the final field:
> > >
> > > 10 8a09c48af4f8a817f59b495bd82971e096e2e367 ima-ng
> > > sha256:21c3d7b09b62b4d0b3ed15ba990f816b94808f90b76787bfae755c4b3a44cd24
> > > selinux-state
> > > 10 e610908931d70990a2855ddb33c16af2d82ce56a ima-ng
> > > sha256:c8898652afd5527ef4eaf8d85f5fee1d91fcccee34bc97f6e55b96746bedb318
> > > selinux-policy-hash
> > >
> > > Thus, I cannot verify. What am I missing?
> > >
> >
> > Looks like the template used is ima-ng which doesn't include the
> > measured buffer. Please set template to "ima-buf" in the policy.
> >
> > For example,
> > measure func=LSM_STATE template=ima-buf
>
> It seems like one shouldn't need to manually specify it if it is the
> only template that yields a useful result for the LSM_STATE function?

Actually, if we used ima-ng template for selinux-policy-hash, then
instead of needing to hash the policy
first and passing the hash to IMA, we could just pass the policy as
the buffer and IMA would take care of the hashing, right?
And we only need to use ima-buf for the selinux-state if we want the
measurement list to include the string value that
was hashed; if we just want to compare against a known-good, it would
suffice to use ima-ng for it as well, right?
