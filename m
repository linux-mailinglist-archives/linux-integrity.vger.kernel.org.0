Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7609D51E0D4
	for <lists+linux-integrity@lfdr.de>; Fri,  6 May 2022 23:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444367AbiEFVOH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 6 May 2022 17:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444353AbiEFVOF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 6 May 2022 17:14:05 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9A6E52
        for <linux-integrity@vger.kernel.org>; Fri,  6 May 2022 14:10:21 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id cx11-20020a17090afd8b00b001d9fe5965b3so11855324pjb.3
        for <linux-integrity@vger.kernel.org>; Fri, 06 May 2022 14:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=VSSUIwdzgxQxnEkB7+u7pnweyPajIQMP3nQqWYs8VX0=;
        b=F1fk333Hmqn5fFa7Bmgf6HpiqZCxqDuhvDOWsX+anEvWQie+Jpk4ekhpFl/YfVZsu6
         jkaytNOhHXbph3/u0Yr6VD8F7fpeZ/mgWi+wdHYwi5Tiq19A/8dpQIqTOMM4lmA9ptrL
         NLe2IT0BoG58k15DJwpz5FggSoqsh3FajbymDqFQA+uQQ9UZoNr47CqHk6c+PVV08MRd
         7kERRkxxALatavGRthjWyvSSpGQseyMnNDLR7JC9909oLNH+VJO9P0GcqihDSLi6/Knr
         SoWLzLwlkldT3BntyUoJ7LKd/WPYlo9GEmdctLaP3dDW++b+PidhUjIkO14BPt9WBq8r
         h0DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to;
        bh=VSSUIwdzgxQxnEkB7+u7pnweyPajIQMP3nQqWYs8VX0=;
        b=5UwvloP83cfjNP7z3jvo6DvEt/DLy38BR+pfSpS3l0qDXN/oc6vm1ON7pF4Fd9f399
         2oNTiuqvgko2w7nxD60kOLWKZzTd2KQmRS8IPIJH5VLD8ffmq8QXbIW+jVv8bI0SdJX3
         7SeDfbUOMC4HDVIJhiKwJ/ImUtwQgKSyaQNFqmmXfTCQhe3tX8MyLV0fbYnrPzYgHDZk
         6GJ+ScJnAtfvAYj9x9PDrXNbkVqRdUghsBDTxL/FCZGlcEqU0dziBSO8O2x8krogXCP2
         CiQp5XU0WbRPabKc7/M0+hQAWsuTFhkjqwllYpmO8slUesFv7I0S+UPAQrmMT4853bR2
         fmyw==
X-Gm-Message-State: AOAM531kqjS+hkeAB2Gg7E+kLV/532WMoD4zU01ANYzqNR+bZhY/0Eew
        aAl8wlKuIqxY9/3o1JCQPJty61c9MM0BshSbwg==
X-Google-Smtp-Source: ABdhPJwUU4aCtXntx4gYnieeAjytSmPiX78iqslQAwpnY0uMUCaOp65KJ+p1X/yoPT/+7FwmvFCLwxr05TXP4VQOmi0=
X-Received: by 2002:a17:903:32c6:b0:15e:c1cc:2400 with SMTP id
 i6-20020a17090332c600b0015ec1cc2400mr5597009plr.153.1651871420790; Fri, 06
 May 2022 14:10:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac4:9906:0:b0:4ba:807b:b8f3 with HTTP; Fri, 6 May 2022
 14:10:19 -0700 (PDT)
Reply-To: warren001buffett@gmail.com
In-Reply-To: <CAD_xG_pvNZK6BFCW+28Xv4DE=_5rbDZXDok2BYNn9xw6Ma7iow@mail.gmail.com>
References: <CAD_xG_pvNZK6BFCW+28Xv4DE=_5rbDZXDok2BYNn9xw6Ma7iow@mail.gmail.com>
From:   Warren Buffett <guidayema@gmail.com>
Date:   Fri, 6 May 2022 21:10:19 +0000
Message-ID: <CAD_xG_pMJL10xE1e5CyUHZ7pNq95D=ASZyrbfhd99PpOr3CJQg@mail.gmail.com>
Subject: Fwd: My name is Warren Buffett, an American businessman.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1042 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4789]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [guidayema[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

My name is Warren Buffett, an American businessman and investor I have
something important to discuss with you.

Mr. Warren Buffett
warren001buffett@gmail.com
Chief Executive Officer: Berkshire Hathaway
aphy/Warren-Edward-Buffett
