Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC66226E9E
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Jul 2020 20:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbgGTS7x (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 Jul 2020 14:59:53 -0400
Received: from linux.microsoft.com ([13.77.154.182]:48720 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbgGTS7x (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Jul 2020 14:59:53 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3F13620B4909;
        Mon, 20 Jul 2020 11:59:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3F13620B4909
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1595271592;
        bh=TwTCyPsy3rMqXVnjk9ggTK+QxuipwRRnBBIqMLIAfHU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=CsOM1OTASiRenjavduL6Z/OSbM8MSJRuka+oE3SfwFiUtblFWSKQjh5MKwzLlONqQ
         L9RuvB8oP0n36cCAFMasvJSqJEWnB0peLm1olX3WYO0JyVLF/C+tGQC7wVF/rAxplY
         +dcGkrf8Uf0UBYjE2diJjx3YEiuc6RRJ0IglDe3Q=
Subject: Re: [PATCH v3 4/5] LSM: Define SELinux function to measure security
 state
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200717222819.26198-1-nramas@linux.microsoft.com>
 <20200717222819.26198-5-nramas@linux.microsoft.com>
 <CAEjxPJ7xQtZToF4d2w_o8SXFKG9kPZaWTWTFqyC-7GwBWnQa0A@mail.gmail.com>
 <c0fbfcf3-ec36-872a-c389-b3fea214848c@linux.microsoft.com>
 <CAEjxPJ7VH18bEo6+U1GWrx=tHVGr=6XtF5_ygcfQYgdtZ74J+g@mail.gmail.com>
 <bea0cb52-2e13-fb14-b66c-b57287c23c3f@linux.microsoft.com>
 <CAEjxPJ6Rt7u3shLbxoPRHgr-D=CD9d_eXRB07A9qN7RmJwZAwA@mail.gmail.com>
 <CAEjxPJ6-jHha+CeqSdQ2O0bpyQe_9buj2ENZz6FNj6S87XSSfg@mail.gmail.com>
 <dccfc56b-c3ab-327e-19b2-7a70d15afe5b@linux.microsoft.com>
 <CAEjxPJ6_pxEh6HG9F3r=4B5ZgEpNPkgLHHfJp6ze=F1wKt4wCw@mail.gmail.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <72af0630-dce0-12af-0977-b4e81c2f99ac@linux.microsoft.com>
Date:   Mon, 20 Jul 2020 11:59:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ6_pxEh6HG9F3r=4B5ZgEpNPkgLHHfJp6ze=F1wKt4wCw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 7/20/20 11:44 AM, Stephen Smalley wrote:

>>>
>>> Actually, if we used ima-ng template for selinux-policy-hash, then
>>> instead of needing to hash the policy
>>> first and passing the hash to IMA, we could just pass the policy as
>>> the buffer and IMA would take care of the hashing, right?
>>
>> That is correct.
>>
>> The IMA hook I've added to measure LSM structures is a generic one that
>> can be used by any security module (SM). I feel it would be better to
>> not have policy or state or any such SM specific logic in IMA, but leave
>> that to the individual SM to handle.
>>
>> What do you think?
> 
> It is correct to remain security module agnostic.  However, I think
> you can remain LSM-neutral while still avoiding the double hashing of
> the policy here.  Can't you just pass in the policy itself as the
> buffer and let IMA hash it?

Yes - that is an option. If I do that then, as you have stated below, 
we'll need to two funcs -
one that will only add the hash but not the entire data payload in the 
IMA log (i.e., "ima-ng")
and, the other that handles hashing and including date payload (i.e., 
"ima-buf").

   Then you can let the policy author decide
> on the template to be used (ima-buf versus ima-ng).  If you want to
> support the use of different templates for different "kinds" of LSM
> state (e.g. state versus policy) you could either provide two funcs
> (LSM_STATE, LSM_POLICY) or otherwise support selection based on some
> other attribute.
> 

I can do the above.

  -lakshmi

