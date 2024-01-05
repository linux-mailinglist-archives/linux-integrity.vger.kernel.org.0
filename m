Return-Path: <linux-integrity+bounces-666-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8850D825479
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jan 2024 14:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2624628493F
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jan 2024 13:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2530F2D7AF;
	Fri,  5 Jan 2024 13:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cLa/ZH+4"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF1A2D78B
	for <linux-integrity@vger.kernel.org>; Fri,  5 Jan 2024 13:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704461422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ZyA0UiJjlDprNRBcnFya4w1YVvVVz2SWLbH1aem4wE=;
	b=cLa/ZH+4EvqnJukw8WvfwqGTK1LrUq8zGEruXg9eFMlKfSb+7Xrs+ne0lSFNoRxKYrlUfn
	+wtonkn6Fja7XRqCBtqEeqUb2FZhq+tCA4HKvGhndh3/w7KGVkgD+LtHic9Y8XBSVjTn4n
	9jQjefnVjCfolMGUFWZsd1PdFTBalZ0=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-kZIDrirRNsG5pOanTZSQ8A-1; Fri, 05 Jan 2024 08:30:21 -0500
X-MC-Unique: kZIDrirRNsG5pOanTZSQ8A-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-594f08f3768so1616194eaf.1
        for <linux-integrity@vger.kernel.org>; Fri, 05 Jan 2024 05:30:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704461421; x=1705066221;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ZyA0UiJjlDprNRBcnFya4w1YVvVVz2SWLbH1aem4wE=;
        b=fnDubfkJRDRc3z+RtHxzAb//8nrqRpcpK3tHH8xsUzy2W27VbKgIKbcNlBeAjAHtFD
         mCiL9icpLs8iUyjtk2TRBb+rzbHziUZfZR+tIs4jCRp5BFwk3jKMmEiyih088QDpi1n6
         8Yj3N2JMdKzSwg9nuzV6e7hQye5NTn3GQqt0SBycc3PQXAc6EYkRrL+t3Q0lzWIBfXV5
         ENi7SDgOm0iqPRQuqfCJ1irfMtKKmxEXYvrpRqS10+6ccCPQDHLEIEGS4cI2eTX083C9
         kLh13mN5luy2V/oKKqeQ6s8FWItExH0iibrFRGEVLati4wQAU1Z2+T8wYR8C6q61vXpR
         S3Ew==
X-Gm-Message-State: AOJu0Yy7e3UWW9vO4oNbNPztdnxsJ2Z/ly6z15tRbTP26nM/UcE7CbKh
	F99JmWgP67DJTLoKmLqBdiXOa+p76nPsFa5wuZKmYOZRFMo7RQUt9wNGlYXDQhuZpkoNiW2Nc8A
	B1NyqMQgT4nC04LOpV0zGUL/SFmYl5r6edi/u
X-Received: by 2002:a05:6359:309a:b0:172:fe9a:44d9 with SMTP id rg26-20020a056359309a00b00172fe9a44d9mr1557962rwb.33.1704461420862;
        Fri, 05 Jan 2024 05:30:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHOshhGoPVy2RT2ywK6Ed2waSP6I+rGR3wAj2kBv8fMfQgXPaSMZNLO9B9u77ckjUZGIzI7w==
X-Received: by 2002:a05:6359:309a:b0:172:fe9a:44d9 with SMTP id rg26-20020a056359309a00b00172fe9a44d9mr1557952rwb.33.1704461420523;
        Fri, 05 Jan 2024 05:30:20 -0800 (PST)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id j3-20020a63fc03000000b005ce71f1440bsm1402487pgi.72.2024.01.05.05.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 05:30:20 -0800 (PST)
Date: Fri, 5 Jan 2024 21:27:28 +0800
From: Coiby Xu <coxu@redhat.com>
To: Eric Snowberg <eric.snowberg@oracle.com>
Cc: "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>, 
	"itrymybest80@protonmail.com" <itrymybest80@protonmail.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH] integrity: don't throw an error immediately when
 failed to add a cert to the .machine keyring
Message-ID: <jaybj2ra7cjsfazxcumpkaozthl245a6s4sdmjsrmvpuddb5ye@cntxrwommw4z>
References: <20231227044156.166009-1-coxu@redhat.com>
 <2E548AE0-8029-4BB0-B162-4CAD0544EDB8@oracle.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2E548AE0-8029-4BB0-B162-4CAD0544EDB8@oracle.com>

On Tue, Jan 02, 2024 at 05:33:53PM +0000, Eric Snowberg wrote:
>
>
>> On Dec 26, 2023, at 9:41 PM, Coiby Xu <coxu@redhat.com> wrote:
>>
>> Currently when the kernel fails to add a cert to the .machine keyring,
>> it will throw an error immediately in the function integrity_add_key.
>>
>> Since the kernel will try adding to the .platform keyring next or throw
>> an error (in the caller of integrity_add_key i.e. add_to_machine_keyring),
>> so there is no need to throw an error immediately in integrity_add_key.
>>
>> Reported-by: itrymybest80@protonmail.com
>> Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2239331
>> Signed-off-by: Coiby Xu <coxu@redhat.com>
>
>Reviewed-by: Eric Snowberg <eric.snowberg@oracle.com>

Thank you for reviewing the patch!

-- 
Best regards,
Coiby


