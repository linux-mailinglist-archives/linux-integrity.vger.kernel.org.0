Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9A7218481F
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Mar 2020 14:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgCMN34 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 13 Mar 2020 09:29:56 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45481 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726832AbgCMN34 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 Mar 2020 09:29:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584106195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3+ksI+XSY2k8kxQCweElbOHXEbbN3FX9hGarbW0qLpE=;
        b=ExgfqPLCHFei3/BGbAitRC+ZfLQxDc1vIdgQBJY6bAad7v6hYR/0mT+vh8SRdM8MorYZNg
        R05HXuGLNEhhc+1Li+bjuy5DHpiLStrE2BYt2KlqC/szqE9Ts6/9FPTZrigTq2ImZNjFs2
        yyTo3bXmoIbBXwWLrXP3lG5GYjEqROI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-SOYfMbpkNq6cmHdbDSn14g-1; Fri, 13 Mar 2020 09:29:52 -0400
X-MC-Unique: SOYfMbpkNq6cmHdbDSn14g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4302189F762;
        Fri, 13 Mar 2020 13:29:49 +0000 (UTC)
Received: from llong.remote.csb (ovpn-125-21.rdu2.redhat.com [10.10.125.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E14A660CC0;
        Fri, 13 Mar 2020 13:29:47 +0000 (UTC)
Subject: Re: [PATCH v2 1/2] KEYS: Don't write out to userspace while holding
 key semaphore
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
References: <20200308170410.14166-1-longman@redhat.com>
 <20200308170410.14166-2-longman@redhat.com>
 <20200313010425.GA11360@linux.intel.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <e2dc038b-0283-0bf6-45f6-ad2dd0775e81@redhat.com>
Date:   Fri, 13 Mar 2020 09:29:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200313010425.GA11360@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 3/12/20 9:04 PM, Jarkko Sakkinen wrote:
> On Sun, Mar 08, 2020 at 01:04:09PM -0400, Waiman Long wrote:
>> +		/*
>> +		 * Read methods will just return the required length
>> +		 * without any copying if the provided length isn't big
>> +		 * enough.
>> +		 */
>> +		if ((ret > 0) && (ret <= buflen) && buffer &&
>> +		    copy_to_user(buffer, tmpbuf, ret))
>> +			ret = -EFAULT;
> Please, reorg and remove redundant parentheses:
>
> /*
>  * Read methods will just return the required length
>  * without any copying if the provided length isn't big
>  * enough.
>  */
> if (ret > 0 && ret <= buflen) {
> 	if (buffer && copy_to_user(buffer, tmpbuf, ret))
> 		ret = -EFAULT;
> }
>
> Now the comment is attached to the exact right thing. The previous
> organization is a pain to look at when backtracking commits for
> whatever reason in the future.
Yes, I can reorganize the code.
> I'm also wondering, would it be possible to rework the code in a way
> that you don't have check whether buffer is valid on a constant basis?

One way to do that is to extract the down_read/up_read block into a
helper function and then have 2 separate paths - one for length
retrieval and another one for reading the key. I think that will make
the code a bit easier easier to read.

Thanks,
Longman

