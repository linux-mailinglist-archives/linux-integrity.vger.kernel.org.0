Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B1B660972
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Jan 2023 23:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjAFWXX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 6 Jan 2023 17:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjAFWXW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 6 Jan 2023 17:23:22 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C770680630
        for <linux-integrity@vger.kernel.org>; Fri,  6 Jan 2023 14:23:20 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id t8so641994uaj.5
        for <linux-integrity@vger.kernel.org>; Fri, 06 Jan 2023 14:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pKfuyHTBtdhQN3JK5P2OOfbuhHpVARhBJ5IfVqBCGvQ=;
        b=BMiumtIzTT7QFpJiPA0PUJGRUS84y6ItjR0cT1t/Wx0bA4s2Ht7++hAuXIo6+WqHp1
         G2LzcnSWN6YMSfYLL8IS/orN4kVEcp2fHIJwNNTKJ99BVzBzMU31jYfn4yPvo7nMEVT4
         iaZW2xHjBKrEaKgRvh/+LF1JCNTL17qAMXafMeTr+NUyrMb5CqOTqv5gCn8LYozlymtf
         wpXVwLDCfVurGGpVXTDPxXoZNr+X7JVPtVnZF3Di7J6T+bpOqF0nFmb9gwSZDUy0v7Pm
         vDL+DVDVwG5+GJebhccAHGD7A8D4VLf8NtUz/04PpOdI1sauK3gOPPpVF0eQJHDZpBo/
         RzHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pKfuyHTBtdhQN3JK5P2OOfbuhHpVARhBJ5IfVqBCGvQ=;
        b=aebEf8O5DOR4mZFz0mBB3UJxnX4ydHKkuml5zVehqeaZsVgzD9EQBDeivpQseQiM8G
         8oBieE9qhx2WMlSKBvop5ohfv50baF3l07+G51c8Z1Kfw8rUFv0TSYwmeKVj3SlyuCQ0
         uQUBu8Z4bHpJHhZHcHeWXOZjf3ebBMqPgHpW6aj5wE8mD0tRuVjyptNn2PCLnTWQuMye
         y1uMNIPXvdPgKPt3qzYVeCLxglKjoHu5OcLmr5aREQQhIpXb9C6xc2ZgJ4wGvNCqZEYR
         8Oif4vM7zoVtiXrucDVZUH0uKcag1VCYgrNl1YYbpQ3pu4Px0zbWTcALY8clvWpa8SEJ
         0e3Q==
X-Gm-Message-State: AFqh2ko7nk5OBAEiSIKCqYrn9mLdp6jkPvbUrbK6gCmax50vPaM/UG6s
        EGuQRQQdJS77EY8IbnHZHjT9VeLiMshlfH8v3wo=
X-Google-Smtp-Source: AMrXdXt/fG5ST5q1Z9+4PTaf7jx2wyFK8+vp3ZllDjGDxO7lHBzU+1aNK+K0LTGk4u5b3HsL2d+b7ZYGNgLe5SseYv8=
X-Received: by 2002:a9f:386b:0:b0:419:1620:be75 with SMTP id
 q40-20020a9f386b000000b004191620be75mr5409301uad.78.1673043799833; Fri, 06
 Jan 2023 14:23:19 -0800 (PST)
MIME-Version: 1.0
References: <CADg8p94+rY5B937YweMo=5aGS4Dhz2z4QW-BiAdkVdiWCm-u9w@mail.gmail.com>
 <3bd7c0b2c9937c30082381f92624e98902c72ece.camel@HansenPartnership.com>
 <CADg8p94qd-Kx9Xn2LwqypFeAsV734wv7CvswPmGqJZa+ENPpRg@mail.gmail.com>
 <2910376b6912885f696afebf43b820513c004dbb.camel@HansenPartnership.com> <63a8c022-1407-d701-e756-070e299b5803@linux.ibm.com>
In-Reply-To: <63a8c022-1407-d701-e756-070e299b5803@linux.ibm.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Fri, 6 Jan 2023 16:23:08 -0600
Message-ID: <CAFftDdr6qs33HaaPK3MMmyi9-mMjUuLURt9PAum6hJ3N3m=_iw@mail.gmail.com>
Subject: Re: Seal/Unseal trusted keys against PCR policy
To:     Ken Goldman <kgold@linux.ibm.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Sughosh Ganu <sughosh.ganu@linaro.org>,
        linux-integrity@vger.kernel.org
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

On Fri, Jan 6, 2023, 15:55 Ken Goldman <kgold@linux.ibm.com> wrote:
>
> On 12/28/2022 5:48 PM, James Bottomley wrote:
> > The main thing you have to do is connect to the TPM not through the
> > resource manager so the policy session survives multiple commands
> >
> > export TPM_DEVICE=/dev/tpm0
>
> Just FYI, as James says, command line utilities interact with the
> resource manager.  When I want to run command line programs through the
> resource manager, I use a proxy to keep the /dev/tpmrm0 session connected.
>
> https://github.com/kgoldman/ibmtss/blob/master/utils/tpmproxy.c holds an
> open source proxy.
>

If you need to do this in production that tpmproxy allows anyone to
connect to it. So while it's open it
would circumvent the permissions on /dev/tpmrm0. You can just use
tpm2-tools, which uses
contexts and avoids this problem.
