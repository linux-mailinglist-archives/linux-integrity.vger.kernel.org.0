Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 293D32F9A35
	for <lists+linux-integrity@lfdr.de>; Mon, 18 Jan 2021 07:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbhARGyw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 18 Jan 2021 01:54:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732707AbhARGym (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 18 Jan 2021 01:54:42 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC66BC061574
        for <linux-integrity@vger.kernel.org>; Sun, 17 Jan 2021 22:53:49 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id u21so17112918lja.0
        for <linux-integrity@vger.kernel.org>; Sun, 17 Jan 2021 22:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qgcz/PpxZGsB8o1BijgydwK4c5Ezi5YX62jHdsF7P9I=;
        b=NANe9jwNsVbZexOYr67tmVCUssf5v62nRFZBq//EHaBlIHASJRxQlArAp5qOgBouCn
         /jLlmOf1VsoVP1Thj0IyOH1W2hI3ay6bQHSL3f5AYFlYZ2WgKJ6Cpl7/pdh7jIVLxQql
         SDXu7EAvOK4EOPp1xbY70RjC12SyqjVsHFbeZ2SB5RpauLKSzNtRTbqLkjdGQSojgFoS
         saHacoN8UQ4DUZSXUtICmchZVbbX/24p9dud81hmVbq/n1M3rkPTdq4J9yylajtzpIPJ
         wu3WLBV0YIqm478Wr5c+KTuJCZJievPaOth44Hwe0Ai2rLWIp6NpzulsxtOGnd1INPwD
         s74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qgcz/PpxZGsB8o1BijgydwK4c5Ezi5YX62jHdsF7P9I=;
        b=k1IWk6/oU7HhfMfzVZfXULWZloGfmxkkTnxaPxf/kFjVoiNZy9JopU6lNAXTaiX6rC
         yommyUvDHBVykbWUrJ1Lr1wW7j7g6pFzQ9DASnx2CFRSO3muAfGsy6uOhKt+e/kprOqE
         M/LX1w/FEM374QQwbIvK22xy7GZTugQOE8yJFmBqZz/Q4nhXaAn2uA4BiX2Bk3GWXNnu
         iOBlEa/VLnO5DBAIH5FUrW3kdTQBfY7w89TwuJOED076c/cSuR30BrNpp/km2lIFnfy7
         dNrDS86hw5diCb282Z3K5gfUKrVAvUlqmGfLqtAzrO8tp/KcTx5lytvARk2K6aP3FNKs
         5dWQ==
X-Gm-Message-State: AOAM533ye0F9Nq1UuKojJ6CmdTaDAlLMbOETZMe6LgZM/s8jUd8h45y6
        YT7qI63iN1MCPiG4KLbrGVzDqbUev/KqhPBBzje3VA==
X-Google-Smtp-Source: ABdhPJx2/iDpZZUj8WQCp4pQnqtigzhYNy6+9CXASdOAh/WB59V/P5XME0FEbXxjPPd9B/+byXacjkhdsvHAoRZdDkc=
X-Received: by 2002:a2e:b806:: with SMTP id u6mr9877991ljo.442.1610952828391;
 Sun, 17 Jan 2021 22:53:48 -0800 (PST)
MIME-Version: 1.0
References: <20201209164249.715178-1-zohar@linux.ibm.com> <20201211081454.GA5262@kernel.org>
 <CAFA6WYMt5+zX09bdgugSq9SgqF=V_OfOZee8fBEAv1thFLs3nA@mail.gmail.com>
 <X/pxpAfn4MFsXT4g@kernel.org> <CAFA6WYO0CW3k+OCBV2UqM1-kK6Fm1A6PfNpLCOA6g=mwYRgb2Q@mail.gmail.com>
 <X/9k19UoZZdC+y0+@kernel.org> <19d3547b-c285-aa98-0cc3-cc55ef09a1b9@gmail.com>
In-Reply-To: <19d3547b-c285-aa98-0cc3-cc55ef09a1b9@gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 18 Jan 2021 12:23:37 +0530
Message-ID: <CAFA6WYP5zQOk-C47L9se6V2zJmtq8rCha1SL-kgr_dRxQSM=sA@mail.gmail.com>
Subject: Re: [PATCH] doc: trusted-encrypted: updates with TEE as a new trust
 source (update)
To:     Elaine Palmer <erpalmerny@gmail.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        Elaine Palmer <erpalmer@us.ibm.com>,
        George Wilson <gcwilson@us.ibm.com>, zgu@us.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Elaine,

On Sat, 16 Jan 2021 at 04:45, Elaine Palmer <erpalmerny@gmail.com> wrote:
>
>
>
> On 1/13/21 4:23 PM, Jarkko Sakkinen wrote:
> > On Tue, Jan 12, 2021 at 10:55:44AM +0530, Sumit Garg wrote:
> >> On Sun, 10 Jan 2021 at 08:46, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >>> On Mon, Jan 04, 2021 at 06:06:33PM +0530, Sumit Garg wrote:
> >>>> Hi Jarkko, On Fri, 11 Dec 2020 at 13:44, Jarkko Sakkinen
> >>>> <jarkko@kernel.org> wrote:
> >>>>> On Wed, Dec 09, 2020 at 11:42:49AM -0500, Mimi Zohar wrote:
> >>>>>> From: Elaine Palmer <erpalmer@us.ibm.com> Update trusted key
> >>>>>> documentation with additional comparisons between discrete TPMs
> >>>>>> and TEE. Signed-off-by: Elaine Palmer <erpalmer@us.ibm.com>
> >>>>> Right, so OP-TEE is not the same as TEE. I did not know this and
> >>>>> the patch set does not underline this. I re-checked the patches
> >>>>> and none of them say explicitly that OP-TEE is an application
> >>>>> living inside TEE.
> >>>> This patch-set provides a trust source based on generic TEE
> >>>> interface where underlying TEE implementations like OP-TEE
> >>>> (drivers/tee/optee/), AMD TEE (drivers/tee/amdtee/) etc. can easily
> >>>> be hooked up. And this is similar to the TPM interface where
> >>>> underlying TPM implementations like discrete TPM, virtual TPM,
> >>>> firmware TPM etc. can be easily hooked up.
> >>>>> This essentially means that the backend needs to be renamed as
> >>>>> "op_tee".
> >>>> I don't see any need for this, see above.
> >>> Right, TEE is a protocol standard, just like TPM, and OP-TEE is one
> >>> implementation of this interface? I.e. OP-TEE does not define API
> >>> that is hard bound to OP-TEE?
> >> Yes, OP-TEE doesn't define a hard bound client interface API. The
> >> client API is based on TEE client API specification [1] from
> >> GlobalPlatform. [1]
> >> http://globalplatform.org/specs-library/tee-client-api-specification/
> >> -Sumit
> > Thanks, bookmarked. No need for name change. /Jarkko
> This discussion has illustrated that even those of us who live and
> breathe this stuff could use clarification.  Shouldn't we recommend
> that the Trust Source have a hardware root of trust?  We could be
> even more specific.  For example, the documentation could recommend
> that a TPM be evaluated under "TCG Protection Profile for PC Client
> Specific TPM 2.0" or later and a TEE be evaluated under GlobalPlatform
> "TEE Protection Profile v1.3, GPD_SPE_021" or later.  Of course, our
> recommendation would not be a requirement, but it would provide
> guidance for deployment as well as precedent for future Trust Sources.
>

Sure, I will update documentation to mention this as a recommendation.

> I know where I'm getting stuck is on TEEs as a concept vs
> TEEs with specific hardware requirements and interfaces.
> The same applies to TPMs.  There are hardware TPMs that meet
> the protection profile and there are other implementations
> (e.g., vTPMs) that use the same interface, but aren't anchored in
> hardware.

Similar is the case with TEEs which can have varying hardware
realizations. Have a look at "Figure 2-3: Example Hardware
Realizations of TEE" from TEE system architecture specification [1].

[1] https://globalplatform.org/specs-library/tee-system-architecture-v1-2/

>
> I know if I were deploying a server, mobile device, or IoT device, I'd
> want to know exactly what is protecting my keys.  A generic TPM or TEE
> doesn't tell me enough.
>

Agree.

-Sumit

> -Elaine
>
>
