Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA4E446A8DC
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Dec 2021 21:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349895AbhLFVAZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Dec 2021 16:00:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349925AbhLFVAO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Dec 2021 16:00:14 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8030DC061354
        for <linux-integrity@vger.kernel.org>; Mon,  6 Dec 2021 12:56:45 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id r25so48052635edq.7
        for <linux-integrity@vger.kernel.org>; Mon, 06 Dec 2021 12:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SPIEvU27nJzVjEldPndh6AIS3bn8rbbKEjqvujfESAs=;
        b=sqwrKYiuzMi5dmssg4GlXv9w5rXRuhpdynng6r31rrdUObFVM64iPlAGLY+IA6nJ/m
         1gWVgyo7h8UJSqiNk8kHnQBl3DslIrDGeQY/YI4e8xSZwdJRLRPILwtK2RvxOIlaDPjC
         OBpGK2HLI8rTM8NspupF8U0OMeFFkOlxbGDEdtu/HKjDnBfhz0fkSnyY621D4Xsbi4/b
         3ST5UtyYqeWW1cHbeOb480Uy4eW1eKVVgbiLR6jyCICedfyJJmGjtpyRESSiCOiDt3JU
         DhRelVF98isI2imEImS6IZhbw31inMErIQFNgiZw9xj2I71NmXJtHWWx+Lg6R3ctNEeU
         pQ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SPIEvU27nJzVjEldPndh6AIS3bn8rbbKEjqvujfESAs=;
        b=CzxKJedvtLqSVqu73yWeOxo5Epi0kss8RqD8GpV/aVbXSl7fNxTjpuTTUJw3WmTU/3
         hBOBtXs+nRf2kgFl2KleZu+HzPC4KiRZZx534O8BdQmCfnuqPmO77vR3PofbyifBoeL5
         1qT9yy/2hH1ABlRryjdNLUFlITgN6W1ZYchlcbiMY/psW6OhKlL97oJR9Lw/41zNSOju
         9wmofKxxXkiTfWctxo3hvumGqtEK5Ho6SI8hffKbcoFG7UF6u+wbg4I2wp2GghVhmMEy
         9OCVWbJFN9Dw0EG/6/Wrkyd30JThvwJyhU8uaiQClD5anTVipDy632/iSD2MJ/XiKTeH
         Et2w==
X-Gm-Message-State: AOAM533Hc977nqs8J0nBZ1DA6M0zf/wulewakPQfACWBeYjrTn3RpArV
        kFAKMFyZgxxTlipQva4MVXX04NW8uSu+YO1Oo+IitypcHg==
X-Google-Smtp-Source: ABdhPJyGSChgdU/2qHILkiKTMa1sAUYPNsA9phsLkYfr2JydqmXGaS1LTwjvs5zpRZPdPLscuqOdPR5Q9zocilnkoek=
X-Received: by 2002:a17:907:9196:: with SMTP id bp22mr46000620ejb.69.1638824203940;
 Mon, 06 Dec 2021 12:56:43 -0800 (PST)
MIME-Version: 1.0
References: <1630070917-9896-1-git-send-email-ross.philipson@oracle.com>
 <CAHC9VhTJG24iG=U0geO-ZhC6OogxOu4icBrNY22+qRNpWd5PBQ@mail.gmail.com> <456caf8c-b79a-e8b0-581f-3504240466ff@apertussolutions.com>
In-Reply-To: <456caf8c-b79a-e8b0-581f-3504240466ff@apertussolutions.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 6 Dec 2021 15:56:33 -0500
Message-ID: <CAHC9VhSZx7j2sEs1H3ON-eDoeWdtXPC7XNQcv5D1WbnP=4Lchg@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] x86: Trenchboot secure dynamic launch Linux
 kernel support
To:     "Daniel P. Smith" <dpsmith@apertussolutions.com>
Cc:     Ross Philipson <ross.philipson@oracle.com>,
        trenchboot-devel@googlegroups.com, linux-kernel@vger.kernel.org,
        x86@kernel.org, iommu@lists.linux-foundation.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, kanth.ghatraju@oracle.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Dec 2, 2021 at 11:11 AM Daniel P. Smith
<dpsmith@apertussolutions.com> wrote:
> Hi Paul!

/me waves

> On 11/30/21 8:06 PM, Paul Moore wrote:
> > On Fri, Aug 27, 2021 at 9:20 AM Ross Philipson
> > <ross.philipson@oracle.com> wrote:
> >>
> >> The larger focus of the Trechboot project (https://github.com/TrenchBoot) is to
> >> enhance the boot security and integrity in a unified manner. The first area of
> >> focus has been on the Trusted Computing Group's Dynamic Launch for establishing
> >> a hardware Root of Trust for Measurement, also know as DRTM (Dynamic Root of
> >> Trust for Measurement).
> >
> > My apologies for such a late reply, but I'm just getting around to
> > looking at this and I have a few questions on the basic design/flow
> > (below) ...
>
> No worries, thank you so much for taking the time to review.
>
> >> The basic flow is:
> >>
> >>  - Entry from the dynamic launch jumps to the SL stub
> >
> > So I'm clear, at this point the combined stub+kernel+initramfs+cmdline
> > image has already been loaded into memory and the SL stub is
> > executing, yes?
>
> That is correct.
>
> > As TrenchBoot seems to be focused on boot measurement and not
> > enforcing policy, I'm guessing this is considered out-of-scope (not to
> > mention that the combined stub+kernel image makes this less
> > interesting), but has any thought been given to leveraging the TXT
> > launch control policy, or is it simply an empty run-everything policy?
>
> The TrenchBoot model is a bit different and takes a more flexible
> approach to allow users to build tailored solutions. For instance Secure
> Launch is able to be used in a configuration that is similar to tboot.
> Consider the functions of tboot, it has a portion that is the
> post-launch kernel that handles the handover from the ACM and a portion
> that provides the Verified Launch policy engine, which is only capable
> of enforcing policy on what is contained in the Multiboot chain. The
> TrenchBoot approach is to introduce the Secure Launch capability into a
> kernel, in this case Linux, to handle the handover from the ACM, and
> then transition to a running user space that can contain a distribution
> specific policy enforcement. As an example, the TrenchBoot project
> contributed to the uroot project a Secure Launch policy engine which
> enables the creation of an initramfs image which can then be embedded
> into a minimal configuration Secure Launch Linux kernel ...

Thank you for the answers, that was helpful.

I think I initially misunderstood TrenchBoot, thinking that a Secure
Launch'd kernel/userspace would be the "normal" OS that would
transition to multi-user mode and be available for users and
applications.  However, on reading your response it appears that the
Secure Launch'd kernel/initramfs exists only to verify a secondary
kernel/initramfs/userspace and then kexec() into that once verified.

> Finally if your schedule allows it and it is not too much to ask, it
> would be greatly appreciated if some code review could be provided.
> Otherwise thank you for taking the time that you have to review the
> approach.

I have to admit that I'm not sure I'm the most appropriate person to
review all of the Intel TXT related assembly, but I could give it a
shot as time allows.  I would think Intel would be willing to help out
here if one were to ask nicely :)

Beyond that, and with my new understanding of how TrenchBoot is
supposed to work, I guess my only other concern is how one might
verify the integrity of the Secure Launch environment on the local
system during boot.  My apologies if I missed some details about that
in your docs, responses, etc. but is this something that TrenchBoot is
planning on addressing (or has already addressed)?

-- 
paul moore
www.paul-moore.com
