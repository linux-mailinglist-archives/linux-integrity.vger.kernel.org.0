Return-Path: <linux-integrity+bounces-7562-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AF67BC2F1B4
	for <lists+linux-integrity@lfdr.de>; Tue, 04 Nov 2025 04:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8EF5A4F7902
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Nov 2025 03:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2BF26E165;
	Tue,  4 Nov 2025 03:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I2FUxMSi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="o7nR5xVA"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEF026CE1E
	for <linux-integrity@vger.kernel.org>; Tue,  4 Nov 2025 03:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762225820; cv=none; b=U4f+QgDjW5/FwX1+wPVMg0+29WJIaxbTPGS8ga+P4sEuAkRpi/3z5TVoaQ8cT15rbizw/vck5DejRMzn05uEbysKGBcP+sgjZEBq7c1nHDTfDt6UxIg3Y1d+p9Un+bCCgqcz6b8Au2e73LVgw937Bbvq8nr16R3GtQs4Z8ns7QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762225820; c=relaxed/simple;
	bh=DiA02NHiJ8O13whq/TwVMMOrAZYKp8grfsQGnMI6BdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UmLwpBbhPcFs4mY44n49UaX/+c2rt/nil/XqH35WrZXiN3uWHTdHr1t47GKFOvi+lb5/zMMm0vy1dbR36rB7mxVVXuRR45S/ZH9h8ZwV3x4Z051PDIJ3JL0dpGscNx6AXW3wptc9/239K4m2xw6wy2QEftWQiRwkRQffLTAMZ5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I2FUxMSi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=o7nR5xVA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762225817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dZTqdWMqaOCDAV9eOD4rL4mzlFe+T9sHs56gI9JdcQ0=;
	b=I2FUxMSi2k7dG+qdWwoll/9V6xMq17xJgar/qDHjP6GIwtVfGg1O2m5WryfUclctIngKW/
	M4p+YY0+eGlRF2fhVB2atN0ZfrD3i8UVevaDdKfxegJ/+km8z8diiNunpsjWUeslgCpMwU
	SIdJT/cArXb68AoQ6ZHT3PIFaO9higA=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-Zz02yyn7NlSNqmOcJ8mSew-1; Mon, 03 Nov 2025 22:10:14 -0500
X-MC-Unique: Zz02yyn7NlSNqmOcJ8mSew-1
X-Mimecast-MFC-AGG-ID: Zz02yyn7NlSNqmOcJ8mSew_1762225813
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7a99a5f77e0so4377611b3a.2
        for <linux-integrity@vger.kernel.org>; Mon, 03 Nov 2025 19:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762225813; x=1762830613; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dZTqdWMqaOCDAV9eOD4rL4mzlFe+T9sHs56gI9JdcQ0=;
        b=o7nR5xVAP8jRFNJZ3SvcD7yir8J7lpcW6dAyiLCL5nQ9OKF183irXKyGl3xeZ97bq5
         obTsb2VPQzY4KDKez6rGM8JslnnmpBwM1Y7zMp+Sr14yclswFk2/sruAN6pUv82NgcHT
         mHsB1b0LcGwrcgfpoeGiHlhRn/360e8Z3JEUZIKl/WAW43Z7jGTfFh0Nk4Gg87Wya+zr
         MbVL8T5m3yBS7bWOx6xHg2NhGm3kL928S9XuvxtCrer9qrCDg84Ei8bmbPk+PGbVONyb
         CzV8kuXxPTMzarCzZeIjcKEAjP7ZjxgXAhdi9IV07Jk59UhOFX8a5mY3mQxhnDxk1T7N
         e6+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762225813; x=1762830613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dZTqdWMqaOCDAV9eOD4rL4mzlFe+T9sHs56gI9JdcQ0=;
        b=V07jk59UCDEGXVkpoXcLbwUHdcpi1rwCduwhSGChVx0NQrynCXLk+p87Q4ZwnRgK5M
         Q3qJXoT42+EWNWXQGquihtaGYcvpexXLinteXOOPZ0aiamixDFdUdV+Of8iuYawF+l2G
         ln2PRc1UPPlVTtCD88z/2RtMNmDfUaGIsetc4dFLh8PDHt1JvKswGoUB5DfqXcDKj3Rc
         YIO2XflAVX+yZZCe7EqSOe0j3Da9+bCL8QEaBiM2hBeND0sBiVrEUPeaqvubF8cl7tHg
         FulnmuPZbbSjpgvddwTZhXDa0TudJxnBhGnqBbT0YiUxN8vTxbAqcNjCrKF4PjmZCsLe
         zQDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWKan0mqC6tx6fcA0W3yWk/52Sjs/Ee3UJsOksIB9s19/cKobpryFtkI6a58k3x/eSsibYR+soxXj5NN+fC/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCU22iciV37srpjD+n84dauLPJhjRwbjR7Nw2iIFl0Dsu6BeSb
	V90QRqson15kDYSDkllLavDL0kx/dcQqvys2DmW4SGdAPww3f6GSD4unzK5V8OrhGWz1hxwX21Q
	plgwc6xQGSygEZtYhcWxY0S5LLF4aZ/idHs/sDdCFItUpizo6Nij4/DM3gw60gWCVW8wWmA==
