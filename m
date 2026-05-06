Return-Path: <linux-integrity+bounces-9463-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8G+UM/Xx+ml1UgMAu9opvQ
	(envelope-from <linux-integrity+bounces-9463-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 06 May 2026 09:47:01 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2154D760C
	for <lists+linux-integrity@lfdr.de>; Wed, 06 May 2026 09:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C874301050F
	for <lists+linux-integrity@lfdr.de>; Wed,  6 May 2026 07:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3633E0245;
	Wed,  6 May 2026 07:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edw4bWt4"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FE93E022A;
	Wed,  6 May 2026 07:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778053617; cv=none; b=JlGdM42sPZmfpx02apP5pq1Ta5OcBI7qrBDQyMD/iRakvDsz56W/ac4VQkq/WFSmbvTkDPkx/N8l7L4e5J/LsNbcTH1V4M2QXF0O6qioQvo6PfODq89mPSCDvWxpQp27FrJrWT31+PGHs/RhkPK0uXb08LTVvG9/xxw2Qk67ACA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778053617; c=relaxed/simple;
	bh=yciUWHPmc3SUKaOblSTZmb2mlEapvuIVhX1wWVo+EO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rxjfj6qFm/DyDRnHQ/rxuy7uT8ZWqdeJjt8bPg7iL1DmVK+vYo//g3ycit/bVqrQMYp/0VvHT4y0MbR20aGMQwKSuLC5cMRXScgUFguLyTw5VykmVeDScDe20MKZiWVG18dArtSDpCwXjQiXAsPMp4q0q4d6PoYzcOAxrpPhLYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edw4bWt4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 465FDC2BCB8;
	Wed,  6 May 2026 07:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778053617;
	bh=yciUWHPmc3SUKaOblSTZmb2mlEapvuIVhX1wWVo+EO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=edw4bWt4BuwT+8VMvdlmmyNkbUfSuCnsn8I47wLVdUe1baqGDMNKtRis/DG6QmF5f
	 uYhcpglQ41NZxUHEoruPxwpCudfhiaExP1H2pS3UhXfd129DiorMM7iW1yyy5QWvrn
	 zJk5CeqZW3FmGUbEyXPcfrESMCnZM1xxu6GuuyzDj9JfqgJdAHbt4NtBV01JSWJeCt
	 sDT5xuaKjgnWxxenMCknvs4XQOfLmM48yj+QYtEJIoYYnPWXVUDPnu0BsRMuOnmXCO
	 xXqTcnDdmkD1PQcrRzKL6g+xA7ZEl0sttFZXG3FHSG1GWlLYAywij/X+la56Bh+AHT
	 w4oE022oeYj8w==
Date: Wed, 6 May 2026 08:46:51 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	Sudeep Holla <sudeep.holla@kernel.org>, jarkko@kernel.org,
	zohar@linux.ibm.com, roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	maz@kernel.org, oupton@kernel.org, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org
Subject: Re: [RFC PATCH 2/3] firmware: arm_ffa: initialise ff-a after
 finalising pKVM initialisation
Message-ID: <20260506-smooth-warthog-of-enthusiasm-e4a9bc@sudeepholla>
References: <20260505095409.1948371-1-yeoreum.yun@arm.com>
 <20260505095409.1948371-3-yeoreum.yun@arm.com>
 <20260505-super-gecko-of-argument-655030@sudeepholla>
 <afoHizU8NgFWzvYW@e129823.arm.com>
 <20260505-adaptable-mussel-of-virtuosity-2751db@sudeepholla>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505-adaptable-mussel-of-virtuosity-2751db@sudeepholla>
X-Rspamd-Queue-Id: 2C2154D760C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9463-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,kernel.org,linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,arm.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sudeep.holla@kernel.org,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Tue, May 05, 2026 at 05:32:15PM +0100, Sudeep Holla wrote:
> On Tue, May 05, 2026 at 04:06:51PM +0100, Yeoreum Yun wrote:
> > Hi Sudeep,
> > 
> > > On Tue, May 05, 2026 at 10:54:08AM +0100, Yeoreum Yun wrote:
> > > > When pKVM is enabled, the FF-A driver must be initialised after pKVM.
> > > > Otherwise, pKVM cannot negotiate the FF-A version or obtain the RX/TX
> > > > buffer information, leading to failures in FF-A calls.
> > > > 
> > > > Currently, pKVM initialisation completes at device_initcall_sync,
> > > > while ffa_init() runs at the device_initcall level.
> > > > 
> > > > So far, linker deployes kvm_arm_init() before ffa_init(), and SMCs can
> > > > still be trapped even before finalise_pkvm() is invoked.
> > > > As a result, this issue has not been observed.
> > > > 
> > > > However, relying on above stuff is fragile.
> > > > Therefore, when pKVM is enabled, the FF-A infrastructure should be
> > > > initialised only after pKVM initialisation has been fully finalised.
> > > > 
> > > > To achieve this, introduce an ffa_root_dev ("arm-ffa") and
> > > > a corresponding driver to defer initialisation of the FF-A infrastructure
> > > > until pKVM initialisation is complete, and to defer probing of all FF-A devices until then
> > > > when pKVM is enabled.
> > > > 
> > > 
> > > I don't like this whole ffa root device design.
> > > Two question for now:
> > > 1. Can FF-A be a module on systems with pKVM which removes the need for all
> > >    this dance done here ?
> > 
> > But this means we reduce the other feature e.x) IMA with TPM over
> > FF-A and pKVM feature. Since IMA must be a built-in, we couldn't avoid
> > to build FF-A driver with built-in.
> > 
> > > 2. If it is a requirement to have this built-in, I prefer to add a probe
> > >    and defer it instead of this root ffa device.
> > 
> > But, How? anyway all of FF-A device & driver couldn't be probed unless
> > FF-A initialisation is finished and How can we trigger FF-A initailise
> > after pKVM finish its initialisation?
> > 
> > The problem is ff-a intiailisation happens before pKVM finish its
> > initailasation and to do defer probe, it should use dd-model and
> > As we discussed in other thread, notifier couldn't be a soluation.
> > 
> > Could you let me share other way I'm missing?
> > 
> 
> Will something like below work ? If we add DT bindings, then we can add
> of_match_table and drop the platform device creation. Also we can adjust
> the parent device the way you have done by a simple change(not done in
> this untested/not compiled change).
> 

I have pushed the changes[1], will post once tested and you confirm your
use-case also works.

-- 
Regards,
Sudeep

[1] https://git.kernel.org/sudeep.holla/l/ffa_plat_dev

