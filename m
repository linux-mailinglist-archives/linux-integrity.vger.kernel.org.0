Return-Path: <linux-integrity+bounces-5291-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32370A65150
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Mar 2025 14:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00F86175B90
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Mar 2025 13:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E674F23F397;
	Mon, 17 Mar 2025 13:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8U12ekB"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BE5EBE;
	Mon, 17 Mar 2025 13:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742218590; cv=none; b=PX7z7UIEEjquxfXm9J+RBJDJx58ron1eEWLeOgv2LPXTnvZJRmDUHt1ryhysCrN27qOy7+py48imsiXoYB9WGGhsA3Wj7LbiHbNFfr5pafzPd00ylMwu9sdFsOiATczEu2yzp2EkzydFJslSvtP+8DbCQw5ZManOkGkbYFkLo6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742218590; c=relaxed/simple;
	bh=RseWPBUm8jLujRzewLcvZ2BXS/0vv+m6EhD8xlnMnmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ITmnWR2y4+0Rsn3IGuwS/yxHS0hJzcDbpXLQ2Unq0Bn9nKAvyPtXIr3NNvVzQYc4w/QbiX+eKxjvuaXxnTuYHCJH3UsAINBQcYNPXduVLvbcki8ell0AnFdSvN7cbPwLTHWtyCtV1W+QVTxTshCakE1hOO93GmNgdmn859cS3HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8U12ekB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A95E9C4CEF1;
	Mon, 17 Mar 2025 13:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742218590;
	bh=RseWPBUm8jLujRzewLcvZ2BXS/0vv+m6EhD8xlnMnmA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E8U12ekBW2a7Bin/kQfOEIUbrByUMBYu+5OR0NzDEUTrA43lTA0rFWJKazYJ+Ex5M
	 3o+/YJzUibV3yfvbeKe2NMEcNCFUikI2RTYD5W9k1K8FBYGO6bQsEjw//qw4WfN1Gi
	 a/QvOf+9Bt/GOxYsnTdWuYccqB1mNu1WgiSNnQAlLkteaLCDb0Je37u7Z7z6fffxz8
	 qYSFsSjzWr3IauwfmC7xfu1sJmOTrJKOwCD24AWzsDWP9F09Stdrcx6YyoN/9Mf0mu
	 uSUn9LE5JwCCtOmpkAPFkhYiukkDncrdt9j2xhDepIXGFLxTh/g8kDu2X9x+Ii9YRl
	 qYadrHPbPCt9A==
Date: Mon, 17 Mar 2025 15:36:26 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	Borislav Petkov <bp@alien8.de>, linux-integrity@vger.kernel.org,
	Dov Murik <dovmurik@linux.ibm.com>,
	Dionna Glaze <dionnaglaze@google.com>, linux-coco@lists.linux.dev,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v3 1/4] x86/sev: add SVSM vTPM probe/send_command
 functions
Message-ID: <Z9glWp6U6vyEmKQa@kernel.org>
References: <20250311094225.35129-1-sgarzare@redhat.com>
 <20250311094225.35129-2-sgarzare@redhat.com>
 <d7e5a1d2-5fcc-bf7f-a67d-7871a1627c98@amd.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7e5a1d2-5fcc-bf7f-a67d-7871a1627c98@amd.com>

On Fri, Mar 14, 2025 at 10:27:07AM -0500, Tom Lendacky wrote:
> On 3/11/25 04:42, Stefano Garzarella wrote:
> > Add two new functions to probe and send commands to the SVSM vTPM.
> > They leverage the two calls defined by the AMD SVSM specification [1]
> > for the vTPM protocol: SVSM_VTPM_QUERY and SVSM_VTPM_CMD.
> > 
> > Expose these functions to be used by other modules such as a tpm
> > driver.
> > 
> > [1] "Secure VM Service Module for SEV-SNP Guests"
> >     Publication # 58019 Revision: 1.00
> > 
> > Co-developed-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> > Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> > Co-developed-by: Claudio Carvalho <cclaudio@linux.ibm.com>
> > Signed-off-by: Claudio Carvalho <cclaudio@linux.ibm.com>
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> 
> One minor nit below, otherwise:
> 
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> 
> > ---
> > v3:
> > - removed link to the spec because those URLs are unstable [Borislav]
> > - squashed "x86/sev: add SVSM call macros for the vTPM protocol" patch
> >   in this one [Borislav]
> > - slimmed down snp_svsm_vtpm_probe() [Borislav]
> > - removed features check and any print related [Tom]
> > ---
> >  arch/x86/include/asm/sev.h |  7 +++++++
> >  arch/x86/coco/sev/core.c   | 31 +++++++++++++++++++++++++++++++
> >  2 files changed, 38 insertions(+)
> > 
> > diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> > index ba7999f66abe..09471d058ce5 100644
> > --- a/arch/x86/include/asm/sev.h
> > +++ b/arch/x86/include/asm/sev.h
> > @@ -384,6 +384,10 @@ struct svsm_call {
> >  #define SVSM_ATTEST_SERVICES		0
> >  #define SVSM_ATTEST_SINGLE_SERVICE	1
> >  
> > +#define SVSM_VTPM_CALL(x)		((2ULL << 32) | (x))
> > +#define SVSM_VTPM_QUERY			0
> > +#define SVSM_VTPM_CMD			1
> > +
> >  #ifdef CONFIG_AMD_MEM_ENCRYPT
> >  
> >  extern u8 snp_vmpl;
> > @@ -481,6 +485,9 @@ void snp_msg_free(struct snp_msg_desc *mdesc);
> >  int snp_send_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_req *req,
> >  			   struct snp_guest_request_ioctl *rio);
> >  
> > +bool snp_svsm_vtpm_probe(void);
> > +int snp_svsm_vtpm_send_command(u8 *buffer);
> > +
> >  void __init snp_secure_tsc_prepare(void);
> >  void __init snp_secure_tsc_init(void);
> >  
> > diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
> > index 96c7bc698e6b..2166bdff88b7 100644
> > --- a/arch/x86/coco/sev/core.c
> > +++ b/arch/x86/coco/sev/core.c
> > @@ -2628,6 +2628,37 @@ static int snp_issue_guest_request(struct snp_guest_req *req, struct snp_req_dat
> >  	return ret;
> >  }
> >  
> > +bool snp_svsm_vtpm_probe(void)
> > +{
> > +	struct svsm_call call = {};
> > +
> > +	/* The vTPM device is available only if a SVSM is present */
> > +	if (!snp_vmpl)
> > +		return false;
> > +
> > +	call.caa = svsm_get_caa();
> > +	call.rax = SVSM_VTPM_CALL(SVSM_VTPM_QUERY);
> > +
> > +	if (svsm_perform_call_protocol(&call))
> > +		return false;
> > +
> > +	/* Check platform commands contains TPM_SEND_COMMAND - platform command 8 */
> > +	return (call.rcx_out & BIT_ULL(8)) == BIT_ULL(8);
> 
> It's a bool function, so this could simplified to just:
> 
> 	return call.rcx_out & BIT_ULL(8);

Or perhaps even just "call.rcx_out & 0x100". I don't think BIT_ULL()
here brings much additional clarity or anything useful...


> 
> Thanks,
> Tom

BR, Jarkko

