Return-Path: <linux-integrity+bounces-5284-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B05C5A6147A
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Mar 2025 16:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CC0A1B60805
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Mar 2025 15:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C32200119;
	Fri, 14 Mar 2025 15:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dlTMJ/LP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4E517579;
	Fri, 14 Mar 2025 15:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741964645; cv=none; b=fYhamcMhPBckL8vjP/TI+he0LkVbMhLyiR+AfmqTU+/4xjvhFVetptlqq2OjcSDl4yUr1/rRcMJTJ2XTyR+BG7zN10/rze7pRMv4fuzhxhLaTWujeBCpi/QaGbzZd0ua6dz0oJyasLGIcq+w31dN73uQm0+Hl+x/Vn98xbQFya4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741964645; c=relaxed/simple;
	bh=0e0DjIP+VKfjwdEYSIUIE2NE30oUUxw6WwNZHuvge3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=syEl3MIKOq+/Q2WCT5o526b/2IuwpaEQK6F5d0/1yaQiqpGjuK6Vhu7+ZQg9I3uctR1nM5zC8yCqMrh7RbVMDbLwiwkSmc78We9QEQ2jhiNnQByNliqqtUKscG644jYTHANYPO7DPnuYpBZUVOPsfEC9kZaxgsLSaiXMYJibihk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dlTMJ/LP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABAF5C4CEE3;
	Fri, 14 Mar 2025 15:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741964645;
	bh=0e0DjIP+VKfjwdEYSIUIE2NE30oUUxw6WwNZHuvge3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dlTMJ/LPHUArLjczhP9hRtw8xbFoO9c5acZfol2Gs5Q7IXltfeD/Tn0j1jVh5f59X
	 Q++N7OWjc+gPpKq+SbV58XPwYclvkrHXvQOjPX8DeUEBrZIjC9Tb1ARZTIROn/GkNk
	 +nkVecMAI/+hcxiUHvwXgZVhOE5t/h+0FfELm16RRVwAJNSdualYRnedaztMR+IMvo
	 Anbv41RgSZz7/YmQ2rzDDTVgkk60mfLS1piXGO7UenTWaLS8kknNVBlA5Fgk4KFEMA
	 RCeH4jDmE+ZTgPaZYvGZdh5nPJkxRzPrkvL4tE/lE7wafzTO2juGQ/z+yudZSSkp1p
	 xYxfIQ6f5dS1Q==
Date: Fri, 14 Mar 2025 17:04:00 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Tom Lendacky <thomas.lendacky@amd.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
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
Message-ID: <Z9RFYCAGEZTVfqjb@kernel.org>
References: <20250311094225.35129-1-sgarzare@redhat.com>
 <20250311094225.35129-2-sgarzare@redhat.com>
 <Z9AIx9kFKWcHB_WK@kernel.org>
 <2of2zhxi2c735fgvjxug2bxjfpz2zk25adf3h2ps5byau3rj3k@pgbxmpbskezi>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2of2zhxi2c735fgvjxug2bxjfpz2zk25adf3h2ps5byau3rj3k@pgbxmpbskezi>

