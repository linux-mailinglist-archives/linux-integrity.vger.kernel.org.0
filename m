Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7E4217B0B2
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Mar 2020 22:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgCEVa2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 5 Mar 2020 16:30:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27162 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726049AbgCEVa2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 5 Mar 2020 16:30:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583443827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hkim17AcBCnxI/wSF69dkEpIuJDcwbjPUSIQZbbuoHA=;
        b=VHSXHJ/Zq82XJV3Zom1VBSY/UDpOIZIJ2U4Td7bQvuZyEBP0IvjRduLlD+N6OLfcnT8RCz
        WdorG8VhK8JXwtFVj8L5YsXrKqeqFC0bnVT/JZiO7oLxJcvnBTaN3HW3OTVAA/dd8ZWTNC
        qis/CsKN85UHBEidMZReMGkKwmCp7Yg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-QZ2WNUImOeqq3Z_tfIAuGA-1; Thu, 05 Mar 2020 16:30:23 -0500
X-MC-Unique: QZ2WNUImOeqq3Z_tfIAuGA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 719268B789C;
        Thu,  5 Mar 2020 21:30:20 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A47C49494C;
        Thu,  5 Mar 2020 21:30:18 +0000 (UTC)
Subject: Re: [PATCH] KEYS: Don't write out to userspace while holding key
 semaphore
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
References: <20200305210640.15315-1-longman@redhat.com>
 <20200305211651.GA225345@gmail.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <f581aab4-1bad-64b8-59bf-2da6c34c53c5@redhat.com>
Date:   Thu, 5 Mar 2020 16:30:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200305211651.GA225345@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 3/5/20 4:16 PM, Eric Biggers wrote:
> On Thu, Mar 05, 2020 at 04:06:40PM -0500, Waiman Long wrote:
>> diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
>> index 9b898c969558..564a4d187329 100644
>> --- a/security/keys/keyctl.c
>> +++ b/security/keys/keyctl.c
>> @@ -846,14 +846,36 @@ long keyctl_read_key(key_serial_t keyid, char __user *buffer, size_t buflen)
>>  can_read_key:
>>  	ret = -EOPNOTSUPP;
>>  	if (key->type->read) {
>> -		/* Read the data with the semaphore held (since we might sleep)
>> +		/*
>> +		 * Read the data with the semaphore held (since we might sleep)
>>  		 * to protect against the key being updated or revoked.
>> +		 *
>> +		 * Allocating a temporary buffer to hold the keys before
>> +		 * transferring them to user buffer to avoid potential
>> +		 * deadlock involving page fault and mmap_sem.
>>  		 */
>> +		char *tmpbuf = kmalloc(buflen, GFP_KERNEL);
> This is passing an arbitrarily large size from userspace into kmalloc().
>
> - Eric
>
That is true. Is there a limit of how much key data are expected to be
returned from the kernel? We could set an internal limit here on how
large the buffer can be.

Cheers,
Longman

