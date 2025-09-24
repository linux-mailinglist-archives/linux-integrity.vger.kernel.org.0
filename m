Return-Path: <linux-integrity+bounces-7261-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFAFCB9823A
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Sep 2025 05:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8362716940B
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Sep 2025 03:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA6635972;
	Wed, 24 Sep 2025 03:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gcCiYEng"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681502F56
	for <linux-integrity@vger.kernel.org>; Wed, 24 Sep 2025 03:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758684697; cv=none; b=nr/VNmFjB5/gGNSw6RI3Yuk/lE9EJd/EAhHUiIrplNN5FHDUiE/BAyd9jpP1gSI4CJjQ1uBgmM2mqFMYJLWYZlJGxUCgCHvoAKgfmU5mBpZUcCit+cVSqtEcQyrFjHwXBu/cMhv4XCuVKyJOaiQSz8s2HIk8jwtzZ0o0rKSzMk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758684697; c=relaxed/simple;
	bh=G38ZsoG8CrgFzxBWLhVVqvp8XVNxsJIloNCyuJcmPxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3jRuxn0nLa5/du9GUSTQ/ViRmCQGQtw9LT3TNIN7ObBbktoyhwaI0rFXtHwI970dlU5YfpJY+k9niC6vT3L8hNAaHvAqEFr/gRz/m4XRkWL0QcAQO1slvbOQDcnJBBCAaCdMU3yFbuS341ugClKfGH/YyG6CakeHCJ1H6sq6HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gcCiYEng; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F787C4CEE7;
	Wed, 24 Sep 2025 03:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758684697;
	bh=G38ZsoG8CrgFzxBWLhVVqvp8XVNxsJIloNCyuJcmPxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gcCiYEngM70IiGtJ1Y5ondVyNeEpIfJvKeJLbbYLedcq/7Uw9bX9zWg+3sJ53jSIC
	 I1q7vZ5+/Rpntjgn8gLBEy9B+qxqp3Qazo+cVmmK5KYCQGOqPM101WZC6teQTO/a8L
	 w23JWE6sgzeL8yRXgiBbpTG6nD1hunIx/5ygqmml9h/B7r2Buo/iZ07/vYonTTYaN8
	 cJZPObmqLFDptUCbx58kRZg+RlO1hH/PhNBmfK/D4szMr/Eh8ILRCW4OZsloA22/+n
	 tcCFixnu6w+qxg6JE4FutU1UQcg4LXNtyDLWHqf/nQ5M15jLLzZRZhHjSpummWIBbb
	 iQBGqxZpSH+sA==
