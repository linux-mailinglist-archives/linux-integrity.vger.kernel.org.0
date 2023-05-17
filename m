Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B30706EC8
	for <lists+linux-integrity@lfdr.de>; Wed, 17 May 2023 18:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjEQQxk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 May 2023 12:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjEQQxG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 May 2023 12:53:06 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A5C59F6
        for <linux-integrity@vger.kernel.org>; Wed, 17 May 2023 09:52:40 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-50bc456cc39so1563069a12.1
        for <linux-integrity@vger.kernel.org>; Wed, 17 May 2023 09:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684342357; x=1686934357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WbLIWNwbWi1oPfkJYehay++7vldUE9mgEn/i2k6StuA=;
        b=LOT6zd+dCqQmaTvAuzv+iEr0Jw4BhTBe521buKQszAUMoN1iBVTP9sWxjD8uf8VN2d
         jl6HA6GVlY3gmKGnODyfN7mElerddiKMdf+q0GNJ659dsKmskJOC1wlUfdZY1nYkub4a
         zl8RwPvQ+lareVeMcG84Xi48Aa8OFZ9lN1HsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684342357; x=1686934357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WbLIWNwbWi1oPfkJYehay++7vldUE9mgEn/i2k6StuA=;
        b=VnG7FFeCoQx4ZDb/HKZlA5uN8C/grU7SrjcpXqBtnSxRiUD5OJfNhtzOz/5tUBzKCQ
         Jm8/1WyXptbGgCSS/Qrssr7Av2ME1aaIQtRq0FjkP7RWEiQA0+QxxVt8R9F+0+Zct5Qj
         /5vJBHZQHJ34NmaCYwnf9D/ElcbD1j3qoJeD1MGhCO8/B/prpORj95dXJB7YKI2KlM/O
         z1IxGhhSBWHttosfEJuaeRgqht+OVgClRDjxFSFp+K2n4pO8XKWizcF/oKyrCYthHTBc
         tb3a8/ae1pSq4viKxpLu6GJ0LedHH9W/Ma+tJXu6UsXfpCcAplrjxysShNBb5JW3TItT
         UmJA==
X-Gm-Message-State: AC+VfDysGlaBB56MKMH7d76wwrgy2Gb21n/jQ2KO8WlU5dhT+oShyGV+
        Am86iZpTIxUM8Z5e3EDYShZ3Eo/tYi15NHcQ2jfEqDd/
X-Google-Smtp-Source: ACHHUZ7xsWBR5HX6Ur2r9D0gXsD/yGZEbuw7Stxkg25sd+4G5rwheNuwlf8AHtuFfeW2JNXV70Ljew==
X-Received: by 2002:a17:906:478b:b0:96b:1608:3563 with SMTP id cw11-20020a170906478b00b0096b16083563mr11724591ejc.58.1684342356956;
        Wed, 17 May 2023 09:52:36 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id hg14-20020a1709072cce00b009662de1937dsm12496062ejc.131.2023.05.17.09.52.36
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 09:52:36 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-96a2b6de3cbso156765766b.1
        for <linux-integrity@vger.kernel.org>; Wed, 17 May 2023 09:52:36 -0700 (PDT)
X-Received: by 2002:a17:907:7d9e:b0:969:f54c:dee2 with SMTP id
 oz30-20020a1709077d9e00b00969f54cdee2mr28364544ejc.26.1684342355901; Wed, 17
 May 2023 09:52:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230516000208.4008443-1-jarkko@kernel.org>
In-Reply-To: <20230516000208.4008443-1-jarkko@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 17 May 2023 09:52:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiEYewsSM0SbdBbdX2DhUNcaZptvS8NPKZES41vr_H=bA@mail.gmail.com>
Message-ID: <CAHk-=wiEYewsSM0SbdBbdX2DhUNcaZptvS8NPKZES41vr_H=bA@mail.gmail.com>
Subject: Re: [GIT PULL] tpmdd: three bug fixes for v6.4-rc2
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, May 15, 2023 at 5:02=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/jarkkojs/linux-tpmdd.git/=
 tpmdd-v6.4-rc2

That didn't work at all.

That "jarkkojs" part of the path seems to be just wrong, and it should
be - like always before - just "jarkko".

I pulled it from the correct location, but I don't know how you messed
that up - maybe just a fat-fingered mistaken edit, or maybe something
else.

So you might try to see what went wrong...

              Linus
