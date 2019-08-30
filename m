Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 085F6A36F7
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Aug 2019 14:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbfH3Mng (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Aug 2019 08:43:36 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40980 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbfH3Mng (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Aug 2019 08:43:36 -0400
Received: by mail-qt1-f195.google.com with SMTP id i4so7403211qtj.8
        for <linux-integrity@vger.kernel.org>; Fri, 30 Aug 2019 05:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=3ZitNgFXrdayf4EBPMRNk2dQMSxsOg5aQdjNQBrLxV0=;
        b=O3LIh1VnGlkPOZRjsHo4nMuWtoEGAiQRYYoD6NNlNcGuu0FBYUlVYR6rh1cRtKftVu
         bT0oSnDd+W+W9nEf4LCrq0Z6XgY6fv2097uMGoIARrHecLnNcbEfoTF5tNdkG4mKMTyh
         d3qBjBhPbET10i0VH4df7MtHrExDfBIk8ELqFSBsx0Vgzq4SH/+xhTaobO1jGFgWOlxO
         2HPbu/l6Z6CCz+aMERDdMW3DXnp3MNiwVFPSdQoKWx4kiExb8Yu0RA7iLKFMKMcofpvT
         J253asUJtCWT6ATk/krqzemDRS4bnNEU3czn+uiR1hCHPsDh0ouB8YywBj2f4MR7mKkW
         grBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=3ZitNgFXrdayf4EBPMRNk2dQMSxsOg5aQdjNQBrLxV0=;
        b=G+ITFnvkKsnaxWXardyVWbIQdNCkKNm7Muz2P3dLSm41LTckzevOs4Jz/amBoloSos
         MHaqdjbQRYOLCLC6RaxCaQmGWz7FsaSYjAmMih3Wo5iNLxaVaesKpBgVBJgTgWItm5y+
         hpC/GoyxeLQ1sgEa/2muEhotA+qtEsoU9XEZzQSC2nB/ZTzmGw12d9TOC9R6fZQjeaQ6
         hDm0lfWTHVdAn0+X1/a6jLnow8Xe1CMcvqo0uAEHNx2/Q9lgZHyv8wyoGuGEB4f+RaR8
         +Kw/eivs/2knyZpriIHmyn90sUpkTxNI6TQ3SEm6AS4oRnU7jj9MbOMMd/Zm9hhE9N8V
         eU1Q==
X-Gm-Message-State: APjAAAWxBzYgCf2NOeVDN3hjphJ3KfvBz6gofT0nybBVhl0Il4UYrZHl
        /usmnSefoRhbXxZFWVHqggIrKw==
X-Google-Smtp-Source: APXvYqxr7U5iMINGzaLcpnUhV5vvDu+v79cBheEV2BWbod9IlB4d2dpJ4rUyizeWdQ0pkITl4LBVqA==
X-Received: by 2002:ac8:478b:: with SMTP id k11mr15016996qtq.323.1567169015108;
        Fri, 30 Aug 2019 05:43:35 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-216-168.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.216.168])
        by smtp.gmail.com with ESMTPSA id d134sm2141239qkg.133.2019.08.30.05.43.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Aug 2019 05:43:34 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i3gFa-0003Cg-4Q; Fri, 30 Aug 2019 09:43:34 -0300
Date:   Fri, 30 Aug 2019 09:43:34 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Seunghun Han <kkamagui@gmail.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] tpm: tpm_crb: enhance resource mapping mechanism for
 supporting AMD's fTPM
Message-ID: <20190830124334.GA10004@ziepe.ca>
References: <20190830095639.4562-1-kkamagui@gmail.com>
 <20190830095639.4562-3-kkamagui@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190830095639.4562-3-kkamagui@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Aug 30, 2019 at 06:56:39PM +0900, Seunghun Han wrote:
> I got an AMD system which had a Ryzen Threadripper 1950X and MSI
> mainboard, and I had a problem with AMD's fTPM. My machine showed an error
> message below, and the fTPM didn't work because of it.
> 
> [  5.732084] tpm_crb MSFT0101:00: can't request region for resource
>              [mem 0x79b4f000-0x79b4ffff]
> [  5.732089] tpm_crb: probe of MSFT0101:00 failed with error -16
> 
> When I saw the iomem, I found two fTPM regions were in the ACPI NVS area. 
> The regions are below.
> 
> 79a39000-79b6afff : ACPI Non-volatile Storage
>   79b4b000-79b4bfff : MSFT0101:00
>   79b4f000-79b4ffff : MSFT0101:00
> 
> After analyzing this issue, I found that crb_map_io() function called
> devm_ioremap_resource() and it failed. The ACPI NVS didn't allow the TPM
> CRB driver to assign a resource in it because a busy bit was set to
> the ACPI NVS area.
> 
> To support AMD's fTPM, I added a function to check intersects between
> the TPM region and ACPI NVS before it mapped the region. If some
> intersects are detected, the function just calls devm_ioremap() for
> a workaround. If there is no intersect, it calls devm_ioremap_resource().
> 
> Signed-off-by: Seunghun Han <kkamagui@gmail.com>
> ---
>  drivers/char/tpm/tpm_crb.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)

This still seems to result in two drivers controlling the same
memory. Does this create bugs and races during resume?

Jason
