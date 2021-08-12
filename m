Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9103EAB47
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Aug 2021 21:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbhHLTsg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Aug 2021 15:48:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:43144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233338AbhHLTsf (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Aug 2021 15:48:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E02B60FBF;
        Thu, 12 Aug 2021 19:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628797690;
        bh=9p726MGqfCJDwM63/3wcjpZXRx+ArKZoieJmNMNdx1Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N6VXpRzDK9KpqN0Cf/9atiRkQv/qWwiKAvzyrFjgif1JjM0guI/0049l3Ny7KzGGB
         uNy/sPFA4zSsNB+J1cBnGCZWbA8OpPun3ogowJI9jM+ZuwxUIKPfyFm3/mqCRoHuQI
         DuTC1oD4nAeHt6ab48Yf3m6+fN1xVHNd7xYT1/zZYTqbMuTM/HcyYSc+wm8oGGv0l3
         Rqh2O9vmCGQOqQpUgMmouu7e8lFiKq7JsOdCrlhvCD0ZSh7trQzUQwY+hCuk9SPCWv
         K8mK+ucYU2Dyrr4QULMHNi/PhvhR9atapPCTYAdurY2Sn+/XXG34u0ulM3gMGFxitt
         1bz4ZfKzoidyg==
Date:   Thu, 12 Aug 2021 22:48:07 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>, nasastry@in.ibm.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nayna Jain <nayna@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>
Subject: Re: [PATCH v4 2/2] tpm: ibmvtpm: Rename tpm_process_cmd to
 tpm_status and define flag
Message-ID: <20210812194807.7nhum62vnyu27tj6@kernel.org>
References: <20210809192159.2176580-1-stefanb@linux.vnet.ibm.com>
 <20210809192159.2176580-3-stefanb@linux.vnet.ibm.com>
 <20210810175855.fixtw5jks4gbmkua@kernel.org>
 <86f6a6c8-87cc-a397-35b3-a30220f12aed@linux.ibm.com>
 <20210811021030.5meaty2zxf253nfl@kernel.org>
 <4eff0296-78da-52b6-322d-56e0f9d78dc2@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4eff0296-78da-52b6-322d-56e0f9d78dc2@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Aug 11, 2021 at 08:15:14AM -0400, Stefan Berger wrote:
> 
> On 8/10/21 10:10 PM, Jarkko Sakkinen wrote:
> > On Tue, Aug 10, 2021 at 09:50:55PM -0400, Stefan Berger wrote:
> > > On 8/10/21 1:58 PM, Jarkko Sakkinen wrote:
> > > > On Mon, Aug 09, 2021 at 03:21:59PM -0400, Stefan Berger wrote:
> > > > > From: Stefan Berger <stefanb@linux.ibm.com>
> > > > > 
> > > > > Rename the field tpm_processing_cmd to tpm_status in ibmvtpm_dev and set
> > > > > the TPM_STATUS_BUSY flag while the vTPM is busy processing a command.
> > > > > 
> > > > > 
> > > > >    		default:
> > > > > diff --git a/drivers/char/tpm/tpm_ibmvtpm.h b/drivers/char/tpm/tpm_ibmvtpm.h
> > > > > index 51198b137461..252f1cccdfc5 100644
> > > > > --- a/drivers/char/tpm/tpm_ibmvtpm.h
> > > > > +++ b/drivers/char/tpm/tpm_ibmvtpm.h
> > > > > @@ -41,7 +41,8 @@ struct ibmvtpm_dev {
> > > > >    	wait_queue_head_t wq;
> > > > >    	u16 res_len;
> > > > >    	u32 vtpm_version;
> > > > > -	u8 tpm_processing_cmd;
> > > > > +	u8 tpm_status;
> > > > > +#define TPM_STATUS_BUSY		(1 << 0) /* vtpm is processing a command */
> > > > Declare this already in the fix, and just leave the rename here.
> > > You mean the fix patch does not use 'true' anymore but uses the
> > > TPM_STATUS_BUSY flag already but the name is still tpm_processing_cmd? And
> > > literally only the renaming of this field is done in the 2nd patch?
> > I can fixup these patches, and use '1', instead of true. No need to send
> > new ones.
> > 
> > Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

I applied the first. If you have only one flag that you even
document as "processing the command" in the inline comment,
it makes absolutely no sense to rename it, as the current
name perfectly documents what it exactly is.

/Jarkko
