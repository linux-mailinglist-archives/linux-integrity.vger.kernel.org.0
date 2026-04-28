Return-Path: <linux-integrity+bounces-9353-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PUxMpa/8GnSYAEAu9opvQ
	(envelope-from <linux-integrity+bounces-9353-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Apr 2026 16:09:26 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF41486937
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Apr 2026 16:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 01BB53344643
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Apr 2026 13:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55B123C50A;
	Tue, 28 Apr 2026 13:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="pdhUfWsd"
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84D91B3B19;
	Tue, 28 Apr 2026 13:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777382489; cv=none; b=EM3gB5NU/SuTwR+J7vBfHQLNxVqQ6K32kMxNOhijE7zWxRIaz7haSkM/tBkeoISEyzgnIiH8Xn2ci8rQwGx82DGUAzQddJu3yCWdCfBsKre5C05AZNU5TFTeJS4MEhBbp9LRVQJ3hoJdK8YGmIUwAktpBC/QjjXIOkkxWM54gO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777382489; c=relaxed/simple;
	bh=bsvWlDxYnAplPFAgfU//71QRl4oKYiApqcT8JyjzfgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jcX2plEHErok5CmLfmG9+w0DUE+VyNrx2BpcHW9PANdqxKlJA/HpAeoHUJUWo6cdN0CEwX/UewuiZ44OdMwDnrz0JtAil6zVgA/cFfWzeT4j7JwiKW2O/QZRfMkys6siSo4QktX7dRaXZ3WfQK+Y9FHeLVhIKMPgSMKiPFCDV+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=pdhUfWsd; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 830982BCB;
	Tue, 28 Apr 2026 06:21:21 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DADBE3F62B;
	Tue, 28 Apr 2026 06:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777382487; bh=bsvWlDxYnAplPFAgfU//71QRl4oKYiApqcT8JyjzfgE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pdhUfWsdmeN3C7bkilDKrPemnn+Oq83RRdC0jvgk7oqYcB095DXFCXxYuWkk0UNEX
	 fIpcey6sslxOGabc6XfGzmecVE2summH/DK2QVGNggJHiRT0Sc7B2RNU7tnq4Eh50E
	 BfHAUUmAgFezutGPVgqHQ6FZ1hjcTqgpvtFQwlmg=
Date: Tue, 28 Apr 2026 14:21:20 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, roberto.sassu@huawei.com,
	Jonathan McDowell <noodles@earth.li>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	jmorris@namei.org, serge@hallyn.com, dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com, jarkko@kernel.org, jgg@ziepe.ca,
	sudeep.holla@kernel.org, maz@kernel.org, oupton@kernel.org,
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org, noodles@meta.com,
	sebastianene@google.com
Subject: Re: [RFC PATCH v2 1/4] security: ima: call ima_init() again at
 late_initcall_sync for defered TPM
Message-ID: <afC0UPfGhNTsXnyi@e129823.arm.com>
References: <aephL3MzYoqFGaT5@e129823.arm.com>
 <CAHC9VhRQWHEWQ5NzOPiu8jtYv6UsRm8WVS4fd74AbkOcAd4y_g@mail.gmail.com>
 <aesGU8a3mbVzvteH@e129823.arm.com>
 <CAHC9VhSaT_quKYnpFjAfqvL07JNbWMgM6c4pB9F46NHawX3DCA@mail.gmail.com>
 <014cf39aa8d6a0bcfa1a95c069675977ac67b843.camel@linux.ibm.com>
 <CAHC9VhTW3=RJ8L91RWXYYA9tFjfSXGN-DMEEwdiD6big9H57Ew@mail.gmail.com>
 <1f78fc75b2e95239973612a4b6c4cc782960b7ac.camel@linux.ibm.com>
 <CAHC9VhS4JmPmCJrYTdbjxb3TO-uK6cB3Zij-ef=wswGce2BGzg@mail.gmail.com>
 <1e51c2fd090e5ceb07b1d09e50650c70fd3ccdb1.camel@linux.ibm.com>
 <CAHC9VhS_WgwhW_NDO91LoTeSzdieGqbwqnwPq8KpavH1_Lwi7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhS_WgwhW_NDO91LoTeSzdieGqbwqnwPq8KpavH1_Lwi7g@mail.gmail.com>
X-Rspamd-Queue-Id: 4BF41486937
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,huawei.com,earth.li,vger.kernel.org,lists.infradead.org,lists.linux.dev,namei.org,hallyn.com,gmail.com,oracle.com,kernel.org,ziepe.ca,arm.com,meta.com,google.com];
	TAGGED_FROM(0.00)[bounces-9353-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[arm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arm.com:dkim,e129823.arm.com:mid]

Hi Paul,

> On Fri, Apr 24, 2026 at 6:49 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > On Fri, 2026-04-24 at 18:10 -0400, Paul Moore wrote:
> > > (I'm assuming you meant initcall and not syscall above, but if you're
> > > talking about something else, please let me know.)
> > >
> > > Saying that you aren't comfortable moving IMA initialization to
> > > late-sync is inconsistent with allowing IMA initialization to be
> > > deferred to late-sync.  Either it is okay to initialize IMA in
> > > late-sync or it isn't.  You must pick one.
> >
> > Yes, we're discussing late_initcall and late_initcall_sync.
> >
> > I prefer to look at it as being pragmatic. I'd rather err on the side of caution
> > and not move the syscall to late_initcall_sync, than move it.
>
> If you were truly erring on the side of caution you wouldn't allow
> late-sync initialization without knowing if it was safe or not.
> Determine whether IMA initialization is safe at late-sync.  If it is
> safe, move the init to late-sync; if not, keep it at late and figure
> out another mechanism to sync with the TPM availability.  If needed,
> you could probably use the LSM notifier to enable the TPM driver to
> signal when it is up and running.

I don't think LSM notifier wouldn't be good since it a one time
notification for initailisation and it wouldn't tell properly
whehter TPM isn't present in system or present unless functions
ima_init() are rewritten to discern the "TPM deferred" and
"TPM doesn't exist" in the system (e.x) boot-aggregate log creation.

One question, though.
In the end, for systems where the TPM has already been probed by late_initcall(),
init_ima() continues to be called at late_initcall(), while the above approach
is introduced for systems where the TPM is not properly initialized by that point.

If init_ima(), which used to be called at late_initcall(),
were instead called at late_initcall_sync(), could this break system integration?
In my view, both late_initcall and late_initcall_sync run during the do_basic_setup() phase,
so it doesn’t seem like this would cause tampering or affect things like the creation of the boot-aggregate log.

Is there any particular reason why init_ima() must be called specifically at late_initcall()?

Thanks.

--
Sincerely,
Yeoreum Yun

