Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39E278CCA1
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Aug 2023 21:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239217AbjH2TEZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 29 Aug 2023 15:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239674AbjH2TEH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Aug 2023 15:04:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06314CC2
        for <linux-integrity@vger.kernel.org>; Tue, 29 Aug 2023 12:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693335797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zuneSeBFPY/y8fIPFfiRl+/xkZx/Kn4q/QLdpRgSaJQ=;
        b=cJ5ZhRpbnPbtfM4zOukXZ9wo4OCcsjF+CKpd+N5WghkJtGM4KIov26f6MVjsSFPJUDfxvP
        9E7sy4NMI+vuAx9xvwO1GlWO7V8izPL/JLw+itTTIcxWuTRbLZ0IlehrX54+b2Dzn4qkUH
        CX8W0hsaWTFy4k61yUQKNOh//FM4XQo=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-ZbiXRPXlOIKqypVBz4bHRw-1; Tue, 29 Aug 2023 15:03:15 -0400
X-MC-Unique: ZbiXRPXlOIKqypVBz4bHRw-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6496d9acb98so60256156d6.0
        for <linux-integrity@vger.kernel.org>; Tue, 29 Aug 2023 12:03:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693335795; x=1693940595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zuneSeBFPY/y8fIPFfiRl+/xkZx/Kn4q/QLdpRgSaJQ=;
        b=BBo40itTwnStg+j4RzqqHiSZG1NEMZPzFC2ymTE0JErlBEm/gsDZ0H3XmRdH53AyNA
         MH8kYpT373EktMgMd+sixamfWzVQQ2Jl6hApYX/gJez/HR8B+CqZ2xJeDipBWLUJ/O+Q
         UD64qBlHvsYqnAD/Tv03oQBsdMvpxW9ct/tmPQYDjoTNVc/PwdoBev0Al6BAP2szMW9b
         +KhA+3vNgSQthA09NNDWMk4WtsOBiBh+VnaU/KN4qZEcsW+K8NoVZL+tGEQzkonOhjqI
         6uWKR0iqsuBTo1ZjL7vCYorCxlYv8YSKWsLciVG4r3YnpeMgUKb/n8NyxO0S6w39TeVS
         uYMw==
X-Gm-Message-State: AOJu0YxTSkAdvCrx81Y3OwkhE+uVHXV7CwpwTUiPRI560ygh3cgiOx8T
        6GGczKRZDw3av1Lx2QG16+TRvRhYuZxC3YpQOYGpUOnfZGO6gEZLXa7RqsgBSTPd0Zm4rhdkQBr
        8RG27TQwMDDcTWn9aqwVJSVc6D4G/
X-Received: by 2002:a0c:8ecb:0:b0:63d:657:4cb9 with SMTP id y11-20020a0c8ecb000000b0063d06574cb9mr28870359qvb.42.1693335795009;
        Tue, 29 Aug 2023 12:03:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHO6zVtzuoNE6uuA2BCZJX/EOpJ2jrXsv+BY1DJ8I5lozKTj/Td7N9r2DAZ+Yrj8E+AMHy93Q==
X-Received: by 2002:a0c:8ecb:0:b0:63d:657:4cb9 with SMTP id y11-20020a0c8ecb000000b0063d06574cb9mr28870339qvb.42.1693335794750;
        Tue, 29 Aug 2023 12:03:14 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id b2-20020a0cb3c2000000b0063cdbe739f0sm3606355qvf.71.2023.08.29.12.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 12:03:14 -0700 (PDT)
Date:   Tue, 29 Aug 2023 12:03:12 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-integrity@vger.kernel.org, stable@vger.kernel.org,
        Todd Brandt <todd.e.brandt@intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mario Limonciello <mario.limonciello@amd.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tpm: Enable hwrng only for Pluton on AMD CPUs
Message-ID: <zlywbvfgkkygcpvmj5rd4thuhbdacit2meg2fj6eyua5qpwyoc@beyiattrr7o6>
References: <20230822231510.2263255-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822231510.2263255-1-jarkko@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Aug 23, 2023 at 02:15:10AM +0300, Jarkko Sakkinen wrote:
> The vendor check introduced by commit 554b841d4703 ("tpm: Disable RNG for
> all AMD fTPMs") doesn't work properly on a number of Intel fTPMs.  On the
> reported systems the TPM doesn't reply at bootup and returns back the
> command code. This makes the TPM fail probe.
> 
> Since only Microsoft Pluton is the only known combination of AMD CPU and
> fTPM from other vendor, disable hwrng otherwise. In order to make sysadmin
> aware of this, print also info message to the klog.
> 
> Cc: stable@vger.kernel.org
> Fixes: 554b841d4703 ("tpm: Disable RNG for all AMD fTPMs")
> Reported-by: Todd Brandt <todd.e.brandt@intel.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217804
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
> v3:
> * Forgot to amend config flags.
> v2:
> * CONFIG_X86
> * Removed "Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>"
> * Removed "Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>"
> ---
>  drivers/char/tpm/tpm_crb.c | 33 ++++++++-------------------------
>  1 file changed, 8 insertions(+), 25 deletions(-)
> 

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> index 65ff4d2fbe8d..ea085b14ab7c 100644
> --- a/drivers/char/tpm/tpm_crb.c
> +++ b/drivers/char/tpm/tpm_crb.c
> @@ -463,28 +463,6 @@ static bool crb_req_canceled(struct tpm_chip *chip, u8 status)
>  	return (cancel & CRB_CANCEL_INVOKE) == CRB_CANCEL_INVOKE;
>  }
>  
> -static int crb_check_flags(struct tpm_chip *chip)
> -{
> -	u32 val;
> -	int ret;
> -
> -	ret = crb_request_locality(chip, 0);
> -	if (ret)
> -		return ret;
> -
> -	ret = tpm2_get_tpm_pt(chip, TPM2_PT_MANUFACTURER, &val, NULL);
> -	if (ret)
> -		goto release;
> -
> -	if (val == 0x414D4400U /* AMD */)
> -		chip->flags |= TPM_CHIP_FLAG_HWRNG_DISABLED;
> -
> -release:
> -	crb_relinquish_locality(chip, 0);
> -
> -	return ret;
> -}
> -
>  static const struct tpm_class_ops tpm_crb = {
>  	.flags = TPM_OPS_AUTO_STARTUP,
>  	.status = crb_status,
> @@ -827,9 +805,14 @@ static int crb_acpi_add(struct acpi_device *device)
>  	if (rc)
>  		goto out;
>  
> -	rc = crb_check_flags(chip);
> -	if (rc)
> -		goto out;
> +#ifdef CONFIG_X86
> +	/* A quirk for https://www.amd.com/en/support/kb/faq/pa-410 */
> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
> +	    priv->sm != ACPI_TPM2_COMMAND_BUFFER_WITH_PLUTON) {
> +		dev_info(dev, "Disabling hwrng\n");
> +		chip->flags |= TPM_CHIP_FLAG_HWRNG_DISABLED;
> +	}
> +#endif /* CONFIG_X86 */
>  
>  	rc = tpm_chip_register(chip);
>  
> -- 
> 2.39.2
> 

