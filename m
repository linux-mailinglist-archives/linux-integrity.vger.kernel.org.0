Return-Path: <linux-integrity+bounces-5342-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE00A6A954
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Mar 2025 16:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C3C23BB0A5
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Mar 2025 15:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9CE1D516C;
	Thu, 20 Mar 2025 15:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iIjIUWs9"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915128F6B;
	Thu, 20 Mar 2025 15:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742482995; cv=none; b=CTH86RLNSbENqzYhsLDBSkNhP6ELQbl1QwyozOdQup1d8K8OGVZhGXHTms1XAcGh751odtw1rwLr/oOxM5DgvOKObinhFBX0uOuzm5C54Iv09CtWeAKtJR9QTiZGDmC1gJgH45UBScfjIOaRLb1uoYSGCNXCiomOPAwg0V4Hyeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742482995; c=relaxed/simple;
	bh=DB/W4NR9cvvIykrHiJ1LIkganubjE8k9NAuFhlU53xY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UXGvxdWov5LJwgpibowo7S+N+qFlZykOU5+dtWMGcSlb1H9eGIXODSoxh3aHUwlXDnKvutb4oFQp50LZOUhEOvzyxFi78VhAVRric3vBFGCchspIp7G6ZwAieZE1gsydlQmF0r53tuHpu6aze+wvHCFiWPrQiwndp0PY2pCwXjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iIjIUWs9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B78C4CEDD;
	Thu, 20 Mar 2025 15:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742482994;
	bh=DB/W4NR9cvvIykrHiJ1LIkganubjE8k9NAuFhlU53xY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iIjIUWs9mj23/ngqm4gOxFYJNc1lbS0WSbo3ow5sfyziDCMwIQioHR1hc6VWCLOSX
	 S0OgDz7YFHqEsvI8W3nE+NNFtfRizV2jeWKP66Fp4xgSp3DVly3ByOc4Y9l1os4XxL
	 7Ib/n2bykBzh2VCmauHHh6O+ekai6JbiJU3TQOZDDFx1wvk+Z80k6ugFmfxEU96gdX
	 QxeWphlvL2yPR6Ls8mZ9VTs8GdDtDHeqy4DxKxD+CyBgKJGJ2SC4ns1xf/ipSH2QKS
	 NWmpsFrmF4NVUwlbEUm5kqa+U0Y0Hhr2/CPrzWV9/9UOQ0lQ5LsnglmSGc3Ep/k5QX
	 aX7gtES8Do3vQ==
Date: Thu, 20 Mar 2025 17:03:09 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Borislav Petkov <bp@alien8.de>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org, Dov Murik <dovmurik@linux.ibm.com>,
	Dionna Glaze <dionnaglaze@google.com>, linux-coco@lists.linux.dev,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v3 1/4] x86/sev: add SVSM vTPM probe/send_command
 functions
Message-ID: <Z9wuLVeP726Cssqp@kernel.org>
References: <20250311094225.35129-1-sgarzare@redhat.com>
 <20250311094225.35129-2-sgarzare@redhat.com>
 <d7e5a1d2-5fcc-bf7f-a67d-7871a1627c98@amd.com>
 <Z9glWp6U6vyEmKQa@kernel.org>
 <7kuhiyy7gj4py323g5n2vy3ddlg666zwhtx3mjcklebgtlstdc@xgdyeecifwei>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7kuhiyy7gj4py323g5n2vy3ddlg666zwhtx3mjcklebgtlstdc@xgdyeecifwei>

