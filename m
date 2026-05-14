Return-Path: <linux-integrity+bounces-9530-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIbXHU3DBWpMbAIAu9opvQ
	(envelope-from <linux-integrity+bounces-9530-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 14 May 2026 14:42:53 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D577541CF3
	for <lists+linux-integrity@lfdr.de>; Thu, 14 May 2026 14:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 03D96301063A
	for <lists+linux-integrity@lfdr.de>; Thu, 14 May 2026 12:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E963C13EF;
	Thu, 14 May 2026 12:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="YLD8FxWG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7FB3B9D98;
	Thu, 14 May 2026 12:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778762571; cv=none; b=ifgNyYMPUAOGuqvdOCk0we4KaqXAG6RRvh52jTe5pMzL7sDXljGBZuIjn0wJas4vKqOkp1gjXivV1j52pTyrAzijdOtzNiZSNQLvCFBFPloi5ucfSJ0Pn/s9W6exhqU5viIZ39mL3HdcbT+NS28gN5FoUkECtMlcZQrSNf+Wd2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778762571; c=relaxed/simple;
	bh=CSZGuhEMgcVv+yjLSc1VRGD3BlRDfXMIcohRaOGnXhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d6V/+anddmB21EX8HgH8WscNssjFu06XcOcnjrF2mHoX68qMyiOolXh0tH4hlq00vVDJ37z5B4/uVb2zWgFXQT85MViaOzWguKNYzPuAIpCa0xM0tlcAYL9jHgxoJ0M9ITPgHt+NjmJbP4gqOOczHjkKImGFMjCVRBcVUSec20M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=YLD8FxWG; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78EB8244B;
	Thu, 14 May 2026 05:42:42 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A1A283F7B4;
	Thu, 14 May 2026 05:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778762567; bh=CSZGuhEMgcVv+yjLSc1VRGD3BlRDfXMIcohRaOGnXhU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YLD8FxWG6lmZaF+56qA4ExHRj6gmec4W4Jy6zLkG6oqEGkL02iZdRMKmMRRZjCR0U
	 xVNyfG7Hlzpevqw0I2XS7WY265pckgOkpMzxKPGXjvD5U9THwi517swXo7gmN3Lc01
	 lO/Kf4a3JDrJykgmj9Ar3XiURm1HGddmuTvrsPkk=
Date: Thu, 14 May 2026 13:42:42 +0100
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
Message-ID: <agXDQhREKIpN7mKX@e129823.arm.com>
References: <aftIuPwNeuzc9nY1@e129823.arm.com>
 <9d1af933ef218b159762884357d127e3644dfe2c.camel@linux.ibm.com>
 <afwoDgaJxmKwOhXp@e129823.arm.com>
 <f19081f1eda19d6d1ae133d8ec93e779ab1a25e5.camel@linux.ibm.com>
 <afyIbW5cljh5ZvTL@e129823.arm.com>
 <afzwJn+5r15jFxrB@e129823.arm.com>
 <77ad49cca1acf707f4152ed3e2066b2f24c90c16.camel@linux.ibm.com>
 <af2nhZyyNaP7LM3w@e129823.arm.com>
 <2b3782398cc17ce9d355490a0c42ebce9120a9ae.camel@linux.ibm.com>
 <af3oFfdSMUglZVHa@e129823.arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af3oFfdSMUglZVHa@e129823.arm.com>
X-Rspamd-Queue-Id: 1D577541CF3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,earth.li,vger.kernel.org,lists.infradead.org,lists.linux.dev,paul-moore.com,namei.org,hallyn.com,huawei.com,oracle.com,kernel.org,ziepe.ca,arm.com,meta.com,google.com];
	TAGGED_FROM(0.00)[bounces-9530-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[arm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,e129823.arm.com:mid]
X-Rspamd-Action: no action

Hi Mimi,
> > On Fri, 2026-05-08 at 10:06 +0100, Yeoreum Yun wrote:
> > 
> > > > The kernel selftests caused the measurements between late_initcall and
> > > > late_initcall_sync.  After disabling all of the kernel selftests, there weren't
> > > > any measurements. Re-enabling the FIPS selftests on PowerVM LPAR resulted in
> > > > measurements.  (I didn't try re-enabling any of the other selftests.)
> > > > 
> > > > CONFIG_FIPS_SIGNATURE_SELFTEST=y
> > > > CONFIG_FIPS_SIGNATURE_SELFTEST_RSA=y
> > > > CONFIG_FIPS_SIGNATURE_SELFTEST_ECDSA=y
> > > 
> > > Thanks for shraring this ;)
> > > 
> > > I found the reason for those mesaurements. Those come from the
> > > request_module() and usermode-thread generates them while handling module
> > > loading request for crypto-x962(ecdsa-nist-p256).
> > > Since it's not a real kernel module,
> > > I confirmed file measurements between late_initcall and
> > > late_initcall_sync are gone for modeprobe with below change:
> > > 
> > > @@ -1246,9 +1250,14 @@ EXPORT_SYMBOL_GPL(ima_measure_critical_data);
> > >   */
> > >  static int ima_kernel_module_request(char *kmod_name)
> > >  {
> > >         if (strncmp(kmod_name, "crypto-pkcs1(rsa,", 17) == 0)
> > >                 return -EINVAL;
> > > 
> > > +       if (IS_BUILTIN(CONFIG_CRYPTO_ECDSA) &&
> > > +           (strncmp(kmod_name, "crypto-x962(ecdsa", 17) == 0))
> > > +               return -EINVAL;
> > > +
> > >         return 0;
> > >  }
> > > 
> > >  Though this is the only request_module() call between
> > >  late_initcall and late_initcall_sync, but I also confirmed there're
> > >  request_modules() call before ima initalisation before "late_initcall":
> > > 
> > > /*
> > >  * NOTE: kmod_name is printed on ima_kernel_module_request()
> > >  */
> > > 
> > > // This is called from module_init(stm_core_init) -> device_initcall()
> > > // which is in driver/hwtracing/stm/core.c (built-in)
> > > [    1.421986] ima: kmod_name: stm_p_basic
> > > ...
> > > [    1.444900] ima: kmod_name: crypto-pkcs1(rsa,sha512)
> > > [    1.444903] ima: kmod_name: crypto-pkcs1(rsa,sha512)-all
> > > ...
> > > [    1.452029] ima: kmod_name: crypto-cbc(aes)
> > > [    1.465321] ima: kmod_name: crypto-cbc(aes)-all
> > > ...
> > > [    1.467845] Key type encrypted registered
> > > [    1.467848] AppArmor: AppArmor sha256 policy hashing enabled
> > > 
> > >  // IMA is initailised at late_initcall level.
> > > [    1.467850] ima: [init_ima_late:1336]
> > > 
> > > If IMA should care request_module() from kernel before IMA init,
> > > I think there is no way to solve except queuing those events
> > > (kernel_load_data/kernel_load_post_data and open for module binary etc.)
> > > though it breaks "measure before use" principle since IMA couldn't
> > > measure at that time.
> > > 
> > > But if you don't care about those things -- some events happend before
> > > IMA init, I think your suggestion -- controlling the init time of ima_init()
> > > via a Kconfig option is good and ignoring some usermodehelper request
> > > including request_module() before IMA initialisation upto user by that option.
> > 
> > Thank you for the complete analysis.  The early measurements before the TPM is
> > initialized is a problem that needs to be addressed.  As to whether the solution
> > will require queueing is yet to be determined. (Roberto has some thoughts on
> > addressing it.) This discussion makes it clear that simply delaying IMA
> > initialization by moving it from late_initcall to late_initcall_sync could miss
> > measurements.  That said, exposing it as an opt-in Kconfig for those who accept
> > the risk is a sensible pragmatic compromise.
> 
> I think once we address ealry measurements before intialising TPM,
> It doesn't matter when IMA is initialissed since they're considered as
> ealry measurements anyway.
> 
> BTW, I'm not sure whether we should take pragmatic compromise first to
> support deferred TPM initialisation or solving it together via solution
> of ealry measurements (whatever it is) in now.

I wonder what's going on for discussion to resolve these problem:
  1) measurement event (via file operation)  before IMA initialisation.
  2) deferred TPM device initailisation and IMA.

Might someone could think it wouldn't be a problem since initrd is
measuared in PCR9 by boot loader (e.x) grub, but it still has a problem
for the case uses root= boot option where it doesn't use initrd
but use specified block dev with a filesystem.

I think soluation would be determined whether IMA neglects the
measurement event before its initialisation or not in current state:

  a) Case for neglecting measurement event before IMA initailisation.

    In this case, As you suggeested, IMA initialisation should be
    determined by build config whether it initialises at late_initcall
    or late_initcall_sync so that make user can choice upto their
    platform.

  b) Case for considering measurement event event before IMA
     initialisation.

    I couldn't image any other solution except queuing those event
    and extend them after generating boot_aggregate log and if those
    event can be queued, it wouldn't a problem to move IMA initialisation
    to late_initcall_sync.

But you mention there are some thoughts from Roberto, might there was
some discussion with him. If you don't mind, would you let me know
how the discussion is going on and your thought to fix this all?

Thanks!

-- 
Sincerely,
Yeoreum Yun

