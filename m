Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD9F2F7530
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Jan 2021 10:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbhAOJYc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 15 Jan 2021 04:24:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:39432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727204AbhAOJYb (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 15 Jan 2021 04:24:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AC61A2339D;
        Fri, 15 Jan 2021 09:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610702631;
        bh=VCDpaZeUdppA614VVCSLc4aWw7dTZlkr+EHOCN3aUfQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aEdo1JA6/YfMV06tEfWDZpY8hbvb8EAbWe2pBi5L8Dw6h2GNDMjqCaxpLExYEJbSk
         /QtmoEtSr+OhlsIdR9oxDk3jz3Sg/cUI855MqtuZFmOdmc7tYK0IkNg+Hnd8J8KzhA
         FDkKnAyJv4z3diOOEDgyIP4EJIW8bcM4wpdgd7bR2h+gKlGxECRHkHY9VD1GiQmS8O
         FM88DYAUdKkI/qQl3jhWSUjoOI6dOPL3xX9b8KsAwFIl2D04v5cfDUgz4LeGchbc80
         W5H6J9i1GRgSr/UaWYUW+fOW/x6RjgQN1kxXsQTbE5mUi7My1sa8d8nY2iBLPX0diq
         YYpqtz80ilwOw==
Date:   Fri, 15 Jan 2021 11:23:46 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>
Subject: Re: [PATCH] tpm/tpm_tis: Fix variable reset during IRQ probing
Message-ID: <YAFfIqaohjneVCO6@kernel.org>
References: <20210113120021.59045-1-tianjia.zhang@linux.alibaba.com>
 <X/+xr/L+m2k5fObZ@kernel.org>
 <44c35c27-0cd4-e451-1b9c-d6fe48e58e51@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44c35c27-0cd4-e451-1b9c-d6fe48e58e51@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jan 14, 2021 at 12:12:16PM +0800, Tianjia Zhang wrote:
> 
> 
> On 1/14/21 10:51 AM, Jarkko Sakkinen wrote:
> > On Wed, Jan 13, 2021 at 08:00:21PM +0800, Tianjia Zhang wrote:
> > > In tpm_tis_core_init(), tpm2_probe() will be called first, this
> > > function will eventually call tpm_tis_send(), and then
> > > tpm_tis_probe_irq_single() will detect whether the interrupt is
> > > normal, mainly the installation interrupted, set `priv->irq_tested`
> > > to false. The logic will eventually be executed to tpm_tis_send()
> > > to trigger an interrupt.
> > > 
> > > There is currently such a scenario, which will cause the IRQ probe
> > > code to never be executed, so that the TPM device is in polling
> > > mode: after setting irq_tested to false, an interrupt occurs
> > > between entering the ttpm_tis_send() function, and the interrupt
> > > will be first set irq_tested to true will cause the IRQ probe code
> > > to never be executed.
> > 
> > Can you describe the scenario more detail?
> > 
> 
> The problematic scenario we encountered is like this. The following figure
> shows the execution flow of tpm_tis_core_init(). An interrupt occurred
> before the IRQ probe. This interrupt was caused by tpm2_probe(), but it was
> triggered before the IRQ probe was executed, and the interrupt handler would
> set irq_tested to true, so the IRQ probe code can never execute, that is,
> the code marked 2 in the figure will never happen.

TPM_INT_ENABLE is cleared on reset [*].

[*] Section 5.9.1
    https://trustedcomputinggroup.org/resource/pc-client-work-group-pc-client-specific-tpm-interface-specification-tis/

/Jarkko
