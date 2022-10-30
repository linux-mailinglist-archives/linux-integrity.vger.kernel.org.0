Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D32612963
	for <lists+linux-integrity@lfdr.de>; Sun, 30 Oct 2022 10:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiJ3JXn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 30 Oct 2022 05:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiJ3JXm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 30 Oct 2022 05:23:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5692C0
        for <linux-integrity@vger.kernel.org>; Sun, 30 Oct 2022 02:23:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 651B960EA5
        for <linux-integrity@vger.kernel.org>; Sun, 30 Oct 2022 09:23:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C607EC43470
        for <linux-integrity@vger.kernel.org>; Sun, 30 Oct 2022 09:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667121820;
        bh=1Y/pRkRj97nwwT6P2rfreFMwXIci3zr8ed8YKLBT+lI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aG2ppb5TkL7TpYVwWGr5aGuEUpHPpogiN/OllePbAEvrhJOWWaHKt4/o+plo7HLxW
         DHrj3wePLdSf2gkoB875msu29630Ix0AF6zK6wEn/QjaSclu9WU9Lf9EO/A4C8r4M8
         vDBI/ee7LWx58DoFSio5/KdIFja0Od55r6Zf7jnHg2bB+bbODPxloQrufgyR+8tOMw
         k4/i5In8BUSiXwYJsYyJBHQDxFXpFQZv7hNE4sGDKoBnfml6YLXuhX306DCDFBnq4p
         7/gGSzU3sbjvoRvMFwjX5RMjYR/5hw9ZdOtC3xNsUQBvB50EPhhPgCt9GYaqjxKvOH
         8LgZbqGbueGVQ==
Received: by mail-lj1-f172.google.com with SMTP id h12so6703176ljg.9
        for <linux-integrity@vger.kernel.org>; Sun, 30 Oct 2022 02:23:40 -0700 (PDT)
X-Gm-Message-State: ACrzQf0wa8zXOyMkYy/5c2KHtbUd7yXu0ZCwm10ETeH5L1dZBmZTGvFy
        2K7eGAT47VpaAYoxJbn9U8jX7tDOHks4q2hhU6E=
X-Google-Smtp-Source: AMsMyM52TpY7g7mJzedTZ5xmYU5wkKuaLVIguSw9GMuwegqFCcv8hHyUqfdbR4qG7+XWQ7yyv5UklHXD3pcg0G0K6b0=
X-Received: by 2002:a2e:9589:0:b0:277:54ee:e8e1 with SMTP id
 w9-20020a2e9589000000b0027754eee8e1mr191820ljh.352.1667121818814; Sun, 30 Oct
 2022 02:23:38 -0700 (PDT)
MIME-Version: 1.0
References: <20221021123309.2770740-1-ardb@kernel.org> <Y1WxtIjnJvX0jAk1@kernel.org>
 <202210281407.29FF39D8@keescook>
In-Reply-To: <202210281407.29FF39D8@keescook>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 30 Oct 2022 10:23:27 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGe_WZU6y0h=S2g2N=EPCk=qaQm4Eemi8595uqUQ+mLyA@mail.gmail.com>
Message-ID: <CAMj1kXGe_WZU6y0h=S2g2N=EPCk=qaQm4Eemi8595uqUQ+mLyA@mail.gmail.com>
Subject: Re: [PATCH] tpm: Avoid function type cast of put_device()
To:     Kees Cook <keescook@chromium.org>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>, peterhuewe@gmx.de,
        linux-integrity@vger.kernel.org, jgg@ziepe.ca,
        samitolvanen@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 28 Oct 2022 at 23:08, Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Oct 24, 2022 at 12:27:16AM +0300, Jarkko Sakkinen wrote:
> > [...]
> > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
>
> Who's tree can this land in?
>

I'd expect the TPM maintainers to take this through the TPM tree.
