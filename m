Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0862E753FC7
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Jul 2023 18:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236233AbjGNQWI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 14 Jul 2023 12:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235737AbjGNQWH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 14 Jul 2023 12:22:07 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5642115
        for <linux-integrity@vger.kernel.org>; Fri, 14 Jul 2023 09:22:06 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b703d7ed3aso33196061fa.1
        for <linux-integrity@vger.kernel.org>; Fri, 14 Jul 2023 09:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1689351725; x=1691943725;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rFEjcMXqBZrAZsK+2fE1V7QZr5MeKAXaA74Ueb4SV2s=;
        b=a1WhRuL0BZgTm8AuZVAmExteF2/lMnb5W5IAKnI3MkLdc4lrjyuQ81GWOA7h8N0Gn7
         o2649bvARu3akwfmjcq1x9fJ48MYE5zsDYuKkzfmFf9P0kOpEIl0ZkzW7KQjPnAkqMWI
         1/3DASJ/PNY7Y7H8JK+xPLUKajNq273pit/I4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689351725; x=1691943725;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rFEjcMXqBZrAZsK+2fE1V7QZr5MeKAXaA74Ueb4SV2s=;
        b=C4SagNl8ssak+mQfuOQeKt1JP9e1wKiTN7WZew4OnWlWfFVH5ZQbosQqCfazD6TcQ1
         w1FBwL5b+Dq/L8mc+NeB2hh+oNBya1gvUfolQ9Uzo9IzKGxRh5RmJUz9GWpQQhl1Y2z3
         QwzGG46vy/fCNW/lpraHYf9VK5Xvxpebjk+h8jXSwHMklBI8DNOLdhRLVm/ZKjTh2c2f
         if4HxCYA26znbiwwY2l1pzNKE6roYbVaUM5w1DctnknLeUrZDacAHdO+OpVGJy1cVg2b
         6g7sADZ0z/RifZJmRbPQ9R43Vw8EE2j3856KLP38Zy1SSPV+awBs5AEgSUmPfurTTjqi
         LjrA==
X-Gm-Message-State: ABy/qLZxZMuZnUW2+UiFc66bj7oe7T9EF1xRT7ZE/X0USW9KguB6pkEI
        jr0kunW5Swm2MPzsN106TDjBbrabZoz2oAKv61nKwPjT
X-Google-Smtp-Source: APBJJlGG8vchf6RK7inne5j7WpTsfNil/26fLn78sVrUNOKaIrCBWl5EqMrlU6b1GQz+ZKYQ6+TWtA==
X-Received: by 2002:a2e:9c10:0:b0:2b6:bda4:f890 with SMTP id s16-20020a2e9c10000000b002b6bda4f890mr3999268lji.10.1689351724978;
        Fri, 14 Jul 2023 09:22:04 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id w18-20020a1709064a1200b00992f1a3b9bfsm5582891eju.170.2023.07.14.09.22.04
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 09:22:04 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-51e48e1f6d1so2516900a12.1
        for <linux-integrity@vger.kernel.org>; Fri, 14 Jul 2023 09:22:04 -0700 (PDT)
X-Received: by 2002:aa7:d5c1:0:b0:51e:2a1b:6de with SMTP id
 d1-20020aa7d5c1000000b0051e2a1b06demr3609121eds.40.1689351724042; Fri, 14 Jul
 2023 09:22:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230714115803.111346-1-jarkko@kernel.org>
In-Reply-To: <20230714115803.111346-1-jarkko@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 14 Jul 2023 09:21:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj_qyDXCvjkb4GAh--OtaHQYCx8gSaX9HF-RfT=dNnvEA@mail.gmail.com>
Message-ID: <CAHk-=wj_qyDXCvjkb4GAh--OtaHQYCx8gSaX9HF-RfT=dNnvEA@mail.gmail.com>
Subject: Re: [GIT PULL] tpmdd changes for v6.5-rc2
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 14 Jul 2023 at 04:58, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/jarkkojs/linux-tpmdd.git/ tpmdd-v6.5-rc2

That does not exist.

The "jarkkojs" should be just "jarkko".

This is the *same* problem that we had in May. I'll wait for you to
fix whatever completely broken flow you have, I'm not dealing with
this AGAIN.

                   Linus
