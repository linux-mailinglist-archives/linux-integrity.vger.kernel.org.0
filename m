Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53DD066AC08
	for <lists+linux-integrity@lfdr.de>; Sat, 14 Jan 2023 16:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjANPMK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 14 Jan 2023 10:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjANPMJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 14 Jan 2023 10:12:09 -0500
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE4A7ED9;
        Sat, 14 Jan 2023 07:12:08 -0800 (PST)
Received: by mail-vk1-xa35.google.com with SMTP id t2so11501284vkk.9;
        Sat, 14 Jan 2023 07:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c3c8jaUlVE8BMYQeENjQTv3B3uo18OX21UOmGaxlhMQ=;
        b=EvnliFJWEZs0lZwDnnXBFsDDFEQE8V/IsI3mi7QxRAiz0nEEC+bN+v8A4J8F5PzabA
         7zrE82jDkkdVEd7/bkB4E4eAI+SIaRgEtWzpEJ6jOCxu8kze5TxoI2UDKjzI7Rfe9Ltx
         87XYsiNYYh8NChEGH+FU9bGC1MkRaxTUVTc5f6PCVciAt4xXXEEQdXO1apJnX3gqheIT
         tCGs/zmTrNxJjnxnL/SWFrTbCLvtgxAlLvlzGUvDaRzzZ4EYUCT0xtHrKCGghQJ3HB1U
         3RSiY5jzFI2hb6z9fC6FBQlW7OdizBhQ3O1ClhxQoRPQ8NiNqmsBamevFD6wdL4vI9Y4
         HCaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c3c8jaUlVE8BMYQeENjQTv3B3uo18OX21UOmGaxlhMQ=;
        b=k2m9JsTqAjByF9zMlNaYYG0wsP/XkWr1H+kKuBfI5mPEDE4wieDpfjOF3/b3IGkNbj
         /4qOyrkrhFYUd60d8ixSu6WLSJk+t3VSM92a/H559jgwc9v9pxKdTqxclE/OtxMwmbPD
         bWjxZbaQcRdJ8uRD0OHVUCs7IzUX4yY/MWhG0l1L0lDX2EzasLowBOvRqX1lHs/WvfkY
         b2OC0X/nCTWPyOOr9ZPNeDDZo+FSrM8W6OHDs5btgPnZVVwdDGX29zahyzSMBFfcytVW
         mpQ6VRd6PGGOiVWCgdwwJmmpqGyDghvGv0nMAuwD+5lsKcTuFvd4yFDlbOJeOUDR9JyC
         ah0A==
X-Gm-Message-State: AFqh2kqCOr1cwKEDItyTDlmA58GelGUHtJyVLzfRNEzyGNM3wSVHhMLz
        j/eIXhV9wJyJByuEYOe/+bySzY8EC1+ct/jf6EA=
X-Google-Smtp-Source: AMrXdXtV2YMvmar3+d29K0tNGtQeGVLbaIrl4wpklnxGW9hhNfA6PLTucAcBRnjzBF/J/HwA9uxEH7cjqCW5+9xCIVk=
X-Received: by 2002:a1f:4547:0:b0:3db:953:b832 with SMTP id
 s68-20020a1f4547000000b003db0953b832mr1139154vka.0.1673709127810; Sat, 14 Jan
 2023 07:12:07 -0800 (PST)
MIME-Version: 1.0
References: <20221111231636.3748636-1-evgreen@chromium.org>
 <20221111151451.v5.3.I9ded8c8caad27403e9284dfc78ad6cbd845bc98d@changeid>
 <8ae56656a461d7b957b93778d716c6161070383a.camel@linux.ibm.com>
 <CAHSSk06sH6Ck11R7k8Pk_30KbzLzZVdBdj5MpsNfY-R_1kt_dA@mail.gmail.com>
 <CAFftDdqUOiysgrAC4wPUXRaEWz4j9V6na3u4bm29AfxE8TAyXw@mail.gmail.com>
 <CAHSSk04asd_ac8KLJYNRyR1Z+fD+iUb+UxjUu0U=HbT1-2R7Ag@mail.gmail.com> <08302ed1c056da86a71aa2e6ca19111075383e75.camel@linux.ibm.com>
In-Reply-To: <08302ed1c056da86a71aa2e6ca19111075383e75.camel@linux.ibm.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Sat, 14 Jan 2023 09:11:56 -0600
Message-ID: <CAFftDdp3-GgAoryMFR424H1tGmxkwjRgWbeSZPpZrVU2=awHwA@mail.gmail.com>
Subject: Re: [PATCH v5 03/11] tpm: Allow PCR 23 to be restricted to
 kernel-only use
To:     jejb@linux.ibm.com
Cc:     Matthew Garrett <mgarrett@aurora.tech>,
        Evan Green <evgreen@chromium.org>,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-integrity@vger.kernel.org,
        Eric Biggers <ebiggers@kernel.org>, gwendal@chromium.org,
        dianders@chromium.org, apronin@chromium.org,
        Pavel Machek <pavel@ucw.cz>, Ben Boeckel <me@benboeckel.net>,
        rjw@rjwysocki.net, Kees Cook <keescook@chromium.org>,
        dlunev@google.com, zohar@linux.ibm.com, jarkko@kernel.org,
        linux-pm@vger.kernel.org, Matthew Garrett <mjg59@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Jan 14, 2023 at 8:55 AM James Bottomley <jejb@linux.ibm.com> wrote:
>
> On Tue, 2023-01-03 at 13:10 -0800, Matthew Garrett wrote:
> > On Tue, Jan 3, 2023 at 1:05 PM William Roberts
> > <bill.c.roberts@gmail.com> wrote:
> >
> > > What's the use case of using the creation data and ticket in this
> > > context? Who gets the creationData and the ticket?
> > > Could a user supplied outsideInfo work? IIRC I saw some patches
> > > flying around where the sessions will get encrypted and presumably
> > > correctly as well. This would allow the transfer of that
> > > outsideInfo, like the NV Index PCR value to be included and
> > > integrity protected by the session HMAC.
> >
> > The goal is to ensure that the key was generated by the kernel. In
> > the absence of the creation data, an attacker could generate a
> > hibernation image using their own key and trick the kernel into
> > resuming arbitrary code. We don't have any way to pass secret data
> > from the hibernate kernel to the resume kernel, so I don't think
> > there's any easy way to do it with outsideinfo.
>
> Can we go back again to why you can't use locality?  It's exactly
> designed for this since locality is part of creation data.  Currently
> everything only uses locality 0, so it's impossible for anyone on Linux
> to produce a key with anything other than 0 in the creation data for
> locality.  However, the dynamic launch people are proposing that the
> Kernel should use Locality 2 for all its operations, which would allow
> you to distinguish a key created by the kernel from one created by a
> user by locality.
>
> I think the previous objection was that not all TPMs implement
> locality, but then not all laptops have TPMs either, so if you ever
> come across one which has a TPM but no locality, it's in a very similar
> security boat to one which has no TPM.
>

I also usually stick to features within the PTP spec[1], which includes
the locality support.

+2 for locality, I responded somewhere that I also support locality. I
was thinking more of TPM2_PolicyLocality I didn't realize that's
within the creationData. I was thinking more along the lines of, can I
wield the key over "did my locality create it". I'm not sure
what other protections are on the key,are there any protections
preventing them from
wielding it and using it to sign something nefarious?

1. https://trustedcomputinggroup.org/wp-content/uploads/TCG_PC_Client_Platform_TPM_Profile_PTP_Specification_Family_2.0_Revision_1.3v22.pdf

> James
>
