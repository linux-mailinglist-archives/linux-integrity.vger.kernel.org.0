Return-Path: <linux-integrity+bounces-150-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CCB7F337B
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Nov 2023 17:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8C2EB21E9D
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Nov 2023 16:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B7C5A0EC;
	Tue, 21 Nov 2023 16:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E3A112;
	Tue, 21 Nov 2023 08:19:28 -0800 (PST)
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7b350130c3fso10750339f.3;
        Tue, 21 Nov 2023 08:19:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700583567; x=1701188367;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nE8sgQxfoX8+3TQJMVpH7ghLRxaJtxNYH11teP3dimk=;
        b=L58Ngcx6ptZ5/CWpHYuK2aFABjfvTjwmuNqjsBYkjZwGtiV/gyvluQuAE4VwtfTQKG
         J0q6ASUHmmHRfksqwxGyYvyKZfeYfdCV3mhFeNnvXmujfUJOWPadoO6ciHfOlqBaxQAa
         qQSSl+s2eEDy2zWH9rPEOTlaKMlMll1x60zjTMrW4cm7hinJxU9zTcG6y8y6DH3rysf6
         ygAQ0hZyLqrar3Qnqpg46BKC3pfmIgoL6YMq7vr8grYbRQy2A71V5V4k0pBr4rWGNGVC
         JPlsKIXkepU/DIuAcMcFfd2DkmLun/W+MqyomeMaJBuw5Tg1s1kyaFmrwyduZvrAwoZ6
         TT0A==
X-Gm-Message-State: AOJu0YyycyBOtQetOcPZPkc3CI/mEYKVw9OHh2tLUftc4BC3TRpuJibG
	YVv+y5AK54ZZQkz2g4GnjQ==
X-Google-Smtp-Source: AGHT+IGVvRlwp8BS7ldPf+BO5WVnnxEQt8lmTreBF2552SQlA/Toi8v4GDwoepsf6Hgxt+O0w96DGw==
X-Received: by 2002:a6b:c545:0:b0:7b0:ae77:36ed with SMTP id v66-20020a6bc545000000b007b0ae7736edmr9471049iof.13.1700583567285;
        Tue, 21 Nov 2023 08:19:27 -0800 (PST)
Received: from herring.priv ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id l21-20020a056638221500b00458ce1c9995sm2703124jas.24.2023.11.21.08.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 08:19:26 -0800 (PST)
Received: (nullmailer pid 2000251 invoked by uid 1000);
	Tue, 21 Nov 2023 16:19:25 -0000
Date: Tue, 21 Nov 2023 09:19:25 -0700
From: Rob Herring <robh@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, linux-integrity@vger.kernel.org, Lino Sanfilippo <LinoSanfilippo@gmx.de>
Subject: Re: [PATCH 2/3] dt-bindings: tpm: Convert IBM vTPM bindings to DT
 schema
Message-ID: <20231121161925.GD1845293-robh@kernel.org>
References: <cover.1700555862.git.lukas@wunner.de>
 <fc5c973d30df7ece297e19edad19ffe86378b6b1.1700555862.git.lukas@wunner.de>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc5c973d30df7ece297e19edad19ffe86378b6b1.1700555862.git.lukas@wunner.de>

