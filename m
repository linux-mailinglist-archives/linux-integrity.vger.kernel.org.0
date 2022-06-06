Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3059E53E058
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Jun 2022 06:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiFFEHY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Jun 2022 00:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiFFEHS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Jun 2022 00:07:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DA1EE7659
        for <linux-integrity@vger.kernel.org>; Sun,  5 Jun 2022 21:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654488430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MuRk3Tab2Z4ZRUgMYXS0prZ+jhG+XkNVjb1ON2n0G3E=;
        b=YheZEg1blcTa5T0Eu2IprNpZ66mtKMVAR1qrZlUxL+z0LGs72SuD1wVTsPaFhksNnro3KO
        zTSB1FzbN83lTi01dzfnFMq/W5jBv0phQzLK5F2LqSfemED+nZp67OThFQOK2ZSwBBGte6
        6VSk+vp1e7lpqv/3niAeGDFCZHBTgVY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-9-f6LMyBluPuqPdnmQJ73N8A-1; Mon, 06 Jun 2022 00:06:58 -0400
X-MC-Unique: f6LMyBluPuqPdnmQJ73N8A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4BADC811E83;
        Mon,  6 Jun 2022 04:06:57 +0000 (UTC)
Received: from localhost (ovpn-12-209.pek2.redhat.com [10.72.12.209])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D67A40E80E0;
        Mon,  6 Jun 2022 04:06:55 +0000 (UTC)
Date:   Mon, 6 Jun 2022 12:06:51 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Jonathan McDowell <noodles@fb.com>, Coiby Xu <coxu@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v4] x86/kexec: Carry forward IMA measurement log on kexec
Message-ID: <Yp19W4/ZQm/8U+BG@MiWiFi-R3L-srv>
References: <YmKyvlF3my1yWTvK@noodles-fedora-PC23Y6EG>
 <YmgjXZphkmDKgaOA@noodles-fedora-PC23Y6EG>
 <YnuJCH75GrhVm0Tp@noodles-fedora.dhcp.thefacebook.com>
 <Yn01Cfb3Divf49g7@noodles-fedora.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yn01Cfb3Divf49g7@noodles-fedora.dhcp.thefacebook.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 05/12/22 at 04:25pm, Jonathan McDowell wrote:
> On kexec file load Integrity Measurement Architecture (IMA) subsystem
> may verify the IMA signature of the kernel and initramfs, and measure
> it. The command line parameters passed to the kernel in the kexec call
> may also be measured by IMA. A remote attestation service can verify
> a TPM quote based on the TPM event log, the IMA measurement list, and
> the TPM PCR data. This can be achieved only if the IMA measurement log
> is carried over from the current kernel to the next kernel across
> the kexec call.
> 
> powerpc and ARM64 both achieve this using device tree with a
> "linux,ima-kexec-buffer" node. x86 platforms generally don't make use of
> device tree, so use the setup_data mechanism to pass the IMA buffer to
> the new kernel.

The entire looks good to me, other than a minor concern, please see the
inline comment.

Reviewed-by: Baoquan He <bhe@redhat.com>

Hi Coiby,

You can check this patch, see if you can take the same way to solve the
LUKS-encrypted disk issue by passing the key via setup_data.

> 
> Signed-off-by: Jonathan McDowell <noodles@fb.com>
> ---
......snip...

> diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
> index 170d0fd68b1f..54bd4ce5f908 100644
> --- a/arch/x86/kernel/kexec-bzimage64.c
> +++ b/arch/x86/kernel/kexec-bzimage64.c
> @@ -186,6 +186,33 @@ setup_efi_state(struct boot_params *params, unsigned long params_load_addr,
>  }
>  #endif /* CONFIG_EFI */
>  
> +static void
> +setup_ima_state(const struct kimage *image, struct boot_params *params,
> +		unsigned long params_load_addr,
> +		unsigned int ima_setup_data_offset)
> +{
> +#ifdef CONFIG_IMA_KEXEC
> +	struct setup_data *sd = (void *)params + ima_setup_data_offset;
> +	unsigned long setup_data_phys;
> +	struct ima_setup_data *ima;
> +
> +	if (!image->ima_buffer_size)
> +		return;
> +
> +	sd->type = SETUP_IMA;
> +	sd->len = sizeof(*ima);
> +
> +	ima = (void *)sd + sizeof(struct setup_data);
> +	ima->addr = image->ima_buffer_addr;
> +	ima->size = image->ima_buffer_size;
> +
> +	/* Add setup data */
> +	setup_data_phys = params_load_addr + ima_setup_data_offset;
> +	sd->next = params->hdr.setup_data;
> +	params->hdr.setup_data = setup_data_phys;
> +#endif /* CONFIG_IMA_KEXEC */
> +}
> +
>  static int
>  setup_boot_parameters(struct kimage *image, struct boot_params *params,
>  		      unsigned long params_load_addr,
> @@ -247,6 +274,13 @@ setup_boot_parameters(struct kimage *image, struct boot_params *params,
>  	setup_efi_state(params, params_load_addr, efi_map_offset, efi_map_sz,
>  			efi_setup_data_offset);
>  #endif
> +
> +	/* Setup IMA log buffer state */
> +	setup_ima_state(image, params, params_load_addr,
> +			efi_setup_data_offset +
> +			sizeof(struct setup_data) +
> +			sizeof(struct efi_setup_data));

Is it a little better to update efi_setup_data_offset beforehand, or
define a local variable?

	efi_setup_data_offset += sizeof(struct setup_data) + sizeof(struct efi_setup_data));
	setup_ima_state(image, params, params_load_addr,
			efi_setup_data_offset));

No strong opinion. If nobody has concern about it.

> +
>  	/* Setup EDD info */
>  	memcpy(params->eddbuf, boot_params.eddbuf,
>  				EDDMAXNR * sizeof(struct edd_info));

