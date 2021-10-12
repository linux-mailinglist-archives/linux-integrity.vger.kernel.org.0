Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3775942A8B4
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Oct 2021 17:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237417AbhJLPp3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 Oct 2021 11:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236864AbhJLPp2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Oct 2021 11:45:28 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDADC061570
        for <linux-integrity@vger.kernel.org>; Tue, 12 Oct 2021 08:43:26 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id n12so3417867qvk.3
        for <linux-integrity@vger.kernel.org>; Tue, 12 Oct 2021 08:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pYzGaaVTDb6cjnLawGS3ll6xPJPKRnUFVY4pJMEW1qQ=;
        b=aXxWWEmI7otvwPSXfEK6Hzf87wzKANGFEo45FY8A5C5F/h6dYa4niGwH6wB4OefJP7
         5rjqaqb+N1m6rYoY232wpw522TUOaeDueRMMQpwLt/TU1Djr6C3feMO6grpFtugxJD45
         x2IoyBLU8DjZkcFVlxjV7cbdXr3LfaofguD3yiwlMIA0KDUguZsm/uI4Bwfo4yIFQDqW
         VXa5ysmgc8uaDXjB+oKfD6wSswbZ6CJ4CFGHrclrSq/NpFwb31T1p6HixV+iX8t0Fswg
         GbHvcsIfXK9lbO+NOAhnljTfUI+InlE5qHq/udfKbcZI+B0LQzCrjaUtW3q7IlJR56EY
         CBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pYzGaaVTDb6cjnLawGS3ll6xPJPKRnUFVY4pJMEW1qQ=;
        b=2ZgXohVwcP4hoZgnjKH9bhwUaMX3LVYTwxYAoayKGxA56rQFuH+YGDscoeNM/Bfyz5
         /CB+S2Kys839BYmBTqDBhXJktNVU51mtwAPpmWlt+0+CpFHOCs9mfqLqMFDPyM364LPU
         7cHRm2Vu1MRCdPY12MDMWSh42KO1Dpf8trQhnoO8Fb2wjjP0XaIytp/u1JgU8DEtEpUj
         m9BFLcuzGF2rPqpUWsFFQb91kbJwR3tYNEUMhl6Pk3MmDXVK7sgWwWHfA+eaXayZsz19
         8/VaPv1oez6JqWpwr0xIYAQD5a84Q381oNeQsWw0ETKctPBjBnfH0wHOTpHxDfPzA+NA
         7ILQ==
X-Gm-Message-State: AOAM531zYMw+nQotzlBdOfWwgmDu/gA3KHqwM6eQ2u7Rr/wgbFcxK4qR
        c3FveMUJxJMgREfegwouavG6wA==
X-Google-Smtp-Source: ABdhPJwPhb77RUSTUgx+dYlcH/kH6JCVlV0vZdQvL4ujvMOtPs7lOUE6uHP/FvBNXymMTKqHTHHqlg==
X-Received: by 2002:ad4:476a:: with SMTP id d10mr30843885qvx.20.1634053406063;
        Tue, 12 Oct 2021 08:43:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id p9sm3138728qki.51.2021.10.12.08.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 08:43:25 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1maJw5-00E4Wt-0H; Tue, 12 Oct 2021 12:43:25 -0300
Date:   Tue, 12 Oct 2021 12:43:25 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Cai Huoqing <caihuoqing@baidu.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Peter Huewe <peterhuewe@gmx.de>, linuxppc-dev@lists.ozlabs.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: ibmvtpm: Make use of dma_alloc_coherent()
Message-ID: <20211012154325.GI2688930@ziepe.ca>
References: <20211010160147.590-1-caihuoqing@baidu.com>
 <31619f2f192a4f1584e458f468422cf6e8f7542f.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31619f2f192a4f1584e458f468422cf6e8f7542f.camel@kernel.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Oct 12, 2021 at 06:29:58PM +0300, Jarkko Sakkinen wrote:
> On Mon, 2021-10-11 at 00:01 +0800, Cai Huoqing wrote:
> > Replacing kmalloc/kfree/get_zeroed_page/free_page/dma_map_single/
>   ~~~~~~~~~
>   Replace
> 
> > dma_unmap_single() with dma_alloc_coherent/dma_free_coherent()
> > helps to reduce code size, and simplify the code, and coherent
> > DMA will not clear the cache every time.
> > 
> > Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> 
> If this does not do functionally anything useful, there's no
> reason to apply this.

At least in this case it looks like the ibmvtpm is not using the DMA
API properly. There is no sync after each data transfer. Replacing
this wrong usage with the coherent API is reasonable.

Jason
