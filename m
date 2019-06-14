Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCC745A77
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Jun 2019 12:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfFNKeh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 14 Jun 2019 06:34:37 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52878 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbfFNKeg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 14 Jun 2019 06:34:36 -0400
Received: by mail-wm1-f66.google.com with SMTP id s3so1809493wms.2
        for <linux-integrity@vger.kernel.org>; Fri, 14 Jun 2019 03:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VQlYOuWw/XgKJ5lYOlgzDNhtem0wEWO83AzsJk5siJw=;
        b=CFkz0AWBLH3qM/wTX9/0rbnEGIdGMhwqDq25JmOGJSDvCx9ui0dw9bqgpr1ksw+LT6
         VMXk2sllUNdudRlnQH2Z9jYfoaJjzBK0BdkpGhugaQ59wtMT7Fi1LQBmUAcNx7u/Q6pU
         woUjMPVk5GtD8+dGjT/59hrYjznvzD+kfru+iCm4Tz+MtFEks/RA/Kl9F9z+YnEp4Rj6
         sL4tqPfeAmH+cBDQDwBd7Dr9J45Vc23gasoIa+2gUZSSujFqmnL1Cd4a2nk5nisrD3o2
         zIEygEfF25IlZJQyz3E3gS73g0A/n8nN0PtL72QnwI6a6tCnEqMvkchTeYiJ1eSFbbrZ
         iG7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VQlYOuWw/XgKJ5lYOlgzDNhtem0wEWO83AzsJk5siJw=;
        b=CFaGwdlX7VF0S97wMpJ4ux2qhEU5HGdWo+SY2M0g1EbkyGPyq8sdW4xl9vsLQLrNFc
         R0z0yFPB9r8Hc89vITnsydJhi7yjnKqjGarFu2umRynkbIhQiBWKG40noKbRSf33z8hN
         6z+WYhe3EXpiXv1ru2e8jwZ7361G20iGqkdba6KH0LeEODmvEEW3kbiI93a46/CopCiO
         BLDWaGpePTRXxvHdHOVw3c4H73ksP3vuqyAbJpStPX9bf0gHbvDsQgG/fXWKM6uprbKd
         6saGsCUwma4qI9HeIUUGcMnZC8dz+nl2yu7yOhh1+UqPuzikelIAcQhj03/nUWkio8H5
         QmFw==
X-Gm-Message-State: APjAAAWhHYeIzVgNzDLR5XVYBt18+OsdnPZvwuGonvN7X5gOofDdhNJU
        IpvRVIQs9MIJNwa/KW9Lq3v2hg==
X-Google-Smtp-Source: APXvYqzMy7f04xPUuO0lEJs4Zkj7eAmy4TPUQhawhEeebqMCl/nBD1FiRvyH776EUxFte8zki3W9TQ==
X-Received: by 2002:a7b:c933:: with SMTP id h19mr7726918wml.52.1560508474645;
        Fri, 14 Jun 2019 03:34:34 -0700 (PDT)
Received: from apalos (athedsl-4461147.home.otenet.gr. [94.71.2.75])
        by smtp.gmail.com with ESMTPSA id s10sm3938737wrw.45.2019.06.14.03.34.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 03:34:34 -0700 (PDT)
Date:   Fri, 14 Jun 2019 13:34:30 +0300
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Sumit Garg <sumit.garg@linaro.org>, peterhuewe@gmx.de,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        jgg@ziepe.ca, corbet@lwn.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        Microsoft Linux Kernel List <linux-kernel@microsoft.com>,
        Thirupathaiah Annapureddy <thiruan@microsoft.com>,
        "Bryan Kelly (CSI)" <bryankel@microsoft.com>,
        tee-dev@lists.linaro.org
Subject: Re: [PATCH v4 1/2] fTPM: firmware TPM running in TEE
Message-ID: <20190614103430.GA6108@apalos>
References: <20190530152758.16628-1-sashal@kernel.org>
 <20190530152758.16628-2-sashal@kernel.org>
 <CAFA6WYM1NrghG9qxUhrm76kopvBx9nmCL9XnRs11ysb2Yr0+Qw@mail.gmail.com>
 <20190604200951.GB29739@sasha-vm>
 <CAFA6WYMOjgHRw9RVrjherNo0ZNbTtEonPwSFFC0dT4CZO=A1NQ@mail.gmail.com>
 <20190613171141.GL1513@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613171141.GL1513@sasha-vm>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Sasha, 
On Thu, Jun 13, 2019 at 01:11:41PM -0400, Sasha Levin wrote:
> On Wed, Jun 05, 2019 at 04:39:36PM +0530, Sumit Garg wrote:
> >On Wed, 5 Jun 2019 at 01:39, Sasha Levin <sashal@kernel.org> wrote:
> >>
> >>On Tue, Jun 04, 2019 at 11:45:52AM +0530, Sumit Garg wrote:
> >>>On Thu, 30 May 2019 at 20:58, Sasha Levin <sashal@kernel.org> wrote:
> >>>> +       /* Open context with TEE driver */
> >>>> +       pvt_data->ctx = tee_client_open_context(NULL, ftpm_tee_match, NULL,
> >>>> +                                               NULL);
> >>>> +       if (IS_ERR(pvt_data->ctx)) {
> >>>> +               dev_err(dev, "%s:tee_client_open_context failed\n", __func__);
> >>>
> >>>Is this well tested? I see this misleading error multiple times as
> >>>follows although TEE driver works pretty well.
> >>
> >>Yes, this was all functionally tested.
I did test as well with a DeveloperBox, i can confirm the driver is loading (but
i have no fTPM support on the OP-TEE side for now)


apalos@mule:~>sudo dmesg | grep optee
[sudo] password for apalos: 
[    5.035801] optee: probing for conduit method from DT.
[    5.041045] optee: revision 3.2 (53bf1c38)
[    5.041772] optee: initialized driver
apalos@mule:~>sudo dmesg | grep tpm
[    5.000674] ftpm-tee tpm@0: ftpm_tee_probe:tee_client_open_context failed
[    5.101655] ftpm-tee tpm@0: ftpm_tee_probe:tee_client_open_session failed,
err=ffff000c
[    5.109703] ftpm-tee: probe of tpm@0 failed with error -22


The error -22 is nice since the probe eventually failed (no fTPM support in
secure world). Can we slightly change the
'ftpm_tee_probe:tee_client_open_context failed' and indicate this is not a real
error since the probe gets deferred untill Secure world is alive?

By the way there is *real* interest for this functionality. I expect to run it
on a number of Arm boards once i get some free time.

> >Can you share your build instructions and testing approach?
> 
> Yes: it looks like you got all the kernel bits, but not the firmware.
> There are instructions for it here: https://github.com/microsoft/ms-tpm-20-ref
> 
> Once it's running, you can test it by running your favorite TPM usecases
> through /dev/tpm0.
> 
> --
> Thanks,
> Sasha

Thanks
/Ilias
