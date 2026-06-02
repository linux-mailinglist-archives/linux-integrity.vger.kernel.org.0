Return-Path: <linux-integrity+bounces-9739-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zBlCATLTHmoZVgAAu9opvQ
	(envelope-from <linux-integrity+bounces-9739-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 02 Jun 2026 14:57:22 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5788462E35C
	for <lists+linux-integrity@lfdr.de>; Tue, 02 Jun 2026 14:57:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=foss header.b=htxJfVbJ;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9739-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9739-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 083503020FD2
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Jun 2026 12:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E5B3C5536;
	Tue,  2 Jun 2026 12:56:42 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798831DF261;
	Tue,  2 Jun 2026 12:56:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780405002; cv=none; b=B7lJSkNXHnWDfVgpgYPbVCooP3V9a1cAFdPtgFLV2JjnFGATU6InawTG8gWElErBbiEQnzN22rKelp7OS622iADLg1nkhMg7qZTFpvDbS61Q01fUmMzFocpA9wUhlfGRdgB8m/ZaQKmic8boBaJaWey2B7X57uLg2Acu6WZucfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780405002; c=relaxed/simple;
	bh=7wsYf/7D0u8ESNWFSm2ElY1xmc2anZep4nrGURpBEUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JLRyrq30agr0Xumb55cTighbEUPibFqrUjMehmTBPRcQL+l4TU2GyRtgNTq++HFX6fLzZVW4AJOkYyvoQISvksDMobfIa2DszO9g7kvUgyYAKFYB9NM2vcH+OSeL+f198R2lxCUATg+CexrmQr9jmf2tSFVMetYURsdcyd+N3Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=htxJfVbJ; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B00DC22EA;
	Tue,  2 Jun 2026 05:56:33 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED8A83F632;
	Tue,  2 Jun 2026 05:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780404998; bh=7wsYf/7D0u8ESNWFSm2ElY1xmc2anZep4nrGURpBEUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=htxJfVbJ7vzwG2Tsi7weAl+dU96bkd/rUkHnIGsVplMEo+ak+SDa4OzYNmKbxyw72
	 oa84ZU9QzXVjKLR1wHMnXeEuleGZHDefl0UYtA10NnHzCPb0KJ1BJo7WpLegDN6LS0
	 vnYNeXtCe1EyDgrMr08gXz+BX8/SOXq31kzoBOGI=
Date: Tue, 2 Jun 2026 13:56:34 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org, paul@paul-moore.com,
	zohar@linux.ibm.com, roberto.sassu@huaweicloud.com,
	noodles@earth.li, sudeep.holla@kernel.org, jmorris@namei.org,
	serge@hallyn.com, dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com, jgg@ziepe.ca
Subject: Re: [PATCH v5 4/4] tpm: tpm_crb_ffa: revert defered_probed when
 tpm_crb_ffa is built-in
Message-ID: <ah7TAk3iItltddzT@e129823.arm.com>
References: <20260601142749.3379697-1-yeoreum.yun@arm.com>
 <20260601142749.3379697-5-yeoreum.yun@arm.com>
 <ah5AD69RNBdE1BvO@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah5AD69RNBdE1BvO@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9739-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,paul-moore.com,linux.ibm.com,huaweicloud.com,earth.li,kernel.org,namei.org,hallyn.com,gmail.com,oracle.com,ziepe.ca];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jarkko@kernel.org,m:linux-security-module@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-integrity@vger.kernel.org,m:paul@paul-moore.com,m:zohar@linux.ibm.com,m:roberto.sassu@huaweicloud.com,m:noodles@earth.li,m:sudeep.holla@kernel.org,m:jmorris@namei.org,m:serge@hallyn.com,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:jgg@ziepe.ca,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER(0.00)[yeoreum.yun@arm.com,linux-integrity@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[arm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yeoreum.yun@arm.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arm.com:dkim,arm.com:from_mime,arm.com:email,vger.kernel.org:from_smtp,e129823.arm.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5788462E35C

> On Mon, Jun 01, 2026 at 03:27:49PM +0100, Yeoreum Yun wrote:
> > commit 746d9e9f62a6 ("tpm: tpm_crb_ffa: try to probe tpm_crb_ffa when it's build_in")
> > probe tpm_crb_ffa forcefully when it's built-in to integrate with IMA.
> > 
> > However, IMA now provides the IMA_INIT_LATE_SYNC build option, which
> > initialises IMA at the late_initcall_sync level, so this change is no
> > longer required.
> > 
> > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> 
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Might be rb tag?. Thanks!

-- 
Sincerely,
Yeoreum Yun

