Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A192A2F588D
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Jan 2021 04:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbhANClh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 13 Jan 2021 21:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbhANClg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 Jan 2021 21:41:36 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E96C061575
        for <linux-integrity@vger.kernel.org>; Wed, 13 Jan 2021 18:40:55 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id w1so6027265ejf.11
        for <linux-integrity@vger.kernel.org>; Wed, 13 Jan 2021 18:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ICU+nSYjt88uUPf04x0vPH+TBGitC4Alk2Ujk58+eBk=;
        b=PBr7F/CY9lJQhXr1uLV8LuI3z+xDfdoQzQPfc8/FN5JuZQi15Bzh7nDx3yf38EeP1l
         yj3OFWs/5W4TDOUFTtyqib2EjQV3Vm16kIpZ48IHM9ufSd0TmaCTj+zzDA6vpoWXPEgE
         xubGG1cGYVnekT00BuI/+bzd9I83XZ4rWcmc18niljoC/97DbJEBDE2zfObQLog9Mzho
         x0yfaJyiezHYDFsGRHYa/i5W9vJG+IeDSztTd3i6ksvaRNCWgPyujBaZZn2Whnflv0zJ
         gT8qJgk4zcGsp3GTPTMXKNY4CSU77FzbtI2mJI7rgyy+hr8Fi45mLSMqFAc33WBtGhyR
         +MKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ICU+nSYjt88uUPf04x0vPH+TBGitC4Alk2Ujk58+eBk=;
        b=OTbS4YWwuWq7hLnWdfVBf9eHyuD+VcHL5g/rToaLf2JdON2YRI/1fFftwbGgTbtA7c
         58qJCpaY03ynFsQXocN+ALdDXL6eePYVK36IYZu9In+TWCsILeFFnsi5QniyltASd7jl
         WEvD3Iti5x4RPXbM8I8BUur+xI+Wf0bhzu+7J0uM2K7hI81+fnfwO2fDLcHwYFslvOZg
         nHLjATH5MDzPOAdZuz8xq29sFu6KvoAMYld+L1W/ZnLAy02LWjIs3foNVbiYrZNETd/b
         jf+GPDoc9gWkYqiLAY7KK55Ivks/KYEvJ2D9Cc/vmzaVGG35ekmu85vxr4oimV8Nmthx
         zTfA==
X-Gm-Message-State: AOAM532EwUGCw4Kh9lTFztNvk8KFY87h9sB6nTjf8kHr+PR+xEWbqaRl
        GVvr8ztPuHvOgu6tdNQihszwmJUre0YGksjY5Ucf
X-Google-Smtp-Source: ABdhPJzUScrMCXjP5CjZuyAFSrux9MlxNzRaM71SlD32TfKMxsyMVQgRkoDizyODeHRLGNSje2xpi5j+8NySHCX6SAM=
X-Received: by 2002:a17:906:aec6:: with SMTP id me6mr3636237ejb.542.1610592054037;
 Wed, 13 Jan 2021 18:40:54 -0800 (PST)
MIME-Version: 1.0
References: <20210108040708.8389-1-tusharsu@linux.microsoft.com>
 <20210108040708.8389-9-tusharsu@linux.microsoft.com> <CAHC9VhSJk0wG=WzO3bwsueiy19mMi9m6MamTrQfH8C=gXUtvGw@mail.gmail.com>
 <97328fc71687a0e1c327f6821548be9ba35bb193.camel@linux.ibm.com>
 <CAHC9VhTzaQ_q8gJ0oeok_yJ54XLETNvOuhhKnyRwgqsqvpBLCw@mail.gmail.com>
 <71cddb6c8676ccd63c89364d805cfca76d32cb6e.camel@linux.ibm.com>
 <CAHC9VhRhYWEcK7TepZ=LK1m=9Zn_gtOZyAYfamP-TFU3rRH+zw@mail.gmail.com> <e29a618645b0e73ec06960a02b6da465614689ff.camel@linux.ibm.com>
In-Reply-To: <e29a618645b0e73ec06960a02b6da465614689ff.camel@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 13 Jan 2021 21:40:43 -0500
Message-ID: <CAHC9VhTHqwKem=MyQBY4TNAq-DOVhwEZS8pjrSE=4OxdEVm-GA@mail.gmail.com>
Subject: Re: [PATCH v10 8/8] selinux: include a consumer of the new IMA
 critical data hook
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, tyhicks@linux.microsoft.com,
        sashal@kernel.org, James Morris <jmorris@namei.org>,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jan 13, 2021 at 6:11 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> On Wed, 2021-01-13 at 17:10 -0500, Paul Moore wrote:
