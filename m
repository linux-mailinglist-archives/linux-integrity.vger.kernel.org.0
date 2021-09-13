Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6520408B7C
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Sep 2021 15:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236776AbhIMND3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 Sep 2021 09:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236882AbhIMND2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Sep 2021 09:03:28 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDF1C061760
        for <linux-integrity@vger.kernel.org>; Mon, 13 Sep 2021 06:02:13 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id w78so10302012qkb.4
        for <linux-integrity@vger.kernel.org>; Mon, 13 Sep 2021 06:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=33qyjUymJuTRSIG7q/aN8mBAjVw26SqZuT1dehv1B5Y=;
        b=BYmQ7J7Ic9+xt0gqwsI8P3BtMa4w+XkkJjwnUm8dISc0SWByFvwp8l59bf/+wXTp8c
         Wgr4qd5tk9j2aVn02+tPhuR4q5e8J75FaNV/0Va/hvboutS7+cFDepEByr1FYrio2dVW
         O9UkthF5FH3nOsB+cTrghpRMlbrDDqPMaYqai/AfgqGo5ZNNgmrR5uS2tnkERckKtHJl
         2n5rGeZ2hRv4HE5DBNhNb9Bpw6do43AqfNXr3YgHvzyHaGtI/c+gUOSZzSKGO8k+K/Ln
         sZ+VYO/PvCyWfSKz26ZPpHn+u+Luaob9uKozdRXMUob/Dyd7X/7gyjg7dJV1CFPsYzYu
         rY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=33qyjUymJuTRSIG7q/aN8mBAjVw26SqZuT1dehv1B5Y=;
        b=Zw5kLxNBxJFJsaPmpDHVu1hCfMS25THx8hu18B448T8HnLjK0OYqTlkfudAYdh0ThK
         CUb2/+pCsugoC/QwFpT4/1dhNmfWLLPhxPq5SYRAjB+7wVd6dP5+ZxTmxRML2DzbI/6N
         M9l/mUB1INXx7aMCIv16bLhIeeZdZvefc3d+QkI7KiYpMFDbgkgdi+05VMhDj9Oh1XT0
         MKca9iO3sgQ9vSVg4Q2ghvKe0aZAY5LOY7P2t8QwgiTDs+B2QO4Ir8OxWSRP+n4h7r5z
         6aGheivnCKau2libGnDKg6K9s4j3KNBTtiKx+bF+w8wXUxk87OmECC7+yDBMjRCXMkIw
         cmAA==
X-Gm-Message-State: AOAM530JSU1B2LkwFTHMqZJ58m/gGikH61AG69H1W19p7eli5eo4jLbo
        5fg95Rq4vBEx2LtM8+VVJO+yQw==
X-Google-Smtp-Source: ABdhPJyLc/JnphbRb7XZZpkDJCXn/N43EWy2uSL5Z9Ww0Rxq38o6dRjRf5sjt39TWBaiwaUeDPH9dA==
X-Received: by 2002:a05:620a:1307:: with SMTP id o7mr9644574qkj.437.1631538131520;
        Mon, 13 Sep 2021 06:02:11 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id p14sm4083952qtq.43.2021.09.13.06.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 06:02:10 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mPlb8-00GSNe-81; Mon, 13 Sep 2021 10:02:10 -0300
Date:   Mon, 13 Sep 2021 10:02:10 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Florian Eckert <fe@dev.tdt.de>
Cc:     peterhuewe@gmx.de, jarkko@kernel.org,
        Eckert.Florian@googlemail.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] tpm/tpm_i2c_infineon: Fix init endian vendor check
Message-ID: <20210913130210.GD3544071@ziepe.ca>
References: <20210913120521.18572-1-fe@dev.tdt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913120521.18572-1-fe@dev.tdt.de>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Sep 13, 2021 at 02:05:21PM +0200, Florian Eckert wrote:
> On my embedded system I use this tpm infineon chip via i2c bus.
> The system is a MIPS architecture and therefore works in big endian mode.
> 
> The problem is, that the chip type is not correctly recognized,
> because the vendor ID is wrongly aligned in the memory.
> 
> By declaring the vendor ID variable as a `__le32` type, the TPM chip is
> then correctly recognized by the driver and feels then responsible.
> 
> The device works than as expected.
> 
> Signed-off-by: Florian Eckert <fe@dev.tdt.de>
> ---
> v2:
> * use variable type instead of le32_to_cpus function call
>  drivers/char/tpm/tpm_i2c_infineon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

And if you do this it need to be made sparse clean/etc

Jason
