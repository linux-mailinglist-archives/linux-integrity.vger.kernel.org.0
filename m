Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4503E87DA
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Aug 2021 04:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbhHKCK4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Aug 2021 22:10:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:49106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231573AbhHKCK4 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Aug 2021 22:10:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D970160184;
        Wed, 11 Aug 2021 02:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628647833;
        bh=JT0tTCfJOs74pR9exNXGPYUSruB1gH5M38fKvDWrIzs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PK0E6SKAkaAzTR0AnZbVqHMiJFw0yvy7tMZ36JSMA0Jy2DUbdGB14FFAjC5AiwtmM
         jl54XUhKn8txBpcPegDgFFfyVM9gkEpGzy8gZfpgQxlwWf5NjUbR3x9Nb4DhiCP8Ed
         17fcKUedfD8HS76O2SZNR6vXszubIx6bbF3LnLlRz9ExW61Dndiwb2VN8YJwdFHvmD
         citlmZHRZaIhj8odQEsO4TMaqN4sNJ9E/JSDxajvAcFBV22DsLNDrQAiKKmJOp1K/a
         hvWjACWQ8VYHyM4D2GtMWY9FRx/LfWpKbc2OcKG5HKFiR0BjbugftMBOsR/AeAxfT5
         8WFYPTXnDbqoQ==
Date:   Wed, 11 Aug 2021 05:10:30 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>, nasastry@in.ibm.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nayna Jain <nayna@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>
Subject: Re: [PATCH v4 2/2] tpm: ibmvtpm: Rename tpm_process_cmd to
 tpm_status and define flag
Message-ID: <20210811021030.5meaty2zxf253nfl@kernel.org>
References: <20210809192159.2176580-1-stefanb@linux.vnet.ibm.com>
 <20210809192159.2176580-3-stefanb@linux.vnet.ibm.com>
 <20210810175855.fixtw5jks4gbmkua@kernel.org>
 <86f6a6c8-87cc-a397-35b3-a30220f12aed@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86f6a6c8-87cc-a397-35b3-a30220f12aed@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Aug 10, 2021 at 09:50:55PM -0400, Stefan Berger wrote:
> 
> On 8/10/21 1:58 PM, Jarkko Sakkinen wrote:
> > On Mon, Aug 09, 2021 at 03:21:59PM -0400, Stefan Berger wrote:
> > > From: Stefan Berger <stefanb@linux.ibm.com>
> > > 
> > > Rename the field tpm_processing_cmd to tpm_status in ibmvtpm_dev and set
> > > the TPM_STATUS_BUSY flag while the vTPM is busy processing a command.
> > > 
> > > 
> > >   		default:
> > > diff --git a/drivers/char/tpm/tpm_ibmvtpm.h b/drivers/char/tpm/tpm_ibmvtpm.h
> > > index 51198b137461..252f1cccdfc5 100644
> > > --- a/drivers/char/tpm/tpm_ibmvtpm.h
> > > +++ b/drivers/char/tpm/tpm_ibmvtpm.h
> > > @@ -41,7 +41,8 @@ struct ibmvtpm_dev {
> > >   	wait_queue_head_t wq;
> > >   	u16 res_len;
> > >   	u32 vtpm_version;
> > > -	u8 tpm_processing_cmd;
> > > +	u8 tpm_status;
> > > +#define TPM_STATUS_BUSY		(1 << 0) /* vtpm is processing a command */
> > Declare this already in the fix, and just leave the rename here.
> 
> You mean the fix patch does not use 'true' anymore but uses the
> TPM_STATUS_BUSY flag already but the name is still tpm_processing_cmd? And
> literally only the renaming of this field is done in the 2nd patch?

I can fixup these patches, and use '1', instead of true. No need to send
new ones.

Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkko
