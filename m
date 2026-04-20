Return-Path: <linux-integrity+bounces-9251-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LuIMy5F5ml/twEAu9opvQ
	(envelope-from <linux-integrity+bounces-9251-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Apr 2026 17:24:30 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0329242E220
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Apr 2026 17:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AC21F317F22E
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Apr 2026 14:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE95367F2A;
	Mon, 20 Apr 2026 14:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jpRPRMjH"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EEF366DD3
	for <linux-integrity@vger.kernel.org>; Mon, 20 Apr 2026 14:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776693932; cv=none; b=JCqcpfb08PipZbnoWN6ZvtAJ1V9WLqarVomaBToz3lUp9UCEPojsJA/vUyIe+M3mxzrn3p4npQHtyF5pIE6itPmp/EymJ0vAI0BdmfhX2I9Ocub322UPcnpTpHUazoFkPdCmdekcnvT3dx1JexpmVY+6ekW5emUB7D6awvBPcD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776693932; c=relaxed/simple;
	bh=S2UHySE5XaH78WLFRWMsAh1zPx/419Y8+b7A7jvMIso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XpDEXWZd9ZCM3D5FvG3Vexf2G8HXd2ijMiLQqWMR56CBkoDBpYUZx1Z/0SejoN05/LrawIon9GEBzwSPo2BGSrJ4LCgz5r4tv6SWuYgaWM89s/KPnHplC4NJstIj48KuWQkkhO4pmT8ylbZGJoK9eBAtR6juXQLXfIjV7qBnyQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jpRPRMjH; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4891ca4ce02so94595e9.1
        for <linux-integrity@vger.kernel.org>; Mon, 20 Apr 2026 07:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776693929; x=1777298729; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G6q3FLtE0M6J2F/PfEuR3infOq1/jMGGhvYKqZy6+Xo=;
        b=jpRPRMjHZUWtLs22Mst1yPkC+bUQjpabQhJWVCAuxIuKc0dk1lIsRTjB+x5hYAhuJg
         enh9Nuiz4wTXeTAWGFbx3Kqecg8J5jTRiwEsBUGY6pybFi5fmtwfiUeTwZeKIu16LmPw
         01DjWMRq/q3wgxB+FPUrlX8A2Chz3PsDWfc7p6ioNrbjOvLYgZTyOatQTJg7R6Nf0NfJ
         g+fyDY223BvMsw7QsPTXcm/ugGHun2dYqJXikP+AKMr4722Occ3u0Kw46njjpA6wpJzD
         2rSMzz3ag89VvwixjwxCKTObuCEQ4fq/hyT7JscRmclbYgQOSG4m1eo0vYz4j5N8bve9
         edrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776693929; x=1777298729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G6q3FLtE0M6J2F/PfEuR3infOq1/jMGGhvYKqZy6+Xo=;
        b=nRslqvrZQIiG3rM9wscGpuIkviGeGAcVSyaD3gRlb7hJKIM1lR06rU3Ton4amS6oRz
         tH0D539vaaXeXgjABquNYBSpb65RYsmEp+L9DXVEX73g3tdO2ZBDAet8yt9sFYKIo4Rp
         MptsUk/HhVlniiL08Ej6uP0DGZv28+F0vTFQaU5zJNsGrWIafJ7fxGUtVqf1lFz9l/4P
         HjAyQDLXnv2SpSbeDPF5g3ngVuMb2+93wkCJFXBby/cnVOKaxB4SiseS36FBjtQTyArD
         JkjYF0r9n4YNZ2US8fWmR2PsnpCCcAnf59oASCRFaEaUkhpeI6AdnNbfcxmyvBDyBKAY
         4Egg==
X-Forwarded-Encrypted: i=1; AFNElJ9niNphSwC0/zY8Ebz29XwAvlIK5625eTJQjVeuYYGkKeLtT9+i9H1mwx8zyOAFr+FAS9fII2k84lhkNkTOLr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrbcHotfLbie8Z1OIlnXPDdlJFdXVQWib7qTQ5jI/wFXh906KL
	EhjCXKGyFbgnJblUW3QCGdPQxcPfYJjV0/B3ZhXgOHuIhRaIaYt+rYaSm9xohj7hbw==
X-Gm-Gg: AeBDieu1WfCnF6vgbpv82C83VXHtgdIt5Al7xaXSEoqFgAv2XlHpOhxM3dUGN6H6GqY
	jQh3MnsjeNAhzg98CD4htcnpOPF/8v6nR5GbhH4ZGUZgRMfl8LpcvwFS+A4/NLA7d8N6qm07J5D
	xwlWBib2y4eCMaQ1qnpBCeb0HW9XY1k58/o17yV1zo+h4392po87WmRKwJ1BVWz5Qe1kwee6jZ4
	30df2NAUCiYJXWWYRq06EPl/IN8RDSBnOomwtSRxGnyUc0I/5vcYcVPrsgko9giOqV2p/s9xebE
	ka6xjJf5t2DNclByZmrYP/ccYSQnwp/Dmdz2OQAaBErLtElsKaLKwrDp+Q1QRQnQU9lJsOAdsF1
	YJUk+IjTq8/Y+08qlEbRyNNoDQpfQ5yiGupgRuhTaHzXQm9gHAXwQ60DlGtrP6zlPz4y00KG3Vs
	mVzgAHE/5KVB/m/wTadWixit7m4sUEAz2ux0AETasPg2lVbRlrpAa42Oym3T/tym5kl93d1lvTA
	q3w4sj5DXcE5/NEdO8=
X-Received: by 2002:a05:600c:55cc:b0:475:d905:9f12 with SMTP id 5b1f17b1804b1-4890095cc81mr2067335e9.4.1776693929074;
        Mon, 20 Apr 2026 07:05:29 -0700 (PDT)
Received: from google.com (117.15.199.104.bc.googleusercontent.com. [104.199.15.117])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e3a341sm32798494f8f.24.2026.04.20.07.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 07:05:28 -0700 (PDT)
Date: Mon, 20 Apr 2026 14:05:24 +0000
From: Sebastian Ene <sebastianene@google.com>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	zohar@linux.ibm.com, roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
	peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
	sudeep.holla@kernel.org, maz@kernel.org, oupton@kernel.org,
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org
Subject: Re: [RFC PATCH 4/4] firmware: arm_ffa: check pkvm initailised when
 initailise ffa driver
Message-ID: <aeYypF4lv6LMH2ch@google.com>
References: <20260417175759.3191279-1-yeoreum.yun@arm.com>
 <20260417175759.3191279-5-yeoreum.yun@arm.com>
 <aeYbdmshGZJ4GhXd@google.com>
 <aeYjiaPtAl7SMVkL@e129823.arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeYjiaPtAl7SMVkL@e129823.arm.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,huawei.com,gmail.com,oracle.com,gmx.de,kernel.org,ziepe.ca,arm.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TAGGED_FROM(0.00)[bounces-9251-lists,linux-integrity=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebastianene@google.com,linux-integrity@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 0329242E220
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 02:00:57PM +0100, Yeoreum Yun wrote:

Hi,

> 
> Hi Sebastian,
> > On Fri, Apr 17, 2026 at 06:57:59PM +0100, Yeoreum Yun wrote:
> >
> > Hello Yeoreum,
> >
> >
> > > When pKVM is enabled, the FF-A driver must be initialized after pKVM.
> > > Otherwise, pKVM cannot negotiate the FF-A version or
> > > obtain RX/TX buffer information, leading to failures in FF-A calls.
> >
> > At the moment this already happens after you move back ffa_init() to
> > device_initcall().
> 
> How? the kvm_arm_init() is device_initcall() if both built as built-in.
> 
> >
> > >
> > > During FF-A driver initialization, check whether pKVM has been initialized.
> > > If not, defer probing of the FF-A driver.
> > >
> >
> > I don't think you need to add this dependency. pKVM is
> > installed through KVM's module_init() which ends up calling hyp_ffa_init() to
> > do the proxy initialization. The ARM-FFA driver comes after it (since
> > pKVM is arch specific code). We don't have to call finalize_pkvm(..) to
> > be able to handle smc(FF-A) calls in the hyp-proxy.
> >
> 
> As Marc said, the before finalised_pkvm(), smc wouldn't be trapped
> to pKVM. IOW, in case when both built as built-in,

They are, I tested before replying to this thread. The HCR_EL2 is
0x480080000 so HCR_EL2 TSC bit is set so SMC/FF-A and trapping is enabled.

In __pkvm_prot_finalize it sets the HCR_VM bit which enables stage-2 and
then write the HCR_EL2 from params->hcr_el2. However I wasn't sure that
this is seen as a 'hack' and not expected to work.

> if ffa_init() is called before finalised_pkvm(),
> it couldn't proxy the FFA_VERSION, FFA_RXTX_MAP and FFA_PARTITION_INFO_GET
> called by ffa_init().
> 
> How can you gurantee hyp_ffa_init() which is called by kvm_arm_init()
> comes first even kvm_arm_init() and ffa_init() are on device_initcall?
> 

While they are both on device_initcall, the only difference is that
kvm_arm_init is arch code which appears before the driver/ code in the
linker. That's why Marc said it is not a solid construct to rely on
this. 


Thanks,
Sebastian 

> [...]
> 
> Thanks
> 
> 
> --
> Sincerely,
> Yeoreum Yun

