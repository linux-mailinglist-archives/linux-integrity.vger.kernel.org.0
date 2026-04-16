Return-Path: <linux-integrity+bounces-9207-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2I0fKqGp4Gm8kgAAu9opvQ
	(envelope-from <linux-integrity+bounces-9207-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Apr 2026 11:19:29 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA98440C29C
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Apr 2026 11:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 03C823035486
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Apr 2026 09:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B63C38C2A3;
	Thu, 16 Apr 2026 09:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OUBVy2Q8"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731AF39C649
	for <linux-integrity@vger.kernel.org>; Thu, 16 Apr 2026 09:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776331086; cv=none; b=RBGLjNiVtqZCfnRhdhOJu/X9SjAX9ZxbyG/O8swrzdfR1b71PwcgWr2J0BH58u3RRH4fLP/BV9a59Kq8zi+blzmZ1HFOIHLXtFpWNXnpgq0a+sRxUXCWXAOmGyB66YkwSqKgrqCgZgFctBEYzCwGtoH834UPgLE4sdTqGaSLK3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776331086; c=relaxed/simple;
	bh=KYjzfsZfRP1EVprZt1gS9lAU+v5vBSd7s1i8Vazn/p0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Em9qx33i5hDQltF8PqrL4uIikUqvGjonMTq/uGIny08MgqXCxdtWRV5kLd5jdH/w7k7Pb8Jh6VQGpsyIxwbYx9l7cN8TwUw30tK/Ev3ZTK1PCl++N/bVOM2HW16rVM9K4zXoeLXPmLSgMyNe2O0h2iv1Ojr7fj9v6eqUSpXnZRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OUBVy2Q8; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776331083; x=1807867083;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=KYjzfsZfRP1EVprZt1gS9lAU+v5vBSd7s1i8Vazn/p0=;
  b=OUBVy2Q8i8Z4gBuEhZINyDhqfPY5Tv0SFnpU99syNONp9YXG9ALCwZyV
   V5mtGnPGxDA+O9nM29Jl8bdBIZDQvs8wDHAiptIR97E60XoChKX6Te8xx
   IT4vl8B7cwf28GIPtq+/e+O5Vxd6oE7mgWP2MuVbb43/TPPgJjP50/ZI5
   Vvbcqwx4/sLAbWEKClvogUg3iaX62D78pPKvInRdR8+0mTwRxS0kUig8p
   kVZqt4nBVw3ePeiB7oiK1zsWsh60cNc7wSKKAguLPZT/1zKny2wFQzM3M
   b8/95JFXQ8G5Rqg+nWlFmdTLbQbLrGID+9aBTgke3u2OB9xG+cageQnAb
   A==;
X-CSE-ConnectionGUID: C5mqEWiFT4qMJ1n8Ua7SNw==
X-CSE-MsgGUID: N9yuJsLhTXW3q7w37Kyz3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="77233171"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="77233171"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 02:18:02 -0700
X-CSE-ConnectionGUID: dFg1db65T3aTHe6sl053+w==
X-CSE-MsgGUID: w9kkHnQORnmvBFpQpjCFhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="224180071"
Received: from administrator-system-product-name.igk.intel.com ([10.91.214.181])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 02:17:59 -0700
Date: Thu, 16 Apr 2026 11:17:56 +0200 (CEST)
From: =?ISO-8859-2?Q?Micha=B3_Grzelak?= <michal.grzelak@intel.com>
To: Oliver Sang <oliver.sang@intel.com>
cc: Petr Vorel <pvorel@suse.cz>, 
    =?ISO-8859-2?Q?Micha=B3_Grzelak?= <michal.grzelak@intel.com>, 
    lkp@intel.com, intel-gfx@lists.freedesktop.org, 
    Jani Nikula <jani.nikula@linux.intel.com>, oe-lkp@lists.linux.dev, 
    intel-xe@lists.freedesktop.org, ltp@lists.linux.it, 
    linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [LTP] [PATCH v1 15/16] drm/i915/bios: search for VBT #57 by
 default
In-Reply-To: <aeCShTeoW+lmHjHF@xsang-OptiPlex-9020>
Message-ID: <2df6f595-da57-0668-951c-657c5c876333@intel.com>
References: <20260331183332.1773886-16-michal.grzelak@intel.com> <202604150702.d409a2b6-lkp@intel.com> <20260416064051.GA281695@pevik> <aeCShTeoW+lmHjHF@xsang-OptiPlex-9020>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1930980307-1776331080=:85214"
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9207-lists,linux-integrity=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michal.grzelak@intel.com,linux-integrity@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,gitlab.freedesktop.org:url,sashiko.dev:url]
X-Rspamd-Queue-Id: AA98440C29C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1930980307-1776331080=:85214
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT

