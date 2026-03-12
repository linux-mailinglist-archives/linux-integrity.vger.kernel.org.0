Return-Path: <linux-integrity+bounces-8985-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHNEF1Qos2ksSwAAu9opvQ
	(envelope-from <linux-integrity+bounces-8985-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Mar 2026 21:55:48 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E9927999E
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Mar 2026 21:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6F0BE3025134
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Mar 2026 20:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B08363094;
	Thu, 12 Mar 2026 20:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPrZEGSB"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AB629D27D;
	Thu, 12 Mar 2026 20:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773348941; cv=none; b=W8DclWVnDjyStJsIohUPH+pEmQ8S+q+m+U0Z2cDLQ5SFSZaYoFkGT839c9V5ahHcOVA4Pup3tZ/oGpX33dYfwI2XT1ib4q4S1cAC9fP7weQipneYAzuPtrndtfC90r04pvshwm3dQ8qf4PnL0FJ6X//hLo+mv4vpYAIk0pUZQZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773348941; c=relaxed/simple;
	bh=v7Mp7oQuSeeAnOPIaJpcQ06wzPNoyTHncHKVCUFHvZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aDxpe2GxiB/lHri1Be4vQG/ZYMiavrhR8Yq62LteKmNU0hP6P0wZgY9EZfnrheWuXrBBp9Xg4We9yLtru811Le/Af1AJFgsB7ir2KNgQ59xScWho8qsRHpzenma1jGn3z/ITQw+EHqWJ2NcwjKXs1DAkT1JiUdiURivkDSrRHJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPrZEGSB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB758C4CEF7;
	Thu, 12 Mar 2026 20:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773348940;
	bh=v7Mp7oQuSeeAnOPIaJpcQ06wzPNoyTHncHKVCUFHvZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jPrZEGSBi1TQR0t3km00WpEMYTejgQIVQOjE077ht7cWB1pkJRLriLLy7Jjd5Kerz
	 zF+VvIJYLQbTm0nSWzEM/kqqohL3jJQs/qv6MCXKVMRHXi9DKgZYofma5Hzt2KrtFr
	 LR9+Pe0bGHixbeU3D8vgl8LYkd1EypoBTAR1U/yFO6oI+U84EE2D4fltW4APa3K1+5
	 cze6ejEVN8VlLmzwMZySmLHlYPwt3/KtqDYQ10Ylk1r+aGFvg9mPnJPPWWmdDM5mF1
	 B4m5h+JdU/9liZubVMb3aVD+i3ThdUcK6dvL4WIylaTenx7wGKZs4CmHTvYNCoZU1f
	 VBSPEbfslo2XA==
Date: Thu, 12 Mar 2026 13:55:33 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Alexander Egorenkov <egorenar@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, Coiby Xu <coxu@redhat.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] integrity: Eliminate weak definition of
 arch_get_secureboot()
Message-ID: <20260312205533.GC2747807@ax162>
References: <20260309-integrity-drop-weak-arch-get-secureboot-v1-1-6460d5c4bb89@kernel.org>
 <d2089740-16d8-4ca4-a61c-8c381f8e30a0@app.fastmail.com>
 <a985c90d9df8ba0fc63f65117cc8e884f70e6035.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a985c90d9df8ba0fc63f65117cc8e884f70e6035.camel@linux.ibm.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8985-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[arndb.de,huawei.com,gmail.com,oracle.com,linux.ibm.com,ellerman.id.au,kernel.org,paul-moore.com,namei.org,hallyn.com,redhat.com,vger.kernel.org,lists.ozlabs.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathan@kernel.org,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 54E9927999E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 12:07:41PM -0400, Mimi Zohar wrote:
> I pushed out the patch to next-integrity, but am a bit concerned about the
> definition:
> 
> +config HAVE_ARCH_GET_SECUREBOOT
> +       def_bool EFI
> +

What is concerning about the definition with regards to s390?

> Has anyone actually tested this patch on s390, not just compiled it?  If so, I'd
> appreciate a tested-by tag.

It would be good to test (if it is possible to test in QEMU, I am happy
to attempt to do so). As far as I can tell, 31a6a07eefeb placed
arch_get_secureboot() in such a way that the __weak definition would be
used when CONFIG_KEXEC_FILE was disabled, even though ipl_secure_flag
should always be available, which this patch avoids.

Cheers,
Nathan

