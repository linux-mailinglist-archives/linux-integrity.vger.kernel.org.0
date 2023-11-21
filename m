Return-Path: <linux-integrity+bounces-141-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E8C7F2B0D
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Nov 2023 11:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9463D281A3C
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Nov 2023 10:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5444778D;
	Tue, 21 Nov 2023 10:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A66CA;
	Tue, 21 Nov 2023 02:57:24 -0800 (PST)
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7a66b5f7ea7so168468239f.2;
        Tue, 21 Nov 2023 02:57:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700564244; x=1701169044;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7lBKRP1MxbrcZ6sLlvoLF/nznFoEzDVIPNY03KLacE0=;
        b=J5W8bzJaZpIz6THr5ChuyjPH6aXgMbKc8+zQET40fhdxJp74gq76Gqab+rbNaUcR//
         sIE5RrjIGblK+NI+i868qmbuS44Ofy4H13egwE0Y+ljSF26dojCp1os51ctDLDDELiMj
         eK5ODUKIvvhLlo8W4E07F05CGiuwAk/fTCzEEl5SoE8vlcdeFy+2NMy3kMXOpi14fBsc
         +q2sF1a6d6oDcQocHb0bcSdiY1+xUto3gcMgGNjZtlHX7aLqecU7fZZUTxLKp/B8JD+g
         TIJWBTOMjX71QdKZtUemLOBZf7poIJE5zrh2QLOEXvyr5iwACu6vC3V7PZWaWSTSDuI8
         VQ5g==
X-Gm-Message-State: AOJu0YxQklIQN7Q6Yb4OV2SKZkGphFn87Pr1btE5H1G0Mfn/dR+IHbYL
	BG76lh3jXUGhfqeYF9tWV171XMTYhQ==
X-Google-Smtp-Source: AGHT+IFun/3IS8RH+ueLcjovySYxC6yq11jY8GXJt9NgRYRkdxUsojgypHI/OYJ6wj6Tc7Re0CYYgA==
X-Received: by 2002:a92:7609:0:b0:357:f5d4:9b12 with SMTP id r9-20020a927609000000b00357f5d49b12mr11703618ilc.15.1700564243744;
        Tue, 21 Nov 2023 02:57:23 -0800 (PST)
Received: from herring.priv ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id bk4-20020a056e02328400b003596a440efasm3142487ilb.19.2023.11.21.02.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 02:57:23 -0800 (PST)
Received: (nullmailer pid 1245586 invoked by uid 1000);
	Tue, 21 Nov 2023 10:57:21 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-integrity@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh+dt@kernel.org>, Lino Sanfilippo <LinoSanfilippo@gmx.de>, devicetree@vger.kernel.org
In-Reply-To: <e83a43a67c96b4f2614f029666209cb408da8678.1700555862.git.lukas@wunner.de>
References: <cover.1700555862.git.lukas@wunner.de>
 <e83a43a67c96b4f2614f029666209cb408da8678.1700555862.git.lukas@wunner.de>
Message-Id: <170056423883.1245414.13982600686594579960.robh@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: tpm: Consolidate TCG TIS bindings
Date: Tue, 21 Nov 2023 03:57:21 -0700


