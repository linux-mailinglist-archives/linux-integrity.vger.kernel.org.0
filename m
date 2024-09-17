Return-Path: <linux-integrity+bounces-3629-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F39F97B359
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Sep 2024 19:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBED7B23EDD
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Sep 2024 17:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E0917B4E9;
	Tue, 17 Sep 2024 17:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="slO00W5p"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-00823401.pphosted.com (mx0a-00823401.pphosted.com [148.163.148.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A38C2A8C1;
	Tue, 17 Sep 2024 17:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726592514; cv=none; b=Zp0JOUDfPPAW5SObmXisC2PVYZ0KW1amD8CMDDUnze2A9wNXAbTRJAmmlOf6Pd3RC4Yf5QB9yWKhcSO63rfEUNlJJp1+EjukaVP/T+IHoD0AvaSbiOg+BfCvuk2kiAmEJSE/eFlol2PNw5NDAwyOhWdOs5TYSbFBTKBZPtpmgKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726592514; c=relaxed/simple;
	bh=iPZzHyUmlAvkesLpvSTeltnC5QZeblgMHpf1sd4TKO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hW8IpLzRZOVrfgVpGAHN2vb1+Gi0bB8KMdQj+2WBFe9frxJJn8Oe+Oof9BZNaFJpwyZSQ7LDR6+qUzkVhMMLDm9GqvEAMBZbJbwUJ7zQvK9k60/afRTw7wrKw1e/GzruG0W3GHaG9tI39rverjVgMpfOT9fp9ri3Bw9uvRydSVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=slO00W5p; arc=none smtp.client-ip=148.163.148.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355088.ppops.net [127.0.0.1])
	by m0355088.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 48HDL3ci029933;
	Tue, 17 Sep 2024 17:01:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=DKIM202306; bh=rIdvr7HhjmLu1dnf7N/fYwy
	Kstz7gDRVUiP7kuUGTIk=; b=slO00W5pF//C1bjzhIiHwlzL9O5kgQsFCyfTYSd
	ux2S3zZZZJ6vNgo19Bd0VRfNI1hMpiAbp91t13t+NOHLlDaNOE3vrDXPQ1pVfMct
	oR6MjzmM0MFE6EXKbqT1MeZg/Mosut22hNWHFCJhTeKB0muywnC7w0iEEuOFF/55
	zSDmPu8bK5rTFuDLfIGWR79hoIE9KUwuEGRiN1ft+1B77kjmDIrQMDVw3IGdZ2Om
	vHiyLlNYtchCm4z6zQwFx0GD/nieUfcezNwQ6BauEBIZofTtq9qb73DVRQpeB88J
	ujKursxlBvtV8/pXrdEFKoy2gyUfBIW2m8PWzk/B2X9GFTw==
Received: from iadlppfpol2.lenovo.com ([104.232.228.81])
	by m0355088.ppops.net (PPS) with ESMTPS id 41nqnt4dgj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 17:01:36 +0000 (GMT)
Received: from ilclmmrp02.lenovo.com (unknown [100.65.83.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by iadlppfpol2.lenovo.com (Postfix) with ESMTPS id 4X7Sjq0vJmzYkjQw;
	Tue, 17 Sep 2024 17:01:35 +0000 (UTC)
Received: from ilclasset02 (ilclasset02.mot.com [100.64.11.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mbland)
	by ilclmmrp02.lenovo.com (Postfix) with ESMTPSA id 4X7Sjq3JXdz3npb3;
	Tue, 17 Sep 2024 17:01:35 +0000 (UTC)
Date: Tue, 17 Sep 2024 12:01:34 -0500
From: Maxwell Bland <mbland@motorola.com>
To: Kees Cook <kees@kernel.org>
Cc: "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        Andrew Wheeler <awheeler@motorola.com>,
        Sammy BS2 Que | =?utf-8?B?6ZiZ5paM55Sf?= <quebs2@motorola.com>,
        Neill Kapron <nkapron@google.com>, Todd Kjos <tkjos@google.com>,
        Viktor Martensson <vmartensson@google.com>,
        Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
        Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        kernel-team <kernel-team@android.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [RFC] Proposal: Static SECCOMP Policies
Message-ID: <etx53yyl6oji7qnw2f2o4svji7xaq35otxyhms4qtfadc7h4ag@b3jxyrezn6mq>
References: <SEZPR03MB6786D45BE387F2B378E71A84B4642@SEZPR03MB6786.apcprd03.prod.outlook.com>
 <202409170005.60410C0A4B@keescook>
 <wacuopelbn4mnfbxzzhz245uhz6dk7hx4tchftayrvcb6jlqfm@6y77hrtzayua>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wacuopelbn4mnfbxzzhz245uhz6dk7hx4tchftayrvcb6jlqfm@6y77hrtzayua>
X-Proofpoint-GUID: o7b6xxGmrkXylPEUJTYPfL3pYaqStAS1
X-Proofpoint-ORIG-GUID: o7b6xxGmrkXylPEUJTYPfL3pYaqStAS1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 impostorscore=0 adultscore=0 phishscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409170122

+ Mimi, Dmitry, Integrity, FYI

On Tue, Sep 17, 2024 at 11:54:17AM GMT, Maxwell Bland wrote:
> On Tue, Sep 17, 2024 at 12:34:28AM GMT, Kees Cook wrote:
> > On Thu, Sep 12, 2024 at 04:02:53PM +0000, Maxwell Bland wrote:
> > > operated on around 0.1188 MB). But most importantly, third, without some degree
> > > of provenance, I have no way of telling if someone has injected malicious code
> > > into the kernel, and unfortunately even knowing the correct bytes is still
> > > "iffy", as in order to prevent JIT spray attacks, each of these filters is
> > > offset by some random number of uint32_t's, making every 4-byte shift of the
> > > filter a "valid" codepage to be loaded at runtime.
> > 
> > So, let's start here. What I've seen from the thread is that there isn't
> > a way to verify that a given JIT matches the cBPF. Is validating the
> > cBPF itself also needed?
> 
> Yes(ish) but mostly no. Current kernel exploits, from what I have seen
> and what is readily available consist of three stages:
> 
> - Find a UAF
> - Bootstrap this UAF into an unconstrained read/write
> - Modify some core kernel resource to get arbitrary execution.
> 
> Example dating back to 2019:
> https://googleprojectzero.blogspot.com/2019/11/bad-binder-android-in-wild-exploit.html
> 
> An adversary could modify the loaded cBPF program prior to loading in
> order to, say, change the range of syscall _NR_'s accepted by the
> seccomp switch statement in order to stage their escape from Chrome's
> sandbox.
> 
> However, JIT presents a more general issue, hence the mostly no, since
> and exploited native system service could target the JITed code page
> in order to exploit the kernel, rather than requiring something to
> be staged within the modified seccomp sandbox in the "cBPF itself"
> example.
> 
> For example, Motorola has a few system services for hardware and other
> things (as well as QCOM), written in C, for example, our native dropbox
> agent. Supposing there were an exploit for this agent allowing execution
> within that service's context, an adversary could find a UAF, and target
> the page of Chrome's JITed seccomp filter in order to exploit the full
> kernel. That is, they are not worried about escaping the sandbox so much
> as finding a writable resource from which they can gain privileges in
> the rest of the kernel.
> 
> Admitted, there are ~29,000 other writable data structures (in
> msm-kernel) they could also target, but the JIT'ed seccomp filter is the
> only code page they could modify (since it is not possible to get
> compile-time provenance/signatures). The dilemma is that opposed to
> modifying, say, the system_unbound_wq and adding an entry to it that
> holds a pointer to call_usermodehelper_exec_work, you could add some
> code to this page instead, making the kernel the same level of
> exploitable.
> 
> The goal at the end of the day is to fix this and then try to build a
> system to lock down the rest of the data in a sensible way. Likely an
> ARM-MTE like, EL2-maintained tag system conditioned on the kernel's
> scheduler and memory allocation infrastructure. At least, that is what I
> want to be working on, after I figure out this seccomp stuff.
> 
> > - The IMA subsystem has wanted a way to measure (and validate) seccomp
> >   filters. We could get more details from them for defining this need
> >   more clearly.
> 
> You are right. I have added Mimi, Dmitry, and the integrity list. Their
> work with linked lists and other data structures is right in line with
> these concerns. I do not know if they have looked at building verifiers
> for JIT'ed cBPF pages already.
> 
> > - The JIT needs to be verified against the cBPF that it was generated
> >   from. We currently do only a single pass and don't validate it once
> >   the region has been set read-only. We have a standing feature request
> >   for improving this: https://github.com/KSPP/linux/issues/154
> >
> Kees, this is exactly what I'm talking about, you are awesome!
> 
> I'll share the (pretty straightforward) EL2 logic for this, though not the
> code, since licensing and all that, but this public mailing list should
> hopefully serve as prior art for any questionable chipset vendor attempting to
> patent public domain security for the everyday person:
> 
> - Marking PTEs null is fine
> - If a new PTE is allocated, mark it PXN atomically using the EL2
>   permission fault failure triggered from the page table lockdown (see
>   GPL-2.0 kernel module below).
> - If a PTE is updated and the PXN bit is switched from 1 to 0, SHA256
>   the page, mark it immutable, and let it through if it is OK.
> 
> This lets the page be mucked with during the whole JIT process, but ensures
> that the second the page wants to be priv-executable, no further modifications
> happen. To "unlock" the page for free-ing, one just needs to set the PXN bit
> back. Then if we ever want to execute from it again, the process repeats, so
> on. This relies on my prior main.c vmalloc maintenance and the below ptprotect
> logic (note, WIP, no warranty on this code).
> 
> > For solutions, I didn't see much discussion around the "orig_prog"
> > copy of the cBPF. Under CHECKPOINT_RESTORE, the original cBPF remains
> > associated with the JIT. struct seccomp_filter's struct bpf_prog prog's
> > orig_prog member. If it has value outside of CHECKPOINT_RESTORE, then
> > we could do it for those conditions too.
> 
> Unfortunately the Android GKI does not support checkpoint restore and makes the
> orig_prog reference fail (at least in the case I'm trying to work towards for
> cell phones).
> 
> I could lock the orig_prog as immutable during the JIT, and given the resulting
> code page, and then attempt to reproduce the code page in EL2 from the original
> cBPF, but that seems dangerous and potentially buggy as opposed to checking the
> reference addresses in the final machine code against knowledge of struct
> seccomp_data (what I am working on right now).
> 
> Maxwell
> 
> // SPDX-License-Identifier: GPL-2.0
> /*
>  * Copyright (C) 2023 Motorola Mobility, Inc.
>  *
>  * Authors: Maxwell Bland
>  * Binsheng "Sammy" Que
>  *
>  * This program is free software; you can redistribute it and/or modify
>  * it under the terms of the GNU General Public License version 2 as
>  * published by the Free Software Foundation.
>  *
>  * This program is distributed in the hope that it will be useful,
>  * but WITHOUT ANY WARRANTY; without even the implied warranty of
>  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>  * GNU General Public License for more details.
>  *
>  * Initializes hypervisor-level protections for the kernel pagetables.  In
>  * coordination with the moto_org_mem driver, which restricts executable code
>  * pages to a well defined region in-between
>  *
>  * stext <-> module_alloc_base + SZ_2G
>  *
>  * It is able to mark all page tables not corresponding to this virtual address
>  * range PXNTable. Mark the table these descriptors exist within as immutable.
>  * For all tables/descriptors which are marked privileged executable, these are
>  * marked permanently immutable, and their modifications are tracked directly.
>  */
> #ifndef _PTPROTECT_H
> #define _PTPROTECT_H
> 
> #include <linux/delay.h>
> #include <linux/highmem.h>
> #include <linux/kprobes.h>
> #include <linux/list.h>
> #include <linux/mm_types.h>
> #include <linux/module.h>
> #include <linux/of.h>
> #include <linux/of_platform.h>
> #include <linux/pagewalk.h>
> #include <linux/types.h>
> #include <asm/pgalloc.h>
> #include <asm/pgtable-hwdef.h>
> #include <asm/pgtable.h>
> #include <mm/pgalloc-track.h>
> #include <trace/hooks/fault.h>
> #include <trace/hooks/vendor_hooks.h>
> #include <fs/erofs/compress.h>
> 
> uint64_t stext_vaddr = 0;
> uint64_t etext_vaddr = 0;
> uint64_t module_alloc_base_vaddr = 0;
> 
> uint64_t last_pmd_range[2] = { 0, 0 };
> uint64_t pmd_range_list[1024][2] = { 0 };
> int pmd_range_list_index = 0;
> 
> /**
>  * add_to_pmd_range_list - adds a range to the pmd range list
>  * @start: Start of the range
>  * @end: End of the range
>  *
>  * Used to implement a naive set of adjacent pmd segments to 
>  * speed up protection code as otherwise we will treat each
>  * pmd (there are a lot of them, as a separate region to protect)
>  */
> static void add_to_pmd_range_list(uint64_t start, uint64_t end)
> {
> 	pmd_range_list[pmd_range_list_index][0] = start;
> 	pmd_range_list[pmd_range_list_index][1] = end;
> 	pmd_range_list_index++;
> }
> 
> void lock_last_pmd_range(void)
> {
> 	if (last_pmd_range[0] == 0 || last_pmd_range[1] == 0)
> 		return;
> 	split_block(last_pmd_range[0]);
> 	mark_range_ro_smc(last_pmd_range[0], last_pmd_range[1],
> 			  KERN_PROT_PAGE_TABLE);
> 	msleep(10);
> }
> 
> /**
>  * prot_pmd_entry - protects a range pointed to by a pmd entry
>  *
>  * @pmd: Pointer to the pmd entry
>  * @addr: Virtual address of the pmd entry
>  */
> static void prot_pmd_entry(pmd_t *pmd, unsigned long addr)
> {
> 	uint64_t pgaddr = pmd_page_vaddr(*pmd);
> 	uint64_t start_range = 0;
> 	uint64_t end_range = 0;
> 
> 	/*
>          * Just found that QCOM's gic_intr_routing.c kernel module is getting
>          * allocated at vaddr ffffffdb87f67000, but modules code region should
>          * only be allocated from ffffffdb8fc00000 to ffffffdc0fdfffff...
>          * 
>          * It seems to be because arm64's module.h defines module_alloc_base as
>          * ((u64)_etext - MODULES_VSIZE) But this module_alloc_base preprocesor
>          * define should be redefined/randomized by kernel/kaslr.c, however, it
>          * appears that early init modules get allocated before
>          * module_alloc_base is relocated, so c'est la vie, and the efforts of
>          * kaslr.c are for naught (_etext's vaddr is randomized though, so it
>          * does not matter, I guess).
>          */
> 	uint64_t module_alloc_start = module_alloc_base_vaddr;
> 	uint64_t module_alloc_end = module_alloc_base_vaddr + SZ_2G;
> 
> 	if (!pmd_present(*pmd) || pmd_bad(*pmd) || pmd_none(*pmd) ||
> 	    !pmd_val(*pmd))
> 		return;
> 
> 	/* Round the starts and ends of each region to their boundary limits */
> 	// module_alloc_start -= (module_alloc_start % PMD_SIZE);
> 	// module_alloc_end += PMD_SIZE - (module_alloc_end % PMD_SIZE) - 1;
> 
> 	start_range = __virt_to_phys(pgaddr);
> 	end_range = __virt_to_phys(pgaddr) + sizeof(pte_t) * PTRS_PER_PMD - 1;
> 
> 	/* If the PMD potentially points to code, check it in the hypervisor */
> 	if (!pmd_leaf(*pmd) &&
> 	    ((addr <= etext_vaddr && (addr + PMD_SIZE - 1) >= stext_vaddr) ||
> 	     (addr <= module_alloc_end &&
> 	      (addr + PMD_SIZE - 1) >= module_alloc_start))) {
> 		if (start_range == last_pmd_range[1] + 1) {
> 			last_pmd_range[1] = end_range;
> 		} else if (end_range + 1 == last_pmd_range[0]) {
> 			last_pmd_range[0] = start_range;
> 		} else if (last_pmd_range[0] == 0 && last_pmd_range[1] == 0) {
> 			last_pmd_range[0] = start_range;
> 			last_pmd_range[1] = end_range;
> 		} else {
> 			add_to_pmd_range_list(last_pmd_range[0],
> 					      last_pmd_range[1]);
> 			lock_last_pmd_range();
> 			last_pmd_range[0] = start_range;
> 			last_pmd_range[1] = end_range;
> 		}
> 		/* If the PMD points to data only, mark it PXN, as the caller will
>                  * mark the PMD immutable after this function returns */
> 	} else {
> 		if (!pmd_leaf(*pmd)) {
> 			set_pmd(pmd, __pmd(pmd_val(*pmd) | PMD_TABLE_PXN));
> 		} else {
> 			/* TODO: if block, ensure range is marked immutable */
> 			pr_info("MotoRKP: pmd block at %llx\n", start_range);
> 		}
> 	}
> }
> 
> pgd_t *swapper_pg_dir_ind;
> void (*set_swapper_pgd_ind)(pgd_t *pgdp, pgd_t pgd);
> 
> static inline bool in_swapper_pgdir_ind(void *addr)
> {
> 	return ((unsigned long)addr & PAGE_MASK) ==
> 	       ((unsigned long)swapper_pg_dir_ind & PAGE_MASK);
> }
> 
> static inline void set_pgd_ind(pgd_t *pgdp, pgd_t pgd)
> {
> 	if (in_swapper_pgdir_ind(pgdp)) {
> 		set_swapper_pgd_ind(pgdp, __pgd(pgd_val(pgd)));
> 		return;
> 	}
> 
> 	WRITE_ONCE(*pgdp, pgd);
> 	dsb(ishst);
> 	isb();
> }
> 
> /**
>  * prot_pgd_entry - protects a range pointed to by a pgd entry
>  * @pgd: pgd struct with descriptor values
>  * @addr: vaddr of start of pgds referenced memory range
>  */
> static int prot_pgd_entry(pgd_t *pgd, unsigned long addr, unsigned long next,
> 			  struct mm_walk *walk)
> {
> 	uint64_t pgaddr = pgd_page_vaddr(*pgd);
> 	uint64_t start_range = 0;
> 	uint64_t end_range = 0;
> 	uint64_t module_alloc_start = module_alloc_base_vaddr;
> 	uint64_t module_alloc_end = module_alloc_base_vaddr + SZ_2G;
> 	uint64_t i = 0;
> 	pmd_t *subdescriptor = 0;
> 	unsigned long subdescriptor_addr = addr;
> 
> 	if (!pgd_present(*pgd) || pgd_bad(*pgd) || pgd_none(*pgd) ||
> 	    !pgd_val(*pgd))
> 		return 0;
> 
> 	/* Round the starts and ends of each region to their boundary limits */
> 	// module_alloc_start -= (module_alloc_start % PGDIR_SIZE);
> 	// module_alloc_end += PGDIR_SIZE - (module_alloc_end % PGDIR_SIZE) - 1;
> 
> 	if (!pgd_leaf(*pgd)) {
> 		start_range = __virt_to_phys(pgaddr);
> 		end_range = __virt_to_phys(pgaddr) +
> 			    sizeof(p4d_t) * PTRS_PER_PGD - 1;
> 
> 		/* If the PGD contains addesses between stext_vaddr and etext_vaddr or
>                  * module_alloc_base and module_alloc_base + SZ_2G, then do not mark it
>                 * PXN */
> 		if ((addr <= etext_vaddr &&
> 		     (addr + PGDIR_SIZE - 1) >= stext_vaddr) ||
> 		    (addr <= module_alloc_end &&
> 		     (addr + PGDIR_SIZE - 1) >= module_alloc_start)) {
> 			/* Protect all second-level PMD entries */
> 			for (i = 0; i < PTRS_PER_PGD; i++) {
> 				subdescriptor =
> 					(pmd_t *)(pgaddr + i * sizeof(pmd_t));
> 				prot_pmd_entry(subdescriptor,
> 					       subdescriptor_addr);
> 				subdescriptor_addr += PMD_SIZE;
> 			}
> 			lock_last_pmd_range();
> 
> 			split_block(start_range);
> 			mark_range_ro_smc(start_range, end_range,
> 					  KERN_PROT_PAGE_TABLE);
> 		} else {
> 			/* Further modifications protected by immutability from hyp_rodata_end to __inittext_begin in kickoff */
> 			set_pgd_ind(pgd, __pgd(pgd_val(*pgd) | 1UL << 59));
> 		}
> 	} else {
> 		/* TODO: Handle block case at this level? */
> 		pr_info("MotoRKP: pgd block at %llx\n", start_range);
> 	}
> 	return 0;
> }
> 
> /*
>  * Locks down the ranges of memory pointed to by all PGDs as read-only.
>  * Current kernel configurations do not bother with p4ds or puds, and
>  * thus we do not need protections for these layers (pgd points directly
>  * to pmd).
>  */
> static const struct mm_walk_ops protect_pgds = {
> 	.pgd_entry = prot_pgd_entry,
> };
> 
> #endif /* _PTPROTECT_H */
> 

