Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C916465C89A
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Jan 2023 22:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237846AbjACVG1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Jan 2023 16:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233586AbjACVFI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Jan 2023 16:05:08 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A541408A;
        Tue,  3 Jan 2023 13:05:07 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id q3so6334528uao.2;
        Tue, 03 Jan 2023 13:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1BpgH2JExWhLYwx16JSRZTh0GkhP5q2EUrahmB7s1do=;
        b=ccvD8F2bv5jXTZjdbF27x/Y8owkiRaw/1iscjN3qC4sSz+hZsjSgXf2x5o8nJw4WJI
         OtEfcSpQuOYVVmXAskTxFHOBPDQEYe8GABS/3WsemdAF9MtmyJezankDZN+WUvxMPTHO
         dyXoaaAx9Fnu+nlFasNQSoTbQ8Z5TPgi+lbSH7mv5SnGIL9tQ0XTCehCcUmky5D3ZqvT
         VmJeB8iV4NemPjLnFfCiR1WXra6OaQtMt4mR4s+aYcGsXkYw4pqK8Qj99fOY6Cz/XKDh
         FphiQZxROts6gnWx223bixxdk3hht4OLI439WOy85ZRi3o61bE4QN/RkbOKLy8f4mjZV
         /5KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1BpgH2JExWhLYwx16JSRZTh0GkhP5q2EUrahmB7s1do=;
        b=N+EIL9xPQ/Ior0sXRBS/IAbiH634MF1o1L3UjnztFpKt/Lp8yO8ig6fpNG96c9h14O
         EEN10VgfFzpPS8msVdJbR/KqjQOF6Gap6ka7g6fnGKyuqs77W3f99PVWCC3MzFZh7RzO
         kfE13ES68CFp8k6Ikx7E9xYpIClijhrQpdXhQ6/oN+P6/1yTy+XDvWWonGT331Q6WpvG
         EHDTj43+hoSqY5lpmqvnT22P98st8/NiP1rx3kMVQliA3LxOUtwaelLxdSwXyIzl2VFs
         rZKXKtZCQQ2mRXk6dDienzsMon9iTjaWmgn1MObDCbFTsqRq/ITYvRS3hzf65ZbeeIPm
         8lGQ==
X-Gm-Message-State: AFqh2krNEQ2eMIN7LiiSTAXYIHkx/6QMlN5oZL7L8aAjdKZFdon1eTRi
        ITRrEZhYIxcc9tdPbbhshmTb76ghdPJ9STNTT1A=
X-Google-Smtp-Source: AMrXdXvnFOqsyc/ytllllcjQjhKZoHWk94A3zikvtODEWsLFPjX3cxdD5uVhmOezj6h7ULdkTTxyei6MoednrJmmo5U=
X-Received: by 2002:ab0:7a61:0:b0:4c2:5fc2:47fb with SMTP id
 c1-20020ab07a61000000b004c25fc247fbmr3089670uat.58.1672779906917; Tue, 03 Jan
 2023 13:05:06 -0800 (PST)
MIME-Version: 1.0
References: <20221111231636.3748636-1-evgreen@chromium.org>
 <20221111151451.v5.3.I9ded8c8caad27403e9284dfc78ad6cbd845bc98d@changeid>
 <8ae56656a461d7b957b93778d716c6161070383a.camel@linux.ibm.com> <CAHSSk06sH6Ck11R7k8Pk_30KbzLzZVdBdj5MpsNfY-R_1kt_dA@mail.gmail.com>
In-Reply-To: <CAHSSk06sH6Ck11R7k8Pk_30KbzLzZVdBdj5MpsNfY-R_1kt_dA@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Tue, 3 Jan 2023 15:04:55 -0600
Message-ID: <CAFftDdqUOiysgrAC4wPUXRaEWz4j9V6na3u4bm29AfxE8TAyXw@mail.gmail.com>
Subject: Re: [PATCH v5 03/11] tpm: Allow PCR 23 to be restricted to
 kernel-only use
To:     Matthew Garrett <mgarrett@aurora.tech>
Cc:     jejb@linux.ibm.com, Evan Green <evgreen@chromium.org>,
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

On Tue, Jan 3, 2023 at 2:43 PM Matthew Garrett <mgarrett@aurora.tech> wrote:
>
> On Mon, Nov 14, 2022 at 9:11 AM James Bottomley <jejb@linux.ibm.com> wrote:
> >
> > On Fri, 2022-11-11 at 15:16 -0800, Evan Green wrote:
> > > Introduce a new Kconfig, TCG_TPM_RESTRICT_PCR, which if enabled
> > > restricts usermode's ability to extend or reset PCR 23.
> >
> > Could I re ask the question here that I asked of Matthew's patch set:
> >
> > https://lore.kernel.org/all/b0c4980c8fad14115daa3040979c52f07f7fbe2c.camel@linux.ibm.com/
> >
> > Which was could we use an NVRAM index in the TPM instead of a PCR?  The
> > reason for asking was that PCRs are rather precious and might get more
> > so now that Lennart has some grand scheme for using more of them in his
> > unified boot project.  Matthew promised to play with the idea but never
> > got back to the patch set to say whether he investigated this or not.
>
> Is there any way to get key creation data to include NV indexes?

Not that I am aware of and the spec seems to be a no.

> If not, no, we can't use NVRAM.

What's the use case of using the creation data and ticket in this
context? Who gets the
creationData and the ticket?
Could a user supplied outsideInfo work? IIRC I saw some patches flying around
where the sessions will get encrypted and presumably correctly as well. This
would allow the transfer of that outsideInfo, like the NV Index PCR value to
be included and integrity protected by the session HMAC.
