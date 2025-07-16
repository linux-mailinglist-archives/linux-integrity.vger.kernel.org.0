Return-Path: <linux-integrity+bounces-6646-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E465B07583
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Jul 2025 14:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E89C1889CCA
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Jul 2025 12:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0682F5094;
	Wed, 16 Jul 2025 12:23:59 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AD42F3C30;
	Wed, 16 Jul 2025 12:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752668639; cv=none; b=Y/HHM8XaU6ApVP7hZJp5EGa6iFDTDZiQoDXqOnPk21dbT77HzmR+byHl5F5QyT0qdNN3Eof60DtpVS6gmKd4qQqo5A4/Ecmf/ZuxwJEteFZFGbFKvt2dn5Aj0cu1Eweb4XJAxpX9St5i68G5AmHm9YjaYINeUH1tuaeGr1vnwX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752668639; c=relaxed/simple;
	bh=KVsft50jqR5g6kgeSU/ed0dTQRFgHT8sNc6O7D0eFLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lab5tVJJHHsJEhZu/UfOOd9q0pUtQEzknKDZ2J5Q+2RLyhJ6nqvGEyMwAXNw+nHxusPdUXi1mgj7sNm6nz1j9az8MeLraU/5i47v0TVbEwhd0A7hurv003RU9c2ZeGopjxg883uYNupH3sOci6iiOD9SBpACVMwlzJ2GpsSmp/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id B5FF461E6479F;
	Wed, 16 Jul 2025 14:23:04 +0200 (CEST)
Message-ID: <9193c59f-3982-42f4-9b05-c6cdefe3b05c@molgen.mpg.de>
Date: Wed, 16 Jul 2025 14:23:04 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] tpm, tpm_vtpm_proxy: boot-time TPM
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
 linux-integrity@vger.kernel.org, Stefan Berger <stefanb@linux.ibm.com>,
 Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
 Jonathan Corbet <corbet@lwn.net>, Peter Huewe <peterhuewe@gmx.de>,
 Jason Gunthorpe <jgg@ziepe.ca>, Andrew Morton <akpm@linux-foundation.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>,
 Frank van der Linden <fvdl@google.com>, linux-doc@vger.kernel.org
References: <20250716121823.173949-1-jarkko@kernel.org>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250716121823.173949-1-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Jarkko,


Am 16.07.25 um 14:18 schrieb Jarkko Sakkinen:
> From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>

Congratulations on the new(?) job! Big thanks to that company to do 
upstream Linux kernel work.

> Provide a kernel command-line parameter named as `supplicant`, which
> contains a path to an TPM emulator binary. When defind, the kernel will

defin*e*d

> launch the program during boot-time.
> 
> This feature is most useful in feature testing e.g., in environments
> where other means are not possible, such as CI runners. Its original use
> case highlights also quite well of its applicability for pre-production
> hardware: it was used to provide a TPM implemnentation for a RISC-V SoC

implementation

> running on FPGA with no TPM HW implementation at the time.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> ---
> Bumped into this in my archives so thought to make it available just in
> case anyone is interested.

Do you have such a TPM emulator binary?

Thank you for upstreaming this.

> ---
>   .../admin-guide/kernel-parameters.txt         | 14 +++++
>   drivers/char/tpm/tpm_vtpm_proxy.c             | 51 +++++++++++++++++++
>   2 files changed, 65 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index f1f2c0874da9..e062de99480e 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -7230,6 +7230,20 @@
>   			defined by Trusted Computing Group (TCG) see
>   			https://trustedcomputinggroup.org/resource/pc-client-platform-tpm-profile-ptp-specification/
>   
> +	tpm_vtpm_proxy.supplicant= [TPM]
> +			When defined, this field must contain a legit path to a
> +			program emulating a TPM chip, which will be started
> +			during the driver initialization, thus providing a
> +			mechanism for the user space have an emulated TPM from
> +			the get go. Kernel prepares the process with a file
> +			pre-opened file descriptor in the index 3 for
> +			/dev/vtpmx.
> +
> +			An emulator can optionally provide support for
> +			localities by reacting to the vendor command defined
> +			by the driver: 0x20001000. Its payload is a single
> +			byte containing the new locality.
> +
>   	tp_printk	[FTRACE]
>   			Have the tracepoints sent to printk as well as the
>   			tracing ring buffer. This is useful for early boot up
> diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtpm_proxy.c
> index 0818bb517805..612f5251fdc0 100644
> --- a/drivers/char/tpm/tpm_vtpm_proxy.c
> +++ b/drivers/char/tpm/tpm_vtpm_proxy.c
> @@ -51,6 +51,8 @@ struct proxy_dev {
>   #define VTPM_PROXY_FLAGS_ALL  (VTPM_PROXY_FLAG_TPM2)
>   
>   static struct workqueue_struct *workqueue;
> +static char *supplicant;
> +module_param(supplicant, charp, 0);
>   
>   static void vtpm_proxy_delete_device(struct proxy_dev *proxy_dev);
>   
> @@ -678,6 +680,55 @@ static const struct file_operations vtpmx_fops = {
>   	.llseek = noop_llseek,
>   };
>   
> +static int vtpmx_supplicant_setup(struct subprocess_info *info, struct cred *new)
> +{
> +	struct vtpm_proxy_new_dev dev = { .flags = VTPM_PROXY_FLAG_TPM2 };
> +	struct file *file = vtpm_proxy_create_device(&dev);
> +
> +	if (IS_ERR(file))
> +		return PTR_ERR(file);
> +
> +	fd_install(dev.fd, file);
> +	return 0;
> +}
> +
> +static void vtpmx_supplicant_cleanup(struct subprocess_info *info)
> +{
> +}
> +
> +static int vtpmx_supplicant_init(void)
> +{
> +	static const char * const argv[] = { supplicant, NULL };
> +	struct subprocess_info *info;
> +	int ret;
> +
> +	if (!supplicant)
> +		return 0;
> +
> +	info = call_usermodehelper_setup(argv[0], (char **)argv, NULL,
> +					 GFP_KERNEL, vtpmx_supplicant_setup,
> +					 vtpmx_supplicant_cleanup, NULL);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	ret = call_usermodehelper_exec(info, UMH_KILLABLE | UMH_NO_WAIT);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int vtpmx_init(void)
> +{
> +	int ret;
> +
> +	ret = vtpmx_supplicant_init();
> +	if (ret)
> +		return ret;
> +
> +	return misc_register(&vtpmx_miscdev);
> +}
> +
>   static struct miscdevice vtpmx_miscdev = {
>   	.minor = MISC_DYNAMIC_MINOR,
>   	.name = "vtpmx",


Kind regards,

Paul

