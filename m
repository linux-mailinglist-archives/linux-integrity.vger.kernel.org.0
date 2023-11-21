Return-Path: <linux-integrity+bounces-143-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D157F2B15
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Nov 2023 11:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E819B281F39
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Nov 2023 10:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2062E47798;
	Tue, 21 Nov 2023 10:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C6F95;
	Tue, 21 Nov 2023 02:57:31 -0800 (PST)
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-359c22c44d6so21160225ab.2;
        Tue, 21 Nov 2023 02:57:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700564250; x=1701169050;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=275NNRvCjAO9MfskKw5eBeJLyzoXsC+6zY6o9BDDJwU=;
        b=sGWyVWovcNjQ8bKaV/flaSpF+n4ILKtZLqhfE0h57ln3mIR6q3UesETPREM9qB4GpN
         WPSrFAu+v3p8M89zvBbFkKAbrikrXfh4c6PCpAZB2t3gqNk/vbXcb+s+rJiME4vzo9sO
         A95kRSuiLaBmjSdgvkBtOW/xq33oae9kjd6wyIANoU0l27IvHPTThfW3uj1qpil4sQXk
         X5eaTl7I0r7YP9KgkOii2IniP7s6QRwSTX8tbvEMTknCIE2fgdPZM2G1We2pav1YHnv9
         LZXIo4P1uSNmen908IHudGjvJLGhiGhnGaDlQJJT6dp84Uw30oX3nEmjFccyDUE8wqZR
         2rhg==
X-Gm-Message-State: AOJu0Yw+lgxuwm+s8g2Y572yZ8zANXpTmJdArx3hM0LIXvXtJyR6rmZC
	eikTOPMqVxXUT5jRx+I27w==
X-Google-Smtp-Source: AGHT+IEeASNMUwxHBJXGwFk4lyfiW/w5Qgbe6Q5LG8gmGgOc/QECSNxA1bvdwqZDxF21QLYN0aBVbg==
X-Received: by 2002:a05:6e02:188c:b0:359:d397:c806 with SMTP id o12-20020a056e02188c00b00359d397c806mr16028462ilu.18.1700564250694;
        Tue, 21 Nov 2023 02:57:30 -0800 (PST)
Received: from herring.priv ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id bp27-20020a056e02349b00b0035268f0794dsm3147658ilb.18.2023.11.21.02.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 02:57:30 -0800 (PST)
Received: (nullmailer pid 1245591 invoked by uid 1000);
	Tue, 21 Nov 2023 10:57:21 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, linux-integrity@vger.kernel.org, devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, Lino Sanfilippo <LinoSanfilippo@gmx.de>, Rob Herring <robh+dt@kernel.org>
In-Reply-To: <ad4b484da8190c83902b2525823ceb3439a7576e.1700555862.git.lukas@wunner.de>
References: <cover.1700555862.git.lukas@wunner.de>
 <ad4b484da8190c83902b2525823ceb3439a7576e.1700555862.git.lukas@wunner.de>
Message-Id: <170056424078.1245511.3802928266274347339.robh@kernel.org>
Subject: Re: [PATCH 3/3] dt-bindings: tpm: Document Microsoft fTPM bindings
Date: Tue, 21 Nov 2023 03:57:21 -0700


On Tue, 21 Nov 2023 10:48:43 +0100, Lukas Wunner wrote:
> A driver for Microsoft's firmware-based Trusted Platform Module (fTPM)
> was merged with commit 09e574831b27 ("tpm/tpm_ftpm_tee: A driver for
> firmware TPM running inside TEE"), but its devicetree bindings were not.
> 
> This is the only remaining undocumented compatible string for a TPM,
> so add a DT schema based on the patch linked below.
> 
> Link: https://lore.kernel.org/all/20190409184958.7476-2-sashal@kernel.org/
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>  .../bindings/tpm/microsoft,ftpm.yaml          | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/tpm/microsoft,ftpm.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/tpm/microsoft,ftpm.example.dtb: tpm: Unevaluated properties are not allowed ('linux,sml-base', 'linux,sml-size' were unexpected)
	from schema $id: http://devicetree.org/schemas/tpm/microsoft,ftpm.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/ad4b484da8190c83902b2525823ceb3439a7576e.1700555862.git.lukas@wunner.de

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


