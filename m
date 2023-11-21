Return-Path: <linux-integrity+bounces-149-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 032E87F334B
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Nov 2023 17:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 865CCB210CB
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Nov 2023 16:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8DD5917A;
	Tue, 21 Nov 2023 16:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77223126;
	Tue, 21 Nov 2023 08:10:29 -0800 (PST)
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7b09035b850so170356439f.3;
        Tue, 21 Nov 2023 08:10:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700583029; x=1701187829;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zz4YwN0potTjrBEf6+oxarC/wn8cZfRVKDwYN1pUfTU=;
        b=nQDvrCq7/PhVtr2bKTpE2C2puD+84yWuNgq40UTHAHkdLp2g/K3EKuerhAwDbyaEcI
         AinWOryv1x9GKuPXW0q3wpx4jrXeIsuKZmQJlk8Rp75hAyHPjGxY2mPElIX8IsqVHLeY
         67riiGm7vMEfq2kTwtThkzB1e8fSJJK0Clu/4m0VAxrm8K0gD6egDxanWQQ/1bFE7w2c
         5aAI1K1ZXMQn469v577+Iox05/JVT0PKraaMBWaiaJ075+Qnf7cg6DxQjgrI4e0RxsTF
         j/JgOzaLAGbzb85RtHk86XtmcHVp1QFPuXHxnMhFJYNqs3PIKR31kwoez6oIatg94SfE
         AmYw==
X-Gm-Message-State: AOJu0Yx3whiIMLxJmRTONihjGLtKaJbnXsxGWAyyMvL2eF//AP/x6W2G
	xSJkGJLHMEE7iIS1RsC3WA==
X-Google-Smtp-Source: AGHT+IGr009kMq89balOASHNC0PrzqqFtcjoasDVSTwBCPPkpTpppJGTWdRPv6RUn85v2aCo+d41/w==
X-Received: by 2002:a05:6602:1249:b0:7a9:571c:5694 with SMTP id o9-20020a056602124900b007a9571c5694mr13196281iou.10.1700583028623;
        Tue, 21 Nov 2023 08:10:28 -0800 (PST)
Received: from herring.priv ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id y22-20020a5d94d6000000b00790b6b9d14bsm2894544ior.49.2023.11.21.08.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 08:10:28 -0800 (PST)
Received: (nullmailer pid 1930865 invoked by uid 1000);
	Tue, 21 Nov 2023 16:10:26 -0000
Date: Tue, 21 Nov 2023 09:10:26 -0700
From: Rob Herring <robh@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, linux-integrity@vger.kernel.org, Lino Sanfilippo <LinoSanfilippo@gmx.de>
Subject: Re: [PATCH 0/3] dt-bindings: tpm: Clean all the things
Message-ID: <20231121161026.GC1845293-robh@kernel.org>
References: <cover.1700555862.git.lukas@wunner.de>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1700555862.git.lukas@wunner.de>

On Tue, Nov 21, 2023 at 10:48:40AM +0100, Lukas Wunner wrote:
> Rob asked me to consolidate and convert the TPM dt-bindings:
> https://lore.kernel.org/all/20230927115300.GA1587935-robh@kernel.org/
> 
> I came across several issues:
> 
> First, this pull request is needed to cope with ibm,#dma-address-cells
> and ibm,#dma-size-cells properties used in ibm,vtpm.yaml:
> 
>   https://github.com/devicetree-org/dt-schema/pull/116

Now applied.


> Second, the compatible string "google,cr50" refers to a chip which has
> both an i2c and an spi interface (see drivers/char/tpm/tpm_tis_i2c_cr50.c
> as well as tpm_tis_spi_main.c)  This confuses the schema validator
> because it thinks that "google,cr50" may only use i2c properties but
> tcg,tpm_tis-spi.yaml contains an spi example, which causes some warnings.
> It seems deeper code changes to the schema validator are required to
> avoid them:
> 
>   Documentation/devicetree/bindings/tpm/tcg,tpm_tis-spi.example.dtb: tpm@0: compatible:1: 'tcg,tpm-tis-i2c' was expected
>   from schema $id: http://devicetree.org/schemas/tpm/tcg,tpm-tis-i2c.yaml#
>   Documentation/devicetree/bindings/tpm/tcg,tpm_tis-spi.example.dtb: tpm@0: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency' were unexpected)
>   from schema $id: http://devicetree.org/schemas/tpm/tcg,tpm-tis-i2c.yaml#

You either need to put "google,cr50" into its own schema file with a 
custom 'select' that omits the generic compatibles or the spi and i2c 
schemas need a custom select omitting "google,cr50" or having just the 
generic compatible. 

However, none of the current users of "google,cr50" have a fallback 
compatible, so perhaps its own schema file with no fallback is the 
answer. Is the fallback useful and is it worth updating all the users? 
Probably not since we have to keep support for "google,cr50" explicitly 
in the driver.


> Third, the schema validator raises warnings about three properties
> I've defined in tpm-common.yaml:  "linux,sml-base" and "linux,sml-size"
> are nested in a oneOf/allOf clause and "lpcpd-gpios" is nested in an
> allOf/if-then clause.  This seems to confuse the validator:
> 
>   Documentation/devicetree/bindings/tpm/tcg,tpm-tis-i2c.example.dtb: tpm@57: Unevaluated properties are not allowed ('linux,sml-base', 'linux,sml-size' were unexpected)
>   from schema $id: http://devicetree.org/schemas/tpm/tcg,tpm-tis-i2c.yaml#

Should be fixed with my suggestion in patch 1.

>   Documentation/devicetree/bindings/tpm/tcg,tpm-tis-i2c.example.dtb: tpm@13: Unevaluated properties are not allowed ('lpcpd-gpios' was unexpected)
>   from schema $id: http://devicetree.org/schemas/tpm/tcg,tpm-tis-i2c.yaml#

The issue is here:

+      properties:
+        compatible:
+          contains:
+            const: st,st33zp24

That's an exact match, not a pattern. You could do 'pattern: '^st,st33zp24'
or an enum with both compatible strings.

Rob

