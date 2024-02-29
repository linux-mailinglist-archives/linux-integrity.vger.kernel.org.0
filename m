Return-Path: <linux-integrity+bounces-1522-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A49C086CA24
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Feb 2024 14:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A45E1C226F1
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Feb 2024 13:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D5582D92;
	Thu, 29 Feb 2024 13:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="baTH7RbD"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E362823B0
	for <linux-integrity@vger.kernel.org>; Thu, 29 Feb 2024 13:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.93.223.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709212897; cv=none; b=obfoggxr3hmBw4FZaFSwCNBNaR0tZr28LEqNAPD0w2Ykan6Pmu5xe9c7mKmTqz/vbjfnJ5g1SryL9pMHjJClMYckgshgefa1R1eM39jTrFCGcmCHjWI6c1iZVQEOxiQou71pj1zyhoSm0RESauZ9bhPJQfSbYMa4tg1B5x5WtJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709212897; c=relaxed/simple;
	bh=rmMyaobrFjgfgoY+1DxVzn7wFSusUgF6D3vMM4t80/E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LQ0fv2SXPlV/WA9YwAP8ADtwtXhpujrQUJzZoKObrx6usBF3guLIGUxJir+pDVx9VjNLD1orSsBl7bU6KAao04Y45xc4peKgeJgtPzFeJBb05KfGAXaSMxr6Hr5jJT9tsQ0MH9j2wpoXL8TVKLc+ou5l8eUs9ilPUIpjdkX97wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=baTH7RbD; arc=none smtp.client-ip=77.93.223.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (unknown [213.235.133.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id BB8D61BE01B;
	Thu, 29 Feb 2024 14:21:20 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1709212883; bh=W9Ca6WxMe0ePjruOa7Varz1kJvqdyOtBeHSeSBDdvbc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=baTH7RbDrd+4pxVinm5/lbkVaJq4HpMzmQVQ1p9APQxqOZ+z+7uv8abHk6UjrQRax
	 8/mmdTKMYaXuLXj7T5Vwojf0bSAuIzcHKnLEPoCdLQr/3ulJQjzhCu8zFYwYoN7un0
	 NbeiHC2/dToUjGC4szPaWISBhrxRgljOHizVcRfIxELrbSdvgDUYLHIwV86Rc3em9j
	 n7kB8l+il5gGqc7+eZVarDVi/J11G+CoPV1M8JXa8hUSWXhuZL56z1aNvYSGKnp+hg
	 iuz69GOGI1YnM+Q3wm/b40Gc1YZ6e7YCzEymQgbhfkOnkhKwcUxU9yAVitntpiuvOR
	 zhF/xj5WWPe3Q==
Date: Thu, 29 Feb 2024 14:21:16 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Tushar Sugandhi <tusharsu@linux.microsoft.com>,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, stefanb@linux.ibm.com, ebiederm@xmission.com,
 noodles@fb.com, bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org, code@tyhicks.com, nramas@linux.microsoft.com,
 paul@paul-moore.com
Subject: Re: [PATCH v5 6/8] ima: suspend measurements during buffer copy at
 kexec execute
Message-ID: <20240229142116.5f16061b@meshulam.tesarici.cz>
In-Reply-To: <20b13e7bab048b3afb94a8878299aa7d61016364.camel@linux.ibm.com>
References: <20240214153827.1087657-1-tusharsu@linux.microsoft.com>
	<20240214153827.1087657-7-tusharsu@linux.microsoft.com>
	<cba09611c2e069be49faca2f137d99c772635831.camel@linux.ibm.com>
	<20b13e7bab048b3afb94a8878299aa7d61016364.camel@linux.ibm.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Feb 2024 11:38:23 -0500
Mimi Zohar <zohar@linux.ibm.com> wrote:

> > > @@ -176,6 +195,19 @@ int ima_add_template_entry(struct ima_template_entry
> > > *entry, int violation,
> > >  		}
> > >  	}
> > >  
> > > +	/*
> > > +	 * suspend_ima_measurements will be set if the system is
> > > +	 * undergoing kexec soft boot to a new kernel.
> > > +	 * suspending measurements in this short window ensures the
> > > +	 * consistency of the IMA measurement list during copying
> > > +	 * of the kexec buffer.
> > > +	 */  
> > 
> > Either remove the 2nd sentence "suspending measurements in this short window
> > ..." or explain what is meant by "short window".
> > 
> >   
> > > +	if (atomic_read(&suspend_ima_measurements)) {
> > > +		audit_cause = "measurements_suspended";
> > > +		audit_info = 0;
> > > +		goto out;  
> 
> After the suggested changes, understanding how many measurements are not being
> added to the measurement list and not being extended into the TPM would be
> really interesting.

First, I'm sorry for chiming in when v5 is already around, but I have
just found this patch series now.

It indeed sounds conceptually wrong to suspend and resume measurements.
At some point during the handover, other CPUs are taken offline (look
for migrate_to_reboot_cpu() in kernel/kexec_core.c) and even the reboot
CPU will be sufficiently shut down as not to be able to add any more
measurements.

IMO it would make more sense to copy the measurement list at this late
stage, even if it means adding a new notifier list (or a new action).

It may be a bit challenging if you want to make 100% sure that a new
measurement cannot be made from hard interrupt context, but is that even
a supported scenario?

Just my two (euro)cents,
Petr T

