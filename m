Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C34534521
	for <lists+linux-integrity@lfdr.de>; Wed, 25 May 2022 22:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiEYUlg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 25 May 2022 16:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241098AbiEYUlf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 May 2022 16:41:35 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A99666BA
        for <linux-integrity@vger.kernel.org>; Wed, 25 May 2022 13:41:34 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id q184so9384616ybg.11
        for <linux-integrity@vger.kernel.org>; Wed, 25 May 2022 13:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=LDBqQh/PztHeiDiV9Pr0v62BTTaDnPQyU98FGi1REkw=;
        b=DKHZh2JHokMBa19p35oqvd7iRWPAzw9Zm4UPija/i1C25IS8AvcOiPS9ttxpratlkt
         bLmyDcVpF0roliP0IW2NdlqL6EumkmInAm2B5+avNnwWEIAKoexMo2KHpNDdZLXg2hW0
         DFy3q5HbVa1Cx7EE7sFx9hXRhP/GxEzWsd8M0smKO1ZNN9VaXZlxD+M9ccBcBQNznFJR
         E/ggX6tLwoRdIOCz1ehXt7wDUBUIppwYKZMYYugoXRHYX5ZyGHldejkw1IEKwWHTU7Si
         Kaf2tXaXCSxCJyPYsprxHiKry0zR20Xtzxv88mYaUagJOBUCzWev/Eetgeyv3T7+U4B2
         cp2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=LDBqQh/PztHeiDiV9Pr0v62BTTaDnPQyU98FGi1REkw=;
        b=ZEtP/FEZDIVQ96dZaTackI5BN7rmSiKJGGE5ba2FPIeuN1pAjpntiFugXrro5fhRwe
         OI1snKfdJz3c/F6gfPBZwVjZqAkaYzVhTI034qmUt8bgHmIIFTm1agEMh5A53SL+yKaN
         /YWe7ApmWbMUUHZ5qsO0Yqq3gWkiJPhXUHSPh0cylhn+gcmv3txbh4w1vaxr5ttH4Anb
         Km8IKyxIY/qXD6fbAfNYDLVQET+g7maJUIBsvnb65LGcIrN8zPiLSgBaKrkw+algOaGD
         EgJHTf0+T8hSoARTk83rJKSWi4DRehTP+VSEVc9gAq1InagO9QvnCnAcwULoXVOF0Psz
         5OLA==
X-Gm-Message-State: AOAM531fUOFWDmuhsLbz/RdhL/TxFjiQ7xB2YJSaXl6pC6kBAfv5YpOC
        4HipO/2BsuQJXR2xGrlxvbQfU15raYQZrJOvgmE=
X-Google-Smtp-Source: ABdhPJxl48Pr46tG2I/4TZnljeqb4eQv1JdXJArMWpJklPdRPoXLlgFkScKUa+Irt9YeaeeK5PmTRzDahY2KkUKowaI=
X-Received: by 2002:a25:ca87:0:b0:656:f98:2e0c with SMTP id
 a129-20020a25ca87000000b006560f982e0cmr3418222ybg.421.1653511293906; Wed, 25
 May 2022 13:41:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5b:506:0:0:0:0:0 with HTTP; Wed, 25 May 2022 13:41:33 -0700 (PDT)
From:   Deterin Falcao <falcaodeterin@gmail.com>
Date:   Wed, 25 May 2022 22:41:33 +0200
Message-ID: <CABCO4Z1qxvmnCsU7ENzK2ATFu9rkRqOxngYW_tK4Bx9GXJniDQ@mail.gmail.com>
Subject: Bitte kontaktaufnahme Erforderlich !!! Please Contact Required !!!
To:     contact@firstdiamondbk.com
Cc:     info@firstdiamondbk.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Guten Tag,

Ich habe mich nur gefragt, ob Sie meine vorherige E-Mail bekommen

haben ?

Ich habe versucht, Sie per E-Mail zu erreichen.

Kommen Sie bitte schnell zu mir zur=C3=BCck, es ist sehr wichtig.

Danke

Falcao Deterin

falcaodeterin@gmail.com








----------------------------------




Good Afternoon,

I was just wondering if you got my Previous E-mail
have ?

I tried to reach you by E-mail.

Please come back to me quickly, it is very Important.

Thanks

Falcao Deterin

falcaodeterin@gmail.com
