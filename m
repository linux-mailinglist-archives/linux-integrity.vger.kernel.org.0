Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8CB1467DD
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Jan 2020 13:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgAWMYL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 23 Jan 2020 07:24:11 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42042 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbgAWMYK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 23 Jan 2020 07:24:10 -0500
Received: by mail-wr1-f67.google.com with SMTP id q6so2822607wro.9
        for <linux-integrity@vger.kernel.org>; Thu, 23 Jan 2020 04:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aRCL8CXLlmFTGIYCIJvvzGt8RhcbFX8onxSEFC39pLg=;
        b=bPWrV2L6zXSCAka0nsq3AXmYmStWPCZOw6FqAC3Wi7Fj9VB6Wasl5uEkFWjml4tfCk
         9Ib74vYOV/xcE6mFhtqdgFzLJBpzEEwcFMzR2XGSXsr4TJ/dBgmPwqWLtUgCOxM/kT6o
         LhT8Oi8Eetck6727TSDRwaxnHG2NU3FTlCPU6goueVSnz9qjuxoEJnMFLvAuep/D9NfS
         TevHeta+AenlMWl5o0n9DY0UzVZdNd+Sy5xUuYrLMczRj10UILpFODrzfKaU8OEPPo7S
         UfFlQPkeohFBFw6hnpBSxPyXq57RterAp+bSy4D50/l+YarAzUI0M51qqf5wmRAL8VD8
         myzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aRCL8CXLlmFTGIYCIJvvzGt8RhcbFX8onxSEFC39pLg=;
        b=JulMfJUnvblUhcQE9rMeS6jiV/n682Jw0uqQv0XMYWRNcl5gN/6zCySUxl2lk8wwON
         tZZHQlfvvtUsXoubSYU/UWDwVvsuwhuKJZxywXfhXDI3D0/6jx7vGb5glHwOmMLeAA2a
         Fn4FKIZqmmIlIwneFC0HhHaWXyGoaOozII/o8U6sTYB1eqmqovh+JQlz9VyRA5CSpoVz
         uEbcsuT+X7oUZd8Z1nlLuJu2lYJ2SD3/qV/kgKQG8yUUcJQWLP2HgnNEw8votd6En3GK
         h4EdXeG/SZhd6lWxnSdGB1zLOFVzPTYJGOGYmpdc5XSLKWX9rFbVAldnH+Nty0NYr4n8
         T+gA==
X-Gm-Message-State: APjAAAVK4gYNUfchZ/m0kSoQ0nlZVzUS9COHdXZlLJbulVuxf++NV+k9
        U89ojR50mhwonppxx7J6vcry6mtLbUWPD/qnq5pzGSJ9Rq4=
X-Google-Smtp-Source: APXvYqznG0VbuLKScctM26duGop+x5oKIy8U/BxpchFYBRD/Ti2/Zk+F2VZOrzfyUjgQ8M1dxPxvSzT6kL/j40OwWok=
X-Received: by 2002:a5d:4d0e:: with SMTP id z14mr17531764wrt.208.1579782249072;
 Thu, 23 Jan 2020 04:24:09 -0800 (PST)
MIME-Version: 1.0
References: <20200114141647.109347-1-ardb@kernel.org> <20200114141647.109347-2-ardb@kernel.org>
 <0effdeeeccdb9544cc69f185fd23cd06828ae8fc.camel@linux.intel.com>
In-Reply-To: <0effdeeeccdb9544cc69f185fd23cd06828ae8fc.camel@linux.intel.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 23 Jan 2020 13:23:58 +0100
Message-ID: <CAKv+Gu_4Y18CF-h36JKKJrcdvUL8KM1YSbDTgED7kurgN6xk_w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: tpm-tis-mmio: add compatible string
 for SynQuacer TPM
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        =?UTF-8?Q?Peter_H=C3=BCwe?= <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 23 Jan 2020 at 13:22, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Tue, 2020-01-14 at 15:16 +0100, Ard Biesheuvel wrote:
> > Add a compatible string for the SynQuacer TPM to the binding for a
> > TPM exposed via a memory mapped TIS frame. The MMIO window behaves
> > slightly differently on this hardware, so it requires its own
> > identifier.
> >
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/security/tpm/tpm_tis_mmio.txt | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/security/tpm/tpm_tis_mmio.txt b/Documentation/devicetree/bindings/security/tpm/tpm_tis_mmio.txt
> > index 7c6304426da1..b604c8688dc8 100644
> > --- a/Documentation/devicetree/bindings/security/tpm/tpm_tis_mmio.txt
> > +++ b/Documentation/devicetree/bindings/security/tpm/tpm_tis_mmio.txt
> > @@ -12,6 +12,7 @@ Required properties:
> >  - compatible: should contain a string below for the chip, followed by
> >                "tcg,tpm-tis-mmio". Valid chip strings are:
> >                 * "atmel,at97sc3204"
> > +               * "socionext,synquacer-tpm-mmio"
> >  - reg: The location of the MMIO registers, should be at least 0x5000 bytes
> >  - interrupts: An optional interrupt indicating command completion.
> >
>
> Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>
> Someone else needs to give reviewed-by as I am not expert on DT bindings.
>

Cheers Jarko.

Rob's ack should be sufficient for this to go via another tree.

However, I am still waiting to hear back from Masahisa to confirm that
the SPI command sequencer approach works 100% on this hardware, so
shall we park these patches for the time being?

Thanks,
Ard.
