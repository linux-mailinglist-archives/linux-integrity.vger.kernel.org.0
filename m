Return-Path: <linux-integrity+bounces-3708-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC21987C32
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Sep 2024 02:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68D4E1F232D5
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Sep 2024 00:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FED34409;
	Fri, 27 Sep 2024 00:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="pQb7aepR"
X-Original-To: linux-integrity@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55112136A;
	Fri, 27 Sep 2024 00:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727397761; cv=none; b=PCvVBLC6uKMKo1smaCE6V17mwojejoGVnaPp+6CXzinOJi05eyXYoczeFXgxHRww0Wpd6vTwfMGlX/9JvTzRVVu70DMX3ggEvPud6FJQSzTGLHdkApaY3kjm+QS1LFdgVlHoq60ksf5x8/MlnPXPkpJfIOBYHGyc2TzgTovGG5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727397761; c=relaxed/simple;
	bh=8aHMpuUEv6lflo1gRRNkgSYGOgLpnoI1wmn6pI616cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LficRVXJRMN+3yLsWAqbjriw54OkR0P3Ds9DzBitFN/HIT5Pasvw1BvjBYTHsEYMfGvCkfbcdWXgsb+AtUKum34/0fpCB/hAE4JJjeK2iOYbqxFnXEmr4XglaQMzeZJpyjmg0XUMp1xnRPhG18j/celUtPRgzjaaObzdORSJLjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=pQb7aepR; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=g+0shDV/+gL+nIk2ylwHIvn9il9U3sJSyEP1xXdQV8Q=; b=pQb7aepRcnPzZ7bgkFlJ7HqUOz
	2iLhBpUsTSkIQ23n4nZOpzGhUT4Z4XAEbMatWviBMcTBWaT8pD6bac2vaUd108RhRAHS83tdkHmKk
	B8b68A0r3779HlmqZR3c6ReeOH8X0Ycmvf70JEEr1TgrrHDGkc3jV0lZTdzkCrLY2Pdy6IBB+hEdj
	HenqVVn+CKm5wzS7/1999Ht0uVE/kh7bqKD53SB4ogesFyh4IRf3I3x6dcFvkzSMMCdubjwgMmJKE
	BGf9QdOYxdTEayHAsN1CRZT7jdcutv28bEYmJ1m8pAKE+zjDTqVLHS0IOUkGp1agY7uMWb1v0Fgkh
	xIm0tBbA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1styts-0059is-1t;
	Fri, 27 Sep 2024 08:42:15 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 27 Sep 2024 08:42:14 +0800
Date: Fri, 27 Sep 2024 08:42:14 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	Guangwu Zhang <guazhang@redhat.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: [PATCH] hwrng: core - Add WARN_ON for buggy read return values
Message-ID: <ZvX_Zj8PAXcFJPLU@gondor.apana.org.au>
References: <ZvEFQAWVgWNd9j7e@gondor.apana.org.au>
 <D4DI1M1ELFXK.2COGZN6O5HABD@kernel.org>
 <ZvE0NrOC00ojRe3t@gondor.apana.org.au>
 <D4DQJ34I5FSD.1K618VWEKI7IW@kernel.org>
 <2024092340-renovate-cornflake-4b5e@gregkh>
 <ZvHsh6by3omeYj9d@gondor.apana.org.au>
 <D4EN54C1IK1R.11JD66L931PD8@kernel.org>
 <D4EP817NLQY9.35RSWO8IFXRL0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D4EP817NLQY9.35RSWO8IFXRL0@kernel.org>

On Tue, Sep 24, 2024 at 08:43:00PM +0300, Jarkko Sakkinen wrote:
>
> Without any traces that would provide more information I don't see
> the smoking gun.

I haven't confirmed that it's definitely the tpm2 driver, it's just
based on the backtrace.  Hopefully my patch will confirm it one way
or the other.  Here is the backtrace:

