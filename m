Return-Path: <linux-integrity+bounces-7774-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0291C9D762
	for <lists+linux-integrity@lfdr.de>; Wed, 03 Dec 2025 01:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F2683A2BFE
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Dec 2025 00:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B832970830;
	Wed,  3 Dec 2025 00:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GiQz+eWj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610B13A1B5;
	Wed,  3 Dec 2025 00:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764723439; cv=none; b=UNnwBYCD9k/7JmT4I1EB/xcLA4WYw/eZXP6U7DZbcWaK7Kb2b7Bru+PQsOdeU7d6Cm5CUeJza6EWJOG3yXtMj7NOs9DNRXU2uLmjJLvolRLqAriJhufcmteEJz7CgDNHJxwqHUC7NTFxpCck32XhNBUzFhs7LQ/cm5TR5+5B4uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764723439; c=relaxed/simple;
	bh=Ob8tr06ujdtWwwMzaNBPkuVP/cjGVH9UXyg0tMDcluw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fzcDENtOrvBS7aLfefjOq1pNSxw2FoWCQlBYDAT8VoYOMsd30N+W4giMUjnYfhOcDXNYna2jUGME09qqdKyhjRKAOUcC6lfw9lk1YRwgc98vlqRe/GNS4LV+xAjG7Z2kuFNEaZHnnH0sEVFmdcYFkbwexpl4qiCSRrza/YethH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GiQz+eWj; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764723437; x=1796259437;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ob8tr06ujdtWwwMzaNBPkuVP/cjGVH9UXyg0tMDcluw=;
  b=GiQz+eWj/+FIqz3bs21WmKltekP/ZTkIUwLWeOAnkrDF+ZZR0d7ChUZ9
   GmvSFKx5LUcAuZTN+T4Tev8y+vrd4ohRgK/UfNTTYcoXJ9UNhZ0TbeN+z
   T4ji9dXdzidGxifYgmflc4ufEei6MSShD/q9u4v0gF9wRKlRlqiFsR6Wd
   ployY9hurCT+2pEJKK479r71CWVQ1KB9shTw1NKv7np+CyuZgfkITfFg+
   z1qduSBGyUTjzsEENH5hU9iWwfPnYupDok7TbP/WnENDflgVSsZSLjoLb
   5Ogx+4Wz2WugizofRzNsjCYLndh0nz54j2aG4dMerBeeFtUvhx74+emo9
   w==;
X-CSE-ConnectionGUID: wuQPs7moQ0mJ+pd+MiixeA==
X-CSE-MsgGUID: w6CjD64YQyOtTu5djy0lLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="70566500"
X-IronPort-AV: E=Sophos;i="6.20,244,1758610800"; 
   d="scan'208";a="70566500"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 16:57:17 -0800
X-CSE-ConnectionGUID: o+Hxg8hVQVyJOPCiT0lBpg==
X-CSE-MsgGUID: XiMYOkUMTyCp8NnkUGQFxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,244,1758610800"; 
   d="scan'208";a="199476074"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.182.64])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 16:57:13 -0800
Date: Wed, 3 Dec 2025 08:57:10 +0800
From: "Lai, Yi" <yi1.lai@linux.intel.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, ross.philipson@oracle.com,
	Jonathan McDowell <noodles@earth.li>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Jonathan McDowell <noodles@meta.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org, yi1.lai@intel.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH v7 01/11] tpm: Cap the number of PCR banks
Message-ID: <aS+K5nO2MP7N+kxQ@ly-workstation>
References: <20251127135445.2141241-1-jarkko@kernel.org>
 <20251127135445.2141241-2-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251127135445.2141241-2-jarkko@kernel.org>

