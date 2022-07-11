Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7481656D26D
	for <lists+linux-integrity@lfdr.de>; Mon, 11 Jul 2022 03:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiGKBNN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 10 Jul 2022 21:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGKBNM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 10 Jul 2022 21:13:12 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241D69581
        for <linux-integrity@vger.kernel.org>; Sun, 10 Jul 2022 18:13:12 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id s1so190115vsr.12
        for <linux-integrity@vger.kernel.org>; Sun, 10 Jul 2022 18:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BguWkT+elma+VHsG/vCWoAlVnf9WR3qWac7GB1dKKww=;
        b=qApy1EGPbyqCyUwOdpGnK698M92QUqtVhnE285ZMoA3aoqJfSz+cPRc3IihYF3kJtn
         p9SYkxd7/0Q9VrWD58TWzlgvfp9viTVSMsThwPdgrceb7MMhglEUTxsUYAeMknCf/LHY
         JFxHGuRFcF7jMyl1NPsKvDmGSFr64/6oHP2XcxAnwyCA32LuZ0gLlu/OWUnaQbObey/I
         iari5+j9Odg2vgvPQZqYfYVEozcxrGcm6s97wVkZ4AKJSiS28CBNBUYzg2kssywpGWb7
         IekmO02wHdu24RBNWTeY1kOohbDsd48DTjGIK+a0MMENPZ6YiNG1R9O+rpOi0wiFKGQU
         Jvzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BguWkT+elma+VHsG/vCWoAlVnf9WR3qWac7GB1dKKww=;
        b=sRq1XqHam58hek0UvroGabP5RxrqvDLfooLodwH39C4mQS6TCThN9WkuXWiH/m/FSf
         HW2QNrIznJdU4lh7mC55zxo2PFzFxoG7EiTKOwGFKMf24agW6kOxqhWQsi9ifcdT+p++
         BiLd1BF4/OPnh9WN9SKFb6unh5hWpHiwN1Sd4MPSL0oPJnQt8j37ayWnDgD3wKZb81Zo
         8lfxZBPx47B/m5j2ch/hU+a5sy/HGyjreYsO0ZAEZyxFTXZ5e2/DTBBeps0tj1lph4bw
         F8brUh2Bryx6GR3lNY6bHCGbW7cv/wrPQrYdCWSuDS/DY6SxXS8XOPzME4D7PL7TDtAe
         HMuA==
X-Gm-Message-State: AJIora++IZp2cQK/69q9M4yJK4HasaOfCSx4jV9xNKVJSGseMAbH0oHm
        R0zAOwYPM9q9+7X17e4B+Ai9iHPYTQeCwVCtl4Y=
X-Google-Smtp-Source: AGRyM1tNh+Z9F5LtSOPFi5ZNeIIE6SAXqojzykXpaesm6YsN1D5Vg358i9oWI2Ro4gzTWiWkkzMZ6kJa1nf6WLLlw5g=
X-Received: by 2002:a67:d495:0:b0:357:688d:f65c with SMTP id
 g21-20020a67d495000000b00357688df65cmr77526vsj.59.1657501991255; Sun, 10 Jul
 2022 18:13:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220702080934.1168975-1-chenhuacai@loongson.cn> <YstqGO4X8P6jY6Is@kernel.org>
In-Reply-To: <YstqGO4X8P6jY6Is@kernel.org>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Mon, 11 Jul 2022 09:13:04 +0800
Message-ID: <CAAhV-H6KnqR3d8oJkP6jT_J0+Vc3iA+9w9y4j6MaJ9zeur0fZA@mail.gmail.com>
Subject: Re: [PATCH] tpm: eventlog: Fix section mismatch for DEBUG_SECTION_MISMATCH
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        WANG Xuerui <git@xen0n.name>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi, Jakko,

On Mon, Jul 11, 2022 at 8:09 AM Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Sat, Jul 02, 2022 at 04:09:34PM +0800, Huacai Chen wrote:
> > If DEBUG_SECTION_MISMATCH enabled, __calc_tpm2_event_size() will not be
> > inlined, this cause section mismatch like this:
> >
> > WARNING: modpost: vmlinux.o(.text.unlikely+0xe30c): Section mismatch in reference from the variable L0 to the function .init.text:early_ioremap()
> > The function L0() references
> > the function __init early_memremap().
> > This is often because L0 lacks a __init
> > annotation or the annotation of early_ioremap is wrong.
> >
> > Fix it by using __always_inline instead of inline for the called-once
> > function __calc_tpm2_event_size().
> >
> > Reported-by: WANG Xuerui <git@xen0n.name>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  include/linux/tpm_eventlog.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/tpm_eventlog.h b/include/linux/tpm_eventlog.h
> > index 739ba9a03ec1..20c0ff54b7a0 100644
> > --- a/include/linux/tpm_eventlog.h
> > +++ b/include/linux/tpm_eventlog.h
> > @@ -157,7 +157,7 @@ struct tcg_algorithm_info {
> >   * Return: size of the event on success, 0 on failure
> >   */
> >
> > -static inline int __calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
> > +static __always_inline int __calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
> >                                        struct tcg_pcr_event *event_header,
> >                                        bool do_mapping)
> >  {
> > --
> > 2.27.0
> >
>
> Please add
>
> Fixes: 44038bc514a2 ("tpm: Abstract crypto agile event size calculations")
OK, thanks.

Huacai
>
> BR, Jarkko
