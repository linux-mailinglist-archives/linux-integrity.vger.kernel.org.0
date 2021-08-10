Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B076C3E5270
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Aug 2021 06:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbhHJEwc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Aug 2021 00:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbhHJEwc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Aug 2021 00:52:32 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D822C0613D3;
        Mon,  9 Aug 2021 21:52:10 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id w14so831679pjh.5;
        Mon, 09 Aug 2021 21:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=pKuRJwP8rC3OTYzaZnoKKKbjB+cT8U3TpcbMo6IGM1I=;
        b=aXorc5K3tDb6Jt5D/oZMu0WbYdFZPh4REiQKk6h3P2YXpIybWdEYMisoSpl0bdplIZ
         okK83LJk4+lct7x07AXjqH+ffKN+uMOITVo450HvZZZD/hw+0UQjeU+17xPGJ0HnyMmz
         VWdaoH/+WUBmTwooB43ArAJW9W4k/7xjlnjV6nLKcFTat9DxnK8AhQrz9VNodoEFYf+B
         oifvK6ScemIWSkwAghfdkP09Lqjp358QGfdj8HGdL+2zNGUv76o7cS1+RaPKsO+lRSow
         pf014ftxGarZ+p/gNfqS2oi1rqyKvD1dpmEx0rirlmbDIKapSyQv6fRyUaWr/5kh+Nvr
         VbHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=pKuRJwP8rC3OTYzaZnoKKKbjB+cT8U3TpcbMo6IGM1I=;
        b=dO9YbWtP83mBq92wdzvuHbE6T8n+RJfz2TA5u2Y4TGhvfGaX3qzjInfmEWhU/IBnTB
         6wp/b5FT816gf1Wv8iLkW0/4YKMRaMvo8yRySYIjzxMryx/+TLHhHEVi98DnreDzloE7
         g4CiEYrKkwfL7KdLaZfyPGBx05Cj3eb/InbSsCKNCoQbfspcfWXee5ktn3QBN2hkfcag
         gXMLX4nmmZwSYXAnL9HB6OIgQXiCT2rvSsN8iJMNulSxBj4RT5HkXts5Y0wtVF/Mu+iL
         jPRmm8HMUk7eh0WG+84u7Htcr6JzuMOiw5ulodR5VEsuATio06ANcLTVtKIoJFOf3GcA
         SiSQ==
X-Gm-Message-State: AOAM530FLFu/ibrUcMI/zsIxeBCowCV0RmGASVJoYhFshz8g48NNMJJ9
        5f0/J/JQ0HBUbh5wLERBnTM=
X-Google-Smtp-Source: ABdhPJw74a13BU5xFHy0dXT/REE8/z+ytaw+hyIvfZ5GzBzrVewUfSW8vW9+3dEuXAK124HxHJcVWg==
X-Received: by 2002:a17:902:cece:b029:12c:72bb:4d64 with SMTP id d14-20020a170902ceceb029012c72bb4d64mr4549396plg.56.1628571130044;
        Mon, 09 Aug 2021 21:52:10 -0700 (PDT)
Received: from [192.168.1.194] ([50.39.237.102])
        by smtp.gmail.com with ESMTPSA id m1sm18576016pfk.84.2021.08.09.21.52.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 21:52:09 -0700 (PDT)
Subject: Re: [PATCH 1/1] NAX LSM: Add initial support support
To:     THOBY Simon <Simon.THOBY@viveris.fr>,
        Igor Zhbanov <i.zhbanov@omp.ru>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Cc:     Igor Zhbanov <izh1979@gmail.com>, Mimi Zohar <zohar@linux.ibm.com>
References: <db1c1de0-3672-4bae-ef45-c554379f36f4@omp.ru>
 <d97d7fdb-1676-9670-6cf5-2427f780ec6f@viveris.fr>
From:   J Freyensee <why2jjj.linux@gmail.com>
Message-ID: <98408368-119a-b00c-97eb-8ea9fd1d5244@gmail.com>
Date:   Mon, 9 Aug 2021 21:52:07 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <d97d7fdb-1676-9670-6cf5-2427f780ec6f@viveris.fr>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


snip...

>> +#define pr_fmt(fmt) "NAX: " fmt
>> +
>> +#include <linux/capability.h>
>> +#include <linux/cred.h>
>> +#include <linux/ctype.h>
>> +#include <linux/lsm_hooks.h>
>> +#include <linux/mman.h>
>> +#include <linux/sched.h>
>> +#include <linux/securebits.h>
>> +#include <linux/security.h>
>> +#include <linux/sysctl.h>
>> +#include <linux/uidgid.h>
>> +
>> +#define NAX_MODE_PERMISSIVE 0 /* Log only             */
>> +#define NAX_MODE_ENFORCING  1 /* Enforce and log      */
>> +#define NAX_MODE_KILL       2 /* Kill process and log */
>> +
>> +static int mode   = CONFIG_SECURITY_NAX_MODE,
>> +	   quiet  = IS_ENABLED(CONFIG_SECURITY_NAX_QUIET),
>> +	   locked = IS_ENABLED(CONFIG_SECURITY_NAX_LOCKED);
>> +
>> +#define ALLOWED_CAPS_HEX_LEN (_KERNEL_CAPABILITY_U32S * 8)
>> +
>> +static char allowed_caps_hex[ALLOWED_CAPS_HEX_LEN + 1];
>> +static kernel_cap_t allowed_caps = CAP_EMPTY_SET;
>> +
>> +static int
>> +is_privileged_process(void)
>> +{
>> +	const struct cred *cred;
>> +	kuid_t root_uid;
>> +
>> +	cred = current_cred();
>> +	root_uid = make_kuid(cred->user_ns, 0);
>> +	/* We count a process as privileged if it any of its IDs is zero
>> +	 * or it has any unsafe capability (even in a user namespace) */
>> +	if ((!issecure(SECURE_NOROOT) && (uid_eq(cred->uid,   root_uid) ||
>> +					  uid_eq(cred->euid,  root_uid) ||
>> +					  uid_eq(cred->suid,  root_uid) ||
>> +					  uid_eq(cred->fsuid, root_uid))) ||
>> +	    (!cap_issubset(cred->cap_effective, allowed_caps)) ||
>> +	    (!cap_issubset(cred->cap_permitted, allowed_caps)))
>> +		return 1;
>> +
>> +	return 0;
>> +}
>> +
>> +static void
>> +log_warn(const char *reason)
>> +{
>> +	if (quiet)
>> +		return;
>> +
>> +	pr_warn_ratelimited("%s: pid=%d, uid=%u, comm=\"%s\"\n",
>> +		            reason, current->pid,
>> +		            from_kuid(&init_user_ns, current_cred()->uid),
>> +	                              current->comm);
> Have you considered writing to the audit log instead of the kernel messages directly?
> (not saying that this is necessarily better, but is there a reasoning to prefer one or
> the other here? Audit logs are often consumed by automated tools and it may be more pratical
> for people to detect and treat violations if the messages were pushed to the audit log
> - but conversely, that requires defining and maintaining a stable log format for consumers)

It's a good idea to writing to the audit log, HOWEVER I'd want to know 
what all the rest of the LSMs are doing in a case like this. If all of 
them just write kernel messages, I'd want this module to also write just 
kernel messages for consistency sake for use with say, log harvesters 
for a SIEM/XDR system solution.

Just in general I like the thought of this LSM.  I used to work for a 
security company in which their cloud "watched" situations where 
mmap()/mprotect() would use anonymous executable pages for possible 
"dodgy" behavior.

Jay

