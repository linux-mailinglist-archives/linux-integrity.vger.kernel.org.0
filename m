Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44B6323D1C4
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Aug 2020 22:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbgHEUF7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 Aug 2020 16:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbgHEQfG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 Aug 2020 12:35:06 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A40C008688;
        Wed,  5 Aug 2020 07:27:54 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id z22so9160331oid.1;
        Wed, 05 Aug 2020 07:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Blb5cBgplWWvh2yRMDcotzJrK1boXBQTYj1dnOWWj6w=;
        b=hnBfreEjxoFcyyZNt3AUYdaPJlBEboB8o3t+lXk2upTSKgdswAGiWu9jg/0bjDKIRn
         IxbZJyTdY5mBsKV2E+uLOpB1HJoAyGRTm3bsB96MFoSVhNKhiGr+4TzQjw9V4R1Au2Rd
         614CJo1wYqs8liVDXesynQ6TiV5Ogr8/eto23NlJStfFnxz4eD0KTQeNrmJZ4le97+39
         hlWODirNQ18FJITf4CF9EKWyKlGpA0diDIDbqpITq2JLYI1x+EoKQAl6+cQOx2m/EMBm
         hnqk6nBDt22HVn/BE+HPMZyYdTdZGzk0seX96HYBeTtARnZqpcTYd6vEvqwGsqTwSN0A
         Nr8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Blb5cBgplWWvh2yRMDcotzJrK1boXBQTYj1dnOWWj6w=;
        b=Ter8kW3QSibscGmf0NtxclMgqcchavT9cxnI/5pDUm965qj0GRjXXYqt2btLdu3gBb
         E0VCdreZSXoPzbpbu4ciqRxWWkbrNKLfhvcxXwSh7EBAs+HfaolWYp37PVwOIGOA/DAE
         XzC1uHyEnIKTtxM3Vjvp4ZacmwU6EsipSsl9gGGSiyl43MarfJbU9vZmc5eAqX5brMzb
         DKs848CWCB6IRxl156Yp45aHRbRDOT6QzdXQA/cC56us1C4VzHzNy/GVbgM63Nw4U391
         Tim2kRjMQaYALAZi2uYvx2KMQQwiOUF5rREJ7tbLiEkWMr/2b05qv2ma1z1EDrC+bdF8
         xwHw==
X-Gm-Message-State: AOAM531YkgQkUiuLHGQhXRRKNLE8Lp9MpCa2leHMWKRD3bv0LfQG7eS2
        5RxMk80BoyGtnFrP46DL03/T9UxuwtT/UcSKFfA=
X-Google-Smtp-Source: ABdhPJwFLSLQMTNN17lzT9UhVboQK3lYQxDoK1SockjPL3YMW5lU1bWcdLTvmy9j25FkcOgQ4oWRA65Xwk+KGDif2X8=
X-Received: by 2002:a54:4817:: with SMTP id j23mr2968773oij.140.1596637674297;
 Wed, 05 Aug 2020 07:27:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200805004331.20652-1-nramas@linux.microsoft.com>
 <20200805004331.20652-2-nramas@linux.microsoft.com> <4b9d2715d3ef3c8f915ef03867cfb1a39c0abc54.camel@linux.ibm.com>
 <f88bf25e-37ef-7f00-6162-215838961bb0@gmail.com> <31d00876438d2652890ab8bf6ba2e80f554ca7a4.camel@linux.ibm.com>
 <CAEjxPJ6X+Cqd5QtZBmNm2cujwbg-STfRF7_8i=Ny8yuc6z9BwQ@mail.gmail.com> <b7df114e8e0d276e66575b6970a1e459d1dd4196.camel@linux.ibm.com>
In-Reply-To: <b7df114e8e0d276e66575b6970a1e459d1dd4196.camel@linux.ibm.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 5 Aug 2020 10:27:43 -0400
Message-ID: <CAEjxPJ7d1yg659OCU6diXXGqegc_jSzO4ZPhkRqQtJnRn-kC0g@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] IMA: Add func to measure LSM state and policy
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>, sashal@kernel.org,
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

