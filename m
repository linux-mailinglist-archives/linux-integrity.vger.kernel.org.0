Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51B47184DF6
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Mar 2020 18:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbgCMRuH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 13 Mar 2020 13:50:07 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32381 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727211AbgCMRuH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 Mar 2020 13:50:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584121806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2y9bOOdnV7SoV4MD1WpKfVVbv/C4nrVUnfO1nhE2Kbg=;
        b=Ga1wwI67AMVNPq3O7bf+nhB1W1/fj07YjCZRg7zL13qV6GQP8zImM5F8MT75/lx0lMRsv/
        hFZdbeo/lpCRAtsJuZeDednHp9wv0l5izdu3Ss2/SPeCEJweqpj8yF2r9+xfqcR9u8NQgC
        oHjx9i2Y2rjvedRqiQKdsDxT7EGol0s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-UH7TaFUzPLSR-Dn6vFuh8w-1; Fri, 13 Mar 2020 13:50:02 -0400
X-MC-Unique: UH7TaFUzPLSR-Dn6vFuh8w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7490E801E6D;
        Fri, 13 Mar 2020 17:50:00 +0000 (UTC)
Received: from llong.remote.csb (ovpn-125-21.rdu2.redhat.com [10.10.125.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 82A4960BF7;
        Fri, 13 Mar 2020 17:49:58 +0000 (UTC)
Subject: Re: [PATCH v3 3/3] KEYS: Use kvmalloc() to better handle large buffer
 allocation
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Chris von Recklinghausen <crecklin@redhat.com>
References: <20200313152102.1707-1-longman@redhat.com>
 <20200313152102.1707-4-longman@redhat.com>
 <20200313164306.GA907@sol.localdomain>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <8f2f1787-88b0-f86d-991c-34cfd2f9b4aa@redhat.com>
Date:   Fri, 13 Mar 2020 13:49:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200313164306.GA907@sol.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 3/13/20 12:43 PM, Eric Biggers wrote:
> On Fri, Mar 13, 2020 at 11:21:02AM -0400, Waiman Long wrote:
>> For large multi-page temporary buffer allocation, the security/keys
>> subsystem don't need contiguous physical pages. It will work perfectly
>> fine with virtually mapped pages.
>>
>> Replace the kmalloc() call by kvmalloc() and provide a __kvzfree()
>> helper function to clear and free the kvmalloc'ed buffer. This will
>> reduce the chance of memory allocation failure just because of highly
>> fragmented pages.
>>
>> Suggested-by: David Howells <dhowells@redhat.com>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>  security/keys/internal.h | 14 ++++++++++++++
>>  security/keys/keyctl.c   | 10 +++++-----
>>  2 files changed, 19 insertions(+), 5 deletions(-)
>>
>> diff --git a/security/keys/internal.h b/security/keys/internal.h
>> index ba3e2da14cef..855b11eb73ee 100644
>> --- a/security/keys/internal.h
>> +++ b/security/keys/internal.h
>> @@ -16,6 +16,8 @@
>>  #include <linux/keyctl.h>
>>  #include <linux/refcount.h>
>>  #include <linux/compat.h>
>> +#include <linux/mm.h>
>> +#include <linux/vmalloc.h>
>>  
>>  struct iovec;
>>  
>> @@ -349,4 +351,16 @@ static inline void key_check(const struct key *key)
>>  
>>  #endif
>>  
>> +/*
>> + * Helper function to clear and free a kvmalloc'ed memory object.
>> + */
>> +static inline void __kvzfree(const void *addr, size_t len)
>> +{
>> +	if (is_vmalloc_addr(addr)) {
>> +		memset((void *)addr, 0, len);
>> +		vfree(addr);
>> +	} else {
>> +		kzfree(addr);
>> +	}
>> +}
> Since this takes the length as a parameter, it can be simplified to:
>
> static inline void __kvzfree(const void *addr, size_t len)
> {
> 	if (addr) {
> 		memset((void *)addr, 0, len);
> 		kvfree(addr);
> 	}
> }
Yes, that will work too.
>>  			if (!tmpbuf || unlikely(ret > tmpbuflen)) {
>>  				if (unlikely(tmpbuf))
>> -					kzfree(tmpbuf);
>> +					__kvzfree(tmpbuf, tmpbuflen);
> Both kzfree() and __kvzfree() handle a NULL pointer, so there's no need for the
> NULL check first.
>
I would like to keep this one because of the unlikely annotation.


>> @@ -920,7 +920,7 @@ long keyctl_read_key(key_serial_t keyid, char __user *buffer, size_t buflen)
>>  				ret = -EFAULT;
>>  		}
>>  		if (tmpbuf)
>> -			kzfree(tmpbuf);
>> +			__kvzfree(tmpbuf, tmpbuflen);
> Likewise here.  No need for the NULL check.

Yes, that tmpbuf check is not really necessary, but it doesn't harm either.

My plan is to send out a mm patch to officially add the kvzfree()
function to mm/util.c. I will remove the tmpbuf check at that time if
you don't mind.

Cheers,
Longman

