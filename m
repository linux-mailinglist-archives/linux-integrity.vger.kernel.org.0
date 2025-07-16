Return-Path: <linux-integrity+bounces-6647-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F55B07D16
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Jul 2025 20:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 531A97B7AFC
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Jul 2025 18:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88AC029B200;
	Wed, 16 Jul 2025 18:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vJO3Z5WI"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952F9188A3A;
	Wed, 16 Jul 2025 18:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752691452; cv=none; b=XdpA/7o3+3ZrWnw2DkRqA5/zTRsLZ0MT2Fl750sxaPJXcqiZ6NpvcnsfQJNGZQWAiXSj2gBx28kxIsLw3Tbi0xzm+dm0JSbQMqxASYLCVyuIIupixFAvohh/7Gtd4eImHdE29jbswijeckne1x68QM+8cocC9yKb5OvIANAR2VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752691452; c=relaxed/simple;
	bh=H/UhfH/UokN99g637wobOS9cbry1x5qXgto7yjFY4ag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O82msgzMA1UuEHbYkA72wZP6NMNTzio/pc+bDD5Nd6xWE72x9Q3CqpPhJ19nUAobOa1Ug7MlU3qhmWW0hq+Z/lfltEPEOq5zBQO+Vjp5NKkQ3BSNXNuA+xjxz6jzpN7VvZJ0mjzSbkaY/5ZdqwUvBFeRYPO2T4iZaKxGunrWjSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vJO3Z5WI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=pyfFofk4+rHlS825JirWA6ODvtQNZleuH6XhENxvc6Q=; b=vJO3Z5WIqa493yE7wWZ30sODik
	vaR9uAICxAilMkm05KIc+Zlp0jfwp7eTVa0JCYuM0En0QOwT9qogIIibBgA9adr3FwEd7YEh3k0fF
	QIuLDq2OvDwWbEnVAu5xFkmeK3GHoKIBwQTzmreqJYp6iohgFspuZMyoOyOYIuIbWpUYT4FPtzIvT
	R4kIY+FA7rpQJeitDD9lTqAzRaWuPLxX1k0LhrYBZ+rlMebt2vNdwjwQCLkAKRR/JK4QbP9tz5CT6
	BXg+tTP+uV87kW1oi7ih4QtLo+GuqYARe2Ho0NpmpjVDxD8sXAOf4sbyPCp8wTYOx/ZZp4HWyOgAR
	FEAnG4pA==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uc76q-00000008Q9A-3RNM;
	Wed, 16 Jul 2025 18:44:04 +0000
Message-ID: <bfcc3a24-b48c-48a6-8280-07f7a2669e6b@infradead.org>
Date: Wed, 16 Jul 2025 11:44:02 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] tpm, tpm_vtpm_proxy: boot-time TPM
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-kernel@vger.kernel.org
Cc: keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
 Stefan Berger <stefanb@linux.ibm.com>,
 Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
 Jonathan Corbet <corbet@lwn.net>, Peter Huewe <peterhuewe@gmx.de>,
 Jason Gunthorpe <jgg@ziepe.ca>, Andrew Morton <akpm@linux-foundation.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>,
 Frank van der Linden <fvdl@google.com>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
References: <20250716121823.173949-1-jarkko@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250716121823.173949-1-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

(mostly nits, along with Paul's comments)


On 7/16/25 5:18 AM, Jarkko Sakkinen wrote:
> From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> 
> Provide a kernel command-line parameter named as `supplicant`, which
> contains a path to an TPM emulator binary. When defind, the kernel will

                  to a TPM

> launch the program during boot-time.
> 
> This feature is most useful in feature testing e.g., in environments

                                         testing, e.g.,

> where other means are not possible, such as CI runners. Its original use
> case highlights also quite well of its applicability for pre-production
> hardware: it was used to provide a TPM implemnentation for a RISC-V SoC
> running on FPGA with no TPM HW implementation at the time.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> ---
> Bumped into this in my archives so thought to make it available just in
> case anyone is interested.
> ---
>  .../admin-guide/kernel-parameters.txt         | 14 +++++
>  drivers/char/tpm/tpm_vtpm_proxy.c             | 51 +++++++++++++++++++
>  2 files changed, 65 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index f1f2c0874da9..e062de99480e 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -7230,6 +7230,20 @@
>  			defined by Trusted Computing Group (TCG) see
>  			https://trustedcomputinggroup.org/resource/pc-client-platform-tpm-profile-ptp-specification/
>  
> +	tpm_vtpm_proxy.supplicant= [TPM]
> +			When defined, this field must contain a legit path to a

			                                        legitimate
or			                                        valid

> +			program emulating a TPM chip, which will be started
> +			during the driver initialization, thus providing a
> +			mechanism for the user space have an emulated TPM from
> +			the get go. Kernel prepares the process with a file

			    get-go.
or just don't use slang terms.

> +			pre-opened file descriptor in the index 3 for
> +			/dev/vtpmx.
> +
> +			An emulator can optionally provide support for
> +			localities by reacting to the vendor command defined
> +			by the driver: 0x20001000. Its payload is a single
> +			byte containing the new locality.
> +
>  	tp_printk	[FTRACE]
>  			Have the tracepoints sent to printk as well as the
>  			tracing ring buffer. This is useful for early boot up

thanks.
-- 
~Randy


