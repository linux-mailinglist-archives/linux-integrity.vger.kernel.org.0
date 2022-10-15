Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57BD85FFC9A
	for <lists+linux-integrity@lfdr.de>; Sun, 16 Oct 2022 01:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiJOX03 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 15 Oct 2022 19:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiJOX02 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 15 Oct 2022 19:26:28 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DE336DF5
        for <linux-integrity@vger.kernel.org>; Sat, 15 Oct 2022 16:26:27 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id y14so17609081ejd.9
        for <linux-integrity@vger.kernel.org>; Sat, 15 Oct 2022 16:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6aF9nFwwA4H8y+DQySeTN9I4LSFxeOQ6cH2LPftSBU4=;
        b=M9DRZmPxDZDogdoJx5F1RgildYxL9mQTgUzTKQV3nRBGsnUtOhpqKudG3yK982bLIX
         7w0xgkOaf0MEIkEMxu4LS16oAuee1MMyurBYuNnYaGQx9+Bg+VI5Mi/WM/KKJcVv9O0Z
         ntB4/nBR7cjw+TVH+jyFRphu9TSa3nVivjNMGWHyoyV6HUmp7JclMrmxrNzOE1YsxrNT
         FhQnKa6qXjfvcoEmqF1kmHPNbjnfgjIC43bnMsQOLScPB35CRpyNK7upnD/Z1QW2WU5p
         PgwvrstmRgJBMDYpUiTzkBan7qZZckRHboBJAzIiXCv4lVPxieuHMksVZZnWICO/9YpR
         o0qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6aF9nFwwA4H8y+DQySeTN9I4LSFxeOQ6cH2LPftSBU4=;
        b=oHauqycwfSIaId/sEiGuwB+yLNKdFDEa5vcvzk0Zfg6+JEovzBNUX7zKjhzKadh9xW
         KQTCdYD4aNwE3tKNj+wofCERo4Z4OJ5j3c3gCsGYR+B4j1X3O5wz57l2+bGsB2Iy+op8
         /EqFy1DnHiE9uBKqhIhWQP3QkEkYVxAA9m71g3O61bW9xDXrn+jR3stXJRtK5C7u21O/
         zEI6gEiKgVd3g6UY+o8taCbM5NMB/Ds7qKkNwdzL4koqqwHdz33E8b7oLghaL5+ermea
         4NiBVCCrNnW8h00Oqhao6NpRLRz/tW8LYQBD3JJyemNTVmOGR5Zoy478eajtvItjNd50
         KeOA==
X-Gm-Message-State: ACrzQf3HTzMAxpmpxPjbUNJ9H5ggsoFNKQiDWJdgutMsQCWJjfU0QgJg
        j1MpPe4aPzsgDaelAIOtSOMskviFdqk15TzhPcc=
X-Google-Smtp-Source: AMsMyM7NZ4O2EZCJca+uO0D7JNrDzVRiZsdphiLLCPlCs2QUFAnVcyKNvqxxWlnQPMRwXCiSPMFUhnv1QFDApIr5xNU=
X-Received: by 2002:a17:907:7f91:b0:78e:2e30:9513 with SMTP id
 qk17-20020a1709077f9100b0078e2e309513mr3498929ejc.759.1665876385692; Sat, 15
 Oct 2022 16:26:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:4c8:0:b0:1df:3d2:9387 with HTTP; Sat, 15 Oct 2022
 16:26:24 -0700 (PDT)
Reply-To: richardwahl9035@gmail.com
From:   Richard Wahl <moserabiage@gmail.com>
Date:   Sun, 16 Oct 2022 02:26:24 +0300
Message-ID: <CACVAh=7AZNUmJtFCf+AzLJkeK2oJFmdd+5BNjSzpiFco+3PgmA@mail.gmail.com>
Subject: Re,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.2 required=5.0 tests=BAYES_80,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,REPTO_419_FRAUD_GM_LOOSE,
        SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: *  2.0 BAYES_80 BODY: Bayes spam probability is 80 to 95%
        *      [score: 0.8090]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [richardwahl9035[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [moserabiage[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:636 listed in]
        [list.dnswl.org]
        *  1.0 REPTO_419_FRAUD_GM_LOOSE Ends-in-digits Reply-To is similar to
        *      known advance fee fraud collector mailbox
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

--=20
Sch=C3=B6nen Tag,

Ich bin Herr Richard Wahl, Sie haben eine Spende von 700.000,00 =E2=82=AC. =
Ich
habe ein gewonnen
Gl=C3=BCck in der Power-Ball-Lotterie und ich spende einen Teil davon an Te=
n
Lucky People und Ten Charity Organisation. Ihre E-Mail kam heraus
siegreich, also antworte mir dringend f=C3=BCr weitere Informationen unter:
richardwahl9035@gmail.com
Aufrichtig,
Herr Richard Wah7
