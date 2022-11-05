Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F4461DFBE
	for <lists+linux-integrity@lfdr.de>; Sun,  6 Nov 2022 00:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbiKEXwy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 5 Nov 2022 19:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiKEXwx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 5 Nov 2022 19:52:53 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D0A12775
        for <linux-integrity@vger.kernel.org>; Sat,  5 Nov 2022 16:52:53 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id g10so8795574oif.10
        for <linux-integrity@vger.kernel.org>; Sat, 05 Nov 2022 16:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6qmFrIxtV+gG3qwEwLA4szI4/WQIA2RDAqO9S7ITY0I=;
        b=MTWVD7kvo6EYk9nQh1OpH1fkXboS7DSgXuGzDm+KUpH6q7DtbIJTZhBjvGJnk5JF2Q
         /II1grUdxzdsYTe17rGddwtJ8TR22g72ZQWB/xb6jBK5wWKR/czRl0b64VG1IIos/4jt
         gB8nIxXhftm7m/Wt/khCcU/gd+f7QQGV5Qf+ZGqVy8PjrAhjJ29iTJRD1e1mKlRgixK9
         G5WQby3feKMT4HcAVVX0TiwH+5u1ItbmDpvyXq74SFB74/iQTAdi2PX+ySgDyg9vbACY
         pEOqW2qZU2v33gk9OQSFQKZGHS84vZCXzNGsvf+2hPKG/WsmJOw08JI0GHsQGg1XYts4
         K53w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6qmFrIxtV+gG3qwEwLA4szI4/WQIA2RDAqO9S7ITY0I=;
        b=v/68oQUvNcVGwhypn1T+gr5PfO5NnCtsvHsVtSGODwpUhHIw8Zgx+p28pBGJ5vEkuY
         ylnMfz4dVNXm8NAXT8RDx9lPQAbizxKE9cSg5mhCbnEpNEn4y8XqWgL/Gtt+HYyOt98i
         pEytPk3M98Oo3QUufQbhqYDi/1DscNeND4XIGQxsb7+hfbL5bVoEmz2kxjFkeOm2hdKv
         R1k/Zzt76TzhvDVYzS0YLtkgIVjEBaTOoKK+GKaxCmM1T+JXZ1EnGrS+NEICJ7oehtUr
         vlbkglWWqjl/kClj8RNXfCi/LGcLroEZ6Gm/uMB8PrB63qEdmubbwMk/RF1u7UZLuQK8
         pVqQ==
X-Gm-Message-State: ACrzQf1Jn2I2foSh3Bx1tFE64TnJKGVptU0WquiWrHP2sOHO17Juag7s
        wuTxBLOD0ATLFo4LIfz2qN3x3n+tshC7wiU1e0Q=
X-Google-Smtp-Source: AMsMyM4PbTdGMeYMg6e1FMuwOAvacSWTkFvobosGPH7URZd5DG0EjViL2dW6Vgytyj6vfnYIYVFyrFRyhY+ykUYahzQ=
X-Received: by 2002:a05:6808:2028:b0:35a:b62:7e87 with SMTP id
 q40-20020a056808202800b0035a0b627e87mr19062655oiw.264.1667692372431; Sat, 05
 Nov 2022 16:52:52 -0700 (PDT)
MIME-Version: 1.0
Sender: wilfriedroy884@gmail.com
Received: by 2002:a05:6850:f00c:b0:36b:d5b:c227 with HTTP; Sat, 5 Nov 2022
 16:52:52 -0700 (PDT)
From:   AZIAZ FATIMA <azizafatima878@gmail.com>
Date:   Sat, 5 Nov 2022 16:52:52 -0700
X-Google-Sender-Auth: uvzlUDZ21z67dkyEP6u3LX452zg
Message-ID: <CAK4F==UpcBoMp6wr4TaaBEUmF_epQt_EU9f2oSqR+M34eS8j-w@mail.gmail.com>
Subject: GREETINGS TO YOU
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.1 required=5.0 tests=BAYES_50,DEAR_FRIEND,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,NA_DOLLARS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:235 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5158]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [wilfriedroy884[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [wilfriedroy884[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  2.6 DEAR_FRIEND BODY: Dear Friend? That's not very dear!
        *  0.0 NA_DOLLARS BODY: Talks about a million North American dollars
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  3.2 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

 DEAR FRIEND

I am MRS.AZIAZ FATIMA a banker by profession i bring to you a business
proposal deal of (US$18.5million  US Dollars) to transfer into your
account, if you are interested get  back to me for more detail. at my
Email (azizafatima878@gmail.com)
Best Regard

MRS.AZIAZ FATIMA
