Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 705EAFCE7D
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Nov 2019 20:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfKNTK5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 Nov 2019 14:10:57 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42660 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfKNTK4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Nov 2019 14:10:56 -0500
Received: by mail-oi1-f195.google.com with SMTP id i185so6301683oif.9;
        Thu, 14 Nov 2019 11:10:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3YL56SWPGQVsNjFHXt4/e0yB7JGA/eRhTgMv1S0Kl3k=;
        b=cg1QihGubpiLJbD8xXtTtczk4+00w8WoeLbtf2GL/9lL4IiDIr3wAL/u6w7A3JPaGa
         hadKC+vdTMZDVCgqlkBsrHKRcQgMJDrsPjV+ky9rIAxQ7eg3r3Pji7tZrR82XNSa255L
         irMBZi90eUg15ek7xiD84mEgcwV64n94MhHE0AVLxXp7Rrv369liKDghiZwCdcH6wTN4
         JtCsmNsYxLCDyUZ2s1GZZbiF7Pk5gOpeV5FJBW1UvuMCXCvBA66zAgvx5tmZz1jviK4/
         hO7wS+fUEXvOGYje76AVV/Fp5wOhoXwKLwMWYB1BAy32ekmidK16TbhFxq+L3Z2YfkOH
         JHLw==
X-Gm-Message-State: APjAAAWuIP8fmO0HlL6r8Utd18UYM2y0weaEjDpYOyjgxCzxgLPoPlMe
        LH//cIT8M3RHarZY4AGV1w==
X-Google-Smtp-Source: APXvYqz71HZf5S7VSUThFF27uk9VXrn+jKsPsmwXCQmMu3Ynhm/j3rU0b2jARLb2VuHT/w4/OT8Pag==
X-Received: by 2002:aca:d0d:: with SMTP id 13mr4993560oin.44.1573758655714;
        Thu, 14 Nov 2019 11:10:55 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o22sm2028669otk.47.2019.11.14.11.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 11:10:54 -0800 (PST)
Date:   Thu, 14 Nov 2019 13:10:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     amirmizi6@gmail.com
Cc:     Eyal.Cohen@nuvoton.com, jarkko.sakkinen@linux.intel.com,
        oshrialkoby85@gmail.com, alexander.steffen@infineon.com,
        mark.rutland@arm.com, peterhuewe@gmx.de, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, oshri.alkoby@nuvoton.com,
        tmaimon77@gmail.com, gcwilson@us.ibm.com, kgoldman@us.ibm.com,
        ayna@linux.vnet.ibm.com, Dan.Morav@nuvoton.com,
        oren.tanami@nuvoton.com, shmulik.hagar@nuvoton.com,
        amir.mizinski@nuvoton.com
Subject: Re: [PATCH v1 4/5] dt-bindings: tpm: Add the TPM TIS I2C device tree
 binding documentaion
Message-ID: <20191114191054.GA20209@bogus>
References: <20191110162137.230913-1-amirmizi6@gmail.com>
 <20191110162137.230913-5-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191110162137.230913-5-amirmizi6@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Nov 10, 2019 at 06:21:36PM +0200, amirmizi6@gmail.com wrote:
> From: Amir Mizinski <amirmizi6@gmail.com>
> 
> this file aim at documenting TPM TIS I2C related dt-bindings for the I2C PTP based Physical TPM.
> 
> Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
> ---
>  .../bindings/security/tpm/tpm_tis_i2c.txt          | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/security/tpm/tpm_tis_i2c.txt

Please make this a schema. See 
Documentation/devicetree/writing-schema.rst.

> 
> diff --git a/Documentation/devicetree/bindings/security/tpm/tpm_tis_i2c.txt b/Documentation/devicetree/bindings/security/tpm/tpm_tis_i2c.txt
> new file mode 100644
> index 0000000..7d5a69e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/security/tpm/tpm_tis_i2c.txt
> @@ -0,0 +1,24 @@
> +* Device Tree Bindings for I2C PTP based Trusted Platform Module(TPM)
> +
> +The TCG defines hardware protocol, registers and interface (based
> +on the TPM Interface Specification) for accessing TPM devices
> +implemented with an I2C interface.
> +
> +Refer to the 'I2C Interface Definition' section in 'TCG PC Client
> +PlatformTPMProfile(PTP) Specification' publication for specification.
> +
> +Required properties:
> +
> +- compatible     : Should be "tcg,tpm_tis-i2c"

s/_/-/

As this has to be under an I2C controller node, the '-i2c' part is 
redundant.

There's a bigger issue that the h/w here is more than just an I2C 
protocol. The chip may have multiple power supplies, clocks, reset 
lines, etc. HID over I2C seems like a similar case. Does the spec define 
*all* of that? If not, you need chip specific compatibles. You can keep 
this as a fallback though.

> +- reg            : Address on the bus
> +- tpm-pirq       : Input gpio pin, used for host interrupts

GPIO connections are properties ending in '-gpios'. However, if the only 
use is an interrupt, then you should use 'interrupts'.

> +
> +Example (for Raspberry Pie 3 Board with Nuvoton's NPCT75X (2.0)
> +-------------------------------------------------------------------
> +
> +tpm_tis-i2c: tpm_tis-i2c@2e {
> +
> +       compatible = "tcg,tpm_tis-i2c";
> +       reg = <0x2e>;
> +       tpm-pirq = <&gpio 24 GPIO_ACTIVE_HIGH>;
> +};
> -- 
> 2.7.4
> 
