Return-Path: <linux-integrity+bounces-7678-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 667B6C87C09
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Nov 2025 02:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F06C23B1A74
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Nov 2025 01:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931E81F9F7A;
	Wed, 26 Nov 2025 01:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RMGohsWY"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464D41A9B58
	for <linux-integrity@vger.kernel.org>; Wed, 26 Nov 2025 01:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764122050; cv=none; b=PeFNdpxX6+onDTQDt8+lcV54GgWxWLnpZutgPoGhOmVP8MnxNVHZHs0mQ65/gcvq/hsj9NyjHrkgheJniR2ASwYK8PCF73FoY3NwlLbDME7BmkZUgk6QpjrE+6wTZzUAVsQ2St15/O/FCc2UVRTx6fuEbe6dy3tFSseKPk6Vbuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764122050; c=relaxed/simple;
	bh=dY36C0ymswftMvx0JTezRyuZjUMuo3ewPmJdkev8ihw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h2Tj/bWbIY1Q07GaDvzBLibctsizw/j9lRDh1Djn6cORQR3dqRBE2usSc0SmsR5nzDNgzQt4qxxG+bNB8WNzuTzmwRU/rXMjKw0JUMDdIwdO6Eg+k3+MijnLQNkrwgF+Kax8hNKdjyoCYy9A0+d0ZrRlW7rLiq9t61gFnBApc0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RMGohsWY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764122046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=53kQFcBCtIvo+SC0mcW7rLuwH5BVmsmmwAugL850DwU=;
	b=RMGohsWYRrOBPKJ09l4yN0kXWtU4euslDNWhDby63zkAflNlLGKdC0mISyKWktTcc4UULD
	gG9X4VRqoyqd99SPe3M4YbeI5X0YQmWLThlCAZ3KNtyxFZqaqOO9awxvZOTcxfCF79FNh9
	Gbz3eDzh2NhKko+a6/8j+ZIhOKdUeew=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-392-RVh1_S1dN4aNwTSb2td7kg-1; Tue,
 25 Nov 2025 20:54:01 -0500
X-MC-Unique: RVh1_S1dN4aNwTSb2td7kg-1
X-Mimecast-MFC-AGG-ID: RVh1_S1dN4aNwTSb2td7kg_1764122040
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0059019560B5;
	Wed, 26 Nov 2025 01:53:59 +0000 (UTC)
Received: from localhost (unknown [10.72.112.35])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8171F3001E83;
	Wed, 26 Nov 2025 01:53:56 +0000 (UTC)
Date: Wed, 26 Nov 2025 09:53:52 +0800
From: Baoquan He <bhe@redhat.com>
To: Pingfan Liu <piliu@redhat.com>, Alexander Graf <graf@amazon.com>,
	makb@juniper.net
Cc: kexec@lists.infradead.org, linux-integrity@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Steven Chen <chenste@linux.microsoft.com>, stable@vger.kernel.org
Subject: Re: [PATCHv2 1/2] kernel/kexec: Change the prototype of
 kimage_map_segment()
Message-ID: <aSZdsNujdXiVr8HU@MiWiFi-R3L-srv>
References: <20251106065904.10772-1-piliu@redhat.com>
 <aSZTb1X26MjSZIzF@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSZTb1X26MjSZIzF@MiWiFi-R3L-srv>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi,

On 11/26/25 at 09:10am, Baoquan He wrote:
> Hi Pingfan,
> 
> On 11/06/25 at 02:59pm, Pingfan Liu wrote:
> > The kexec segment index will be required to extract the corresponding
> > information for that segment in kimage_map_segment(). Additionally,
> > kexec_segment already holds the kexec relocation destination address and
> > size. Therefore, the prototype of kimage_map_segment() can be changed.
> 
> Because no cover letter, I just reply here.
> 
> I am testing code of (tag: next-20251125, next/master) on arm64 system.
> I saw your two patches are already in there. When I used kexec reboot
> as below, I still got the warning message during ima_kexec_post_load()
> invocation. 

