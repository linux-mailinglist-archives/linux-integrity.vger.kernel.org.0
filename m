Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81D3018029B
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Mar 2020 16:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgCJP60 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Mar 2020 11:58:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30311 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726315AbgCJP6Z (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Mar 2020 11:58:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583855905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OSEf+e1z2AIh8TwnGvrS3GbCOp/ww6nvmkrZoHTSUBo=;
        b=bkP2ldGAwGcPk9sSZpM2v0Xfoo7UuC/1Y89Lvk7rhXn3AIJBcZcQk/3qXO92IgHSvFq8Mt
        UhqYHprEXHUYxsyuv+0FIo8tmjyNyD6DrzfliHdth8beGfsx70wvdHkU/2mOKMYijwxjCw
        CUY2E/8hj/rZBrVLqBcTqKChlvxQJgA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69-jj_zUsTgPXisfcrY7WvHAA-1; Tue, 10 Mar 2020 11:58:23 -0400
X-MC-Unique: jj_zUsTgPXisfcrY7WvHAA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDC77107ACCD;
        Tue, 10 Mar 2020 15:58:21 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2D19860BF4;
        Tue, 10 Mar 2020 15:58:20 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] KEYS: Avoid false positive ENOMEM error on key
 read
From:   Waiman Long <longman@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
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
References: <20200308170410.14166-3-longman@redhat.com>
 <20200308170410.14166-1-longman@redhat.com>
 <416690.1583771540@warthog.procyon.org.uk>
 <a4c92057-c364-965c-a251-02cbe46229b6@redhat.com>
Organization: Red Hat
Message-ID: <da226448-4b76-0456-4c29-742a1a24fe79@redhat.com>
Date:   Tue, 10 Mar 2020 11:58:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <a4c92057-c364-965c-a251-02cbe46229b6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 3/10/20 11:45 AM, Waiman Long wrote:
> On 3/9/20 12:32 PM, David Howells wrote:
>> Waiman Long <longman@redhat.com> wrote:
>>
>>> +			tmpbuf = kmalloc(tbuflen, GFP_KERNEL);
>> This would probably be better off using kvmalloc() - otherwise big objects
>> have to be constructed from runs of contiguous pages.  But since all we're
>> doing is buffering for userspace, we don't care about that.
>>
>> If you agree, we can address it with an additional patch.
>>
>> David
> That is certainly fine with me. I don't care if the pages are contiguous
> or not. Will add a patch 3 for that as suggested.

That is not as simple as I thought. First of that, there is not an
equivalent kzvfree() helper to clear the buffer first before clearing.
Of course, I can do that manually.

With patch 2, the allocated buffer length will be max(1024, keylen). The
security code uses kmalloc() for allocation. If we use kvalloc() here,
perhaps we should also use that for allocation that can be potentially
large like that in big_key. What do you think?

Cheers,
Longman

