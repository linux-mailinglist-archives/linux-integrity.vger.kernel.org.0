Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8E1199BA0
	for <lists+linux-integrity@lfdr.de>; Tue, 31 Mar 2020 18:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731155AbgCaQby (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 31 Mar 2020 12:31:54 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44257 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730442AbgCaQbx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 31 Mar 2020 12:31:53 -0400
Received: by mail-io1-f65.google.com with SMTP id r25so10544204ioc.11;
        Tue, 31 Mar 2020 09:31:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d+R74nPaOd+vv5Gmpvi8SiKDP0tZWuo+3fb7DyGJD94=;
        b=Xe94CU5O4VPWb1e722exKeelCmGRSw1Qs9mSTsMUBpQQotSmsrYD7aPLoFanXF/tNm
         /KgAFd+UnrCK5mKq+qcuZtB/N6TItOWAzJLP0g+tuOcSm9BRw1/OiwzzKONM5sqEV/A3
         q7ogmllqct/RRAmot+UFnAOmqQICtKUx5xWRrgi3SRFQ29i2+yEQuIRiYa4ks6hT43Tc
         LJ4GLhRI5hJxsRyxaRRUH69Z6tQRwgWPwCcy9bgRpa3p6dvOhHtDbfkE32g5xTbm6qF/
         cmSWba/AmtEYNmPV51wkP6MJYjwtCw0hHe3KIQtYzHMokSa8R4f6G1/DA0MnYWNXSFzY
         +cIg==
X-Gm-Message-State: ANhLgQ0Qba0UKqV0D99BJVJ1qFQDBRzkJjjah8l8wPO8eaeYGhjCavO0
        +8mTd8WHNaof79SBRwPYxg==
X-Google-Smtp-Source: ADFU+vseCz7jttp+qlbtqHQk7BycDFzLlrtD6E9EBfQMKQpsnrIBI40lc6Q/LtZu799Hxyrz31fqRg==
X-Received: by 2002:a05:6638:a99:: with SMTP id 25mr17196821jas.37.1585672310128;
        Tue, 31 Mar 2020 09:31:50 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id g78sm6111274ild.36.2020.03.31.09.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 09:31:49 -0700 (PDT)
Received: (nullmailer pid 24308 invoked by uid 1000);
        Tue, 31 Mar 2020 16:31:47 -0000
Date:   Tue, 31 Mar 2020 10:31:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     amirmizi6@gmail.com
Cc:     Eyal.Cohen@nuvoton.com, jarkko.sakkinen@linux.intel.com,
        oshrialkoby85@gmail.com, alexander.steffen@infineon.com,
        robh+dt@kernel.org, mark.rutland@arm.com, peterhuewe@gmx.de,
        jgg@ziepe.ca, arnd@arndb.de, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, oshri.alkoby@nuvoton.com,
        tmaimon77@gmail.com, gcwilson@us.ibm.com, kgoldman@us.ibm.com,
        Dan.Morav@nuvoton.com, oren.tanami@nuvoton.com,
        shmulik.hager@nuvoton.com, amir.mizinski@nuvoton.com,
        Amir Mizinski <amirmizi6@gmail.com>
Subject: Re: [PATCH v4 6/7] dt-bindings: tpm: Add YAML schema for TPM TIS I2C
 options
Message-ID: <20200331163147.GA23388@bogus>
References: <20200331113207.107080-1-amirmizi6@gmail.com>
 <20200331113207.107080-7-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331113207.107080-7-amirmizi6@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 31 Mar 2020 14:32:06 +0300, <amirmizi6@gmail.com> wrote:
> 
> From: Amir Mizinski <amirmizi6@gmail.com>
> 
> Added a YAML schema to support tpm tis i2c realted dt-bindings for the I2c
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
>  .../bindings/security/tpm/tpm-tis-i2c.yaml         | 46 ++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml:  while parsing a block collection
  in "<unicode string>", line 36, column 3
did not find expected '-' indicator
  in "<unicode string>", line 46, column 4
Documentation/devicetree/bindings/Makefile:12: recipe for target 'Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.example.dts' failed
make[1]: *** [Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
warning: no schema found in file: Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml: ignoring, error parsing file
Makefile:1262: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1264698

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.
