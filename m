Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F8B672DDF
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Jan 2023 02:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjASBNS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Jan 2023 20:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjASBNJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Jan 2023 20:13:09 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5856843B;
        Wed, 18 Jan 2023 17:13:07 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id v23so879843plo.1;
        Wed, 18 Jan 2023 17:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=trQ8wPDdZRnOhR09mO+bG/KeF7fjbj/nqEQErtarT5c=;
        b=iedPpwf5nA+2keWvD77tT1QHT2acngdr0fxuAbMcmef4fExDwXZU8yzdvJCxhpT2ym
         mq2SWTKZN8VkEL1mCgymWRb/aODT6vdXJ2OhQNWKI1eQMQeVnu3gz0WFxHYMFwydsOjx
         2/W05BJEfDQjIy3JZXoaQCcJhjrfYpJmuh5iFYvhHXr3Z6jgbchYnFCzBsxcCdNTZdeF
         uB7Dnjl5+7QtYFW8tfqC74mpu8BS5VZCJNZ7LytWzt3Rim3m0WZ1iAd21BhwhZQX3KDt
         ouzBsmDpWRIvzUVq3beb+KIenmmnAf6jNHWJNN+pMiHLw6aKFM2vJbFS5VRKj2iaFoNL
         WXSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=trQ8wPDdZRnOhR09mO+bG/KeF7fjbj/nqEQErtarT5c=;
        b=gdmXwXWstN0t63Q9Mz7k3kO+ki3oBLAirw9GF86uQwdEU+nyR6LcYDyuJxJCtp+w29
         t4CYQmV/I4YA8WLzH9zLwKPip6BeQ2q0S6ViBaPUbX3wOhzFAUNfe9HCUIIzAW6Mw+Je
         izqc2VQE0Vgc18GeSFkE9qH4zD9ULdmYDuDiv0dYScQLXw3G+F2qBw7sxGCxcr9QKhgH
         BwHX+/dSUB07W7HVQdOMmF/3kf0O62W7Odmf4fP0FFyOtVrR7vHMDSTBR5As8fQfun2+
         N41WPDW0fupp0z2I4Gk6Inv67j9YQU3hDBb4ycZCEieuVHHLtTuR9LF6/CC3K1nkULuC
         Il7g==
X-Gm-Message-State: AFqh2kpRwaz82eh9X5mpHyD8qvQ25rBKJ3c508Vkjk2pUFoObx/ooY0+
        9kGwjtmEHU6XoFF5mWCwexM=
X-Google-Smtp-Source: AMrXdXsFGIbounHZJ2Dj4H4446MRSLS+KlWWG8txSiLuHDvKJ/U3YrT2y5kFsBYYfzOil7tpMtE/pg==
X-Received: by 2002:a17:902:a9c5:b0:194:60c3:482f with SMTP id b5-20020a170902a9c500b0019460c3482fmr23642700plr.26.1674090787240;
        Wed, 18 Jan 2023 17:13:07 -0800 (PST)
Received: from localhost (193-116-102-45.tpgi.com.au. [193.116.102.45])
        by smtp.gmail.com with ESMTPSA id y8-20020a17090322c800b00186f0f59c85sm2511649plg.235.2023.01.18.17.13.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 17:13:06 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 19 Jan 2023 11:12:57 +1000
Message-Id: <CPVRNHVV9L6U.34DQEC4B6NB51@bobo>
Cc:     <sudhakar@linux.ibm.com>, <bgray@linux.ibm.com>,
        <erichte@linux.ibm.com>, <gregkh@linuxfoundation.org>,
        <nayna@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
        <zohar@linux.ibm.com>, <gjoyce@linux.ibm.com>,
        <gcwilson@linux.ibm.com>
Subject: Re: [PATCH v3 16/24] powerpc/pseries: Implement signed update for
 PLPKS objects
From:   "Nicholas Piggin" <npiggin@gmail.com>
To:     "Andrew Donnellan" <ajd@linux.ibm.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.13.0
References: <20230118061049.1006141-1-ajd@linux.ibm.com>
 <20230118061049.1006141-17-ajd@linux.ibm.com>
In-Reply-To: <20230118061049.1006141-17-ajd@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed Jan 18, 2023 at 4:10 PM AEST, Andrew Donnellan wrote:
> From: Nayna Jain <nayna@linux.ibm.com>
>
> The Platform Keystore provides a signed update interface which can be use=
d
> to create, replace or append to certain variables in the PKS in a secure
> fashion, with the hypervisor requiring that the update be signed using th=
e
> Platform Key.
>
> Implement an interface to the H_PKS_SIGNED_UPDATE hcall in the plpks
> driver to allow signed updates to PKS objects.
>
> (The plpks driver doesn't need to do any cryptography or otherwise handle
> the actual signed variable contents - that will be handled by userspace
> tooling.)
>
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> [ajd: split patch, add timeout handling and misc cleanups]
> Co-developed-by: Andrew Donnellan <ajd@linux.ibm.com>
> Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
> Signed-off-by: Russell Currey <ruscur@russell.cc>
>
> ---
>
> v3: Merge plpks fixes and signed update series with secvar series
>
>     Fix error code handling in plpks_confirm_object_flushed() (ruscur)
>
>     Pass plpks_var struct to plpks_signed_update_var() by reference (mpe)
>
>     Consistent constant naming scheme (ruscur)
> ---
>  arch/powerpc/include/asm/hvcall.h      |  3 +-
>  arch/powerpc/include/asm/plpks.h       |  5 ++
>  arch/powerpc/platforms/pseries/plpks.c | 71 ++++++++++++++++++++++++--
>  3 files changed, 73 insertions(+), 6 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm=
/hvcall.h
> index 95fd7f9485d5..33b26c0cb69b 100644
> --- a/arch/powerpc/include/asm/hvcall.h
> +++ b/arch/powerpc/include/asm/hvcall.h
> @@ -336,7 +336,8 @@
>  #define H_SCM_FLUSH		0x44C
>  #define H_GET_ENERGY_SCALE_INFO	0x450
>  #define H_WATCHDOG		0x45C
> -#define MAX_HCALL_OPCODE	H_WATCHDOG
> +#define H_PKS_SIGNED_UPDATE	0x454
> +#define MAX_HCALL_OPCODE	H_PKS_SIGNED_UPDATE

^ Bad rebase.

Thanks,
Nick
