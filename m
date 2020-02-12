Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7524D159EDC
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Feb 2020 02:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbgBLB7t (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 Feb 2020 20:59:49 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44026 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbgBLB7t (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 Feb 2020 20:59:49 -0500
Received: by mail-oi1-f194.google.com with SMTP id p125so491019oif.10;
        Tue, 11 Feb 2020 17:59:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oUgmGZs9ysmhnlBcesm5luyKADc/t2m7O/Es9uN8oM0=;
        b=SwG0izXwTqMlwyJxqphql03KfZZ19JlEBJ/1pJKFo+pqOUEiTfMWT3nxd07lAyID3+
         PM0oaX0wP9RHrloGSd/tnZamPouNEvAm+SbftQgPXxNvk5NExiTXrjnMc+I5MD2CNLYe
         fBa3qa2DETgyNzlTIwUkxMLjjfkX/LZtZXnD4hOuz6KJhpaxcQwFN5VqZRxAIsa6HBOH
         1AiHOTUkTCHytgNAoFC6At9kYH7OUBq41m+ZOd8MtDalBffANCSflTCdS86lxVXYZo8W
         8XpXNq6M7HHNZWeXn5vHDuWkFyuJWlaTXWlXPfWBWOU3q3682A1vs7NFUvX8+bmNVcuq
         gzoQ==
X-Gm-Message-State: APjAAAVqk6cz7mzhFeoGlAHfCxm/O9F3HVvghE0xnMQTNpxfIFxK/uN/
        2KjP4lFzIJ8FrIHf/45fXA==
X-Google-Smtp-Source: APXvYqzYkrEPi4s5FihRWg4m7/OX91OhLNOhEUTKhsmkD+7S2Uhze22H30khgoNiGbcUKSRzyqL2/w==
X-Received: by 2002:aca:4a0b:: with SMTP id x11mr4616138oia.37.1581472787109;
        Tue, 11 Feb 2020 17:59:47 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y14sm1699802oih.23.2020.02.11.17.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 17:59:46 -0800 (PST)
Received: (nullmailer pid 16508 invoked by uid 1000);
        Wed, 12 Feb 2020 01:59:45 -0000
Date:   Tue, 11 Feb 2020 19:59:45 -0600
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
Subject: Re: [PATCH v3 6/7] dt-bindings: tpm: Add YAML schema for TPM TIS I2C
 options
Message-ID: <20200212015945.GA15472@bogus>
References: <20200210162838.173903-1-amirmizi6@gmail.com>
 <20200210162838.173903-7-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210162838.173903-7-amirmizi6@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 10 Feb 2020 18:28:37 +0200, amirmizi6@gmail.com wrote:
> From: Amir Mizinski <amirmizi6@gmail.com>
> 
> Added a YAML schema to support tpm tis i2c realted dt-bindings for the I2c
>  PTP based physical layer.
> 
> This patch adds the documentation for corresponding device tree bindings of
>  I2C based Physical TPM.
> Refer to the 'I2C Interface Definition' section in
>  'TCG PC Client PlatformTPMProfile(PTP) Specification' publication
>  for specification.
> 
> Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
> ---
>  .../bindings/security/tpm/tpm-tis-i2c.yaml         | 43 ++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/display/simple-framebuffer.example.dts:21.16-37.11: Warning (chosen_node_is_root): /example-0/chosen: chosen node must be at root node
Error: Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.example.dts:17.12-13 syntax error
FATAL ERROR: Unable to parse input tree
scripts/Makefile.lib:300: recipe for target 'Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.example.dt.yaml' failed
make[1]: *** [Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.example.dt.yaml] Error 1
Makefile:1263: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1235916
Please check and re-submit.
