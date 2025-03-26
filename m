Return-Path: <linux-integrity+bounces-5450-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A481BA71CC4
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Mar 2025 18:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 555E33AA453
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Mar 2025 17:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95D91F790B;
	Wed, 26 Mar 2025 17:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dcs1qspy"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8591F76CA;
	Wed, 26 Mar 2025 17:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743009266; cv=none; b=M5MfjyLv0CfHmDMsXREr7QRAn/qsbh8jsjs/JidTe2zoFTmGUKrlCuIzTb5j/zqLDQ0aSZ8B4Dkm1erCkvBi1M72Gtyq4d02Gyk3Y2dQtDlFre/Yb6OZ4R7eRztYCmTap9veP+WCYtQVeuaqTRX0MGg6JinMdVYh+SLr/mwbRro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743009266; c=relaxed/simple;
	bh=j37MQkuCptzGY0gYJsrYLQCLJ3wA7UC8XI6mMPlGdVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQ49OzpfvGwhof9ahy/6gLStAxQhREkKs8sIQptJlPy7yGreX0MWuTYT1Tt5pj4KvIBQ5B9qqMABdbZ8+mV7tTiggVBWWQiQCwkdmhfCOiiVKHoLeYErwRikLp/9/u92G0wHyYZVG7m3rxluWThtecvap+YXe+fMXVSu4d8DQq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dcs1qspy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C027BC4CEE2;
	Wed, 26 Mar 2025 17:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743009266;
	bh=j37MQkuCptzGY0gYJsrYLQCLJ3wA7UC8XI6mMPlGdVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dcs1qspylvHcv9ik6TzLK+Osso0bfAytpqxN+YpHorcT5uNqs742f28dXTQfoUXgo
	 poWNQS0q4c7FEloTWr0DuXVSHTbzi6bbL/oE7361tQloU4O6lNjyXw+GDlqovclYGK
	 BEL5OhAgCo2MuAizj72mF6Fmegzs+7uCh5eJF2Not2oFGBAokDhWSiOd8kHr/TocG8
	 wBqBS3Bo9DSSiwEKe4LGK2mS6UN89eQj4OseofygoaNGTrqiIpinq7kJrTEGFp55t8
	 R7K9i4xdxPHsKBEduNj37sn+7+qQ/iVM3klIcW87EPnGsic3PHxmZYUyYWAbaOqt3l
	 lPN3uyvVe4NMg==
Date: Wed, 26 Mar 2025 19:14:22 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Dionna Amalie Glaze <dionnaglaze@google.com>,
	Joerg Roedel <jroedel@suse.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, "H. Peter Anvin" <hpa@zytor.com>,
	linux-coco@lists.linux.dev,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	Dov Murik <dovmurik@linux.ibm.com>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 1/4] x86/sev: add SVSM vTPM probe/send_command
 functions
Message-ID: <Z-Q17iAvJCgJy5pf@kernel.org>
References: <20250324104653.138663-1-sgarzare@redhat.com>
 <20250324104653.138663-2-sgarzare@redhat.com>
 <CAAH4kHYuaQEkvftWuX+UmGDiAgV5i1uHx8=rjmhJ0Y=inQFw-Q@mail.gmail.com>
 <dou3uniecwqapl7kmsxa2776v6pdy7c4zdvcrdky6wz62ohyao@u3vlgaao4sb7>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dou3uniecwqapl7kmsxa2776v6pdy7c4zdvcrdky6wz62ohyao@u3vlgaao4sb7>

On Tue, Mar 25, 2025 at 06:20:48PM +0100, Stefano Garzarella wrote:
> On Tue, Mar 25, 2025 at 09:56:53AM -0700, Dionna Amalie Glaze wrote:
> > On Mon, Mar 24, 2025 at 3:47 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
> > > 
> > > From: Stefano Garzarella <sgarzare@redhat.com>
> > > 
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
> > > Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > ---
> > > v4:
> > > - added Tom's R-b
> > > - added functions documentation [Jarkko]
> > > - simplified TPM_SEND_COMMAND check [Tom/Jarkko]
> > > v3:
> > > - removed link to the spec because those URLs are unstable [Borislav]
> > > - squashed "x86/sev: add SVSM call macros for the vTPM protocol" patch
> > >   in this one [Borislav]
> > > - slimmed down snp_svsm_vtpm_probe() [Borislav]
> > > - removed features check and any print related [Tom]
> > > ---
> > >  arch/x86/include/asm/sev.h |  7 +++++
> > >  arch/x86/coco/sev/core.c   | 59 ++++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 66 insertions(+)
> > > 
> > > diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> > > index ba7999f66abe..09471d058ce5 100644
> > > --- a/arch/x86/include/asm/sev.h
> > > +++ b/arch/x86/include/asm/sev.h
> > > @@ -384,6 +384,10 @@ struct svsm_call {
> > >  #define SVSM_ATTEST_SERVICES           0
> > >  #define SVSM_ATTEST_SINGLE_SERVICE     1
> > > 
> > > +#define SVSM_VTPM_CALL(x)              ((2ULL << 32) | (x))
> > > +#define SVSM_VTPM_QUERY                        0
> > > +#define SVSM_VTPM_CMD                  1
> > > +
> > >  #ifdef CONFIG_AMD_MEM_ENCRYPT
> > > 
> > >  extern u8 snp_vmpl;
> > > @@ -481,6 +485,9 @@ void snp_msg_free(struct snp_msg_desc *mdesc);
> > >  int snp_send_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_req *req,
> > >                            struct snp_guest_request_ioctl *rio);
> > > 
> > > +bool snp_svsm_vtpm_probe(void);
> > > +int snp_svsm_vtpm_send_command(u8 *buffer);
> > > +
> > 
> > These should be defined static inline with trivial definitions in the
> > #else case, yes?
> 
> For now the only user of those is the tpm_svsm driver which is build only if
> CONFIG_AMD_MEM_ENCRYPT is defined, so there should be no problem, but you
> are right, better to follow the other functions and define the stubs
> 
> I'll fix in v5, good catch!

Only denoting here that you can keep my reviewed-by in the v5 for
this despite the minor change.

> 
> Thanks,
> Stefano
> 

BR, Jarkko

