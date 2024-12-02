Return-Path: <linux-integrity+bounces-4264-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC56F9DF78B
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Dec 2024 02:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59802B20F0B
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Dec 2024 01:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5599D6FC3;
	Mon,  2 Dec 2024 01:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JNCd0IqM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE6D3D81
	for <linux-integrity@vger.kernel.org>; Mon,  2 Dec 2024 01:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733101249; cv=none; b=kEnoQxrkjTpvJdjh8/wJfXguoTpsn2PUi2RlM+VhB/fYOSIb+eDltdYuqNw2iIpVMKenuHrWvQOCrBOH/dKmq0XCo089vQ7udbPGdvZPn/Nvl5JR+/4BnrA6x3RxYUW+RvQ4YXKiM94uloOICvcUVKrSwvipaAwjPSVOP2qmljQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733101249; c=relaxed/simple;
	bh=Jt8uHNpFLzr4nvHRRWIV9EeXJ76wTY3wXAuxA7qLyaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wdrz6HnxL1zrBMxuxTQurecaq7nW3PFY+JNXeiM+rI7q3blcQL/5zidJUI9GIIv6OuWuyoW94Ohsp6b9QZu2eX1ksnENKzZjn7Ya59AJ5rBl/Eil7zsquynH3XnOqfbukURVR4ZYxhTabav+G85ZS3YzkTznM++Z0vXmgxOxzHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JNCd0IqM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733101246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zXDjoyDGbdGJFrHTUV5STwitXMd9LhvrYV6xfcqauvY=;
	b=JNCd0IqMMOB0R4aX1b8ocv2DyImWRLP+C3BuTeflYxfRWzhFcECun7kLT6AuqOz04SK6Y6
	r0VVB47+xwoTRlE1gauFbHZE95uo9TDrQFcPLBAJPS33+2sxX2U/GoifkcltcCRjT/yHf9
	8y5z//xYqRs8TOuYptx55ZReexaqfeU=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-oJIlZe2TOMysYy8k6lkDXw-1; Sun, 01 Dec 2024 20:00:44 -0500
X-MC-Unique: oJIlZe2TOMysYy8k6lkDXw-1
X-Mimecast-MFC-AGG-ID: oJIlZe2TOMysYy8k6lkDXw
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7254237c888so3131746b3a.1
        for <linux-integrity@vger.kernel.org>; Sun, 01 Dec 2024 17:00:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733101244; x=1733706044;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zXDjoyDGbdGJFrHTUV5STwitXMd9LhvrYV6xfcqauvY=;
        b=ZSrOjEsMMB6ac+eNeLl1dgMWUnKzwJuEekchPp07ACRCxEj5uRNY2Z1RkGheiayZ5C
         W/cCHMnUIILEX8FSzKl893jFJxd7Lp7gubM57xtqje7Yhyin+XUGiIZSWqsSYnR1PmrL
         DwEQXCqA7kDEoGEu4CoCWHKJneChIGwhUZwL0kRcW/1gxpOKzevoak2s1z5xNfoj1DVg
         s/8EGrFY3oPX+0me2jtfuvWG4kyGJ97Q78ReloWkWOYmpzPXERgQ2Cb1Lg+RDpWBCXmG
         vN9WTUTUmAgp9UWutDGGc8Dg0HdMRlWlr4WWgqt1MXNAuZg53fHKCvgJ07HqQRxa6kt/
         bm1A==
X-Forwarded-Encrypted: i=1; AJvYcCXcinwOHgqpD13H+6CvqUKl1LM5lQsuzh7hZU/uM6uuA2yPdo4KTOCtPe8SmYmzzTFYEEllhXi2g8j9+6FqoaY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw05baP7zkhrOYpouT6pYZxUzqN0tjM8bRm8zHGwT/zAEiqD8yl
	VOtPxt4WXYbR4+1Xz7wLrGVz9hAV/UfxpBR6TwZljwNufcNVC435KjxZ8e2C6SrA9yvnpMStdvH
	jXOdEyQNKfTpk3XPqlLRkA1IqWzqpND7atKSfe7wlnH3b5DENR6bS+cBNJwQx0ALAbw==
X-Gm-Gg: ASbGncsX1mZWSOJ2vufOQQOfOTuF1keqRsMIBzKKC6Z3XxeaP42IcMawJ6/mKC5Y0l/
	VQd4E1JBPJRSnL3E/rf6xmnbv6N2GawEXroUFL478myE328BQB0cBw8gCvhGmpgONEaYYDt/ICD
	YOEDozgFMmoDk6Ty8Pey8Yu06YD6oufBobCfpVozIU4PMIu2NXM6F56CurL8v/BUci+RuOD5gJ0
	RU8daCCiBt3jotaTfh9KSqh+0uQqcZnGW5tWT3ztoubIWEPjvc=
X-Received: by 2002:a17:90b:1dd2:b0:2ee:c5ea:bd91 with SMTP id 98e67ed59e1d1-2eec5eabed1mr3592902a91.29.1733101243743;
        Sun, 01 Dec 2024 17:00:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGl5F2sSLutUPl1cZ8gKsk/vTOnuxdjoMePMl1X0n1eAkhrCok8GwjcHJfMeEF4jcsYkJi/lA==
X-Received: by 2002:a17:90b:1dd2:b0:2ee:c5ea:bd91 with SMTP id 98e67ed59e1d1-2eec5eabed1mr3592868a91.29.1733101243441;
        Sun, 01 Dec 2024 17:00:43 -0800 (PST)
Received: from [10.72.112.98] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee58666b31sm2977870a91.2.2024.12.01.17.00.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Dec 2024 17:00:42 -0800 (PST)
Message-ID: <1873bfe4-3d44-40a7-89cb-0742bea8494a@redhat.com>
Date: Mon, 2 Dec 2024 09:00:32 +0800
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
 <Z0mXHSnqmstCIMrF@yuki.lan>
Content-Language: en-US
From: Xiubo Li <xiubli@redhat.com>
In-Reply-To: <Z0mXHSnqmstCIMrF@yuki.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/29/24 18:27, Cyril Hrubis wrote:
> Hi!
>> './configure' is needed just before generating the Makefiles.
>>
>> Signed-off-by: Xiubo Li <xiubli@redhat.com>
>> ---
>>   doc/users/quick_start.rst | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/doc/users/quick_start.rst b/doc/users/quick_start.rst
>> index 1581b1f0c..e80c1c244 100644
>> --- a/doc/users/quick_start.rst
>> +++ b/doc/users/quick_start.rst
>> @@ -54,6 +54,7 @@ generated first:
>>   .. code-block:: console
>>   
>>      $ cd testcases/open_posix_testsuite/
>> +   $ ./configure
> That should be before the 'cd testcase/...' otherwise good catch, this
> is clearly missing there.

Good catch.

Fixed it.

Thanks!


>>      $ make generate-makefiles
>>      $ cd conformance/interfaces/foo
>>      $ make
>> -- 
>> 2.46.0
>>
>>
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp


