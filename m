Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71D436606B
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Jul 2019 22:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbfGKULF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 11 Jul 2019 16:11:05 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44362 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728554AbfGKULF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Jul 2019 16:11:05 -0400
Received: by mail-wr1-f66.google.com with SMTP id p17so7581436wrf.11
        for <linux-integrity@vger.kernel.org>; Thu, 11 Jul 2019 13:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JEDDV86sPR8FRgxFWuhkGy+3eyqHIGbOW1QO5T3V+YE=;
        b=df/qOs9gghLYnK5io9SbPuJPNjkVPE9LUc+HbjUTrXgRMd3hmRHKEjLeyaGo/GsisT
         7nSw45WqX7KInvc5D3F0EnKCn4TI+dPq0Y2VCyar322LEgSPkOAwnqhxSo4XkKpKrWv5
         vDxa10fr1xsvRt+I1E235vP2bS1odcAmG4ThqXwHtGYpowcDVTvFKUzNv/aB5LYvL7RY
         e+aPgiU3I7FZPtrjMAzIIEnPj7ad2nCa+NJ3cbXCiKgWUqme0XfQLBoHauvElYxstmor
         oCDMizugt3k/80xQAq5vOlrWjZe98NNmxSUYcJWJIiZ6PJQh9GgkqlIwQkgLRljUpm/N
         5Yeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JEDDV86sPR8FRgxFWuhkGy+3eyqHIGbOW1QO5T3V+YE=;
        b=lxdP5vSdhtlyx78nUiZY7TqCOG80z3kMrxiDSYW1K1s7mKVWTB0z4wf3w/EHU4muC+
         G2Zmc9lSGSwQXGiytS3g5z5Vkt8zmdHDUzdUvkBGpqjpE38aPrpfND/3Ot94a9tsXjZw
         h7rNuYfV0xheE2N8wst0raqEpxuoaleBlQ0cFTzkBq37x0LHzERXiF9fYbbR/Ugtrci5
         1Syg7GSEMNjubHDJuFlduk9tp7i+HKqI9BcCKFj3s7vuZcMNC/mqqzQlXDWyVA0aDRTf
         jL5x+/AuztkCBi5H4epXiMZvyGji51yPbTiCWudwE7Hz0swW9okqOJDY9Vx19ssjv6SS
         IpOQ==
X-Gm-Message-State: APjAAAWWTZNCp1vx7KUR65ih49HJyqQa8ILCE7EngktTM/EXfVIgXTrg
        60Vwr5nwt4sUHm8ktluKSetpnQ==
X-Google-Smtp-Source: APXvYqyUBBOu66wNAd0BTSpA/H1oaEclZcNUAp7t/EtuW3X4zQQ83iMw4MTEh5VduNaCWHpH1jXwPA==
X-Received: by 2002:a5d:6b07:: with SMTP id v7mr6828693wrw.169.1562875863136;
        Thu, 11 Jul 2019 13:11:03 -0700 (PDT)
Received: from apalos (athedsl-428434.home.otenet.gr. [79.131.225.144])
        by smtp.gmail.com with ESMTPSA id k124sm9605135wmk.47.2019.07.11.13.11.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 13:11:02 -0700 (PDT)
Date:   Thu, 11 Jul 2019 23:10:59 +0300
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Sasha Levin <sashal@kernel.org>, peterhuewe@gmx.de, jgg@ziepe.ca,
        corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@microsoft.com, thiruan@microsoft.com,
        bryankel@microsoft.com, tee-dev@lists.linaro.org,
        sumit.garg@linaro.org, rdunlap@infradead.org
Subject: Re: [PATCH v8 0/2] fTPM: firmware TPM running in TEE
Message-ID: <20190711201059.GA18260@apalos>
References: <20190705204746.27543-1-sashal@kernel.org>
 <20190711200858.xydm3wujikufxjcw@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190711200858.xydm3wujikufxjcw@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jul 11, 2019 at 11:08:58PM +0300, Jarkko Sakkinen wrote:
> On Fri, Jul 05, 2019 at 04:47:44PM -0400, Sasha Levin wrote:
> > Changes from v7:
> > 
> >  - Address Jarkko's comments.
> > 
> > Sasha Levin (2):
> >   fTPM: firmware TPM running in TEE
> >   fTPM: add documentation for ftpm driver
> > 
> >  Documentation/security/tpm/index.rst        |   1 +
> >  Documentation/security/tpm/tpm_ftpm_tee.rst |  27 ++
> >  drivers/char/tpm/Kconfig                    |   5 +
> >  drivers/char/tpm/Makefile                   |   1 +
> >  drivers/char/tpm/tpm_ftpm_tee.c             | 350 ++++++++++++++++++++
> >  drivers/char/tpm/tpm_ftpm_tee.h             |  40 +++
> >  6 files changed, 424 insertions(+)
> >  create mode 100644 Documentation/security/tpm/tpm_ftpm_tee.rst
> >  create mode 100644 drivers/char/tpm/tpm_ftpm_tee.c
> >  create mode 100644 drivers/char/tpm/tpm_ftpm_tee.h
> > 
> > -- 
> > 2.20.1
> > 
> 
> I applied the patches now. Appreciate a lot the patience with these.
> Thank you.
> 

Will report back any issues when we start using it on real hardware
rather than QEMU

Thanks
/Ilias
> /Jarkko
