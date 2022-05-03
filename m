Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC83518D1D
	for <lists+linux-integrity@lfdr.de>; Tue,  3 May 2022 21:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbiECT0x (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 May 2022 15:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241859AbiECT0v (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 May 2022 15:26:51 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E29B2AE37
        for <linux-integrity@vger.kernel.org>; Tue,  3 May 2022 12:23:18 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id b18so13041075lfv.9
        for <linux-integrity@vger.kernel.org>; Tue, 03 May 2022 12:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=oDPDRTaJ/Y9FxcEb/X2khYoMXOgW7bHgyQsV8PtMr7Y=;
        b=UrLmD6tCqKeG6+qUvD3hHxC/7foZmjkC2BmjZf25xGF648iF4IDJqjbzyfeYzl/xjA
         WMGDsHeQrmpyATwD6MWLsZ6vZOEMAyoWPiI1q1iWaqh6tRbP1gIwTSilFXtvHB/oXf9e
         isJVuZxZDeGoSTBLW/Gx+UOrV351WD/G8XvsZXqw0ZKLGSaJ4mVrK17lKparMyguqwff
         I4w3UZBLIN3tGRKQ0ffeP3XA1CCK0P3q+jYbfV3B3HHB9FRic9NdgQgk3NDo+4aGgmOb
         fIQYi1ip2njr6wNSeDgaSlFjNkABFBs88JslD3/uEjR0n8GzefAFPnPqJ3ZWiwBo+Sx5
         Khjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=oDPDRTaJ/Y9FxcEb/X2khYoMXOgW7bHgyQsV8PtMr7Y=;
        b=asynRccN4GlVj/WwEdC1YOjHU6NS4IfVS3cKbahL8i9MSDotOG92JndPO4MPmva3eL
         vLkL3sOPhwbJvnEg3tYdwobNamsOGQQoovk62A68d1fhcKNmPR37QocWmlB207pto/qF
         /RraP8K0uHEyWck3q4BryMDbxzlCr+xD2+W58UD2LoK8W3tMP5feXGHu/qTrIGZCZnW3
         OqGn6W1a9W8ZVLeyDk4RP/s6oOZWvIA+Dr9BpkW4eYmqboC388DBo7UqRqvOuv/jkRsp
         hi/jYwEj+2aQq0uf07ddjOZpDmuGAyRwOY8Q6cgAKX9rfseI5ovumJLXSX/F8Ia9c2tH
         sJcg==
X-Gm-Message-State: AOAM530eTvA3orp6huFNQZtAxzIGUNSxx1umEW+lLr/y1k+hTopBz/32
        DUKE7G2d+fLmmMZR0I+NZeocccN64nKMS+BpujnVbLFDvOk=
X-Google-Smtp-Source: ABdhPJwe0OKZU6xokfVUK0JvKXXGwI8b8dPqA1aRxNlk7ZYn8zNJJPxwvacC/lN9OC2zyQ7DIAxIrfvPsbJjRwkFkvE=
X-Received: by 2002:a19:f706:0:b0:473:9e36:79de with SMTP id
 z6-20020a19f706000000b004739e3679demr6476812lfe.35.1651605795823; Tue, 03 May
 2022 12:23:15 -0700 (PDT)
MIME-Version: 1.0
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Tue, 3 May 2022 14:23:02 -0500
Message-ID: <CAFftDdqL5OB+1X=W4C5KjkJgArAaUM-EJPorOXOWKsfOP6jBLA@mail.gmail.com>
Subject: Permissions on binary_runtime_measurements and tpm0/binary_bios_measurements
To:     linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Currently the tpm2-tools and other userspace processes cannot access
the system measurement logs for users even if they are in the group
tss:

crw-rw---- 1 tss root 10, 224 Mai  3 17:22 /dev/tpm0
-r--r----- 1 root root 0 Mai  3 17:22
/sys/kernel/security/ima/binary_runtime_measurements
-r--r----- 1 root root 0 Mai  3 17:22
/sys/kernel/security/tpm0/binary_bios_measurements

So with tss2_quote a quote can be computed but not the pcrLog for the
sytem PCRs.

The problem could be solved if the log files would be owned by tss.
But that could create privacy issues because the pcrLog would e.g.
contain executables in user home directories.
Do you have any suggestions how the problem could be addressed or is
there a privacy concern here?

Thanks,
Bill
