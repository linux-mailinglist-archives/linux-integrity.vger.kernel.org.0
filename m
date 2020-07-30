Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9D152333C5
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Jul 2020 16:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgG3OF7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Jul 2020 10:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbgG3OF6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Jul 2020 10:05:58 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E83AC061574
        for <linux-integrity@vger.kernel.org>; Thu, 30 Jul 2020 07:05:58 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id n21so4357836ooj.5
        for <linux-integrity@vger.kernel.org>; Thu, 30 Jul 2020 07:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y81TeT0UWU2cWr3bZj0TSDe9ZCoSnPc9Gto9awtWvBU=;
        b=d5h8WvPAYNCDS0xZb+1XHKnaTCalFEOqhf8bk2FHB7fhro4LTFm0az4MW0r5B/ZviW
         i0pxckHmiU/z4d6G+F6XRi9cryQF2EnA9q7Ayqa5tW5SF/zOpUf0qiQ2VLPgHtjClFCB
         BBZ89DJ9ACg0vg8EszMuWO4HRObs7Ei4NJ+HXhjLdseE0KDePEFohwLmR28cuXUmsnO9
         2hYYHKurcU3bMt5fKSsT/W/NkKNcC5xgCJ/DiAoI6FUZPJYdBbkCSqKCmm0JVIgjgqaU
         yhO3/dQHeLcgz0GOZIQu123/vso4BiCkDC2TbUNn7FEgRf0Bktd0CQFI2OvI4Ki2BPA4
         vVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y81TeT0UWU2cWr3bZj0TSDe9ZCoSnPc9Gto9awtWvBU=;
        b=aejJwcvYe65UjzVjEFm5ur3aVA3glxQnnBTI9Y3WrleBMXAthVZYyXMhnxprAKO9h4
         sGuwfJDCgbyiMM4u6sCCZkwIaSkt4yJxO5jHpO/pXIqU2o2QC4HweWHsSSEyG7B3mIHZ
         rIJVIv/B/KzAsumojH7EhjgwJy9szA3DAsy4BbtBJgGpBnGaJtiQPhfHJH4/DqgRjWwb
         yWhzFZPHVjakCQ3I7cmIzWFVrfuDwioruWfnfsr5MOhC5g+Td7Xh04SXF6KMstKFiWYc
         O2N3zqlB/jjtONgk7DnJZCZFSuxp3+bzgCsVnNt3OBvUPnYgLV+uD/BNGsCCGZs9Ahej
         tyRg==
X-Gm-Message-State: AOAM53056bLOKM+1F+8FOwow/mF/RKR4FX1kGhNACVGuJt8YFj+LDt+4
        T0sBIoAfPRG2RG10F6ewuF9DhnKX6aOgb5Xy4pE=
X-Google-Smtp-Source: ABdhPJyDLTqiyoyMVY9N6viVj0WYz2fkt3MuCLoMSIhjalnFgQCSc593m6cBlowyk4E/HkJHOJLuszNj53iyJL0Z7lo=
X-Received: by 2002:a4a:9f93:: with SMTP id z19mr2573207ool.58.1596117957853;
 Thu, 30 Jul 2020 07:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <8bcf778d-8fa8-9985-43d7-c2b80d8d8445@linux.microsoft.com>
 <59f23e8953c0735695e5679fc7b7021252837874.camel@linux.ibm.com>
 <a83fdf87-d98e-b5cd-2557-2fae88b09a13@linux.microsoft.com>
 <1596110753.25003.3.camel@kernel.org> <31db3e6f-c877-b359-19fd-cd09a58dbc13@linux.microsoft.com>
In-Reply-To: <31db3e6f-c877-b359-19fd-cd09a58dbc13@linux.microsoft.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 30 Jul 2020 10:05:45 -0400
Message-ID: <CAEjxPJ6+jn0NOw2AxS+j7Vu+xB6KrXWAKjGtwBufNApAt=KaMA@mail.gmail.com>
Subject: Re: Measure data again even when it has not changed
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Mimi Zohar <zohar@kernel.org>, linux-integrity@vger.kernel.org,
        Tyler Hicks <tyhicks@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jul 30, 2020 at 9:12 AM Lakshmi Ramasubramanian
<nramas@linux.microsoft.com> wrote:
>
> On 7/30/20 5:05 AM, Mimi Zohar wrote:
> > On Wed, 2020-07-29 at 20:41 -0700, Lakshmi Ramasubramanian wrote:
> >> On 7/29/20 8:23 PM, Mimi Zohar wrote:
> >>
> >>> On Wed, 2020-07-29 at 10:17 -0700, Lakshmi Ramasubramanian wrote:
> >>>> Hi Mimi,
> >>>>
> >>>> I have a query related to measuring data (by IMA subsystem) when that
> >>>> data has been already been measured.
> >>>>
> >>>> Consider the following sequence of events:
> >>>>
> >>>> => At time T0 IMA hook is called by another subsystem to measure data
> >>>> "foo". IMA measures it.
> >>>>
> >>>> => At time T1 data is "bar". IMA measures it.
> >>>>
> >>>> => At time T2 data is "foo" again. But IMA doesn't measure it since it
> >>>> is already in the measured list.
> >>>>
> >>>> But for the subsystem making the call to IMA, the state has changed and
> >>>> "foo" has to be measured again.
> >>>>
> >>>> One way to address the above is to use unique "event name" in each call
> >>>> so that IMA measures the given data every time.
> >>>>
> >>>> Is there a better way to address the above?
> >>>
> >>> Most likely the file is being re-measured, but the new value already exists in
> >>> the hash table so it isn't being added to the IMA measurement list or extending
> >>> the TPM.  When IMA was upstreamed, there was concern about TPM performance and
> >>> the number of measurements being extended.  We've improved TPM performance quite
> >>> a bit.  If you're not concerned about TPM performance, I would define a new
> >>> template data field based on i_version.
> >>
> >> In the use case I am considering the entity being measured is not a
> >> file, but a memory buffer - it is for measuring an LSM's data
> >> constructs. So i_version is not available in this case.
> >>
> >> When LSM's data changes from A to B and then back to A, hash(A) already
> >> exists in IMA's hash table. So A is not measured again.
> >>
> >> Since LSM state change is not expected to be frequent, TPM performance
> >> shouldn't be a concern.
> >
> > Wouldn't a unique event name result in a new measurement every time?
> >
>
> Adding Stephen.
>
> Yes - but the LSM would call the IMA hook only when there is a change in
> the state.
>
> I have posted a patch set for this last night -
> it defines IMA hooks for measuring LSM data and uses that to measure
> SELinux data constructs. It can be used by other security modules as
> well. Please take a look.

To provide more context, the patch set is enabling the measurement of
LSM state variables (e.g. SELinux enabled and enforcing among others)
and LSM policy (e.g. the SELinux policy).  An appraiser may want to
know either or both of:
1) What is the current state/policy of the system, e.g. is it
currently enforcing an expected policy?
2) Has the system ever been in a state/policy that was
unexpected/unauthorized, e.g. was it switched to permissive mode at
some point earlier or did it load an unexpected/unauthorized policy
earlier?
