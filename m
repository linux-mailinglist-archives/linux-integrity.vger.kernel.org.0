Return-Path: <linux-integrity+bounces-9492-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEISHY8k/mlTnQAAu9opvQ
	(envelope-from <linux-integrity+bounces-9492-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 08 May 2026 19:59:43 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 170424FA4D1
	for <lists+linux-integrity@lfdr.de>; Fri, 08 May 2026 19:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9413430302BB
	for <lists+linux-integrity@lfdr.de>; Fri,  8 May 2026 17:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB18410D34;
	Fri,  8 May 2026 17:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWAWPDvG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548CD3DA7D3;
	Fri,  8 May 2026 17:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778263178; cv=none; b=FwIuD1DK2imLFMYjZTPwo9ZR9cL7cAz2Q/EmOJ+xXTIOhVuzPntSHM8B8cwHnCROn5srShK2VJn54BzGe3PzHHWU8b/OGB20G+tD4oz58KnpW8r8W/YgDxKDgezjmfY+stDjxDmCiNz7ab2A+4OXb7cB/ur/igaiqYeuOY+9hl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778263178; c=relaxed/simple;
	bh=f+C6+Is1XDoPUTJlfzjwfJtrygH27kCkd9+va+Q5+wQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R3M12kNAD9gI0lnJkYF54CoLDppsktUJAYlba5kuO+AwJtq54KiepBdsoGK2BzYlin7YSxeUClMKZh7AFElaIYA035ZyDYi+h7THF0tn7CCkojU58JJkTpwn4ONEfniyZoPCzKlVcqkOaDAW10wSrNMO29spB3XFFfJOWYZha18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JWAWPDvG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58D32C2BCB0;
	Fri,  8 May 2026 17:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778263178;
	bh=f+C6+Is1XDoPUTJlfzjwfJtrygH27kCkd9+va+Q5+wQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JWAWPDvGtq97KDoBUrMNVn9jGLtr0S6yU0SmNcoAoyE2s2EAXBMnXtXMka60FpLeN
	 TOFqpirW5UGbw7mPrCRrkHf7mSHljwAahNBB4PpxRGUlk0zsQ3JGvXACFJ5JagLcJa
	 4aKx4OzboqGUMVOH29tprYlLnrAKRc9M0h6jp8Xu8JsIc4Uaf4/vQHPH4DD7ofsEMj
	 jZdY4bHynb3dvCv3fYpWYT3cG0WJTIIb1kWp1Cv5pqgdvE3ayQNdJh6xbZnAynDj73
	 8QhrF5OUcnvkDluYPJUNvNH+/1hLDYGVcoY+ThxaAG4VaOG/iLDTGcoig4HtjCMQZY
	 tIoUF86YTBl3A==
Date: Fri, 8 May 2026 18:59:32 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	Sudeep Holla <sudeep.holla@kernel.org>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	jarkko@kernel.org, zohar@linux.ibm.com, roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	maz@kernel.org, oupton@kernel.org, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org
Subject: Re: [RFC PATCH 0/3] initalise ff-a after finalising pKVM
Message-ID: <20260508-ubiquitous-sexy-robin-b1ca51@sudeepholla>
References: <20260505095409.1948371-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505095409.1948371-1-yeoreum.yun@arm.com>
X-Rspamd-Queue-Id: 170424FA4D1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9492-lists,linux-integrity=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, May 05, 2026 at 10:54:06AM +0100, Yeoreum Yun wrote:
> This patch is split out from the patchset [0] --
> fix FF-A call failure with pKVM when the FF-A driver is built-in,
> specifically the IMA-related part.
> 
> When pKVM is enabled, the FF-A driver must be initialised after pKVM.
> Otherwise, pKVM cannot negotiate the FF-A version or obtain the RX/TX
> buffer information, leading to failures in FF-A calls.
> 
> Currently, pKVM initialisation completes at device_initcall_sync,
> while ffa_init() runs at the device_initcall level.
> 
> So far, linker deployes kvm_arm_init() before ffa_init(), and SMCs can
> still be trapped even before finalise_pkvm() is invoked.
> As a result, this issue has not been observed.
> 
> However, relying on above stuff is fragile.
> Therefore, when pKVM is enabled, the FF-A infrastructure should be
> initialised only after pKVM initialisation has been fully finalised.
> 
> To achieve this, introduce an ffa_root_dev ("arm-ffa") and
> a corresponding driver to defer initialisation of the FF-A infrastructure
> until pKVM initialisation is complete, and to defer probing of all FF-A devices until then
> when pKVM is enabled.
>

I have posted an alternative based on all the discussion in this thread
@[1]. I have not cc-ed all the people as the changes are contained in
FF-A driver and not sure if all the cc-ed here are much interested.
All the lists are included I assume and one can always provide feedback
referring to the link.

-- 
Regards,
Sudeep

[1] https://lore.kernel.org/all/20260508-b4-ffa_plat_dev-v1-0-c5a30f8cf7b8@kernel.org/