On Tue, 21 Nov 2023 10:48:41 +0100, Lukas Wunner wrote:
> A significant number of Trusted Platform Modules conform to the "TIS"
> specification published by the Trusted Computing Group ("TCG PC Client
> Specific TPM Interface Specification").  These chips typically use an
> SPI, I²C or LPC bus as transport (via MMIO in the latter case).  Some
> of them even support multiple of those buses (selectable through a
> config strap) or the same chip is available in multiple SKUs, each with
> a different bus interface.
> 
> The devicetree bindings for these TPMs have not been converted to DT
> schema yet and are spread out across 3 generic files and 3 chip-specific
> files.  A few TPM compatible strings were added to trivial-devices.yaml
> even though additional properties are documented in the plaintext
> bindings.
> 
> Consolidate the devicetree bindings into 3 files, one per bus.
> 
> Move common properties to a separate tpm-common.yaml.
> 
> Document compatible strings which are supported by the TPM TIS driver
> but were neglected to be added to the devicetree bindings.
> 
> Document the memory-region property recently introduced by commit
> 1e2714bb83fc ("tpm: Add reserved memory event log").
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>  .../bindings/security/tpm/google,cr50.txt     |  19 ----
>  .../bindings/security/tpm/st33zp24-i2c.txt    |  34 ------
>  .../bindings/security/tpm/st33zp24-spi.txt    |  32 ------
>  .../bindings/security/tpm/tpm-i2c.txt         |  26 -----
>  .../bindings/security/tpm/tpm_tis_mmio.txt    |  25 ----
>  .../bindings/security/tpm/tpm_tis_spi.txt     |  23 ----
>  .../bindings/tpm/tcg,tpm-tis-i2c.yaml         | 107 ++++++++++++++++++
>  .../bindings/tpm/tcg,tpm-tis-mmio.yaml        |  50 ++++++++
>  .../bindings/tpm/tcg,tpm_tis-spi.yaml         |  88 ++++++++++++++
>  .../devicetree/bindings/tpm/tpm-common.yaml   |  56 +++++++++
>  .../devicetree/bindings/trivial-devices.yaml  |  16 ---
>  11 files changed, 301 insertions(+), 175 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/security/tpm/google,cr50.txt
>  delete mode 100644 Documentation/devicetree/bindings/security/tpm/st33zp24-i2c.txt
>  delete mode 100644 Documentation/devicetree/bindings/security/tpm/st33zp24-spi.txt
>  delete mode 100644 Documentation/devicetree/bindings/security/tpm/tpm-i2c.txt
>  delete mode 100644 Documentation/devicetree/bindings/security/tpm/tpm_tis_mmio.txt
>  delete mode 100644 Documentation/devicetree/bindings/security/tpm/tpm_tis_spi.txt
>  create mode 100644 Documentation/devicetree/bindings/tpm/tcg,tpm-tis-i2c.yaml
>  create mode 100644 Documentation/devicetree/bindings/tpm/tcg,tpm-tis-mmio.yaml
>  create mode 100644 Documentation/devicetree/bindings/tpm/tcg,tpm_tis-spi.yaml
>  create mode 100644 Documentation/devicetree/bindings/tpm/tpm-common.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/tpm/tpm-common.yaml: properties:oneOf: [{'memory-region': {'description': 'reserved memory allocated for firmware event log', 'maxItems': 1}}, {'allOf': [{'linux,sml-base': {'description': 'base address of reserved memory allocated for firmware event log', '$ref': '/schemas/types.yaml#/definitions/uint32-array', 'minItems': 2, 'maxItems': 2}}, {'linux,sml-size': {'description': 'size of reserved memory allocated for firmware event log', '$ref': '/schemas/types.yaml#/definitions/uint32'}}]}] is not of type 'object', 'boolean'
	from schema $id: http://json-schema.org/draft-07/schema#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/tpm/tpm-common.yaml: properties: 'oneOf' should not be valid under {'$ref': '#/definitions/json-schema-prop-names'}
	hint: A json-schema keyword was found instead of a DT property name.
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/tpm/tpm-common.yaml: properties:oneOf: [{'memory-region': {'description': 'reserved memory allocated for firmware event log', 'maxItems': 1}}, {'allOf': [{'linux,sml-base': {'description': 'base address of reserved memory allocated for firmware event log', '$ref': '/schemas/types.yaml#/definitions/uint32-array', 'minItems': 2, 'maxItems': 2}}, {'linux,sml-size': {'description': 'size of reserved memory allocated for firmware event log', '$ref': '/schemas/types.yaml#/definitions/uint32'}}]}] is not of type 'object', 'boolean'
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/tpm/tpm-common.yaml: powered-while-suspended: missing type definition
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/tpm/tcg,tpm_tis-spi.example.dtb: tpm@0: compatible:1: 'tcg,tpm-tis-i2c' was expected
	from schema $id: http://devicetree.org/schemas/tpm/tcg,tpm-tis-i2c.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/tpm/tcg,tpm_tis-spi.example.dtb: tpm@0: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency' were unexpected)
	from schema $id: http://devicetree.org/schemas/tpm/tcg,tpm-tis-i2c.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/tpm/tcg,tpm_tis-spi.example.dtb: tpm@0: Unevaluated properties are not allowed ('lpcpd-gpios' was unexpected)
	from schema $id: http://devicetree.org/schemas/tpm/tcg,tpm_tis-spi.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/tpm/tcg,tpm-tis-i2c.example.dtb: tpm@57: Unevaluated properties are not allowed ('linux,sml-base', 'linux,sml-size' were unexpected)
	from schema $id: http://devicetree.org/schemas/tpm/tcg,tpm-tis-i2c.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/tpm/tcg,tpm-tis-i2c.example.dtb: tpm@13: Unevaluated properties are not allowed ('lpcpd-gpios' was unexpected)
	from schema $id: http://devicetree.org/schemas/tpm/tcg,tpm-tis-i2c.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/e83a43a67c96b4f2614f029666209cb408da8678.1700555862.git.lukas@wunner.de

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


