Return-Path: <linux-integrity+bounces-9287-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAUqHK7j6WlQmgIAu9opvQ
	(envelope-from <linux-integrity+bounces-9287-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Apr 2026 11:17:34 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7B844F291
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Apr 2026 11:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C4D23092D99
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Apr 2026 09:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53AC3E2740;
	Thu, 23 Apr 2026 09:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQOMP5f0"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656AA21771B;
	Thu, 23 Apr 2026 09:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776935591; cv=none; b=mIZJ6JMTcHoY0jGx5Bz5vCURVQ8ALfeRfjPil2mmv61zv8jppmEsV0S/bpcBQRC4FzDpDj9vbHwuMDuzP61qIl2S9fwCzxyWQ91Xf6i+tW4BpdVfhFWxJmhz2sejWu4CpohsIn3TSHXlBDNPMzeq3hoDuDFK3oVPjaqYMvDBdU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776935591; c=relaxed/simple;
	bh=I8yq6oDEe4IHbD8yPEv7ivQ6TWif+Z1YOjsoLQles1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D08oY/EYG2M80KNMNm0/2KU3oyjXCfR56deoyo3q7SshSPdcb1psagP8L3M2lJmZaBriTNtNcfrfvIdA2b9JOPxLGhCapYf5vg6ePseRAuWuZWxhUBW0FuzF3VKn9jMkavs0oJWxkSmwGpQ+G10dhFBurCIf0mz6fHUYB0wskMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQOMP5f0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E36FC2BCAF;
	Thu, 23 Apr 2026 09:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776935590;
	bh=I8yq6oDEe4IHbD8yPEv7ivQ6TWif+Z1YOjsoLQles1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dQOMP5f0VjHvc+YmGVPGeaieUSfRjE7tm5+nujJeHLGpAPi157n1VwdkekO4Lvu53
	 gnjOw9zdf6fYt2M40uSV7CvZfaQ/weaTj5RGyTKeXgRQDOS+XrYP44ckrZVJHv9hNK
	 0RI/prRi3lzYNFJ8YFTTkjW1c/KknZBLGdFaoJG5Xx655MRuXf6iJEcO1O9bi7ur1/
	 P/Z/VlmG1RtNZChbqrg1DE09zSdKfta2WGH3UjbCBxFYyWbxRVmyTJxIqngTQ8CeGR
	 6N4dHCFtLOGvfo8qfYJMfbn/EAIrcyXsF9IOxNHp/g/7c6nE6lojb0qA8+B6TXdLAc
	 iBDH32pN6SkaQ==
Date: Thu, 23 Apr 2026 10:13:05 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@kernel.org>,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	zohar@linux.ibm.com, roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
	jarkko@kernel.org, jgg@ziepe.ca, maz@kernel.org, oupton@kernel.org,
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org, noodles@meta.com,
	sebastianene@google.com
Subject: Re: [RFC PATCH v2 3/4] firmware: arm_ffa: revert ffa_init() initcall
 level to device_initcall
Message-ID: <20260423-rich-caped-seal-b00d07@sudeepholla>
References: <20260422162449.1814615-1-yeoreum.yun@arm.com>
 <20260422162449.1814615-4-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422162449.1814615-4-yeoreum.yun@arm.com>
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
	TAGGED_FROM(0.00)[bounces-9287-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,lists.infradead.org,lists.linux.dev,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,huawei.com,gmail.com,oracle.com,ziepe.ca,arm.com,meta.com,google.com];
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
X-Rspamd-Queue-Id: AF7B844F291
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 05:24:48PM +0100, Yeoreum Yun wrote:
> commit 0e0546eabcd6 ("firmware: arm_ffa: Change initcall level of ffa_init() to rootfs_initcall")
> changed the initcall level of ffa_init() to rootfs_initcall to address
> an issue where IMA could not properly recognize the TPM device.
> 
> However, this introduces a problem: pKVM fails to handle any FF-A calls
> because it cannot trap the FFA_VERSION call invoked by ffa_init().
> 
> Since the IMA init function level has been changed to late_initcall_sync,
> there is no longer a need to keep ffa_init() at rootfs_initcall.
> Revert it back to device_initcall.
> 

I prefer you do actual git revert on the original commit for this as well
as the TPM CRM FFA driver explaining how the original idea fails in certain
conditions. Don't add it as separate commit and add fixes tag to the
original commits.

-- 
Regards,
Sudeep

