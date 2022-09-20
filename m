Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A5D5BF0DC
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Sep 2022 01:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbiITXKE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Sep 2022 19:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiITXKD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Sep 2022 19:10:03 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AA62F65A
        for <linux-integrity@vger.kernel.org>; Tue, 20 Sep 2022 16:10:00 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id w20so3879700ply.12
        for <linux-integrity@vger.kernel.org>; Tue, 20 Sep 2022 16:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=Fcm+XfXr78eqc0dgPlS58A1dADCVGldx6M+iMJxUTk4=;
        b=hWnpeF4UfcmqZ4Wh2WQjFQP9I4p5uiA5/md6bfoXMTIIdNrg5FBHD2Kz11xbkllLg1
         MlYK2gWymn2MOl56jIV1xhycl0rY2zwghyOZvWTg5ltD2GB5x1TGBC74cRpmztJmMdSQ
         DVprZ8qohULdilJctbm77jrm6deb3FfJ8T65E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Fcm+XfXr78eqc0dgPlS58A1dADCVGldx6M+iMJxUTk4=;
        b=K61x/69FwgI5fI464OODHhBBA+xAizZM/rGI4WdOGRPGkXBrDOOsJ2DOfcTyUqZ7ie
         XmHDobZ9J7tZEwvRmAHp7H6OV6uoGx1kJppSiyY+cMJkXdrH6suo8GsqJXG5dJ1amHGO
         /Ld0D2cHfjwTF14EMzGNkdRyVrLSg4rY41aBGXIlmX3r+jO4UIKkftEiYPIT6s/JoL84
         g+qrr83UrGfynnpg7DpuVyTjTomZQpo3USa7+vAxyttZ8lWgO3CmP4de6jmGiZ15y49M
         oxTsGF1nQ6CYTz+xcWOqNKrm4a9Yg/tNTIkJhqW9QKo3wOX3wUg3iTNZKJMNQkL5hYt5
         s9zw==
X-Gm-Message-State: ACrzQf0Kq4ie+OpNACNTkZSpR7Ke8ljfL6kfEC/+a3PCoFubjYoNv0SU
        lyvoR0DeWFiBjanU3xOB7jvyWw==
X-Google-Smtp-Source: AMsMyM4Vs8r+F9epOvKPDzNCChxRMpq/jkOL8lwp6ROWR0KPywyY8g2O5MXieKbAneOHF9ltvtTp7w==
X-Received: by 2002:a17:902:cec9:b0:178:5fa6:f3c3 with SMTP id d9-20020a170902cec900b001785fa6f3c3mr1814328plg.83.1663715399638;
        Tue, 20 Sep 2022 16:09:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 207-20020a6215d8000000b00537a6b81bb7sm464526pfv.148.2022.09.20.16.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 16:09:58 -0700 (PDT)
Date:   Tue, 20 Sep 2022 16:09:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     linux-kernel@vger.kernel.org, gwendal@chromium.org,
        Eric Biggers <ebiggers@kernel.org>,
        Matthew Garrett <mgarrett@aurora.tech>, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, apronin@chromium.org,
        dlunev@google.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        corbet@lwn.net, jejb@linux.ibm.com,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 06/10] PM: hibernate: Add kernel-based encryption
Message-ID: <202209201608.507B5468@keescook>
References: <20220823222526.1524851-1-evgreen@chromium.org>
 <20220823152108.v2.6.Ifff11e11797a1bde0297577ecb2f7ebb3f9e2b04@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823152108.v2.6.Ifff11e11797a1bde0297577ecb2f7ebb3f9e2b04@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Aug 23, 2022 at 03:25:22PM -0700, Evan Green wrote:
> Enabling the kernel to be able to do encryption and integrity checks on
> the hibernate image prevents a malicious userspace from escalating to
> kernel execution via hibernation resume. As a first step toward this, add
> the scaffolding needed for the kernel to do AEAD encryption on the
> hibernate image, giving us both secrecy and integrity.

I'd love Eric to take a look at this, just to make sure the crypto API
is being used correctly here. :)

-- 
Kees Cook
