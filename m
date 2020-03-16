Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4B26187046
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Mar 2020 17:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732064AbgCPQmw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 Mar 2020 12:42:52 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:53383 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731884AbgCPQmw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Mar 2020 12:42:52 -0400
X-Greylist: delayed 4874 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Mar 2020 12:42:52 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584376971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jC00Z6qh/Tdo08cJHrlqWaLr117ZyFvx6URUV4dogZI=;
        b=gX08pM8I6OJfHSvBBibXR18bI1jl9XzGTqNByJijEL09xqn+fEtD5Lq6xFbgqVPA8EStNV
        C/XEFocIXm4eZAL0JdL5Aaczo/S46eL7vYllV6iDpuU/qi8vu9EFCNvwXVUfWXPU64+IRk
        9D22HvYCVbEUs1cJPUqd/JHbd+pLc4A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-LWQ5OmvLM5qkW_o2seEmAA-1; Mon, 16 Mar 2020 12:42:49 -0400
X-MC-Unique: LWQ5OmvLM5qkW_o2seEmAA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6669518A8CBA;
        Mon, 16 Mar 2020 16:33:20 +0000 (UTC)
Received: from llong.remote.csb (ovpn-118-249.phx2.redhat.com [10.3.118.249])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A0AE660BE2;
        Mon, 16 Mar 2020 16:33:17 +0000 (UTC)
Subject: Re: [PATCH v3 1/3] KEYS: Don't write out to userspace while holding
 key semaphore
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Howells <dhowells@redhat.com>
Cc:     James Morris <jmorris@namei.org>,
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
References: <20200315212706.GE224162@linux.intel.com>
 <20200313152102.1707-1-longman@redhat.com>
 <20200313152102.1707-2-longman@redhat.com>
 <20200315192104.GD224162@linux.intel.com>
 <1793253.1584357764@warthog.procyon.org.uk>
 <c1138c83619553d018970a4b2d95f38fccebc99c.camel@linux.intel.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <6f00132d-2ed8-fcbc-a1c3-54151a582aa1@redhat.com>
Date:   Mon, 16 Mar 2020 12:33:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <c1138c83619553d018970a4b2d95f38fccebc99c.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 3/16/20 9:53 AM, Jarkko Sakkinen wrote:
> On Mon, 2020-03-16 at 11:22 +0000, David Howells wrote:
>> Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:
>>
>>> I guess we cannot sanely define fixes tag for this one, can we?
>> Use:
>>
>> 	Fixes: ^1da177e4c3f4 ("Linux-2.6.12-rc2")
>>
>> David
> Longmao, please include this to the next version.
>
> /Jarkko
>
Sure, will do.

Cheers,
Longman

