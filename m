Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6146AA03B
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Mar 2023 20:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjCCTqP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 Mar 2023 14:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjCCTqP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Mar 2023 14:46:15 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE3236084
        for <linux-integrity@vger.kernel.org>; Fri,  3 Mar 2023 11:46:13 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id bx12so3325954wrb.11
        for <linux-integrity@vger.kernel.org>; Fri, 03 Mar 2023 11:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uUYvI8Ui3dKTVhj+7tR1tb9NpNDk/M6Jzff0bPtmFz0=;
        b=DbXOV5460YAOGYkffd/IwSzlFD7dBwhWULaW6G8mYDdPURUqJuxRgUmHk013axGuZE
         lqN/f9xCdyif3l6iHVLUB7vZvqyPjDnyOa3w1iSWrrYZMDvTsXXLSDHFDh2twLnxojmK
         Nk8k1lgGYlyn6QGQLL52gSWPj6Mx7SVsmRkCfIxfORgtMIye3ak97gov7Fn566ou1L0Q
         HRCpeBe+1oZRree09NJFRLLA78cq/7J1uKeGmGN2MfiT4DJUMQVtkx65ZFXwd0DTmUfx
         CIpUxYvKHsKEbTm7IN9RIbFZ4GxI0swFNsnt7SnRPMzdX5Lm4R1OibovBvzVtrGHa+rW
         5ZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uUYvI8Ui3dKTVhj+7tR1tb9NpNDk/M6Jzff0bPtmFz0=;
        b=SyL5Sflce5slm/gR2QEdfITe2OfxmQDRKxlZEY/VcKC3QH6eS4RHTUfU++ccytQxw7
         5OUUpL/MnB1hnGKtX9PStDlZ+ObmH0nS7SJWncjeqcbhRSt2K/q8FpFku7jN5Zhh7Jov
         HkLU7qKzNHpWwndYTp5E1yd9z/higLo3bqZuvlX41zHij1kiXQrUTipEpA6zqz99EeVB
         +LhjhcCsOb6EBvMDS608pBjoNmu0jItLVg3ymCmRU54o1Mu6aq4SkWCvc7bRN4grb8wr
         xpRJivLYgTUXrWV8jLg5YWNlgU2ygIQ4FTplxY/+5ArrguIYnNEDX2RvsTDKEGsHVYGc
         gvZA==
X-Gm-Message-State: AO0yUKX5ZkbBKLqyZsuznxOed+jNs/ZTWglUkXKt67Vg9jU/lockK8ng
        DtsxUGUDv3H1FrEjNKinmzGlGUGn19M=
X-Google-Smtp-Source: AK7set9LADaYhgbQEpxPVOVMhWwiix4c3Hf+idvv/1NiCeslZE97Bvr5gL43p8+oY1V1VaWCYpODAw==
X-Received: by 2002:a5d:4e8d:0:b0:2c7:e21:4e49 with SMTP id e13-20020a5d4e8d000000b002c70e214e49mr2256616wru.10.1677872771987;
        Fri, 03 Mar 2023 11:46:11 -0800 (PST)
Received: from localhost ([5.61.42.112])
        by smtp.gmail.com with ESMTPSA id p1-20020a5d4581000000b002c55551e6e9sm2992570wrq.108.2023.03.03.11.46.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 11:46:11 -0800 (PST)
Message-ID: <af33fdf7-f56f-cc8c-fc75-5e6545a0c432@gmail.com>
Date:   Fri, 3 Mar 2023 21:46:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     jwboyer@fedoraproject.org, jarkko@kernel.org,
        linux-integrity@vger.kernel.org
From:   Adam Vodopjan <adam.vodopjan@gmail.com>
Subject: Shouldn't we check if MokIgnoreDB is non volatile in load_uefi.c?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Commit 5f56a74cc0a6d explains why it does check if efi variable
"MokSBStateRT" does not have EFI_VARIABLE_NON_VOLATILE attribute.

Shouldn't the same logic be applied to "MokIgnoreDB" in 386b49f51dc24 ?


Just a reminder "MokIgnoreDB" for "MokDBState" is the same as
"MokSBStateRT" for "MokSBState":

https://github.com/rhboot/shim/blob/main/mok.c#L128-L131
https://github.com/rhboot/shim/blob/main/mok.c#L142-L145


