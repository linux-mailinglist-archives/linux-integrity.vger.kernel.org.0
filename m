Return-Path: <linux-integrity+bounces-9717-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBaYKdA1HmrChwkAu9opvQ
	(envelope-from <linux-integrity+bounces-9717-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 02 Jun 2026 03:45:52 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F52F626EAF
	for <lists+linux-integrity@lfdr.de>; Tue, 02 Jun 2026 03:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DBB113011C7C
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Jun 2026 01:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B17342501;
	Tue,  2 Jun 2026 01:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QknTTocn"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D662D1F44;
	Tue,  2 Jun 2026 01:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780364738; cv=none; b=o+3Fs6cnTfIM63O5HZX/9ifFVRpyq+11lSF7rNrRwisgLohGodzSYdL/I6VGGPTy3P6aMoVqZEnv1GbuBgWnMjb042jTfnhT95SHezvTjwhpPkAsQRERgRhlkDAjKUyFRjovXoWgy5MNSPrhBbrUqfE9Jy6Umwhm+HU6bNML3CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780364738; c=relaxed/simple;
	bh=iOU3gyK+glYccNvi65Hp8Q04CztIbkYp9GyBqfp8e2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LOlKgTtSUr+6KOQvO2be033Lkf3/B76hlVMMLqU8oPye4rokNh2Mj2xTT5ug6bVaUdI4FDdEuWQlCAXUkqLe4BgAIH5nTDMEHRHj6ZT8fb6QYNyGE+WJtHM9R7LUpVvdv5ZbjHxy6UkvDfhvBujLjvLolS43MqFBmWdWrQU6/nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QknTTocn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A6AE71F00893;
	Tue,  2 Jun 2026 01:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780364737;
	bh=peSu8tvEPn14pm26rreO1GbDh7fMnvGCkqxEiwbsCCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QknTTocn8eb+zNATVF1NvVDXMKdkGkJ0OLf8oZvSiG5KY5rVpaUbJs5VEa6IvCTfg
	 x/yQYZwv9fGE4fwoRQxa8nkvWNcJ1ZZlt6wVHJlGj6GHCC0+ImJoGQBa5fhpUScMv7
	 +8aqFw2qRhgr+ijoaObWBoUEveOrDaImfpZLT3lUhPTES9cYljRlpwvlcuclHvg7pF
	 WHA15O831ZK/hM82LvgJLLNqspHa+7wk7Z7bA0rCbSMJ3PaED1I6a8kdT5QE0f+GFX
	 Wjt1yEuj0nwWqs3MUS319gVEBdcSSma/e+F24Kj2nO3FOiYi9zgJYS6yaf1lXiHLDL
	 D3R73S50kAwBg==
Date: Tue, 2 Jun 2026 04:45:33 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org, paul@paul-moore.com,
	zohar@linux.ibm.com, roberto.sassu@huaweicloud.com,
	noodles@earth.li, sudeep.holla@kernel.org, jmorris@namei.org,
	serge@hallyn.com, dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com, jgg@ziepe.ca
Subject: Re: [PATCH v4 3/3] tpm: tpm_crb_ffa: revert defered_probed when
 tpm_crb_ffa is built-in
Message-ID: <ah41vRFwTLUBD4as@kernel.org>
References: <20260525075404.3480282-1-yeoreum.yun@arm.com>
 <20260525075404.3480282-4-yeoreum.yun@arm.com>
 <ahoXUjbsPmKxfV_R@kernel.org>
 <ah0x+YDypYFzpFqt@e129823.arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah0x+YDypYFzpFqt@e129823.arm.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9717-lists,linux-integrity=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,paul-moore.com,linux.ibm.com,huaweicloud.com,earth.li,kernel.org,namei.org,hallyn.com,gmail.com,oracle.com,ziepe.ca];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4F52F626EAF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jun 01, 2026 at 08:17:13AM +0100, Yeoreum Yun wrote:
> Hi Jarkko,
> 
> Sorry for late answer.

it's all good, there's been a bug storm so I'm glad that you have not been
around ;-)

BR, Jarkko

> 
> > On Mon, May 25, 2026 at 08:54:04AM +0100, Yeoreum Yun wrote:
> > > commit 746d9e9f62a6 ("tpm: tpm_crb_ffa: try to probe tpm_crb_ffa when it's build_in")
> > > probe tpm_crb_ffa forcefully when it's built-in to integrate with IMA.
> > > 
> > > However, IMA now provides the IMA_INIT_LATE_SYNC build option, which
> > > initialises IMA at the late_initcall_sync level, so this change is no
> > > longer required.
> > > 
> > > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > > ---
> > >  drivers/char/tpm/tpm_crb_ffa.c | 18 +++---------------
> > >  1 file changed, 3 insertions(+), 15 deletions(-)
> > > 
> > > diff --git a/drivers/char/tpm/tpm_crb_ffa.c b/drivers/char/tpm/tpm_crb_ffa.c
> > > index 99f1c1e5644b..025c4d4b17ca 100644
> > > --- a/drivers/char/tpm/tpm_crb_ffa.c
> > > +++ b/drivers/char/tpm/tpm_crb_ffa.c
> > > @@ -177,23 +177,13 @@ static int tpm_crb_ffa_to_linux_errno(int errno)
> > >   */
> > >  int tpm_crb_ffa_init(void)
> > >  {
> > > -	int ret = 0;
> > > -
> > > -	if (!IS_MODULE(CONFIG_TCG_ARM_CRB_FFA)) {
> > > -		ret = ffa_register(&tpm_crb_ffa_driver);
> > > -		if (ret) {
> > > -			tpm_crb_ffa = ERR_PTR(-ENODEV);
> > > -			return ret;
> > > -		}
> > > -	}
> > > -
> > >  	if (!tpm_crb_ffa)
> > > -		ret = -ENOENT;
> > > +		return -ENOENT;
> > >  
> > >  	if (IS_ERR_VALUE(tpm_crb_ffa))
> > > -		ret = -ENODEV;
> > > +		return -ENODEV;
> > >  
> > > -	return ret;
> > > +	return 0;
> > >  }
> > >  EXPORT_SYMBOL_GPL(tpm_crb_ffa_init);
> > >  
> > > @@ -405,9 +395,7 @@ static struct ffa_driver tpm_crb_ffa_driver = {
> > >  	.id_table = tpm_crb_ffa_device_id,
> > >  };
> > >  
> > > -#ifdef MODULE
> > >  module_ffa_driver(tpm_crb_ffa_driver);
> > > -#endif
> > >  
> > >  MODULE_AUTHOR("Arm");
> > >  MODULE_DESCRIPTION("TPM CRB FFA driver");
> > > -- 
> > > LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
> > > 
> > 
> > How we would sync up this patch? Through which tree etc.
> 
> IMHO, the IMA relevant thing would be into IMA tree,
> However I think this patch would be much easier to sync into Sudeep's
> FF-A tree where ff-a initilisation is reverted to device_initcall
> unless you're uncomfortable.
> 
> For this, It might be better to split this patch from this series
> since by above and defer probe of ff-a would make a register failure
> of registering tpm_crb_ffa driver which is built-in.
> 
> @Sudeep what do you think?
> 
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git/commit/?h=for-next/ffa/updates&id=cc7e8f21b9f0c229d68cf19a837cba82b5ac2d87 [0]
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git/commit/?h=for-next/ffa/updates&id=e659fc8e537c7a21d5d693d6f30d8852f2fa8d91 [1]
> 
> -- 
> Sincerely,
> Yeoreum Yun

