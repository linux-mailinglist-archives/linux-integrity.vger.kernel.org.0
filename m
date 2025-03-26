Return-Path: <linux-integrity+bounces-5449-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E47A71CB8
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Mar 2025 18:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8663716B427
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Mar 2025 17:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB341F5845;
	Wed, 26 Mar 2025 17:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mjOvb9cT"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22CD1F3FF8;
	Wed, 26 Mar 2025 17:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743009162; cv=none; b=Q6tEDhtg7bfjEKPdGRgxsawH7+A+VVvlv5h5x15Q3/QRBfGY1BNurgSBNcteSWGKPS28u3M+t1vnsaVqZeoIKm1aTwKSUpWCiD06EDW+B/yAkHVoZvTwMOYL7w8oepDIPzFCvwLdlkzB0faYcOsJAHxedcTEjKOXDE7WGurO/9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743009162; c=relaxed/simple;
	bh=7hXlRCnNGKHPf28WAizHax7IS3FwqirVTx4+rBP+fX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sDdw0bUJlswz5BQWa6hoGqZPFNxhzTR2IQO8YFPqO+dSm7IpZiDNkl0a5MJfGOPppsylHY1qDy6oZ48USWhOu9MyDaKgyQB0RiQMwVUe1Oimsq6YQE9rkR761nD/y0uYd1V+UPssAAs+MEdxVqm2ekpfJe6H/6Go9JImFmZ+5Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mjOvb9cT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F39C4CEE2;
	Wed, 26 Mar 2025 17:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743009162;
	bh=7hXlRCnNGKHPf28WAizHax7IS3FwqirVTx4+rBP+fX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mjOvb9cTaFcLfcWOgOwCw3z+8/SRfPWduEnrirrmmvSf00T1qMYysIE6EdgRRAzD4
	 aPAn7QKDTTI2srFbUctcMH8cKigeyFfxYIwnppPt9kGvFbx8mOd5XXNro27heT38q2
	 v2GOvMkXTEqyUyKQRjNYg8u4zysZxlMlbvL84wjBqEDRedF4qKhVyRJMZqRrs7phcI
	 7CyPwwagFNfdYMrdK6SSEtYW9iHhl9pMLzL3pRD6wOquV+BnyaWeWKOqJQwg/OwvS5
	 n5Hu3id78HCPSpAYwpVS5lVDjrC30QC0gC8jqK+if/B5SsgUCJeFFbUXsse009nChl
	 xk9hR9dLau6zw==
Date: Wed, 26 Mar 2025 19:12:38 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Joerg Roedel <jroedel@suse.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, "H. Peter Anvin" <hpa@zytor.com>,
	linux-coco@lists.linux.dev,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	Dov Murik <dovmurik@linux.ibm.com>,
	Dionna Glaze <dionnaglaze@google.com>,
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 1/4] x86/sev: add SVSM vTPM probe/send_command
 functions
Message-ID: <Z-Q1hjUSbs9FLiEI@kernel.org>
References: <20250324104653.138663-1-sgarzare@redhat.com>
 <20250324104653.138663-2-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250324104653.138663-2-sgarzare@redhat.com>