On Tue, Nov 21, 2023 at 10:48:42AM +0100, Lukas Wunner wrote:
> Convert the devicetree bindings for the IBM Virtual Trusted Platform
> Module to DT schema.  Drop properties which are already documented in
> tpm-common.yaml.
> 
> Document the "IBM,vtpm20" compatible string introduced by commit
> 18b3670d79ae ("tpm: ibmvtpm: Add support for TPM2").
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>  .../bindings/security/tpm/ibmvtpm.txt         |  41 -------
>  .../devicetree/bindings/tpm/ibm,vtpm.yaml     | 101 ++++++++++++++++++
>  2 files changed, 101 insertions(+), 41 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/security/tpm/ibmvtpm.txt
>  create mode 100644 Documentation/devicetree/bindings/tpm/ibm,vtpm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/security/tpm/ibmvtpm.txt b/Documentation/devicetree/bindings/security/tpm/ibmvtpm.txt
> deleted file mode 100644
> index d89f99971368..000000000000
> --- a/Documentation/devicetree/bindings/security/tpm/ibmvtpm.txt
> +++ /dev/null
> @@ -1,41 +0,0 @@
> -* Device Tree Bindings for IBM Virtual Trusted Platform Module(vtpm)
> -
> -Required properties:
> -
> -- compatible            : property name that conveys the platform architecture
> -                          identifiers, as 'IBM,vtpm'
> -- device_type           : specifies type of virtual device
> -- interrupts            : property specifying the interrupt source number and
> -                          sense code associated with this virtual I/O Adapters
> -- ibm,my-drc-index      : integer index for the connector between the device
> -                          and its parent - present only if Dynamic
> -                          Reconfiguration(DR) Connector is enabled
> -- ibm,#dma-address-cells: specifies the number of cells that are used to
> -                          encode the physical address field of dma-window
> -                          properties
> -- ibm,#dma-size-cells   : specifies the number of cells that are used to
> -                          encode the size field of dma-window properties
> -- ibm,my-dma-window     : specifies DMA window associated with this virtual
> -                          IOA
> -- ibm,loc-code          : specifies the unique and persistent location code
> -                          associated with this virtual I/O Adapters
> -- linux,sml-base        : 64-bit base address of the reserved memory allocated
> -                          for the firmware event log
> -- linux,sml-size        : size of the memory allocated for the firmware event log
> -
> -Example (IBM Virtual Trusted Platform Module)
> ----------------------------------------------
> -
> -                vtpm@30000003 {
> -                        ibm,#dma-size-cells = <0x2>;
> -                        compatible = "IBM,vtpm";
> -                        device_type = "IBM,vtpm";
> -                        ibm,my-drc-index = <0x30000003>;
> -                        ibm,#dma-address-cells = <0x2>;
> -                        linux,sml-base = <0xc60e 0x0>;
> -                        interrupts = <0xa0003 0x0>;
> -                        ibm,my-dma-window = <0x10000003 0x0 0x0 0x0 0x10000000>;
> -                        ibm,loc-code = "U8286.41A.10082DV-V3-C3";
> -                        reg = <0x30000003>;
> -                        linux,sml-size = <0xbce10200>;
> -                };
> diff --git a/Documentation/devicetree/bindings/tpm/ibm,vtpm.yaml b/Documentation/devicetree/bindings/tpm/ibm,vtpm.yaml
> new file mode 100644
> index 000000000000..a88ed96c80cf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/tpm/ibm,vtpm.yaml
> @@ -0,0 +1,101 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/tpm/ibm,vtpm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: IBM Virtual Trusted Platform Module (vTPM)
> +
> +maintainers:
> +  - Nayna Jain <nayna@linux.ibm.com>
> +
> +description: |
> +  Virtual TPM is used on IBM POWER7+ and POWER8 systems running POWERVM.
> +  It is supported through the adjunct partition with firmware release 740
> +  or higher.  With vTPM support, each lpar is able to have its own vTPM
> +  without the physical TPM hardware.  The TPM functionality is provided by
> +  communicating with the vTPM adjunct partition through Hypervisor calls
> +  (Hcalls) and Command/Response Queue (CRQ) commands.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - IBM,vtpm
> +      - IBM,vtpm20
> +
> +  device_type:
> +    description:
> +      type of virtual device

const: IBM,vtpm

> +
> +  reg:
> +    maxItems: 1
> +
> +  'ibm,#dma-address-cells':
> +    description:
> +      number of cells that are used to encode the physical address field of
> +      dma-window properties
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +
> +  'ibm,#dma-size-cells':
> +    description:
> +      number of cells that are used to encode the size field of
> +      dma-window properties
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +
> +  ibm,my-dma-window:
> +    description:
> +      DMA window associated with this virtual I/O Adapter
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 5
> +    maxItems: 5
> +
> +  ibm,my-drc-index:
> +    description:
> +      integer index for the connector between the device and its parent;
> +      present only if Dynamic Reconfiguration (DR) Connector is enabled
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  ibm,loc-code:
> +    description:
> +      unique and persistent location code associated with this virtual
> +      I/O Adapter
> +    $ref: /schemas/types.yaml#/definitions/string
> +
> +required:
> +  - compatible
> +  - device_type
> +  - reg
> +  - interrupts
> +  - ibm,#dma-address-cells
> +  - ibm,#dma-size-cells
> +  - ibm,my-dma-window
> +  - ibm,my-drc-index
> +  - ibm,loc-code
> +  - linux,sml-base
> +  - linux,sml-size
> +
> +allOf:
> +  - $ref: tpm-common.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    soc {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        vtpm@30000003 {

tpm@...

With that,

Reviewed-by: Rob Herring <robh@kernel.org>


