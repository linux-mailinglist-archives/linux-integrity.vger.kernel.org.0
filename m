Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1418F5F83DF
	for <lists+linux-integrity@lfdr.de>; Sat,  8 Oct 2022 08:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiJHGig (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 8 Oct 2022 02:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJHGif (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 8 Oct 2022 02:38:35 -0400
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892773AE4F
        for <linux-integrity@vger.kernel.org>; Fri,  7 Oct 2022 23:38:34 -0700 (PDT)
Received: by mail-pj1-f44.google.com with SMTP id fw14so6027810pjb.3
        for <linux-integrity@vger.kernel.org>; Fri, 07 Oct 2022 23:38:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Oo3e28Mm5/d6vuboR9JiHPHIRBcR1/Ef5JWQr39IG20=;
        b=da8PgweeDwU5FBwxxQhZ36hjQsoXA01ZqPnOXiYWpUCCohexZgjHCrZ46M1dODl1lY
         xw5GGg2BJ/YaiSViQwqtQwyDEPQNlnR1bIdS6+EqGEjrRishdjMtIvpDBsLbKFMTZB5R
         011EDrA5RBOFHhUjlQeoNyXRHTeULb6ODbYdRf1CtVpID4jIo9+msT/I+kEpGk9Rf30W
         EMuK/gqeLNls2NhyEezHw6nPa9jioY5NmEUDCgx6GOhpYuan+w/Nm1Z94iKDuYp1tEJK
         H8/hClIhV0eJOajXH+4MIeSnn7jJhE3HTNZdSdZ7k2VP1aYNW9GIIT78T1VixP7Igd48
         +d8w==
X-Gm-Message-State: ACrzQf36S2kCkngHzaRBB6tx+sjeT/4JlXpMqEP/d7fW4aMLuLZ+1AxU
        22KCM+zL8LBfCp5YHu8NuS+4gN4MhMs=
X-Google-Smtp-Source: AMsMyM7KXB34OBAMAoYarKwmS6mFoRO31B2pdPmQxaoG5jbKrE2ogpnkMpkn3ntZOxFmutrMr4e4Ww==
X-Received: by 2002:a17:902:ec90:b0:180:289f:7f10 with SMTP id x16-20020a170902ec9000b00180289f7f10mr5658873plg.29.1665211113807;
        Fri, 07 Oct 2022 23:38:33 -0700 (PDT)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com. [209.85.215.178])
        by smtp.gmail.com with ESMTPSA id s20-20020aa78bd4000000b00562f6df42f1sm484353pfd.152.2022.10.07.23.38.33
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 23:38:33 -0700 (PDT)
Received: by mail-pg1-f178.google.com with SMTP id b5so6383736pgb.6
        for <linux-integrity@vger.kernel.org>; Fri, 07 Oct 2022 23:38:33 -0700 (PDT)
X-Received: by 2002:a63:2215:0:b0:43b:e00f:7c7b with SMTP id
 i21-20020a632215000000b0043be00f7c7bmr7744521pgi.511.1665211113111; Fri, 07
 Oct 2022 23:38:33 -0700 (PDT)
MIME-Version: 1.0
From:   Ken Williams <ken@williamsclan.us>
Date:   Fri, 7 Oct 2022 23:38:21 -0700
X-Gmail-Original-Message-ID: <CADrftwN_3ZCKfOCLj80fBwkGtz8KpAX912ip09OhfMd96uPBXQ@mail.gmail.com>
Message-ID: <CADrftwN_3ZCKfOCLj80fBwkGtz8KpAX912ip09OhfMd96uPBXQ@mail.gmail.com>
Subject: User question / Policy file
To:     linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

My question here is related to preventing an off-line attack where one
simply removes the policy file.

I have successfully installed and enabled appraisal sufficiently for
experimenting with IMA.  In my environment, I am allowing the policy
file to be automatically loaded through systemd by placing the policy
file at /etc/ima/ima-policy.  This is good, but what happens if one
simply removes the policy file through an off-line attack?  Since the
policy file would not exist, measurement and appraisal would simply
never be enabled.  Are there other ways of baking the policy into the
system or protecting against this exposure.

Thanks

Ken
