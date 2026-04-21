Return-Path: <linux-integrity+bounces-9261-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0N5iAsQ652no5QEAu9opvQ
	(envelope-from <linux-integrity+bounces-9261-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Apr 2026 10:52:20 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 609A6438670
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Apr 2026 10:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 116D1302F733
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Apr 2026 08:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B12539FCBA;
	Tue, 21 Apr 2026 08:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rv44PtdN"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BFC397E91;
	Tue, 21 Apr 2026 08:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776761466; cv=none; b=LTjqRaEy3C3BpZ3hpnijgLn/3gCpgLpj10MXuVdkRQyVgIeFM6Lkb6bj0S3z0UTEeiFGQFMHUS0Sq/zWj298mRVeGmR4RXIVWl+zCWmnxllr3FWwaXNplkWENXLweCcKul6BSAYCg/Dxx4IJ3/Z0s/hXVp+ass8aaGDHmdtD/J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776761466; c=relaxed/simple;
	bh=MEcfYsbBJrV5oQCJrkPYya9PsDdj0dGclYzGZ/NMaoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pAYO/ixxRCMR/qpk1aGjbXWYK/h3Jyhghnj7/raXS4R5PDWEeNosbZ4VAw8Yi0tpiLnFOg7DtQgzSwXouZ41l0y8c/pjb2xn14seWRTT65Hj9PWrSKlu44c/PFdOn7Prc1MeURrSQ+qK8dd0HizOgPvgLiz2hBMEfrl/twws1lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rv44PtdN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599BDC2BCB0;
	Tue, 21 Apr 2026 08:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776761466;
	bh=MEcfYsbBJrV5oQCJrkPYya9PsDdj0dGclYzGZ/NMaoQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rv44PtdNr22dtKoHbGMuLuFFdDw3bvbNc/DmRgWcVmzuLDomT92rSJwcxKDhGkp12
	 uChD5+vAcrJkapF5msWb3hc0PiiVDwDmzlGoauk1Rp2hY32637iD1HS2jLeGWkvp+x
	 edMAVyiQGC5RxPdppq0LUGkGu6K9qFCKeVben/2I3gES4JuF8UARLHj1qiTyCwPE/u
	 m+NtImr7q56WBR4t+1HZKryZVgRkH7dBrpFJf5zKucpkHEBCOhpxF/pM8sKE3OdSmT
	 W4UDnvSbmjKR5A1xIvcAbgjSGw5+Ln1he9pK+LXtZse27pu1GgMaEzU++/Z68J8qj0
	 l7d6KLvBeommg==
Date: Tue, 21 Apr 2026 09:51:00 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	zohar@linux.ibm.com, roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
	peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
	oupton@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org
Subject: Re: [RFC PATCH 4/4] firmware: arm_ffa: check pkvm initailised when
 initailise ffa driver
Message-ID: <20260421-married-liberal-ammonite-dffda8@sudeepholla>
References: <20260417175759.3191279-1-yeoreum.yun@arm.com>
 <20260417175759.3191279-5-yeoreum.yun@arm.com>
 <87se8sbozv.wl-maz@kernel.org>
 <aeNeNjfO7i128TIP@e129823.arm.com>
 <87pl3vb5bm.wl-maz@kernel.org>
 <aecf57rWloQwDh6v@e129823.arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aecf57rWloQwDh6v@e129823.arm.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9261-lists,linux-integrity=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.infradead.org,lists.linux.dev,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,huawei.com,gmail.com,oracle.com,gmx.de,ziepe.ca,arm.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sudeep.holla@kernel.org,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 609A6438670
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 07:57:43AM +0100, Yeoreum Yun wrote:

[...]

> 
> Also, the FF-A initialization is not driven by a device probe, but rather
> happens as part of the bus registration itself,
> so it does not fit well with a device_link or probe deferral based approach.
> 
> Instead, perhaps we could go with the idea I mentioned previously:
> either introduce a notifier, or create a pseudo ffa_device
> once pKVM initialization has completed, and
> then let the ffa driver perform the additional initialization from there.
> 
> Am I missing something?
> 

In order to handle/cleanup some ugliness in interrupt management in the
FF-A driver, we may introduce DT node eventually. But it will take sometime.

-- 
Regards,
Sudeep