> > On Wed, Jan 13, 2021 at 4:11 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > > On Wed, 2021-01-13 at 14:19 -0500, Paul Moore wrote:
> > > > On Wed, Jan 13, 2021 at 2:13 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > > > > On Tue, 2021-01-12 at 11:27 -0500, Paul Moore wrote:
> > > > > > On Thu, Jan 7, 2021 at 11:07 PM Tushar Sugandhi
> > > > > > <tusharsu@linux.microsoft.com> wrote:
> > > > > > > From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> > > > > > >
> > > > > > > SELinux stores the active policy in memory, so the changes to this data
> > > > > > > at runtime would have an impact on the security guarantees provided
> > > > > > > by SELinux.  Measuring in-memory SELinux policy through IMA subsystem
> > > > > > > provides a secure way for the attestation service to remotely validate
> > > > > > > the policy contents at runtime.
> > > > > > >
> > > > > > > Measure the hash of the loaded policy by calling the IMA hook
> > > > > > > ima_measure_critical_data().  Since the size of the loaded policy
> > > > > > > can be large (several MB), measure the hash of the policy instead of
> > > > > > > the entire policy to avoid bloating the IMA log entry.
> > > > > > >
> > > > > > > To enable SELinux data measurement, the following steps are required:
> > > > > > >
> > > > > > > 1, Add "ima_policy=critical_data" to the kernel command line arguments
> > > > > > >    to enable measuring SELinux data at boot time.
> > > > > > > For example,
> > > > > > >   BOOT_IMAGE=/boot/vmlinuz-5.10.0-rc1+ root=UUID=fd643309-a5d2-4ed3-b10d-3c579a5fab2f ro nomodeset security=selinux ima_policy=critical_data
> > > > > > >
> > > > > > > 2, Add the following rule to /etc/ima/ima-policy
> > > > > > >    measure func=CRITICAL_DATA label=selinux
> > > > > > >
> > > > > > > Sample measurement of the hash of SELinux policy:
> > > > > > >
> > > > > > > To verify the measured data with the current SELinux policy run
> > > > > > > the following commands and verify the output hash values match.
> > > > > > >
> > > > > > >   sha256sum /sys/fs/selinux/policy | cut -d' ' -f 1
> > > > > > >
> > > > > > >   grep "selinux-policy-hash" /sys/kernel/security/integrity/ima/ascii_runtime_measurements | tail -1 | cut -d' ' -f 6
> > > > > > >
> > > > > > > Note that the actual verification of SELinux policy would require loading
> > > > > > > the expected policy into an identical kernel on a pristine/known-safe
> > > > > > > system and run the sha256sum /sys/kernel/selinux/policy there to get
> > > > > > > the expected hash.
> > > > > > >
> > > > > > > Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> > > > > > > Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > > > > > Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> > > > > > > ---
> > > > > > >  Documentation/ABI/testing/ima_policy |  3 +-
> > > > > > >  security/selinux/Makefile            |  2 +
> > > > > > >  security/selinux/ima.c               | 64 ++++++++++++++++++++++++++++
> > > > > > >  security/selinux/include/ima.h       | 24 +++++++++++
> > > > > > >  security/selinux/include/security.h  |  3 +-
> > > > > > >  security/selinux/ss/services.c       | 64 ++++++++++++++++++++++++----
> > > > > > >  6 files changed, 149 insertions(+), 11 deletions(-)
> > > > > > >  create mode 100644 security/selinux/ima.c
> > > > > > >  create mode 100644 security/selinux/include/ima.h
> > > > > >
> > > > > > I remain concerned about the possibility of bypassing a measurement by
> > > > > > tampering with the time, but I appear to be the only one who is
> > > > > > worried about this so I'm not going to block this patch on those
> > > > > > grounds.
> > > > > >
> > > > > > Acked-by: Paul Moore <paul@paul-moore.com>
> > > > >
> > > > > Thanks, Paul.
> > > > >
> > > > > Including any unique string would cause the buffer hash to change,
> > > > > forcing a new measurement.  Perhaps they were concerned with
> > > > > overflowing a counter.
> > > >
> > > > My understanding is that Lakshmi wanted to force a new measurement
> > > > each time and felt using a timestamp would be the best way to do that.
> > > > A counter, even if it wraps, would have a different value each time
> > > > whereas a timestamp is vulnerable to time adjustments.  While a
> > > > properly controlled and audited system could be configured and
> > > > monitored to detect such an event (I *think*), why rely on that if it
> > > > isn't necessary?
> > >
> > > Why are you saying that even if the counter wraps a new measurement is
> > > guaranteed.   I agree with the rest of what you said.
> >
> > I was assuming that the IMA code simply compares the passed
> > "policy_event_name" value to the previous value, if they are different
> > a new measurement is taken, if they are the same the measurement
> > request is ignored.  If this is the case the counter value is only
> > important in as much as that it is different from the previous value,
> > even simply toggling a single bit back and forth would suffice in this
> > case.  IMA doesn't keep a record of every previous "policy_event_name"
> > value does it?  Am I misunderstanding how
> > ima_measure_critical_data(...) works?
>
> Originally, there was quite a bit of discussion as to how much or how
> little should be measured for a number of reasons.  One reason is that
> the TPM is relatively slow.  Another reason is to limit the size of the
> measurement list.  For this reason, duplicate hashes aren't added to
> the measurement list or extended into the TPM.
>
> When a dentry is removed from cache, its also removed from IMA's iint
> cache.  A subsequent file read would result in adding the measurement
> and extending the TPM again.  ima_lookup_digest_entry() is called to
> prevent adding the duplicate entry.
>
> Lakshmi is trying to address the situation where an event changes a
> value, but then is restored to the original value.  The original and
> subsequent events are measured, but restoring to the original value
> isn't re-measured.  This isn't any different than when a file is
> modified and then reverted.
>
> Instead of changing the name like this, which doesn't work for files,
> allowing duplicate measurements should be generic, based on policy.

Perhaps it is just the end of the day and I'm a bit tired, but I just
read all of the above and I have no idea what your current thoughts
are regarding this patch.

-- 
paul moore
www.paul-moore.com
