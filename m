Return-Path: <linux-integrity+bounces-5210-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 221B5A59705
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Mar 2025 15:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4BA33A51B7
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Mar 2025 14:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B219122B8A0;
	Mon, 10 Mar 2025 14:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="e0+lZ4th"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC6522A807;
	Mon, 10 Mar 2025 14:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741615520; cv=none; b=Ygnm+T9hNtrn/jdXaTnA0sSDoxu2EtlfbNLKe4RI6MAhnS8I112AKuORIW4la79g4lXaLkz01HE7nkHT+WtP2wZZ0uDThvSntCx97Mfc1+jyByOsAu0fM5o47jzLpeEW0mQu43CULVSoATwZJ+zRTQMlRYUuT+ZMptRcZhKlcFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741615520; c=relaxed/simple;
	bh=zdcuwioXMQ0g7o9vXchk2/gMjZ08nKjhdVg9BSLNS7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tdYk/QNCSQxNhMm5IpOEr2X7VbDXJdW8IfJ/EjFEtWvvAH2x9Kkqe34Byoxm5jGMrN6zP/O9OsAGtRKyZO/qH+AVGkJ/IG0qWrbDfYLqxo62idu8DjICHhM2DDU8ThFZKjlvXTY8vV2Fe9maPkyz7CD6WdIcM/V40nl6aZqitn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=e0+lZ4th; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 945E440E0218;
	Mon, 10 Mar 2025 14:05:16 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Io1pzLc1U_zq; Mon, 10 Mar 2025 14:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741615513; bh=ktORUinjRMSPW3AxMyH0MdsBYKixkPvsbxrQTasAWjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e0+lZ4thH2Hc61D3H7yBcEJmgN+0UR6s3v1GYWGFqQlMeKbWSGl42hbaIljhEDYBX
	 KmFPX5FgFuphu1KKv535yzqCOgLmeIDMXy4b0AjyLS1RiNbX8sWT0K74X/DzKSXNQc
	 rRV+kUdW+dXmSmMy3Ckmwot/Zx1KyOP8T8/D6GpELxp9qLE0Wre4yBhxnr30KwfP2k
	 fwVMHfRJHNc0uDnQk6IJs+TzY0u5T1z26kq03PQw8yAndLzBrYMfLRIQ9n50BPxvVH
	 fvTFSOIibUMwxxve6ol5a8YmT/6ndM+oJ/v5ThrlsXZ9kMrfcCGuaj4i+XmnHeOCov
	 OnxNYbmpRFG1M/+6O4JZkdfcB7nlhPOJHyAnzbDdD3oMBZxsiqm6rXCIFMet7KZpXC
	 vbLd4//FDR7NZeXMEz4bBLyVjidsMeO1kM+OTK0ZUvk7hKMK/OJRYKuq7u+lT1q1Es
	 4bGSCVGQGFsJ5IVTQkEAUjfMwsmpgwGULGhDRbfCaen6gwwUXpC/N1n7oufWQv51tt
	 aa6k7cxoKxggJ8FsmhhUNITYk8vs0Ji9tvSjQhZh3buE+f8TwpQGYTws/7U5S+Fpg4
	 fKWMkzcrNkz6LSs1Qy10BDaQ+nqR1Srmqld4bKWwJnPyL8ODVyCXElkdpk3fnOUbjf
	 WQaDwEaMIL8B2jzPJLgMf6s4=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B94DE40E0216;
	Mon, 10 Mar 2025 14:04:54 +0000 (UTC)
Date: Mon, 10 Mar 2025 15:04:53 +0100
From: Borislav Petkov <bp@alien8.de>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	Peter Huewe <peterhuewe@gmx.de>, x86@kernel.org,
	Dov Murik <dovmurik@linux.ibm.com>, linux-coco@lists.linux.dev,
	Dionna Glaze <dionnaglaze@google.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC PATCH v2 2/6] x86/sev: add SVSM vTPM probe/send_command
 functions
Message-ID: <20250310140453.GLZ87xheyuki61V5Mo@fat_crate.local>
References: <20250228170720.144739-1-sgarzare@redhat.com>
 <20250228170720.144739-3-sgarzare@redhat.com>
 <20250310113006.GFZ87NPu-LgFVVtsEG@fat_crate.local>
 <mjftygohmhgs6daqvgkh2jbfuqjquchcaovcjtnzyhilnt5ww5@l3fr7phqh2ps>
 <3dd645f2-476a-d0d5-c8c1-c87307f2d756@amd.com>
 <20250310135133.GIZ87uZZNhNSkmxvg1@fat_crate.local>
 <6yzzspawrp6lg3m242bcdl5egpdvt6je2kc3cuznnnze7iypc7@4uaonepi7myq>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6yzzspawrp6lg3m242bcdl5egpdvt6je2kc3cuznnnze7iypc7@4uaonepi7myq>

On Mon, Mar 10, 2025 at 02:59:44PM +0100, Stefano Garzarella wrote:
> On Mon, Mar 10, 2025 at 02:51:33PM +0100, Borislav Petkov wrote:
> > On Mon, Mar 10, 2025 at 08:27:37AM -0500, Tom Lendacky wrote:
> > > I don't think anything needs to be checked or printed.
> > 
> > Yes.
> 
> Ack, I removed the check and the print.
> 
> @Boris I also removed `ret` to continue the slimming, so the end
> result should be this:
> 
> bool snp_svsm_vtpm_probe(void)
> {
> 	struct svsm_call call = {};
> 
> 	/* The vTPM device is available only if a SVSM is present */
> 	if (!snp_vmpl)
> 		return false;
> 
> 	call.caa = svsm_get_caa();
> 	call.rax = SVSM_VTPM_CALL(SVSM_VTPM_QUERY);
> 
> 	if (svsm_perform_call_protocol(&call))
> 		return false;
> 
> 	/* Check platform commands contains TPM_SEND_COMMAND - platform command 8 */
> 	return (call.rcx_out & BIT_ULL(8)) == BIT_ULL(8);
> }
> 
> Quite nice, thanks for the review!

Thanks, looks clean to me. :)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

