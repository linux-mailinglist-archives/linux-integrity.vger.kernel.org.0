Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9EEB7B772C
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Oct 2023 06:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjJDEi2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 Oct 2023 00:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbjJDEi2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 Oct 2023 00:38:28 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0979B0
        for <linux-integrity@vger.kernel.org>; Tue,  3 Oct 2023 21:38:24 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id 006d021491bc7-57b67c84999so1082895eaf.3
        for <linux-integrity@vger.kernel.org>; Tue, 03 Oct 2023 21:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696394304; x=1696999104; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JEkw1KmmzfmMdZjy2G/k2kJ9Rp06l3CUoffIihDDUro=;
        b=aM4RgpOZ9jaok5PPURrnxoLzO52PMPj2rxCT7nXy8534YPlASNmtjKxFh7kfapspOs
         UwIKlT+kdVIjwnM+MFi3dIEjT6uzdsM3sS7T1i9IO36bUcilYUdDDlSXkFib7wuV7jA+
         MqPIEU/Oq3JBDnAcsMuB1aXmVVCax/YNtJqNoOpeTLCzp4i2PJfdAsnEfX2S7+6iMZOz
         ADJ54thgQfWOuN3rttwEVPV87LAKtLcjJGQo2WexQDoDGgENlagrEY7+xJEhyguIctD8
         Yt6b0wR6C1tKTM56lakzs/o+VsrWfuesdVkUfRMNA1P4hGEf+NazhYfaR7ALv832qPi9
         RpAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696394304; x=1696999104;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JEkw1KmmzfmMdZjy2G/k2kJ9Rp06l3CUoffIihDDUro=;
        b=sU/mJUioZevBjxgl3t5b/jaViMuLTxQEm0YwBODhKEHBgikPxAplRhytf8svvBybPX
         jvnWNHfXPDv6K5nhWSvTdfEmDciJ7i8mdCMFDrrmJ5DjYjgxz2TLFuOoJIxTWmlXRl+A
         bN5MmNQ37jK50LSR7iY7B2vvnqcKBMkjAlj4oyz7Klvho/E6YjW4makyVu0cDHBlaxVD
         ROx1oZzJlHKmGZ5+QtFFe3u66RZSSIyaTWfqszsgUT6ePBE4ciyPmVBsdbgQY137HUvv
         f8qIKLc9xOaI4gJUL1TCViaSeH+i+BglmVsMrN41+/NLArDMHYiQscRwcdK7fp1NaJ0P
         CoJg==
X-Gm-Message-State: AOJu0YzojF6273HmyDh2L+lOV5myTFckM/PSSneUCBvufpzKMKVVT4k9
        6sEd0TtwHw1KO3jE+IQ8WRiH9ahxOXJlkXC9+s0=
X-Google-Smtp-Source: AGHT+IGm/2JEqiE0/QY5Eg+yRU7DF4Rvf501YmbiZkubsI/IdEroDZ36x5LMTaZA3rHSbSlkAXnAoouGCICBHKWExpk=
X-Received: by 2002:a05:6358:938f:b0:139:5a46:ea7e with SMTP id
 h15-20020a056358938f00b001395a46ea7emr1196955rwb.28.1696394303874; Tue, 03
 Oct 2023 21:38:23 -0700 (PDT)
MIME-Version: 1.0
Sender: meizhen100@gmail.com
Received: by 2002:a05:6a10:b789:b0:4f9:6afd:7c3c with HTTP; Tue, 3 Oct 2023
 21:38:23 -0700 (PDT)
From:   Dr Ava Smith <avadrsmith1181@gmail.com>
Date:   Wed, 4 Oct 2023 04:38:23 +0000
X-Google-Sender-Auth: dRTeW-NviaW1u3olLG9_33LiWyQ
Message-ID: <CADYjMSTVNQj-Ui0AuxBC-sC1RG4gKUYPpVNgCR_m3j5z3zeZ1A@mail.gmail.com>
Subject: Hello,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello,
My name is Dr Ava Smith,a medical doctor from United States.I have
Dual citizenship which is English and French.I will share more details
about me as soon as i get a response from you.

Thanks
Ava
