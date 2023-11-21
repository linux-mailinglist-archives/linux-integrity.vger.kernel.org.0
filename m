Return-Path: <linux-integrity+bounces-142-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0DE7F2B11
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Nov 2023 11:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 217991C20DCE
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Nov 2023 10:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C9B482CF;
	Tue, 21 Nov 2023 10:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6168A83;
	Tue, 21 Nov 2023 02:57:29 -0800 (PST)
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-35aa6107e9fso19531675ab.0;
        Tue, 21 Nov 2023 02:57:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700564248; x=1701169048;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cmjt7Cvxkdz+Mw7yc/+RbJZ/ktXLEhwYw8VZUPmFUL4=;
        b=gzbOTIHp7Vnc6nUL+I6X+xQcZ3sdn1DT1gNthIGf1BZsmQDQwtWuT0QxqkI0hcwKGT
         Q4+eH9tTzYP2PIuXQn9jM+iARebONO1kgDyHMEtJJ2qqgJ9KXHH2IQRCRN3tjYeIKVEq
         XDsaAy2inBAUd3QULcQqMsKavKoJCrcCJ35uVdENwNTCC3ph72WqruHJmWW0PImql7av
         53U85tqrZ4vQXou3jm28c8W7LACxGc5c4TdZUr+uw69ybn/OcEV9ASMt7e1bz3akiJV4
         Sp7Kb4I71lFfe1dgysGftHkgEwdpoAelE5Hdok3KopaYLvljOP0zOdX+T3xAOAaWi9+d
         atoA==
X-Gm-Message-State: AOJu0Yz4K+obrhtFkNcBVNnwQbq5GeLQE2e6UH33zCxWXNr4e1O37THp
	bhV6Trwz24riiRp9ZngjFg==
X-Google-Smtp-Source: AGHT+IHSXPcvDe+5s83j1OJWr5LZcD3kjMa83yZv5E+brU51ZYtdW8m/My8ZESv69eZHh7AckhWaSw==
X-Received: by 2002:a05:6e02:220e:b0:359:30b1:425b with SMTP id j14-20020a056e02220e00b0035930b1425bmr16445879ilf.23.1700564248640;
        Tue, 21 Nov 2023 02:57:28 -0800 (PST)
Received: from herring.priv ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id j10-20020a056e02154a00b0035b0b56e0e1sm844636ilu.53.2023.11.21.02.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 02:57:27 -0800 (PST)
Received: (nullmailer pid 1245589 invoked by uid 1000);
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
Cc: Lino Sanfilippo <LinoSanfilippo@gmx.de>, devicetree@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>, linux-integrity@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <fc5c973d30df7ece297e19edad19ffe86378b6b1.1700555862.git.lukas@wunner.de>
References: <cover.1700555862.git.lukas@wunner.de>
 <fc5c973d30df7ece297e19edad19ffe86378b6b1.1700555862.git.lukas@wunner.de>
Message-Id: <170056423981.1245464.10395498560154249075.robh@kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: tpm: Convert IBM vTPM bindings to DT
 schema
Date: Tue, 21 Nov 2023 03:57:21 -0700


On Tue, 21 Nov 2023 10:48:42 +0100, Lukas Wunner wrote:
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

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/tpm/ibm,vtpm.yaml: required:4: 'ibm,#dma-address-cells' does not match '^([a-zA-Z#][a-zA-Z0-9,+\\-._@]{0,63}|\\$nodename)$'
	hint: 'required' must be valid DT property or node names
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/tpm/ibm,vtpm.yaml: required:5: 'ibm,#dma-size-cells' does not match '^([a-zA-Z#][a-zA-Z0-9,+\\-._@]{0,63}|\\$nodename)$'
	hint: 'required' must be valid DT property or node names
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/tpm/ibm,vtpm.example.dtb: vtpm@30000003: Unevaluated properties are not allowed ('linux,sml-base', 'linux,sml-size' were unexpected)
	from schema $id: http://devicetree.org/schemas/tpm/ibm,vtpm.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/tpm/ibm,vtpm.example.dtb: vtpm@30000003: 'ibm,#dma-address-cells', 'ibm,#dma-size-cells' do not match any of the regexes: '.*-names$', '.*-supply$', '^#.*-cells$', '^#[a-zA-Z0-9,+\\-._]{0,63}$', '^[a-zA-Z0-9][a-zA-Z0-9,+\\-._]{0,63}$', '^[a-zA-Z0-9][a-zA-Z0-9,+\\-._]{0,63}@[0-9a-fA-F]+(,[0-9a-fA-F]+)*$', '^__.*__$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/fc5c973d30df7ece297e19edad19ffe86378b6b1.1700555862.git.lukas@wunner.de

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


