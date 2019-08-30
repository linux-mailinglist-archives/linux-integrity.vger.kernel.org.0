Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E078A3BBB
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Aug 2019 18:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbfH3QNY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Aug 2019 12:13:24 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:40940 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728202AbfH3QNY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Aug 2019 12:13:24 -0400
Received: by mail-yb1-f194.google.com with SMTP id t15so2649563ybg.7;
        Fri, 30 Aug 2019 09:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jxavUzmR4j4QY4vF+5GYDteLHfU18c17qk0astXeeP8=;
        b=YULv0bFjeyounsVuhV7i2KEsAFrVn9IcJu+lmx6/Ml10Ln1qHiZje6PbDLzpuRoYWw
         S46lZ/MNFuMWSZlpPyTl02bSZPqkRfb9bkhBGNqAQFj2bkZkmAM7A1mHRirAVNh/Gna/
         1MFYpZn2WCIN4XUk7jjUmaA2B5wudQTys95LCLbDcznndluUctkDslijws6XmPpkDsTy
         WwXCEVhC1qaZj3OUm5r0XgmfmIosWpeYhVIsnd3jnsBM2Y95m8y2Xy3Zw6lGMAMYe0sg
         /b2kKx4chUULSB3p+GlJite2DR6bOuAuYq90dGPLsfRkApI9ICUQwTx6Wu9m/+21NuuK
         41SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jxavUzmR4j4QY4vF+5GYDteLHfU18c17qk0astXeeP8=;
        b=gV0pr55v6bdDXEW+Ix6GLwOUK9NsdBTZzkltR/8D6ZuerYn/D0NaBVN3brEBi2ttkM
         WbwIpH3zvCwKuq0o9OC70aoDzole0cgPV0XikT7vGpTvEd1vNpRmTYrpIO6Tm6HjZ0jH
         d3gybJqn0+QvFCB2mxs3fEL28Syx2+dHHitrW6CuMhllev7HuGjYNjSYCJMzUAuwgA6B
         gJ004PDBkDocY1HxoZPSu1cYXu2YlNaxS6E9iJJ6KsK4mgEm5/G3VfYp4sCBv1SO4erm
         Qqk8PZ1VlDEw4MdA9xLa68RcJx207Qe2eAgqvW77hTZLjT/+0D0RA5Vv6COQv8ROXdj9
         l8rQ==
X-Gm-Message-State: APjAAAU6i1Pky82/FIDhmI3pAUiy8nH7nWZGElkEOsy5UJ9F1hDpJc3m
        HYy6LGqVPw7VL5OkfxLvHM3rb6JnPycewDMRnnjn8Xy8
X-Google-Smtp-Source: APXvYqy5fIizkvflP77/xUWuXJZ1bCpNB9fIWDfTgrw9jBs2cK3N/Kg+2DA1Gt8TsX9SdzK/EGrfi8/nyJLXMvtUQtk=
X-Received: by 2002:a25:2f42:: with SMTP id v63mr11611956ybv.228.1567181602873;
 Fri, 30 Aug 2019 09:13:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190830095639.4562-1-kkamagui@gmail.com> <20190830095639.4562-3-kkamagui@gmail.com>
 <20190830124334.GA10004@ziepe.ca> <CAHjaAcQ0MrPCZUit7s0Rmqpwpp0w5jiYjNUNEEm2yc1AejZ3ng@mail.gmail.com>
 <20190830143852.GA302@ziepe.ca>
In-Reply-To: <20190830143852.GA302@ziepe.ca>
From:   Seunghun Han <kkamagui@gmail.com>
Date:   Sat, 31 Aug 2019 01:13:11 +0900
Message-ID: <CAHjaAcQyCgfc+JbVNa_ix1HY64K3NCY5octj26j=o64EDtPkGw@mail.gmail.com>
Subject: Re: [PATCH 2/2] tpm: tpm_crb: enhance resource mapping mechanism for
 supporting AMD's fTPM
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

>
> On Fri, Aug 30, 2019 at 10:54:59PM +0900, Seunghun Han wrote:
>
> > When I tested this patch in my machine, it seemed that ACPI NVS was
> > saved after TPM CRB driver sent "TPM2_Shutdown(STATE)" to the fTPM
> > while suspending. Then, ACPI NVS was restored while resuming.
> > After resuming, PCRs didn't change and TPM2 tools such as
> > tpm2_pcrlist, tpm2_extend, tpm2_getrandoms worked well.
> > So, according to my test result, it seems that the patch doesn't
> > create bugs and race during resume.
>
> I have a feeling that is shear luck of link time ordering and not guarenteed??
>
> Jason

No, it is guaranteed. As you know, suspend_nvs_save() is called by
acpi_pm_pre_suspend(), and it is called by
platform_suspend_prepare_noirq(). platform_suspend_prepare_noirq() is
also called by suspend_enter(), and it already suspends all devices
like TPM CRB driver before calling platform_suspend_prepare_noirq().
This means that the order is guaranteed and we don't need to worry about it.

Seunghun
