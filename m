Return-Path: <linux-integrity+bounces-5540-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6884AA78634
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Apr 2025 03:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F05B7A2919
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Apr 2025 01:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916CE1426C;
	Wed,  2 Apr 2025 01:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f5oM2jE4"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F2DFC0A
	for <linux-integrity@vger.kernel.org>; Wed,  2 Apr 2025 01:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743558010; cv=none; b=Yh8VWHYn+GUV7+fkIzIJ2TSOtCdfv4j4nXUYlsHrJITH+YJhK4P9Nwkz1nycHani6KOwHaP9unvzekt0mI5PUniW95q49jhgH0iR8ctenuJK0PPe24t3KNqR1yXuE8FAaWR+STnI85DafYfeumpxKCHeDJeBVUqWiiP77U5IAj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743558010; c=relaxed/simple;
	bh=w5QaFG3n8eTuSO1MH5JiaPPWAIOXBUCe+qkt6gTzHKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FYnEZcga+xAqVmz0GNHTV9MUlCbpqHGpHwchb9y1XWKSeB8ZMj7t4U2mucZ3Ad1bDBpqAkhY37+LeM8sd3eRbdoMYxWvlMlsM7cdO7KwhtRkhs664rdP9Rt+rbDgrzP4VYUf78q7DLfBLYCXQWJrbMS7cM/FVvLo6mFKn7hiV3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f5oM2jE4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743558007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/k0YNeB6UyiHRw5bzlnGVGO6Th6xGTizhYj16Y2ixXU=;
	b=f5oM2jE4CzYaX2ckqUjZTq1hyFJlWsDg4V1q8X/AWH1cK/J00VuEKATRxEN+VuHPQEOPpb
	3flWHZxlodI2qCRm5Hkyb5YEy//EH3UkV17CUATCsxrFCRl3QgSLYg67zn7+w/gz9aPNKa
	XttYOGiUCoM4CubLUk7ukBaluNVuZFk=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-puEQbBoEOPSuF9_b0uQNVQ-1; Tue, 01 Apr 2025 21:40:06 -0400
X-MC-Unique: puEQbBoEOPSuF9_b0uQNVQ-1
X-Mimecast-MFC-AGG-ID: puEQbBoEOPSuF9_b0uQNVQ_1743558005
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2242ce15cc3so115040885ad.1
        for <linux-integrity@vger.kernel.org>; Tue, 01 Apr 2025 18:40:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743558005; x=1744162805;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/k0YNeB6UyiHRw5bzlnGVGO6Th6xGTizhYj16Y2ixXU=;
        b=jG27EUxaLIvRU94Pgj1Aa2pVAbEi6mu9HzhWUGltqNCFWKtn8f3PIXW+Amsfzd0fR0
         2AoFGq6MLV9iSpkOclKfQR5VZoMnQxRH8E31GJ3Ic2pf8vuwTTnvTZ2kPDWqtlDgPmHU
         HEAWLVqFjXO0QcZZY09on72T1IbcflCGpBBl1DG0ZSMiGH0EB9cRT4Kv8Xa/tsvqZEtU
         Sz8XQNMspK4FhEUX8IubTpssFbkiLaz/m2uzX4U5rbVOvccHDWntFmOfUGcuX4OlAL8K
         9l1Wzb10aIKglwOMPQALc94lDuH8XcLwxoGllaMtZCaG7QH26PaoXtuf7IuwdFFrDrJv
         xHOg==
X-Forwarded-Encrypted: i=1; AJvYcCXSE36ycG4yFDMt6r7rz4st8ipdyMJ/8NbMDkvqdnDJGNe7LKPo2MYpGfG1OizTEFka0OcQNv+xdDCUtpgugkU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2wqYS2xPN8HnvZ8fq9KssFiQ/ZUns9+3Mx3rALviBEOP9f4qh
	SPFUDukleFVCc8RU7wsrh2XgMV4yFsJ9ooj3OPVHkOtFWiSvE33pGTJqv192EvfSzLKaMvxxbMW
	rDgFykvRgoGajRFOaFkKLFVD3qtCrG6RsU/Ut3I7DBc/5/LGDQknA6juJnvmNWANV5g==
X-Gm-Gg: ASbGnctOFo2IeCoyEXZXS3bDiYY5noEF/5patFwXAWkzmXF6E6F66+4lJ6BFcjuCDYe
	3wK1lvnwbyQhU3MoylSRhvKDAm7A+lR8tJcztpaSaehi++PPznpDa3bNrdSQ2XRPvXMxIfQtvg4
	E8bpex4darrOcxRq3ecIXLZOEQZFzgedXyH5hiYYO+PF2ozCWZfyQfyRPCRIDC3yMikmyAYXaJx
	+QACpdg/wuFjqZSibnFsy5Pb2nYWQA0Qlc60t1uc2QvbWvT0TPsH8PeEGcZGHNfEisiWTZxk72z
	4FqJRko=
