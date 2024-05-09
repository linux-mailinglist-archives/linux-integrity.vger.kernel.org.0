Return-Path: <linux-integrity+bounces-2354-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A5B8C0B88
	for <lists+linux-integrity@lfdr.de>; Thu,  9 May 2024 08:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6821C1F239AC
	for <lists+linux-integrity@lfdr.de>; Thu,  9 May 2024 06:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7849138DE8;
	Thu,  9 May 2024 06:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="fsiaFvae"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A132F4A
	for <linux-integrity@vger.kernel.org>; Thu,  9 May 2024 06:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715236331; cv=none; b=K4ZIqql+1p+g6g/hqDS6rVMzodelJXQw+gIj3GerJC7SRcGnJkQZ6IydnyBOs/zasrOAJT2+2zKJ5dIvjHjMci0ZKjZSWIrRNWvww/n3VdLsP64LFBxhO2k0rQ1jQErNGMT7Xq4v5grAp6F8m2ZWQ73hmTR1/NUQXCBADoGEEcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715236331; c=relaxed/simple;
	bh=DVbVgDvfhP+VeJ3ICc7r3fQfOhEW9FMXSSlwS63/C04=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cOQDwdf0iUsFGVHT+WAgfFj6wZNENtYAcqx2LLAM+ayUeBFd7DamXCiVhc5rz1L95imIiUUSUcG7weFT7idwj+iYvYBrTIqJnUcyP2b/EXCIpfaR9saU2EH1sc9ffY4w7+oGJsL/YTIeF0miqOcW+5R+3606sWb7JsDge9ii/os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=fsiaFvae; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 954C91C3C9C;
	Thu,  9 May 2024 08:32:06 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1715236326; bh=efG3zK0vKcyGk9qTSSHOK3oDZCuzuyL7s8iDujt9W14=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fsiaFvaeIO1yoIVjC02r2h5+4oCgd528m2/Elrx/HYZ37kkBOwxe0mkftqoNlyOaT
	 lsdmomHOLQHvZPX0gS+mlnbBqBcOMAkgplAa0ZpF9fymben+E8wq8i8XAKuWf/NVtm
	 iyPftgTGY4b1FGSCb78qp+lgSjFUXL5fb2VyL/iJrSVDG1GUB1DAIhIWCVVgwvTC14
	 BbYekJIBPMIxBQod5+lcYEk7HH0rbp4UOQuXYKJx9QNAIwC81r+2ktNqLRWD0XO9Ow
	 9uLheolhMl40dFK2v6KrpGhtsvE71/9tSHuNIMVL3oiQL36ISC9mbwaAFbbKJqaIjI
	 Gjysq3ffjrYPg==
Date: Thu, 9 May 2024 08:32:05 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Cc: zohar@linux.ibm.com, roberto.sassu@huaweicloud.com,
 roberto.sassu@huawei.com, eric.snowberg@oracle.com, stefanb@linux.ibm.com,
 ebiederm@xmission.com, noodles@fb.com, bauermann@kolabnow.com,
 linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
 code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Subject: Re: [PATCH v5 5/8] ima: kexec: move IMA log copy from kexec load to
 execute
Message-ID: <20240509083205.17d53ccb@meshulam.tesarici.cz>
In-Reply-To: <20240214153827.1087657-6-tusharsu@linux.microsoft.com>
References: <20240214153827.1087657-1-tusharsu@linux.microsoft.com>
	<20240214153827.1087657-6-tusharsu@linux.microsoft.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Feb 2024 07:38:24 -0800
Tushar Sugandhi <tusharsu@linux.microsoft.com> wrote:

> ima_dump_measurement_list() is called during kexec 'load', which may
> result in loss of IMA measurements during kexec soft reboot.  It needs
> to be called during kexec 'execute'.
> 
> This patch includes the following changes:
>  - Call kimage_file_post_load() from kexec_file_load() syscall only for
>    kexec soft reboot scenarios and not for KEXEC_FILE_ON_CRASH.  It will
>    map the IMA segment, and register reboot notifier for the function
>    ima_update_kexec_buffer() which would copy the IMA log at kexec soft
>    reboot.
>  - Make kexec_segment_size variable local static to the file, for it to be
>    accessible both during kexec 'load' and 'execute'.
>  - Move ima_dump_measurement_list() call from ima_add_kexec_buffer()
>    to ima_update_kexec_buffer().
>  - Remove ima_reset_kexec_file() call from ima_add_kexec_buffer(), now
>    that the buffer is being copied at kexec 'execute', and resetting the
>    file at kexec 'load' will corrupt the buffer.
> 
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> ---
>  kernel/kexec_file.c                |  3 ++
>  security/integrity/ima/ima_kexec.c | 45 +++++++++++++++++++-----------
>  2 files changed, 32 insertions(+), 16 deletions(-)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index fe59cb7c179d..2d5df320c34f 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -410,6 +410,9 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
>  
>  	kimage_terminate(image);
>  
> +	if (!(flags & KEXEC_FILE_ON_CRASH))
> +		kimage_file_post_load(image);
> +
>  	ret = machine_kexec_post_load(image);
>  	if (ret)
>  		goto out;
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index 1d4d6c122d82..98fc9b9782a2 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -19,6 +19,7 @@
>  #ifdef CONFIG_IMA_KEXEC
>  static struct seq_file ima_kexec_file;
>  static void *ima_kexec_buffer;
> +static size_t kexec_segment_size;
>  static bool ima_kexec_update_registered;
>  
>  static void ima_reset_kexec_file(struct seq_file *sf)
> @@ -129,7 +130,6 @@ void ima_add_kexec_buffer(struct kimage *image)
>  	/* use more understandable variable names than defined in kbuf */
>  	void *kexec_buffer = NULL;
>  	size_t kexec_buffer_size;
> -	size_t kexec_segment_size;
>  	int ret;
>  
>  	/*
> @@ -154,14 +154,6 @@ void ima_add_kexec_buffer(struct kimage *image)
>  		return;
>  	}
>  
> -	ret = ima_dump_measurement_list(&kexec_buffer_size, &kexec_buffer,
> -					kexec_segment_size);
> -	if (ret < 0) {
> -		pr_err("%s: Failed to dump IMA measurements. Error:%d.\n",
> -		       __func__, ret);
> -		return;
> -	}
> -

After removing these lines...

>  	kbuf.buffer = kexec_buffer;
>  	kbuf.bufsz = kexec_buffer_size;
                     ^^^^^^^^^^^^^^^^^

... kexec_buffer_size is uninitialized here.

Petr T

