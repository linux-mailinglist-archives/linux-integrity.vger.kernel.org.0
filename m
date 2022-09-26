Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0F25E9B6E
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Sep 2022 10:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbiIZIAv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 26 Sep 2022 04:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234311AbiIZH7s (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Sep 2022 03:59:48 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3DC1E3DB
        for <linux-integrity@vger.kernel.org>; Mon, 26 Sep 2022 00:57:36 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id v4so5829492pgi.10
        for <linux-integrity@vger.kernel.org>; Mon, 26 Sep 2022 00:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=p4tQ0Veg2aAipvjxXfd/dOpQbJgpeWN6SuNpOla53Hk=;
        b=WiwqDYN3Ur2fO943ookpYkguhas9KY4wHopBmxa3ytfFMqfU7WjIRhDldMRfc9V4ZM
         X8RNw5Nw3+30DEGNtv2uDZU05lJH/OghhZPQ5f3JbXR2OgbhG7oAyck9Fpu6s/DEm3fd
         nS2WZ9WXk/lDEa6OaYXhhvnlxo/px7+z5jbwJoO416YLzkUicesp30SbWQxR/pE7dDHM
         CO+DdHg3kgCcNvdi/KQd17Gj2BCSTexq86p3Qe5BPaTdKqeOKG4VFrtm4Aq+dFenBfQX
         U5z95aRnkyUslN/brR/HUh6UMEOROlZOa+J9yVbD2r5c2X9fj/2wTayIO/UfxKyG/N71
         bHPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=p4tQ0Veg2aAipvjxXfd/dOpQbJgpeWN6SuNpOla53Hk=;
        b=FuLKH1nPvGNwCtou4VJBSs4xTNY5QJac0udkm0PFhyBnsYZKLxdu6tKwjgvrcx+sY5
         AYeXCojWfdjb4SmPPb1ddkMOM1zB9RkYuuxX1BF8XYpRh4k96YVJ68573eJH6Yo/3nPp
         9kzSvHBi7kHprkVS4Mx6E+60eo/4hw6kHqOO/geGfYd/RJPNM6pNaoVLI++9rNSj/Jvu
         jcuTfKv+AWZoYigyjuwka49PCEaYS2sxPpOnVGlPHM3xGJ0KIWLVbO/9hiiXhqUsW4zR
         3rir7+ehCT4ydVlSYIXHLxCoqWbuGPi2MzLEjk3dHbbO8uiYyI8n/VVPukt6QfKNpn/g
         ASKg==
X-Gm-Message-State: ACrzQf18NhnpNx1dgyPhqDHKNAkzMFUX5RgDF2Qt0QpxyurZvQr2w/r/
        NyAXZbzAN+O24wrRWDjLPQ+ZpKOLvIqjayOcsnM=
X-Google-Smtp-Source: AMsMyM6jxUyPK1BxNKQi/p/f9XWjIweva48ugzk3U5kBuC/CVoGqbMi7XVfIZGVZb9/NV7Fd6mcC9XBhib7IPr0mOKM=
X-Received: by 2002:a62:8345:0:b0:53e:a1bf:8df9 with SMTP id
 h66-20020a628345000000b0053ea1bf8df9mr22414961pfe.68.1664179055692; Mon, 26
 Sep 2022 00:57:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac4:9ba2:0:b0:578:474:608e with HTTP; Mon, 26 Sep 2022
 00:57:35 -0700 (PDT)
Reply-To: izzatibrahim724@gmail.com
From:   "Ibrahim I . Hassan" <doungotraore1234@gmail.com>
Date:   Mon, 26 Sep 2022 07:57:35 +0000
Message-ID: <CAJFraYwCRR8omz_C3k6hA9V8=YiNDJ6AayC165Y19Y4rRY8U5A@mail.gmail.com>
Subject: Thanks
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:535 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5202]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [izzatibrahim724[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [doungotraore1234[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [doungotraore1234[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.2 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

ATTENTION:

Have you any viable business plan that needs funding? I am acting on
behalf of a family who are cautious due to political and personal
reasons. Be assured that more details will be revealed on showing
interest.

For the safety of their funds the family will be willing to invest or
fund in both short and long term projects. Should you be interested to
engage us for a more detailed discussion on the aforementioned
proposal, we would be glad to do so in whatever medium appropriate for
this engagement.

The funds will be released through bank to bank transfer upon proof of
feasibility study conformable to be viable and demonstration of
managerial skill to prove that the principal amount being invested
will be secured,

Due to the above mentioned reasons (political and personal) we implore
for confidentiality as we look forward to your response. Please
contact me with the below alternative email Address (
izzatibrahim724@gmail.com )
We look forward towards receiving your proposal/feasibility study.

Regards :
Ibrahim I . Hassan
