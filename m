Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2572611460
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Oct 2022 16:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiJ1OW5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 28 Oct 2022 10:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiJ1OW4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 28 Oct 2022 10:22:56 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49C742AFF
        for <linux-integrity@vger.kernel.org>; Fri, 28 Oct 2022 07:22:55 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id d26so13251284eje.10
        for <linux-integrity@vger.kernel.org>; Fri, 28 Oct 2022 07:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XZVkFn3YwdxEdThkVHM6Q9Cxc1dE09qwtEAvH/ySM1g=;
        b=QCEYotzpOaYXQcbVVzLTP6eEdNXjxvk6uwE8h3Re6HYArJ7t0tghR//HRbfZVBgocB
         0U+OcpmZgaKEo5DhVs+jdKkwbXfmeVtwqlrKmC99KsUvoqpeo+uTyH8WwjUM2M66YlRp
         EST2ZgNkzOAylXKuHOjJ5pQGJM9mhvmx4KxXD7SILZQ5riaQU9r9wYd1go23xpfA5cAa
         5HIBBBOiOh6Nx7oQDskPxoqPRAI0SKiJMMR1bRDEnz+66zet/RPZ/3+vHcoWJhu33xPg
         Yn+KtQR2hrAVMxrlV/VQj0Pbvhi8Sidj4RnaveaCG+/3nYhJeLszCnFnOV3sC/It0khK
         0qlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XZVkFn3YwdxEdThkVHM6Q9Cxc1dE09qwtEAvH/ySM1g=;
        b=rhxuvDfm0qL17Pl2VYlOo9F+UN1Oc1nNqFO8UKpDpYfivzPLzvL52lfDdPtmOxkXl2
         5IA/OcLafZyTEcuoSxjzWFo1TmDIPoG7BHFQVvh0FDTY4WsSUhkTLUNS7KG311dXIbZQ
         8d3FbvD+k9NNn2p7AG0+hWqZORPcjQrHamCYDbf55ZbDYGiSV6qfEemFnwY/TXllGoeN
         haQW2gxMkrDO0DZwu7zPVHLi6I+bODl8WssSjqUspRS41SntYI3dqBAWrTWe5f/P7oym
         upfcu8/H0TuJLy4hHA8MV9ZjZzUwU/4WZinUrdga32QLBoTY3TZLN//OtBfkuMytpJzI
         VTYw==
X-Gm-Message-State: ACrzQf0JqTZCYeLEfpQSZSYDmOMwN+aiv01k9U6DiZbkyfeVfHDq6IU4
        9ch4dvCI/AIDpyqK0GppIygFJdNjSaOFdNF+TuHVMQOpHLg=
X-Google-Smtp-Source: AMsMyM7w/jcIlN0aJY4Pw9m1WhRfT86nipMtESWBqgI42G7Vc0/6mdEwJ2fzp7txxYgAnlpgtL3H4ydtQhN5ChErDVU=
X-Received: by 2002:a17:907:724d:b0:78d:acf4:4c57 with SMTP id
 ds13-20020a170907724d00b0078dacf44c57mr47083509ejc.516.1666966974168; Fri, 28
 Oct 2022 07:22:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6f02:cc7:b0:25:e104:abc1 with HTTP; Fri, 28 Oct 2022
 07:22:53 -0700 (PDT)
Reply-To: sgtkaylam28@gmail.com
From:   sgt kayla manthey <otawo2019@gmail.com>
Date:   Fri, 28 Oct 2022 14:22:53 +0000
Message-ID: <CAB9VptRWtN-jvh5m2p2ZG78rzr3F6qFPcQ3=W9=4OD3uRW7Bog@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

-- 
Hello,
Please did you receive my previous letter? write me back
