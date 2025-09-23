Return-Path: <linux-integrity+bounces-7252-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72446B97734
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Sep 2025 22:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BB0E3AB3A1
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Sep 2025 20:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42DD305067;
	Tue, 23 Sep 2025 20:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lp8n0gpn"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB5B2F3620
	for <linux-integrity@vger.kernel.org>; Tue, 23 Sep 2025 20:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758658074; cv=none; b=ieywUv/2/PQm5EsBoxlAMVyqguJ5Vvj/gXNaRh58Zkenv9P5z5IxF0vCkp/bnPjFoDgwLoJjaZzsNreKaLGQpEDv3tgX/z9jqqf643RlgRfvEOv7QvfHJ7/oVoFERgaecA66PiDYyamMdmV7IUWd+rRiIh2XzS6U96QcWFwsuWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758658074; c=relaxed/simple;
	bh=RtEf51h/3CsE3krGIkly9rcGDvycw46D2mNsAn4P68I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4l6Wh9qet4QIrB1cL+jXFHKGKtc0w9KL5McO1u0NSnZwgmuAG+qV0ymHdWrd1b6iOVfYXINr54JnIi4pRvLeTXIOBhUblhWY5addnt0/1nm918canN1ObTv2A/+aumjo5glU2ySE5hbPcuWsRbBse46ieP5ck300ipeVdO/obk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lp8n0gpn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E84C4CEF5;
	Tue, 23 Sep 2025 20:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758658073;
	bh=RtEf51h/3CsE3krGIkly9rcGDvycw46D2mNsAn4P68I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lp8n0gpnOPW2kSBRCR7IH5ypAMYx0GX3hP7wyLGPCcMcUTS0wLLSTaIzliSDnVNLr
	 AXwkbh/fLEmAx9VtA012cu362c59TDH4Iu6qUYjJs8xfTFQqJWK3FfuFtyesAN150b
	 c+Lg82NtZvsMf/FNc9Znfv75dwRs+e8kodCZSMtB4WIOs25GeSvhf/QKOBJlC8WGc1
	 INPjuENcavox6exPJVwPDyCsYWOHRM8caDFD+A9H9egu1d9cBZTcvjGoCJf07CQ53L
	 uCZhwaQK+WqavN47UsGQN5sz4nAJzM543KkgidZImgzZKYbw+upW0Lb98WhVBfQFl+
	 Jegf49jJrH4eg==
