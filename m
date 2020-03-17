Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C08BD188D46
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Mar 2020 19:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgCQSg6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 17 Mar 2020 14:36:58 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:43347 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726294AbgCQSg6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 Mar 2020 14:36:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584470217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gwrf4J2FnOgQssJONp9zFLVSRMiMPIXEXh9xD+q8AIo=;
        b=TZWAYBcRFpQX7+wZ1NCtypCkjFYJHUCZI+aRSDEphrfwhR9WyAVBxvi62K+m4Fhc1PajJX
        gro5G9SqS6qoKvQdzB1jI4Ts9uUK53cfj8fPl2LFRBCvNtXyCcMS+oP8AZu9oJuLDV0x1Y
        SPHElHAriMMWnd3ZxaruFTHitimCg4g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-DopgLM-EMf20XOl6Py1l5w-1; Tue, 17 Mar 2020 14:36:55 -0400
X-MC-Unique: DopgLM-EMf20XOl6Py1l5w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A0B31405;
        Tue, 17 Mar 2020 18:36:53 +0000 (UTC)
Received: from llong.remote.csb (ovpn-115-15.rdu2.redhat.com [10.10.115.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 76BFE6E3EE;
        Tue, 17 Mar 2020 18:36:51 +0000 (UTC)
Subject: Re: [PATCH v3 2/3] KEYS: Avoid false positive ENOMEM error on key
 read
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Eric Biggers <ebiggers@google.com>,
        Chris von Recklinghausen <crecklin@redhat.com>
References: <20200313152102.1707-1-longman@redhat.com>
 <20200313152102.1707-3-longman@redhat.com>
 <20200315213245.GF224162@linux.intel.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <98feb3ff-835a-e4cf-40a9-284d21e16993@redhat.com>
Date:   Tue, 17 Mar 2020 14:36:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200315213245.GF224162@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 3/15/20 5:32 PM, Jarkko Sakkinen wrote:
> On Fri, Mar 13, 2020 at 11:21:01AM -0400, Waiman Long wrote:
>> -		 * Read methods will just return the required length
>> -		 * without any copying if the provided length isn't big
>> -		 * enough.
>> +		 * We don't want an erronous -ENOMEM error due to an
>> +		 * arbitrary large user-supplied buflen. So if buflen
>> +		 * exceeds a threshold (1024 bytes in this case), we call
>> +		 * the read method twice. The first time to get the buffer
>> +		 * length and the second time to read out the key data.
>> +		 *
>> +		 * N.B. All the read methods will return the required
>> +		 *      buffer length with a NULL input buffer or when
>> +		 *      the input buffer length isn't large enough.
>>  		 */
>> +		if (buflen <= 0x400) {
> 1. The overwhelmingly long comment. Will be destined to rotten.
> 2. Magic number.
> 3. The cap must be updated both in comment and code, and not only
>    that, but the numbers use a different base (dec and hex).
>
> /Jarkko
>
Thank for the comment. I will make the necessary change.

Cheers,
Longman