On Thu, Nov 27, 2025 at 03:54:33PM +0200, Jarkko Sakkinen wrote:
> From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> 
> tpm2_get_pcr_allocation() does not cap any upper limit for the number of
> banks. Cap the limit to eight banks so that out of bounds values coming
> from external I/O cause on only limited harm.
> 
> Cc: Roberto Sassu <roberto.sassu@huawei.com>
> Fixes: bcfff8384f6c ("tpm: dynamically allocate the allocated_banks array")
> Reviewed-By: Jonathan McDowell <noodles@meta.com>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> ---
> v7:
> - In Ryzen desktop there is total three banks so yep, eight is probably
>   much safer bet than four banks. Fixed the commit message as per remark
>   from Jonathan:
> 
>   https://lore.kernel.org/linux-integrity/aPYg1N0TvrkG6AJI@earth.li/#t
> 
>   And with that added also reviewed-by.
> v6
> - No changes.
> v5:
> - No changes.
> v4:
> - Revert spurious changes from include/linux/tpm.h.
> - Increase TPM2_MAX_BANKS to 8.
> - Rename TPM2_MAX_BANKS as TPM2_MAX_PCR_BANKS for the sake of clarity.
> v3:
> - Wrote a more clear commit message.
> - Fixed pr_err() message.
> v2:
> - A new patch.
> ---
>  drivers/char/tpm/tpm-chip.c | 13 +++++++++----
>  drivers/char/tpm/tpm.h      |  1 -
>  drivers/char/tpm/tpm1-cmd.c | 25 -------------------------
>  drivers/char/tpm/tpm2-cmd.c |  8 +++-----
>  include/linux/tpm.h         |  8 +++++---
>  5 files changed, 17 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index e25daf2396d3..6cb25862688f 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -559,14 +559,19 @@ static int tpm_add_hwrng(struct tpm_chip *chip)
>  
>  static int tpm_get_pcr_allocation(struct tpm_chip *chip)
>  {
> -	int rc;
> +	int rc = 0;
>  
>  	if (tpm_is_firmware_upgrade(chip))
>  		return 0;
>  
> -	rc = (chip->flags & TPM_CHIP_FLAG_TPM2) ?
> -	     tpm2_get_pcr_allocation(chip) :
> -	     tpm1_get_pcr_allocation(chip);
> +	if (!(chip->flags & TPM_CHIP_FLAG_TPM2)) {
> +		chip->allocated_banks[0].alg_id = TPM_ALG_SHA1;
> +		chip->allocated_banks[0].digest_size = hash_digest_size[HASH_ALGO_SHA1];
> +		chip->allocated_banks[0].crypto_id = HASH_ALGO_SHA1;
> +		chip->nr_allocated_banks = 1;
> +	} else {
> +		rc = tpm2_get_pcr_allocation(chip);
> +	}
>  
>  	if (rc > 0)
>  		return -ENODEV;
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 2726bd38e5ac..a37712c02e44 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -252,7 +252,6 @@ int tpm1_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf);
>  ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
>  		    const char *desc, size_t min_cap_length);
>  int tpm1_get_random(struct tpm_chip *chip, u8 *out, size_t max);
> -int tpm1_get_pcr_allocation(struct tpm_chip *chip);
>  unsigned long tpm_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
>  int tpm_pm_suspend(struct device *dev);
>  int tpm_pm_resume(struct device *dev);
> diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
> index 11088bda4e68..708bc553437b 100644
> --- a/drivers/char/tpm/tpm1-cmd.c
> +++ b/drivers/char/tpm/tpm1-cmd.c
> @@ -786,28 +786,3 @@ int tpm1_pm_suspend(struct tpm_chip *chip, u32 tpm_suspend_pcr)
>  
>  	return rc;
>  }
> -
> -/**
> - * tpm1_get_pcr_allocation() - initialize the allocated bank
> - * @chip: TPM chip to use.
> - *
> - * The function initializes the SHA1 allocated bank to extend PCR
> - *
> - * Return:
> - * * 0 on success,
> - * * < 0 on error.
> - */
> -int tpm1_get_pcr_allocation(struct tpm_chip *chip)
> -{
> -	chip->allocated_banks = kcalloc(1, sizeof(*chip->allocated_banks),
> -					GFP_KERNEL);
> -	if (!chip->allocated_banks)
> -		return -ENOMEM;
> -
> -	chip->allocated_banks[0].alg_id = TPM_ALG_SHA1;
> -	chip->allocated_banks[0].digest_size = hash_digest_size[HASH_ALGO_SHA1];
> -	chip->allocated_banks[0].crypto_id = HASH_ALGO_SHA1;
> -	chip->nr_allocated_banks = 1;
> -
> -	return 0;
> -}
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index 7d77f6fbc152..97501c567c34 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -538,11 +538,9 @@ ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
>  
>  	nr_possible_banks = be32_to_cpup(
>  		(__be32 *)&buf.data[TPM_HEADER_SIZE + 5]);
> -
> -	chip->allocated_banks = kcalloc(nr_possible_banks,
> -					sizeof(*chip->allocated_banks),
> -					GFP_KERNEL);
> -	if (!chip->allocated_banks) {
> +	if (nr_possible_banks > TPM2_MAX_PCR_BANKS) {
> +		pr_err("tpm: unexpected number of banks: %u > %u",
> +		       nr_possible_banks, TPM2_MAX_PCR_BANKS);
>  		rc = -ENOMEM;
>  		goto out;
>  	}
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index dc0338a783f3..eb0ff071bcae 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -26,7 +26,9 @@
>  #include <crypto/aes.h>
>  
>  #define TPM_DIGEST_SIZE 20	/* Max TPM v1.2 PCR size */
> -#define TPM_MAX_DIGEST_SIZE SHA512_DIGEST_SIZE
> +
> +#define TPM2_MAX_DIGEST_SIZE	SHA512_DIGEST_SIZE
> +#define TPM2_MAX_PCR_BANKS	8
>  
>  struct tpm_chip;
>  struct trusted_key_payload;
> @@ -68,7 +70,7 @@ enum tpm2_curves {
>  
>  struct tpm_digest {
>  	u16 alg_id;
> -	u8 digest[TPM_MAX_DIGEST_SIZE];
> +	u8 digest[TPM2_MAX_DIGEST_SIZE];
>  } __packed;
>  
>  struct tpm_bank_info {
> @@ -189,7 +191,7 @@ struct tpm_chip {
>  	unsigned int groups_cnt;
>  
>  	u32 nr_allocated_banks;
> -	struct tpm_bank_info *allocated_banks;
> +	struct tpm_bank_info allocated_banks[TPM2_MAX_PCR_BANKS];
>  #ifdef CONFIG_ACPI
>  	acpi_handle acpi_dev_handle;
>  	char ppi_version[TPM_PPI_VERSION_LEN + 1];
> -- 
> 2.52.0
>

Hi Jarkko Sakkinen,

Greetings!

I used Syzkaller and found that there is KASAN: invalid-free in tpm_dev_release in linux-tpmdd branch tpmdd-next-6.19-rc1-v3.

After bisection and the first bad commit is:
"
83f6ace27d21 tpm: Cap the number of PCR banks
"

All detailed into can be found at:
https://github.com/laifryiee/syzkaller_logs/tree/main/251202_193851_tpm_dev_release
Syzkaller repro code:
https://github.com/laifryiee/syzkaller_logs/tree/main/251202_193851_tpm_dev_release/repro.c
Syzkaller repro syscall steps:
https://github.com/laifryiee/syzkaller_logs/tree/main/251202_193851_tpm_dev_release/repro.prog
Syzkaller report:
https://github.com/laifryiee/syzkaller_logs/tree/main/251202_193851_tpm_dev_release/repro.report
Kconfig(make olddefconfig):
https://github.com/laifryiee/syzkaller_logs/tree/main/251202_193851_tpm_dev_release/kconfig_origin
Bisect info:
https://github.com/laifryiee/syzkaller_logs/tree/main/251202_193851_tpm_dev_release/bisect_info.log
bzImage:
https://github.com/laifryiee/syzkaller_logs/raw/refs/heads/main/251202_193851_tpm_dev_release/bzImage_tpmdd-next-6.19-rc1-v3
Issue dmesg:
https://github.com/laifryiee/syzkaller_logs/blob/main/251202_193851_tpm_dev_release/tpmdd-next-6.19-rc1-v3_dmesg.log

"
[   18.405712] ==================================================================
[   18.406210] BUG: KASAN: invalid-free in tpm_dev_release+0xdc/0x110
[   18.406657] Free of addr ff11000011572d38 by task repro/729
[   18.407037]
[   18.407156] CPU: 1 UID: 0 PID: 729 Comm: repro Not tainted 6.18.0-tpmdd-next-6+ #1 PREEMPT(voluntary)
[   18.407167] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.q4
[   18.407173] Call Trace:
[   18.407177]  <TASK>
[   18.407180]  dump_stack_lvl+0xea/0x150
[   18.407197]  print_report+0xce/0x610
[   18.407210]  ? kasan_complete_mode_report_info+0x40/0x200
[   18.407220]  ? tpm_dev_release+0xdc/0x110
[   18.407232]  kasan_report_invalid_free+0xa7/0xd0
[   18.407245]  ? tpm_dev_release+0xdc/0x110
[   18.407259]  ? tpm_dev_release+0xdc/0x110
[   18.407271]  check_slab_allocation+0x128/0x140
[   18.407281]  __kasan_slab_pre_free+0xd/0x20
[   18.407291]  kfree+0x119/0x620
[   18.407300]  ? tpm_dev_release+0xdc/0x110
[   18.407311]  ? do_wait_intr_irq+0x1e0/0x230
[   18.407326]  ? __pfx_tpm_dev_release+0x10/0x10
[   18.407340]  tpm_dev_release+0xdc/0x110
[   18.407351]  ? tpm_dev_release+0xdc/0x110
[   18.407363]  device_release+0xb6/0x260
[   18.407374]  kobject_put+0x22d/0x550
[   18.407383]  put_device+0x29/0x40
[   18.407391]  vtpm_proxy_fops_release+0x152/0x1e0
[   18.407403]  ? __pfx_vtpm_proxy_fops_release+0x10/0x10
[   18.407412]  __fput+0x41f/0xb70
[   18.407435]  ____fput+0x22/0x30
[   18.407449]  task_work_run+0x19e/0x2b0
[   18.407467]  ? __pfx_task_work_run+0x10/0x10
[   18.407480]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[   18.407490]  ? switch_task_namespaces+0xdd/0x130
[   18.407502]  do_exit+0x893/0x28c0
[   18.407519]  ? do_group_exit+0x1d8/0x2c0
[   18.407532]  ? __pfx_do_exit+0x10/0x10
[   18.407545]  ? __this_cpu_preempt_check+0x21/0x30
[   18.407555]  ? _raw_spin_unlock_irq+0x2c/0x60
[   18.407571]  ? lockdep_hardirqs_on+0x89/0x110
[   18.407589]  do_group_exit+0xe4/0x2c0
[   18.407602]  __x64_sys_exit_group+0x4d/0x60
[   18.407615]  x64_sys_call+0x21a2/0x21b0
[   18.407627]  do_syscall_64+0x6d/0x450
[   18.407641]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   18.407650] RIP: 0033:0x7f1331118a4d
[   18.407658] Code: Unable to access opcode bytes at 0x7f1331118a23.
[   18.407662] RSP: 002b:00007ffec868c668 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
[   18.407671] RAX: ffffffffffffffda RBX: 00007f13311f69e0 RCX: 00007f1331118a4d
[   18.407677] RDX: 00000000000000e7 RSI: ffffffffffffff80 RDI: 0000000000000000
[   18.407683] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000020
[   18.407688] R10: 00007ffec868c510 R11: 0000000000000246 R12: 00007f13311f69e0
[   18.407694] R13: 00007f13311fbf00 R14: 0000000000000001 R15: 00007f13311fbee8
[   18.407707]  </TASK>
[   18.407710]
[   18.423610] Allocated by task 729:
[   18.423853]  kasan_save_stack+0x2c/0x60
[   18.424122]  kasan_save_track+0x18/0x40
[   18.424392]  kasan_save_alloc_info+0x3c/0x50
[   18.424690]  __kasan_kmalloc+0x88/0xa0
[   18.424954]  __kmalloc_cache_noprof+0x2b1/0x840
[   18.425271]  tpm_chip_alloc+0x56/0x4c0
[   18.425540]  vtpmx_fops_ioctl+0x2d0/0x830
[   18.425819]  __x64_sys_ioctl+0x1bf/0x220
[   18.426100]  x64_sys_call+0x1280/0x21b0
[   18.426366]  do_syscall_64+0x6d/0x450
[   18.426630]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   18.426980]
[   18.427098] The buggy address belongs to the object at ff11000011572000
[   18.427098]  which belongs to the cache kmalloc-4k of size 4096
[   18.427931] The buggy address is located 3384 bytes inside of
[   18.427931]  3528-byte region [ff11000011572000, ff11000011572dc8)
[   18.428720]
[   18.428836] The buggy address belongs to the physical page:
[   18.429210] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x11570
[   18.429744] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[   18.430258] anon flags: 0xfffffc0000040(head|node=0|zone=1|lastcpupid=0x1fffff)
[   18.430754] page_type: f5(slab)
[   18.430982] raw: 000fffffc0000040 ff1100000ac38140 0000000000000000 dead000000000001
[   18.431505] raw: 0000000000000000 0000000080040004 00000000f5000000 0000000000000000
[   18.432025] head: 000fffffc0000040 ff1100000ac38140 0000000000000000 dead000000000001
[   18.432549] head: 0000000000000000 0000000080040004 00000000f5000000 0000000000000000
[   18.433077] head: 000fffffc0000003 ffd4000000455c01 00000000ffffffff 00000000ffffffff
[   18.433605] head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
[   18.434126] page dumped because: kasan: bad access detected
[   18.434504]
[   18.434621] Memory state around the buggy address:
[   18.434950]  ff11000011572c00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[   18.435438]  ff11000011572c80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[   18.435925] >ff11000011572d00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[   18.436399]                                         ^
[   18.436744]  ff11000011572d80: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
[   18.437229]  ff11000011572e00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   18.437709] ==================================================================
"

Hope this cound be insightful to you.

Regards,
Yi Lai

---

If you don't need the following environment to reproduce the problem or if you
already have one reproduced environment, please ignore the following information.

How to reproduce:
git clone https://gitlab.com/xupengfe/repro_vm_env.git
cd repro_vm_env
tar -xvf repro_vm_env.tar.gz
cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
  // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
  // You could change the bzImage_xxx as you want
  // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
You could use below command to log in, there is no password for root.
ssh -p 10023 root@localhost

After login vm(virtual machine) successfully, you could transfer reproduced
binary to the vm by below way, and reproduce the problem in vm:
gcc -pthread -o repro repro.c
scp -P 10023 repro root@localhost:/root/

Get the bzImage for target kernel:
Please use target kconfig and copy it to kernel_src/.config
make olddefconfig
make -jx bzImage           //x should equal or less than cpu num your pc has

Fill the bzImage file into above start3.sh to load the target kernel in vm.


Tips:
If you already have qemu-system-x86_64, please ignore below info.
If you want to install qemu v7.1.0 version:
git clone https://github.com/qemu/qemu.git
cd qemu
git checkout -f v7.1.0
mkdir build
cd build
yum install -y ninja-build.x86_64
yum -y install libslirp-devel.x86_64
../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
make
make install
  

