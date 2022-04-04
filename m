Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7D64F206A
	for <lists+linux-integrity@lfdr.de>; Tue,  5 Apr 2022 01:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiDDXvy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 4 Apr 2022 19:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiDDXvx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 4 Apr 2022 19:51:53 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA70B67
        for <linux-integrity@vger.kernel.org>; Mon,  4 Apr 2022 16:49:51 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id i6-20020a1c3b06000000b0038e710da2dcso535906wma.1
        for <linux-integrity@vger.kernel.org>; Mon, 04 Apr 2022 16:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l9xW3HAcFSKuV+/FcSEP9k1d5+BZ/v4v+0buVAagfng=;
        b=Rtdpm9/eExIrkWu7lqvtkp2SFUdc1voWm++CoidXs0vCCl0DY2whSZxPuRt8j+gotn
         +MrPOkFIqus6rHCei1KQMzI1v3glGY2IrhLl4sZuHtCXfTqNTYi1CmXVfLs14gYU7Dtv
         XJJWs78w5wb0t8EsE89dxxUJNOF5TMhq0guchBQ1GMv5FMZRNfVzhUMPlK6qRz9QjRbU
         z7Mmj1n/Vk4XgkeoTJUtjGrzX+Dof23gOL+XiaQSv/asA4zYRHUX6XqkqKxXOGDM4HI1
         2p43PYHU8zuby29ZXuOjKABaRi1tTnGXw3urM1d/B8NwhpVSxEYBjUEyQsfbmNfwhjcD
         5DeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l9xW3HAcFSKuV+/FcSEP9k1d5+BZ/v4v+0buVAagfng=;
        b=gStN7rjEXt5MVNwrPGAi/QBcuOuL8p0iwLDauE5ilU2BX9Z/P8DB9pSHJEmfiu2mxO
         bW2D3IqVXO5FkL2nFmaEoLeFadye3J8Ivqi9ZOI40YVJwTMQCbkn6Fo/RRzlVbdgxsFy
         P/YtcEG0BIV5QkBMXQFq4LuHYzgXHP530T0wnmW91wiN3DdqtAHFTql6dSbryRJowuIh
         6NkDq7HZ8HNcbkV9CRft/Oxsr5ZXwubwj9FT0Rjzho7ur797DJGlsYZTEH9OkCtRq58M
         cUO7kKk9ELwzVOlXOO6Tzua+Uu/LKdd2nAE9mVhQfMDycbLPqvbliWtHn/NEFhwWVM71
         9ixA==
X-Gm-Message-State: AOAM531UO+CBVDtX2QrOjImL3xNV3eKkf0yC3Qm6AfKo7K68rhBtA+/B
        K0hEYibTdV1p2vnd7ZAppc2rUOggDKixel/uFPU2DA==
X-Google-Smtp-Source: ABdhPJyg+abWix7Ts4qCEO7RXp6fKaPsVgBsnBTOQy+NgVb44hvZvX8QAtOVUrILV/l+lMXh8eMMBCOoDOqNay9FyAk=
X-Received: by 2002:a05:600c:1797:b0:38e:70fa:4e4f with SMTP id
 x23-20020a05600c179700b0038e70fa4e4fmr479543wmo.30.1649115908962; Mon, 04 Apr
 2022 16:45:08 -0700 (PDT)
MIME-Version: 1.0
References: <CANMTAZSQgokaG7ZaqipcR56yzOK7iDq50P0_GKd-H7nxUX3TzQ@mail.gmail.com>
 <Ykt9hoX+mPG1oirv@sol.localdomain>
In-Reply-To: <Ykt9hoX+mPG1oirv@sol.localdomain>
From:   Jes Klinke <jbk@google.com>
Date:   Mon, 4 Apr 2022 16:44:57 -0700
Message-ID: <CANMTAZR-7UEeNXx0Syd+eS7L1K9xc6X9L01UoT50xpDPu4+xVQ@mail.gmail.com>
Subject: Re: PATCH: Google security chip, additional DID:VID
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

I have sent a separate email to the list with the patch, in which I
have cut out the long explanation, added Signed-off-by, and added the
delimiter for the diff.  Let me know if there are anything else I have
overlooked.

Regards
Jes

On Mon, Apr 4, 2022 at 4:21 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Mon, Apr 04, 2022 at 04:00:31PM -0700, Jes Klinke wrote:
> > Hello Peter,
> >
> > I am a firmware engineer working on the TPM chip in Chromebooks (known
> > as cr50).  As we plan to deploy a new codebase on our TPM chips, we
> > will have them present a new DID:VID value, but otherwise follow the
> > same protocol as the existing implementations.
> >
> > The below patch has the effect of accepting one additional numerical
> > value, and logging one of two messages, depending on the value.
> > Unfortunately, I had to reverse the indentation, so the diff appears
> > to touch more lines than it needed to do.
> >
> > I am unsure which procedure to follow, as this is my first kernel
> > patch.  Let me know if posting the patch inline like this is not the
> > way to go.
>
> Can you take a look at Documentation/process/submitting-patches.rst?
>
> - Eric
