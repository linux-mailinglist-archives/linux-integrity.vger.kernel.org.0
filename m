Return-Path: <linux-integrity+bounces-4339-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 151D19EC163
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Dec 2024 02:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C3AA283EA2
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Dec 2024 01:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE712134AC;
	Wed, 11 Dec 2024 01:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i3tOuDNL"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57FA2451D0
	for <linux-integrity@vger.kernel.org>; Wed, 11 Dec 2024 01:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733879831; cv=none; b=Sc9Y7BRpzXhZk5P6/j6Jaf9XYMfUo9jaBl8qHRuPBsiNSsmJ8NDzn4byjaKlRexFEWS/6w4fwjs7G+6EW4p63iQsllzc6slwDxXc5IGpCQkHaQEIaQ4vY3fyNONH+93O1Fx4dHQIYIdwQiL/7WWIDCTz1tG93JimGFhBlkl7h7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733879831; c=relaxed/simple;
	bh=ENaIi2aFqpk8mSDob/8doNja9YHRMjpA6Hql7/zpAE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pIV2bONkiV7iPx0nAZEBmE/IEHaC9/juivTf+ao4gl/d4FeB3bqmF5RyXw7Rnk9zyykLB+6A2mUyai9iQehh5Vu6red20CVcd5xteXU1XCEqjMgI1I9JqvXJ4krJN5eoSgjEj0vOmcwOaKHvyzN2vNTSCNRJrLs6XFMmReLHi3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i3tOuDNL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733879828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ENaIi2aFqpk8mSDob/8doNja9YHRMjpA6Hql7/zpAE4=;
	b=i3tOuDNLyXiOXL71SuBdG6K9KkznrkArU0ujSc8w7Gf2Dd4CmLXfloKDJR61+xWv+zHzQs
	wkmum3vTZe+naDbhpkWptRwUJcKUfFhsjhcAZQUZknmQtJTlLBbWeB1qaF1tzxRA5t+4Cc
	6cquQZmN0aauLaC6GfwVS7F5GG1Xavc=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-gD6Zdu1oNEuA5BYqjbfFIg-1; Tue, 10 Dec 2024 20:17:07 -0500
X-MC-Unique: gD6Zdu1oNEuA5BYqjbfFIg-1
X-Mimecast-MFC-AGG-ID: gD6Zdu1oNEuA5BYqjbfFIg
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-725efa0c796so208175b3a.0
        for <linux-integrity@vger.kernel.org>; Tue, 10 Dec 2024 17:17:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733879826; x=1734484626;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ENaIi2aFqpk8mSDob/8doNja9YHRMjpA6Hql7/zpAE4=;
        b=ho4tA34CTTuQAGktc1lgUke3P29i6lSgfHCaTn1RRWwfncwYurwbRGnqIHmhZHl7i3
         uPZybSZwCkqQhRJH5nVP4VJG7U6Dc5RgmZR8EackzMwfRvy7YJ6f0BtF5WJkGybbv51x
         ZQ9sPSQC8xmgy5rQbXGwWiTgsAJcF8wTSaOLThvXQjlDg8IOmMoteEZ6TDtPJOQ4vVNh
         tEVfPMkx7bKzgGqSKR4B7YNTkJx0gJzy+Sv5ZkSfracCSxyj1YaGl49/h4Jw/o0GeEgd
         syVj+6OgkhItCZWYv7xPrNkR1TU55Kh3mTLTbU1pAaCJ62btWV7UpYVYHgpCU1Gr/y+H
         Tbuw==
X-Forwarded-Encrypted: i=1; AJvYcCWUh785qYzHgbaPq8o/pIAooR6ihfoP0y/DXwAEd6I2Cbcy+YJKIcsRQ7sYzSRnfjFSL3w/URPsECyXUYRoBvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyOAdRV+oaTcnHc6lZnEaa7LTaSfafacpBGIHJVBigcskF2s5R
	0cgg/aNgOetBowkUml3N7J7InUpxySIszDpGtTZDDbT1nAc2I7fRSZWzhtB7L7fpVOtfZ9rBn08
	85Dc9p6js0q3f5sSupr0fdANHZl5N+oiD8TjYpulCZ0G+l6/hQvx3RD1onc9ODJQgjQ==
X-Gm-Gg: ASbGnctgXypdAilIgmG6HxiLicIUt1u3WMtRlV7sUcQyXj+wfdM74nOCVebeNpJx6Cv
	TeQ/erneshltSzYLywMFeeHwSIWmkPCQJrpy8RpSppEQI5taZj4Hs+CVGziZqVsId/tLpUU1xZj
	XykBveKCPuYLRHgQndEigCv8kuty0VVMWubOUGsdDshPHoIk4PUERtwQFQl07k7eIfEC1DiQeo0
	2uL01QLIYdgfFofVKDnGaSdOMvvtKyP3+VxqU18aSysIaLA2ASwo88=
X-Received: by 2002:a05:6a00:9a9:b0:725:4915:c10 with SMTP id d2e1a72fcca58-728edbe33f4mr1266233b3a.10.1733879826236;
        Tue, 10 Dec 2024 17:17:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQQWEATATIc+G64CcLLmv5kSezF2MHXxOrOZ372DLl6jWZ9fg9zcJa9bT/l2wu4GpwjZHddw==
X-Received: by 2002:a05:6a00:9a9:b0:725:4915:c10 with SMTP id d2e1a72fcca58-728edbe33f4mr1266212b3a.10.1733879825857;
        Tue, 10 Dec 2024 17:17:05 -0800 (PST)
Received: from [10.72.112.22] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725e438f169sm5292766b3a.168.2024.12.10.17.17.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 17:17:05 -0800 (PST)
Message-ID: <b690e9aa-bb40-403a-8227-4944f9dccf74@redhat.com>
Date: Wed, 11 Dec 2024 09:17:02 +0800
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
 <Z02PZRGzw5qM3z0w@yuki.lan> <2779c1f7-28fd-415f-a016-da3aa077659b@redhat.com>
 <Z1gw_mNXF7KIzklK@yuki.lan>
Content-Language: en-US
From: Xiubo Li <xiubli@redhat.com>
In-Reply-To: <Z1gw_mNXF7KIzklK@yuki.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 12/10/24 20:15, Cyril Hrubis wrote:
> Hi!
>>> The top level configure script configures the open posix testsuite, but
>>> you have to pass the --with-open-posix-testsuite flag to it.
>>>
>>> Or you can run the open posix configure from the open posix directory.
>>>
>> Yeah, this looks better.
>>
>> Does it make sense to fix the doc about this ? If so I will send the V3.
> Yes please (and sorry for the delayed response).
>
Done. Thanks!


