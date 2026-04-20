Return-Path: <linux-integrity+bounces-9252-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PU3DDVG5mk+uAEAu9opvQ
	(envelope-from <linux-integrity+bounces-9252-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Apr 2026 17:28:53 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A595A42E360
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Apr 2026 17:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47ACE3791F72
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Apr 2026 15:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16843C942C;
	Mon, 20 Apr 2026 14:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JiGwj+Wb"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2A13C7E1B
	for <linux-integrity@vger.kernel.org>; Mon, 20 Apr 2026 14:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776694843; cv=none; b=eG5Dz7ik0BqhlgwDsdGSPnURhvG6dPAxK5Gy0rnc/Gzf55YqJpaiHEE1M0l70n/SAcGflIHCEGnop2XSCyMPB08ksihP/mQTI4ZbHcSDFb9Ri2Q9PcZe18ru4VV/ucOPuly7sxh4mgHkySGRCvpmRthxF6h+J5bStXzqow/V9gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776694843; c=relaxed/simple;
	bh=2KVxJI9ejeEZMIbIF08+ol9mi4y5S3ApoE9rL6Bsf/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8i06LXy4LaE77zJS+nkukr7CsoD5lVon5Srgk/7dmB5CnfuhXe60abFN8wA2h5f/A79OLyjGzwo+tWLoUgh/fLgp8kACBOCuKdEFZOjaBQxp55dz4dvk3/5Kp2Uo8ePwe3asQPDYnXyfNig6dLuz8gFFI4HGV+BFiDTlgmnjYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JiGwj+Wb; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4891ca4ce02so96295e9.1
        for <linux-integrity@vger.kernel.org>; Mon, 20 Apr 2026 07:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776694840; x=1777299640; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9ReL9mAV/3BRJ2Kkh/ldlZKgZcqKVBFpRWFlO3tSbuI=;
        b=JiGwj+Wbv9KnT3gRkEmweNEBnkubyyFIMerjCd+FGTG4AzpYCCsaEU/xN7O5bZRRaV
         3vtmu34laWP2K4CGm2ygW0hbACmBMkxB18bYDvS4jtoVayGB3Mql7Ye2RiY9tHW9P8Fl
         OKUp+rwLTXd6e/UnVj6IclbML22doBTSsXiDgtchEGjE7RP2dNUeaQ1QxehBI7Wb83qf
         r7TQ2UhIqR4OxH+qmBGc39RElCvRlSu+3505capXf/v6r1z1p9FUoKX0ozVaaWdiqC1n
         PM3CLfKq0qH5mhm+SXYFDGi3khMsSfsOdkJjFxopAuHpM5TVpAkoiiSMu75bGoLHN7Wr
         gGvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776694840; x=1777299640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ReL9mAV/3BRJ2Kkh/ldlZKgZcqKVBFpRWFlO3tSbuI=;
        b=UcRKfMww/dvQ1CWXNNZ0455yB5zKLfRF8wbX5pHMU3OZn5pZXFqNZXLQaEXkxY6nZ9
         OWi646daniYdJioZL2yRQD7ZAeEnFCKRij/TnOnEP7H0VLiiSKIk0ryujRWpr5hOUBTc
         RqEoDkxUBiRGgldjLZWNdYSzXkQ6RWUJV58SN8gm4yhyD2L3Y8uVcgwKILNPVmri6Oxk
         n0TNJZSWVT9BLhRXm8mfFrM+6RJT2sLHr0038oJjy+232y95VQF+CR2J4CU88bBanm9w
         a20G4JeUhZ0S21js3cFUO5RnyVqmTA4YQT72iGyGUEKpndl9mXCOGHFG6whlTiW8HPZg
         474w==
X-Forwarded-Encrypted: i=1; AFNElJ94j+WB/5gM4Huo/MFJL1s/2tYQttPrrgDBXQHj0HMQ6yNTMzuHVcjVCPznglO6eo5XYhgrsfy2pnU2WhePwb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUPBYsZ1ptGghf5JjKIorOhbGzBrDpgPJWi9gcd8LoNJXlnL4f
	AIJ8aFI06jHuxdND/4aef6YK5HV5xNVqUy3j2PAnCEgWa0SHGlqCqn0eWxc11YWH1Q==
X-Gm-Gg: AeBDietvW8swN8XhDVIHMmMZeIv8TjOdMnZBkIC1PNRh51JpO9U97rgfeiR3FQyKDPM
	H8QM5lOr4zuW6PUZbtQ4zZOPf8rZH6qTRkeZK+f04ad+tiBM3ltZmbqd3qMyR8PkUtWOrzBdK4E
	B1bmgEzq/R7Letp2KMrCfJiUhExnIJ0zfWjMSQ1aJFpS2++3gOGxkcLCLwnmlRoQS/CCZtJyAbW
	7CMxe8H6SnL/0T/quieES7meA3pYYhIRnSIzxQg64mtLKS3ttEY5zvISM6ACHpzfB+defx2IaLm
	0X5H3d0j9D5mfltwn3cAoYNV15SlWzK3eWzp5vef6l6hHQpLWaO+seOlyuK9XFf2pZqvmEmTT/b
	sxov8U1CrDOMtUe6bplNnWUcXyBeRKykP3GhXZqH/i8nblTJ7UoTHo9wFTggSerIY/jZyKC0/K1
	ESAMVNOwqEnIgz/78WlLswSORXHmOqwS+4xhEfEtQjm5/m+M+cQg8qbiUVvP9MiQhq8U2iQ3vpj
	RsI8kBt6ojavLMSvdE=
X-Received: by 2002:a05:600d:848c:20b0:485:4133:4021 with SMTP id 5b1f17b1804b1-489013bd634mr1619625e9.7.1776694839891;
        Mon, 20 Apr 2026 07:20:39 -0700 (PDT)
Received: from google.com (117.15.199.104.bc.googleusercontent.com. [104.199.15.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891c318636sm86355285e9.7.2026.04.20.07.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 07:20:39 -0700 (PDT)
Date: Mon, 20 Apr 2026 14:20:35 +0000
From: Sebastian Ene <sebastianene@google.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
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
Message-ID: <aeY2M3v97c00JjFe@google.com>
References: <20260417175759.3191279-1-yeoreum.yun@arm.com>
 <20260417175759.3191279-5-yeoreum.yun@arm.com>
 <aeYbdmshGZJ4GhXd@google.com>
 <86mryx2408.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86mryx2408.wl-maz@kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[arm.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,huawei.com,gmail.com,oracle.com,gmx.de,kernel.org,ziepe.ca];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TAGGED_FROM(0.00)[bounces-9252-lists,linux-integrity=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: A595A42E360
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 01:46:47PM +0100, Marc Zyngier wrote:
> On Mon, 20 Apr 2026 13:32:32 +0100,
> Sebastian Ene <sebastianene@google.com> wrote:
> > 
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
> But relying on this sort of ordering is just making things more
> fragile.
> 

Thanks for letting me know. Since this is not a solid construct we will have
to change the driver init code to come after pKVM in this case.

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
> 
> You do. Without the finalisation, SMCs are not trapped by EL2.
> 
> And even if it did, relying on such hack is just wrong.
> 

That makes it an even stronger argument to move the driver init at a
later stage. I was relying on this to trap early ff-a when the
ARM FF-A driver was used.

> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.

Thanks,
Sebastian

