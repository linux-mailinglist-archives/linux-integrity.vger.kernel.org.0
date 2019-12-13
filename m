Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCBA11EDEC
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Dec 2019 23:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbfLMWg0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 13 Dec 2019 17:36:26 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35584 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfLMWgZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 Dec 2019 17:36:25 -0500
Received: by mail-ot1-f65.google.com with SMTP id o9so928520ote.2;
        Fri, 13 Dec 2019 14:36:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aViRkDm5Q83Ziq8WvPrQQFLWmlznU7OM781DBB+jypg=;
        b=ucND154++qoAxLmokTgA2eEdK6s5YKYYDcJ5pF5t0tyGwIbddMoGtivA0Wg+fU4wz0
         8vhz78HoY/DWs1JxsnH/mHDzR1VWIB9UkCJzBrvm5HAMGUgCfLRGaUFXO0Yji/MqcFzx
         NoGd/l2/VeyasbIRrswD6ocw1Q9QJEXZNNrTCpnBjmfOOtj8RwZ24+b5aj0VtHQcgooJ
         E7X/dKc8aytc4HCPGXcuFkkKJ920A30MFpDRg1jKGQSAQedw0t397xpnHn9REHkVHpGb
         rTWaFy0p9a4bA0rRsqJ1Kwc6mG1F5KCSl7lwMD7rfaQQfL/B3I2EsDLB4kNdT20KP6rC
         bh1A==
X-Gm-Message-State: APjAAAXEfS2TAXY7xDhJwpM4dlAZwxNiYMPArvynr1Wu4C3ppltt66cU
        w1FLARk90hZ8wVdyxoElmA==
X-Google-Smtp-Source: APXvYqw8SEx0ZsdXc4Aw+KPeDksSB3h46zpVT+15p6hwpJ1l8hKcJ9COeglbxaJdcO7zzSAu5R/efQ==
X-Received: by 2002:a05:6830:1353:: with SMTP id r19mr17631952otq.288.1576276584871;
        Fri, 13 Dec 2019 14:36:24 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b15sm3832281oti.23.2019.12.13.14.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 14:36:24 -0800 (PST)
Date:   Fri, 13 Dec 2019 16:36:23 -0600
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
        oren.tanami@nuvoton.com, shmulik.hager@nuvoton.com,
        amir.mizinski@nuvoton.com
Subject: Re: [PATCH v2 4/5] dt-bindings: tpm: Add YAML schema for TPM TIS I2C
 options
Message-ID: <20191213223623.GA14809@bogus>
References: <20191202133332.178110-1-amirmizi6@gmail.com>
 <20191202133332.178110-5-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202133332.178110-5-amirmizi6@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Dec 02, 2019 at 03:33:31PM +0200, amirmizi6@gmail.com wrote:
> From: Amir Mizinski <amirmizi6@gmail.com>
> 
> Added a YAML schema to support tpm tis i2c realted dt-bindings for the I2c PTP based physical layer.

Wrap your commmit message. And TPM, TIS?, and I2C should be capitalized.

> 
> Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
> ---
>  .../bindings/security/tpm/tpm-tis-i2c.yaml         | 38 ++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml

Please read my comments on v1 (The first v1 from 11/10, not the 2nd v1 
you sent).

Rob