On Tue, Mar 18, 2025 at 11:07:57AM +0100, Stefano Garzarella wrote:
> On Mon, Mar 17, 2025 at 03:36:26PM +0200, Jarkko Sakkinen wrote:
> > On Fri, Mar 14, 2025 at 10:27:07AM -0500, Tom Lendacky wrote:
> > > On 3/11/25 04:42, Stefano Garzarella wrote:
> > > > Add two new functions to probe and send commands to the SVSM vTPM.
> > > > They leverage the two calls defined by the AMD SVSM specification [1]
> > > > for the vTPM protocol: SVSM_VTPM_QUERY and SVSM_VTPM_CMD.
> > > >
> > > > Expose these functions to be used by other modules such as a tpm
> > > > driver.
> > > >
> > > > [1] "Secure VM Service Module for SEV-SNP Guests"
> > > >     Publication # 58019 Revision: 1.00
> > > >
> > > > Co-developed-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> > > > Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> > > > Co-developed-by: Claudio Carvalho <cclaudio@linux.ibm.com>
> > > > Signed-off-by: Claudio Carvalho <cclaudio@linux.ibm.com>
> > > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > 
> > > One minor nit below, otherwise:
> > > 
> > > Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> 
> Thanks!
> 
> > > 
> > > > ---
> > > > v3:
> > > > - removed link to the spec because those URLs are unstable [Borislav]
> > > > - squashed "x86/sev: add SVSM call macros for the vTPM protocol" patch
> > > >   in this one [Borislav]
> > > > - slimmed down snp_svsm_vtpm_probe() [Borislav]
> > > > - removed features check and any print related [Tom]
> > > > ---
> > > >  arch/x86/include/asm/sev.h |  7 +++++++
> > > >  arch/x86/coco/sev/core.c   | 31 +++++++++++++++++++++++++++++++
> > > >  2 files changed, 38 insertions(+)
> > > >
> > > > diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> > > > index ba7999f66abe..09471d058ce5 100644
> > > > --- a/arch/x86/include/asm/sev.h
> > > > +++ b/arch/x86/include/asm/sev.h
> > > > @@ -384,6 +384,10 @@ struct svsm_call {
> > > >  #define SVSM_ATTEST_SERVICES		0
> > > >  #define SVSM_ATTEST_SINGLE_SERVICE	1
> > > >
> > > > +#define SVSM_VTPM_CALL(x)		((2ULL << 32) | (x))
> > > > +#define SVSM_VTPM_QUERY			0
> > > > +#define SVSM_VTPM_CMD			1
> > > > +
> > > >  #ifdef CONFIG_AMD_MEM_ENCRYPT
> > > >
> > > >  extern u8 snp_vmpl;
> > > > @@ -481,6 +485,9 @@ void snp_msg_free(struct snp_msg_desc *mdesc);
> > > >  int snp_send_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_req *req,
> > > >  			   struct snp_guest_request_ioctl *rio);
> > > >
> > > > +bool snp_svsm_vtpm_probe(void);
> > > > +int snp_svsm_vtpm_send_command(u8 *buffer);
> > > > +
> > > >  void __init snp_secure_tsc_prepare(void);
> > > >  void __init snp_secure_tsc_init(void);
> > > >
> > > > diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
> > > > index 96c7bc698e6b..2166bdff88b7 100644
> > > > --- a/arch/x86/coco/sev/core.c
> > > > +++ b/arch/x86/coco/sev/core.c
> > > > @@ -2628,6 +2628,37 @@ static int snp_issue_guest_request(struct snp_guest_req *req, struct snp_req_dat
> > > >  	return ret;
> > > >  }
> > > >
> > > > +bool snp_svsm_vtpm_probe(void)
> > > > +{
> > > > +	struct svsm_call call = {};
> > > > +
> > > > +	/* The vTPM device is available only if a SVSM is present */
> > > > +	if (!snp_vmpl)
> > > > +		return false;
> > > > +
> > > > +	call.caa = svsm_get_caa();
> > > > +	call.rax = SVSM_VTPM_CALL(SVSM_VTPM_QUERY);
> > > > +
> > > > +	if (svsm_perform_call_protocol(&call))
> > > > +		return false;
> > > > +
> > > > +	/* Check platform commands contains TPM_SEND_COMMAND - platform command 8 */
> > > > +	return (call.rcx_out & BIT_ULL(8)) == BIT_ULL(8);
> > > 
> > > It's a bool function, so this could simplified to just:
> > > 
> > > 	return call.rcx_out & BIT_ULL(8);
> 
> Sure.
> 
> > 
> > Or perhaps even just "call.rcx_out & 0x100". I don't think BIT_ULL()
> > here brings much additional clarity or anything useful...
> 
> I can do that, I slightly prefer BIT_ULL() macro, but I don't have a strong
> opinion on my side.
> @Borislav since you suggested it, WDYT?

Either goes for me. Sorry for nitpicking that :-) The first comment
stil applies.

> 
> Thanks,
> Stefano
> 

BR, Jarkko

