Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617995F1FE3
	for <lists+linux-integrity@lfdr.de>; Sat,  1 Oct 2022 23:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiJAVxO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 1 Oct 2022 17:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJAVxN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 1 Oct 2022 17:53:13 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6171D4F680
        for <linux-integrity@vger.kernel.org>; Sat,  1 Oct 2022 14:53:10 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id u26so3106013lfk.8
        for <linux-integrity@vger.kernel.org>; Sat, 01 Oct 2022 14:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bearmetal.eu; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ABtpF7FpkfscTeG2ufv9Or4kQC9LnXNTy/2SsoC+Eas=;
        b=HevJvU8hspeLmS9MrlOWp8KZGUAhe2ngK8LrGg4cMI9Ux5yoH+miFKJTeY9Y1Bi3s8
         /p7kt8KZiBWquzSUdAm8MpsZ1RI5yIoYCOg147BgCVO3Q7aFH9wTVe4+H/+OcTAI1966
         ntNzHfy7Dz2w0HGE+fKIa7I6BLuw0No8KvFNp/V2zy3/yT03PyJg15YpQpje59mETt2q
         AaAZCWaTRTlnEEiVl73NAn4zm+a/Xnbsjqilxlf5Se1eqYYcKm6fDPm01qq0oFSFpjny
         iQKF8SgnEZmrmdl241J6+KtiRJPETT4JlnHIXUgweLsNw+awH1PacMyVAsTDr92hKfFI
         JrmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ABtpF7FpkfscTeG2ufv9Or4kQC9LnXNTy/2SsoC+Eas=;
        b=oaZIfe6fSkPlLnND5og70iODOTYxec+WhX+rLCU0bGtdSAV7TjiuaHCdy5mm+UBbo4
         LObzzR2+RN454e4THuX3BVtmIj70aA4JGk54APGWU3MtZimTSKFmaPNma9sGcUgpMbRD
         7Al61cmo35CVOqyoH7nc1qR/3MKh3609G1j6LKTf4TANgWF+jycI+mixwrdQOZOnrBcP
         qHgWSuj/rC7jw8b+RgXxyI5qAZQqv27ufqbn+S20tGjfeYwwxanYc/P1cm6K9lReLaAf
         3QNRXAoKBw1Kb/k7P11HYkgyJuy0/hMWjl/nP3ynunZ/QL8CVNzBROuyNhm4Hkgw2PFR
         KUjw==
X-Gm-Message-State: ACrzQf2MiZPYI4SIk4MzNeODkBFJm3KYL7u79/wk0WTAeO77CSDIOQPc
        OnL0Dh9/V7gGoYRulFB5tCzeOA==
X-Google-Smtp-Source: AMsMyM53AovU0IuW6qHAXDZOCB0H9RLslxXWp+EFYe4dSwZrqWB6ghDV2ik9rEFJezod/YDrivgfmA==
X-Received: by 2002:a05:6512:1087:b0:49e:5f7b:ffad with SMTP id j7-20020a056512108700b0049e5f7bffadmr5835239lfg.471.1664661188580;
        Sat, 01 Oct 2022 14:53:08 -0700 (PDT)
Received: from erkki-carbon-x1.bearden.eu (75-161-250-195.sta.estpak.ee. [195.250.161.75])
        by smtp.gmail.com with ESMTPSA id f5-20020a056512228500b0049c86ca95bfsm870920lfu.52.2022.10.01.14.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 14:53:08 -0700 (PDT)
From:   Erkki Eilonen <erkki@bearmetal.eu>
To:     jarkko@kernel.org
Cc:     jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, morten@linderud.pw, peterhuewe@gmx.de
Subject: Re: [PATCH v2] tpm/eventlog: Don't abort tpm_read_log on faulty ACPI address
Date:   Sun,  2 Oct 2022 00:52:24 +0300
Message-Id: <20221001215223.783896-1-erkki@bearmetal.eu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <Yqooof3If/y9lBPC@iki.fi>
References: <Yqooof3If/y9lBPC@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> If this is not something you can buy off-the-shelf, it
> unfortunately does not cut.

For a N=2, we're having the same issue with a set of OTC machines.

Device: QuantaGrid D53X-1U
BIOS:
  Vendor: INSYDE Corp.
  Version: 3A16.Q402
  Release_Date: 11/10/2021

ACPI TPM2 table:
  [000h 0000   4]                    Signature : "TPM2"    [Trusted Platform Module hardware interface table]
  [004h 0004   4]                 Table Length : 0000004C
  [008h 0008   1]                     Revision : 04
  [009h 0009   1]                     Checksum : 8C
  [00Ah 0010   6]                       Oem ID : "INSYDE"
  [010h 0016   8]                 Oem Table ID : "WHITLEY "
  [018h 0024   4]                 Oem Revision : 00000002
  [01Ch 0028   4]              Asl Compiler ID : "INTL"
  [020h 0032   4]        Asl Compiler Revision : 00040000
  
  [024h 0036   2]               Platform Class : 0001
  [026h 0038   2]                     Reserved : 0000
  [028h 0040   8]              Control Address : 0000000000000000
  [030h 0048   4]                 Start Method : 06 [Memory Mapped I/O]
  
  [034h 0052  12]            Method Parameters : 00 00 00 00 00 00 00 00 00 00 00 00
  [040h 0064   4]           Minimum Log Length : 00010000
  [044h 0068   8]                  Log Address : 0000000043274000

Fallback to the UEFI eventlog is what we did for a short term fix too. Will try to contact the vendor for a fixed ACPI table long term.

Morten: Did you get in contact with the vendor about this? Looks like a class error across different devices.

Cheers,
Erkki
