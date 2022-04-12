Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14A14FE6A5
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Apr 2022 19:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241720AbiDLRSD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 Apr 2022 13:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349263AbiDLRSB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Apr 2022 13:18:01 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7F251594
        for <linux-integrity@vger.kernel.org>; Tue, 12 Apr 2022 10:15:42 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id x33so26904237lfu.1
        for <linux-integrity@vger.kernel.org>; Tue, 12 Apr 2022 10:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=7MQEcSwfBb3KjcRUg/INs91ABtIOS3JRaH/ug4JzThc=;
        b=HrmLeLfBnCq2mrPW16Sn+RT+6UPLO1Md3cK7NkcADIb8/xPjXDv3OnrroNifoXZzKb
         0wM2KC0Io/XQH6OyQXwdEVMD/0TBYsLVvH4xEE+cTXAIA5DoSUzQ6DZ3t7OUf/BuDhgE
         0mEpQ4zgxcWDRi/ZvMvZbupNlveulp+PDKtOSJxnYD+fCL7j1PwmaStS81Xx+34oyLoh
         UMHhilJrdc+hX7S1GeqOka/s/w9QeSsmfj2FB5pOsQuhfBJwlUcL4ta7tvYOv5V7vSVO
         C5BPA0wJ87FfWuKVQDghqn73aIWWRp6EXA8hYIqmZD4hHZ3xGctWiECDUfGXIEfN1gJM
         ZALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=7MQEcSwfBb3KjcRUg/INs91ABtIOS3JRaH/ug4JzThc=;
        b=BYQ1hYCrO6J0i8L9fNVjA3h28AwHMOVqEpADkqiRo1zr1gG/PFIwHAy3i1XEo7rwYP
         zpqp916JOAiFs91TezBCwCT+NYe3raCsnikBUoudKVzTdAP8VCw+i76tByEI60Wut58i
         ZffrBP7NndZrOK538YrcdUqJrh2eb/vXdvFe/OMfmilMm9JrHOnxRp8iU76bvVV18H+A
         L77JJFFlD0IF+nLkbqC49i65PJdcCZ3OhcqRUlTHWoglkKzyQjvEHp42LDjCRvB+LJEo
         Ksv/Zv9uRvgjZ++PS4uxueXWpR2Cd6R8tQTADkl9qDPc/vrq5T3M/On1TRidYJ6p80mM
         vFhw==
X-Gm-Message-State: AOAM533uZW+6NqqUuo37FFMhQYkEtT6q3HUKOHo2Akg1lJ+VUwL1ULWT
        cn1QP7h0KDPP1Svo3RsZHS57+khi+wnp/dlNPZY=
X-Google-Smtp-Source: ABdhPJw/SJ8gTeOl8BNieHEELBISFHTh/m1LNaLox6j8sI3/QjEu5GssH7B8A59jJq0WhDu0+rEtAjzOFUEDoP3bVRc=
X-Received: by 2002:a05:6512:6c4:b0:44a:95a4:83e1 with SMTP id
 u4-20020a05651206c400b0044a95a483e1mr26532979lff.93.1649783741127; Tue, 12
 Apr 2022 10:15:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:9c2:0:0:0:0:0 with HTTP; Tue, 12 Apr 2022 10:15:40 -0700 (PDT)
Reply-To: robertsodjo63@gmail.com
From:   Roberts kodjo <kristengriest196@gmail.com>
Date:   Tue, 12 Apr 2022 17:15:40 +0000
Message-ID: <CANL0B4YWxgY7609c1QHgTFH__reXsFMswq-=FPGXaeB5Cky79w@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

I also wrote you a previous message 2 days ago but no response from you, why?
