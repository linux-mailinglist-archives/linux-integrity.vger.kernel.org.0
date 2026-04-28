Return-Path: <linux-integrity+bounces-9351-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GI0OCxkO8GnTNgEAu9opvQ
	(envelope-from <linux-integrity+bounces-9351-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Apr 2026 03:32:09 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 966BE47C650
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Apr 2026 03:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 32E3E301E7D4
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Apr 2026 01:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0715923D2B1;
	Tue, 28 Apr 2026 01:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GR/9PU2h"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DDA1A6817
	for <linux-integrity@vger.kernel.org>; Tue, 28 Apr 2026 01:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777339925; cv=pass; b=TRv2bwAk6XSOu9D9YGhZbb1J5TjgAu4sZ/MHyR+SyBzBgcpsCmX+HhfzCdK7J5ITHIhL8RHIc9ACEw8rNUtjFJWYcCJcxxSwSgwR0NZMCM4bv9ux/He6gEUoKhq8Ng3nixp84bLPx8+TAfCH1wB6eRtgljqaWbJ6eImcO5vmdgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777339925; c=relaxed/simple;
	bh=Lp0NVo10PoigQtDjm/3ukLN/BhlWLdcFx2DFRGXFAn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cWhfo2oZRZ3Sa+L4j8lsobUjnQZ+vS8WehZsK+91CDZP0fah9ugmS+6+Y7eXC1YZrd6ec18NV6lXH6udLQpvanIi93zln8gQmfTge6eoNn5P2xjD5osRa8M9J4qiOR8OaX1fX/wYaQ6qMahAEHB4Jzgwgqqr+oJL900IQ7ymQ5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GR/9PU2h; arc=pass smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-35dac556bb2so6312940a91.1
        for <linux-integrity@vger.kernel.org>; Mon, 27 Apr 2026 18:32:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777339924; cv=none;
        d=google.com; s=arc-20240605;
        b=NC+N74QEjwVi7mI1WZwwFcJbolrEwFxQ1tZVVgUekB7W9I1KEUGgRplL0pxewMUxkb
         QjVjpNUxCPK1/EGF9Nzre77384TNwIx2mjCdZ9+0RSpF0RCTRPQodK2ae0AG1Qk9g4/Y
         TeloCC7ocw6kBoc8ztenPdBwAsFi8U8ZoKzhdAIEW3xizkpp5famtHAoJHMCIRyTmRMV
         pPwi8mFq5qVxOBz4IOGPllgpzwTnvTFtGRjn3ewcsA8jRr31oV0NMLIJ6RpAlNxwqBGD
         MatQBe9YKcKProqDsRE4bGd1JrDr1OEz8u4McMi7HJJ5IuQCCVsG9HqH2+GS7INjsu+e
         bolQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dkNNLielDoU+waGJTxz6K7Cs44v4hc05yCRBP0rYkY4=;
        fh=LoRXSKakYU3DLxKrTbqxja2NaHEzVNopGTdCJiTBN2w=;
        b=j3f6dMHTa788YTkRHVhnFzc0Mr0yDAV54pWC4f5Bf0OVc9FNiPFhNhQr6p5MYipBVU
         sXpx9D990EocghhGyK4MMqIq/bhtVr5lGwcQ5/sRCPMSrWQBRfkCgROoRkhbXNUAIwsy
         Z8U/fYWIEMoNSDmlz8j6JSfHaaOOF3M04b1hS0eR4yCcFmRP0SAHOPztN90K1JawV0kN
         tHkl4njyjou/38HNrOnN5T+KMV4lZnTsiqMfe77FDdsqf/CrTpl8C95IXa7jpAw8ZNd+
         Y/rHZZbfqgpv1T/qFUJop0Isf32LylY8YKrSGEACDKYZw33XieXUD3HEt+alqlT4Lvep
         fQ9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777339924; x=1777944724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dkNNLielDoU+waGJTxz6K7Cs44v4hc05yCRBP0rYkY4=;
        b=GR/9PU2hhLx7g3YzIBrG4dXdPJ9kH1+PdVHWPcybSq41wCBOSQgKX+B6TC7siDjUs8
         8yep/jjPuYI1kjVeOIHFVuPlHkYJ4hEStOL90y/NmkWNcYMpxg4G8yInBnSxRIC6HaGj
         s8/H+9s72GWv7uctwp9XITxII7teYKxg16TVi8k0Oa7UznZn98mRSEGPn44pI1mCqhvW
         TYCe58xMm/2WjorpSqF1ecvRxzA+hQ1ezff1fl6plFq1aMYHiQX8laF5TBF6FVtg56Wt
         vKjoj77yLGZ0XLiHOjOX/7Uh47jotdGgKn4omjXWXDg23cmmr54TyzXKI7PF5govEX4+
         tCXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777339924; x=1777944724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dkNNLielDoU+waGJTxz6K7Cs44v4hc05yCRBP0rYkY4=;
        b=FWG6yR2fNbzTQefHFT/3axe+xwC0EsiKDfjM+E4fzTf5AWZvlf0XldujiFoZz/fwPI
         s1r4KTOyzYYkILbHjqi5mRe0IdWdMFmEZun/vZKQaB+/OhJEnPG4CL+8sh99kKHiEasI
         EL+wmL7FrgpttJGJMx0le9V25So+IFfTiv60LHwDnymy9osXd/No5WKnaft8/R3L2cpR
         KTTBEQyuKY3u0PPnuxvu+5CCqidtN042HtylLuuVg/d6VlfapMmla7M8tjw+FXL81l6l
         Y0BMZMPkB6B+l7366a7ulFj5gwoq2ZWZprJep/DP1t/3msmd08yxtd1RTSgbT945sQGE
         tJ8A==
X-Forwarded-Encrypted: i=1; AFNElJ+eT3Inb8UT9Tw8skeLIasNbS6vMwW3LhqyL6mZH1yzeqkjtEOwS48PrZG80+3LtObv6EJzuke4EfBN+YrDxSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUbCrTh5RjLpGxDeMifeg6ifXDDPDtMy9g12ih4bVhUrZ6aeCK
	OB7qPII4OdRwr36H8hx8wJJO8uSFd7Mx5/kTR6f7XblV+eq+8EradcPqQg0WkDc5D2Wx3Chmf6y
	33skOf5wW9+J0M0+QJASYvJ2YkKsj9utFSHh1MYpi
X-Gm-Gg: AeBDievTeJgXpVrtRZi8Uc94pMHkxTAGRzkpLRQBZsHfOw6cOKsGi0lsxwe9UkxrrTT
	lH4EqS94Sf8oOF+eBTbqP19Rgx0PdOnwO6d0UbfXERJM3csljM0BDB2rGUp/Fk5XLVpJJWyE3if
	/LDMfH5E7cYa+H9e/fjPpOv0T/9SvASefhPrU0MD0UbhaZfhuR2Uyr+hgXCIY7UtRohj3YmW7Xa
	rMuXbVn5rcKs7WdwTqZsDVj0V/dUNuz5OLNB6G/wqykcslTKUfbKeABSEbwagjM7o7mpUWQCCbn
	jASo8M3XDFVXkdr6dg==
X-Received: by 2002:a17:90b:52cc:b0:35f:b714:e516 with SMTP id
 98e67ed59e1d1-3649202f6b2mr1031930a91.16.1777339924049; Mon, 27 Apr 2026
 18:32:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bd908e28298d968740d03c97bc7e441de188b7b4.camel@linux.ibm.com>
 <aeokwrC86WI7uT+K@e129823.arm.com> <aeomlp3I0eVE5mce@earth.li>
 <aeotq8nPVu4wvEx5@e129823.arm.com> <e4e242ae5533d5762a3647186a178764881bf9ff.camel@linux.ibm.com>
 <aephL3MzYoqFGaT5@e129823.arm.com> <CAHC9VhRQWHEWQ5NzOPiu8jtYv6UsRm8WVS4fd74AbkOcAd4y_g@mail.gmail.com>
 <aesGU8a3mbVzvteH@e129823.arm.com> <CAHC9VhSaT_quKYnpFjAfqvL07JNbWMgM6c4pB9F46NHawX3DCA@mail.gmail.com>
 <014cf39aa8d6a0bcfa1a95c069675977ac67b843.camel@linux.ibm.com> <aexIwJpno3iPIdRD@e129823.arm.com>
In-Reply-To: <aexIwJpno3iPIdRD@e129823.arm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 27 Apr 2026 21:31:51 -0400
X-Gm-Features: AVHnY4JvmD_vpNd2uBimzy27N58OmiHGYAhJK_BGt8LuvH5xnPjA0AMhCSfE4Tk
Message-ID: <CAHC9VhRT1v3mM9CFvz7Dh5Zrv_MF3vgBk+BZ=q8wOMkPB6O6Fw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/4] security: ima: call ima_init() again at
 late_initcall_sync for defered TPM
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, roberto.sassu@huawei.com, 
	Jonathan McDowell <noodles@earth.li>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	jmorris@namei.org, serge@hallyn.com, dmitry.kasatkin@gmail.com, 
	eric.snowberg@oracle.com, jarkko@kernel.org, jgg@ziepe.ca, 
	sudeep.holla@kernel.org, maz@kernel.org, oupton@kernel.org, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	catalin.marinas@arm.com, will@kernel.org, noodles@meta.com, 
	sebastianene@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 966BE47C650
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9351-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_CC(0.00)[linux.ibm.com,huawei.com,earth.li,vger.kernel.org,lists.infradead.org,lists.linux.dev,namei.org,hallyn.com,gmail.com,oracle.com,kernel.org,ziepe.ca,arm.com,meta.com,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,paul-moore.com:dkim,paul-moore.com:url,arm.com:email]

On Sat, Apr 25, 2026 at 12:53=E2=80=AFAM Yeoreum Yun <yeoreum.yun@arm.com> =
wrote:
> > > I understand the need to ensure that the TPM is available, but if it
> > > isn't safe to wait to initialize IMA at late_initcall_sync() then it
> > > would seem like this is a bad option and we need another mechanism to
> > > synchronize IMA with TPM devices.  If it is safe to initalize IMA in
> > > late_initcall_sync(), just do that and be done with it.
> >
> > Within the same initcall level there is no way of ordering the initiali=
zation.
> > Yeorum attempted to address the ordering issue in commit 0e0546eabcd6
> > ("firmware: arm_ffa: Change initcall level of ffa_init() to rootfs_init=
call"),
> > which is being reverted in this patch set.
> >
> > Ordering within an initcall level needs to be fixed, but for now retryi=
ng at
> > late_initcall_sync works for some, hopefully most, cases.
>
> Ordering within an initcall level is not good idea.

Agreed.  That's why we have the different initcall levels.

--=20
paul-moore.com