On Wed, Mar 12, 2025 at 11:56:06AM +0100, Stefano Garzarella wrote:
> On Tue, Mar 11, 2025 at 11:56:23AM +0200, Jarkko Sakkinen wrote:
> > On Tue, Mar 11, 2025 at 10:42:22AM +0100, Stefano Garzarella wrote:
> > > Add two new functions to probe and send commands to the SVSM vTPM.
> > > They leverage the two calls defined by the AMD SVSM specification [1]
> > > for the vTPM protocol: SVSM_VTPM_QUERY and SVSM_VTPM_CMD.
> > > 
> > > Expose these functions to be used by other modules such as a tpm
> > > driver.
> > > 
> > > [1] "Secure VM Service Module for SEV-SNP Guests"
> > >     Publication # 58019 Revision: 1.00
> > > 
> > > Co-developed-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> > > Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> > > Co-developed-by: Claudio Carvalho <cclaudio@linux.ibm.com>
> > > Signed-off-by: Claudio Carvalho <cclaudio@linux.ibm.com>
> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > ---
> > > v3:
> > > - removed link to the spec because those URLs are unstable [Borislav]
> > > - squashed "x86/sev: add SVSM call macros for the vTPM protocol" patch
> > >   in this one [Borislav]
> > > - slimmed down snp_svsm_vtpm_probe() [Borislav]
> > > - removed features check and any print related [Tom]
> > > ---
> > >  arch/x86/include/asm/sev.h |  7 +++++++
> > >  arch/x86/coco/sev/core.c   | 31 +++++++++++++++++++++++++++++++
> > >  2 files changed, 38 insertions(+)
> > > 
> > > diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> > > index ba7999f66abe..09471d058ce5 100644
> > > --- a/arch/x86/include/asm/sev.h
> > > +++ b/arch/x86/include/asm/sev.h
> > > @@ -384,6 +384,10 @@ struct svsm_call {
> > >  #define SVSM_ATTEST_SERVICES		0
> > >  #define SVSM_ATTEST_SINGLE_SERVICE	1
> > > 
> > > +#define SVSM_VTPM_CALL(x)		((2ULL << 32) | (x))
> > > +#define SVSM_VTPM_QUERY			0
> > > +#define SVSM_VTPM_CMD			1
> > > +
> > >  #ifdef CONFIG_AMD_MEM_ENCRYPT
> > > 
> > >  extern u8 snp_vmpl;
> > > @@ -481,6 +485,9 @@ void snp_msg_free(struct snp_msg_desc *mdesc);
> > >  int snp_send_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_req *req,
> > >  			   struct snp_guest_request_ioctl *rio);
> > > 
> > > +bool snp_svsm_vtpm_probe(void);
> > > +int snp_svsm_vtpm_send_command(u8 *buffer);
> > > +
> > >  void __init snp_secure_tsc_prepare(void);
> > >  void __init snp_secure_tsc_init(void);
> > > 
> > > diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
> > > index 96c7bc698e6b..2166bdff88b7 100644
> > > --- a/arch/x86/coco/sev/core.c
> > > +++ b/arch/x86/coco/sev/core.c
> > > @@ -2628,6 +2628,37 @@ static int snp_issue_guest_request(struct snp_guest_req *req, struct snp_req_dat
> > >  	return ret;
> > >  }
> > > 
> > 
> > Since this is an exported symbol, it'd be a good practice document
> > snp_svsm_vtpm_probe().
> 
> Yes, you are right, since the others were not documented, I had not added
> it, but I agree with you, I'll do in v4.
> 
> > 
> > > +bool snp_svsm_vtpm_probe(void)
> > > +{
> > > +	struct svsm_call call = {};
> > > +
> > > +	/* The vTPM device is available only if a SVSM is present */
> > > +	if (!snp_vmpl)
> > > +		return false;
> > > +
> > > +	call.caa = svsm_get_caa();
> > > +	call.rax = SVSM_VTPM_CALL(SVSM_VTPM_QUERY);
> > 
> > I supposed CAA is some kind of shared memory area for host and VM?
> 
> Not with the host, but with SVSM, which is the firmware running in the
> guest, but at a higher privilege level (VMPL) than the kernel, where, for
> example, the vTPM is emulated.
> 
> BTW, yep it is a shared memory defined by the SVSM calling convention.
> From AMD SVSM specification:
> 
>   5 Calling Convention
> 
>     Each call to the SVSM conveys data through a combination of the
>     SVSM Calling Area (whose address was first configured through the
>     SVSM_CAA field of the secrets page) and registers. Use of the
>     Calling Area is necessary for the SVSM to detect the difference
>     between a call that was issued by the guest and a spurious
>     invocation by a poorly behaved host. Registers are used for all
>     other parameters.
>     The initially configured SVSM Calling Area is a page of memory that
>     lies outside the initial SVSM memory range and has not had its VMPL
>     permissions restricted in any way. The address is guaranteed to be
>     aligned to a 4 KB boundary, so the remainder of the page may be used
>     by the guest for memory-based parameter passing if desired.
>     The contents of the Calling Area are described in the following
>     table:
> 
>     Table 2: Calling Area
>     Byte      Size     Name                Description
>     Offset
> 
>     0x000     1 byte   SVSM_CALL_PENDING   Indicates whether a call has
>                                            been requested by the guest
>                                            (0=no call requested, 1=call
>                                            requested).
>     0x001     1 byte   SVSM_MEM_AVAILABLE  Free memory is available to
>                                            be withdrawn.
>     0x002     6 byte                       Reserved. The SVSM is not
>                                            required to verify that
>                                            these bytes are 0.
> 
> > 
> > > +
> > > +	if (svsm_perform_call_protocol(&call))
> > > +		return false;
> > > +
> > > +	/* Check platform commands contains TPM_SEND_COMMAND - platform command 8 */
> > > +	return (call.rcx_out & BIT_ULL(8)) == BIT_ULL(8);
> > > +}
> > > +EXPORT_SYMBOL_GPL(snp_svsm_vtpm_probe);
> > > +
> > 
> > Ditto.
> 
> Ack.
> 
> > 
> > > +int snp_svsm_vtpm_send_command(u8 *buffer)
> > > +{
> > > +	struct svsm_call call = {};
> > > +
> > > +	call.caa = svsm_get_caa();
> > > +	call.rax = SVSM_VTPM_CALL(SVSM_VTPM_CMD);
> > > +	call.rcx = __pa(buffer);
> > > +
> > > +	return svsm_perform_call_protocol(&call);
> > > +}
> > > +EXPORT_SYMBOL_GPL(snp_svsm_vtpm_send_command);
> > > +
> > >  static struct platform_device sev_guest_device = {
> > >  	.name		= "sev-guest",
> > >  	.id		= -1,
> > > --
> > > 2.48.1
> > > 
> > 
> > That said, these are rather self-documenting (i.e, nice and clean).
> 
> Thanks for the review!

Sure, don't worry about it! Let's just cycle this enough rounds that
it fits well...

> Stefano

BR, Jarkko


