Return-Path: <linux-integrity+bounces-1529-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 353FD86E009
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Mar 2024 12:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B205D1F2305A
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Mar 2024 11:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C376BFC6;
	Fri,  1 Mar 2024 11:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="A1Xc3mzp"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845F76995C
	for <linux-integrity@vger.kernel.org>; Fri,  1 Mar 2024 11:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709292050; cv=none; b=Tmf/mS5b09aFQtaXPo/9fwfItxgoNwr3X8epQmX0CcLeiZ9G0yXYRgLX/QHlY/J83zGyQ4Xgf+ntgmieQrDWxNLMApBmhN6hTljLuq/j61OPcB48ghnBNbunBmmlgEfxfjnFqEgtVLrl1Io9cJS1TPdbSVXalVm+Lo13Iz+YXMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709292050; c=relaxed/simple;
	bh=T8U5F/5ZmzCqOBKhn+Yu6eZsSN3WS941AB/N2BZgfE0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WAhkAgXeT87iIhTwhfomlmRO2aMgFezdXvxGAWXK/XlLk3N6dOebB4tA0No9zwY0nRwC6E45Oev/JA8FG9WXtkMzEukxhIFSlp6/A2u+z0JadmTt+jWRKEXMLv23TDMzC3I/31Z51xYpdwlVnoBOI6nEQ2vyB0VJn1osQQMbbfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=A1Xc3mzp; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id AEAF41C0A52;
	Fri,  1 Mar 2024 12:12:23 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1709291543; bh=XSBoTq4bOiHd3evrpzuKLxQ+GPngWacdjSd3NjxyXYA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A1Xc3mzpSkj+2F0Q4cYvRYPKN3N3f34JUAEo1H+VFC//ZfwOePXof1W0359zO0pYK
	 qAQJpcnWlHVzewjVyOYWZxLoqBrqVZhTmJDIY/1CWU/dGln+6Q06XQJCC2zC/fVWwM
	 xc2PKeGkgdig3dnQInjmHcaUCyzL24u3JcYNxMOjCRgRXYnQeWw8/zn2R8F43NERqu
	 glsEOivimXeyt/nizkmla0bRaax/Pr5q2JfyF71QHExQFMNA00956PS25G1FfVh8pI
	 aCxNjCPf5bqwcTUDfd7xQaZ2+WWMdhTxIdOCp9hWSBKKpxcY99WHjmOKb+je7UTEAl
	 xOjH/4Zama8Mg==
Date: Fri, 1 Mar 2024 12:12:22 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Cc: zohar@linux.ibm.com, roberto.sassu@huaweicloud.com,
 roberto.sassu@huawei.com, eric.snowberg@oracle.com, stefanb@linux.ibm.com,
 ebiederm@xmission.com, noodles@fb.com, bauermann@kolabnow.com,
 linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
 code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com,
 bhe@redhat.com
Subject: Re: [PATCH v5 4/8] ima: kexec: define functions to copy IMA log at
 soft boot
Message-ID: <20240301121222.7d03756e@meshulam.tesarici.cz>
In-Reply-To: <20240214153827.1087657-5-tusharsu@linux.microsoft.com>
References: <20240214153827.1087657-1-tusharsu@linux.microsoft.com>
	<20240214153827.1087657-5-tusharsu@linux.microsoft.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Feb 2024 07:38:23 -0800
Tushar Sugandhi <tusharsu@linux.microsoft.com> wrote:

