Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E98166097A
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Jan 2023 23:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235960AbjAFW2V (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 6 Jan 2023 17:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjAFW2U (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 6 Jan 2023 17:28:20 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD9F85C90
        for <linux-integrity@vger.kernel.org>; Fri,  6 Jan 2023 14:28:19 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id j16so3374644qtv.4
        for <linux-integrity@vger.kernel.org>; Fri, 06 Jan 2023 14:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QXQOUJjcoX1hrsbbTN+Z+gwuy5Yx5WlxprMyzhgXuL0=;
        b=FSwATMmksAKMdpu1wQNSAU4HfcxbtJpqP5jg4jxAia7ZjIAJt4LpHBViEiX5ZkvhWV
         XA077dHR8grrfxkhZnG7h3W83Y6u9reeX0IgVJqi16hhxZZAnt1gx0ImUTDz0+wZcva6
         cB9bwoRmvnDNak/FU5AzQ18NzyvaFmMkZwKoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QXQOUJjcoX1hrsbbTN+Z+gwuy5Yx5WlxprMyzhgXuL0=;
        b=KwRI1W4sDypfz7fOWc6mfbDwMDysDaG4SwKFDbzixiyDPJI48HkdktN7bcMplEKYsv
         88hY9gybrP3A50i6L9G9zDSyYO+7EV3MeWxx7KyWO1feZRxy3A2GXH/fgigve99br/+G
         uI1wBpOu2/Ai72tyP6K95bw6zmR63TSRNZBoVc7peCY/xT5D7rfcglctEDSGt+NbSsrj
         NvKgcw49wbK04Vv6ITGXsWWaGzsP3pjrTo5PA2VuinUOeOxIfVioW2zfM2AGLf7vhv0N
         5aVHOsadP9ci5P4kmhTXpakYqpWQ7AC9NSNHEtxWln4KLdGzrXR2RZywQe8IKonaJ4R3
         gI7g==
X-Gm-Message-State: AFqh2krqhrJCUoiUESzNNSFKaA52qOC3PzH3AEpxcElVP4dBFQ8mM0Tl
        Q7zapmJ37bmYYYxAC6tNdR/7SK59unnxnDq4
X-Google-Smtp-Source: AMrXdXsN9DjbVAOtCO+TKFHech4ym172vY9p/3PbwgS3PSXAAxl9GzALuf+D7WcjBJ46RmjD9T4R0w==
X-Received: by 2002:ac8:4a93:0:b0:3a7:ec9b:e00b with SMTP id l19-20020ac84a93000000b003a7ec9be00bmr76901333qtq.68.1673044098658;
        Fri, 06 Jan 2023 14:28:18 -0800 (PST)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com. [209.85.219.49])
        by smtp.gmail.com with ESMTPSA id cm8-20020a05622a250800b003a50ef44a77sm1099300qtb.28.2023.01.06.14.28.16
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 14:28:17 -0800 (PST)
Received: by mail-qv1-f49.google.com with SMTP id h10so1930615qvq.7
        for <linux-integrity@vger.kernel.org>; Fri, 06 Jan 2023 14:28:16 -0800 (PST)
X-Received: by 2002:a0c:df09:0:b0:4f0:656b:c275 with SMTP id
 g9-20020a0cdf09000000b004f0656bc275mr3791255qvl.129.1673044096460; Fri, 06
 Jan 2023 14:28:16 -0800 (PST)
MIME-Version: 1.0
References: <Y7dPV5BK6jk1KvX+@zx2c4.com> <20230106030156.3258307-1-Jason@zx2c4.com>
 <CAHk-=wjin0Rn6j+EvYV9pzrbA0G2xnHKdp_EAB6XnansQ8kpUA@mail.gmail.com> <CAA25o9Sbkg=qD+DH-aqXY9H5R_oBtePcnqagwAGCgoUk8D-Vyg@mail.gmail.com>
In-Reply-To: <CAA25o9Sbkg=qD+DH-aqXY9H5R_oBtePcnqagwAGCgoUk8D-Vyg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 6 Jan 2023 14:28:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi60PhJRzaBJ9uvVCpOpqSsKy=oXkGDq7t844BJ6dRcmA@mail.gmail.com>
Message-ID: <CAHk-=wi60PhJRzaBJ9uvVCpOpqSsKy=oXkGDq7t844BJ6dRcmA@mail.gmail.com>
Subject: Re: [PATCH v2] tpm: Allow system suspend to continue when TPM suspend fails
To:     Luigi Semenzato <semenzato@chromium.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Dabros <jsd@semihalf.com>,
        regressions@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Johannes Altmanninger <aclopte@gmail.com>,
        stable@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        tbroch@chromium.org, dbasehore@chromium.org,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jan 6, 2023 at 12:04 PM Luigi Semenzato <semenzato@chromium.org> wrote:
>
> I think it's fine to go ahead with your change, for multiple reasons.

Ok, I've applied the patch (although I did end up editing it to use
dev_err() before doing that just to make myself happier about the
printout).

            Linus
