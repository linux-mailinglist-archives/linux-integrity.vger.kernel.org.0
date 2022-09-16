Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFD75BA660
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Sep 2022 07:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiIPFhL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 16 Sep 2022 01:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiIPFhJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Sep 2022 01:37:09 -0400
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C987E6FA3F
        for <linux-integrity@vger.kernel.org>; Thu, 15 Sep 2022 22:37:05 -0700 (PDT)
Received: by mail-pg1-f182.google.com with SMTP id t65so19377640pgt.2
        for <linux-integrity@vger.kernel.org>; Thu, 15 Sep 2022 22:37:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=WZkQpJyYB+67gVRRexiyvUSPng4BF5EZLOF8oI43+uM=;
        b=65KXL6EXGizVnO0burjY4J6cH0PWxidjBLFenyajHB2Sax8XAXr/kiqEErymzcUmtK
         hUl8Ast7O83M7Ljy0MDnVkyPraBcgD6PNHijAzUa9krQQ/xThMOGlhhs6A6bKwGWhrrG
         r0aTsNhOtujTvrcxc2PvhLk1aLnwWJcra2NWTt3w7yWcsncTLCFgxoWIyV81JTLf+tol
         +Caq/yWsd2vqJGZPmoW1FebxpxDpBRERhddiNq89QgTXliGayASNkPboUkji24j65zr+
         KR6lM+AsjF20JzhF4kkq8QjgoVESwF3O8mSK30vOvX+oUo4y7JNMMSSMhHnXy/DH66EE
         o/ww==
X-Gm-Message-State: ACrzQf02hPM4ERxnElQeX44gvvlOvDXVHF4nbMb2oc4lp2xX5HZ/zvf1
        wFcbNETx9S7mA/e1fQ5/0WavkDWUAHk=
X-Google-Smtp-Source: AMsMyM7XfPYnGN70tXau9e1VKJY0fyum85YcFk7z1nWDcGEbYf3LrZ7El1yn9ivZ630XmY90crF0sw==
X-Received: by 2002:a65:5b4d:0:b0:42b:31fd:b2c0 with SMTP id y13-20020a655b4d000000b0042b31fdb2c0mr2945312pgr.609.1663306625054;
        Thu, 15 Sep 2022 22:37:05 -0700 (PDT)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com. [209.85.214.177])
        by smtp.gmail.com with ESMTPSA id v4-20020a63f204000000b00438eaf65766sm9756857pgh.73.2022.09.15.22.37.04
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Sep 2022 22:37:04 -0700 (PDT)
Received: by mail-pl1-f177.google.com with SMTP id iw17so20467205plb.0
        for <linux-integrity@vger.kernel.org>; Thu, 15 Sep 2022 22:37:04 -0700 (PDT)
X-Received: by 2002:a17:90b:1d08:b0:200:823f:9745 with SMTP id
 on8-20020a17090b1d0800b00200823f9745mr3630223pjb.84.1663306624150; Thu, 15
 Sep 2022 22:37:04 -0700 (PDT)
MIME-Version: 1.0
From:   Ken Williams <ken@williamsclan.us>
Date:   Thu, 15 Sep 2022 22:36:52 -0700
X-Gmail-Original-Message-ID: <CADrftwOUDT5CuwHsrgEM1GTu_N3TAhZTpxFBERKa7zwUHkQscw@mail.gmail.com>
Message-ID: <CADrftwOUDT5CuwHsrgEM1GTu_N3TAhZTpxFBERKa7zwUHkQscw@mail.gmail.com>
Subject: User questions
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

I am looking at Linux IMA to try and understand how it might be useful
for my application.  I am playing around with it a bit now and as I do
so, I am finding myself with questions about the usage model and user
configuration.  With that opening, my first question is:

Is this an acceptable forum for asking user and usage questions?

If yes, then let me describe my environment;
I am running an older kernel, 4.14.238, on a fsl device in a system
that does not have a TPM although I am running an implementation of
OP-TEE.  In my case, I want to do the best I can to prevent file
modification, without considering off-line attacks.  My deployment
mechanism is os-tree.

When I look at the measurement capability, I cannot see how that can
help since I do not have a TPM in which to anchor the measurements so
it looks like I need to implement appraisal.  I did find this link,
https://sourceforge.net/p/linux-ima/mailman/linux-ima-user/?viewmonth=201409&viewday=10,
where Mimi says "Enabling IMA-appraisal is anything but simple". and I
actually found that kind of re-assuring as it confirmed that my
learning curve in this area may not be out of line.  My plan is to
pre-sign the files prior to installation and I see that effort as
being outside of the scope of my inquiries here.  So now, does it look
like I am starting in the right direction?

Thanks for reading through this and I welcome any comments.

Ken
