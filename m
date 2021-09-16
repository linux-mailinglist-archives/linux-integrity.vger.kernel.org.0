Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBAF40DD13
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Sep 2021 16:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238590AbhIPOo7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Sep 2021 10:44:59 -0400
Received: from mail-io1-f52.google.com ([209.85.166.52]:42734 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237526AbhIPOo7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Sep 2021 10:44:59 -0400
Received: by mail-io1-f52.google.com with SMTP id b10so8178813ioq.9;
        Thu, 16 Sep 2021 07:43:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PBMbyG66JcsJeX8hysmtBlI8q6/uwacbLt8pVZtH9oY=;
        b=3oIy7Zp5jijawIACXMMZEP4nqsk7uS79Kr5GF0/bzYSKiZRA71iIJdoyJAwVI1RAUO
         zrdYHsbC1zn3YSBA3Pf8n2+vzSen1ts81EjpmqQRIifShhLcnJsUSxm1ZtrWXZ0ngy0z
         j5m5C4Aek27qCa2cF4p7MPHcgmeJqJX7uukQfFXNmheJbGBIjjkVy2DFYcJiDb/fxd0n
         UKW9dmcmlyQR25n/cfq+H1QPw6eYFN49zWRB6Kfr7RrzeUJSHGrbgFIBNj7vquS2fSJ1
         J2I1XIlbT5w1zBtzz8+8+ViWtfcMV+ocj/ZI0Snc+pW/D0lP6e8j0vyLybELqloM2dZ4
         qsOw==
X-Gm-Message-State: AOAM531YGOMZdmRHwNgkU2efxlVJhU4+AkLA6D7eR2P+ByEGCh5gLnRS
        7zd5SMN3ue9RUeR/ro4AJw==
X-Google-Smtp-Source: ABdhPJxxammQEcKK3G2JWaR69oSUKLj81sFdPLSuBn/OtrrWh35XAzDzP/+ey1dgIMCyhEre4XQ7RA==
X-Received: by 2002:a05:6638:3890:: with SMTP id b16mr4807745jav.65.1631803418434;
        Thu, 16 Sep 2021 07:43:38 -0700 (PDT)
Received: from robh.at.kernel.org (96-84-70-89-static.hfc.comcastbusiness.net. [96.84.70.89])
        by smtp.gmail.com with ESMTPSA id q17sm2011045ilc.81.2021.09.16.07.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 07:43:37 -0700 (PDT)
Received: (nullmailer pid 1327692 invoked by uid 1000);
        Thu, 16 Sep 2021 14:43:36 -0000
Date:   Thu, 16 Sep 2021 09:43:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     amirmizi6@gmail.com
Cc:     jgg@ziepe.ca, devicetree@vger.kernel.org, oshrialkoby85@gmail.com,
        gregkh@linuxfoundation.org, kgoldman@us.ibm.com,
        robh+dt@kernel.org, alexander.steffen@infineon.com,
        jarkko@kernel.org, oshri.alkoby@nuvoton.com, peterhuewe@gmx.de,
        linux-kernel@vger.kernel.org, benoit.houyere@st.com,
        Eyal.Cohen@nuvoton.com, gcwilson@us.ibm.com, mark.rutland@arm.com,
        joel@jms.id.au, Dan.Morav@nuvoton.com, shmulik.hager@nuvoton.com,
        amir.mizinski@nuvoton.com, oren.tanami@nuvoton.com,
        tmaimon77@gmail.com, arnd@arndb.de,
        linux-integrity@vger.kernel.org, eajames@linux.ibm.com
Subject: Re: [PATCH v15 6/6] tpm: Add YAML schema for TPM TIS I2C options
Message-ID: <YUNYGNktq0HgiThT@robh.at.kernel.org>
References: <20210914151032.216122-1-amirmizi6@gmail.com>
 <20210914151032.216122-7-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914151032.216122-7-amirmizi6@gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 14 Sep 2021 18:10:32 +0300, amirmizi6@gmail.com wrote:
> From: Amir Mizinski <amirmizi6@gmail.com>
> 
> Add a YAML schema to support tpm tis i2c related dt-bindings for the I2c
> PTP based physical layer.
> 
> This patch adds the documentation for corresponding device tree bindings of
> I2C based Physical TPM.
> Refer to the 'I2C Interface Definition' section in
> 'TCG PC Client PlatformTPMProfile(PTP) Specification' publication
> for specification.
> 
> Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
> ---
>  .../bindings/security/tpm/tpm-tis-i2c.yaml         | 52 ++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
