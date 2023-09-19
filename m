Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A34AE7A5AF6
	for <lists+linux-integrity@lfdr.de>; Tue, 19 Sep 2023 09:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbjISHcs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 19 Sep 2023 03:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbjISHcs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 19 Sep 2023 03:32:48 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C22120
        for <linux-integrity@vger.kernel.org>; Tue, 19 Sep 2023 00:32:42 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d8571d5e71aso205188276.0
        for <linux-integrity@vger.kernel.org>; Tue, 19 Sep 2023 00:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695108761; x=1695713561; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rKObcm639gGAm/mfp4vDKZFXpxuyA+KOVIh7QFzNSE8=;
        b=Pu8w6X+tRXt+kklzC38dM/97d5FXi1N0EyxGNqQz0b81zB+awwtWYRerNUk6OCb/E/
         dRokNif+u9qrPMfr/i9AftuIzyoTJY42WHu6sXZLfwTg9760sEptF6CKIM/A4sY+UkE9
         WX9ak05bfDopHIZvzw7mY4mmRpyyi9quButIaFEM4muW7wfFg16mTHgWq8JNwVN7472m
         b/hDbTn+zM7gxfnJj/GHvOfANGB+rJRsfHW/1J+QQS2NFT4+PR+C1Pd3FX9HR7futbhE
         Z55bYEjqO3zL7SkNi+stvG2w6Yw9T7J7XYvz6Y94KyoMIQZoeaYORjPU2FxuIKO2jSF5
         +6xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695108761; x=1695713561;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rKObcm639gGAm/mfp4vDKZFXpxuyA+KOVIh7QFzNSE8=;
        b=i0xOe5jknNUFrh80kgfMkeM+yDzCLQcXwp8xPXplTWpvDyKSLSL2QbCBXUocm02oPw
         eSHslRSN4vJLvgJO10lKqTwtKEDyyIz2ToNCT728P3Qe/JM7+h9GifEMpLAjam4Yk4Ma
         7gV1IROJ2D/EZd8SR2ONLiUW1wzjC8lb5AwW72xP6KWxcBmq2Dyhd6QIPI8Qpcj05uBC
         G2jBSM4awDkZuRza8vWkrx93WTYLR6GBNG+zkVEJCvbrPuk4i5UECpHHHnoK5Py0mwCB
         thjPeNvCaHWagMBdQSxB4RLADexsvqED0uCj7QXtkfV1TNzlNnb1JsEbSqEKqXcZQ4I8
         LYaw==
X-Gm-Message-State: AOJu0Yw78FJcdZrKTQsyIdsGNpJvs7u9bg2FIpDa6lZzGm2hc0nIR6ZX
        g4H0n1xA63/ZEogieK9E6M/B8vU=
X-Google-Smtp-Source: AGHT+IHJxvy/cbJranGmaNtnWNIlAAOZOh3kGq6IYc0OGUoP8LX3QnKfja9ikwiEO9lFEoCk/VuVoMU=
X-Received: from hmarynka.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:925])
 (user=ovt job=sendgmr) by 2002:a25:d882:0:b0:d81:9903:9dec with SMTP id
 p124-20020a25d882000000b00d8199039decmr237127ybg.7.1695108761694; Tue, 19 Sep
 2023 00:32:41 -0700 (PDT)
Date:   Tue, 19 Sep 2023 07:32:37 +0000
In-Reply-To: <20230711164447.714035-1-nayna@linux.ibm.com>
Mime-Version: 1.0
References: <20230711164447.714035-1-nayna@linux.ibm.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230919073238.2476335-1-ovt@google.com>
Subject: [PATCH] ima: Remove deprecated IMA_TRUSTED_KEYRING Kconfig
From:   Oleksandr Tymoshenko <ovt@google.com>
To:     nayna@linux.ibm.com
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello,

There are two Kconfigs that depend on IMA_TRUSTED_KEYRING:
IMA_LOAD_X509 and IMA_BLACKLIST_KEYRING. Removing IMA_TRUSTED_KEYRING
makes them unreachable. Should they be removed too or should
the dependency clauses be removed?