And when I try to turn off cma allocating for kexec buffer, I found
there's no such flag in user space utility kexec-tools. Since Alexander
introduced commit 07d24902977e ("kexec: enable CMA based contiguous
allocation"), but haven't add flag KEXEC_FILE_NO_CMA to kexec-tools, and
Pingfan you are working to fix the bug, can any of you post patch to
kexec-tools to add the flag?

And flag KEXEC_FILE_FORCE_DTB too, which was introduced in commit f367474b5884
("x86/kexec: carry forward the boot DTB on kexec").

We only have them in kernel, but there's no chance to specify them,
what's the meaning to have them?

Thanks
Baoquan

> 
> ====================
> kexec -d -l /boot/vmlinuz-6.18.0-rc7-next-20251125 --initrd /boot/initramfs-6.18.0-rc7-next-20251125.img --reuse-cmdline
> ====================
> 
> ====================
> [34283.657670] kexec_file: kernel: 000000006cf71829 kernel_size: 0x48b0000
> [34283.657700] PEFILE: Unsigned PE binary
> [34283.676597] ima: kexec measurement buffer for the loaded kernel at 0xff206000.
> [34283.676621] kexec_file: Loaded initrd at 0x84cb0000 bufsz=0x25ec426 memsz=0x25ed000
> [34283.684646] kexec_file: Loaded dtb at 0xff400000 bufsz=0x39e memsz=0x1000
> [34283.684653] kexec_file(Image): Loaded kernel at 0x80400000 bufsz=0x48b0000 memsz=0x48b0000
> [34283.684663] kexec_file: nr_segments = 4
> [34283.684666] kexec_file: segment[0]: buf=0x0000000000000000 bufsz=0x0 mem=0xff206000 memsz=0x1000
> [34283.684674] kexec_file: segment[1]: buf=0x000000006cf71829 bufsz=0x48b0000 mem=0x80400000 memsz=0x48b0000
> [34283.725987] kexec_file: segment[2]: buf=0x00000000c7369de6 bufsz=0x25ec426 mem=0x84cb0000 memsz=0x25ed000
> [34283.747670] kexec_file: segmen
> ** replaying previous printk message **
> [34283.747670] kexec_file: segment[3]: buf=0x00000000d83b530b bufsz=0x39e mem=0xff400000 memsz=0x1000
> [34283.747973] ------------[ cut here ]------------
> [34283.747976] WARNING: CPU: 33 PID: 16112 at kernel/kexec_core.c:1002 kimage_map_segment+0x138/0x190
> [34283.778574] Modules linked in: rfkill vfat fat ipmi_ssif igb acpi_ipmi ipmi_si ipmi_devintf mlx5_fwctl i2c_algo_bit ipmi_msghandler fwctl fuse loop nfnetlink zram lz4hc_compress lz4_compress xfs mlx5_ib macsec mlx5_core nvme nvme_core mlxfw psample tls nvme_keyring nvme_auth pci_hyperv_intf sbsa_gwdt rpcrdma sunrpc rdma_ucm ib_uverbs ib_srpt ib_isert iscsi_target_mod target_core_mod ib_iser i2c_dev ib_umad rdma_cm ib_ipoib iw_cm ib_cm libiscsi ib_core scsi_transport_iscsi aes_neon_bs
> [34283.824233] CPU: 33 UID: 0 PID: 16112 Comm: kexec Tainted: G        W           6.17.8-200.fc42.aarch64 #1 PREEMPT(voluntary) 
> [34283.836355] Tainted: [W]=WARN
> [34283.839684] Hardware name: CRAY CS500/CMUD        , BIOS 1.4.0 Jun 17 2020
> [34283.846903] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [34283.854243] pc : kimage_map_segment+0x138/0x190
> [34283.859120] lr : kimage_map_segment+0x4c/0x190
> [34283.863920] sp : ffff8000a0643a90
> [34283.867394] x29: ffff8000a0643a90 x28: ffff800083d0a000 x27: 0000000000000000
> [34283.874901] x26: 0000aaaad722d4b0 x25: 000000000000008f x24: ffff800083d0a000
> [34283.882608] x23: 0000000000000001 x22: 00000000ff206000 x21: 00000000ff207000
> [34283.890305] x20: ffff008fbd306980 x19: ffff008f895d6400 x18: 00000000fffffff9
> [34283.897815] x17: 303d6d656d206539 x16: 3378303d7a736675 x15: 646565732d676e72
> [34283.905516] x14: 00646565732d726c x13: 616d692c78756e69 x12: 6c00636578656b2d
> [34283.912999] x11: 007265666675622d x10: 636578656b2d616d x9 : ffff80008050b73c
> [34283.920691] x8 : 0001000000000000 x7 : 0000000000000000 x6 : 0000000080000000
> [34283.928197] x5 : 0000000084cb0000 x4 : ffff008fbd2306b0 x3 : ffff008fbd305000
> [34283.935898] x2 : fffffff7ff000000 x1 : 0000000000000004 x0 : ffff800082046000
> [34283.943603] Call trace:
> [34283.946039]  kimage_map_segment+0x138/0x190 (P)
> [34283.950935]  ima_kexec_post_load+0x58/0xc0
> [34283.955225]  __do_sys_kexec_file_load+0x2b8/0x398
> [34283.960279]  __arm64_sys_kexec_file_load+0x28/0x40
> [34283.965965]  invoke_syscall.constprop.0+0x64/0xe8
> [34283.971025]  el0_svc_common.constprop.0+0x40/0xe8
> [34283.975883]  do_el0_svc+0x24/0x38
> [34283.979361]  el0_svc+0x3c/0x168
> [34283.982833]  el0t_64_sync_handler+0xa0/0xf0
> [34283.987176]  el0t_64_sync+0x1b0/0x1b8
> [34283.991000] ---[ end trace 0000000000000000 ]---
> [34283.996060] ------------[ cut here ]------------
> [34283.996064] WARNING: CPU: 33 PID: 16112 at mm/vmalloc.c:538 vmap_pages_pte_range+0x2bc/0x3c0
> [34284.010006] Modules linked in: rfkill vfat fat ipmi_ssif igb acpi_ipmi ipmi_si ipmi_devintf mlx5_fwctl i2c_algo_bit ipmi_msghandler fwctl fuse loop nfnetlink zram lz4hc_compress lz4_compress xfs mlx5_ib macsec mlx5_core nvme nvme_core mlxfw psample tls nvme_keyring nvme_auth pci_hyperv_intf sbsa_gwdt rpcrdma sunrpc rdma_ucm ib_uverbs ib_srpt ib_isert iscsi_target_mod target_core_mod ib_iser i2c_dev ib_umad rdma_cm ib_ipoib iw_cm ib_cm libiscsi ib_core scsi_transport_iscsi aes_neon_bs
> [34284.055630] CPU: 33 UID: 0 PID: 16112 Comm: kexec Tainted: G        W           6.17.8-200.fc42.aarch64 #1 PREEMPT(voluntary) 
> [34284.067701] Tainted: [W]=WARN
> [34284.070833] Hardware name: CRAY CS500/CMUD        , BIOS 1.4.0 Jun 17 2020
> [34284.078238] pstate: 40400009 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [34284.085546] pc : vmap_pages_pte_range+0x2bc/0x3c0
> [34284.090607] lr : vmap_small_pages_range_noflush+0x16c/0x298
> [34284.096528] sp : ffff8000a0643940
> [34284.100001] x29: ffff8000a0643940 x28: 0000000000000000 x27: ffff800084f76000
> [34284.107699] x26: fffffdffc0000000 x25: ffff8000a06439d0 x24: ffff800082046000
> [34284.115174] x23: ffff800084f75000 x22: ffff007f80337ba8 x21: 03ffffffffffffc0
> [34284.122821] x20: ffff008fbd306980 x19: ffff8000a06439d4 x18: 00000000fffffff9
> [34284.130331] x17: 303d6d656d206539 x16: 3378303d7a736675 x15: 646565732d676e72
> [34284.138032] x14: 0000000000004000 x13: ffff009781307130 x12: 0000000000002000
> [34284.145733] x11: 0000000000000000 x10: 0000000000000001 x9 : ffff8000804e197c
> [34284.153248] x8 : 0000000000000027 x7 : ffff800085175000 x6 : ffff8000a06439d4
> [34284.160944] x5 : ffff8000a06439d0 x4 : ffff008fbd306980 x3 : 0068000000000f03
> [34284.168449] x2 : ffff007f80337ba8 x1 : 0000000000000000 x0 : 0000000000000000
> [34284.176150] Call trace:
> [34284.178768]  vmap_pages_pte_range+0x2bc/0x3c0 (P)
> [34284.183665]  vmap_small_pages_range_noflush+0x16c/0x298
> [34284.189264]  vmap+0xb4/0x138
> [34284.192312]  kimage_map_segment+0xdc/0x190
> [34284.196794]  ima_kexec_post_load+0x58/0xc0
> [34284.201044]  __do_sys_kexec_file_load+0x2b8/0x398
> [34284.206107]  __arm64_sys_kexec_file_load+0x28/0x40
> [34284.211254]  invoke_syscall.constprop.0+0x64/0xe8
> [34284.216139]  el0_svc_common.constprop.0+0x40/0xe8
> [34284.221196]  do_el0_svc+0x24/0x38
> [34284.224678]  el0_svc+0x3c/0x168
> [34284.227983]  el0t_64_sync_handler+0xa0/0xf0
> [34284.232526]  el0t_64_sync+0x1b0/0x1b8
> [34284.236376] ---[ end trace 0000000000000000 ]---
> [34284.241412] kexec_core: Could not map ima buffer.
> [34284.241421] ima: Could not map measurements buffer.
> [34284.551336] machine_kexec_post_load:155:
> [34284.551354]   kexec kimage info:
> [34284.551366]     type:        0
> [34284.551373]     head:        90363f9002
> [34284.551377]     kern_reloc: 0x00000090363f7000
> [34284.551381]     el2_vectors: 0x0000000000000000
> [34284.551384] kexec_file: kexec_file_load: type:0, start:0x80400000 head:0x90363f9002 flags:0x8
> ====================
> 
> > 
> > Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")
> > Signed-off-by: Pingfan Liu <piliu@redhat.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Baoquan He <bhe@redhat.com>
> > Cc: Mimi Zohar <zohar@linux.ibm.com>
> > Cc: Roberto Sassu <roberto.sassu@huawei.com>
> > Cc: Alexander Graf <graf@amazon.com>
> > Cc: Steven Chen <chenste@linux.microsoft.com>
> > Cc: <stable@vger.kernel.org>
> > To: kexec@lists.infradead.org
> > To: linux-integrity@vger.kernel.org
> > ---
> >  include/linux/kexec.h              | 4 ++--
> >  kernel/kexec_core.c                | 9 ++++++---
> >  security/integrity/ima/ima_kexec.c | 4 +---
> >  3 files changed, 9 insertions(+), 8 deletions(-)
> > 
> > diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> > index ff7e231b0485..8a22bc9b8c6c 100644
> > --- a/include/linux/kexec.h
> > +++ b/include/linux/kexec.h
> > @@ -530,7 +530,7 @@ extern bool kexec_file_dbg_print;
> >  #define kexec_dprintk(fmt, arg...) \
> >          do { if (kexec_file_dbg_print) pr_info(fmt, ##arg); } while (0)
> >  
> > -extern void *kimage_map_segment(struct kimage *image, unsigned long addr, unsigned long size);
> > +extern void *kimage_map_segment(struct kimage *image, int idx);
> >  extern void kimage_unmap_segment(void *buffer);
> >  #else /* !CONFIG_KEXEC_CORE */
> >  struct pt_regs;
> > @@ -540,7 +540,7 @@ static inline void __crash_kexec(struct pt_regs *regs) { }
> >  static inline void crash_kexec(struct pt_regs *regs) { }
> >  static inline int kexec_should_crash(struct task_struct *p) { return 0; }
> >  static inline int kexec_crash_loaded(void) { return 0; }
> > -static inline void *kimage_map_segment(struct kimage *image, unsigned long addr, unsigned long size)
> > +static inline void *kimage_map_segment(struct kimage *image, int idx)
> >  { return NULL; }
> >  static inline void kimage_unmap_segment(void *buffer) { }
> >  #define kexec_in_progress false
> > diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> > index fa00b239c5d9..9a1966207041 100644
> > --- a/kernel/kexec_core.c
> > +++ b/kernel/kexec_core.c
> > @@ -960,17 +960,20 @@ int kimage_load_segment(struct kimage *image, int idx)
> >  	return result;
> >  }
> >  
> > -void *kimage_map_segment(struct kimage *image,
> > -			 unsigned long addr, unsigned long size)
> > +void *kimage_map_segment(struct kimage *image, int idx)
> >  {
> > +	unsigned long addr, size, eaddr;
> >  	unsigned long src_page_addr, dest_page_addr = 0;
> > -	unsigned long eaddr = addr + size;
> >  	kimage_entry_t *ptr, entry;
> >  	struct page **src_pages;
> >  	unsigned int npages;
> >  	void *vaddr = NULL;
> >  	int i;
> >  
> > +	addr = image->segment[idx].mem;
> > +	size = image->segment[idx].memsz;
> > +	eaddr = addr + size;
> > +
> >  	/*
> >  	 * Collect the source pages and map them in a contiguous VA range.
> >  	 */
> > diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> > index 7362f68f2d8b..5beb69edd12f 100644
> > --- a/security/integrity/ima/ima_kexec.c
> > +++ b/security/integrity/ima/ima_kexec.c
> > @@ -250,9 +250,7 @@ void ima_kexec_post_load(struct kimage *image)
> >  	if (!image->ima_buffer_addr)
> >  		return;
> >  
> > -	ima_kexec_buffer = kimage_map_segment(image,
> > -					      image->ima_buffer_addr,
> > -					      image->ima_buffer_size);
> > +	ima_kexec_buffer = kimage_map_segment(image, image->ima_segment_index);
> >  	if (!ima_kexec_buffer) {
> >  		pr_err("Could not map measurements buffer.\n");
> >  		return;
> > -- 
> > 2.49.0
> > 
> 