Date: Wed, 24 Sep 2025 06:31:32 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Denis Aleksandrov <daleksan@redhat.com>, peterhuewe@gmx.de,
	jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	Jan Stancek <jstancek@redhat.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH v5] tpm: Prevent local DOS via tpm/tpm0/ppi/*operations
Message-ID: <aNNmFCl0OsfeImK3@kernel.org>
References: <20250915210829.6661-1-daleksan@redhat.com>
 <20250923200748.GA3355497@ax162>
 <aNNB7w3x2ZoekCML@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aNNB7w3x2ZoekCML@kernel.org>

On Wed, Sep 24, 2025 at 03:57:23AM +0300, Jarkko Sakkinen wrote:
> On Tue, Sep 23, 2025 at 01:07:48PM -0700, Nathan Chancellor wrote:
> > Hi Denis,
> > 
> > On Mon, Sep 15, 2025 at 05:08:29PM -0400, Denis Aleksandrov wrote:
> > > Reads on tpm/tpm0/ppi/*operations can become very long on
> > > misconfigured systems. Reading the TPM is a blocking operation,
> > > thus a user could effectively trigger a DOS.
> > > 
> > > Resolve this by caching the results and avoiding the blocking
> > > operations after the first read.
> > > 
> > > Reported-by: Jan Stancek <jstancek@redhat.com>
> > > Signed-off-by: Denis Aleksandrov <daleksan@redhat.com>
> > > Suggested-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> > > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > ---
> > > 
> > > Changes in v5:
> > > 	- Unlocks the tpm_ppi_lock if cache_ppi_operations() returns and
> > > 	  error.
> > > 
> > >  drivers/char/tpm/tpm_ppi.c | 89 ++++++++++++++++++++++++++++----------
> > >  1 file changed, 66 insertions(+), 23 deletions(-)
> > > 
> > > diff --git a/drivers/char/tpm/tpm_ppi.c b/drivers/char/tpm/tpm_ppi.c
> > > index d53fce1c9d6f..47655407fea5 100644
> > > --- a/drivers/char/tpm/tpm_ppi.c
> > > +++ b/drivers/char/tpm/tpm_ppi.c
> > > @@ -33,6 +33,20 @@ static const guid_t tpm_ppi_guid =
> > >  	GUID_INIT(0x3DDDFAA6, 0x361B, 0x4EB4,
> > >  		  0xA4, 0x24, 0x8D, 0x10, 0x08, 0x9D, 0x16, 0x53);
> > >  
> > > +static const char * const tpm_ppi_info[] = {
> > > +	"Not implemented",
> > > +	"BIOS only",
> > > +	"Blocked for OS by system firmware",
> > > +	"User required",
> > > +	"User not required",
> > > +};
> > > +
> > > +/* A spinlock to protect access to the cache from concurrent reads */
> > > +static DEFINE_SPINLOCK(tpm_ppi_lock);
> > > +
> > > +static u32 ppi_operations_cache[PPI_VS_REQ_END + 1];
> > > +static bool ppi_cache_populated;
> > > +
> > >  static bool tpm_ppi_req_has_parameter(u64 req)
> > >  {
> > >  	return req == 23;
> > > @@ -277,8 +291,7 @@ static ssize_t tpm_show_ppi_response(struct device *dev,
> > >  	return status;
> > >  }
> > >  
> > > -static ssize_t show_ppi_operations(acpi_handle dev_handle, char *buf, u32 start,
> > > -				   u32 end)
> > > +static ssize_t cache_ppi_operations(acpi_handle dev_handle, char *buf)
> > >  {
> > >  	int i;
> > >  	u32 ret;
> > > @@ -286,34 +299,22 @@ static ssize_t show_ppi_operations(acpi_handle dev_handle, char *buf, u32 start,
> > >  	union acpi_object *obj, tmp;
> > >  	union acpi_object argv = ACPI_INIT_DSM_ARGV4(1, &tmp);
> > >  
> > > -	static char *info[] = {
> > > -		"Not implemented",
> > > -		"BIOS only",
> > > -		"Blocked for OS by BIOS",
> > > -		"User required",
> > > -		"User not required",
> > > -	};
> > > -
> > >  	if (!acpi_check_dsm(dev_handle, &tpm_ppi_guid, TPM_PPI_REVISION_ID_1,
> > >  			    1 << TPM_PPI_FN_GETOPR))
> > >  		return -EPERM;
> > >  
> > >  	tmp.integer.type = ACPI_TYPE_INTEGER;
> > > -	for (i = start; i <= end; i++) {
> > > +	for (i = 0; i <= PPI_VS_REQ_END; i++) {
> > >  		tmp.integer.value = i;
> > >  		obj = tpm_eval_dsm(dev_handle, TPM_PPI_FN_GETOPR,
> > >  				   ACPI_TYPE_INTEGER, &argv,
> > >  				   TPM_PPI_REVISION_ID_1);
> > > -		if (!obj) {
> > > +		if (!obj)
> > >  			return -ENOMEM;
> > > -		} else {
> > > -			ret = obj->integer.value;
> > > -			ACPI_FREE(obj);
> > > -		}
> > >  
> > > -		if (ret > 0 && ret < ARRAY_SIZE(info))
> > > -			len += sysfs_emit_at(buf, len, "%d %d: %s\n",
> > > -					     i, ret, info[ret]);
> > > +		ret = obj->integer.value;
> > > +		ppi_operations_cache[i] = ret;
> > > +		ACPI_FREE(obj);
> > >  	}
> > >  
> > >  	return len;
> > > @@ -324,9 +325,30 @@ static ssize_t tpm_show_ppi_tcg_operations(struct device *dev,
> > >  					   char *buf)
> > >  {
> > >  	struct tpm_chip *chip = to_tpm_chip(dev);
> > > +	ssize_t len = 0;
> > > +	u32 ret;
> > > +	int i;
> > > +
> > > +	spin_lock(&tpm_ppi_lock);
> > > +	if (!ppi_cache_populated) {
> > > +		len = cache_ppi_operations(chip->acpi_dev_handle, buf);
> > > +		if (len < 0) {
> > > +			spin_unlock(&tpm_ppi_lock);
> > > +			return len;
> > > +		}
> > >  
> > > -	return show_ppi_operations(chip->acpi_dev_handle, buf, 0,
> > > -				   PPI_TPM_REQ_MAX);
> > > +		ppi_cache_populated = true;
> > > +	}
> > > +
> > > +	for (i = 0; i <= PPI_TPM_REQ_MAX; i++) {
> > > +		ret = ppi_operations_cache[i];
> > > +		if (ret >= 0 && ret < ARRAY_SIZE(tpm_ppi_info))
> > > +			len += sysfs_emit_at(buf, len, "%d %d: %s\n",
> > > +							i, ret, tpm_ppi_info[ret]);
> > > +	}
> > > +	spin_unlock(&tpm_ppi_lock);
> > > +
> > > +	return len;
> > >  }
> > >  
> > >  static ssize_t tpm_show_ppi_vs_operations(struct device *dev,
> > > @@ -334,9 +356,30 @@ static ssize_t tpm_show_ppi_vs_operations(struct device *dev,
> > >  					  char *buf)
> > >  {
> > >  	struct tpm_chip *chip = to_tpm_chip(dev);
> > > +	ssize_t len = 0;
> > > +	u32 ret;
> > > +	int i;
> > >  
> > > -	return show_ppi_operations(chip->acpi_dev_handle, buf, PPI_VS_REQ_START,
> > > -				   PPI_VS_REQ_END);
> > > +	spin_lock(&tpm_ppi_lock);
> > > +	if (!ppi_cache_populated) {
> > > +		len = cache_ppi_operations(chip->acpi_dev_handle, buf);
> > > +		if (len < 0) {
> > > +			spin_unlock(&tpm_ppi_lock);
> > > +			return len;
> > > +		}
> > > +
> > > +		ppi_cache_populated = true;
> > > +	}
> > > +
> > > +	for (i = PPI_VS_REQ_START; i <= PPI_VS_REQ_END; i++) {
> > > +		ret = ppi_operations_cache[i];
> > > +		if (ret >= 0 && ret < ARRAY_SIZE(tpm_ppi_info))
> > > +			len += sysfs_emit_at(buf, len, "%d %d: %s\n",
> > > +							i, ret, tpm_ppi_info[ret]);
> > > +	}
> > > +	spin_unlock(&tpm_ppi_lock);
> > > +
> > > +	return len;
> > >  }
> > >  
> > >  static DEVICE_ATTR(version, S_IRUGO, tpm_show_ppi_version, NULL);
> > > -- 
> > > 2.48.1
> > > 
> > 
> > I am seeing a "scheduling while atomic" splat in -next when running
> > LTP's read_all testcase against /proc and /sys that I bisected to this
> > change (bisect log at the end of the message). It is still reproducible
> > with the most recent sha in Jarkko's tree, c4a211c65878 ("tpm: Prevent
> > local DOS via tpm/tpm0/ppi/*operations"), where there is no difference
> > in the code as far as I can tell.
> > 
> >   $ curl -LSs https://github.com/nathanchance/env/raw/014a117384fb9121cf5c81ab30aa4de935246c17/bin/x86_64/read_all | install -m755 /dev/stdin read_all
> > 
> >   $ sudo sh -c "$PWD/read_all -d /proc && $PWD/read_all -d /sys && dmesg"
> >   ...
> >   [  103.605352] BUG: scheduling while atomic: read_all/2907/0x00000002
> >   [  103.605357] Modules linked in: ...
> >   [  103.605401]  ...
> >   [  103.605454] CPU: 0 UID: 0 PID: 2907 Comm: read_all Not tainted 6.17.0-rc6-debug-00276-gc4a211c65878 #1 PREEMPT(full)  ccfbb8e489d66d107205aa22f3b6242dd3605b88
> >   [  103.605457] Hardware name: AZW MINI S/MINI S, BIOS ADLNV106 05/12/2024
> >   [  103.605459] Call Trace:
> >   [  103.605461]  <TASK>
> >   [  103.605465]  dump_stack_lvl+0x5d/0x80
> >   [  103.605471]  __schedule_bug.cold+0x42/0x4e
> >   [  103.605473]  __schedule+0x1083/0x1330
> >   [  103.605478]  ? acpi_ex_field_datum_io+0xe8/0x4f0
> >   [  103.605482]  ? acpi_os_release_object+0xe/0x20
> >   [  103.605486]  schedule+0x27/0xd0
> >   [  103.605487]  schedule_timeout+0xbd/0x100
> >   [  103.605491]  __down_common+0x137/0x2d0
> >   [  103.605493]  down_timeout+0x67/0x70
> >   [  103.605495]  acpi_os_wait_semaphore+0x68/0x180
> >   [  103.605498]  acpi_ut_acquire_mutex+0x97/0x250
> >   [  103.605500]  acpi_ns_delete_namespace_subtree+0x48/0x110
> >   [  103.605503]  acpi_ds_terminate_control_method+0x1c8/0x200
> >   [  103.605505]  acpi_ps_parse_aml+0x1ae/0x5d0
> >   [  103.605508]  acpi_ps_execute_method+0x171/0x3e0
> >   [  103.605511]  acpi_ns_evaluate+0x196/0x5c0
> >   [  103.605513]  acpi_evaluate_object+0x1ce/0x450
> >   [  103.605515]  acpi_evaluate_dsm+0xcb/0x150
> >   [  103.605519]  cache_ppi_operations.isra.0+0xc2/0x110
> >   [  103.605522]  tpm_show_ppi_tcg_operations+0x99/0xb0
> >   [  103.605523]  dev_attr_show+0x1c/0x50
> >   [  103.605526]  sysfs_kf_seq_show+0xc9/0x120
> >   [  103.605530]  seq_read_iter+0x125/0x480
> >   [  103.605532]  ? rw_verify_area+0x56/0x180
> >   [  103.605534]  vfs_read+0x265/0x390
> >   [  103.605538]  ksys_read+0x73/0xf0
> >   [  103.605540]  do_syscall_64+0x81/0x970
> >   [  103.605542]  ? ksys_read+0x73/0xf0
> >   [  103.605545]  ? refill_obj_stock+0x12e/0x240
> >   [  103.605547]  ? xas_load+0xd/0xd0
> >   [  103.605549]  ? xa_load+0x76/0xb0
> >   [  103.605552]  ? refill_obj_stock+0x12e/0x240
> >   [  103.605553]  ? __memcg_slab_free_hook+0xf4/0x140
> >   [  103.605555]  ? kmem_cache_free+0x490/0x4d0
> >   [  103.605557]  ? __x64_sys_close+0x3d/0x80
> >   [  103.605560]  ? __x64_sys_close+0x3d/0x80
> >   [  103.605562]  ? do_syscall_64+0x81/0x970
> >   [  103.605563]  ? do_syscall_64+0x81/0x970
> >   [  103.605564]  ? do_syscall_64+0x81/0x970
> >   [  103.605565]  ? do_syscall_64+0x81/0x970
> >   [  103.605566]  ? __irq_exit_rcu+0x4c/0xf0
> >   [  103.605569]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >   [  103.605571] RIP: 0033:0x4243b8
> >   [  103.605597] Code: 0f 05 48 83 f8 da 75 08 4c 89 c0 48 89 d6 0f 05 c3 48 89 f8 4d 89 c2 48 89 f7 4d 89 c8 48 89 d6 4c 8b 4c 24 08 48 89 ca 0f 05 <c3> e9 e1 ff ff ff 48 8d 3d 9b 52 02 00 e9 8a 06 00 00 48 8d 3d 8f
> >   [  103.605598] RSP: 002b:00007ffccef321b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> >   [  103.605601] RAX: ffffffffffffffda RBX: 00007ffccef32690 RCX: 00000000004243b8
> >   [  103.605602] RDX: 00000000000003ff RSI: 00007ffccef32690 RDI: 0000000000000003
> >   [  103.605603] RBP: 00000000310cdd71 R08: 0000000000000000 R09: 0000000000000000
> >   [  103.605603] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fb294164000
> >   [  103.605604] R13: 000000000042b00c R14: 00007ffccef32290 R15: 0000000000000003
> >   [  103.605606]  </TASK>
> >   [  103.652735] BUG: scheduling while atomic: read_all/2907/0x00000000
> >   [  103.652739] Modules linked in: ...
> >   [  103.652775]  ...
> >   [  103.652825] CPU: 0 UID: 0 PID: 2907 Comm: read_all Tainted: G        W           6.17.0-rc6-debug-00276-gc4a211c65878 #1 PREEMPT(full)  ccfbb8e489d66d107205aa22f3b6242dd3605b88
> >   [  103.652828] Tainted: [W]=WARN
> >   [  103.652829] Hardware name: AZW MINI S/MINI S, BIOS ADLNV106 05/12/2024
> >   [  103.652830] Call Trace:
> >   [  103.652830]  <TASK>
> >   [  103.652831]  dump_stack_lvl+0x5d/0x80
> >   [  103.652835]  __schedule_bug.cold+0x42/0x4e
> >   [  103.652837]  __schedule+0x1083/0x1330
> >   [  103.652840]  ? get_nohz_timer_target+0x2f/0x150
> >   [  103.652843]  ? timerqueue_add+0x73/0xd0
> >   [  103.652845]  schedule+0x27/0xd0
> >   [  103.652847]  schedule_hrtimeout_range_clock+0xd8/0x120
> >   [  103.652850]  ? __pfx_hrtimer_wakeup+0x10/0x10
> >   [  103.652853]  usleep_range_state+0x6c/0xa0
> >   [  103.652855]  crb_wait_for_reg_32.constprop.0+0x40/0x80
> >   [  103.652858]  crb_request_locality+0x3d/0x50
> >   [  103.652860]  tpm_chip_start+0x6c/0xe0
> >   [  103.652862]  tpm_try_get_ops+0x89/0xb0
> >   [  103.652863]  tpm_find_get_ops+0x1b/0x70
> >   [  103.652865]  tpm_pcr_read+0x1b/0x70
> >   [  103.652866]  pcr_value_show+0xcc/0x140
> >   [  103.652869]  dev_attr_show+0x1c/0x50
> >   [  103.652871]  sysfs_kf_seq_show+0xc9/0x120
> >   [  103.652873]  seq_read_iter+0x125/0x480
> >   [  103.652875]  ? rw_verify_area+0x56/0x180
> >   [  103.652877]  vfs_read+0x265/0x390
> >   [  103.652880]  ksys_read+0x73/0xf0
> >   [  103.652882]  do_syscall_64+0x81/0x970
> >   [  103.652883]  ? do_syscall_64+0x81/0x970
> >   [  103.652884]  ? __irq_exit_rcu+0x4c/0xf0
> >   [  103.652887]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >   [  103.652889] RIP: 0033:0x4243b8
> >   [  103.652903] Code: 0f 05 48 83 f8 da 75 08 4c 89 c0 48 89 d6 0f 05 c3 48 89 f8 4d 89 c2 48 89 f7 4d 89 c8 48 89 d6 4c 8b 4c 24 08 48 89 ca 0f 05 <c3> e9 e1 ff ff ff 48 8d 3d 9b 52 02 00 e9 8a 06 00 00 48 8d 3d 8f
> >   [  103.652905] RSP: 002b:00007ffccef321b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> >   [  103.652906] RAX: ffffffffffffffda RBX: 00007ffccef32690 RCX: 00000000004243b8
> >   [  103.652907] RDX: 00000000000003ff RSI: 00007ffccef32690 RDI: 0000000000000003
> >   [  103.652908] RBP: 00000000310cdd71 R08: 0000000000000000 R09: 0000000000000000
> >   [  103.652909] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fb294164000
> >   [  103.652910] R13: 000000000042b00c R14: 00007ffccef32290 R15: 0000000000000003
> >   [  103.652912]  </TASK>
> > 
> > If there is any other information I can provide or patches I can test, I
> > am more than happy to do so.
> 
> Thanks a lot! And I have not rushed with my 6.18 pull request.
> 
> It took me less than 30 seconds to locate the bug: it's spin
> lock and sleeing operations.
> 
> E.g., acpi_evaluate_dsm_typed can lead to kzalloc() and stuff
> like that. I don't know how I could I have possibly missed this
> detail and this is embarrasing but luckily this should be easy
> to fix with major hurdle :-)
> 
> What I suggest is that I'll simply repeal and replace the lock
> type (i.e. tweak the patch), as it does not feel worth of trouble
> to do a review round. Then we should be seeing better results.
> 
> Thanks again for spotting this. Yeah, and definitely not blaming
> original author for this. It's all on me tbh. The patch itself
> was great and I should have been able to address this...


So I guess the fix is exactly this:

~/work/kernel.org/jarkko/linux-tpmdd master* ⇡⇣
❯ sed -i 's/DEFINE_SPINLOCK/DEFINE_MUTEX/g' drivers/char/tpm/tpm_ppi.c

~/work/kernel.org/jarkko/linux-tpmdd master* ⇡⇣
❯ sed -i 's/spin_/mutex_/g' drivers/char/tpm/tpm_ppi.c

~/work/kernel.org/jarkko/linux-tpmdd master* ⇡⇣
❯ git -P diff
diff --git a/drivers/char/tpm/tpm_ppi.c b/drivers/char/tpm/tpm_ppi.c
index 47655407fea5..c9793a3d986d 100644
--- a/drivers/char/tpm/tpm_ppi.c
+++ b/drivers/char/tpm/tpm_ppi.c
@@ -42,7 +42,7 @@ static const char * const tpm_ppi_info[] = {
 };

 /* A spinlock to protect access to the cache from concurrent reads */
-static DEFINE_SPINLOCK(tpm_ppi_lock);
+static DEFINE_MUTEX(tpm_ppi_lock);

 static u32 ppi_operations_cache[PPI_VS_REQ_END + 1];
 static bool ppi_cache_populated;
@@ -329,11 +329,11 @@ static ssize_t tpm_show_ppi_tcg_operations(struct device *dev,
        u32 ret;
        int i;

-       spin_lock(&tpm_ppi_lock);
+       mutex_lock(&tpm_ppi_lock);
        if (!ppi_cache_populated) {
                len = cache_ppi_operations(chip->acpi_dev_handle, buf);
                if (len < 0) {
-                       spin_unlock(&tpm_ppi_lock);
+                       mutex_unlock(&tpm_ppi_lock);
                        return len;
                }

@@ -346,7 +346,7 @@ static ssize_t tpm_show_ppi_tcg_operations(struct device *dev,
                        len += sysfs_emit_at(buf, len, "%d %d: %s\n",
                                                        i, ret, tpm_ppi_info[ret]);
        }
-       spin_unlock(&tpm_ppi_lock);
+       mutex_unlock(&tpm_ppi_lock);

        return len;
 }
@@ -360,11 +360,11 @@ static ssize_t tpm_show_ppi_vs_operations(struct device *dev,
        u32 ret;
        int i;

-       spin_lock(&tpm_ppi_lock);
+       mutex_lock(&tpm_ppi_lock);
        if (!ppi_cache_populated) {
                len = cache_ppi_operations(chip->acpi_dev_handle, buf);
                if (len < 0) {
-                       spin_unlock(&tpm_ppi_lock);
+                       mutex_unlock(&tpm_ppi_lock);
                        return len;
                }

@@ -377,7 +377,7 @@ static ssize_t tpm_show_ppi_vs_operations(struct device *dev,
                        len += sysfs_emit_at(buf, len, "%d %d: %s\n",
                                                        i, ret, tpm_ppi_info[ret]);
        }
-       spin_unlock(&tpm_ppi_lock);
+       mutex_unlock(&tpm_ppi_lock);

        return len;
 }

I'll just push it to next as it does not make things worse and
right at the moment I don't have time to do conclusive testing
(and it is high certainty the correct fix).

BR, Jarkko

