Return-Path: <linux-integrity+bounces-4272-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A59BA9E10C0
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Dec 2024 02:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D725161455
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Dec 2024 01:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096B0847C;
	Tue,  3 Dec 2024 01:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AncE1MJx"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7FF25745
	for <linux-integrity@vger.kernel.org>; Tue,  3 Dec 2024 01:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733189032; cv=none; b=Wfz/f38kZWK/s3czTRzNvFIsPKWWspHRlnvbvIerxhlSYitjPpIGfAlPUQVlXbtXJUrbiY0yOnpOZN0oPEcQLvGAIP9MiMUwEIPbAhSN+OImxUJyjknn9qemy+C4gCdXJyKZZX+pVfusP3kxratoVKHtMH1KS1Q9hlrCaXno+7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733189032; c=relaxed/simple;
	bh=C2/PC1ZypqZswVys9659RV2tZzXp19PZ6Avu/KkJe0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oZ5rbe8pukytwRY+MAII3jlMZ4ENMMwsCArrah3fPpmH36BKWY8j26PPhXA7o6SiqL2HxRfewKZTshe0uZALbGoxxK2Lw5kzYm92sAGZVXPgbbCMKrfaY2uFWyvS+dwwz4+8l6ClXJySPHARh40/d/o3oBv2rxq0SlDhPlQZrXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AncE1MJx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733189030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C2/PC1ZypqZswVys9659RV2tZzXp19PZ6Avu/KkJe0k=;
	b=AncE1MJxszjrWjtJF9+JEnUmMcvEyY5ouMv6hSirNjXW5gzLhJM6e/1Y7ZEljHmf2RctlM
	GBqYITV6vCx6kqttMwt4RIbl4GKLkZHwy86o1M7rOhZrY14f8NAgo2rOcs+Nkz0WSefNxp
	i4+i6XXMG40TKDyq1H+xwHNIzi5lwV8=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-hLQd2eOcMh6MTFiQNc_APA-1; Mon, 02 Dec 2024 20:23:49 -0500
X-MC-Unique: hLQd2eOcMh6MTFiQNc_APA-1
X-Mimecast-MFC-AGG-ID: hLQd2eOcMh6MTFiQNc_APA
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-211c1c131c4so52756785ad.1
        for <linux-integrity@vger.kernel.org>; Mon, 02 Dec 2024 17:23:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733189028; x=1733793828;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C2/PC1ZypqZswVys9659RV2tZzXp19PZ6Avu/KkJe0k=;
        b=Omr5pTRNhNbYXHbuIp7LfDvci0uyG04p12SzRf/3ax+le7wxtU/4sCxYAck1yZ2ptP
         wgUfrra00TgiZPXef+qpghdSMkU6aVYAafgHBN1N4MTS1TUenbDMcQwRLFlD5iFiuI6Z
         WpYV15PI7ydh2SicX///rQyXvpPCC3n8pLDQElG3VzmhvE8ncgGvzZLxZahKEq6y3P6u
         GALYsMDSlfknp/d8whJ3+FFTCxBdla+AKAfbEqeHSRUll0dGmDaHvKIpvh++vEHRg51s
         RZDYzNh3+/m+BC42Z7MeC8FHEl0tXlT+P15h0Hz/jGVlNy5+NBHnyf92aCcK/JoIYUTr
         v7XA==
X-Forwarded-Encrypted: i=1; AJvYcCVCig2cHZ2gupy1gpqLyZZOjINb7NGBGLsIxEFaAGbSurRpNQScKHsJhzYAvxywFUCnF2BtTLKooFChwDn2VMo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6BMHXHRObQvWdXdNgzTWpXTs46YBSUy5vY9GFa7a/lumJn63j
	bSeTx/t7PG06cMZ94ADls7IauKVA361bfgVh93jxp3eQBALSHafYHDwBUkez3EJV6WBbmPHqrI+
	Wal3clfKa9azrStlQ3afzSblSm0qpBIWGK6J7rG7DiH1n9d9aCCoz2Ay1AGFcXPozM0c8tUk4Mw
	==
X-Gm-Gg: ASbGncusHNU0Aq08jjo+l+V7oYC5XExJg6t6poCwBP4KBoGafayxm+M6ypc2a9aiN4/
	OKMXIOqHQmsMIOmEump5dMvyecJ34qVoILzi+xnnecefaxk9kpRUgLa6YFeAlAnyDcYwxV7Sdsc
	nQ+Y5j30c4ZdegxTNfks1E5UJRwEQRwncfCbZ5qd8QVjxQav/QbZjnunm+UeaBW+RPWWBXaZU3n
	8UNEqDryAkmYyad6bApgTpH9TdSKx5NsSWIf4yl0mJZqUuEKqA=
X-Received: by 2002:a17:902:cec7:b0:215:a3e4:d26b with SMTP id d9443c01a7336-215a3e4dc89mr65627895ad.0.1733189027857;
        Mon, 02 Dec 2024 17:23:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEcnlTkOEYdvVSwQb5f9BrlBHCoY4NdIqDAtzR19zkNXnGj7T2eKbjQ4ASSxLtdeMBsVBvjVg==
X-Received: by 2002:a17:902:cec7:b0:215:a3e4:d26b with SMTP id d9443c01a7336-215a3e4dc89mr65627645ad.0.1733189027600;
        Mon, 02 Dec 2024 17:23:47 -0800 (PST)
Received: from [10.72.112.98] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215b0887f58sm8629995ad.208.2024.12.02.17.23.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 17:23:46 -0800 (PST)
Message-ID: <2779c1f7-28fd-415f-a016-da3aa077659b@redhat.com>
Date: Tue, 3 Dec 2024 09:23:37 +0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LTP] [PATCH] doc: correct the build steps for
 open_posix_testsuite
To: Cyril Hrubis <chrubis@suse.cz>
Cc: ltp@lists.linux.it, linux-integrity@vger.kernel.org
References: <20241119101357.951813-1-xiubli@redhat.com>
 <Z0mXHSnqmstCIMrF@yuki.lan> <a32c6381-8779-4dc5-878b-a46bff6454d6@redhat.com>
 <Z02PZRGzw5qM3z0w@yuki.lan>
Content-Language: en-US
From: Xiubo Li <xiubli@redhat.com>
In-Reply-To: <Z02PZRGzw5qM3z0w@yuki.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 12/2/24 18:43, Cyril Hrubis wrote:
> Hi!
>> Wait.
>>
>> I check it again. I think we should do it under
>> 'testcases/open_posix_testsuite/' too ? For me it doesn't work only do
>> this just before 'cd testcase/...'
> Ah it's a bit more complicated that I remmebered. There are two ways how
> to compile the open posix testsuite.
>
> The top level configure script configures the open posix testsuite, but
> you have to pass the --with-open-posix-testsuite flag to it.
>
> Or you can run the open posix configure from the open posix directory.
>
Yeah, this looks better.

Does it make sense to fix the doc about this ? If so I will send the V3.

Thanks

- Xiubo