Hi Petr & Oliver,

On Thu, 16 Apr 2026, Oliver Sang wrote:
> hi, Petr,
>
> On Thu, Apr 16, 2026 at 08:40:51AM +0200, Petr Vorel wrote:
>> Hi all,
>>
>> [ Cc Mimi and linux-integrity ]
>>> Hello,
>>
>>> kernel test robot noticed "BUG:KASAN:slab-out-of-bounds_in_parse_vswing_preemph_snps" on:
>>
>>> commit: 07d1ee54da4966c1457602dc088a8a43b29254cb ("[PATCH v1 15/16] drm/i915/bios: search for VBT #57 by default")
>>> url: https://github.com/intel-lab-lkp/linux/commits/Micha-Grzelak/drm-i915-lt-align-xe3plpd-with-VS-PE-Override-layout/20260401-092928
>>> base: https://gitlab.freedesktop.org/drm/i915/kernel.git for-linux-next
>>> patch link: https://lore.kernel.org/all/20260331183332.1773886-16-michal.grzelak@intel.com/
>>> patch subject: [PATCH v1 15/16] drm/i915/bios: search for VBT #57 by default
>>
>>> in testcase: ltp
>>> version:
>>> with following parameters:
>>
>>> 	test: ima
>>
>>
>>
>>> config: x86_64-rhel-9.4-ltp
>>> compiler: gcc-14
>>> test machine: 22 threads 1 sockets Intel(R) Core(TM) Ultra 9 185H @ 4.5GHz (Meteor Lake) with 32G memory
>>
>>> (please refer to attached dmesg/kmsg for entire log/backtrace)
>>
>>
>>
>>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>>> the same patch/commit), kindly add following tags
>>> | Reported-by: kernel test robot <oliver.sang@intel.com>
>>> | Closes: https://lore.kernel.org/oe-lkp/202604150702.d409a2b6-lkp@intel.com
>>
>>
>>> The kernel config and materials to reproduce are available at:
>>> https://download.01.org/0day-ci/archive/20260415/202604150702.d409a2b6-lkp@intel.com
>>
>>
>>> kern  :err   : [   27.966990] [    T399] ==================================================================
>>> kern  :err   : [   27.968126] [    T399] BUG: KASAN: slab-out-of-bounds in parse_vswing_preemph_snps+0x2dd/0x430 [i915]
>>> kern  :err   : [   27.969712] [    T399] Read of size 4 at addr ffff8881eba2c49d by task (udev-worker)/399
>>
>>> kern  :err   : [   27.971135] [    T399] CPU: 4 UID: 0 PID: 399 Comm: (udev-worker) Tainted: G S                  7.0.0-rc4-01496-g07d1ee54da49 #1 PREEMPT(lazy)
>>> kern  :err   : [   27.971139] [    T399] Tainted: [S]=CPU_OUT_OF_SPEC
>>> kern  :err   : [   27.971140] [    T399] Hardware name: ASUSTeK COMPUTER INC. NUC14RVS-B/NUC14RVSU9, BIOS RVMTL357.0047.2025.0108.1408 01/08/2025
>>> kern  :err   : [   27.971142] [    T399] Call Trace:
>>> kern  :err   : [   27.971144] [    T399]  <TASK>
>>> kern  :err   : [   27.971145] [    T399]  dump_stack_lvl+0x47/0x70
>>> kern  :err   : [   27.971152] [    T399]  print_address_description+0x88/0x320
>>> kern  :err   : [   27.971156] [    T399]  ? parse_vswing_preemph_snps+0x2dd/0x430 [i915]
>>> kern  :err   : [   27.971355] [    T399]  print_report+0x106/0x1f4
>>> kern  :err   : [   27.971357] [    T399]  ? __virt_addr_valid+0xc4/0x230
>>> kern  :err   : [   27.971360] [    T399]  ? parse_vswing_preemph_snps+0x2dd/0x430 [i915]
>>> kern  :err   : [   27.971533] [    T399]  kasan_report+0xb5/0xf0
>>> kern  :err   : [   27.971537] [    T399]  ? parse_vswing_preemph_snps+0x2dd/0x430 [i915]
>>> kern  :err   : [   27.971704] [    T399]  parse_vswing_preemph_snps+0x2dd/0x430 [i915]
>>> kern  :err   : [   27.971868] [    T399]  intel_bios_init+0xcc1/0x14b0 [i915]
>>> kern  :err   : [   27.972042] [    T399]  ? drm_vblank_init+0x147/0x330 [drm]
>>> kern  :err   : [   27.972105] [    T399]  intel_display_driver_probe_noirq+0x8d/0x870 [i915]
>>> kern  :err   : [   27.972295] [    T399]  i915_driver_probe+0x209/0x9f0 [i915]
>>> kern  :err   : [   27.972445] [    T399]  ? __pfx_mutex_lock+0x10/0x10
>>> kern  :err   : [   27.972450] [    T399]  ? mutex_lock+0x91/0xf0
>>> kern  :err   : [   27.972451] [    T399]  ? __pfx_i915_driver_probe+0x10/0x10 [i915]
>>> kern  :err   : [   27.972597] [    T399]  ? drm_privacy_screen_get+0x2bf/0x370 [drm]
>>> kern  :err   : [   27.972628] [    T399]  ? intel_display_driver_probe_defer+0x41/0x70 [i915]
>>> kern  :err   : [   27.972814] [    T399]  ? i915_pci_probe+0x2ab/0x3b0 [i915]
>>> kern  :err   : [   27.972963] [    T399]  ? __pfx_i915_pci_probe+0x10/0x10 [i915]
>>> kern  :err   : [   27.973110] [    T399]  local_pci_probe+0xdb/0x1b0
>>> kern  :err   : [   27.973114] [    T399]  pci_call_probe+0x153/0x4f0
>>> kern  :err   : [   27.973116] [    T399]  ? __pfx_pci_call_probe+0x10/0x10
>>> kern  :err   : [   27.973117] [    T399]  ? __pfx__raw_spin_lock+0x10/0x10
>>> kern  :err   : [   27.973119] [    T399]  ? pci_assign_irq+0x80/0x2f0
>>> kern  :err   : [   27.973121] [    T399]  ? pci_match_device+0x38d/0x6b0
>>> kern  :err   : [   27.973123] [    T399]  ? kernfs_create_link+0x164/0x230
>>> kern  :err   : [   27.973127] [    T399]  pci_device_probe+0x173/0x2f0
>>> kern  :err   : [   27.973128] [    T399]  call_driver_probe+0x62/0x1f0
>>> kern  :err   : [   27.973132] [    T399]  really_probe+0x197/0x770
>>> kern  :err   : [   27.973134] [    T399]  __driver_probe_device+0x18c/0x3b0
>>> kern  :err   : [   27.973137] [    T399]  driver_probe_device+0x4a/0x130
>>> kern  :err   : [   27.973139] [    T399]  __driver_attach+0x18c/0x4f0
>>> kern  :err   : [   27.973141] [    T399]  ? __pfx___driver_attach+0x10/0x10
>>> kern  :err   : [   27.973143] [    T399]  bus_for_each_dev+0xef/0x170
>>> kern  :err   : [   27.973145] [    T399]  ? kasan_unpoison+0x40/0x70
>>> kern  :err   : [   27.973147] [    T399]  ? __pfx_bus_for_each_dev+0x10/0x10
>>> kern  :err   : [   27.973149] [    T399]  ? __kasan_slab_alloc+0x2f/0x70
>>> kern  :err   : [   27.973152] [    T399]  ? klist_add_tail+0x132/0x270
>>> kern  :err   : [   27.973154] [    T399]  bus_add_driver+0x2a7/0x4f0
>>> kern  :err   : [   27.973156] [    T399]  driver_register+0x1a1/0x370
>>> kern  :err   : [   27.973158] [    T399]  i915_init+0x57/0x160 [i915]
>>> kern  :err   : [   27.973307] [    T399]  ? __pfx_i915_init+0x10/0x10 [i915]
>>> kern  :err   : [   27.973453] [    T399]  do_one_initcall+0x8d/0x3f0
>>> kern  :err   : [   27.973455] [    T399]  ? __pfx_do_one_initcall+0x10/0x10
>>> kern  :err   : [   27.973457] [    T399]  ? kasan_unpoison+0x3b/0x70
>>> kern  :err   : [   27.973458] [    T399]  ? kasan_unpoison+0x40/0x70
>>> kern  :err   : [   27.973460] [    T399]  do_init_module+0x281/0x830
>>> kern  :err   : [   27.973463] [    T399]  ? __pfx_do_init_module+0x10/0x10
>>> kern  :err   : [   27.973464] [    T399]  ? kfree+0x195/0x430
>>> kern  :err   : [   27.973467] [    T399]  load_module+0x173d/0x2070
>>> kern  :err   : [   27.973469] [    T399]  ? ima_post_read_file+0x18f/0x230
>>
>> I'm surprised, but indeed it's could be triggered by IMA.
>>
>> Looking at full dmesg [1] I'm surprised that this is triggered before tests are
>> actually run and there is no IMA specific kernel command line parameter. That
>> means that error is not related to any LTP test.
>>
>> Is it always reproducible or just a random glitch?
>
> in our tests, it's quite persistent and clean on parent:

