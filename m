Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3833621E369
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jul 2020 01:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbgGMXFR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 Jul 2020 19:05:17 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:34101 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgGMXFR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Jul 2020 19:05:17 -0400
Received: by mail-il1-f195.google.com with SMTP id t4so12716178iln.1;
        Mon, 13 Jul 2020 16:05:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qkXyHnsv68ED4w7McKNKxAN4UpsE/YFqp1JlctBInnU=;
        b=a9WqWF13sZl/lV00EiMTDDbeZTW1x5BuNPyqRra83jgTSaCyeIQHArKsAQjtUPNtlv
         zSfy2/Ey0PNIPA5Nd8ITbXvzVAd+/qiJNiWcLIj9ZcH3Bk6ewLlbCoGU5iBdC0BSDqDR
         tyIUhlEkklEE2b3RQV51h++fG6D0cDhshE+TDdLT48r4/bPu1UQyqPt2oxgaL1DsMtoU
         0rvzUHG/0cVMehNjQUl5T1p9YAxGPc1nVmEWD79mkSwbYoVaZy+K5IgkTQkvBtTGkRwQ
         jf57QjXvTARz3g4erspq3t1rDAphPopqa4SLGAUVpd81hoPD+4MwBFHSFg003JeSKAR6
         9DTQ==
X-Gm-Message-State: AOAM532kvAXVvVAebvXsO70kfTxGIbl6y9SokiPlb+Ecd3IJbubso4Hq
        BBFF2kk2a0/Z9MDW/kF42g==
X-Google-Smtp-Source: ABdhPJxZ9uWIbSzhP3o1StELFModGoY1L4ZSW4KiG7rqg3xYuCfk5q/0OPS7jM/nLh/X7d/OC/Nu8g==
X-Received: by 2002:a92:c9cb:: with SMTP id k11mr2188434ilq.70.1594681516447;
        Mon, 13 Jul 2020 16:05:16 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id w5sm8931082ilm.46.2020.07.13.16.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 16:05:15 -0700 (PDT)
Received: (nullmailer pid 888550 invoked by uid 1000);
        Mon, 13 Jul 2020 23:05:14 -0000
Date:   Mon, 13 Jul 2020 17:05:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Masahisa Kojima <masahisa.kojima@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        jgg@ziepe.ca, Rob Herring <robh+dt@kernel.org>,
        linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        ardb@kernel.org, peterhuewe@gmx.de,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/2] dt-bindings: Add SynQucer TPM MMIO as a trivial
 device
Message-ID: <20200713230514.GA888497@bogus>
References: <20200708131424.18729-1-masahisa.kojima@linaro.org>
 <20200708131424.18729-3-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708131424.18729-3-masahisa.kojima@linaro.org>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 08 Jul 2020 22:14:24 +0900, Masahisa Kojima wrote:
> Add a compatible string for the SynQuacer TPM to the binding for a
> TPM exposed via a memory mapped TIS frame. The MMIO window behaves
> slightly differently on this hardware, so it requires its own
> identifier.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
