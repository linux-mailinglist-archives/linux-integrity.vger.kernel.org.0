Return-Path: <linux-integrity+bounces-899-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A2883E4F9
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Jan 2024 23:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B5631C21279
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Jan 2024 22:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56171249E6;
	Fri, 26 Jan 2024 22:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Cg7IaZWW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D55A46447
	for <linux-integrity@vger.kernel.org>; Fri, 26 Jan 2024 22:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706307280; cv=none; b=t46Ah1qHHBVtyeUOkpp/pNL8CWi81x+h9sWx/+YoB0l9D4jn8jMUag5YxS04pai8pNZCMiF1EjllQeQZQn05SbbWHhMu//dV1JVMGmg8ufOmtplMp9dp15E6TQYUejWSjCEFZOXQOjQp0A7FVLfFAYdE9vXHi/+8pm/D8o32qOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706307280; c=relaxed/simple;
	bh=0gmkN3yaFwqsZqUzjahvvfez/w99dFq/wbKB8lPy5hc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HGsf9FzzZcnTHgW5kaJSSymHaYcOa2xvIWwN5rQ2/YvOqO5t6stmea5ri1gx9WJH6UVCs4LOBGrVF0KnPSEwKPGfX9VP/KezuZMZ2frTrkqQlSzp7Q0gcC1tU6J5rxFIAE95oAsDrY7oKLklt80wUXosbtMJkLR12lKVXpTnCyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Cg7IaZWW; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.86.69] (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 089A920E61A3;
	Fri, 26 Jan 2024 14:14:38 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 089A920E61A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1706307278;
	bh=GXmiqod9xX64NJifX2j5khOOeqYMJKmC3UctX+BeH7I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Cg7IaZWWOGAkmTgE1/gjjTuwvQR0/9qlswNmx6ZSrYDC0mjXnXKwdZTK34HkB8/7B
	 +VMOZKOT+b7akv+iCMBbuc9SbE1XGNyp18UyVFB6xJIgIeSbN1wu46in7jAyMZvpYK
	 JDbDxC3Pl5pDIRNhivdtAJowv9JlWI8GYpsWzY5I=
Message-ID: <283233af-52cc-4d13-b0b2-79d9be6b99c5@linux.microsoft.com>
Date: Fri, 26 Jan 2024 14:14:37 -0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/7] ima: define and call ima_alloc_kexec_file_buf
Content-Language: en-US
To: Stefan Berger <stefanb@linux.ibm.com>, zohar@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, noodles@fb.com,
 bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20240122183804.3293904-1-tusharsu@linux.microsoft.com>
 <20240122183804.3293904-2-tusharsu@linux.microsoft.com>
 <2c4e98bc-8e26-4df1-8567-04d81d2c3963@linux.ibm.com>
 <efc24a43-2ebb-4fa4-814a-7c0ad5ef022e@linux.ibm.com>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <efc24a43-2ebb-4fa4-814a-7c0ad5ef022e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thanks for catching this Stefan.

