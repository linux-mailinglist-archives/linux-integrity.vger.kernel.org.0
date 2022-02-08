Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8904AD3DB
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Feb 2022 09:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351493AbiBHIo1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 8 Feb 2022 03:44:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351928AbiBHIoC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Feb 2022 03:44:02 -0500
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F033C03FEFA
        for <linux-integrity@vger.kernel.org>; Tue,  8 Feb 2022 00:44:01 -0800 (PST)
Received: by mail-ua1-x944.google.com with SMTP id u77so10896622uau.6
        for <linux-integrity@vger.kernel.org>; Tue, 08 Feb 2022 00:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=edeevZ54MxyNr2ONaDsC9jI+UtdZjrCL/LCuSFC70Ao=;
        b=qzcA3K52de9EhxIhzDkkmYbbQbKaihztEhpxunYq2GbraMA2FahupsNjdrEQdl+2Xo
         x8jS+FGEUTCMk4tDTYOrkEiAnHXAkXcvH7RvY2aCKbp+IjLQ3Bp7h8T/UGTTv6cbvQJx
         UDaJ+EExkU2Hp+cSSYRA9eBK9kaPiYVEdlhpEIKA2WBzvL9GDh4CBhV+D7H2jS5hbt2m
         8LtLW4gnxvDWL+oX1Mu+PuIaS25Xny7KZOl+qnwzrY5EU6w8EDQE49bsI3Zvp3xnEqz9
         DCUxVi2bJ97Z5XO1ifHRoy2QV3wbBOmeBX5qA9XMxLaJLZCuYBlb/QVcJLQKQ1TiYL1W
         HBgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=edeevZ54MxyNr2ONaDsC9jI+UtdZjrCL/LCuSFC70Ao=;
        b=ZGCXS/OJwFiNP75DrXBd3d4sXIprqlaQ9C83eDaG8Jkz9ZIET51HtZPYe6iFjRXsts
         reUhsCpcJ4xPsH43HX4xyFUvSpQqWs4X2DT876/+50wK6GHed6DI4wAlTjL0zOEt70V0
         4RS+M1jJREbyZB70sOJ2gEAkcqwQZof76Frt59I53rsHckPuYziRVaRP5Ce4fb6DYAP0
         ig6OPY2+D9HgnjWgb2uWlfqLJmiHTTUvUOO6yaDEFuMOElUEpCWhcpA6O6E+eNIhtAuS
         aEMk4oVCeCe89eT6/+UO9MzZL4iZl0z+lc6/K15DdVsqwDu/CxWOs8G5ok1w7E06ttQH
         ApnQ==
X-Gm-Message-State: AOAM533537a5h2vRvE1SBkf42N598ZmTa1vi6QnvWWBGrXPiLSL9gck0
        wQtglX0+bv5CQIRashpSVhWNr6a8v4AT4UiXMdM=
X-Google-Smtp-Source: ABdhPJwabOZCYr3WB5MAVlhPccZ8TF1Tp/Jgj7lvaHsfCshVug2Z/NGcswi/yGz08altCfIkGJhgE6VUV2eXkpdV8Qk=
X-Received: by 2002:ab0:72c2:: with SMTP id g2mr1148800uap.15.1644309840067;
 Tue, 08 Feb 2022 00:44:00 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ab0:2bc5:0:0:0:0:0 with HTTP; Tue, 8 Feb 2022 00:43:59 -0800 (PST)
Reply-To: saeedmohammedsaeed085@gmail.com
From:   Mohammed Saeed <nzubewwwww@gmail.com>
Date:   Tue, 8 Feb 2022 11:43:59 +0300
Message-ID: <CAMj4HvQnWsfFGFOGV12hnhn1-7ggyDY5TkaLTvG3KD73KTrShQ@mail.gmail.com>
Subject: Proposal
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:944 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.0 HK_RANDOM_ENVFROM Envelope sender username looks random
        *  0.6 HK_RANDOM_FROM From username looks random
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [nzubewwwww[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [saeedmohammedsaeed085[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.4 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Salam alaikum,

I am the investment officer of UAE based investment company who are
ready to fund projects outside UAE, in the form of debt finance. We
grant loan to both Corporate and private entities at a low interest
rate of 2% ROI per annum. The terms are very flexible and
interesting.Kindly revert back if you have projects that needs funding
for further discussion and negotiation.

Thanks

investment officer
