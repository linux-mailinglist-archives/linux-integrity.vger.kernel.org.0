Return-Path: <linux-integrity+bounces-7636-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C47C6F42A
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Nov 2025 15:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3721E4FDA92
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Nov 2025 14:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4AD329C67;
	Wed, 19 Nov 2025 14:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LYzGnCut";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gtqQg3rg"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB9733438C
	for <linux-integrity@vger.kernel.org>; Wed, 19 Nov 2025 14:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763561349; cv=none; b=IQa04gcrJaCw3r4J3qrP/MjHpRgNZmOp4Y7QE43FxHLHxi2hGd3+GyprP0bRMkVS/fxB8vli2lhWMU1BZ6cRi43qOUOblzAJ+pW0H4OkO3THJYQPup/OJfBSRBHgjWDZ2/JeAM50okx8ljTX02NRZL2jYVPoWNLzd3PKPPkpLRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763561349; c=relaxed/simple;
	bh=NkmEpXSuwuLhgk3lS0PQKXSpIu4CRN0uCwVXZNwYT+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OkHFWEoI6Dbvo/9mHIB087eLFIxGakGtZpcpF7voKTE/J4UmzN5fBih0CBrESX1x8zQF6I0IVvDBMtcAcFJVd6kz2rRyrlnS+Aqb1wi+WFxIWVv48Hcm18GqXFUVhcnhdM2AeiPpLUD9385V8Xa5VFxiUWq8IQ+isGqyJH0CyQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LYzGnCut; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gtqQg3rg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763561341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sRv4gN6lbv1SmMMciAbtKT3jfXKjBM1qenldjai+GsI=;
	b=LYzGnCutMRmCN+j0zR7YLmFV6NcUCmLtFa132KlS9qkwDtyluqQsg6Jyhs9LLRPbra01oH
	3ll+1xYL3wMu23MTpkG7FB0aAJbK2ttTlFzIt1QuxPpAORrijj7F4aRdszBZOMp6NrjXuk
	H6m4CBc4vG6O77ZQPCaMz2QrgRMzq84=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-Dh1wkuH_PCC3PLWUTSFm_w-1; Wed, 19 Nov 2025 09:09:00 -0500
X-MC-Unique: Dh1wkuH_PCC3PLWUTSFm_w-1
X-Mimecast-MFC-AGG-ID: Dh1wkuH_PCC3PLWUTSFm_w_1763561340
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2980ef53fc5so131269255ad.1
        for <linux-integrity@vger.kernel.org>; Wed, 19 Nov 2025 06:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763561339; x=1764166139; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sRv4gN6lbv1SmMMciAbtKT3jfXKjBM1qenldjai+GsI=;
        b=gtqQg3rgFxMRvEkC6UTmEB63pajC6ammzUYSCCIeKpGiBwhtMDGP91V3KYzvhLaRQ9
         5/EXzzdxURF5kfyOhYlqEpYpVDbGI2nWgFQ/Ebc0KAzK7aHoiWOKH1lTNOHcZm0IqgRA
         BcDgHss+BRtoCDdDSLtHBT37+GkbljqBwg982ylwUWXnj60Us52KiMhY3sZBb91oeD6A
         81QNU+cyVig01Nqkkki50GtfUrcVglNQ/xsHPWR8Tr0wWbHD7VVQTTiCe6XnbZbk9z6v
         5ReVj/UTfm+vHFeyoNrZinwkfr0NC+OSN+8dLb0+mn/5ImpXPMmxXz5FTrQGEPGtl+TX
         pJUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763561339; x=1764166139;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sRv4gN6lbv1SmMMciAbtKT3jfXKjBM1qenldjai+GsI=;
        b=wJyya0OPAGNcH2bFE6K+aNParyv4IaDImY3kxZmo3W5+2Z3UVZ9Z2ZW6T2dhPukwOM
         g9csJLiLdmWA1Fhyl/sgMIBRHTF2DoQpeo4hov2lmrr9K60yMvHe+rBqC8LhUMAC+SJ4
         lIMujGqEUrm/Jafb9/u9DZ1mum0X5gB+jZqi7l0L+7X/qXg6hDi85vv/9igW/1F4qmzB
         VQt+uo5VfCMlL0A/Qykht4DIiFGiFsY6fJAqH52kYNmUb+/X1+a2BCRwHGMwRoT+0/T0
         Kv1UID5OKw14BEQ2mHs9lkQha00l0R9KBleOhVPwyw13S5JkZpW1ujBwUYgbfwcjQabh
         NT5A==
