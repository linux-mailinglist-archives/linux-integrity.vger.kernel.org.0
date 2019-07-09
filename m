Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFB4863811
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Jul 2019 16:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbfGIOl3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 9 Jul 2019 10:41:29 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41483 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfGIOl2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 9 Jul 2019 10:41:28 -0400
Received: by mail-io1-f65.google.com with SMTP id j5so24304993ioj.8;
        Tue, 09 Jul 2019 07:41:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EyPnKhK+QTa3w59m9Lz+vk+6zrrmCFPQRDeNLA4SjFM=;
        b=aTrwuMCgdnV3Dx6uymSVWlROCgBlNW1NLtqeoWFHfbn5+KWB3V/4Olub1BfXprljdG
         FFL6ziGLMLFK0K1ogq2MTXBZYrq0Ubpw0317KDYtinTERbTUMkY+9kO7hczewFfW+ndL
         Qt6G3N2xhbc92oZL1ABiYFUxOuDwMSbzxAAb43hk98VnDVCPBoIC74NQH4wCKNyBr2g8
         rOjBSFQL/cKI52m8VkWcYlezGwI/ZypdyDFQU+4nGWo5C7byjPw7sFuDR8iV7h8HaTKu
         OE/LvaOx6RZXicdNEYGFMC30tRiREa9+5bPK/jdIfUFXQQy4u8G14KUDFvyZbTRW2lNO
         xLyw==
X-Gm-Message-State: APjAAAX2blL+uGkyaNLKYcRP99FFJJzqVkjoB1I7jjp2IdtBuksBqsi6
        lNJF/ItKrrWhsAcFarXk0t2y4wE=
X-Google-Smtp-Source: APXvYqyncVy8cA742s5kc2Sy1Hke65FJvErGLFMZdEivjqzZxTI7NRCTl8QKuCrGHf8f/WIzK026ww==
X-Received: by 2002:a6b:8b0b:: with SMTP id n11mr8460184iod.101.1562683287950;
        Tue, 09 Jul 2019 07:41:27 -0700 (PDT)
Received: from localhost ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id v3sm11713790iom.53.2019.07.09.07.41.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 07:41:27 -0700 (PDT)
Date:   Tue, 9 Jul 2019 08:41:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Andrey Pronin <apronin@chromium.org>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, devicetree@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH 4/8] dt-bindings: tpm: document properties for cr50
Message-ID: <20190709144126.GA12345@bogus>
References: <20190613180931.65445-1-swboyd@chromium.org>
 <20190613180931.65445-5-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613180931.65445-5-swboyd@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 13, 2019 at 11:09:27AM -0700, Stephen Boyd wrote:
> From: Andrey Pronin <apronin@chromium.org>
> 
> Add TPM2.0 PTP FIFO compatible SPI interface for chips with Cr50
> firmware.
> 
> Signed-off-by: Andrey Pronin <apronin@chromium.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
> 
> This is a resend of https://lkml.kernel.org/r/1469757314-116169-2-git-send-email-apronin@chromium.org
> with status removed.
> 
>  .../bindings/security/tpm/cr50_spi.txt        | 19 +++++++++++++++++++

google,cr50.txt instead.

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

>  1 file changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/security/tpm/cr50_spi.txt
