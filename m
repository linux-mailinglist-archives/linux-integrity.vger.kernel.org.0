Return-Path: <linux-integrity+bounces-9767-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Lz8SJPI8JmpCTwIAu9opvQ
	(envelope-from <linux-integrity+bounces-9767-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 08 Jun 2026 05:54:26 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7AB65284A
	for <lists+linux-integrity@lfdr.de>; Mon, 08 Jun 2026 05:54:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=BDKr1imC;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9767-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9767-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C45D300EAB3
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Jun 2026 03:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78C41F7575;
	Mon,  8 Jun 2026 03:54:23 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C933B1B3;
	Mon,  8 Jun 2026 03:54:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780890863; cv=none; b=ZugLKcvcK1EfLAgMqiJFybSSrUGmo9+QfvTbyF6eo6cQ5fsunwTvSYt8gSIBVAzhGoUeoY3+EfpVdcduYz+/PrB5iAt7CeaCfJA2PVPdkmtKVpUQPen5mNDWxRpggRhfr5Ji49ft9F10F5kNWX8q5GLE0kHgR5bqJS7sNc5iK0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780890863; c=relaxed/simple;
	bh=81HZNmdle6HQPLeMIIIJPwek/zBBuWVSb9DSx9ImLQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eD4dgpH7K0ien9BIB/J1hujExzDFOeI0Ecfh67ZncxbyniUTy/gobb5uVFxEjRj01Nl+R6dPZIe56jt/0RK8ymTnuQiw5PoRz5IRCMEj8cXBKXLVZipnk8hb09riVib4wH8ax+KU8ubyXHEeTZHZ2lDnKiemS/zWouEdzspaSzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDKr1imC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 8C8DA1F00893;
	Mon,  8 Jun 2026 03:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780890862;
	bh=2yF6IXnzl6ul7Ol/oQMfdDb0ydAjbSwjDiAFbu+c7Ag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BDKr1imC3JX0SWWEb25YQ0aqDpyuqicv+hW9zkzBQx7KB3zwTktyI7y44rQF2CL2S
	 faCrrQuu7xCWdn7X0LOPTC72x4KbpYA1de5s5NS+zWcNFM1+TZ+Zr56gesSVadXCO1
	 RaRmIXe6KtRyrLB7tgL5q82iIDp0ZUF5sgrnmqfVxqr1FdUAbV+JD2hFHpo3LUCtLd
	 nTZbQcr3XeDG+96ro8wfX551e0E+eVAd2/mBbs5rRFvMcBMTTgFHDmPFJJ2X9niP/L
	 9jk09uGuWGdgoOUPKpy/zdhPJ57eE4ztyCLaBWvj4G12QLO2WWLjIeD78T/Qi8rPaB
	 mjKIscKBH7viQ==
Date: Mon, 8 Jun 2026 06:54:18 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Sudeep Holla <sudeep.holla@kernel.org>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org, paul@paul-moore.com,
	zohar@linux.ibm.com, roberto.sassu@huaweicloud.com,
	noodles@earth.li, jmorris@namei.org, serge@hallyn.com,
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, jgg@ziepe.ca
Subject: Re: [PATCH v4 3/3] tpm: tpm_crb_ffa: revert defered_probed when
 tpm_crb_ffa is built-in
Message-ID: <aiY86gtIdaLwaaoC@kernel.org>
References: <20260525075404.3480282-1-yeoreum.yun@arm.com>
 <20260525075404.3480282-4-yeoreum.yun@arm.com>
 <ahoXUjbsPmKxfV_R@kernel.org>
 <ah0x+YDypYFzpFqt@e129823.arm.com>
 <20260601-shiny-steel-jellyfish-b38b6e@sudeepholla>
 <ah428rLnpoIersnQ@kernel.org>
 <20260602-vague-proficient-gibbon-b005c0@sudeepholla>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602-vague-proficient-gibbon-b005c0@sudeepholla>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9767-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sudeep.holla@kernel.org,m:yeoreum.yun@arm.com,m:linux-security-module@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-integrity@vger.kernel.org,m:paul@paul-moore.com,m:zohar@linux.ibm.com,m:roberto.sassu@huaweicloud.com,m:noodles@earth.li,m:jmorris@namei.org,m:serge@hallyn.com,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:jgg@ziepe.ca,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[arm.com,vger.kernel.org,paul-moore.com,linux.ibm.com,huaweicloud.com,earth.li,namei.org,hallyn.com,gmail.com,oracle.com,ziepe.ca];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DE7AB65284A

On Tue, Jun 02, 2026 at 10:57:25AM +0100, Sudeep Holla wrote:
> On Tue, Jun 02, 2026 at 04:50:42AM +0300, Jarkko Sakkinen wrote:
> > On Mon, Jun 01, 2026 at 09:54:08AM +0100, Sudeep Holla wrote:
> > > On Mon, Jun 01, 2026 at 08:17:13AM +0100, Yeoreum Yun wrote:
> > > > Hi Jarkko,
> > > > 
> > > > Sorry for late answer.
> > > > 
> > > > > On Mon, May 25, 2026 at 08:54:04AM +0100, Yeoreum Yun wrote:
> > > > > > commit 746d9e9f62a6 ("tpm: tpm_crb_ffa: try to probe tpm_crb_ffa when it's build_in")
> > > > > > probe tpm_crb_ffa forcefully when it's built-in to integrate with IMA.
> > > > > > 
> > > > > > However, IMA now provides the IMA_INIT_LATE_SYNC build option, which
> > > > > > initialises IMA at the late_initcall_sync level, so this change is no
> > > > > > longer required.
> > > > > > 
> > > > > > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > > > > > ---
> > > > > >  drivers/char/tpm/tpm_crb_ffa.c | 18 +++---------------
> > > > > >  1 file changed, 3 insertions(+), 15 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/char/tpm/tpm_crb_ffa.c b/drivers/char/tpm/tpm_crb_ffa.c
> > > > > > index 99f1c1e5644b..025c4d4b17ca 100644
> > > > > > --- a/drivers/char/tpm/tpm_crb_ffa.c
> > > > > > +++ b/drivers/char/tpm/tpm_crb_ffa.c
> > > > > > @@ -177,23 +177,13 @@ static int tpm_crb_ffa_to_linux_errno(int errno)
> > > > > >   */
> > > > > >  int tpm_crb_ffa_init(void)
> > > > > >  {
> > > > > > -	int ret = 0;
> > > > > > -
> > > > > > -	if (!IS_MODULE(CONFIG_TCG_ARM_CRB_FFA)) {
> > > > > > -		ret = ffa_register(&tpm_crb_ffa_driver);
> > > > > > -		if (ret) {
> > > > > > -			tpm_crb_ffa = ERR_PTR(-ENODEV);
> > > > > > -			return ret;
> > > > > > -		}
> > > > > > -	}
> > > > > > -
> > > > > >  	if (!tpm_crb_ffa)
> > > > > > -		ret = -ENOENT;
> > > > > > +		return -ENOENT;
> > > > > >  
> > > > > >  	if (IS_ERR_VALUE(tpm_crb_ffa))
> > > > > > -		ret = -ENODEV;
> > > > > > +		return -ENODEV;
> > > > > >  
> > > > > > -	return ret;
> > > > > > +	return 0;
> > > > > >  }
> > > > > >  EXPORT_SYMBOL_GPL(tpm_crb_ffa_init);
> > > > > >  
> > > > > > @@ -405,9 +395,7 @@ static struct ffa_driver tpm_crb_ffa_driver = {
> > > > > >  	.id_table = tpm_crb_ffa_device_id,
> > > > > >  };
> > > > > >  
> > > > > > -#ifdef MODULE
> > > > > >  module_ffa_driver(tpm_crb_ffa_driver);
> > > > > > -#endif
> > > > > >  
> > > > > >  MODULE_AUTHOR("Arm");
> > > > > >  MODULE_DESCRIPTION("TPM CRB FFA driver");
> > > > > > -- 
> > > > > > LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
> > > > > > 
> > > > > 
> > > > > How we would sync up this patch? Through which tree etc.
> > > > 
> > > > IMHO, the IMA relevant thing would be into IMA tree,
> > > > However I think this patch would be much easier to sync into Sudeep's
> > > > FF-A tree where ff-a initilisation is reverted to device_initcall
> > > > unless you're uncomfortable.
> > > > 
> > > > For this, It might be better to split this patch from this series
> > > > since by above and defer probe of ff-a would make a register failure
> > > > of registering tpm_crb_ffa driver which is built-in.
> > > > 
> > > > @Sudeep what do you think?
> > > > 
> > > 
> > > IIRC, there is/was no dependency between these and FF-A patches that are
> > > queued in terms of build. I agree there may be dependency to get all the
> > > functionality but we can resort to linux-next for that. FF-A is not enabled
> > > in the defconfig, so anyone working on FF-A + TPM must enable then and can
> > > rely on -next IMHO.
> > > 
> > > That said, I have already sent PR for FF-A to SoC team and it is already
> > > queued for v7.2. I don't have any other plans unless they are fixes.
> > 
> > Works for me.
> > 
> 
> Sorry if I was not clear. I haven't included any TPM patches in this series
> as part of my FF-A pull request queued for v7.2. So I was asking to route this
> via your tree.

It's now in 'for-next-tpm'. Just pushed.

> 
> -- 
> Regards,
> Sudeep

BR, Jarkko

