Return-Path: <linux-integrity+bounces-9586-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBE2NmzGB2pEHwMAu9opvQ
	(envelope-from <linux-integrity+bounces-9586-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sat, 16 May 2026 03:20:44 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA34559BFA
	for <lists+linux-integrity@lfdr.de>; Sat, 16 May 2026 03:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C93083006D5C
	for <lists+linux-integrity@lfdr.de>; Sat, 16 May 2026 01:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6179E1F4611;
	Sat, 16 May 2026 01:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VBa8wyqf"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8C61E5724;
	Sat, 16 May 2026 01:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778894439; cv=none; b=s1wLPRIsE8o2LwjlCAUymUWZG2bijjlprb3iYKNHf6ad5r+/mkeFC98yojcJQxaBnyWmyTs2lbHoP7cobduBOMXwTEMDq1S8AKisOFzdfwrzz80bTuozAP6HwxGqmu1Mr4niMJOs1Gi1rPaUa1Q2VB+CtGDGXXZKAQyRHbvJTHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778894439; c=relaxed/simple;
	bh=LQRaR0UL9iyobR+hCkfFaKqgH+JL9Mut3BqeOIgUx9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHFOTH01tFpt21wxUbzohcdv71QZjJ5GLbGDUGxlPgbwuU4sUaCWnzj/nwLHMxQhQAKB2SvgPAjVg9bTrtsy2cNDzb8QQ6k3RywoDaj5QY8LB00xkK66cUzkAAdkLr3LLAwCjRmf4IrxYukkOBoObyYrP8Z4J9Tp/D4isTjAdl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VBa8wyqf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F7FC2BCB0;
	Sat, 16 May 2026 01:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778894438;
	bh=LQRaR0UL9iyobR+hCkfFaKqgH+JL9Mut3BqeOIgUx9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VBa8wyqfRs4wDPJD1SXCRu9DN38+nKJFn+7/giMsPGrK//MWEsyYUcCpHoyRUeyTc
	 1DtUIO2qcd8MQmBoZy7CRT/Gh4xogdHDFnA650zKPlinFotv8hGOgWvYLpVXKbJeYE
	 QnLpo3Jem5/wTMhfkkGXGwp5JcFSkhuOQQEUEISn747uDkKryRpke8QGQ9rwl6xxTs
	 +2dO4JSJv9vDL2FhtY4BU0Fxs+M/g1s8rGk1ykexEi3qQu0NH8s1rf+5/6jW9JbZQZ
	 nRQJIPIO+NqMf3b4zEaf/dTPSSNrNnCmsK/meN/0l/uAyrGpkS/PcptcR8s5UWLsRE
	 E4OLySAGwkPYQ==
Date: Sat, 16 May 2026 04:20:35 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Arun Menon <armenon@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [RFC v2 4/5] tpm: Increase TPM_BUFSIZE to 8kB for chunking
 support
Message-ID: <agfGY1dtiPhi9iI-@kernel.org>
References: <20260324181244.17741-1-armenon@redhat.com>
 <20260324181244.17741-5-armenon@redhat.com>
 <af9KnU90yMf8MxnQ@kernel.org>
 <af9Nn3WA7bWVI1nO@kernel.org>
 <agRbHXcRF2XI1d-x@fedora>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agRbHXcRF2XI1d-x@fedora>
X-Rspamd-Queue-Id: DDA34559BFA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmx.de,ziepe.ca];
	TAGGED_FROM(0.00)[bounces-9586-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 04:36:05PM +0530, Arun Menon wrote:
> On Sat, May 09, 2026 at 06:07:11PM +0300, Jarkko Sakkinen wrote:
> > On Sat, May 09, 2026 at 05:54:25PM +0300, Jarkko Sakkinen wrote:
> > > On Tue, Mar 24, 2026 at 11:42:43PM +0530, Arun Menon wrote:
> > > > The size of the command is checked against TPM_BUFSIZE early on before
> > > > even sending it to the backend. We therefore need to increase the
> > > > TPM_BUFSIZE to allow support for larger commands.
> > > > 
> > > > For now, 8KB seems sufficient for ML-KEM and ML-DSA algorithms and it is
> > > > also order-1 safe.
> > > > 
> > > > Signed-off-by: Arun Menon <armenon@redhat.com>
> > > > ---
> > > >  drivers/char/tpm/tpm.h | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> > > > index 87d68ddf270a7..26c3765fbd732 100644
> > > > --- a/drivers/char/tpm/tpm.h
> > > > +++ b/drivers/char/tpm/tpm.h
> > > > @@ -33,7 +33,7 @@
> > > >  #endif
> > > >  
> > > >  #define TPM_MINOR		224	/* officially assigned */
> > > > -#define TPM_BUFSIZE		4096
> > > > +#define TPM_BUFSIZE		8192
> > > >  #define TPM_NUM_DEVICES		65536
> > > >  #define TPM_RETRY		50
> > > >  
> > > > -- 
> > > > 2.53.0
> > > > 
> > > 
> > > Shouldn't this prepend previous patch?
> > 
> > Also did you remark that tpm_buf would also need changes as it is fixed
> > to PAGE_SIZE?
> 
> TPM_BUFSIZE can be increased, in its new location include/linux/tpm.h as
> per the patch : https://lore.kernel.org/linux-integrity/20260125192526.782202-12-jarkko@kernel.org/
> and I think that alone will take care of the check if (size > TPM_BUFSIZE)
> in tpm_common_write() in drivers/char/tpm/tpm-dev-common.c.
> 
> However I was not able to apply the mbox file cleanly on the existing
> branches for-next-tpm and for-next-keys. I could apply them cleanly on
> the old branch (next). Please guide.
> 
> I would only change the TPM_BUFSIZE set in 
> [PATCH v9 11/11] tpm-buf: Implement managed allocations to 8192.

So.. why can't you just rebase them and resolve possible merge
conflicts? If you use git-am, you'll like want to use '-3' flag.

> 
> > 
> > I've made a patch that essentially makes tpm_buf size variable as caller
> > does kzalloc:
> > 
> > https://lore.kernel.org/linux-integrity/20260125192526.782202-12-jarkko@kernel.org/
> > 
> > I'd see this as pretty good long-term solution.
> 
> Indeed. 
> 
> > 
> > BR, Jarkko
> > 
> 
> 
> Regards,
> Arun Menon
> 

BR, Jarkko

