Return-Path: <linux-integrity+bounces-5043-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49017A4C6FF
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Mar 2025 17:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AED60176CB4
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Mar 2025 16:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE842253B0;
	Mon,  3 Mar 2025 16:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g7sgoETh"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56B1227EBF
	for <linux-integrity@vger.kernel.org>; Mon,  3 Mar 2025 16:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741018763; cv=none; b=jQKbzKrYi+69mNrPzWagQ/pUu8hcH1tVy6fTXQSQUk33oldeygnrtV+G64ggzROumfWTwkHcuZH1vggxVKhFBw8MsB2pluCLHGnMPyOyWr627tTd+w5hEozuo92I0M+RTyZ6kgUN4JrxDqvUwOtcLPZiqwA19mORRXuSH619TD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741018763; c=relaxed/simple;
	bh=kkHQcZoTJndCnwcbB9E+wpOiprPx3EnYCYUyF+KeBqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sw7ka9jWshNhToB0oIq+H7OgDRhu6QxyUzCOJgik0CZ+/Bq0EjAsBZ2a6TGT4tLrSTbLU4VIvQBb+8z6QmxSACVxs/qZXd5gRszj7mZDxs5xqKc3T6kz65b+H/FEvWJuqcDNuI7utw+AQ2AI4T6voxxW1EOxVpW0bqQY0eKS2zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g7sgoETh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741018760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L5XdYcpLAdNxNfxY8Lfqw4ebX+gqF0nBQ5UXPPTJPbQ=;
	b=g7sgoEThBZ8vKPnCF7JSDFg+kngQNgcl2u2u3N0c6cVAK+MNHACxVFEX0Si4uVfzaCUIPU
	UWcVtLpXnIMRALNvoyslx4exmmUlzj9FQiMzlTmgkAM1FHbqx295a90/3uk5h5w3VLkNFo
	7HgSPHwoAE5yw8ta4VygosMIhSprjBA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-sZZD1bJ-PvSJwMdsIplMYg-1; Mon, 03 Mar 2025 11:19:12 -0500
X-MC-Unique: sZZD1bJ-PvSJwMdsIplMYg-1
X-Mimecast-MFC-AGG-ID: sZZD1bJ-PvSJwMdsIplMYg_1741018751
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3910034500eso757834f8f.1
        for <linux-integrity@vger.kernel.org>; Mon, 03 Mar 2025 08:19:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741018751; x=1741623551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5XdYcpLAdNxNfxY8Lfqw4ebX+gqF0nBQ5UXPPTJPbQ=;
        b=IVBxrU8NTjlsjzk/pT9CUrB6sBIhFsOD7zhTS/l94o0cyJ7eT6xZEJ0UVrBdIi6a4O
         l6xA7ssJcYVehV4KzA8eIqQMaTHdNDePvgLR7OUI2LDzXL+177YtTKXiN4NQGz+INpF1
         ubF6s/C1NIEhqmx+E1WJu/VkCMKWbeb5WlMGSMX39gAFBC3NBlXU9k26El+chZlM8+v3
         +GG0u7TFQ5pautLrtarPEbU/jWORoXkBJk+v3TV1rsmQrEw7TgZ6PanShx4V86242nZO
         OJJdofKRALMHDxiUiSLRo/4nno3IAaws7vtUNu7+N4/CI2y9LrPFu6DHQXCYnUR8q2VB
         ItKw==
X-Forwarded-Encrypted: i=1; AJvYcCW6fcwnPoFgG0m/FiAoptan1hRkke84HtAgCR9YTbN22eCaoNBltisWeURXi/TYFLl5mq8HRExXFtwf95h7TXY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy518AJI2SUm/t+ZZGPnuzbg2wm8AkXCFH/YqFK1vLM6zlpe0yK
	Zr2+9RF7Xj+EPVj5yQ+3HknrqWH0R7KsQeOpc2N0ZMSrWT7+QLLF6O+lLfmTA4veLHR4NBHWGUH
	yi1nPmlX2bKTG+2/gQQrzShUgELF0EsY7xz7JO3peaRinwVIatvgqsSZH269PgzgC5Q==
