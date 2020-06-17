Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E21161FD635
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jun 2020 22:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbgFQUn2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Jun 2020 16:43:28 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34760 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbgFQUn1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Jun 2020 16:43:27 -0400
Received: by mail-io1-f65.google.com with SMTP id m81so4574840ioa.1;
        Wed, 17 Jun 2020 13:43:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=emJpJjtrMEqB2UXVQWJGyVmpIt4i0tBG2sjF9wqyg6s=;
        b=lc5B7tRhJGDdbMFm2QSG6dnzrjGuD5l5poYtmeh4CTduzLGiS0dUmdEGdgO8hsbtb9
         fzRq00NP2OJzklCvpfvqvyiMmfWfu7RxnADUMobKwEhkMsrN70RJb668ZieH8FIApKZ1
         CZicwgJqPUGEUnMSeAtH01IsgPmsaq/IZWmDTtCDJaMRr2DuGeHt/RVbfmGnD0rmIYFq
         EMAAv7q+xjnstOCZMkVBUsoDwpj8P+7enirg0nMy/Zcl6HpG/KXEvzScRKwN8BadeEdI
         eh2sS7OmXh+W0IjdeaVb/wM9xwcIS9n7zhWJOmB9qyXWMXf8dt/IhEMCnfU/1Rly98lA
         sucA==
X-Gm-Message-State: AOAM530MkJpdLqYVEObwVd0h+0kABxEPhVoPbbubliH+GeA1jMxhkROx
        4MzP9xkR6CozOL1Ln2tU+Q==
X-Google-Smtp-Source: ABdhPJx6D38aHYbkc7/7zEd9UCiEIZ/iKJdovV7uWe+2O6ZR5TDlocKXFkMaZH8WNeCz6fnzzMumHw==
X-Received: by 2002:a5d:9d03:: with SMTP id j3mr1328409ioj.176.1592426606820;
        Wed, 17 Jun 2020 13:43:26 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id c20sm499812iot.33.2020.06.17.13.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 13:43:26 -0700 (PDT)
Received: (nullmailer pid 2766741 invoked by uid 1000);
        Wed, 17 Jun 2020 20:43:24 -0000
Date:   Wed, 17 Jun 2020 14:43:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Prakhar Srivastava <prsriva@linux.microsoft.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, frowand.list@gmail.com, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        kstewart@linuxfoundation.org, takahiro.akashi@linaro.org,
        tglx@linutronix.de, vincenzo.frascino@arm.com,
        mark.rutland@arm.com, masahiroy@kernel.org, james.morse@arm.com,
        bhsharma@redhat.com, mbrugger@suse.com, hsinyi@chromium.org,
        tao.li@vivo.com, christophe.leroy@c-s.fr,
        gregkh@linuxfoundation.org, nramas@linux.microsoft.com,
        tusharsu@linux.microsoft.com, balajib@linux.microsoft.com
Subject: Re: [v1 PATCH 2/2] Add Documentation regarding the ima-kexec-buffer
 node in the chosen node documentation
Message-ID: <20200617204324.GA2740878@bogus>
References: <20200607233323.22375-1-prsriva@linux.microsoft.com>
 <20200607233323.22375-3-prsriva@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200607233323.22375-3-prsriva@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Jun 07, 2020 at 04:33:23PM -0700, Prakhar Srivastava wrote:
> Add Documentation regarding the ima-kexec-buffer node in
>  the chosen node documentation

Run 'git log --oneline Documentation/devicetree/bindings/chosen.txt' and 
write $subject using the dominate format used.

For the commit message, answer why you need the change, not what the 
change is. I can read the diff for that.

>  
> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> ---
>  Documentation/devicetree/bindings/chosen.txt | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)

This file has moved to a schema here[1]. You need to update it.

> 
> diff --git a/Documentation/devicetree/bindings/chosen.txt b/Documentation/devicetree/bindings/chosen.txt
> index 45e79172a646..a15f70c007ef 100644
> --- a/Documentation/devicetree/bindings/chosen.txt
> +++ b/Documentation/devicetree/bindings/chosen.txt
> @@ -135,3 +135,20 @@ e.g.
>  		linux,initrd-end = <0x82800000>;
>  	};
>  };
> +
> +linux,ima-kexec-buffer
> +----------------------
> +
> +This property(currently used by powerpc, arm64) holds the memory range,
> +the address and the size, of the IMA measurement logs that are being carried
> +over to the kexec session.

What's IMA? 

> +
> +/ {
> +	chosen {
> +		linux,ima-kexec-buffer = <0x9 0x82000000 0x0 0x00008000>;
> +	};
> +};
> +
> +This porperty does not represent real hardware, but the memory allocated for

typo

> +carrying the IMA measurement logs. The address and the suze are expressed in

typo

> +#address-cells and #size-cells, respectively of the root node.
> -- 
> 2.25.1
> 


[1] https://github.com/devicetree-org/dt-schema/blob/master/schemas/chosen.yaml

