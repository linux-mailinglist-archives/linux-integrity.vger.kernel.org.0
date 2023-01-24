Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68066678F4C
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Jan 2023 05:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbjAXEgV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 23 Jan 2023 23:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjAXEgU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 Jan 2023 23:36:20 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471DA367EA;
        Mon, 23 Jan 2023 20:36:19 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id h5-20020a17090a9c0500b0022bb85eb35dso8530487pjp.3;
        Mon, 23 Jan 2023 20:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b8U31/JHK1SijUo9KNZPEWC0iXAuh3371iOKZ7pi7Bc=;
        b=W90qqbnL3dTHE2ye/e6FMaljY7HETG1lSjyj160P0TbMDriUzz1kKpEUmWDtWz4oEr
         wqi/vc9+WGKslLj1ar75bAKzXBjdBif4nE5AJIzEpCctiaurnH5iWGnjP0RZYNR/SEt3
         6PbuLYKU8VN0Coi0k29d/ZFZw8XQCf0fGBtaFrMj8SPawzghG/OTOCxz8MLe+zk3pJcq
         HusQm34LkSMgestXlQnlUjyix3VGKm5bTZo8ESfyXzK5hWB2VJQwEYl0QSgvnfff5SkN
         YEwLeMs2CZ7T6eE3EJdfZS8ak2uSeb931u3a9sQ9/x5/JZieGfr0czCT8JQZ8zOU3GwJ
         Y6+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b8U31/JHK1SijUo9KNZPEWC0iXAuh3371iOKZ7pi7Bc=;
        b=aqi8nngjtBpT40m/v6EodnCA4qeLIH3WYpxb8OmbVVVt6cdaNNqubjW+rmHbw791II
         DTkOSZDrfbm6MMFjE07cFkaYgbWlcfyNmlcnIVrGqEwQkshOTnYVtPjJsD0yBdVyzKSA
         9ywvMoDq8xksIE5ZUN8tX8akp563fvytCFnm1z2sT00lm2jkjTm6/J9W0dRLvv9IwMn+
         WLSwhZ1mlhl/h7E6VnGioJuPDZIR2xxOIstKNr61oUdaO1+tlZGKRpj8ky7IOJLBlmdt
         lw2eMWr8K/2xWIeeqQz6eIl8Ljy3tT9VIv3gUN4jAYKJUIEShlNa0SRivH/pR6FErpQW
         +CoA==
X-Gm-Message-State: AFqh2kr54kj42HiOcT5xYOxKlQIUHZNHCyvo4VMX78wdy/f2Mq00cmAI
        B1jobSCSflLux5Bps8t4ow5ennxE5Ug=
X-Google-Smtp-Source: AMrXdXuD6RDsupccsQ917UGoQ9sV7IX7GmlnFerU/q/bSmCF+jS1YWw4T/NrOM9TzeECVLYeCUIWYA==
X-Received: by 2002:a17:902:f2c5:b0:194:b745:5eaf with SMTP id h5-20020a170902f2c500b00194b7455eafmr20974064plc.42.1674534978795;
        Mon, 23 Jan 2023 20:36:18 -0800 (PST)
Received: from localhost (121-44-64-35.tpgi.com.au. [121.44.64.35])
        by smtp.gmail.com with ESMTPSA id c1-20020a170902aa4100b001960441f604sm520307plr.277.2023.01.23.20.36.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 20:36:18 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 24 Jan 2023 14:36:11 +1000
Message-Id: <CQ053TUZQIPP.1OHV7MVS4F4HT@bobo>
To:     "Andrew Donnellan" <ajd@linux.ibm.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-integrity@vger.kernel.org>
Cc:     <sudhakar@linux.ibm.com>, <bgray@linux.ibm.com>,
        <erichte@linux.ibm.com>, <gregkh@linuxfoundation.org>,
        <nayna@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
        <zohar@linux.ibm.com>, <gjoyce@linux.ibm.com>, <ruscur@russell.cc>,
        <gcwilson@linux.ibm.com>, <joel@jms.id.au>
Subject: Re: [PATCH v4 21/24] powerpc/pseries: Pass PLPKS password on kexec
From:   "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.13.0
References: <20230120074306.1326298-1-ajd@linux.ibm.com>
 <20230120074306.1326298-22-ajd@linux.ibm.com>
In-Reply-To: <20230120074306.1326298-22-ajd@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri Jan 20, 2023 at 5:43 PM AEST, Andrew Donnellan wrote:
> From: Russell Currey <ruscur@russell.cc>
>
> Before interacting with the PLPKS, we ask the hypervisor to generate a
> password for the current boot, which is then required for most further
> PLPKS operations.
>
> If we kexec into a new kernel, the new kernel will try and fail to
> generate a new password, as the password has already been set.
>
> Pass the password through to the new kernel via the device tree, in
> /chosen/plpks-pw. Check for the presence of this property before trying

