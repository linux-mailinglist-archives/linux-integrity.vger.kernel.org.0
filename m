Return-Path: <linux-integrity+bounces-9254-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOBBKNNJ5mnSuAEAu9opvQ
	(envelope-from <linux-integrity+bounces-9254-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Apr 2026 17:44:19 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2812242E835
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Apr 2026 17:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D456C34DF8AF
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Apr 2026 15:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F9C35A3B4;
	Mon, 20 Apr 2026 15:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="BiT8otpw"
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FF3359A91;
	Mon, 20 Apr 2026 15:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776697500; cv=none; b=JZM4Bn7Ki1KczyuO4eleoM+Gr7JFq4+2qeXyGnhxjq75icTtKvhFT4pNhk/lgKsxltYOUiZOWVCqS9lLfb9FTZdXhPhKf5AR8Zfhow6LGJ44e0tgePbK275h1j4GhRhsFV6hjfXlBE/1eH+P6bLFwVy8MU1LpBYyB7NgivPup8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776697500; c=relaxed/simple;
	bh=I53+Jlg3kdlGg/Rj+8bJhpj0apdT2P0ZlMXr6W2UZ4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PVKoNNbWBJZ4lmE2EZlwSHAG+BWj7W4j2bwkoEuyZs0+uqioc87G9yUrOYEoKIgjzzbsE6dnsMeI1efGY6jSWiSvWDzP36U0Cc0DCRbqsLQRdPVXLb8VfPqY8X317N4SQJuEbk71dKW9v3tkNea7dIS8HK3TSzPdxzYtf4ckva4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=BiT8otpw; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 015FF16F2;
	Mon, 20 Apr 2026 08:04:53 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8DDA93F915;
	Mon, 20 Apr 2026 08:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1776697498; bh=I53+Jlg3kdlGg/Rj+8bJhpj0apdT2P0ZlMXr6W2UZ4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BiT8otpw/0GZmJVXuQDMx/xztcku9UYtGTjLlIS1HUYrELacmhj9huNRj0gz4l4Je
	 CuFVeQ8NnZ1FDFu7n0gS7HszvrOGrnamm6HHA/Mi6oMRnWYXF3I6pixSugO2Qa1Yr9
	 tZKmNoQt0x8S2BzUYHNR4G/NgdTMfbieI95nvFZg=
Date: Mon, 20 Apr 2026 16:04:51 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Sebastian Ene <sebastianene@google.com>
Cc: Marc Zyngier <maz@kernel.org>, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	zohar@linux.ibm.com, roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
	peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
	sudeep.holla@kernel.org, oupton@kernel.org, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org
Subject: Re: [RFC PATCH 4/4] firmware: arm_ffa: check pkvm initailised when
 initailise ffa driver
Message-ID: <aeZAkzdUd+A99rbF@e129823.arm.com>
References: <20260417175759.3191279-1-yeoreum.yun@arm.com>
 <20260417175759.3191279-5-yeoreum.yun@arm.com>
 <aeYbdmshGZJ4GhXd@google.com>
 <86mryx2408.wl-maz@kernel.org>
 <aeY2M3v97c00JjFe@google.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aeY2M3v97c00JjFe@google.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.infradead.org,lists.linux.dev,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,huawei.com,gmail.com,oracle.com,gmx.de,ziepe.ca,arm.com];
	TAGGED_FROM(0.00)[bounces-9254-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[arm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yeoreum.yun@arm.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,e129823.arm.com:mid]
X-Rspamd-Queue-Id: 2812242E835
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 02:20:35PM +0000, Sebastian Ene wrote:
> On Mon, Apr 20, 2026 at 01:46:47PM +0100, Marc Zyngier wrote:
> > On Mon, 20 Apr 2026 13:32:32 +0100,
> > Sebastian Ene <sebastianene@google.com> wrote:
> > >
> > > On Fri, Apr 17, 2026 at 06:57:59PM +0100, Yeoreum Yun wrote:
> > >
> > > Hello Yeoreum,
> > >
> > >
> > > > When pKVM is enabled, the FF-A driver must be initialized after pKVM.
> > > > Otherwise, pKVM cannot negotiate the FF-A version or
> > > > obtain RX/TX buffer information, leading to failures in FF-A calls.
> > >
> > > At the moment this already happens after you move back ffa_init() to
> > > device_initcall().
> >
> > But relying on this sort of ordering is just making things more
> > fragile.
> >
>
> Thanks for letting me know. Since this is not a solid construct we will have
> to change the driver init code to come after pKVM in this case.
>
> > >
> > > >
> > > > During FF-A driver initialization, check whether pKVM has been initialized.
> > > > If not, defer probing of the FF-A driver.
> > > >
> > >
> > > I don't think you need to add this dependency. pKVM is
> > > installed through KVM's module_init() which ends up calling hyp_ffa_init() to
> > > do the proxy initialization. The ARM-FFA driver comes after it (since
> > > pKVM is arch specific code). We don't have to call finalize_pkvm(..) to
> > > be able to handle smc(FF-A) calls in the hyp-proxy.
> >
> > You do. Without the finalisation, SMCs are not trapped by EL2.
> >
> > And even if it did, relying on such hack is just wrong.
> >
>
> That makes it an even stronger argument to move the driver init at a
> later stage. I was relying on this to trap early ff-a when the
> ARM FF-A driver was used.


I don’t think moving the FF-A driver initialization to a later stage is
a viable solution. For example, even if it is moved to device_initcall_sync,
it still relies on fragile ordering.

Similarly, moving it to late_initcall is problematic.
Since deferred_probe_initcall() runs at the same level, if it is invoked first,
devices that depend on FF-A (e.g. tpm_ffa_crb) may not be probed correctly,
leading to deferred devices not being handled properly.

Therefore, the FF-A driver should be able to detect when pKVM has been
initialized and perform its initialization accordingly otherwise,
just relying on the trap after kvm_arm_initialised.

--
Sincerely,
Yeoreum Yun

