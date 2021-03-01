Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEA032934A
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Mar 2021 22:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243179AbhCAVLw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 1 Mar 2021 16:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234078AbhCAVJr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Mar 2021 16:09:47 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E13C06178A;
        Mon,  1 Mar 2021 13:09:02 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id p21so27759752lfu.11;
        Mon, 01 Mar 2021 13:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RND9a8mDUQOYZaFLBcRyMzHxI6PVzRgVXmxJa2P7jiQ=;
        b=m7bi2qaD3tTk3Q3CYW/irTFcbzzSdk6/Y3EN+Am97dpuN9qZ9rcAoalHJMBgjF2+Dh
         SdNJbw5Qe07zsDx00GLE/21MfUiuLqqTAITVHy37prAMuQpq/Hoyret//bbVbV2aIwIf
         9LtgWa30dwEmfOehnMIBBPPhv3Q31WxcJszPm5niBtcpXTWo5MfQLBvP4xFZvQmlmwFT
         ETxuwsMrcSwcGrtcsqsAKqURfSjjpdm6Kut0LXUlMkyLT7/zr9ccWW8mWi+o7zpTTIWS
         7fsWj1BUVOT1y7Tz0/BDMWaA0LDEzb5UMapLv4E55PUkjuLmxINxtfS1G9Mjn2tyy9so
         7kww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RND9a8mDUQOYZaFLBcRyMzHxI6PVzRgVXmxJa2P7jiQ=;
        b=nJfuj3NGMWB60gR2n+IOa2EyLYsP5lz+2mkxjtfrE6WI7BA2E5lGWijXcWsjh6LoOv
         NvWU+pHQCNr9W4uVSYNpFJdOJMmhGCk1OrcYzOq2N3t9+vdUvn8DQ9CszE/LNMX+if8n
         VtQrtOA002VO9EpGdDiTgMlPPYNN6ttcsPw2yDpG15B0uVA3gbcjfv5Ag9VbMR9+uJb7
         o0LQFaG69tyQa62K9F2VImMzYHZ3YbFoHibauPSE09Y2N8XSzwcpwb3Oj7fcjlJkKrpF
         F7j6FNwldzHm+xg+eSwvmsCXcTYiqwG2NWQiM8AS5kcIm7LE/WZr2a4aCsMeDI0pQ3bu
         A7Pg==
X-Gm-Message-State: AOAM5326TBygpr1kA0WZlelJzNu/h0d3/AXYtYK9f2k6CUeMZ0YR74pF
        R/01qpVf+AzZCg0fZtpE1bI=
X-Google-Smtp-Source: ABdhPJxPhVzOfx4HqFyxNGMBXwQ8vqAzu5SGYTtv64rsO+8zHlJl5gGs+d1atpjxpzRIBs46qskz8w==
X-Received: by 2002:a19:8b41:: with SMTP id n62mr10493293lfd.380.1614632941148;
        Mon, 01 Mar 2021 13:09:01 -0800 (PST)
Received: from rikard (h-98-128-229-129.NA.cust.bahnhof.se. [98.128.229.129])
        by smtp.gmail.com with ESMTPSA id a3sm1312086lfr.55.2021.03.01.13.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 13:09:00 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
X-Google-Original-From: Rikard Falkeborn <rikard.falkeborn>
Date:   Mon, 1 Mar 2021 22:08:55 +0100
To:     jarkko@kernel.org
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] tpm: Remove unintentional dump_stack() call
Message-ID: <YD1X553fpbyl7Kbw@rikard>
References: <20210301094409.14380-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210301094409.14380-1-jarkko@kernel.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Mar 01, 2021 at 11:44:09AM +0200, jarkko@kernel.org wrote:
> From: Jarkko Sakkinen <jarkko@kernel.org>
> 
> Somewhere along the line, probably during a rebase, an unintentional
> dump_stack() got included. Revert this change.
> 
> Reported-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> Fixes: 90cba8d20f8b ("tpm/ppi: Constify static struct attribute_group")
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
>  drivers/char/tpm/tpm-chip.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 19e23fcc6bc8..ddaeceb7e109 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -278,8 +278,6 @@ static void tpm_devs_release(struct device *dev)
>  {
>  	struct tpm_chip *chip = container_of(dev, struct tpm_chip, devs);
>  
> -	dump_stack();
> -
>  	/* release the master device reference */
>  	put_device(&chip->dev);
>  }
> -- 
> 2.30.1
> 

Acked-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