Date: Tue, 23 Sep 2025 13:07:48 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Denis Aleksandrov <daleksan@redhat.com>
Cc: peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
	linux-integrity@vger.kernel.org, Jan Stancek <jstancek@redhat.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH v5] tpm: Prevent local DOS via tpm/tpm0/ppi/*operations
Message-ID: <20250923200748.GA3355497@ax162>
References: <20250915210829.6661-1-daleksan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915210829.6661-1-daleksan@redhat.com>

Hi Denis,

On Mon, Sep 15, 2025 at 05:08:29PM -0400, Denis Aleksandrov wrote:
> Reads on tpm/tpm0/ppi/*operations can become very long on
> misconfigured systems. Reading the TPM is a blocking operation,
> thus a user could effectively trigger a DOS.
> 
> Resolve this by caching the results and avoiding the blocking
> operations after the first read.
> 
> Reported-by: Jan Stancek <jstancek@redhat.com>
> Signed-off-by: Denis Aleksandrov <daleksan@redhat.com>
> Suggested-by: Jarkko Sakkinen <jarkko@kernel.org>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
> 
> Changes in v5:
> 	- Unlocks the tpm_ppi_lock if cache_ppi_operations() returns and
> 	  error.
> 
>  drivers/char/tpm/tpm_ppi.c | 89 ++++++++++++++++++++++++++++----------
>  1 file changed, 66 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_ppi.c b/drivers/char/tpm/tpm_ppi.c
> index d53fce1c9d6f..47655407fea5 100644
> --- a/drivers/char/tpm/tpm_ppi.c
> +++ b/drivers/char/tpm/tpm_ppi.c
> @@ -33,6 +33,20 @@ static const guid_t tpm_ppi_guid =
>  	GUID_INIT(0x3DDDFAA6, 0x361B, 0x4EB4,
>  		  0xA4, 0x24, 0x8D, 0x10, 0x08, 0x9D, 0x16, 0x53);
>  
> +static const char * const tpm_ppi_info[] = {
> +	"Not implemented",
> +	"BIOS only",
> +	"Blocked for OS by system firmware",
> +	"User required",
> +	"User not required",
> +};
> +
> +/* A spinlock to protect access to the cache from concurrent reads */
> +static DEFINE_SPINLOCK(tpm_ppi_lock);
> +
> +static u32 ppi_operations_cache[PPI_VS_REQ_END + 1];
> +static bool ppi_cache_populated;
> +
>  static bool tpm_ppi_req_has_parameter(u64 req)
>  {
>  	return req == 23;
> @@ -277,8 +291,7 @@ static ssize_t tpm_show_ppi_response(struct device *dev,
>  	return status;
>  }
>  
> -static ssize_t show_ppi_operations(acpi_handle dev_handle, char *buf, u32 start,
> -				   u32 end)
> +static ssize_t cache_ppi_operations(acpi_handle dev_handle, char *buf)
>  {
>  	int i;
>  	u32 ret;
> @@ -286,34 +299,22 @@ static ssize_t show_ppi_operations(acpi_handle dev_handle, char *buf, u32 start,
>  	union acpi_object *obj, tmp;
>  	union acpi_object argv = ACPI_INIT_DSM_ARGV4(1, &tmp);
>  
> -	static char *info[] = {
> -		"Not implemented",
> -		"BIOS only",
> -		"Blocked for OS by BIOS",
> -		"User required",
> -		"User not required",
> -	};
> -
>  	if (!acpi_check_dsm(dev_handle, &tpm_ppi_guid, TPM_PPI_REVISION_ID_1,
>  			    1 << TPM_PPI_FN_GETOPR))
>  		return -EPERM;
>  
>  	tmp.integer.type = ACPI_TYPE_INTEGER;
> -	for (i = start; i <= end; i++) {
> +	for (i = 0; i <= PPI_VS_REQ_END; i++) {
>  		tmp.integer.value = i;
>  		obj = tpm_eval_dsm(dev_handle, TPM_PPI_FN_GETOPR,
>  				   ACPI_TYPE_INTEGER, &argv,
>  				   TPM_PPI_REVISION_ID_1);
> -		if (!obj) {
> +		if (!obj)
>  			return -ENOMEM;
> -		} else {
> -			ret = obj->integer.value;
> -			ACPI_FREE(obj);
> -		}
>  
> -		if (ret > 0 && ret < ARRAY_SIZE(info))
> -			len += sysfs_emit_at(buf, len, "%d %d: %s\n",
> -					     i, ret, info[ret]);
> +		ret = obj->integer.value;
> +		ppi_operations_cache[i] = ret;
> +		ACPI_FREE(obj);
>  	}
>  
>  	return len;
> @@ -324,9 +325,30 @@ static ssize_t tpm_show_ppi_tcg_operations(struct device *dev,
>  					   char *buf)
>  {
>  	struct tpm_chip *chip = to_tpm_chip(dev);
> +	ssize_t len = 0;
> +	u32 ret;
> +	int i;
> +
> +	spin_lock(&tpm_ppi_lock);
> +	if (!ppi_cache_populated) {
> +		len = cache_ppi_operations(chip->acpi_dev_handle, buf);
> +		if (len < 0) {
> +			spin_unlock(&tpm_ppi_lock);
> +			return len;
> +		}
>  
> -	return show_ppi_operations(chip->acpi_dev_handle, buf, 0,
> -				   PPI_TPM_REQ_MAX);
> +		ppi_cache_populated = true;
> +	}
> +
> +	for (i = 0; i <= PPI_TPM_REQ_MAX; i++) {
> +		ret = ppi_operations_cache[i];
> +		if (ret >= 0 && ret < ARRAY_SIZE(tpm_ppi_info))
> +			len += sysfs_emit_at(buf, len, "%d %d: %s\n",
> +							i, ret, tpm_ppi_info[ret]);
> +	}
> +	spin_unlock(&tpm_ppi_lock);
> +
> +	return len;
>  }
>  
>  static ssize_t tpm_show_ppi_vs_operations(struct device *dev,
> @@ -334,9 +356,30 @@ static ssize_t tpm_show_ppi_vs_operations(struct device *dev,
>  					  char *buf)
>  {
>  	struct tpm_chip *chip = to_tpm_chip(dev);
> +	ssize_t len = 0;
> +	u32 ret;
> +	int i;
>  
> -	return show_ppi_operations(chip->acpi_dev_handle, buf, PPI_VS_REQ_START,
> -				   PPI_VS_REQ_END);
> +	spin_lock(&tpm_ppi_lock);
> +	if (!ppi_cache_populated) {
> +		len = cache_ppi_operations(chip->acpi_dev_handle, buf);
> +		if (len < 0) {
> +			spin_unlock(&tpm_ppi_lock);
> +			return len;
> +		}
> +
> +		ppi_cache_populated = true;
> +	}
> +
> +	for (i = PPI_VS_REQ_START; i <= PPI_VS_REQ_END; i++) {
> +		ret = ppi_operations_cache[i];
> +		if (ret >= 0 && ret < ARRAY_SIZE(tpm_ppi_info))
> +			len += sysfs_emit_at(buf, len, "%d %d: %s\n",
> +							i, ret, tpm_ppi_info[ret]);
> +	}
> +	spin_unlock(&tpm_ppi_lock);
> +
> +	return len;
>  }
>  
>  static DEVICE_ATTR(version, S_IRUGO, tpm_show_ppi_version, NULL);
> -- 
> 2.48.1
> 

I am seeing a "scheduling while atomic" splat in -next when running
LTP's read_all testcase against /proc and /sys that I bisected to this
change (bisect log at the end of the message). It is still reproducible
with the most recent sha in Jarkko's tree, c4a211c65878 ("tpm: Prevent
local DOS via tpm/tpm0/ppi/*operations"), where there is no difference
in the code as far as I can tell.

  $ curl -LSs https://github.com/nathanchance/env/raw/014a117384fb9121cf5c81ab30aa4de935246c17/bin/x86_64/read_all | install -m755 /dev/stdin read_all

  $ sudo sh -c "$PWD/read_all -d /proc && $PWD/read_all -d /sys && dmesg"
  ...
  [  103.605352] BUG: scheduling while atomic: read_all/2907/0x00000002
  [  103.605357] Modules linked in: ...
  [  103.605401]  ...
  [  103.605454] CPU: 0 UID: 0 PID: 2907 Comm: read_all Not tainted 6.17.0-rc6-debug-00276-gc4a211c65878 #1 PREEMPT(full)  ccfbb8e489d66d107205aa22f3b6242dd3605b88
  [  103.605457] Hardware name: AZW MINI S/MINI S, BIOS ADLNV106 05/12/2024
  [  103.605459] Call Trace:
  [  103.605461]  <TASK>
  [  103.605465]  dump_stack_lvl+0x5d/0x80
  [  103.605471]  __schedule_bug.cold+0x42/0x4e
  [  103.605473]  __schedule+0x1083/0x1330
  [  103.605478]  ? acpi_ex_field_datum_io+0xe8/0x4f0
  [  103.605482]  ? acpi_os_release_object+0xe/0x20
  [  103.605486]  schedule+0x27/0xd0
  [  103.605487]  schedule_timeout+0xbd/0x100
  [  103.605491]  __down_common+0x137/0x2d0
  [  103.605493]  down_timeout+0x67/0x70
  [  103.605495]  acpi_os_wait_semaphore+0x68/0x180
  [  103.605498]  acpi_ut_acquire_mutex+0x97/0x250
  [  103.605500]  acpi_ns_delete_namespace_subtree+0x48/0x110
  [  103.605503]  acpi_ds_terminate_control_method+0x1c8/0x200
  [  103.605505]  acpi_ps_parse_aml+0x1ae/0x5d0
  [  103.605508]  acpi_ps_execute_method+0x171/0x3e0
  [  103.605511]  acpi_ns_evaluate+0x196/0x5c0
  [  103.605513]  acpi_evaluate_object+0x1ce/0x450
  [  103.605515]  acpi_evaluate_dsm+0xcb/0x150
  [  103.605519]  cache_ppi_operations.isra.0+0xc2/0x110
  [  103.605522]  tpm_show_ppi_tcg_operations+0x99/0xb0
  [  103.605523]  dev_attr_show+0x1c/0x50
  [  103.605526]  sysfs_kf_seq_show+0xc9/0x120
  [  103.605530]  seq_read_iter+0x125/0x480
  [  103.605532]  ? rw_verify_area+0x56/0x180
  [  103.605534]  vfs_read+0x265/0x390
  [  103.605538]  ksys_read+0x73/0xf0
  [  103.605540]  do_syscall_64+0x81/0x970
  [  103.605542]  ? ksys_read+0x73/0xf0
  [  103.605545]  ? refill_obj_stock+0x12e/0x240
  [  103.605547]  ? xas_load+0xd/0xd0
  [  103.605549]  ? xa_load+0x76/0xb0
  [  103.605552]  ? refill_obj_stock+0x12e/0x240
  [  103.605553]  ? __memcg_slab_free_hook+0xf4/0x140
  [  103.605555]  ? kmem_cache_free+0x490/0x4d0
  [  103.605557]  ? __x64_sys_close+0x3d/0x80
  [  103.605560]  ? __x64_sys_close+0x3d/0x80
  [  103.605562]  ? do_syscall_64+0x81/0x970
  [  103.605563]  ? do_syscall_64+0x81/0x970
  [  103.605564]  ? do_syscall_64+0x81/0x970
  [  103.605565]  ? do_syscall_64+0x81/0x970
  [  103.605566]  ? __irq_exit_rcu+0x4c/0xf0
  [  103.605569]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
  [  103.605571] RIP: 0033:0x4243b8
  [  103.605597] Code: 0f 05 48 83 f8 da 75 08 4c 89 c0 48 89 d6 0f 05 c3 48 89 f8 4d 89 c2 48 89 f7 4d 89 c8 48 89 d6 4c 8b 4c 24 08 48 89 ca 0f 05 <c3> e9 e1 ff ff ff 48 8d 3d 9b 52 02 00 e9 8a 06 00 00 48 8d 3d 8f
  [  103.605598] RSP: 002b:00007ffccef321b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
  [  103.605601] RAX: ffffffffffffffda RBX: 00007ffccef32690 RCX: 00000000004243b8
  [  103.605602] RDX: 00000000000003ff RSI: 00007ffccef32690 RDI: 0000000000000003
  [  103.605603] RBP: 00000000310cdd71 R08: 0000000000000000 R09: 0000000000000000
  [  103.605603] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fb294164000
  [  103.605604] R13: 000000000042b00c R14: 00007ffccef32290 R15: 0000000000000003
  [  103.605606]  </TASK>
  [  103.652735] BUG: scheduling while atomic: read_all/2907/0x00000000
  [  103.652739] Modules linked in: ...
  [  103.652775]  ...
  [  103.652825] CPU: 0 UID: 0 PID: 2907 Comm: read_all Tainted: G        W           6.17.0-rc6-debug-00276-gc4a211c65878 #1 PREEMPT(full)  ccfbb8e489d66d107205aa22f3b6242dd3605b88
  [  103.652828] Tainted: [W]=WARN
  [  103.652829] Hardware name: AZW MINI S/MINI S, BIOS ADLNV106 05/12/2024
  [  103.652830] Call Trace:
  [  103.652830]  <TASK>
  [  103.652831]  dump_stack_lvl+0x5d/0x80
  [  103.652835]  __schedule_bug.cold+0x42/0x4e
  [  103.652837]  __schedule+0x1083/0x1330
  [  103.652840]  ? get_nohz_timer_target+0x2f/0x150
  [  103.652843]  ? timerqueue_add+0x73/0xd0
  [  103.652845]  schedule+0x27/0xd0
  [  103.652847]  schedule_hrtimeout_range_clock+0xd8/0x120
  [  103.652850]  ? __pfx_hrtimer_wakeup+0x10/0x10
  [  103.652853]  usleep_range_state+0x6c/0xa0
  [  103.652855]  crb_wait_for_reg_32.constprop.0+0x40/0x80
  [  103.652858]  crb_request_locality+0x3d/0x50
  [  103.652860]  tpm_chip_start+0x6c/0xe0
  [  103.652862]  tpm_try_get_ops+0x89/0xb0
  [  103.652863]  tpm_find_get_ops+0x1b/0x70
  [  103.652865]  tpm_pcr_read+0x1b/0x70
  [  103.652866]  pcr_value_show+0xcc/0x140
  [  103.652869]  dev_attr_show+0x1c/0x50
  [  103.652871]  sysfs_kf_seq_show+0xc9/0x120
  [  103.652873]  seq_read_iter+0x125/0x480
  [  103.652875]  ? rw_verify_area+0x56/0x180
  [  103.652877]  vfs_read+0x265/0x390
  [  103.652880]  ksys_read+0x73/0xf0
  [  103.652882]  do_syscall_64+0x81/0x970
  [  103.652883]  ? do_syscall_64+0x81/0x970
  [  103.652884]  ? __irq_exit_rcu+0x4c/0xf0
  [  103.652887]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
  [  103.652889] RIP: 0033:0x4243b8
  [  103.652903] Code: 0f 05 48 83 f8 da 75 08 4c 89 c0 48 89 d6 0f 05 c3 48 89 f8 4d 89 c2 48 89 f7 4d 89 c8 48 89 d6 4c 8b 4c 24 08 48 89 ca 0f 05 <c3> e9 e1 ff ff ff 48 8d 3d 9b 52 02 00 e9 8a 06 00 00 48 8d 3d 8f
  [  103.652905] RSP: 002b:00007ffccef321b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
  [  103.652906] RAX: ffffffffffffffda RBX: 00007ffccef32690 RCX: 00000000004243b8
  [  103.652907] RDX: 00000000000003ff RSI: 00007ffccef32690 RDI: 0000000000000003
  [  103.652908] RBP: 00000000310cdd71 R08: 0000000000000000 R09: 0000000000000000
  [  103.652909] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fb294164000
  [  103.652910] R13: 000000000042b00c R14: 00007ffccef32290 R15: 0000000000000003
  [  103.652912]  </TASK>

If there is any other information I can provide or patches I can test, I
am more than happy to do so.

Cheers,
Nathan

# bad: [846bd2225ec3cfa8be046655e02b9457ed41973e] Add linux-next specific files for 20250919
# good: [097a6c336d0080725c626fda118ecfec448acd0f] Merge tag 'trace-rv-v6.17-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace
git bisect start '846bd2225ec3cfa8be046655e02b9457ed41973e' '097a6c336d0080725c626fda118ecfec448acd0f'
# good: [b9d41d5a636cffade9b996694870ef32b63702cf] Merge branch 'main' of https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
git bisect good b9d41d5a636cffade9b996694870ef32b63702cf
# good: [a39463956b2ff01e8892f1aa3eec0dd38749b07c] Merge branch 'next' of https://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git
git bisect good a39463956b2ff01e8892f1aa3eec0dd38749b07c
# bad: [414e90f0344140f0fdf2cc1d9aea49dce91ef629] Merge branch 'usb-next' of https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
git bisect bad 414e90f0344140f0fdf2cc1d9aea49dce91ef629
# bad: [3a4440a874853fb3d3e48711351d2bb6f997eafb] Merge branch 'master' of https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
git bisect bad 3a4440a874853fb3d3e48711351d2bb6f997eafb
# good: [cfec5d142506784293fd5e0eeca6eb4b06c43d28] Merge branch into tip/master: 'x86/core'
git bisect good cfec5d142506784293fd5e0eeca6eb4b06c43d28
# bad: [0158a8692e42348f1c56d35e93a0b94e8ead8c1c] Merge branch 'master' of git://www.linux-watchdog.org/linux-watchdog-next.git
git bisect bad 0158a8692e42348f1c56d35e93a0b94e8ead8c1c
# good: [afed810f203f0f3f17f5e3d97da3a1b1b19c8ea9] Merge branch 'for-next' of https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git
git bisect good afed810f203f0f3f17f5e3d97da3a1b1b19c8ea9
# good: [d8fdd0c0599c24d20e527d206f138dafd3180088] Merge branch 'next-integrity' of https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity
git bisect good d8fdd0c0599c24d20e527d206f138dafd3180088
# good: [46221ed48c7e1e137ffd90da98008c5bc53841ce] Merge branch 'master' of git://git.code.sf.net/p/tomoyo/tomoyo.git
git bisect good 46221ed48c7e1e137ffd90da98008c5bc53841ce
# good: [66036fa63a9b070a76100179d829d8d34e450e68] watchdog: rzg2l_wdt: don't print superfluous errors
git bisect good 66036fa63a9b070a76100179d829d8d34e450e68
# good: [1506ba7cdc61ec69f2a59b14803c369fa1155769] KEYS: encrypted: Use SHA-256 library instead of crypto_shash
git bisect good 1506ba7cdc61ec69f2a59b14803c369fa1155769
# good: [7dfd80f70ef00d871df5af7c391133f7ba61ad9b] watchdog: mpc8xxx_wdt: Reload the watchdog timer when enabling the watchdog
git bisect good 7dfd80f70ef00d871df5af7c391133f7ba61ad9b
# bad: [f53d117864c01aecd974e229e58079d753b5844c] tpm_tis: Fix incorrect arguments in tpm_tis_probe_irq_single
git bisect bad f53d117864c01aecd974e229e58079d753b5844c
# bad: [5b84ce6e6a746cb59ce8f77ebf69e6f2684485b0] tpm: Prevent local DOS via tpm/tpm0/ppi/*operations
git bisect bad 5b84ce6e6a746cb59ce8f77ebf69e6f2684485b0
# first bad commit: [5b84ce6e6a746cb59ce8f77ebf69e6f2684485b0] tpm: Prevent local DOS via tpm/tpm0/ppi/*operations

