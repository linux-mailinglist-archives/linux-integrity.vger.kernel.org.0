Return-Path: <linux-integrity+bounces-9469-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLgIMfAT+2lLWQMAu9opvQ
	(envelope-from <linux-integrity+bounces-9469-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 06 May 2026 12:12:00 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DEE4D92BD
	for <lists+linux-integrity@lfdr.de>; Wed, 06 May 2026 12:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1BBB630E25C3
	for <lists+linux-integrity@lfdr.de>; Wed,  6 May 2026 10:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E043F9F44;
	Wed,  6 May 2026 09:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SiaNJ+8S"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BE3317146;
	Wed,  6 May 2026 09:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778061545; cv=none; b=F2dLQSosrNUDt8quNYV4SzQamkDob3Uys7DDRS0NySqsks44Agdg7WsckJ28/ePq8OfQ1w4PpzSvf7vL16aLSb77DG3GcVwdp+OF61Quh6tWaRemjhS/nRGLm6xRP6ae1Vk7Vrjf3vg4lnfEpo7YD6oe3zX+gMJpgs9hs63IceI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778061545; c=relaxed/simple;
	bh=sge0Aq4orDl1UUhYfuWpyGkDYKF/J+FuAik5kVD3tJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tEGJIKPxjLsmbZOWv/MpdDOwB/WbqtAknlo+SnPInpS9PvJ1G34ep2B+efdb9FOfMVX9mIBNGG0x84BxFwACYiZLoFMPEGkzpb+Zb5qaFoha1+m1BbkdU95SYG48jdk2mP9SS/uzvkZDPAANvMLJbgqT55SoM7+C6bn4xI8Wqt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SiaNJ+8S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB80C2BCB8;
	Wed,  6 May 2026 09:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778061543;
	bh=sge0Aq4orDl1UUhYfuWpyGkDYKF/J+FuAik5kVD3tJ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SiaNJ+8SKoxpxU1+QfXofbZfQTU/LjV5CQxA+MAk4yI5RxtFOutp9OCk/+e+nM/3A
	 2d3r5fHk3fkMdey4aup3VaFW7XJwImcRKbCtTbkdrlp5rQgWNLkLmegzEFnqofUX+c
	 qRH/b6xmbFV3KB5EZynGQjacqBFYBjRwT81eGpliA80taMZVr9ZH14VEBQ6eV9rA9f
	 TkvnlJL9+LysvDRRZzOKMmXSft0llZZZ12e3hzd0ySHsULeTwYylRCf1Rbwsu0ZvxP
	 OciVtzlVBlkmTD/1P2x5pB/cA7yignXtv9i6wf8+ZF5IOYmqQCZwjO0vAfLolFLms2
	 7pGD6p4mCZv0w==
Date: Wed, 6 May 2026 10:58:57 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@kernel.org>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	jarkko@kernel.org, zohar@linux.ibm.com, roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	maz@kernel.org, oupton@kernel.org, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org
Subject: Re: [RFC PATCH 2/3] firmware: arm_ffa: initialise ff-a after
 finalising pKVM initialisation
Message-ID: <20260506-flawless-rousing-quoll-3acab5@sudeepholla>
References: <20260505095409.1948371-1-yeoreum.yun@arm.com>
 <20260505095409.1948371-3-yeoreum.yun@arm.com>
 <20260505-super-gecko-of-argument-655030@sudeepholla>
 <afoHizU8NgFWzvYW@e129823.arm.com>
 <20260505-adaptable-mussel-of-virtuosity-2751db@sudeepholla>
 <afohuFhVBIyUFEMT@e129823.arm.com>
 <20260506-warm-deer-of-energy-522bfa@sudeepholla>
 <afrygFx4OoCbbr+a@e129823.arm.com>
 <20260506-colossal-bee-of-discussion-08ac76@sudeepholla>
 <afsCs56KfpoMhPH9@e129823.arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afsCs56KfpoMhPH9@e129823.arm.com>
X-Rspamd-Queue-Id: 60DEE4D92BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9469-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,lists.infradead.org,lists.linux.dev,linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,arm.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sudeep.holla@kernel.org,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Wed, May 06, 2026 at 09:58:27AM +0100, Yeoreum Yun wrote:
> > On Wed, May 06, 2026 at 08:49:20AM +0100, Yeoreum Yun wrote:
> > > Hi,
> > > 
> > > I mean like DT node, it seems to add some "FF-A" device for this.
> > > Anyway, right now as your suggestion, let me respin with platform device
> > > again.
> > > 
> > 
> > Please check my branch ffa_plat_dev [1] as I noted in the last email.
> > 
> > -- 
> > Regards,
> > Sudeep
> > 
> > [1] https://git.kernel.org/sudeep.holla/l/ffa_plat_dev
> 
> Sorry, I've seen this email after I sent former mail.
> 
> And since platform_driver_probe() prevents deferred probe.
> I think it need to change jsut platform_driver_register()
> for ffa_driver.
> 

Thanks for pointing that out. Forgot about that as I was focussing on keeping
it as simple as possible. I have updated the branch now.

-- 
Regards,
Sudeep

