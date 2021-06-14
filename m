Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6AC3A5DA6
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Jun 2021 09:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbhFNH0C (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 14 Jun 2021 03:26:02 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51]:36547 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232475AbhFNHZ6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Jun 2021 03:25:58 -0400
Received: by mail-lf1-f51.google.com with SMTP id v22so19461103lfa.3
        for <linux-integrity@vger.kernel.org>; Mon, 14 Jun 2021 00:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TuRZz017BBgAVMKoaGy8N3HYwV0bwLZwAUPuHJ32orA=;
        b=j3sOCJmU0K3TcI1KaLS+R0w+7P4R3fFjhK6QrhK/0X3pmdqGTXcLOu9Mh+/PRHiVjp
         ng8pGzd/d32BjnDvgz6z8K4NIdl6EGusDd9sTUM093jnnIl6qvkKH2Ska/1JVnQ5QSvP
         g4sBX5WqMiYo3up8gTRaq9Qk3U1/Qdqyx7dfO39kNGcg7OHhT916iippBIYouH9gKV+h
         OcvehJpHou6mwIp9dmXDM6GxIG05eKdOJnvYX0Ojkc45xTt2BB6mzP3+7QELscdwKobF
         AJLVee+P8OlUIGuy3x/mFcZm6E5dfkT4graQf5gbDGqgxzRopeT2tj51qBCyhMJc2/E3
         9V5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TuRZz017BBgAVMKoaGy8N3HYwV0bwLZwAUPuHJ32orA=;
        b=C963FskcGfCjBtrjaGfl/ed+efsQuFqUO3UGKguc0tdTmr5vFlnug6MunUs2j44qKS
         qsL1lqLxzKfQI3ZJvgeuzvbacTHgF19aO/SRHAqldx1ggsb2hcSlNBlBMS2OkiKJeVw8
         YV55bLIZ+6fdFRBCTl90//+MoZ08Rs+MM4+uVektfV8zRP8AAnmkHSZZDCpoKJNOQ9vM
         v7eRBbQuwGbwMXPs2SHkXXeXwqxJCDHvmDvaM9h9jB9u1G0D/naOooTY8rWO/9OFTJIl
         cmM84a/yUp7lB7ksFKFjhRlwbeNkaziRNCPgR9wN3RU0F7VFoUDbzJ8HINeIjxRbjeHH
         bWWw==
X-Gm-Message-State: AOAM532c8IlOT2jsl3alGk5L1psTFVSMx+AQNPdJ9hWpf2JIGvmr89hm
        3vnlLO8G1v488KNoLkDhgWuS9A==
X-Google-Smtp-Source: ABdhPJyqZXHBxomzhuOZfIuf8Zs1x2UeitiGj4p9X56ysLMGca0c8XfXDemfx0jK2rmoRfMdEvLh9w==
X-Received: by 2002:a19:5e5b:: with SMTP id z27mr7650041lfi.403.1623655374886;
        Mon, 14 Jun 2021 00:22:54 -0700 (PDT)
Received: from jade (h-79-136-85-3.A175.priv.bahnhof.se. [79.136.85.3])
        by smtp.gmail.com with ESMTPSA id v2sm1390309lfi.115.2021.06.14.00.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 00:22:54 -0700 (PDT)
Date:   Mon, 14 Jun 2021 09:22:52 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     Allen Pais <apais@linux.microsoft.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Vikas Gupta <vikas.gupta@broadcom.com>,
        Thirupathaiah Annapureddy <thiruan@microsoft.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        op-tee@lists.trustedfirmware.org, linux-integrity@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/8] optee: fix tee out of memory failure seen during
 kexec reboot
Message-ID: <20210614072252.GB1033436@jade>
References: <20210610210913.536081-1-tyhicks@linux.microsoft.com>
 <20210610210913.536081-4-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210610210913.536081-4-tyhicks@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 10, 2021 at 04:09:08PM -0500, Tyler Hicks wrote:
> From: Allen Pais <apais@linux.microsoft.com>
> 
> The following out of memory errors are seen on kexec reboot
> from the optee core.
> 
> [    0.368428] tee_bnxt_fw optee-clnt0: tee_shm_alloc failed
> [    0.368461] tee_bnxt_fw: probe of optee-clnt0 failed with error -22
> 
> tee_shm_release() is not invoked on dma shm buffer.
> 
> Implement .shutdown() method to handle the release of the buffers
> correctly.
> 
> More info:
> https://github.com/OP-TEE/optee_os/issues/3637
> 
> Signed-off-by: Allen Pais <apais@linux.microsoft.com>
> Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> ---
>  drivers/tee/optee/core.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)

Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>