[  100.784159] vmd 0000:c2:00.5: Bound to PCI domain 10002 
[  100.786209] Monitor-Mwait will be used to enter C-1 state 
[  100.786225] Monitor-Mwait will be used to enter C-2 state 
[  100.786244] ACPI: \_SB_.SCK0.C000: Found 2 idle states 
[  100.823093] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0 
[  100.823636] ACPI: button: Power Button [PWRF] 
[  100.905756] ERST: Error Record Serialization Table (ERST) support is initialized. 
[  100.905858] pstore: Using crash dump compression: deflate 
[  100.905861] pstore: Registered erst as persistent store backend 
[  100.907044] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled 
[  100.908305] 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A 
[  100.926608] 00:04: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A 
[  100.942953] Non-volatile memory driver v1.3 
[  100.947908] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0x1B, rev-id 22) 
[  101.226913] ACPI: bus type drm_connector registered 
[  101.229708] alg: ecdh-nist-p256 (ecdh-nist-p256-generic) is disabled due to FIPS 
[  101.229745] tpm tpm0: crypto ecdh allocation failed 
[  101.236311] tpm tpm0: A TPM error (708) occurred start auth session 
[  101.238797] ================================================================== 
[  101.238800] BUG: KASAN: slab-out-of-bounds in blake2s_update+0x135/0x2b0 
[  101.238808] Read of size 44 at addr ff11000167334d98 by task hwrng/318 
[  101.238811]  
[  101.238813] CPU: 26 UID: 0 PID: 318 Comm: hwrng Not tainted 6.11.0-0.rc5.22.el10.x86_64+debug #1 
[  101.238818] Hardware name: Supermicro SSG-110P-NTR10-EI018/X12SPO-NTF, BIOS 1.3 05/20/2022 
[  101.238820] Call Trace: 
[  101.238823]  <TASK> 
[  101.238826]  dump_stack_lvl+0x6f/0xb0 
[  101.238833]  ? blake2s_update+0x135/0x2b0 
[  101.238836]  print_address_description.constprop.0+0x88/0x330 
[  101.238843]  ? blake2s_update+0x135/0x2b0 
[  101.238847]  print_report+0x108/0x209 
[  101.238851]  ? blake2s_update+0x135/0x2b0 
[  101.238855]  ? __virt_addr_valid+0x20b/0x440 
[  101.238859]  ? blake2s_update+0x135/0x2b0 
[  101.238863]  kasan_report+0xa8/0xe0 
[  101.238868]  ? blake2s_update+0x135/0x2b0 
[  101.238874]  kasan_check_range+0x10f/0x1f0 
[  101.238879]  __asan_memcpy+0x23/0x60 
[  101.238883]  blake2s_update+0x135/0x2b0 
[  101.238887]  add_hwgenerator_randomness+0x3d/0xe0 
[  101.238895]  hwrng_fillfn+0x144/0x270 
[  101.238900]  ? __pfx_hwrng_fillfn+0x10/0x10 
[  101.238904]  kthread+0x2d2/0x3a0 
[  101.238908]  ? __pfx_kthread+0x10/0x10 
[  101.238912]  ret_from_fork+0x31/0x70 
[  101.238917]  ? __pfx_kthread+0x10/0x10 
[  101.238920]  ret_from_fork_asm+0x1a/0x30 
[  101.238929]  </TASK> 
[  101.238931]  
[  101.238932] Allocated by task 1: 
[  101.238934]  kasan_save_stack+0x30/0x50 
[  101.238937]  kasan_save_track+0x14/0x30 
[  101.238940]  __kasan_kmalloc+0x8f/0xa0 
[  101.238942]  __kmalloc_noprof+0x1fe/0x410 
[  101.238947]  kobj_map+0x7e/0x6d0 
[  101.238951]  cdev_add+0x92/0x180 
[  101.238954]  tty_cdev_add+0x17a/0x280 
[  101.238957]  tty_register_device_attr+0x401/0x740 
[  101.238960]  tty_register_driver+0x381/0x6f0 
[  101.238963]  vty_init+0x2c1/0x2f0 
[  101.238967]  tty_init+0x13b/0x150 
[  101.238970]  do_one_initcall+0x11c/0x5c0 
[  101.238975]  do_initcalls+0x1b4/0x1f0 
[  101.238980]  kernel_init_freeable+0x4ae/0x520 
[  101.238984]  kernel_init+0x1c/0x150 
[  101.238988]  ret_from_fork+0x31/0x70 
[  101.238991]  ret_from_fork_asm+0x1a/0x30 
[  101.238994]  
[  101.238995] The buggy address belongs to the object at ff11000167334d80 
[  101.238995]  which belongs to the cache kmalloc-64 of size 64 
[  101.238998] The buggy address is located 24 bytes inside of 
[  101.238998]  allocated 56-byte region [ff11000167334d80, ff11000167334db8) 
[  101.239002]  
[  101.239003] The buggy address belongs to the physical page: 
[  101.239004] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x167334 
[  101.239008] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff) 
[  101.239012] page_type: 0xfdffffff(slab) 
[  101.239016] raw: 0017ffffc0000000 ff1100010003c8c0 dead000000000122 0000000000000000 
[  101.239019] raw: 0000000000000000 0000000000200020 00000001fdffffff 0000000000000000 
[  101.239021] page dumped because: kasan: bad access detected 
[  101.239023]  
[  101.239024] Memory state around the buggy address: 
[  101.239025]  ff11000167334c80: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc 
[  101.239028]  ff11000167334d00: 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc 
[  101.239030] >ff11000167334d80: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc 
[  101.239031]                                         ^ 
[  101.239033]  ff11000167334e00: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc 
[  101.239035]  ff11000167334e80: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc 
[  101.239037] ================================================================== 
[  101.383067] rdac: device handler registered 
[  101.383412] hp_sw: device handler registered 
[  101.383415] emc: device handler registered 
[  101.383879] alua: device handler registered 
[  101.391255] xhci_hcd 0000:00:14.0: xHCI Host Controller 
[  101.391892] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1 
[  101.393706] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x0000000000009810 
[  101.399646] xhci_hcd 0000:00:14.0: xHCI Host Controller 
[  101.400136] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2 
[  101.400163] xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed 
[  101.400818] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.11 
[  101.400823] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1 
[  101.400826] usb usb1: Product: xHCI Host Controller 
[  101.400829] usb usb1: Manufacturer: Linux 6.11.0-0.rc5.22.el10.x86_64+debug xhci-hcd 
[  101.400832] usb usb1: SerialNumber: 0000:00:14.0 
[  101.403055] hub 1-0:1.0: USB hub found 
[  101.403222] hub 1-0:1.0: 16 ports detected 
[  101.657974] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.11 
[  101.657982] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1 
[  101.657986] usb usb2: Product: xHCI Host Controller 
[  101.657990] usb usb2: Manufacturer: Linux 6.11.0-0.rc5.22.el10.x86_64+debug xhci-hcd 
[  101.657993] usb usb2: SerialNumber: 0000:00:14.0 
[  101.660659] hub 2-0:1.0: USB hub found 
[  101.660882] hub 2-0:1.0: 10 ports detected  {code}

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