X-Received: by 2002:a17:902:d2cd:b0:224:1eab:97b5 with SMTP id d9443c01a7336-2292f94944emr221795805ad.1.1743558005031;
        Tue, 01 Apr 2025 18:40:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZOUh4MmWk+aGZXLGBKMqkfsxmI8ex3akUdiud/F0qCd7uEBlf0i0UkeBJ4QOm7cMCaSHkBA==
X-Received: by 2002:a17:902:d2cd:b0:224:1eab:97b5 with SMTP id d9443c01a7336-2292f94944emr221795595ad.1.1743558004648;
        Tue, 01 Apr 2025 18:40:04 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7397106ad9bsm9729016b3a.117.2025.04.01.18.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 18:40:03 -0700 (PDT)
Date: Wed, 2 Apr 2025 09:38:10 +0800
From: Coiby Xu <coxu@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Baoquan He <bhe@redhat.com>, linux-integrity@vger.kernel.org, 
	kexec@lists.infradead.org
Subject: Re: [RFC PATCH] ima: add a knob to make IMA be able to be disabled
Message-ID: <fv7h5jfb4r6d5j6jjpgyjbv75zyzqpy6tbqn3ahzuewghnvrgd@5yclg75kr3cq>
References: <20250331061611.253919-1-bhe@redhat.com>
 <b1eba83a9f68ed9a19100f6c0dc5aca7aff437d5.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <b1eba83a9f68ed9a19100f6c0dc5aca7aff437d5.camel@linux.ibm.com>

On Mon, Mar 31, 2025 at 08:15:08AM -0400, Mimi Zohar wrote:
>On Mon, 2025-03-31 at 14:16 +0800, Baoquan He wrote:
>> It doesn't make sense to run IMA functionality in kdump kernel, and that
>> will cost extra memory. It would be great to allow IMA to be disabled on
>> purpose, e.g for kdump kernel.
>>
>> Hence add a knob here to allow people to disable IMA if needed.
>>
>> Signed-off-by: Baoquan He <bhe@redhat.com>
>> ---
>>  security/integrity/ima/ima_main.c | 21 +++++++++++++++++++++
>>  1 file changed, 21 insertions(+)
>>
>> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
>> index 28b8b0db6f9b..5d677d1389fe 100644
>> --- a/security/integrity/ima/ima_main.c
>> +++ b/security/integrity/ima/ima_main.c
>> @@ -38,11 +38,27 @@ int ima_appraise;
>>
>>  int __ro_after_init ima_hash_algo = HASH_ALGO_SHA1;
>>  static int hash_setup_done;
>> +static int ima_disabled = 0;
>>
>>  static struct notifier_block ima_lsm_policy_notifier = {
>>  	.notifier_call = ima_lsm_policy_change,
>>  };
>>
>> +static int __init ima_setup(char *str)
>> +{
>> +	if (strncmp(str, "off", 3) == 0)
>> +                ima_disabled = 1;
>> +        else if (strncmp(str, "on", 2) == 0)
>> +                ima_disabled = 0;
>> +        else
>> +                pr_err("invalid ima setup option: \"%s\" ", str);
>> +
>> +	return 1;
>> +}
>> +__setup("ima=", ima_setup);
>
>I understand your wanting to disable IMA for Kdump, but this goes way beyond
>that.  Please don't make it generic like this.
>
>Please refer to ima_appraise_parse_cmdline().

Hi Mimi,

To save memory for kdump, it seems init_ima has been to be skipped thus
ima=off is necessary (ima_appraise=off won't serve the purpose). Or do
you have any specific concerns in mind?

>
>Mimi
>
>> +
>> +
>> +
>>  static int __init hash_setup(char *str)
>>  {
>>  	struct ima_template_desc *template_desc = ima_template_desc_current();
>> @@ -1176,6 +1192,11 @@ static int __init init_ima(void)
>>  {
>>  	int error;
>>
>> +	if (ima_disabled) {
>> +		pr_info("IMA functionality is disabled on purpose!");
>> +		return 0;
>> +	}
>> +
>>  	ima_appraise_parse_cmdline();
>>  	ima_init_template_list();
>>  	hash_setup(CONFIG_IMA_DEFAULT_HASH);
>
>

-- 
Best regards,
Coiby


