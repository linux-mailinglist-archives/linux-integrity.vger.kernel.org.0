Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63A0683105
	for <lists+linux-integrity@lfdr.de>; Tue, 31 Jan 2023 16:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbjAaPNk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 31 Jan 2023 10:13:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbjAaPNY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 31 Jan 2023 10:13:24 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BE759273
        for <linux-integrity@vger.kernel.org>; Tue, 31 Jan 2023 07:11:22 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id v13so14662553eda.11
        for <linux-integrity@vger.kernel.org>; Tue, 31 Jan 2023 07:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XP53Z8DqFPdzcQhD/cnUiDrRVDZLpCF2Yb8rq991hL8=;
        b=LCo288fkbRBrw6OWKnlOWfHe8hB6eo7gWN49/7Ly4x8P18ZyAqyi7QY8N1EUx7sVJr
         gqIfbbtyRd1QLQD2JPzuJEm6jexF+I9dcUQ0QWImEcVmPde8IJw6sQSs9snFq2IiOfLt
         sc5tV3lv5p8UKub/ZY/EwKDb7UzCZfKFcRnQbc5d3gKxB5EZDAyh0AIa1cbws1jT/sMG
         gaQvzHmIb5XRJytL92V59IImij762t5HyKL/EIcsmnT3T5FPqVVmP4QuVcWDRzS0GK4m
         q2C8An5U7uwqxnM3h/QoBESI6LSyKaE5O19LiZfJr11KxR1z5dPS2MGOBu+OYMOaKv2x
         hD+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XP53Z8DqFPdzcQhD/cnUiDrRVDZLpCF2Yb8rq991hL8=;
        b=QP2HvkRQYNHzO/Ku6IS8Q+Q8SpH/K53mdvMkjLCmGsgF8wizBHixRqw/K0dn/JsksN
         h2WnR+u9voJuiHKzvMQ3cbIx5jqVMzA/8UQ1JghfduLpHuPRy4RzTv6b68ZB5tlRkIkl
         O1NKyPacXZFc0ea4Aw8al6YBVrm39Uf7nbe/0ub+kipGn42t3jUdrKZ7jrm6Z0g/Z9n1
         0nqBTqIBZirOs6f7UIWdiCfbbTOB8o6xT3BH/wOk3pHV07UKTn3n259hrfYHcd2lB05S
         +LtzS4pdpThc0ulie64pR1p8vQMPQ+CI9UIlfVa5jNyUzaXeZOT4f+qhr9m2MJh5rcUy
         b45g==
X-Gm-Message-State: AO0yUKVU2f7wl5YIB14TBUK18YdKf8Xc+PlXMPMMsUbcdPWNELEbpvo8
        Dtycyx2yTl0F3J8DyG07wvhfFwXSaWo/1CYjMdY=
X-Google-Smtp-Source: AK7set9jEHAabwIgCFcEEARF2ChjQzZc5Zzj/Gs4wQLhCAHFK208+/lXyLZstPzH6ZENL7nCkDpM7FOdoU4wADE9Tvc=
X-Received: by 2002:a05:6402:254e:b0:4a2:4abf:b5ed with SMTP id
 l14-20020a056402254e00b004a24abfb5edmr2476910edb.52.1675177866042; Tue, 31
 Jan 2023 07:11:06 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:906:4b43:b0:885:64e9:aebf with HTTP; Tue, 31 Jan 2023
 07:11:05 -0800 (PST)
Reply-To: infor.atmbankofafrican@gmail.com
From:   Kristalina Georgieva <mr.johnsonwray@gmail.com>
Date:   Tue, 31 Jan 2023 15:11:05 +0000
Message-ID: <CAFbsNHPHM=efX-jF68Oy8VZnpuZMqfNq-_NYhVua6pGNq+UmhA@mail.gmail.com>
Subject: =?UTF-8?Q?R=C3=A9clamez_votre_carte_ATM_de_1=2C5_million?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:529 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mr.johnsonwray[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  2.8 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  0.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  3.3 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Cher propri=C3=A9taire/destinataire de l'e-mail,

Nous vous avons envoy=C3=A9 cette lettre pr=C3=A9c=C3=A9demment sans avoir =
de vos
nouvelles, je ne suis pas s=C3=BBr que vous l'ayez re=C3=A7ue, et c'est pou=
rquoi
je le r=C3=A9p=C3=A8te. Premi=C3=A8rement,

Je m'appelle Mme Kristalina Georgieva, pr=C3=A9sidente du FMI. Vous avez
abandonn=C3=A9 votre million cinq cent mille dollars des =C3=89tats-Unis av=
ec
United Bank of African. Quelle est la raison, qui essaie de vous
tromper? Parce que c'est la seule banque autoris=C3=A9e avec M. Emeka Chris
comme agent agr=C3=A9=C3=A9. Si vous refusez de contacter M. Emeka Chris, l=
e FMI
ne vous permettra pas de recevoir de paiement et vous continuerez =C3=A0
travailler avec de mauvaises personnes tous les jours de votre vie
sans bonnes nouvelles. Votre argent reste toujours chez UBA au Togo et
vous devez contacter M. Emeka Chris si vous vous souciez de la
signature et de l'approbation du FMI.

Agent agr=C3=A9=C3=A9 : M. emeka chris
Nom de la banque : United Bank of African
Courriel=C2=A0: infor.atmbankofafrican@gmail.com


t=C3=A9l. : +228 93983877

Il s'agit de la banque approuv=C3=A9e par les Nations Unies, le FMI, la
Banque mondiale et la CEDEAO et sans cette banque mentionn=C3=A9e, aucun de
cet agent ne vous soutiendra ni n'approuvera le paiement pour vous.
Veuillez contacter la banque maintenant et recevez sans d=C3=A9lai votre
carte de guichet automatique d'une valeur de 1,5 million de dollars.

Sinc=C3=A8rement
Kristalina Georgieva
Pr=C3=A9sident du FMI.
