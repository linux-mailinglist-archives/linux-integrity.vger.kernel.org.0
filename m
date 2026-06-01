Return-Path: <linux-integrity+bounces-9706-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMHoL+xfHWo/ZwkAu9opvQ
	(envelope-from <linux-integrity+bounces-9706-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 01 Jun 2026 12:33:16 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3887061D889
	for <lists+linux-integrity@lfdr.de>; Mon, 01 Jun 2026 12:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 07B303295A3F
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Jun 2026 10:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD49399377;
	Mon,  1 Jun 2026 10:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="jfJc/omk"
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3738C393DF0;
	Mon,  1 Jun 2026 10:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780308120; cv=none; b=SpTc79jH1tTt4eMQ6Xnhz7TftB1DGAgB5xiYB1eFeYfdNdHPD7k4kuJvlD7GsCdX8OzJKz+G9bGeD41Co+h3AL2dpR+HVK3dkQAvsyOOQk+htruc0ofxvgnvhkqtzHM+7sSkDjJT4x5DnhXDokomzRPjW0UlqDZfI5eEyKN1vz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780308120; c=relaxed/simple;
	bh=WhKBYQjkcocB0XlUA6nqiQgnsCY56+0zFBqbKB7I2+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMtVR8kgfxrBHBsEOjlEZafkQao01f28Z3XXGOGupRKYg8Rt1ZYJEsVp8GQ9N1w0LM+xrwR7CUeeWi/DdleQ2cKAY+3IywPKZBYYA/cjM9uXHCl9oO4drHqJvf2RRAd0OWeBPgS7FuLBzW3fY/azPN2N6mFx58F+C+Yqf3RkGvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=jfJc/omk; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 638481E8D;
	Mon,  1 Jun 2026 03:01:47 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A4A4A3F905;
	Mon,  1 Jun 2026 03:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780308112; bh=WhKBYQjkcocB0XlUA6nqiQgnsCY56+0zFBqbKB7I2+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jfJc/omkSGCCWfPqsCyUuBdN+GjGhx4bJ/wq/tZsCQecw2Lw3STbKHj2Nw82tZuvC
	 zN755jQ9oycfTNnp08DTirtMnG0jSJvBqQNu8Ppjj//pbxMxMzP1at8QXsdHr40MA5
	 OOswJPVLjNJ/egr8TddpGXwdJt2qC1GqA4I0Ji8o=
Date: Mon, 1 Jun 2026 11:01:48 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Sudeep Holla <sudeep.holla@kernel.org>
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org, paul@paul-moore.com,
	zohar@linux.ibm.com, roberto.sassu@huaweicloud.com,
	noodles@earth.li, jmorris@namei.org, serge@hallyn.com,
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, jgg@ziepe.ca
Subject: Re: [PATCH v4 3/3] tpm: tpm_crb_ffa: revert defered_probed when
 tpm_crb_ffa is built-in
Message-ID: <ah1YjJJmrkecklko@e129823.arm.com>
References: <20260525075404.3480282-1-yeoreum.yun@arm.com>
 <20260525075404.3480282-4-yeoreum.yun@arm.com>
 <ahoXUjbsPmKxfV_R@kernel.org>
 <ah0x+YDypYFzpFqt@e129823.arm.com>
 <20260601-shiny-steel-jellyfish-b38b6e@sudeepholla>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601-shiny-steel-jellyfish-b38b6e@sudeepholla>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,paul-moore.com,linux.ibm.com,huaweicloud.com,earth.li,namei.org,hallyn.com,gmail.com,oracle.com,ziepe.ca];
	TAGGED_FROM(0.00)[bounces-9706-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[arm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yeoreum.yun@arm.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,arm.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3887061D889
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> On Mon, Jun 01, 2026 at 08:17:13AM +0100, Yeoreum Yun wrote:
> > Hi Jarkko,
> > 
> > Sorry for late answer.
> > 
> > > On Mon, May 25, 2026 at 08:54:04AM +0100, Yeoreum Yun wrote:
> > > > commit 746d9e9f62a6 ("tpm: tpm_crb_ffa: try to probe tpm_crb_ffa when it's build_in")
> > > > probe tpm_crb_ffa forcefully when it's built-in to integrate with IMA.
> > > > 
> > > > However, IMA now provides the IMA_INIT_LATE_SYNC build option, which
> > > > initialises IMA at the late_initcall_sync level, so this change is no
> > > > longer required.
> > > > 
> > > > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > > > ---
> > > >  drivers/char/tpm/tpm_crb_ffa.c | 18 +++---------------
> > > >  1 file changed, 3 insertions(+), 15 deletions(-)
> > > > 
> > > > diff --git a/drivers/char/tpm/tpm_crb_ffa.c b/drivers/char/tpm/tpm_crb_ffa.c
> > > > index 99f1c1e5644b..025c4d4b17ca 100644
> > > > --- a/drivers/char/tpm/tpm_crb_ffa.c
> > > > +++ b/drivers/char/tpm/tpm_crb_ffa.c
> > > > @@ -177,23 +177,13 @@ static int tpm_crb_ffa_to_linux_errno(int errno)
> > > >   */
> > > >  int tpm_crb_ffa_init(void)
> > > >  {
> > > > -	int ret = 0;
> > > > -
> > > > -	if (!IS_MODULE(CONFIG_TCG_ARM_CRB_FFA)) {
> > > > -		ret = ffa_register(&tpm_crb_ffa_driver);
> > > > -		if (ret) {
> > > > -			tpm_crb_ffa = ERR_PTR(-ENODEV);
> > > > -			return ret;
> > > > -		}
> > > > -	}
> > > > -
> > > >  	if (!tpm_crb_ffa)
> > > > -		ret = -ENOENT;
> > > > +		return -ENOENT;
> > > >  
> > > >  	if (IS_ERR_VALUE(tpm_crb_ffa))
> > > > -		ret = -ENODEV;
> > > > +		return -ENODEV;
> > > >  
> > > > -	return ret;
> > > > +	return 0;
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(tpm_crb_ffa_init);
> > > >  
> > > > @@ -405,9 +395,7 @@ static struct ffa_driver tpm_crb_ffa_driver = {
> > > >  	.id_table = tpm_crb_ffa_device_id,
> > > >  };
> > > >  
> > > > -#ifdef MODULE
> > > >  module_ffa_driver(tpm_crb_ffa_driver);
> > > > -#endif
> > > >  
> > > >  MODULE_AUTHOR("Arm");
> > > >  MODULE_DESCRIPTION("TPM CRB FFA driver");
> > > > -- 
> > > > LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
> > > > 
> > > 
> > > How we would sync up this patch? Through which tree etc.
> > 
> > IMHO, the IMA relevant thing would be into IMA tree,
> > However I think this patch would be much easier to sync into Sudeep's
> > FF-A tree where ff-a initilisation is reverted to device_initcall
> > unless you're uncomfortable.
> > 
> > For this, It might be better to split this patch from this series
> > since by above and defer probe of ff-a would make a register failure
> > of registering tpm_crb_ffa driver which is built-in.
> > 
> > @Sudeep what do you think?
> > 
> 
> IIRC, there is/was no dependency between these and FF-A patches that are
> queued in terms of build. I agree there may be dependency to get all the
> functionality but we can resort to linux-next for that. FF-A is not enabled
> in the defconfig, so anyone working on FF-A + TPM must enable then and can
> rely on -next IMHO.
> 
> That said, I have already sent PR for FF-A to SoC team and it is already
> queued for v7.2. I don't have any other plans unless they are fixes.

Thanks. Then I think it's enough to merge this patch to TPM tree
when this patchset is approved once.

-- 
Sincerely,
Yeoreum Yun

