Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A12C4217BFA
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Jul 2020 01:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbgGGX7G (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Jul 2020 19:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728673AbgGGX7C (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Jul 2020 19:59:02 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6AEC08C5E3
        for <linux-integrity@vger.kernel.org>; Tue,  7 Jul 2020 16:59:02 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id u185so17093033pfu.1
        for <linux-integrity@vger.kernel.org>; Tue, 07 Jul 2020 16:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rdv9aWYxdWzi7YuZEHxXGYFHP62AjpgpR6iHCVdleuI=;
        b=E5Bv52U3XPTKQk/JUCHmdsxbrjEBV7kFdiIQaCyIgOqHSS133VrkT0uweCNwnEouhB
         D6ChoBGorNNXQRd5vuzzcx1j8GUi9ZQpXJ/p70YeFpe/j26iafcL6ByrwDGUqHuT5A/I
         RFDzv7/AV7eJ4KbBcjAjcMhpYwiZT3d6/TEnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rdv9aWYxdWzi7YuZEHxXGYFHP62AjpgpR6iHCVdleuI=;
        b=l+bsEH44fnVqHOFCZEhQ/JAOkEPoKYYuJmJBqBxf+jXrZdX1/ArYAfI/tTPKpRxmnl
         oUv9wdfmU4GtI0GShFGqJA4YBLyn6IuvBNmzUWThT+4xdC6Va3vwPRsfhqpIQYfpGYC2
         +NHGjiL6PCWDE8Q2lovYSzXjj0cr9KGoCaqkQcHNe/jk2VFL98G8CbnaGUUiXtLT+J2O
         uy/r5icoPe49up3YXpXHyhHVxvhksj7XhNRTLXlopbkTbMhBxNZiuiuhDMBt+5OORi73
         MCJwhb5MPKHL4vBCCTUFsJkaA20DcNDt10DqmIWiFwi9d3sKZkXftrW0UdGwRP8ATRYJ
         M0tw==
X-Gm-Message-State: AOAM5307QNXifX6fJoE8sCLLChD2MGMMms4jOMUFn4t45KAwXH5ma2c8
        UVMqrLVad7y/KxTxR2my9tVydQ==
X-Google-Smtp-Source: ABdhPJzYvJrtZ8JwyO03TQIq0tpFYVl2WHcKj9p5wk7nKZXNGQu8Fct93qp7eRhs4GS/cWugEjuxmw==
X-Received: by 2002:a62:404:: with SMTP id 4mr53377463pfe.133.1594166341548;
        Tue, 07 Jul 2020 16:59:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w123sm15793025pfd.2.2020.07.07.16.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 16:59:00 -0700 (PDT)
Date:   Tue, 7 Jul 2020 16:58:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v10 3/9] firmware: add request_partial_firmware_into_buf
Message-ID: <202007071657.55C2CFA57@keescook>
References: <20200706232309.12010-1-scott.branden@broadcom.com>
 <20200706232309.12010-4-scott.branden@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706232309.12010-4-scott.branden@broadcom.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jul 06, 2020 at 04:23:03PM -0700, Scott Branden wrote:
> Add request_partial_firmware_into_buf to allow for portions
> of firmware file to be read into a buffer.  Necessary where firmware
> needs to be loaded in portions from file in memory constrained systems.

Just tear out the differing "id" and just use FW_OPT_PARTIAL and I think
if Luis is happy, you're all set.

-- 
Kees Cook
