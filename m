Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB7958FD17
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Aug 2022 15:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234133AbiHKNKG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 11 Aug 2022 09:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235193AbiHKNKF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Aug 2022 09:10:05 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3546F572
        for <linux-integrity@vger.kernel.org>; Thu, 11 Aug 2022 06:10:04 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id bx38so19226709ljb.10
        for <linux-integrity@vger.kernel.org>; Thu, 11 Aug 2022 06:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ucfBP/53P+UnzU4Fa8i2eVWM9uv5/ktiToZlI9Ntdqk=;
        b=NSbbNPqjvWfdwSYpAG4Xy3FS3qBHPq+OAXBz/qlrnN8kLAJqu707xfUJchvfsw4I4N
         DXFkEof+pN0oul6LkwxLyXNgWKIsen0Er2mPPHp5Faw5BIv7jLe124nvftk1Louy2xdX
         95BjKuN4xgMNugJ2DqadtrsaKsubR91EAeFuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ucfBP/53P+UnzU4Fa8i2eVWM9uv5/ktiToZlI9Ntdqk=;
        b=Yrc/u+QQQxJqgzHu+BT+2rzqsjfGuvWhBl/SFWVHrh1fb8dNA9IqzK9e1fBy1PHhRG
         TCc4J/iVFQCWyhczaqZFlB5zeUgHsGj3v26BWoIDxjX/2jQWLHAqIB1RJwHaHOUIuuPI
         x9kT/ngij2wGJhYSETxvNAyrRhytdnqTaMg871VZ4vgLzLiAn8dFV6hSAhUPueWOwRq/
         kGYjFLtULJFRFPi7mijVNxbl8fsAd9em8Beyynq2JEKopJa2Yk+hUWm4CYmEcW//hBPh
         m53xYX7C+fTuUvLtQmZMQRcFXexgjJ+8f3asNQbTKXQvegdEqTCjOJjb7JaySkoHn5TN
         NcYw==
X-Gm-Message-State: ACgBeo2auZyiAGyrdpvQVMWzZhEiFDagS/o08ERber0oQ1xxwG4LChfX
        AalHVPxeb5Z7/7NYWftXTbEFsjDER59bk/HL
X-Google-Smtp-Source: AA6agR4i5OanfVM9dO8Zg6jW8yz3sJCx9116qqIkWQW/ipFN5AzDc+I3V7EckrJk7mfb4B27tQaWxg==
X-Received: by 2002:a2e:bc06:0:b0:25e:70a9:56ad with SMTP id b6-20020a2ebc06000000b0025e70a956admr10559296ljf.118.1660223402638;
        Thu, 11 Aug 2022 06:10:02 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id w26-20020a19c51a000000b0048b03b4b018sm692308lfe.283.2022.08.11.06.10.01
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 06:10:02 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id bx38so19226627ljb.10
        for <linux-integrity@vger.kernel.org>; Thu, 11 Aug 2022 06:10:01 -0700 (PDT)
X-Received: by 2002:a05:6512:b87:b0:48b:2247:684f with SMTP id
 b7-20020a0565120b8700b0048b2247684fmr11707556lfv.593.1660223389777; Thu, 11
 Aug 2022 06:09:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220809193921.544546-1-svenva@chromium.org> <YvSNSs84wMRZ8Fa9@kernel.org>
In-Reply-To: <YvSNSs84wMRZ8Fa9@kernel.org>
From:   Sven van Ashbrook <svenva@chromium.org>
Date:   Thu, 11 Aug 2022 09:09:38 -0400
X-Gmail-Original-Message-ID: <CAM7w-FX4NfeQy9chKgzjAj6gvvoK3OxCK0VYq9DT5qrdB=_tDA@mail.gmail.com>
Message-ID: <CAM7w-FX4NfeQy9chKgzjAj6gvvoK3OxCK0VYq9DT5qrdB=_tDA@mail.gmail.com>
Subject: Re: [PATCH] tpm: fix potential race condition in suspend/resume
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Hao Wu <hao.wu@rubrik.com>, Yi Chou <yich@google.com>,
        Andrey Pronin <apronin@chromium.org>,
        James Morris <james.morris@microsoft.com>,
        stable@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Aug 11, 2022 at 1:02 AM Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> What about adding TPM_CHIP_FLAG_SUSPENDED instead?

Thank you for the feedback, Jarkko. After thinking this over, I
believe this patch only moves kernel warnings around. Will re-post
soon with a fresh approach, intended to fix the underlying issue
rather than the symptom.

So please disregard this patch.
