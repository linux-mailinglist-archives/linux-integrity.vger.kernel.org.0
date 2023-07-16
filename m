Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAEC7550DD
	for <lists+linux-integrity@lfdr.de>; Sun, 16 Jul 2023 21:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjGPTLp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 16 Jul 2023 15:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjGPTLp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 16 Jul 2023 15:11:45 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A3DE4B
        for <linux-integrity@vger.kernel.org>; Sun, 16 Jul 2023 12:11:44 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-991ef0b464cso1055857566b.0
        for <linux-integrity@vger.kernel.org>; Sun, 16 Jul 2023 12:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1689534702; x=1692126702;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0OyrnABpfGrBHIIzfnTugrqAUuXCez/5n+BWJ/56tEc=;
        b=A1YZA4EgsF+jlQLL/+OPICtgA4VitZn5GBPJUbO1XZZ4ttq1Yn2wNo1qz8T5ERoIZ9
         TTqOcviZd6lWgskRwzY1enpoOFQnL1jvdcYRimC00cO8+LmZlkp09gSWROI0qrjFKV7o
         BB43clWjMGhiMgrMdFuOuFn7/CKMcJ0djMSeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689534702; x=1692126702;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0OyrnABpfGrBHIIzfnTugrqAUuXCez/5n+BWJ/56tEc=;
        b=HjkTJeZLsPDb1e6hJ9MooyctxtfuSNG43wZT6B6ZZ3dhSp8mc9GgXBP7ZIFoN/3kAG
         qeqD/k8vE4snGN3u9LXGkE0DARlfPh4CjVKTmTVRRh8xwugRrkzrJIIUq06eOM4Gwa3P
         jH8TfT1q2d2doFl3OCHt73MOvPIon5Jjej9oqss2QEWFtRtfOP/ruReN3lMHciUB5mYR
         ZFSYtMIJZ7m3UnU+55WcDPYP3iadmmVm/+RbkgQ9zRJlLd7Bb1CC1X5bH1d3IQXMnMUQ
         FH9rVv5nZAdUYmry0bjc1zT4V7zrg/eKUsDngxXr/DUuZ366bcHILYnLkSMw64PguuVV
         98yg==
X-Gm-Message-State: ABy/qLbcBlyA0T5jF+3F7z8/N1ozkw2cuLEYQbQgWgWHaCAeb/cUDjh5
        fCJo6+yKRfP8PaVHrxx/cuTTPnkLe+zIMo/b+LvibA==
X-Google-Smtp-Source: APBJJlECCD4Z9OLj2nR3+az1Fl7TzwNLeRHteeAFrA02mCfNgeOxxMCJ9D9OcUtD97t7PenCUfEMJA==
X-Received: by 2002:a17:906:9b96:b0:978:8979:c66c with SMTP id dd22-20020a1709069b9600b009788979c66cmr9332481ejc.18.1689534702658;
        Sun, 16 Jul 2023 12:11:42 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id um10-20020a170906cf8a00b0098e78ff1a87sm8191525ejb.120.2023.07.16.12.11.40
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jul 2023 12:11:41 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so10441616a12.0
        for <linux-integrity@vger.kernel.org>; Sun, 16 Jul 2023 12:11:40 -0700 (PDT)
X-Received: by 2002:a17:906:5d16:b0:992:13c7:560 with SMTP id
 g22-20020a1709065d1600b0099213c70560mr9668575ejt.38.1689534700551; Sun, 16
 Jul 2023 12:11:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230714181325.3351-1-jarkko@kernel.org>
In-Reply-To: <20230714181325.3351-1-jarkko@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 16 Jul 2023 12:11:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg6Gv+zbBt7RLN43KD0BaegS=SYkwaHjd_YM5BDsvS08w@mail.gmail.com>
Message-ID: <CAHk-=wg6Gv+zbBt7RLN43KD0BaegS=SYkwaHjd_YM5BDsvS08w@mail.gmail.com>
Subject: Re: [GIT PULL] tpmdd changes for v6.5-rc2
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 14 Jul 2023 at 11:14, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/jarkko/linux-tpmdd.git/ tpmdd-v6.5-rc2-fixed

No, that still isn't a valid git repo path.

This all also looks like it should have come in during the merge
window, so I'm just going to ignore it.

Feel free to send in actual fixes - not this massive update - once you
have fixed your workflow.

But don't even bother emailing me until you have actually *verified*
what the heck you are sending me.

No more broken script garbage. No more untested git pull requests that
don't actually work.

                Linus