I haven't reproduced it myself, but this issue seems somewhat related
with issue observed earlier by CI [1]. I would expect it to not be a
random glitch but a true bug related to the series.

In previous versions of the series, during parsing there was a
unfortunate snippet of:

+	const u32 *tables = block->tables;
+	size_t offset = 0;
+	size_t row_width;
+	const u32 *vals;
+
+	row_width = block->num_columns * sizeof(*tables);
+
+	for (int idx = 0; idx < block->num_tables; idx++) {
+		for (int row = 0; row < num_rows; row++) {
+			vals = &tables[offset];
[...]
+			offset += row_width;
+		}
+	}

Which caused hopping by 4 times more bytes than it should, because the
sizeof() wasn't meant to be there. Since parsing takes place at module
load, looks like it could be the issue. This seems especially convincing
given that report is from parse_vswing_preemph_snps(). I have to also
admit that it would be consistent with review comment from Sashiko [2].

Lastly, sadly due to poorly split commits, 15th patch from v1 turned on
whole VBT #57 searching. This probably caused bisect to point at 15th
patch instead of pointing at patch adding parsing code, which would
clearly show that patch/es introduce/s the bug.

Anyways, now the bug should be fixed in v2 [3].

[1] https://intel-gfx-ci.01.org/tree/drm-tip/Patchwork_164196v1/fi-hsw-4770/dmesg0.txt 
[2] https://sashiko.dev/#/patchset/20260331183332.1773886-1-michal.grzelak%40intel.com?part=5 
[3] https://lore.kernel.org/intel-gfx/20260415234639.3577774-21-michal.grzelak@intel.com/

