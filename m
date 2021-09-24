Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 735DB4175F4
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Sep 2021 15:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346618AbhIXNgc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 24 Sep 2021 09:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346289AbhIXNg3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 24 Sep 2021 09:36:29 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7803DC06129F
        for <linux-integrity@vger.kernel.org>; Fri, 24 Sep 2021 06:33:23 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id l13so9409598qtv.3
        for <linux-integrity@vger.kernel.org>; Fri, 24 Sep 2021 06:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=f7PJQ49f2XQNsVpC/1cTituVVFDqoofyOlji1lyJ65Y=;
        b=MPJHXJSK62fiV7bY72s9psPD0qwrmH4+DSCY4SIpcq1V/qq7c2BkdfsmcaxbnZE5i3
         /DvF7FLnGlJFR6hfvLptQEy4IBMwpL963K/d7znelDInDKeXM0ZsyLxMQZHM7JZs5Ip0
         QynG3Y2Jovo34yHzcQ+gjUZ5rgopklx4kDUOC5yH5h4IbzUe6HYE4oTChIK1TS04Y5NT
         05EQCx9I1GD+unY3XX8rWaoIWbDoqEkxUd6D+SCxH47Tkt5pmURs2/PItpfgV9dwkNrl
         HYwRyR7RVlx5RtzLQAja7xmQJ5bm/9tbwJEXxjUi5kS/Fr4IkllyvWCWlP3oDNzBjA/6
         0qnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f7PJQ49f2XQNsVpC/1cTituVVFDqoofyOlji1lyJ65Y=;
        b=3RvVeS/Val9d8wcGuhbhq8q2GW1c+0XV8NrFoott7ios9vvssWO5AoueeMU18CATZU
         b1Q/KmwQKrmmyQXrI6nX3MNVlcBeBQ3X8Zt8EZzenWj3FJO3By1ew7YCG2fDdAtjHaLq
         eroQu0v2EpjCVRP7t6LYQHpKiSNbiYw2XKoAGCP6M/JNkH7/WH6ToqjfN93fwADHc3qz
         CD3EWOrXckadFyoGmtP2Xe26BW3lPKuFbv04Hmdc1A1Cye0s2ngmSC+jpuumjcKNcK59
         IaWtW5kmm3jrmO7OU/eqWIFSNHO3u4A/HhEY8kLY6MDuIDZttGWQI5vSqJNGhHv4CEzB
         +eLg==
X-Gm-Message-State: AOAM5307JMyGQxQvvhcsINH72rACG1v2NGaTMdEE14Q1si4qnvelnLiz
        aV+69KLS8pnkUkRcA4GCXASfog==
X-Google-Smtp-Source: ABdhPJzGALBkia0iPtmjNoAr7JPtYRFEawKuGcqgeqOKn7YKM4EhxGhO7qWobDM3jezsg5ZghKh7lA==
X-Received: by 2002:ac8:687:: with SMTP id f7mr4255449qth.165.1632490402674;
        Fri, 24 Sep 2021 06:33:22 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id d11sm862534qtb.39.2021.09.24.06.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 06:33:21 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mTlKL-005A7W-6H; Fri, 24 Sep 2021 10:33:21 -0300
Date:   Fri, 24 Sep 2021 10:33:21 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>, peterhuewe@gmx.de,
        p.rosenberger@kunbus.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] tpm: fix potential NULL pointer access in
 tpm_del_char_device()
Message-ID: <20210924133321.GX3544071@ziepe.ca>
References: <20210910180451.19314-1-LinoSanfilippo@gmx.de>
 <204a438b6db54060d03689389d6663b0d4ca815d.camel@kernel.org>
 <trinity-27f56ffd-504a-4c34-9cda-0953ccc459a3-1631566430623@3c-app-gmx-bs69>
 <c22d2878f9816000c33f5349e7256cadae22b400.camel@kernel.org>
 <50bd6224-0f01-ca50-af0e-f79b933e7998@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50bd6224-0f01-ca50-af0e-f79b933e7998@gmx.de>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Sep 24, 2021 at 03:29:46PM +0200, Lino Sanfilippo wrote:

> So this bug is triggered when the bcm2835 drivers shutdown() function is called since this
> driver does something quite unusual: it unregisters the spi controller in its shutdown()
> handler.

This seems wrong

Jason
