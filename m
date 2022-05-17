Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14BE552A79E
	for <lists+linux-integrity@lfdr.de>; Tue, 17 May 2022 18:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350672AbiEQQG6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 17 May 2022 12:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350676AbiEQQG5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 May 2022 12:06:57 -0400
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A63369E5;
        Tue, 17 May 2022 09:06:56 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id i11so33157487ybq.9;
        Tue, 17 May 2022 09:06:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T+Y0T0by6V75JyhkkKhy6aaHysUDsmwlgU76NEv5hWY=;
        b=JTxWjsc1g9aYb/foqfiAq6EqRuWOzjuVWT97j4hei0KotI2fGZLoyk5H9k2vpFVABK
         2gMsAP0otZsp+mk4lMAGh5XYJwdaXjJoz80VaExDriCUo+A3xY8XODKIDdwx5p18pPUQ
         a79VdvzuaLIqj7ePYQqWL3ltFlobmmcsUXkTK16aBZNP/jNyitdFGU1TkiZDemdu5EsA
         8Fi83f/O6anK8/sqbNSQwnkPiUtuJCD7cQPLa7QkjqinCLfNzWPo9z3j5A7g3ADyELE4
         9S2kwN74Xkh074fXE7Mzs60WyKzUKTnfuGprrBd12erZl9WIBPz4akLvqw3XGoYMz2LX
         5cXA==
X-Gm-Message-State: AOAM5304AGrVtug+HToZCE+wR33fjbyUtDZYx3YvC6ghQNl6CkbNe1AC
        KpDRUclLkwOy0fMtVPDqu2oZVjTI/cKT/WlHqws/ufhe
X-Google-Smtp-Source: ABdhPJy1LGg4mJVH0m9Pwfdn7gwx0zv22rx74oJyN/QFQI66KeJQrMvIuDw13YQMm1Z5ZZyzAnUAXdJqmdCaaW/IMyc=
X-Received: by 2002:a25:1145:0:b0:64d:d6be:c741 with SMTP id
 66-20020a251145000000b0064dd6bec741mr8135761ybr.137.1652803615502; Tue, 17
 May 2022 09:06:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220504232102.469959-1-evgreen@chromium.org> <20220506160807.GA1060@bug>
 <CAE=gft6m75T0UC2DBhfFhuSMW6TK7aatD_04sQ18WosgGVsATw@mail.gmail.com>
In-Reply-To: <CAE=gft6m75T0UC2DBhfFhuSMW6TK7aatD_04sQ18WosgGVsATw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 17 May 2022 18:06:44 +0200
Message-ID: <CAJZ5v0gxq=EA_WWUiCR_w8o87iTHDR7OC5wi=GRBaAQS2ofd5w@mail.gmail.com>
Subject: Re: [PATCH 00/10] Encrypted Hibernation
To:     Evan Green <evgreen@chromium.org>
Cc:     Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>,
        Matthew Garrett <mgarrett@aurora.tech>,
        Daniil Lunev <dlunev@google.com>, zohar@linux.ibm.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-integrity@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Hao Wu <hao.wu@rubrik.com>, James Morris <jmorris@namei.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Len Brown <len.brown@intel.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, axelj <axelj@axis.com>,
        keyrings@vger.kernel.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, May 9, 2022 at 6:44 PM Evan Green <evgreen@chromium.org> wrote:
>
> On Fri, May 6, 2022 at 9:08 AM Pavel Machek <pavel@ucw.cz> wrote:
> >
> > Hi!
> >
> > > We are exploring enabling hibernation in some new scenarios. However,
> > > our security team has a few requirements, listed below:
> > > 1. The hibernate image must be encrypted with protection derived from
> > >    both the platform (eg TPM) and user authentication data (eg
> > >    password).
> > > 2. Hibernation must not be a vector by which a malicious userspace can
> > >    escalate to the kernel.
> >
> > Can you (or your security team) explain why requirement 2. is needed?
> >
> > On normal systems, trusted userspace handles kernel upgrades (for example),
> > so it can escalate to kernel priviledges.
> >
>
> Our systems are a little more sealed up than a normal distro, we use
> Verified Boot [1]. To summarize, RO firmware with an embedded public
> key verifies that the kernel+commandline was signed by Google. The
> commandline includes the root hash of the rootfs as well (where the
> modules live). So when an update is applied (A/B style, including the
> whole rootfs), assuming the RO firmware stayed RO (which requires
> physical measures to defeat), we can guarantee that the kernel,
> commandline, and rootfs have not been tampered with.
>
> Verified boot gives us confidence that on each boot, we're at least
> starting from known code. This makes it more challenging for an
> attacker to persist an exploit across reboot. With the kernel and
> modules verified, we try to make it non-trivial for someone who does
> manage to gain root execution once from escalating to kernel
> execution. Hibernation would be one obvious escalation route, so we're
> hoping to find a way to enable it without handing out that easy
> primitive.
>
> [1] https://www.chromium.org/chromium-os/chromiumos-design-docs/verified-boot/

So I guess this really is an RFC.

Honestly, I need more time to go through this and there are pieces of
it that need to be looked at other people (like the TPM-related
changes).

Thanks!
