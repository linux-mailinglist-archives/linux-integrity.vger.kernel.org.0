Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88A1C393342
	for <lists+linux-integrity@lfdr.de>; Thu, 27 May 2021 18:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234756AbhE0QNe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 May 2021 12:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235148AbhE0QNc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 May 2021 12:13:32 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42725C061574
        for <linux-integrity@vger.kernel.org>; Thu, 27 May 2021 09:11:59 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id 76so1136852qkn.13
        for <linux-integrity@vger.kernel.org>; Thu, 27 May 2021 09:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1DCYsxPcwgz6wGBXKddPfgeFqjOqmPMV5wFOCxRJ+3A=;
        b=PngmZ1AInSHpKNoMvNBtIfyeQ/6Llk/gXeRI9Pd0xGn54rwNOD/XdwequEEpKUbM53
         6VlYrgeQs1Wi1y9TNmxlBivIkc8Si+ODQGVBXt+Ie0XI6nBRrOqUSTLPB2U83Sk0pWju
         4Rzy6Q6+G5uqk1pkzlP2nb9SxHeLPmPRRS2IsmZT/Yg/cCbcMzATIstA5PS9jp/YNwFb
         kfvokaxjIB6487ZnmGgCD2xOLe54oPJmjKTpqFjrBnf6WMAhBE3kXD7F6XmsGPQlXIik
         VmLapHyeddMc5C2ybH8Jcd/IrWAI3N8u6eOXcKxlYY1qIaFgqRT/MiFqZQmMOGuJWA9U
         zGzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1DCYsxPcwgz6wGBXKddPfgeFqjOqmPMV5wFOCxRJ+3A=;
        b=KWUH0n5KRffMa8xjolQfRzkMb5Xll0RwizRizySqA/paU2fRoWhgFuJfHXnsd/prRw
         z/ALfdF3e9PWDHER1LVV6T1e/ZYrAVkVossAtk2IhS21lkhs33PjjU744LpwS9jxCe/k
         5yyihSRiA+A/4NzVmhUSL4x9uzCBf8wj6E5Iq5V+Cf9NV+Z2RjIMQ9V/GD9VqHGt1CPP
         8EM2LVK2PxjqJipJ5jn3p5Pvi7tswOWttYrtHOTYBwGbuOXcO/tC1Z3zFa40XIoWICs3
         5DaYV4gdwJt6PWpLcTx76SP0EkqXtJZ5onS6xi1ekq4w9PIZCWzpTnkvDlAw9G9blsoL
         HyCQ==
X-Gm-Message-State: AOAM533vXtUxhpijUncfQEnPMJcPnxwVGEoBBwtqhnpUO4wPgLA2fwQv
        6uhxTP4W1MzBBrQ1XwnhR/b+ew==
X-Google-Smtp-Source: ABdhPJxSGGCq2RcvTVfyqdH4MeLuYORIVug/LGCAqFWth8scx61JtGxD+Zd0VUKM5Xo7RbDMK1wHOQ==
X-Received: by 2002:a37:6645:: with SMTP id a66mr4272666qkc.314.1622131918489;
        Thu, 27 May 2021 09:11:58 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id x9sm1587665qto.33.2021.05.27.09.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 09:11:57 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lmIc0-00Fc4q-Ni; Thu, 27 May 2021 13:11:56 -0300
Date:   Thu, 27 May 2021 13:11:56 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Wellbrock <a.wellbrock@mailbox.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Peter Robinson <pbrobinson@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm_tis_spi: add missing SPI device ID entries
Message-ID: <20210527161156.GH1096940@ziepe.ca>
References: <20210527152352.3835076-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210527152352.3835076-1-javierm@redhat.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, May 27, 2021 at 05:23:52PM +0200, Javier Martinez Canillas wrote:
> The SPI core always reports a "MODALIAS=spi:<foo>", even if the device was
> registered via OF. This means that this module won't auto-load if a DT has
> for example has a node with a compatible "infineon,slb9670" string.

Really? Then why do we have of_tis_spi_match and why does spi have an
of_match_table?

Jason
