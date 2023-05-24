Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15DB971012E
	for <lists+linux-integrity@lfdr.de>; Thu, 25 May 2023 00:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjEXW5O (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 May 2023 18:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjEXW5N (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 May 2023 18:57:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4C7A9
        for <linux-integrity@vger.kernel.org>; Wed, 24 May 2023 15:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684968986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k1Jcq95wsHIqLNg9wbmmJlT15+6EzUdpG8ilf/jMgQ8=;
        b=YK+qnrCTP8ByBFJjvr6gI48dutejVK7ZpLhAb2iwEcqMLQB1NPA6OY39gDHe8CZcc7dcW4
        PTpJnPlW/Skhsn7+A8ILvHzsyvbu71uynHkJl9+Kzwt6IZLwxtkuTMxib8ZF55FVoHLjDI
        0pvY95F6wjl3e9K1B66M1rajjsRM9NE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-AYPCbqpFMXOYqNIwRqQf-A-1; Wed, 24 May 2023 18:56:24 -0400
X-MC-Unique: AYPCbqpFMXOYqNIwRqQf-A-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-3f6a856ae6aso6647441cf.0
        for <linux-integrity@vger.kernel.org>; Wed, 24 May 2023 15:56:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684968984; x=1687560984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1Jcq95wsHIqLNg9wbmmJlT15+6EzUdpG8ilf/jMgQ8=;
        b=AZfCink2hfVNYzh0mq9x/nbxIz3lQcHdRzXHK0Col8QNpn7F8ZgeBaGx/ZbTWHwHAA
         P4tjtgIODhdEykehAHTRlA2WgRPjLk8usg43fi9d0aJwfKhIRSqFLcLemASpbEXPj7nr
         bIxh4birUV/Lr59pcZSoTuj83gGfW6whG+CvGsNxLiW8PQ1DndN9TY0AC9sPfLfU6SYM
         okm4nbhTcgQIJsblBZXhSamEOQoPie6Eivzn+saNX0Ocl2CCm+/nWdf35Oc9L1WIYKDU
         3U/R+LYjC9DKcZ4N5sKJklK9YtdMPI4AxE16nZyMloS0Yh74txAXrUBogWeHVsF1BLRT
         t2Rg==
X-Gm-Message-State: AC+VfDzfOq30jQcHaEDtd4O8yWxaADefvFtSycPFx9l79A9rxYvAPgcE
        tOJwBIMY9k8yrnpfn7/N8e+POLM+nFNaJupZYSGM4eQojdNpuz6DiZpoq+EIG8oacI6XNnEsMjl
        rQEK2s4akmRWKL676mPpl05NXANiU
X-Received: by 2002:ac8:7c54:0:b0:3f6:b7a3:8450 with SMTP id o20-20020ac87c54000000b003f6b7a38450mr11325806qtv.64.1684968984358;
        Wed, 24 May 2023 15:56:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6YIOLa22uHsyvn/hEoIII2YehPLAhvw1u1EoIWqYO1cyYh5aCnNjvQkCcKdtrNBcB8QhnYhA==
X-Received: by 2002:ac8:7c54:0:b0:3f6:b7a3:8450 with SMTP id o20-20020ac87c54000000b003f6b7a38450mr11325796qtv.64.1684968984135;
        Wed, 24 May 2023 15:56:24 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id u7-20020a05622a010700b003f6a8379fa4sm3555602qtw.70.2023.05.24.15.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 15:56:23 -0700 (PDT)
Date:   Wed, 24 May 2023 15:56:21 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     kexec@lists.infradead.org, devicetree@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, nayna@linux.ibm.com,
        nasastry@in.ibm.com, mpe@ellerman.id.au,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Rob Herring <robh@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [PATCH v9 1/4] drivers: of: kexec ima: Support 32-bit platforms
Message-ID: <a2dx66ug4gnbokit35in5c2qjsq2fcewtw35bwknnsav4pw2ee@c3s4wsbszeyb>
References: <20230418134409.177485-1-stefanb@linux.ibm.com>
 <20230418134409.177485-2-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418134409.177485-2-stefanb@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Apr 18, 2023 at 09:44:06AM -0400, Stefan Berger wrote:
> From: Palmer Dabbelt <palmer@rivosinc.com>
> 
> RISC-V recently added kexec_file() support, which uses enables kexec
> IMA.  We're the first 32-bit platform to support this, so we found a
> build bug.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

> ---
>  drivers/of/kexec.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
> index f26d2ba8a371..1373d7e0a9b3 100644
> --- a/drivers/of/kexec.c
> +++ b/drivers/of/kexec.c
> @@ -250,8 +250,8 @@ static int setup_ima_buffer(const struct kimage *image, void *fdt,
>  	if (ret)
>  		return -EINVAL;
>  
> -	pr_debug("IMA buffer at 0x%llx, size = 0x%zx\n",
> -		 image->ima_buffer_addr, image->ima_buffer_size);
> +	pr_debug("IMA buffer at 0x%pa, size = 0x%zx\n",
> +		 &image->ima_buffer_addr, image->ima_buffer_size);
>  
>  	return 0;
>  }
> -- 
> 2.38.1
> 