On Wed, Aug 5, 2020 at 9:20 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Wed, 2020-08-05 at 09:03 -0400, Stephen Smalley wrote:
> > On Wed, Aug 5, 2020 at 8:57 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > > On Wed, 2020-08-05 at 08:46 -0400, Stephen Smalley wrote:
> > > > On 8/4/20 11:25 PM, Mimi Zohar wrote:
> > > >
> > > > > Hi Lakshmi,
> > > > >
> > > > > There's still  a number of other patch sets needing to be reviewed
> > > > > before my getting to this one.  The comment below is from a high level.
> > > > >
> > > > > On Tue, 2020-08-04 at 17:43 -0700, Lakshmi Ramasubramanian wrote:
> > > > > > Critical data structures of security modules need to be measured to
> > > > > > enable an attestation service to verify if the configuration and
> > > > > > policies for the security modules have been setup correctly and
> > > > > > that they haven't been tampered with at runtime. A new IMA policy is
> > > > > > required for handling this measurement.
> > > > > >
> > > > > > Define two new IMA policy func namely LSM_STATE and LSM_POLICY to
> > > > > > measure the state and the policy provided by the security modules.
> > > > > > Update ima_match_rules() and ima_validate_rule() to check for
> > > > > > the new func and ima_parse_rule() to handle the new func.
> > > > > I can understand wanting to measure the in kernel LSM memory state to
> > > > > make sure it hasn't changed, but policies are stored as files.  Buffer
> > > > > measurements should be limited  to those things that are not files.
> > > > >
> > > > > Changing how data is passed to the kernel has been happening for a
> > > > > while.  For example, instead of passing the kernel module or kernel
> > > > > image in a buffer, the new syscalls - finit_module, kexec_file_load -
> > > > > pass an open file descriptor.  Similarly, instead of loading the IMA
> > > > > policy data, a pathname may be provided.
> > > > >
> > > > > Pre and post security hooks already exist for reading files.   Instead
> > > > > of adding IMA support for measuring the policy file data, update the
> > > > > mechanism for loading the LSM policy.  Then not only will you be able
> > > > > to measure the policy, you'll also be able to require the policy be
> > > > > signed.
> > > >
> > > > To clarify, the policy being measured by this patch series is a
> > > > serialized representation of the in-memory policy data structures being
> > > > enforced by SELinux.  Not the file that was loaded.  Hence, this
> > > > measurement would detect tampering with the in-memory policy data
> > > > structures after the policy has been loaded.  In the case of SELinux,
> > > > one can read this serialized representation via /sys/fs/selinux/policy.
> > > > The result is not byte-for-byte identical to the policy file that was
> > > > loaded but can be semantically compared via sediff and other tools to
> > > > determine whether it is equivalent.
> > >
> > > Thank you for the clarification.   Could the policy hash be included
> > > with the other critical data?  Does it really need to be measured
> > > independently?
> >
> > They were split into two separate functions because we wanted to be
> > able to support using different templates for them (ima-buf for the
> > state variables so that the measurement includes the original buffer,
> > which is small and relatively fixed-size, and ima-ng for the policy
> > because it is large and we just want to capture the hash for later
> > comparison against known-good).  Also, the state variables are
> > available for measurement always from early initialization, whereas
> > the policy is only available for measurement once we have loaded an
> > initial policy.
>
> Ok, measuring the policy separately from other critical data makes
> sense.  Instead of measuring the policy, which is large, measure the
> policy hash.

I think that was the original approach.  However, I had concerns with
adding code to SELinux to compute a hash over the policy versus
leaving that to IMA's existing policy and mechanism.  If that's
preferred I guess we can do it that way but seems less flexible and
duplicative.
