Return-Path: <linux-integrity+bounces-9467-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCmuGM8C+2kbVQMAu9opvQ
	(envelope-from <linux-integrity+bounces-9467-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 06 May 2026 10:58:55 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B274D835A
	for <lists+linux-integrity@lfdr.de>; Wed, 06 May 2026 10:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C66B7301572A
	for <lists+linux-integrity@lfdr.de>; Wed,  6 May 2026 08:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A023EDAB3;
	Wed,  6 May 2026 08:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="WQg9q3wM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431283ECBC9;
	Wed,  6 May 2026 08:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778057917; cv=none; b=DWBQ+ruzAd1gDJFdhjFeFomiHWqYIPBESLN6A0aWobfwOU7oHNup1aDpWDeDFG8plYEh+4DjYh4e0mihuchx6oi5as2bVcadZcqO2nfrW3hU/9AYat9cZPx79uNmBNR+ddRI5SzUTGNE5iXjVmWLAQ16iat206K3Bm9Nx58uOOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778057917; c=relaxed/simple;
	bh=qmBmjzeAcJ5nql9S7tzn6aZ63xzXy+8siom1eVtABjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JKlpoyK8Y6+aH35mXHL72gmEeLOA+DjblOZQokkrX5tcIW+Y6MgIslhM/9KQbxNw3Ymk5F/Snf1kSfNTGJgNQ5WOWi22hVNorv9JUr7yb9vmlgIIXCc0TuHc48r0mo29/jAvmx7e43dm6pLC6TaqUb+gU2T6zwkVNrKJrwg6ODw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=WQg9q3wM; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F2AC1A25;
	Wed,  6 May 2026 01:58:27 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F2E203F836;
	Wed,  6 May 2026 01:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778057913; bh=qmBmjzeAcJ5nql9S7tzn6aZ63xzXy+8siom1eVtABjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WQg9q3wMZNS1Lu5L5NkIQs4DobfTcUmY2PhRDEDniXlR58HKmmfpRpdh3Aa8RmmBn
	 fJrO031dJgDWxwpzKa7fbFC5z3tMFCLuNVdeAurF7QW3BOT+hLdvJ0Oi+8wtkoAw1J
	 7KfSmYPOZnWpMoT140ilwt+hj1udjhcYEogZrObE=
Date: Wed, 6 May 2026 09:58:27 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Sudeep Holla <sudeep.holla@kernel.org>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	jarkko@kernel.org, zohar@linux.ibm.com, roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	maz@kernel.org, oupton@kernel.org, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org
Subject: Re: [RFC PATCH 2/3] firmware: arm_ffa: initialise ff-a after
 finalising pKVM initialisation
Message-ID: <afsCs56KfpoMhPH9@e129823.arm.com>
References: <20260505095409.1948371-1-yeoreum.yun@arm.com>
 <20260505095409.1948371-3-yeoreum.yun@arm.com>
 <20260505-super-gecko-of-argument-655030@sudeepholla>
 <afoHizU8NgFWzvYW@e129823.arm.com>
 <20260505-adaptable-mussel-of-virtuosity-2751db@sudeepholla>
 <afohuFhVBIyUFEMT@e129823.arm.com>
 <20260506-warm-deer-of-energy-522bfa@sudeepholla>
 <afrygFx4OoCbbr+a@e129823.arm.com>
 <20260506-colossal-bee-of-discussion-08ac76@sudeepholla>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506-colossal-bee-of-discussion-08ac76@sudeepholla>
X-Rspamd-Queue-Id: 41B274D835A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,kernel.org,linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,arm.com];
	TAGGED_FROM(0.00)[bounces-9467-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[arm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yeoreum.yun@arm.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,arm.com:dkim]

> On Wed, May 06, 2026 at 08:49:20AM +0100, Yeoreum Yun wrote:
> > Hi,
> > 
> > I mean like DT node, it seems to add some "FF-A" device for this.
> > Anyway, right now as your suggestion, let me respin with platform device
> > again.
> > 
> 
> Please check my branch ffa_plat_dev [1] as I noted in the last email.
> 
> -- 
> Regards,
> Sudeep
> 
> [1] https://git.kernel.org/sudeep.holla/l/ffa_plat_dev

Sorry, I've seen this email after I sent former mail.

And since platform_driver_probe() prevents deferred probe.
I think it need to change jsut platform_driver_register()
for ffa_driver.

Thanks!

-- 
Sincerely,
Yeoreum Yun