> IMA log is copied to the new Kernel during kexec 'load' using 
> ima_dump_measurement_list().  The log copy at kexec 'load' may result in
> loss of IMA measurements during kexec soft reboot.  It needs to be copied
> over during kexec 'execute'.  Setup the needed infrastructure to move the
> IMA log copy from kexec 'load' to 'execute'. 
> 
> Define a new IMA hook ima_update_kexec_buffer() as a stub function.
> It will be used to call ima_dump_measurement_list() during kexec 
> 'execute'.   
> 
> Implement kimage_file_post_load() and ima_kexec_post_load() functions
> to be invoked after the new Kernel image has been loaded for kexec.
> ima_kexec_post_load() maps the IMA buffer to a segment in the newly
> loaded Kernel.  It also registers the reboot notifier_block to trigger
> ima_update_kexec_buffer() at exec 'execute'.
> 
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> ---
>  include/linux/ima.h                |  3 ++
>  kernel/kexec_file.c                |  5 ++++
>  security/integrity/ima/ima_kexec.c | 46 ++++++++++++++++++++++++++++++
>  3 files changed, 54 insertions(+)
> 
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index 86b57757c7b1..006db20f852d 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -49,6 +49,9 @@ static inline void ima_appraise_parse_cmdline(void) {}
>  
>  #ifdef CONFIG_IMA_KEXEC
>  extern void ima_add_kexec_buffer(struct kimage *image);
> +extern void ima_kexec_post_load(struct kimage *image);
> +#else
> +static inline void ima_kexec_post_load(struct kimage *image) {}
>  #endif
>  
>  #else
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 0e3689bfb0bb..fe59cb7c179d 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -186,6 +186,11 @@ kimage_validate_signature(struct kimage *image)
>  }
>  #endif
>  
> +void kimage_file_post_load(struct kimage *image)
> +{
> +	ima_kexec_post_load(image);
> +}
> +
>  /*
>   * In file mode list of segments is prepared by kernel. Copy relevant
>   * data from user space, do error checking, prepare segment list
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index ccb072617c2d..1d4d6c122d82 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -12,10 +12,14 @@
>  #include <linux/kexec.h>
>  #include <linux/of.h>
>  #include <linux/ima.h>
> +#include <linux/reboot.h>
> +#include <asm/page.h>
>  #include "ima.h"
>  
>  #ifdef CONFIG_IMA_KEXEC
>  static struct seq_file ima_kexec_file;
> +static void *ima_kexec_buffer;
> +static bool ima_kexec_update_registered;
>  
>  static void ima_reset_kexec_file(struct seq_file *sf)
>  {
> @@ -184,6 +188,48 @@ void ima_add_kexec_buffer(struct kimage *image)
>  	kexec_dprintk("kexec measurement buffer for the loaded kernel at 0x%lx.\n",
>  		      kbuf.mem);
>  }
> +
> +/*
> + * Called during kexec execute so that IMA can update the measurement list.
> + */
> +static int ima_update_kexec_buffer(struct notifier_block *self,
> +				   unsigned long action, void *data)
> +{
> +	return NOTIFY_OK;
> +}
> +
> +struct notifier_block update_buffer_nb = {
> +	.notifier_call = ima_update_kexec_buffer,
> +};
> +
> +/*
> + * Create a mapping for the source pages that contain the IMA buffer
> + * so we can update it later.
> + */
> +void ima_kexec_post_load(struct kimage *image)
> +{
> +	if (ima_kexec_buffer) {
> +		kimage_unmap_segment(ima_kexec_buffer);
> +		ima_kexec_buffer = NULL;
> +	}
> +
> +	if (!image->ima_buffer_addr)
> +		return;
> +
> +	ima_kexec_buffer = kimage_map_segment(image,
> +					      image->ima_buffer_addr,
> +					      image->ima_buffer_size);
> +	if (!ima_kexec_buffer) {
> +		pr_err("%s: Could not map measurements buffer.\n", __func__);
> +		return;
> +	}
> +
> +	if (!ima_kexec_update_registered) {
> +		register_reboot_notifier(&update_buffer_nb);

Specifically this means that the notifier is run from kernel_kexec()
through kernel_restart_prepare(). At that point the kernel is still
running at full speed, i.e. new IMA measurements can be added to the
list.

I believe it would be better to add a "kexec late notifier list" which
would be notified just before kmsg_dump() in kernel_kexec(). Functions
on that list would be called in a more quiet context, i.e. after other
CPUs and most devices have been shut down.

I can see that the current proposal does not address passing the IMA
measurements to a panic kernel, but I'm adding Baoquan nevertheless.
Would it make sense to implement such a late notifier list for the
crash kexec case. I know that in general, it is no good idea to run
more code in a crashed kernel context, but what about self-contained
things like copying IMA measurements?

Petr T