BR,
Micha³

> =========================================================================================
> tbox_group/testcase/rootfs/kconfig/compiler/test:
>  igk-mtl-nuc02/ltp/debian-13-x86_64-20250902.cgz/x86_64-rhel-9.4-ltp/gcc-14/ima
>
> e3d53a63657f3213 07d1ee54da4966c1457602dc088
> ---------------- ---------------------------
>       fail:runs  %reproduction    fail:runs
>           |             |             |
>           :6          100%           6:6     dmesg.BUG:KASAN:slab-out-of-bounds_in_parse_vswing_preemph_snps
>
>
>>
>> ima_post_read_file() is a part of IMA core therefore issue might be not related
>> to any config, but just FYI kernel config [2].
>>
>> Kind regards,
>> Petr
>>
>> [1] https://download.01.org/0day-ci/archive/20260415/202604150702.d409a2b6-lkp@intel.com/kmsg.xz
>> [2] https://download.01.org/0day-ci/archive/20260415/202604150702.d409a2b6-lkp@intel.com/config-7.0.0-rc4-01496-g07d1ee54da49
>>
>>> kern  :err   : [   27.973474] [    T399]  ? __pfx_load_module+0x10/0x10
>>> kern  :err   : [   27.973476] [    T399]  ? security_kernel_post_read_file+0x35/0xf0
>>> kern  :err   : [   27.973479] [    T399]  ? __pfx_kernel_read_file+0x10/0x10
>>> kern  :err   : [   27.973483] [    T399]  ? __pfx_current_time+0x10/0x10
>>> kern  :err   : [   27.973486] [    T399]  ? init_module_from_file+0x157/0x1b0
>>> kern  :err   : [   27.973487] [    T399]  init_module_from_file+0x157/0x1b0
>>> kern  :err   : [   27.973489] [    T399]  ? __pfx_init_module_from_file+0x10/0x10
>>> kern  :err   : [   27.973491] [    T399]  ? touch_atime+0x1bc/0x4f0
>>> kern  :err   : [   27.973493] [    T399]  ? _raw_spin_lock+0x80/0xf0
>>> kern  :err   : [   27.973494] [    T399]  ? __pfx__raw_spin_lock+0x10/0x10
>>> kern  :err   : [   27.973496] [    T399]  ? __pfx_filemap_read+0x10/0x10
>>> kern  :err   : [   27.973498] [    T399]  ? do_sys_openat2+0xeb/0x170
>>> kern  :err   : [   27.973501] [    T399]  idempotent_init_module+0x21c/0x770
>>> kern  :err   : [   27.973503] [    T399]  ? __pfx_idempotent_init_module+0x10/0x10
>>> kern  :err   : [   27.973505] [    T399]  ? fdget+0x54/0x3b0
>>> kern  :err   : [   27.973506] [    T399]  ? security_capable+0x35/0xf0
>>> kern  :err   : [   27.973509] [    T399]  __x64_sys_finit_module+0xca/0x170
>>> kern  :err   : [   27.973511] [    T399]  do_syscall_64+0x108/0x5b0
>>> kern  :err   : [   27.973513] [    T399]  ? vfs_read+0x3be/0x9b0
>>> kern  :err   : [   27.973514] [    T399]  ? vfs_read+0x3be/0x9b0
>>> kern  :err   : [   27.973516] [    T399]  ? __pfx_vfs_read+0x10/0x10
>>> kern  :err   : [   27.973517] [    T399]  ? __pfx__raw_spin_lock+0x10/0x10
>>> kern  :err   : [   27.973519] [    T399]  ? fdget+0x54/0x3b0
>>> kern  :err   : [   27.973520] [    T399]  ? __pfx___seccomp_filter+0x10/0x10
>>> kern  :err   : [   27.973523] [    T399]  ? __x64_sys_pread64+0x18d/0x1f0
>>> kern  :err   : [   27.973525] [    T399]  ? __pfx___x64_sys_pread64+0x10/0x10
>>> kern  :err   : [   27.973526] [    T399]  ? fdget+0x54/0x3b0
>>> kern  :err   : [   27.973528] [    T399]  ? security_capable+0x35/0xf0
>>> kern  :err   : [   27.973530] [    T399]  ? do_syscall_64+0x140/0x5b0
>>> kern  :err   : [   27.973531] [    T399]  ? arch_exit_to_user_mode_prepare+0x9e/0xf0
>>> kern  :err   : [   27.973533] [    T399]  ? do_syscall_64+0x140/0x5b0
>>> kern  :err   : [   27.973534] [    T399]  ? __x64_sys_openat+0x104/0x1f0
>>> kern  :err   : [   27.973536] [    T399]  ? __pfx___x64_sys_openat+0x10/0x10
>>> kern  :err   : [   27.973538] [    T399]  ? do_syscall_64+0x140/0x5b0
>>> kern  :err   : [   27.973540] [    T399]  ? do_syscall_64+0x140/0x5b0
>>> kern  :err   : [   27.973541] [    T399]  ? irqentry_exit+0x76/0x4f0
>>> kern  :err   : [   27.973544] [    T399]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>> kern  :err   : [   27.973546] [    T399] RIP: 0033:0x7f3689aa8779
>>> kern  :err   : [   27.973549] [    T399] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 67 76 0d 00 f7 d8 64 89 01 48
>>> kern  :err   : [   27.973551] [    T399] RSP: 002b:00007ffca3326338 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
>>> kern  :err   : [   27.973555] [    T399] RAX: ffffffffffffffda RBX: 000055c94afdd3e0 RCX: 00007f3689aa8779
>>> kern  :err   : [   27.973556] [    T399] RDX: 0000000000000000 RSI: 00007f36882ae44d RDI: 0000000000000053
>>> kern  :err   : [   27.973557] [    T399] RBP: 0000000000000000 R08: 0000000000000000 R09: 000055c94af65b30
>>> kern  :err   : [   27.973558] [    T399] R10: 0000000000000000 R11: 0000000000000246 R12: 00007f36882ae44d
>>> kern  :err   : [   27.973559] [    T399] R13: 0000000000020000 R14: 000055c94afb65f0 R15: 0000000000000000
>>> kern  :err   : [   27.973561] [    T399]  </TASK>
>>
>>> kern  :err   : [   28.051757] [    T399] Allocated by task 399:
>>> kern  :warn  : [   28.052350] [    T399]  kasan_save_stack+0x1e/0x70
>>> kern  :warn  : [   28.053001] [    T399]  kasan_save_track+0x10/0x30
>>> kern  :warn  : [   28.053646] [    T399]  __kasan_kmalloc+0x8b/0xb0
>>> kern  :warn  : [   28.054278] [    T399]  __kmalloc_noprof+0x1d8/0x5f0
>>> kern  :warn  : [   28.054944] [    T399]  init_bdb_block+0x128/0xc30 [i915]
>>> kern  :warn  : [   28.055915] [    T399]  intel_bios_init+0x4de/0x14b0 [i915]
>>> kern  :warn  : [   28.056854] [    T399]  intel_display_driver_probe_noirq+0x8d/0x870 [i915]
>>> kern  :warn  : [   28.057984] [    T399]  i915_driver_probe+0x209/0x9f0 [i915]
>>> kern  :warn  : [   28.058917] [    T399]  local_pci_probe+0xdb/0x1b0
>>> kern  :warn  : [   28.059565] [    T399]  pci_call_probe+0x153/0x4f0
>>> kern  :warn  : [   28.060210] [    T399]  pci_device_probe+0x173/0x2f0
>>> kern  :warn  : [   28.060878] [    T399]  call_driver_probe+0x62/0x1f0
>>> kern  :warn  : [   28.061547] [    T399]  really_probe+0x197/0x770
>>> kern  :warn  : [   28.062168] [    T399]  __driver_probe_device+0x18c/0x3b0
>>> kern  :warn  : [   28.062894] [    T399]  driver_probe_device+0x4a/0x130
>>> kern  :warn  : [   28.063587] [    T399]  __driver_attach+0x18c/0x4f0
>>> kern  :warn  : [   28.064243] [    T399]  bus_for_each_dev+0xef/0x170
>>> kern  :warn  : [   28.064898] [    T399]  bus_add_driver+0x2a7/0x4f0
>>> kern  :warn  : [   28.065543] [    T399]  driver_register+0x1a1/0x370
>>> kern  :warn  : [   28.066202] [    T399]  i915_init+0x57/0x160 [i915]
>>> kern  :warn  : [   28.067030] [    T399]  do_one_initcall+0x8d/0x3f0
>>> kern  :warn  : [   28.067677] [    T399]  do_init_module+0x281/0x830
>>> kern  :warn  : [   28.068320] [    T399]  load_module+0x173d/0x2070
>>> kern  :warn  : [   28.068951] [    T399]  init_module_from_file+0x157/0x1b0
>>> kern  :warn  : [   28.069678] [    T399]  idempotent_init_module+0x21c/0x770
>>> kern  :warn  : [   28.070417] [    T399]  __x64_sys_finit_module+0xca/0x170
>>> kern  :warn  : [   28.071143] [    T399]  do_syscall_64+0x108/0x5b0
>>> kern  :warn  : [   28.071777] [    T399]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>
>>> kern  :err   : [   28.072915] [    T399] The buggy address belongs to the object at ffff8881eba2c000
>>>                                           which belongs to the cache kmalloc-2k of size 2048
>>> kern  :err   : [   28.074832] [    T399] The buggy address is located 0 bytes to the right of
>>>                                           allocated 1181-byte region [ffff8881eba2c000, ffff8881eba2c49d)
>>
>>> kern  :err   : [   28.077135] [    T399] The buggy address belongs to the physical page:
>>> kern  :warn  : [   28.078017] [    T399] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1eba28
>>> kern  :warn  : [   28.079226] [    T399] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
>>> kern  :warn  : [   28.080389] [    T399] flags: 0x17ffffc0000040(head|node=0|zone=2|lastcpupid=0x1fffff)
>>> kern  :warn  : [   28.081460] [    T399] page_type: f5(slab)
>>> kern  :warn  : [   28.082008] [    T399] raw: 0017ffffc0000040 ffff888100042f00 dead000000000100 dead000000000122
>>> kern  :warn  : [   28.083180] [    T399] raw: 0000000000000000 0000000800080008 00000000f5000000 0000000000000000
>>> kern  :warn  : [   28.084355] [    T399] head: 0017ffffc0000040 ffff888100042f00 dead000000000100 dead000000000122
>>> kern  :warn  : [   28.085541] [    T399] head: 0000000000000000 0000000800080008 00000000f5000000 0000000000000000
>>> kern  :warn  : [   28.086725] [    T399] head: 0017ffffc0000003 ffffea0007ae8a01 00000000ffffffff 00000000ffffffff
>>> kern  :warn  : [   28.087909] [    T399] head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
>>> kern  :warn  : [   28.089093] [    T399] page dumped because: kasan: bad access detected
>>
>>> kern  :err   : [   28.090297] [    T399] Memory state around the buggy address:
>>> kern  :err   : [   28.091073] [    T399]  ffff8881eba2c380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>> kern  :err   : [   28.092175] [    T399]  ffff8881eba2c400: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>> kern  :err   : [   28.093276] [    T399] >ffff8881eba2c480: 00 00 00 05 fc fc fc fc fc fc fc fc fc fc fc fc
>>> kern  :err   : [   28.094376] [    T399]                             ^
>>> kern  :err   : [   28.095041] [    T399]  ffff8881eba2c500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>>> kern  :err   : [   28.096145] [    T399]  ffff8881eba2c580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>>> kern  :err   : [   28.097247] [    T399] ==================================================================
>>> kern  :warn  : [   28.098668] [    T399] Disabling lock debugging due to kernel taint
>
--8323329-1930980307-1776331080=:85214--

