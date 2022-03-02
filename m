Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788B34CAF7F
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Mar 2022 21:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiCBURN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Mar 2022 15:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242976AbiCBURM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Mar 2022 15:17:12 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E551CD5EA
        for <linux-integrity@vger.kernel.org>; Wed,  2 Mar 2022 12:16:29 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-2dc0364d2ceso31714037b3.7
        for <linux-integrity@vger.kernel.org>; Wed, 02 Mar 2022 12:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s67k1EJaVHxhbvHcAvfuqUxfoKCbqS5gFyMqywS2VG8=;
        b=XcytHnVbWT2BCtJIxUY3icFBZrzB/UM6egb4+8ldoQNwtxdhCmQtI0kuab6DQqU6qo
         gREp7w5CH5ciETcu04uh43n3wOUL0XtK/NgBnH5tLLMjYEm+WiN46gn7Fl3yGjipLbuQ
         PZ1W/MJEd/F0PAjXjZRmRjAMCrzJe+N+NRgaVUq/qG+zKn5R7aGFuTlKoebQrLjx/w9y
         PsXY3fEydh4c+QBEe37955ZDdEnyAmoBtwiXUwAHkChgyAqFm/TDdhko67VIx/mABpHA
         wqocT9Ek4mHW7K0k4CusZJO6d9qTP6cgnO878m0rfVkdc5gvMmkaFNTM4zQ2LQozzoVB
         E4uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s67k1EJaVHxhbvHcAvfuqUxfoKCbqS5gFyMqywS2VG8=;
        b=iJ3UE5noR/VxCWL4E1MY/Jw+x+4raqG2H0uOEvPQOh1t9yMUr0z3/G8kCqhylwkLcT
         CEA0VPYR5tkkejC0yu2ACWYQlmxgnVJyxeEettuuFmvfqlEMQr6HRiuPSPB327q1D0BG
         SB+mWBTx/40iw6rEnLO+5l+KKb+ADpDg4Wj43eGEMZvlPu2VVENZ3VM3aUynxnHR1rij
         Hvnw6CzQk7nXmdbpoSO8a4EC4lRC/6yvi5fkpOZJXsd7fqXPZ9xNPxw52aw6AA0yTw+3
         32NbtXEHoUjCwrOjA5TJ+riwjc5uyuzzOZla1CcfNnxk3mVq3ZoWbOPuq+KbNwZqn8WN
         nBcg==
X-Gm-Message-State: AOAM53119CiN/J2ldNuI8ngsKEgEGmczpqpjrnq6Lm2Jthie8nnzRr/t
        g86WHmXxBEL0R0CSSprYVefkvpq8Fsn6cszzETJoSA==
X-Google-Smtp-Source: ABdhPJzrH2if6CDf5wHK5EtuFMgfqu1uxju7OgWv0aks44zYH+1hcVNDxiRW4mKpFQe+z5VHbHFZvo9CV5G/1sjJr44=
X-Received: by 2002:a81:a552:0:b0:2dc:15ce:21e with SMTP id
 v18-20020a81a552000000b002dc15ce021emr3588744ywg.250.1646252188339; Wed, 02
 Mar 2022 12:16:28 -0800 (PST)
MIME-Version: 1.0
References: <20220223200731.1859670-1-yaelt@google.com> <Yh+S7JD2q8oalRoM@yuki>
In-Reply-To: <Yh+S7JD2q8oalRoM@yuki>
From:   Yael Tzur <yaelt@google.com>
Date:   Wed, 2 Mar 2022 15:16:17 -0500
Message-ID: <CAKoutNsWCE9wuXwBW544FFe5NDNdbRNOUyD335yEEaMQHbqqug@mail.gmail.com>
Subject: Re: [LTP] [PATCH v4] syscalls/keyctl09: test encrypted keys with
 provided decrypted data.
To:     Cyril Hrubis <chrubis@suse.cz>
Cc:     ltp@lists.linux.it, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Mar 2, 2022 at 10:50 AM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> The test looks good to me now.
>
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
>
> Looking at the kernel counterpart it is still in the next tree. We
> usually wait until the kernel functionality is part of a kernel release
> in order to make sure that there are no changes done to the
> kernel-userspace API.
>
> I this case I guess that in this case the change is so minimal that we
> can add this test into LTP once it reaches Linus tree.
>
> --
> Cyril Hrubis
> chrubis@suse.cz

Sounds good. Thank you!
