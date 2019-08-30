Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF81A395F
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Aug 2019 16:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbfH3Oiz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Aug 2019 10:38:55 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35570 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727751AbfH3Oiz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Aug 2019 10:38:55 -0400
Received: by mail-io1-f65.google.com with SMTP id b10so14501204ioj.2
        for <linux-integrity@vger.kernel.org>; Fri, 30 Aug 2019 07:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jgvuX3mMmDJc/ezKItSFjRT6UTB3DxucqcXRUOj/zcI=;
        b=GXget5QqWcoVV20hrVl8z/734YXraq2fUD3DzCUj4gl3uabBS3UFzNf0ba0+YCbay7
         vog1JwlLXNOx8mQxUYV/a6YYm26t8RUPUGzw0MK0LVwAOcTOOB21n0qyBcqS0UjvNlOC
         kQgMcdNGGedkmoMSRrFZGpqfeWpLuSSe3EF8GyZyi/wEJCPDdTvPpw17Wht04TveC1LX
         qHFRlVmfR9Oic2M2iuBThZOXT14BchHEbKos5E0eQUDBc1ZjuuEjPVy+8VloXQnBs3p8
         dvN5ignrb8HBn2yxAA7tN9/746wKC7bfpUsRVbEfGj8+U3HevUHZ+FMJhQl6rzi+eMRR
         bNng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jgvuX3mMmDJc/ezKItSFjRT6UTB3DxucqcXRUOj/zcI=;
        b=MT0wP0laktBwmi/G9tyhqy3XcwBzivpk1jcnNF1eaQzgzABE3GPA+L3Ljfhww41/Ne
         h9Zof+q0DB5M0T9YxH6L7Q7DiW7hFYRQvB6FFLSIHjkty3ufJ7+90lEOmuFNZ29EqB0n
         VSFEdhPnLKEDglvqVxRySDNNc0Nrl10F/43iVFUAchLmr3NaWA7yKxHGIJohwZY1PDCL
         9PSwuSJLesnK3hR3UVO3rPCzuHW8xwwuTVJkB+0YsEP8Ec6UM0aGxzXKVoDQMDUz+xVV
         Inu+TpyqbOiVlIu9S3+Sopnry4ZwSIWSGoHNCZnT9M8cZ+UCCYzKU76j4uHi8OnzTB9O
         RE9w==
X-Gm-Message-State: APjAAAW3+FfHowcksM7VcRh30lux8klSkcrf6K4476blYngkGigUdsPk
        QWXx/5KiTnEEZQSU7otqXEURGQ==
X-Google-Smtp-Source: APXvYqwqV4sqIOnC5JkzIybJh2aOhL5g7B/SiCPWu7FObtesW0RDKSiaWPbQGgAkjnQniKe/QwNt5w==
X-Received: by 2002:a5d:9282:: with SMTP id s2mr4066iom.283.1567175934280;
        Fri, 30 Aug 2019 07:38:54 -0700 (PDT)
Received: from ziepe.ca ([142.177.133.130])
        by smtp.gmail.com with ESMTPSA id z9sm8093916ior.79.2019.08.30.07.38.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Aug 2019 07:38:53 -0700 (PDT)
Received: from jgg by LT-JGG-7470.mtl.com with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i3i3A-00005B-SD; Fri, 30 Aug 2019 11:38:52 -0300
Date:   Fri, 30 Aug 2019 11:38:52 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Seunghun Han <kkamagui@gmail.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] tpm: tpm_crb: enhance resource mapping mechanism for
 supporting AMD's fTPM
Message-ID: <20190830143852.GA302@ziepe.ca>
References: <20190830095639.4562-1-kkamagui@gmail.com>
 <20190830095639.4562-3-kkamagui@gmail.com>
 <20190830124334.GA10004@ziepe.ca>
 <CAHjaAcQ0MrPCZUit7s0Rmqpwpp0w5jiYjNUNEEm2yc1AejZ3ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHjaAcQ0MrPCZUit7s0Rmqpwpp0w5jiYjNUNEEm2yc1AejZ3ng@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Aug 30, 2019 at 10:54:59PM +0900, Seunghun Han wrote:

> When I tested this patch in my machine, it seemed that ACPI NVS was
> saved after TPM CRB driver sent "TPM2_Shutdown(STATE)" to the fTPM
> while suspending. Then, ACPI NVS was restored while resuming.
> After resuming, PCRs didn't change and TPM2 tools such as
> tpm2_pcrlist, tpm2_extend, tpm2_getrandoms worked well.
> So, according to my test result, it seems that the patch doesn't
> create bugs and race during resume.

I have a feeling that is shear luck of link time ordering and not guarenteed??	

Jason
