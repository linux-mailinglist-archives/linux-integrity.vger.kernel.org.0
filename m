Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791C04C34DF
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Feb 2022 19:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbiBXSlW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 24 Feb 2022 13:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbiBXSlV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 24 Feb 2022 13:41:21 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487BA269AA8
        for <linux-integrity@vger.kernel.org>; Thu, 24 Feb 2022 10:40:51 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id p15so4145724oip.3
        for <linux-integrity@vger.kernel.org>; Thu, 24 Feb 2022 10:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=EnIhEH1vdTKcn29ZsdP2aHezLRDrXpWJMjSt/Cn/QaU=;
        b=g6m43yJ0oSmUKmiWVRK7ZFQEirp5prRicq0oMClfcw7rZwWy6/rs8aXt3Una/n52Dl
         NE3kfoy/v0394fd8EJ6YZNIkjDGLLrq2A3F81gku5FTEiM5TPggnKgnRIF4nXsRAVHy3
         T/dUnMcBPH7km1wgkXg+vHj65M1miEhdFLoUXMhHmPBbsMOFErHFgkl3spHK+UvwGP/c
         CszjuOacqoLX6hcDdmVDGf/mvUZ4D2eoZuM5SIKARgjY3IrbiHPhHEt3XxIqkwvCgF9N
         AfE0XL1aBcvumQX3BokSCUF4UTUb5+07M31BUYx6W7Pq4EEM7d6oSXDYahiT6jOLQn7h
         iJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=EnIhEH1vdTKcn29ZsdP2aHezLRDrXpWJMjSt/Cn/QaU=;
        b=WoMKPKXBEFN6ymB6lQ4nS9Bg5lhjAeVsUF7dD49aS1KtD+ERQ1m+QT79IDEyLdJQ1b
         tmOFH7qcAAAyDKpp5arg1MJhQ9o+L+fUfpNQz4ZIcSMrf9hOPNQ3zBfiXdamiENLZS2Q
         XBDnoCvwTnE2LjrSu1e2egDefoJl5WLAUJY9yuJzhPO346/xnlbWWwdNgpqDSxLmUA6U
         kWNd6Opp+e+2RAqW/c0M4L4dWkg7yRMtxS+XurNifbU+uJQjPUM9NykVwTh66t6NvUS3
         ZfSkDOTdT1UDWn+QM/UsCjXOsF3xmH1wK6BGbvVgGABY0l4Wi5lSxNFpIJlNWegWn0ix
         CAow==
X-Gm-Message-State: AOAM5332XGTiHviHGvnFoza8MworjsjJDp5ZBMbaGI3jO8xT5K5Cjl8Z
        X5MhxNKsa8dPSCEQ96jgdqdjYPMz8bTwcn4wtus=
X-Google-Smtp-Source: ABdhPJwpNtGC7rNbIba2D3pZrEdWokxb3wg5K2Mp8+xUdjbDmoCbwUmu5UtqMxEatwRpesN++Gi+xiDq1ybN8COyoyQ=
X-Received: by 2002:aca:582:0:b0:2c9:ec1c:46a5 with SMTP id
 124-20020aca0582000000b002c9ec1c46a5mr2004403oif.92.1645728050563; Thu, 24
 Feb 2022 10:40:50 -0800 (PST)
MIME-Version: 1.0
Sender: ericgloriapaul@gmail.com
Received: by 2002:a9d:3d3:0:0:0:0:0 with HTTP; Thu, 24 Feb 2022 10:40:50 -0800 (PST)
From:   DINA MCKENNA <dinamckennahowley@gmail.com>
Date:   Thu, 24 Feb 2022 18:40:50 +0000
X-Google-Sender-Auth: r6PDwyjmzkNrIKQENuRIu2aOH50
Message-ID: <CAApFGfRkxFMCHz9idM9cR7-c7rjtTNznOQbwmJSyzP6nBNjHQg@mail.gmail.com>
Subject: May the peace of the Lord be with you,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.8 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_60,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:231 listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.7397]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ericgloriapaul[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  3.5 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello my dear,

 I sent this mail praying it will get to you in a good condition of
health, since I myself are in a very critical health condition in
which I sleep every night without knowing if I may be alive to see the
next day. I bring peace and love to you. It is by the grace of God, I
had no choice than to do what is lawful and right in the sight of God
for eternal life and in the sight of man, for witness of God=E2=80=99s merc=
y
and glory upon my life. I am Mrs. Donna Mcinnes Louise., a widow. I am
suffering from a long time brain tumor, It has defiled all forms of
medical treatment, and right now I have about a few months to leave,
according to medical experts. The situation has gotten complicated
recently with my inability to hear proper, am communicating with you
with the help of the chief nurse herein the hospital, from all
indication my conditions is really deteriorating and it is quite
obvious that, according to my doctors they have advised me that I may
not live too long, Because this illness has gotten to a very bad
stage. I plead that you will not expose or betray this trust and
confidence that I am about to repose on you for the mutual benefit of
the orphans and the less privilege. I have some funds I inherited from
my late husband, the sum of ($ 11,000,000.00, Eleven Million Dollars).
Having known my condition, I decided to donate this fund to you
believing that you will utilize it the way i am going to instruct
herein. I need you to assist me and reclaim this money and use it for
Charity works therein your country for orphanages and gives justice
and help to the poor, needy and widows says The Lord." Jeremiah
22:15-16.=E2=80=9C and also build schools for less privilege that will be
named after my late husband if possible and to promote the word of God
and the effort that the house of God is maintained. I do not want a
situation where this money will be used in an ungodly manner. That's
why I'm taking this decision. I'm not afraid of death, so I know where
I'm going. I accept this decision because I do not have any child who
will inherit this money after I die. Please I want your sincerely and
urgent answer to know if you will be able to execute this project for
the glory of God, and I will give you more information on how the fund
will be transferred to your bank account. May the grace, peace, love
and the truth in the Word of God be with you and all those that you
love and care for.

I'm waiting for your immediate reply.

May God Bless you,
Mrs. Dina Mckenna Howley.