On Mon, Mar 24, 2025 at 11:46:46AM +0100, Stefano Garzarella wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> Add two new functions to probe and send commands to the SVSM vTPM.
> They leverage the two calls defined by the AMD SVSM specification [1]
> for the vTPM protocol: SVSM_VTPM_QUERY and SVSM_VTPM_CMD.
> 
> Expose these functions to be used by other modules such as a tpm
> driver.
> 
> [1] "Secure VM Service Module for SEV-SNP Guests"
>     Publication # 58019 Revision: 1.00
> 
> Co-developed-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Co-developed-by: Claudio Carvalho <cclaudio@linux.ibm.com>
> Signed-off-by: Claudio Carvalho <cclaudio@linux.ibm.com>
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> v4:
> - added Tom's R-b
> - added functions documentation [Jarkko]
> - simplified TPM_SEND_COMMAND check [Tom/Jarkko]
> v3:
> - removed link to the spec because those URLs are unstable [Borislav]
> - squashed "x86/sev: add SVSM call macros for the vTPM protocol" patch
>   in this one [Borislav]
> - slimmed down snp_svsm_vtpm_probe() [Borislav]
> - removed features check and any print related [Tom]
> ---
>  arch/x86/include/asm/sev.h |  7 +++++
>  arch/x86/coco/sev/core.c   | 59 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 66 insertions(+)
> 
> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index ba7999f66abe..09471d058ce5 100644
> --- a/arch/x86/include/asm/sev.h
> +++ b/arch/x86/include/asm/sev.h
> @@ -384,6 +384,10 @@ struct svsm_call {
>  #define SVSM_ATTEST_SERVICES		0
>  #define SVSM_ATTEST_SINGLE_SERVICE	1
>  
> +#define SVSM_VTPM_CALL(x)		((2ULL << 32) | (x))
> +#define SVSM_VTPM_QUERY			0
> +#define SVSM_VTPM_CMD			1
> +
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>  
>  extern u8 snp_vmpl;
> @@ -481,6 +485,9 @@ void snp_msg_free(struct snp_msg_desc *mdesc);
>  int snp_send_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_req *req,
>  			   struct snp_guest_request_ioctl *rio);
>  
> +bool snp_svsm_vtpm_probe(void);
> +int snp_svsm_vtpm_send_command(u8 *buffer);
> +
>  void __init snp_secure_tsc_prepare(void);
>  void __init snp_secure_tsc_init(void);
>  
> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
> index 96c7bc698e6b..034aab7e76d2 100644
> --- a/arch/x86/coco/sev/core.c
> +++ b/arch/x86/coco/sev/core.c
> @@ -2628,6 +2628,65 @@ static int snp_issue_guest_request(struct snp_guest_req *req, struct snp_req_dat
>  	return ret;
>  }
>  
> +/**
> + * snp_svsm_vtpm_probe() - Probe if SVSM provides a vTPM device
> + *
> + * This function checks that there is SVSM and that it supports at least
> + * TPM_SEND_COMMAND which is the only request we use so far.
> + *
> + * Return: true if the platform provides a vTPM SVSM device, false otherwise.
> + */
> +bool snp_svsm_vtpm_probe(void)
> +{
> +	struct svsm_call call = {};
> +
> +	/* The vTPM device is available only if a SVSM is present */
> +	if (!snp_vmpl)
> +		return false;
> +
> +	call.caa = svsm_get_caa();
> +	call.rax = SVSM_VTPM_CALL(SVSM_VTPM_QUERY);
> +
> +	if (svsm_perform_call_protocol(&call))
> +		return false;
> +
> +	/* Check platform commands contains TPM_SEND_COMMAND - platform command 8 */
> +	return call.rcx_out & BIT_ULL(8);
> +}
> +EXPORT_SYMBOL_GPL(snp_svsm_vtpm_probe);
> +
> +/**
> + * snp_svsm_vtpm_send_command() - execute a vTPM operation on SVSM
> + * @buffer: A buffer used to both send the command and receive the response.
> + *
> + * This function executes a SVSM_VTPM_CMD call as defined by
> + * "Secure VM Service Module for SEV-SNP Guests" Publication # 58019 Revision: 1.00
> + *
> + * All command request/response buffers have a common structure as specified by
> + * the following table:
> + *     Byte      Size       In/Out    Description
> + *     Offset    (Bytes)
> + *     0x000     4          In        Platform command
> + *                          Out       Platform command response size
> + *
> + * Each command can build upon this common request/response structure to create
> + * a structure specific to the command.
> + * See include/linux/tpm_svsm.h for more details.
> + *
> + * Return: 0 on success, -errno on failure
> + */
> +int snp_svsm_vtpm_send_command(u8 *buffer)
> +{
> +	struct svsm_call call = {};
> +
> +	call.caa = svsm_get_caa();
> +	call.rax = SVSM_VTPM_CALL(SVSM_VTPM_CMD);
> +	call.rcx = __pa(buffer);
> +
> +	return svsm_perform_call_protocol(&call);
> +}
> +EXPORT_SYMBOL_GPL(snp_svsm_vtpm_send_command);
> +
>  static struct platform_device sev_guest_device = {
>  	.name		= "sev-guest",
>  	.id		= -1,
> -- 
> 2.49.0
> 
> 

This looks good enough as far as I'm concerned:

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

