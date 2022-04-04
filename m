Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500CB4F1AC3
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Apr 2022 23:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379213AbiDDVS6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 4 Apr 2022 17:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378962AbiDDQK4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 4 Apr 2022 12:10:56 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC01DF47;
        Mon,  4 Apr 2022 09:08:59 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-ddfa38f1c1so11187055fac.11;
        Mon, 04 Apr 2022 09:08:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=Kx6ERCrj+RAX4ftx3ARMDh8uvUSQAfGf8UrRWwljjyQ=;
        b=VKbUPMt4ypzLMRW0Bj4M5MoMtZ0AQA2Ni4ImfNxVgsZrIvC8jpZWcifgPW2Umg32dN
         VDx+crCsfJLjI+8d40MN8odTLjtpDN99wQtqLhXKeWVB759RVtwaQBbsE6MaOKLT2q9I
         WKrOlTQJJo9X9mLQwVH99nGEls+bELTFKTfZIijh2E24WZXKObK3+wp57tPJfiHJOmv8
         OFAmCH8mtzs44TGsLF4saC6GAHVqQwHfRTiqtldxkGAX+Yc26hiPvpAKlGe0LfrkPmaB
         uIb+FVsM8Xrhs6/0EwQCG/Y3sWgmr+LG99fhLAWEYCSw7FSre6T16oIi67QuNzjJ3yTx
         NeCw==
X-Gm-Message-State: AOAM531jA6ChDqp887vLEjwlr0OuT7x1EPKu4sPy7ZvvTkBlsAp+rzFp
        y/1/AaN8W6sYi0odLIEk0g==
X-Google-Smtp-Source: ABdhPJwjEFDANYI87q+T1m/cxlD9OPVLWfDti/NALdasQ/YIMK9xAtUQhLRRf8DokcYSDllKErUj0Q==
X-Received: by 2002:a05:6870:6188:b0:e1:e3ed:b39a with SMTP id a8-20020a056870618800b000e1e3edb39amr324317oah.271.1649088539072;
        Mon, 04 Apr 2022 09:08:59 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i21-20020a056830011500b005cdc3cdacb5sm4730227otp.57.2022.04.04.09.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 09:08:58 -0700 (PDT)
Received: (nullmailer pid 1436945 invoked by uid 1000);
        Mon, 04 Apr 2022 16:08:58 -0000
From:   Rob Herring <robh@kernel.org>
To:     Johannes Holland <johannes.holland@infineon.com>
Cc:     devicetree@vger.kernel.org, peterhuewe@gmx.de, jarkko@kernel.org,
        jgg@ziepe.ca, amirmizi6@gmail.com, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
In-Reply-To: <20220404081835.495-4-johannes.holland@infineon.com>
References: <20220404081835.495-1-johannes.holland@infineon.com> <20220404081835.495-4-johannes.holland@infineon.com>
Subject: Re: [PATCH 4/4] tpm: Add YAML schema for the TPM TIS I2C options
Date:   Mon, 04 Apr 2022 11:08:58 -0500
Message-Id: <1649088538.021063.1436944.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 04 Apr 2022 10:18:35 +0200, Johannes Holland wrote:
> Add a YAML schema to support device tree bindings for the generic I2C
> physical layer. Refer to the TCG PC Client Platform TPM Profile (PTP)
> Specification for TPM 2.0 v1.04 Revision 14.
> 
> Signed-off-by: Johannes Holland <johannes.holland@infineon.com>
> ---
>  .../bindings/security/tpm/tpm-tis-i2c.yaml    | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.example.dt.yaml: tpm@2e: compatible:1: 'tcg,tpm-tis-i2c' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.example.dt.yaml: tpm@2e: compatible: ['infineon,slb9673', 'nuvoton,npct75x', 'tcg,tpm-tis-i2c'] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