In /chosen/ibm,plpks-pw

> to generate a new password - if it exists, use the existing password and
> remove it from the device tree.
>
> Signed-off-by: Russell Currey <ruscur@russell.cc>
> Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
>
> ---
>
> v3: New patch
>
> v4: Fix compile when CONFIG_PSERIES_PLPKS=3Dn (snowpatch)
>
>     Fix error handling on fdt_path_offset() call (ruscur)
> ---
>  arch/powerpc/kexec/file_load_64.c      | 18 ++++++++++++++++++
>  arch/powerpc/platforms/pseries/plpks.c | 18 +++++++++++++++++-
>  2 files changed, 35 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_=
load_64.c
> index af8854f9eae3..0c9130af60cc 100644
> --- a/arch/powerpc/kexec/file_load_64.c
> +++ b/arch/powerpc/kexec/file_load_64.c
> @@ -27,6 +27,7 @@
>  #include <asm/kexec_ranges.h>
>  #include <asm/crashdump-ppc64.h>
>  #include <asm/prom.h>
> +#include <asm/plpks.h>
> =20
>  struct umem_info {
>  	u64 *buf;		/* data buffer for usable-memory property */
> @@ -1156,6 +1157,9 @@ int setup_new_fdt_ppc64(const struct kimage *image,=
 void *fdt,
>  {
>  	struct crash_mem *umem =3D NULL, *rmem =3D NULL;
>  	int i, nr_ranges, ret;
> +#ifdef CONFIG_PSERIES_PLPKS
> +	int chosen_offset;
> +#endif

Could put this in plpks_is_available and avoid an ifdef.

> =20
>  	/*
>  	 * Restrict memory usage for kdump kernel by setting up
> @@ -1230,6 +1234,20 @@ int setup_new_fdt_ppc64(const struct kimage *image=
, void *fdt,
>  		}
>  	}
> =20
> +#ifdef CONFIG_PSERIES_PLPKS
> +	// If we have PLPKS active, we need to provide the password
> +	if (plpks_is_available()) {
> +		chosen_offset =3D fdt_path_offset(fdt, "/chosen");
> +		if (chosen_offset < 0) {
> +			pr_err("Can't find chosen node: %s\n",
> +			       fdt_strerror(chosen_offset));
> +			goto out;
> +		}
> +		ret =3D fdt_setprop(fdt, chosen_offset, "ibm,plpks-pw",
> +				  plpks_get_password(), plpks_get_passwordlen());
> +	}
> +#endif // CONFIG_PSERIES_PLPKS

I think if you define plpks_get_password and plpks_get_passwordlen as
BUILD_BUG_ON when PLPKS is not configured and plpks_is_available as
false, you could remove the ifdef entirely.

> +
>  out:
>  	kfree(rmem);
>  	kfree(umem);
> diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/platfo=
rms/pseries/plpks.c
> index b3c7410a4f13..0350f10e1755 100644
> --- a/arch/powerpc/platforms/pseries/plpks.c
> +++ b/arch/powerpc/platforms/pseries/plpks.c
> @@ -16,6 +16,7 @@
>  #include <linux/slab.h>
>  #include <linux/string.h>
>  #include <linux/types.h>
> +#include <linux/of.h>
>  #include <asm/hvcall.h>
>  #include <asm/machdep.h>
>  #include <asm/plpks.h>
> @@ -126,7 +127,22 @@ static int plpks_gen_password(void)
>  {
>  	unsigned long retbuf[PLPAR_HCALL_BUFSIZE] =3D { 0 };
>  	u8 *password, consumer =3D PLPKS_OS_OWNER;
> -	int rc;
> +	struct property *prop;
> +	int rc, len;
> +
> +	// Before we generate the password, we may have been booted by kexec an=
d
> +	// provided with a previous password.  Check for that first.

So not really generating the password then. Should it be in a different
function the caller makes first?

> +	prop =3D of_find_property(of_chosen, "ibm,plpks-pw", &len);
> +	if (prop) {
> +		ospasswordlength =3D (u16)len;
> +		ospassword =3D kzalloc(ospasswordlength, GFP_KERNEL);
> +		if (!ospassword) {
> +			of_remove_property(of_chosen, prop);
> +			return -ENOMEM;
> +		}
> +		memcpy(ospassword, prop->value, len);
> +		return of_remove_property(of_chosen, prop);

Why do you remove the property afterward?

Thanks,
Nick
