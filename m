Return-Path: <linux-integrity+bounces-9722-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKN5OQ2pHmq3IwAAu9opvQ
	(envelope-from <linux-integrity+bounces-9722-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 02 Jun 2026 11:57:33 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA6A62BFF9
	for <lists+linux-integrity@lfdr.de>; Tue, 02 Jun 2026 11:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6F6AF30157C9
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Jun 2026 09:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42CC367286;
	Tue,  2 Jun 2026 09:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQ4HSQir"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99746286D5E;
	Tue,  2 Jun 2026 09:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780394251; cv=none; b=josCSqgsUuHLpzbDNwoaaEDlAvKL2EwSJTYtpDWGcOaQdeSblO/w1B2XwsokxOJ1HIk/HZiIZvJenlpIPIITyOxvq5371zc0n/Lu0t/njDlEcGWptohCQ9V0vIfYZpu3XZ9AwhwpCvDkhqtoPc/A/A70oSwZl50hptfmJNyKfuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780394251; c=relaxed/simple;
	bh=wMKlGVx2MnyptDjsVMHQ+hlIQD9/WeC/bmFF/ihPQls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1lQE6cmmOBjdw6IuXPWsFoKsled/DaerTK+6kKbVldts95+RFSaRa6bpzCeXHVqeN/g2L9G3UGYOdWYDPUIV8KW4wnLYo81evmhAk0BLJTy7qduSJtceIKm5Ge+Kp6niyr56znQXAHhBX5WCrrBgkLqCdIqusVbubbGPuwxu9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQ4HSQir; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D06821F00893;
	Tue,  2 Jun 2026 09:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780394250;
	bh=lJValK5+2Z0irO1NxpbHzVkGyPU3KW03yPIO5crgh6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bQ4HSQirP4TEA6BQpNPg8Ekem7iWsEKWgec5Vppj+TeoVi4BVIKwzIvLgvXMtPnWL
	 7KChEMIEN51A/EtZY4RhRBChzYZea3UwIt0vRWB9Q0cDssDLoyLgzZ9bUwZ1C893Ix
	 OkuDWMWX/dLtBTv3e9LUx5RRForgUSXJyPyoYUjm/gNWSv01GmJWEP/7GI8+yIO9EL
	 bguhRRGwzBHOaI4+RWJxd/5MlsCAuYOnz0RWvAyP+esMtAmEP9ayYqocGpGlVy6duX
	 fc3PYoSA6yhXmChXdHmBja7LH9dsHXi+v6esAXOSqaCjnrBjfoM8BOc6YTrGCKfgXE
	 LUrIzdkndO4fA==
Date: Tue, 2 Jun 2026 10:57:25 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org, paul@paul-moore.com,
	zohar@linux.ibm.com, roberto.sassu@huaweicloud.com,
	noodles@earth.li, jmorris@namei.org, serge@hallyn.com,
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, jgg@ziepe.ca
Subject: Re: [PATCH v4 3/3] tpm: tpm_crb_ffa: revert defered_probed when
 tpm_crb_ffa is built-in
Message-ID: <20260602-vague-proficient-gibbon-b005c0@sudeepholla>
References: <20260525075404.3480282-1-yeoreum.yun@arm.com>
 <20260525075404.3480282-4-yeoreum.yun@arm.com>
 <ahoXUjbsPmKxfV_R@kernel.org>
 <ah0x+YDypYFzpFqt@e129823.arm.com>
 <20260601-shiny-steel-jellyfish-b38b6e@sudeepholla>
 <ah428rLnpoIersnQ@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah428rLnpoIersnQ@kernel.org>
X-Rspamd-Queue-Id: 5DA6A62BFF9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9722-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sudeep.holla@kernel.org,linux-integrity@vger.kernel.org];
	FREEMAIL_CC(0.00)[arm.com,kernel.org,vger.kernel.org,paul-moore.com,linux.ibm.com,huaweicloud.com,earth.li,namei.org,hallyn.com,gmail.com,oracle.com,ziepe.ca];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Jun 02, 2026 at 04:50:42AM +0300, Jarkko Sakkinen wrote:
> On Mon, Jun 01, 2026 at 09:54:08AM +0100, Sudeep Holla wrote:
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
> Works for me.
> 

Sorry if I was not clear. I haven't included any TPM patches in this series
as part of my FF-A pull request queued for v7.2. So I was asking to route this
via your tree.

-- 
Regards,
Sudeep