X-Gm-Gg: ASbGncs6wN7DVDNBNzCFycFAQyIT66V1V7wm5Gg0ADuhhOsD4GskWMq3NCl12K+AVxN
	hJyORi0GcYTxvx+greYO7wtD4yHZVT5raG+848ZAUJ72oDIR2OVtWf96qWJMlAbEJerDQJk8d7t
	DUBMP4dWXXklZsO74s+EcKD2OncRRZ0uXaKMA+5jUqPVNQxm74nEZxWID1ymDUmhNiT4COG0kCk
	z9JuPjZNP3c/m+Uh/x4msCdjkLP21DO7HY1kTxMN8WwwFaYEaTac4U9kTJRsAzJQejgeork4yfr
	7yr02yeh5Htm1p+zdSSF+7ZRDB33BQXrsSIdoF6e6KyE/veTNkACdAvfYDWCSkrm
X-Received: by 2002:a05:6000:2ac:b0:391:42f:7e94 with SMTP id ffacd0b85a97d-391042f836emr4415534f8f.18.1741018751450;
        Mon, 03 Mar 2025 08:19:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNgTP7CW85b75d/hToTcBGfinaj7PcJa9xIMaekWrZFC7WO4fkAD1vXiloSjC5Lawdn0s6dg==
X-Received: by 2002:a05:6000:2ac:b0:391:42f:7e94 with SMTP id ffacd0b85a97d-391042f836emr4415499f8f.18.1741018750944;
        Mon, 03 Mar 2025 08:19:10 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba53943asm193042295e9.19.2025.03.03.08.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 08:19:10 -0800 (PST)
Date: Mon, 3 Mar 2025 17:19:05 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Claudio Carvalho <cclaudio@linux.ibm.com>, 
	Peter Huewe <peterhuewe@gmx.de>, x86@kernel.org, Dov Murik <dovmurik@linux.ibm.com>, 
	linux-coco@lists.linux.dev, Dionna Glaze <dionnaglaze@google.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dave Hansen <dave.hansen@linux.intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC PATCH v2 5/6] tpm: add SNP SVSM vTPM driver
Message-ID: <45ze5sxvcvg2ituxrefw6konxtwjgs4zs5bscrp2khfqkf3jb4@zozeerbmtik5>
References: <20250228170720.144739-1-sgarzare@redhat.com>
 <20250228170720.144739-6-sgarzare@redhat.com>
 <20250301002819.GO5011@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250301002819.GO5011@ziepe.ca>

On Fri, Feb 28, 2025 at 08:28:19PM -0400, Jason Gunthorpe wrote:
>On Fri, Feb 28, 2025 at 06:07:19PM +0100, Stefano Garzarella wrote:
>> +/*
>> + * tpm_svsm_remove() lives in .exit.text. For drivers registered via
>> + * module_platform_driver_probe() this is ok because they cannot get unbound
>> + * at runtime. So mark the driver struct with __refdata to prevent modpost
>> + * triggering a section mismatch warning.
>> + */
>
>??? Is that really true? I didn't know that

I initially followed drivers/virt/coco/sev-guest/sev-guest.c to figure 
out how to clean a driver registered with 
module_platform_driver_probe(), then I saw that pattern with the same 
comment is used in several other drivers.

>
>I thought you could unbind anything using /sys/../unbind?

I can't see `unbind` for this driver:

   $ ls /sys/bus/platform/drivers/tpm-svsm/
   module	tpm-svsm  uevent

While I can see it for example for others like fw_cfg:

   $ ls /sys/bus/platform/drivers/fw_cfg
   bind  module  QEMU0002:00  uevent  unbind

BTW I can unload the `tpm-svsm` module. Loading it again will cause 
issues if I don't have a remove function that calls 
tpm_chip_unregister().

Thanks,
Stefano


