Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D691835AE4
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Jun 2019 13:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbfFELJt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 Jun 2019 07:09:49 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:47053 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727263AbfFELJs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 Jun 2019 07:09:48 -0400
Received: by mail-ua1-f68.google.com with SMTP id a95so8905827uaa.13
        for <linux-integrity@vger.kernel.org>; Wed, 05 Jun 2019 04:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Y5HwIx3fzDChQujd1N/5M1n45Hod1+PxY2t0oBRnBQ=;
        b=jhg4g22mJsIJvSlpDwP+93DagHN+KMBYeEa0gjvpcvW9hE8IebuAfQu6rIDc8B45B1
         XbEI/BLU5MONyvFQP1CG6k11hw9WvO3UVwPQyQDweq/cXlpyI/xrJrKGtMCUEi0yucRL
         EDNpv0Hx/DwO4NnyyjQhb9K4FwAK9YZBeHfIUvTKbWo6b4Tu2twDS+dCBIX6pit6VVzN
         BhqGZmCTYXKg5Ua28E7sahtqGTrnOq8ibMN8bPBQh+ZBEQ5cwsvIy4hEw49ox54iK0z0
         K0bMAW7vOlRJpoSf+x1ewWiRXnOjpdURRh4bNNAKucy4Maoul5kqPlmCw6CGIbT4xuEE
         se0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Y5HwIx3fzDChQujd1N/5M1n45Hod1+PxY2t0oBRnBQ=;
        b=tGPqMv8JDacMk2oyJk15Cay8VxjiXk6bh2olW8sX9joZ/jgWFtuhTIGel3A1z9sAXU
         3801o1D6QZstNcdR9WytZV0ASyWYfHtZ+MtqfxVNeZx+eiC0RlEj7i6OB1tavzf4/64Y
         yEd14iZQkdFjl7C3puWKNfEF2b5MY2axIM/fvSl1ylJMqZEFX+GaTbiHx6FRxqXEX90H
         +v/z03vtu9tY+O5mj8iPk78kWvDnTIM3/XKSHl1BkHJV6Db6rxZ88X/9Id3wFvKk4tdu
         zWHnARNYf0pC8/Ra4J0N+PB/SLfNG56zKuXkMYQO5GJIlqw2cBOrKSGdW28ujJ/YHnTU
         CVvw==
X-Gm-Message-State: APjAAAVG5HJXVMhupcYKnx9zgBP4XLLOkcuk/caXXX9arSiJTRA3x0mA
        dyDqmL50FLFprlRQTFaq1wI3hBlV2sIfKzJlGYs8sQ==
X-Google-Smtp-Source: APXvYqxAkbHwRdqB7xghLMjam6SVNoHl2PMlMYH9gCYZViKeRuwKt4rDsCauU6BAiCx5LxlKalIUzDm+9yk3JDGCnbQ=
X-Received: by 2002:ab0:238a:: with SMTP id b10mr14235309uan.52.1559732987905;
 Wed, 05 Jun 2019 04:09:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190530152758.16628-1-sashal@kernel.org> <20190530152758.16628-2-sashal@kernel.org>
 <CAFA6WYM1NrghG9qxUhrm76kopvBx9nmCL9XnRs11ysb2Yr0+Qw@mail.gmail.com> <20190604200951.GB29739@sasha-vm>
In-Reply-To: <20190604200951.GB29739@sasha-vm>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 5 Jun 2019 16:39:36 +0530
Message-ID: <CAFA6WYMOjgHRw9RVrjherNo0ZNbTtEonPwSFFC0dT4CZO=A1NQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] fTPM: firmware TPM running in TEE
To:     Sasha Levin <sashal@kernel.org>
Cc:     peterhuewe@gmx.de,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        jgg@ziepe.ca, corbet@lwn.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        Microsoft Linux Kernel List <linux-kernel@microsoft.com>,
        Thirupathaiah Annapureddy <thiruan@microsoft.com>,
        "Bryan Kelly (CSI)" <bryankel@microsoft.com>,
        tee-dev@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 5 Jun 2019 at 01:39, Sasha Levin <sashal@kernel.org> wrote:
>
> On Tue, Jun 04, 2019 at 11:45:52AM +0530, Sumit Garg wrote:
> >On Thu, 30 May 2019 at 20:58, Sasha Levin <sashal@kernel.org> wrote:
> >> +       /* Open context with TEE driver */
> >> +       pvt_data->ctx = tee_client_open_context(NULL, ftpm_tee_match, NULL,
> >> +                                               NULL);
> >> +       if (IS_ERR(pvt_data->ctx)) {
> >> +               dev_err(dev, "%s:tee_client_open_context failed\n", __func__);
> >
> >Is this well tested? I see this misleading error multiple times as
> >follows although TEE driver works pretty well.
>
> Yes, this was all functionally tested.

Can you share your build instructions and testing approach?

>
> Why is this error message misleading? I'd be happy to fix it.

IIUC, here you are trying to resolve dependency with OP-TEE driver
using "-EPROBE_DEFER". So user shouldn't be prompted with error
messages until OP-TEE driver comes up.

BTW, for me this OP-TEE driver dependency seems not to work, boot is
simply stuck waiting for device. Probably the reason being this fTPM
driver is a platform driver and OP-TEE NOT a platform driver.

>
> >Module built with "CONFIG_TCG_FTPM_TEE=y"
> >
> >[    1.436878] ftpm-tee tpm@0: ftpm_tee_probe:tee_client_open_context failed
> >[    1.509471] ftpm-tee tpm@0: ftpm_tee_probe:tee_client_open_context failed
> >[    1.517268] ftpm-tee tpm@0: ftpm_tee_probe:tee_client_open_context failed
> >[    1.525596] ftpm-tee tpm@0: ftpm_tee_probe:tee_client_open_context failed
>
> Does the TEE have the fTPM implementation and such? Could you provide
> details about your testing environment (hardware, fTPM verions, etc)?
>

I just did a sanity check on my arm64 machine (Developerbox), just
adding following DT node and enabled CONFIG_TCG_FTPM_TEE=y:

+    tpm@0 {
+        compatible = "microsoft,ftpm";
+    };

Basically with no fTPM TA, I expected the driver to fail during
"tee_client_open_session()" call with TA not found error and boot
should continue. But it fails during "tee_client_open_context()" which
opens a context with OP-TEE driver and has nothing to do with fTPM TA.

-Sumit

> --
> Thanks,
> Sasha