X-Gm-Message-State: AOJu0YwA1PJqoCPRZl/Jn3MJmz/NfZIcUlWRKtpgTAFuwbyfB2F6C1vo
	8OWGIwnBXljD8qPMKhSOg/jJgBYvkcIyE0tMMawD5THtVsYZDryO1p1IXdkqpV02IXP/UyoOr8E
	roM61ZGYbNAMFjVHrrdxf5NmYFX3gx/2Z9YGtri8pGdkCJc1VPH0b95KGxZDQM5lBdPbvZg==
X-Gm-Gg: ASbGncszOCvQTBSXfpZEGxXrMpD/kZmNXravSvhHWqMAvr5INWbaTjojp+isPbcf++V
	X8KMg4Eju4isHY2a0BkizFI8xXOiSWslGfoVPO8FwEq5Ek0gBdHJ4cyCuI/eCTIJ5bas4mNuEIr
	XVwW0xBU1qjCSRSzdfT8laaLeSsI6G5MEMNm66XInLpvPlJwqLbxe3qHsbfdaQC5mKwyg53bBmH
	Yy4WhHzLiinLfQ+/yLIxDNo4jIv23jITcRGxcDzeGN/eot7E0WQFw4h10edEG61zVMbyAe3Aldb
	xNXsjxYUbKjYxBcSWh7UX/23bDYlkMeiyJBQX0/vE3BI1PEz6SoXsqsiqJc5nZ+MTU6QL6blrZ4
	5
X-Received: by 2002:a17:902:dac5:b0:295:39d9:8971 with SMTP id d9443c01a7336-2986a6b8d39mr259786815ad.1.1763561339351;
        Wed, 19 Nov 2025 06:08:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFoYZmE59xp6Ipi5eyc2g8cV1kiLGsM5qO/CIP4bd1FKcfYa3EkB3JPo0oIjCnqmz99Neumpg==
X-Received: by 2002:a17:902:dac5:b0:295:39d9:8971 with SMTP id d9443c01a7336-2986a6b8d39mr259786235ad.1.1763561338591;
        Wed, 19 Nov 2025 06:08:58 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c23487esm206193675ad.20.2025.11.19.06.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 06:08:58 -0800 (PST)
Date: Wed, 19 Nov 2025 22:05:50 +0800
From: Coiby Xu <coxu@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, Karel Srot <ksrot@redhat.com>, 
	Paul Moore <paul@paul-moore.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Fan Wu <wufan@kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>, "open list:MODULE SUPPORT" <linux-modules@vger.kernel.org>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, "open list:SELINUX SECURITY MODULE" <selinux@vger.kernel.org>
Subject: Re: [PATCH v3] ima: Access decompressed kernel module to verify
 appended signature
Message-ID: <yiwtnidayji53irhrowznu75ajedrsu6pwh7xzjplcyzmifz6u@7epealeg3ssa>
References: <20251031074016.1975356-1-coxu@redhat.com>
 <20251119034718.618008-1-coxu@redhat.com>
 <fc1d67e411ef53460517db4c03bdcf1b9d9f8a8f.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <fc1d67e411ef53460517db4c03bdcf1b9d9f8a8f.camel@linux.ibm.com>

On Wed, Nov 19, 2025 at 08:29:22AM -0500, Mimi Zohar wrote:
>Hi Coiby,

Hi Mimi,

>
>On Wed, 2025-11-19 at 11:47 +0800, Coiby Xu wrote:
>> Currently, when in-kernel module decompression (CONFIG_MODULE_DECOMPRESS)
>> is enabled, IMA has no way to verify the appended module signature as it
>> can't decompress the module.
>>
>> Define a new kernel_read_file_id enumerate READING_MODULE_COMPRESSED so
>> IMA can know only to collect original module data hash on
>> READING_MODULE_COMPRESSED and defer appraising/measuring it until on
>> READING_MODULE when the module has been decompressed.
>
>This paragraph is a bit awkward.  Perhaps something like:
>
>-> so IMA can calculate the compressed kernel module data hash and defer
>measuring/appraising ...
>
>>
>> Before enabling in-kernel module decompression, a kernel module in
>> initramfs can still be loaded with ima_policy=secure_boot. So adjust the
>> kernel module rule in secure_boot policy to allow either an IMA
>> signature OR an appended signature i.e. to use
>> "appraise func=MODULE_CHECK appraise_type=imasig|modsig".
>>
>> Reported-by: Karel Srot <ksrot@redhat.com>
>> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
>> Suggested-by: Paul Moore <paul@paul-moore.com>
>> Signed-off-by: Coiby Xu <coxu@redhat.com>
>
>Thanks, Coiby!
>
>The patch applies cleanly to linus' tree, but needs to be applied to next-
>integrity.  Please re-base.

I've sent v4 which has been rebased onto next tree with improved
wording as suggested.

>
>-- 
>
>thanks,
>
>Mimi
>

-- 
Best regards,
Coiby


