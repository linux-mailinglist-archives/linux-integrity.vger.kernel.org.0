Return-Path: <linux-integrity+bounces-9719-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iC/bNcg4Hmr4hwkAu9opvQ
	(envelope-from <linux-integrity+bounces-9719-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 02 Jun 2026 03:58:32 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D8362703E
	for <lists+linux-integrity@lfdr.de>; Tue, 02 Jun 2026 03:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AADEC301F9BB
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Jun 2026 01:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBED331A63;
	Tue,  2 Jun 2026 01:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0Lg2bPP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C467A1F2380;
	Tue,  2 Jun 2026 01:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780365340; cv=none; b=R5N4Q6bPwc7TkiQcOkiZ1GPy7iJUwzV25WQaKCukLnB5pvC5urTundJGQmx3vgDg1QtX8otpJEkOwep4rPTdq0QbTCUmLB/AAnyO6QjXRHpewmC+rpMhPfQup8I11PNx23OhJ4IIVQlxV5Au+lwVqVnwpSQXLPPmxjUCDg/Nse4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780365340; c=relaxed/simple;
	bh=/4YIeX02kUF2c5nsHUMnEL3yAoMfbLVnFobDROXb3YI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G8KzmaY28SsDg+1slMKofumu/+crxsFmA7sHH4XD1QlhKXb/+nR+3bIFSCIAaEXG4ZoBlNuYzfOuuFlBcjuJE8biPmpQHnEzyoQ9ZApIse1uhvse2fpBikqEhXiDVa/ERECSBJFTCDnULVsT26so1sT+t74Yp1HDhj2OlDtQD34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0Lg2bPP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id DFE8E1F00893;
	Tue,  2 Jun 2026 01:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780365339;
	bh=HnZf3cpnXy9GpZVM+wtx2iBY7lUD7Gf53lSWKOPqY7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Q0Lg2bPPZ7DspTheBqQ88EWsKxU+VETQLMeYkl7653KGhYGPFgQpOnhDkcyu6OEqy
	 Wvy+Zp3VubTe8O97gC6noBeeCaarqp9K9ADRcUkQt3Anz/h/T7qRcNXmOswlRzu4mI
	 VCU3cXndMEftKi9fuhp1nMGyXPERQoUTAj5P6QEXHf3RCfXWlRevXbBORHHdhhZZuC
	 EhD4zYSNgfRJFMS1VIkj1NeKydLDLG+y9pypcBqU39rGZZ9qvm2/zjIlEJVQrRIFLU
	 7u+d9KquHSsoRr0OcHlKc7mc1FNNM1LjMC9UfejVyOCYLFPXMR3S/CU4XI1raMCGzz
	 dTE9Y6feAdrlQ==
Date: Tue, 2 Jun 2026 04:55:35 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org, paul@paul-moore.com,
	zohar@linux.ibm.com, roberto.sassu@huaweicloud.com,
	noodles@earth.li, jmorris@namei.org, serge@hallyn.com,
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, jgg@ziepe.ca
Subject: Re: [PATCH v4 3/3] tpm: tpm_crb_ffa: revert defered_probed when
 tpm_crb_ffa is built-in
Message-ID: <ah44F7qkpUOltuJ5@kernel.org>
References: <20260525075404.3480282-1-yeoreum.yun@arm.com>
 <20260525075404.3480282-4-yeoreum.yun@arm.com>
 <ahoXUjbsPmKxfV_R@kernel.org>
 <ah0x+YDypYFzpFqt@e129823.arm.com>
 <20260601-shiny-steel-jellyfish-b38b6e@sudeepholla>
 <ah1YjJJmrkecklko@e129823.arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah1YjJJmrkecklko@e129823.arm.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9719-lists,linux-integrity=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,paul-moore.com,linux.ibm.com,huaweicloud.com,earth.li,namei.org,hallyn.com,gmail.com,oracle.com,ziepe.ca];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 84D8362703E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jun 01, 2026 at 11:01:48AM +0100, Yeoreum Yun wrote:
> > On Mon, Jun 01, 2026 at 08:17:13AM +0100, Yeoreum Yun wrote:
> > > Hi Jarkko,
> > > 
> > > Sorry for late answer.
> > > 
> > > > On Mon, May 25, 2026 at 08:54:04AM +0100, Yeoreum Yun wrote:
> > > > > commit 746d9e9f62a6 ("tpm: tpm_crb_ffa: try to probe tpm_crb_ffa when it's build_in")
> > > > > probe tpm_crb_ffa forcefully when it's built-in to integrate with IMA.
> > > > > 
> > > > > However, IMA now provides the IMA_INIT_LATE_SYNC build option, which
> > > > > initialises IMA at the late_initcall_sync level, so this change is no
> > > > > longer required.
> > > > > 
> > > > > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > > > > ---
> > > > >  drivers/char/tpm/tpm_crb_ffa.c | 18 +++---------------
> > > > >  1 file changed, 3 insertions(+), 15 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/char/tpm/tpm_crb_ffa.c b/drivers/char/tpm/tpm_crb_ffa.c
> > > > > index 99f1c1e5644b..025c4d4b17ca 100644
> > > > > --- a/drivers/char/tpm/tpm_crb_ffa.c
> > > > > +++ b/drivers/char/tpm/tpm_crb_ffa.c
> > > > > @@ -177,23 +177,13 @@ static int tpm_crb_ffa_to_linux_errno(int errno)
> > > > >   */
> > > > >  int tpm_crb_ffa_init(void)
> > > > >  {
> > > > > -	int ret = 0;
> > > > > -
> > > > > -	if (!IS_MODULE(CONFIG_TCG_ARM_CRB_FFA)) {
> > > > > -		ret = ffa_register(&tpm_crb_ffa_driver);
> > > > > -		if (ret) {
> > > > > -			tpm_crb_ffa = ERR_PTR(-ENODEV);
> > > > > -			return ret;
> > > > > -		}
> > > > > -	}
> > > > > -
> > > > >  	if (!tpm_crb_ffa)
> > > > > -		ret = -ENOENT;
> > > > > +		return -ENOENT;
> > > > >  
> > > > >  	if (IS_ERR_VALUE(tpm_crb_ffa))
> > > > > -		ret = -ENODEV;
> > > > > +		return -ENODEV;
> > > > >  
> > > > > -	return ret;
> > > > > +	return 0;
> > > > >  }
> > > > >  EXPORT_SYMBOL_GPL(tpm_crb_ffa_init);
> > > > >  
> > > > > @@ -405,9 +395,7 @@ static struct ffa_driver tpm_crb_ffa_driver = {
> > > > >  	.id_table = tpm_crb_ffa_device_id,
> > > > >  };
> > > > >  
> > > > > -#ifdef MODULE
> > > > >  module_ffa_driver(tpm_crb_ffa_driver);
> > > > > -#endif
> > > > >  
> > > > >  MODULE_AUTHOR("Arm");
> > > > >  MODULE_DESCRIPTION("TPM CRB FFA driver");
> > > > > -- 
> > > > > LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
> > > > > 
> > > > 
> > > > How we would sync up this patch? Through which tree etc.
> > > 
> > > IMHO, the IMA relevant thing would be into IMA tree,
> > > However I think this patch would be much easier to sync into Sudeep's
> > > FF-A tree where ff-a initilisation is reverted to device_initcall
> > > unless you're uncomfortable.
> > > 
> > > For this, It might be better to split this patch from this series
> > > since by above and defer probe of ff-a would make a register failure
> > > of registering tpm_crb_ffa driver which is built-in.
> > > 
> > > @Sudeep what do you think?
> > > 
> > 
> > IIRC, there is/was no dependency between these and FF-A patches that are
> > queued in terms of build. I agree there may be dependency to get all the
> > functionality but we can resort to linux-next for that. FF-A is not enabled
> > in the defconfig, so anyone working on FF-A + TPM must enable then and can
> > rely on -next IMHO.
> > 
> > That said, I have already sent PR for FF-A to SoC team and it is already
> > queued for v7.2. I don't have any other plans unless they are fixes.
> 
> Thanks. Then I think it's enough to merge this patch to TPM tree
> when this patchset is approved once.

Oops, sorry I've forgot to tag this although I've mentally accepted
this (which does not unfortunately help move things forward):

It's probably better just put SOB to the tail, or least messiest
I think:

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

> 
> -- 
> Sincerely,
> Yeoreum Yun

BR, Jarkko