X-Gm-Gg: ASbGncukGaER7dR6a3Xhg6foQ7KgfQIjEfw+neUhUo9jFAK3a5OY6rzdWfXUcixdpG+
	W3RZdzKEAEIbofL/LkSvjmusKmg5puf2wPAQRPr8TS4EoKXHv/yJSCbGySA3L3SNvJS1lM6At8T
	HRl0OnHF8XMBnq/rOFOOYQKhL00AxUYFvmZ/4uVrFZoMn0YVX6c5AwmC/nbqpgGVJAllhIdU6Gt
	MvlDDb16WSeuktQ0mZjdjP/dis/1spusXBvSCC9etQdxf1INqI6ZxddjjmbKOkEkK3MsDCsmAHc
	Sayzr8y6cRfDsVLQN1fk/FACVB4I+Ygd01U7RZIQHFiKhb0jkXmSKjv6kZDuUuDYiQ==
X-Received: by 2002:a05:6a20:734c:b0:342:a7cd:9211 with SMTP id adf61e73a8af0-348cbea958dmr18363396637.34.1762225813211;
        Mon, 03 Nov 2025 19:10:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGm5fBbSRyZNOxCgqY4a03dPe7CQzSGiGCw0qKW97bKKyfx2XbG2IugOoPF3SL9x4EH14/L9Q==
X-Received: by 2002:a05:6a20:734c:b0:342:a7cd:9211 with SMTP id adf61e73a8af0-348cbea958dmr18363337637.34.1762225812487;
        Mon, 03 Nov 2025 19:10:12 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f1a19e70sm635985a12.7.2025.11.03.19.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 19:10:12 -0800 (PST)
Date: Tue, 4 Nov 2025 11:05:46 +0800
From: Coiby Xu <coxu@redhat.com>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-modules@vger.kernel.org, linux-integrity@vger.kernel.org, 
	kernel test robot <lkp@intel.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, "open list:MODULE SUPPORT" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] module: Only declare set_module_sig_enforced when
 CONFIG_MODULE_SIG=y
Message-ID: <dvbgwskini45clhmqx2py46yzgwejqrna3uccempvfeip7opdq@vgfxrj46mmeq>
References: <20251031080949.2001716-1-coxu@redhat.com>
 <w4vqvjighjl33a32gvwnu7xlzmp6yztx42gbjixrhic3wt34j6@5flsq5omspn7>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <w4vqvjighjl33a32gvwnu7xlzmp6yztx42gbjixrhic3wt34j6@5flsq5omspn7>

On Fri, Oct 31, 2025 at 04:09:27PM -0400, Aaron Tomlin wrote:
>On Fri, Oct 31, 2025 at 04:09:48PM +0800, Coiby Xu wrote:
>> Currently, set_module_sig_enforced is declared as long as CONFIG_MODULES
>> is enabled. This can lead to a linking error if
>> set_module_sig_enforced is called with CONFIG_MODULE_SIG=n,
>>
>>     ld: security/integrity/ima/ima_appraise.o: in function `ima_appraise_measurement':
>>     security/integrity/ima/ima_appraise.c:587:(.text+0xbbb): undefined reference to `set_module_sig_enforced'
>>
>> So only declare set_module_sig_enforced when CONFIG_MODULE_SIG is
>> enabled.
>>
>> Note this issue hasn't caused a real problem because all current callers
>> of set_module_sig_enforced e.g. security/integrity/ima/ima_efi.c
>> depend on CONFIG_MODULE_SIG=y.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202510030029.VRKgik99-lkp@intel.com/
>> Signed-off-by: Coiby Xu <coxu@redhat.com>
>> ---
>>  include/linux/module.h | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/linux/module.h b/include/linux/module.h
>> index e135cc79acee..fa251958b138 100644
>> --- a/include/linux/module.h
>> +++ b/include/linux/module.h
>> @@ -769,8 +769,6 @@ static inline bool is_livepatch_module(struct module *mod)
>>  #endif
>>  }
>>
>> -void set_module_sig_enforced(void);
>> -
>>  void module_for_each_mod(int(*func)(struct module *mod, void *data), void *data);
>>
>>  #else /* !CONFIG_MODULES... */
>> @@ -865,10 +863,6 @@ static inline bool module_requested_async_probing(struct module *module)
>>  }
>>
>>
>> -static inline void set_module_sig_enforced(void)
>> -{
>> -}
>> -
>>  /* Dereference module function descriptor */
>>  static inline
>>  void *dereference_module_function_descriptor(struct module *mod, void *ptr)
>> @@ -924,6 +918,8 @@ static inline bool retpoline_module_ok(bool has_retpoline)
>>  #ifdef CONFIG_MODULE_SIG
>>  bool is_module_sig_enforced(void);
>>
>> +void set_module_sig_enforced(void);
>> +
>>  static inline bool module_sig_ok(struct module *module)
>>  {
>>  	return module->sig_ok;
>> @@ -934,6 +930,10 @@ static inline bool is_module_sig_enforced(void)
>>  	return false;
>>  }
>>
>> +static inline void set_module_sig_enforced(void)
>> +{
>> +}
>> +
>>  static inline bool module_sig_ok(struct module *module)
>>  {
>>  	return true;
>>
>> base-commit: e53642b87a4f4b03a8d7e5f8507fc3cd0c595ea6
>> --
>> 2.51.0
>>
>>
>
>Looks good to me.
>
>Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>

Hi Aaron,

Thanks for reviewing the patch!

>
>-- 
>Aaron Tomlin
>

-- 
Best regards,
Coiby