On 1/23/24 19:38, Stefan Berger wrote:
>>>       kbuf.buffer = kexec_buffer;
>>>       kbuf.bufsz = kexec_buffer_size;
>>>       kbuf.memsz = kexec_segment_size;
>>
>>
>> A dent with this patch when only applying this patch:
>>
>> Two consecutive kexec loads lead to this here:
>>
>> [   30.670330] IMA buffer at 0x3fff10000, size = 0xf0000
>> [   32.519618] ------------[ cut here ]------------
>> [   32.519669] Trying to vfree() nonexistent vm area (00000000093ae29c)
>> [   32.519762] WARNING: CPU: 11 PID: 1796 at mm/vmalloc.c:2826 
>> vfree+0x254/0x340
>> [   32.519786] Modules linked in: bonding tls rfkill sunrpc 
>> virtio_console virtio_balloon crct10dif_vpmsum fuse loop zram bochs 
>> drm_vram_helper drm_kms_helper drm_ttm_helper ttm ibmvscsi 
>> scsi_transport_srp drm virtio_blk virtio_net vmx_crypto net_failover 
>> crc32c_vpmsum failover pseries_wdt drm_panel_orientation_quirks 
>> scsi_dh_rdac scsi_dh_emc scsi_dh_alua dm_multipath
>> [   32.519939] CPU: 11 PID: 1796 Comm: kexec Not tainted 6.5.0+ #112
>> [   32.519953] Hardware name: IBM pSeries (emulated by qemu) POWER8E 
>> (raw) 0x4b0201 0xf000004 of:SLOF,git-5b4c5a hv:linux,kvm pSeries
>> [   32.519973] NIP:  c0000000004bd004 LR: c0000000004bd000 CTR: 
>> c00000000017ef00
>> [   32.519986] REGS: c00000004593b670 TRAP: 0700   Not tainted  (6.5.0+)
>> [   32.519999] MSR:  8000000002029033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 
>> 44424842  XER: 00000000
>> [   32.520023] CFAR: c0000000001515b0 IRQMASK: 0
>>                 GPR00: c0000000004bd000 c00000004593b910 
>> c000000001e17000 0000000000000038
>>                 GPR04: 00000000ffffbfff c00000004593b6e8 
>> c00000004593b6e0 00000003f9580000
>>                 GPR08: 0000000000000027 c0000003fb707010 
>> 0000000000000001 0000000044424842
>>                 GPR12: c00000000017ef00 c00000003fff1300 
>> 0000000000000000 0000000000000000
>>                 GPR16: 0000000000000000 0000000000000000 
>> 0000000000000000 0000000000000000
>>                 GPR20: 0000000000000000 0000000000000000 
>> 0000000000000003 0000000000000004
>>                 GPR24: 00007fffeab0f68f 000000000000004c 
>> 0000000000000000 c00000002bdce400
>>                 GPR28: c000000002bf28f0 0000000000000000 
>> c008000004770000 0000000000000000
>> [   32.520180] NIP [c0000000004bd004] vfree+0x254/0x340
>> [   32.520212] LR [c0000000004bd000] vfree+0x250/0x340
>> [   32.520225] Call Trace:
>> [   32.520232] [c00000004593b910] [c0000000004bd000] vfree+0x250/0x340 
>> (unreliable)
>> [   32.520250] [c00000004593b990] [c00000000091d590] 
>> ima_add_kexec_buffer+0xe0/0x3c0
>> [   32.520296] [c00000004593ba90] [c000000000280968] 
>> sys_kexec_file_load+0x148/0x9b0
>> [   32.520333] [c00000004593bb70] [c00000000002ea84] 
>> system_call_exception+0x174/0x320
>> [   32.520372] [c00000004593be50] [c00000000000d6a0] 
>> system_call_common+0x160/0x2c4
>> [   32.520408] --- interrupt: c00 at 0x7fffa52e7ae4
>> [   32.520420] NIP:  00007fffa52e7ae4 LR: 0000000108481d8c CTR: 
>> 0000000000000000
>> [   32.520452] REGS: c00000004593be80 TRAP: 0c00   Not tainted  (6.5.0+)
>> [   32.520483] MSR:  800000000000f033 <SF,EE,PR,FP,ME,IR,DR,RI,LE>  
>> CR: 24424202  XER: 00000000
>> [   32.520507] IRQMASK: 0
>>                 GPR00: 000000000000017e 00007fffeab09470 
>> 00007fffa53f6f00 0000000000000003
>>                 GPR04: 0000000000000004 000000000000004c 
>> 00007fffeab0f68f 0000000000000000
>>                 GPR08: 0000000000000000 0000000000000000 
>> 0000000000000000 0000000000000000
>>                 GPR12: 0000000000000000 00007fffa559b280 
>> 0000000000000002 0000000000000001
>>                 GPR16: 0000000000000000 0000000000000000 
>> 0000000000000000 0000000000000000
>>                 GPR20: 00007fffa53f0454 00007fffa53f0458 
>> 0000000000000000 0000000000000001
>>                 GPR24: 0000000000000000 00007fffeab0f64d 
>> 0000000000000006 0000000000000000
>>                 GPR28: 0000000000000003 00007fffeab09530 
>> 00007fffeab09b08 0000000000000007
>> [   32.520767] NIP [00007fffa52e7ae4] 0x7fffa52e7ae4
>> [   32.521192] LR [0000000108481d8c] 0x108481d8c
>> [   32.521587] --- interrupt: c00
>> [   32.521981] Code: 3884c208 4bfc20f1 60000000 0fe00000 60000000 
>> 60000000 60420000 3c62ff94 7fc4f378 38632b20 4bc944cd 60000000 
>> <0fe00000> eba10068 4bffff34 2c080000
>> [   32.522823] ---[ end trace 0000000000000000 ]---
>> [   32.536347] Removed old IMA buffer reservation.
>> [   32.536473] IMA buffer at 0x3fff10000, size = 0xf0000
>>
>> This vfree here probably has to go:
>>
>>          ret = kexec_add_buffer(&kbuf);
>>          if (ret) {
>>                  pr_err("Error passing over kexec measurement 
>> buffer.\n");
>>                  vfree(kexec_buffer);
>>                  return;
>>          }
>>
> 
> The vfree may need to be removed or replaced with 
> ima_free_kexec_file_buf() but it doesn't seem to solve the problem alone.
> I got rid of this issue later with this:
> 
> static void ima_reset_kexec_file(struct seq_file *sf)
> {
>          sf->buf = NULL;
>          sf->size = 0;
>          sf->read_pos = 0;
>          sf->count = 0;
> }
> 
> static void ima_free_kexec_file_buf(struct seq_file *sf)
> {
>          vfree(sf->buf);
>          ima_reset_kexec_file(sf);
> }
> 
> [...]
> 
I was able to repro the issue by calling kexec 'load' multiple times on 
patch #1.  Good catch, thanks.

Earlier I was testing the multiple 'load' scenario on the last patch only.
Here onward I will call it on each of the patch individually.

> @@ -170,6 +175,9 @@ void ima_add_kexec_buffer(struct kimage *image)
>          image->ima_segment_index = image->nr_segments - 1;
>          image->is_ima_segment_index_set = true;
> 
> +       /* kexec owns kexec_buffer since kexec_add_buffer and will 
> vfree() it */
> +       ima_reset_kexec_file(&ima_kexec_file);
> +
>          pr_debug("kexec measurement buffer for the loaded kernel at 
> 0x%lx.\n",
>                   kbuf.mem);
> 
> 
Thanks for the suggested solution. Looks like you applied it on top of
patch #3.
I applied it on patch #1, and it seems to be working.

I will dig deeper to ensure it doesn't cause any memory leaks, and will 
incorporate it in v5.

Thanks again.

~Tushar

>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec 

