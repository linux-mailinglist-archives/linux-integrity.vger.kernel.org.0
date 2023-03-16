Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB506BDA11
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Mar 2023 21:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjCPUWO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Mar 2023 16:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjCPUWK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Mar 2023 16:22:10 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2E8E4DB2
        for <linux-integrity@vger.kernel.org>; Thu, 16 Mar 2023 13:21:53 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id v196so3384874ybe.9
        for <linux-integrity@vger.kernel.org>; Thu, 16 Mar 2023 13:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1678998112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wNELyMFYQ3E5IM6Bv8MMesyXF2Jl9Zu5m81e3F3V3lY=;
        b=cuAwnKU1af2vaASb3Lb/E+svpI5ZkG7HLQ2xV/imN+I88wrD2YzUgpO+hZn2BB9/oy
         i/7Hs5NEwZNflLSoDOtYQqOhi3J4lhgmVMnZVjjZNY4O3TFKDADQi35BEr8H+2grDxH+
         KWdRx2vB9rbqq0S9HNYGc9N7y0bZneToDxBfmEgZSBEF53rSeygh6kGFm/3M7RxWkSf9
         ly5Q3WPGOU8IkjcwCKEMOzee+lCoTGtNMVWuz/Kz9q8nzrRSLdK6x5YEJN0VjqmcW3CX
         iCUDH9p/YscgROaoI5MjIFf4xq4Nb4WS2vOTNAwTfV9b6oLSfLX1NxSMTIBLDfYO4Luf
         NUvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678998112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wNELyMFYQ3E5IM6Bv8MMesyXF2Jl9Zu5m81e3F3V3lY=;
        b=7KnbEgslWk36iehRNm6l0wabpL95YNhZd1cV+C+8hdNWbh+O+NoaBn9ZjjtIvStWiC
         m3WFWSiFXrc92AQyoKG+s9V5f+G/2qMZq921zhEHJUR+nU7hr839ksgqNxUq+yB3P1wm
         LuZ80/+Bf95/N2K9CN2QFgjXjVlbMTNfCsFmTt+Owcnkt/UsT86s4bwEwe9VHiGW6Rc3
         SC49QeiJasqNB7OjAaSg1EefBkrwobCEYyiohZHEe5o4OVTSzwW/ZJXjk1Ne0CgaucbK
         Xa2uf2PiJOdxPTTaWot0VQcLzqC2MT3pma/N2mSjWnEVHSAa5u3pgsAzbJg+aFjonCfM
         f3gg==
X-Gm-Message-State: AO0yUKXnCJOccSLzPnXcPGIpUL1rj4Vt21biP7McUY/3LWa6K3k4Ykgr
        OfHmAQ+r6j9Af+iKtY7uF6yrbbtPpilwAnRAdyrW
X-Google-Smtp-Source: AK7set9uBhgzbmhDJCi0vSwei7yt7owdxxv4r10RmPDwX9b/iT9fNRgcOW9tiVqjYCNRwf+C738zFHavozwUxQbQaZ4=
X-Received: by 2002:a25:f512:0:b0:b3c:cbdb:ed5e with SMTP id
 a18-20020a25f512000000b00b3ccbdbed5emr8239740ybe.3.1678998112637; Thu, 16 Mar
 2023 13:21:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230316175749.233373-1-paul@paul-moore.com> <CAEjxPJ4v3KWoBidGpbrU9ibiQeuwUh34uEZg3E8tc7vPJ9dH0w@mail.gmail.com>
In-Reply-To: <CAEjxPJ4v3KWoBidGpbrU9ibiQeuwUh34uEZg3E8tc7vPJ9dH0w@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 16 Mar 2023 16:21:41 -0400
Message-ID: <CAHC9VhSzrF6QUgYSXGMUdS3J8xrWTNXT4onG7FV1e2nrVxuh4g@mail.gmail.com>
Subject: Re: [PATCH] selinux: remove the 'checkreqprot' functionality
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, selinux@vger.kernel.org,
        linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Mar 16, 2023 at 2:25=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Mar 16, 2023 at 2:01=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > We originally promised that the SELinux 'checkreqprot' functionality
> > would be removed no sooner than June 2021, and now that it is March
> > 2023 it seems like it is a good time to do the final removal.  The
> > deprecation notice in the kernel provides plenty of detail on why
> > 'checkreqprot' is not desirable, with the key point repeated below:
> >
> >   This was a compatibility mechanism for legacy userspace and
> >   for the READ_IMPLIES_EXEC personality flag.  However, if set to
> >   1, it weakens security by allowing mappings to be made executable
> >   without authorization by policy.  The default value of checkreqprot
> >   at boot was changed starting in Linux v4.4 to 0 (i.e. check the
> >   actual protection), and Android and Linux distributions have been
> >   explicitly writing a "0" to /sys/fs/selinux/checkreqprot during
> >   initialization for some time.
> >
> > Along with the official deprecation notice, we have been discussing
> > this on-list and directly with several of the larger SELinux-based
> > distros and everyone is happy to see this feature finally removed.
> > In an attempt to catch all of the smaller, and DIY, Linux systems
> > we have been writing a deprecation notice URL into the kernel log,
> > along with a growing ssleep() penalty, when admins enabled
> > checkreqprot at runtime or via the kernel command line.  We have
> > yet to have anyone come to us and raise an objection to the
> > deprecation or planned removal.
> >
> > It is worth noting that while this patch removes the checkreqprot
> > functionality, it leaves the user visible interfaces (kernel command
> > line and selinuxfs file) intact, just inert.  This should help
> > prevent breakages with existing userspace tools that correctly, but
> > unnecessarily, disable checkreqprot at boot or runtime.  Admins
> > that attempt to enable checkreqprot will be met with a removal
> > message in the kernel log.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Thanks Stephen.  Although I just noticed that we can drop the
checkreqprot_set() function entirely now, expect a v2 in just a moment
...

> I was wondering if we could remove the reqprot parameter altogether from =
the
> mmap/mprotect hooks but looks like IMA is using it.

Yep, there was even a recent bug fix about that too.

--=20
paul-moore.com
