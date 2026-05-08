Return-Path: <linux-integrity+bounces-9486-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJeZGPbp/WkPkgAAu9opvQ
	(envelope-from <linux-integrity+bounces-9486-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 08 May 2026 15:49:42 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 034AA4F755B
	for <lists+linux-integrity@lfdr.de>; Fri, 08 May 2026 15:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 395323076B94
	for <lists+linux-integrity@lfdr.de>; Fri,  8 May 2026 13:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01773E3177;
	Fri,  8 May 2026 13:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="YtuBmpKr"
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738543E1D0B;
	Fri,  8 May 2026 13:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778247710; cv=none; b=nq8L6E0Th05PGCyX23ny2meZKGwW1WkUx4ULSstT9YnhT9ycKXjkg/0J8a8tulZQK5f+QORNdnvFxOLhdimj9kJyl6XpFbssPXERq01Iu5YUP6W4Y9Rj0pnFFc9jCP3gg85terKfafLyYB9QWS4Wvzaw/9lJ4izITvKMOaGRJQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778247710; c=relaxed/simple;
	bh=QmNsu1x3udImOIG51/QbUgV1i4PuYkqOa/OqRyu9jYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ll09TmYA8pAswK5/BiujgQCB/cE3duyGr0HKjsTDU0BbC5UvpKAQXZkfYe7nFPHX/Tn9QGosIFmXRaApAFJC0KkaXHewjUgL3TTrWpF3IupxaY4+VJGrdWIpvJ9o/qlAFTJ2d0RGPMuLu4MAJF5OO1g5IlmFS7yusID/DPMOuDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=YtuBmpKr; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 268E326BC;
	Fri,  8 May 2026 06:41:42 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC9193F836;
	Fri,  8 May 2026 06:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778247707; bh=QmNsu1x3udImOIG51/QbUgV1i4PuYkqOa/OqRyu9jYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YtuBmpKr0TZuvK4M6mGLVWsPHJyGPvari/WZL9N7a5iN6M6C+22Wv5070OxoiTENO
	 rqLOSz8K4YTk/Lw8UQnNbvLfijqmt6BezYbkduh1KFqGpIRr0BvfM5GB4Zbef6OXiP
	 DBig3E/RZyG5BLnpb9HHb9UZJ7vvP/6jpGmNMLTs=
Date: Fri, 8 May 2026 14:41:41 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: David Safford <david.safford@gmail.com>,
	Jonathan McDowell <noodles@earth.li>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com, jarkko@kernel.org, jgg@ziepe.ca,
	sudeep.holla@kernel.org, maz@kernel.org, oupton@kernel.org,
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org, noodles@meta.com,
	sebastianene@google.com
Subject: Re: [PATCH] ima: debugging late_initcall_sync measurements
Message-ID: <af3oFfdSMUglZVHa@e129823.arm.com>
References: <9ff4853a8e9932b3a1424f2a6c3347f1723fb5f4.camel@linux.ibm.com>
 <aftIuPwNeuzc9nY1@e129823.arm.com>
 <9d1af933ef218b159762884357d127e3644dfe2c.camel@linux.ibm.com>
 <afwoDgaJxmKwOhXp@e129823.arm.com>
 <f19081f1eda19d6d1ae133d8ec93e779ab1a25e5.camel@linux.ibm.com>
 <afyIbW5cljh5ZvTL@e129823.arm.com>
 <afzwJn+5r15jFxrB@e129823.arm.com>
 <77ad49cca1acf707f4152ed3e2066b2f24c90c16.camel@linux.ibm.com>
 <af2nhZyyNaP7LM3w@e129823.arm.com>
 <2b3782398cc17ce9d355490a0c42ebce9120a9ae.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b3782398cc17ce9d355490a0c42ebce9120a9ae.camel@linux.ibm.com>
X-Rspamd-Queue-Id: 034AA4F755B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,earth.li,vger.kernel.org,lists.infradead.org,lists.linux.dev,paul-moore.com,namei.org,hallyn.com,huawei.com,oracle.com,kernel.org,ziepe.ca,arm.com,meta.com,google.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+];
	TAGGED_FROM(0.00)[bounces-9486-lists,linux-integrity=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[26];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yeoreum.yun@arm.com,linux-integrity@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

> On Fri, 2026-05-08 at 10:06 +0100, Yeoreum Yun wrote:
> 
> > > The kernel selftests caused the measurements between late_initcall and
> > > late_initcall_sync.  After disabling all of the kernel selftests, there weren't
> > > any measurements. Re-enabling the FIPS selftests on PowerVM LPAR resulted in
> > > measurements.  (I didn't try re-enabling any of the other selftests.)
> > > 
> > > CONFIG_FIPS_SIGNATURE_SELFTEST=y
> > > CONFIG_FIPS_SIGNATURE_SELFTEST_RSA=y
> > > CONFIG_FIPS_SIGNATURE_SELFTEST_ECDSA=y
> > 
> > Thanks for shraring this ;)
> > 
> > I found the reason for those mesaurements. Those come from the
> > request_module() and usermode-thread generates them while handling module
> > loading request for crypto-x962(ecdsa-nist-p256).
> > Since it's not a real kernel module,
> > I confirmed file measurements between late_initcall and
> > late_initcall_sync are gone for modeprobe with below change:
> > 
> > @@ -1246,9 +1250,14 @@ EXPORT_SYMBOL_GPL(ima_measure_critical_data);
> >   */
> >  static int ima_kernel_module_request(char *kmod_name)
> >  {
> >         if (strncmp(kmod_name, "crypto-pkcs1(rsa,", 17) == 0)
> >                 return -EINVAL;
> > 
> > +       if (IS_BUILTIN(CONFIG_CRYPTO_ECDSA) &&
> > +           (strncmp(kmod_name, "crypto-x962(ecdsa", 17) == 0))
> > +               return -EINVAL;
> > +
> >         return 0;
> >  }
> > 
> >  Though this is the only request_module() call between
> >  late_initcall and late_initcall_sync, but I also confirmed there're
> >  request_modules() call before ima initalisation before "late_initcall":
> > 
> > /*
> >  * NOTE: kmod_name is printed on ima_kernel_module_request()
> >  */
> > 
> > // This is called from module_init(stm_core_init) -> device_initcall()
> > // which is in driver/hwtracing/stm/core.c (built-in)
> > [    1.421986] ima: kmod_name: stm_p_basic
> > ...
> > [    1.444900] ima: kmod_name: crypto-pkcs1(rsa,sha512)
> > [    1.444903] ima: kmod_name: crypto-pkcs1(rsa,sha512)-all
> > ...
> > [    1.452029] ima: kmod_name: crypto-cbc(aes)
> > [    1.465321] ima: kmod_name: crypto-cbc(aes)-all
> > ...
> > [    1.467845] Key type encrypted registered
> > [    1.467848] AppArmor: AppArmor sha256 policy hashing enabled
> > 
> >  // IMA is initailised at late_initcall level.
> > [    1.467850] ima: [init_ima_late:1336]
> > 
> > If IMA should care request_module() from kernel before IMA init,
> > I think there is no way to solve except queuing those events
> > (kernel_load_data/kernel_load_post_data and open for module binary etc.)
> > though it breaks "measure before use" principle since IMA couldn't
> > measure at that time.
> > 
> > But if you don't care about those things -- some events happend before
> > IMA init, I think your suggestion -- controlling the init time of ima_init()
> > via a Kconfig option is good and ignoring some usermodehelper request
> > including request_module() before IMA initialisation upto user by that option.
> 
> Thank you for the complete analysis.  The early measurements before the TPM is
> initialized is a problem that needs to be addressed.  As to whether the solution
> will require queueing is yet to be determined. (Roberto has some thoughts on
> addressing it.) This discussion makes it clear that simply delaying IMA
> initialization by moving it from late_initcall to late_initcall_sync could miss
> measurements.  That said, exposing it as an opt-in Kconfig for those who accept
> the risk is a sensible pragmatic compromise.

I think once we address ealry measurements before intialising TPM,
It doesn't matter when IMA is initialissed since they're considered as
ealry measurements anyway.

BTW, I'm not sure whether we should take pragmatic compromise first to
support deferred TPM initialisation or solving it together via solution
of ealry measurements (whatever it is) in now.

-- 
Sincerely,
Yeoreum Yun

