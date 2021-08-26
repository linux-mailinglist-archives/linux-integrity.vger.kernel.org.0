Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D38163F88D7
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Aug 2021 15:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242708AbhHZN1K (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 26 Aug 2021 09:27:10 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:40515 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242719AbhHZN07 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 26 Aug 2021 09:26:59 -0400
Received: by mail-ot1-f43.google.com with SMTP id x9-20020a056830278900b0051b8be1192fso3447275otu.7;
        Thu, 26 Aug 2021 06:26:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=uIS+8gYdkJjlrt+Ek4uoUfWZb6Pa8S7tyRKs39tOyHo=;
        b=mETh4Se60dRVzqor2YEmRipKwwOKzBJCkzuA5IbmUgctGZsAO6GL5PrWQpUs5ceoAg
         njB+Oxr2PZr9+jtbScOR7GGnr4FeJ3tPy9oD29Hcd4fyHWCv/n8RmTn0PcW4jRWO5pHP
         9BUNKmRC9vdyOETQ0+wi4h3iRPIl1dVwZksOmOZhzbCrOywugzt/mC5GxPuE+9usDoyv
         NO+raFnTXDJFviIl9RkV/1gZ6rJfk9bZuq6PUeqPzm6jrPdNxIqeuxrKAre1i1HmBIqV
         S1BklyKhfNmCY4KCKSXp4aeYM4qtCXL4VZJ5+Cd9MnONB0jD0gNrzzOZVsuInBlJEeel
         qgxQ==
X-Gm-Message-State: AOAM533vYkOWy5fWYiHsq9cWeahjNNVsiaKjCaakqNxhd6y4BG18BJAc
        29Jk1EH4ZrEagXwiVVmcdSfFLY+5lw==
X-Google-Smtp-Source: ABdhPJxNI0g7Dxl6NJmuGLI5tee2rarhhWN6VNmz8YZLrFfLMJvu2ENDDI4aJHTclCNLT0H7r6+O1Q==
X-Received: by 2002:a9d:5f07:: with SMTP id f7mr3198978oti.183.1629984371677;
        Thu, 26 Aug 2021 06:26:11 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id n17sm564601otl.32.2021.08.26.06.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 06:26:10 -0700 (PDT)
Received: (nullmailer pid 1033390 invoked by uid 1000);
        Thu, 26 Aug 2021 13:26:01 -0000
From:   Rob Herring <robh@kernel.org>
To:     amirmizi6@gmail.com
Cc:     oshri.alkoby@nuvoton.com, tmaimon77@gmail.com, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com, kgoldman@us.ibm.com,
        oshrialkoby85@gmail.com, jgg@ziepe.ca, shmulik.hager@nuvoton.com,
        robh+dt@kernel.org, gregkh@linuxfoundation.org,
        mark.rutland@arm.com, benoit.houyere@st.com,
        amir.mizinski@nuvoton.com, oren.tanami@nuvoton.com, joel@jms.id.au,
        devicetree@vger.kernel.org, gcwilson@us.ibm.com,
        alexander.steffen@infineon.com, Dan.Morav@nuvoton.com,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Eyal.Cohen@nuvoton.com, eajames@linux.ibm.com, arnd@arndb.de
In-Reply-To: <20210826111908.117278-8-amirmizi6@gmail.com>
References: <20210826111908.117278-1-amirmizi6@gmail.com> <20210826111908.117278-8-amirmizi6@gmail.com>
Subject: Re: [PATCH v13 7/7] tpm: Add YAML schema for TPM TIS I2C options
Date:   Thu, 26 Aug 2021 08:26:01 -0500
Message-Id: <1629984361.421167.1033389.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 26 Aug 2021 14:19:08 +0300, amirmizi6@gmail.com wrote:
> From: Amir Mizinski <amirmizi6@gmail.com>
> 
> Added a YAML schema to support tpm tis i2c related dt-bindings for the I2c
> PTP based physical layer.
> 
> This patch adds the documentation for corresponding device tree bindings of
> I2C based Physical TPM.
> Refer to the 'I2C Interface Definition' section in
> 'TCG PC Client PlatformTPMProfile(PTP) Specification' publication
> for specification.
> 
> Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/security/tpm/tpm-tis-i2c.yaml         | 50 ++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml: 'additionalProperties' is a required property
	hint: A schema without a "$ref" to another schema must define all properties and use "additionalProperties"
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml: ignoring, error in schema: 
warning: no schema found in file: ./Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.example.dt.yaml:0:0: /example-0/i2c/tpm@2e: failed to match any schema with compatible: ['nuvoton,npct75x', 'tcg,tpm-tis-i2c']
Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.example.dt.yaml:0:0: /example-0/i2c/tpm@2e: failed to match any schema with compatible: ['nuvoton,npct75x', 'tcg,tpm-tis-i2c']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1521079

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

