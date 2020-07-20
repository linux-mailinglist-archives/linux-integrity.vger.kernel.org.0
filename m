Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDFC226E3C
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Jul 2020 20:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729905AbgGTS1R (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 Jul 2020 14:27:17 -0400
Received: from linux.microsoft.com ([13.77.154.182]:43702 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgGTS1Q (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Jul 2020 14:27:16 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5B9C220B4909;
        Mon, 20 Jul 2020 11:27:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5B9C220B4909
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1595269636;
        bh=vZFIrBIdJyC5Xb5S8CJMRXERS/PRPgBtWmfiWFbXNiU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PhuaUfn3PsD00nHkSKO/079qirBPkHdG2rtXca5M72Kg0znz8z9Ivs1zLHeO3VRhN
         jPmx/HOaTMH+qDcujRuG/dZfTK9fUGB7hkYFrQxQ+uuqEcoVnc379ESsf3GJohUl0M
         cmWjplFOWLBrsI6Gu1BCwYmGbVsp5Rdk0zaqgARc=
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
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <dccfc56b-c3ab-327e-19b2-7a70d15afe5b@linux.microsoft.com>
Date:   Mon, 20 Jul 2020 11:27:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ6-jHha+CeqSdQ2O0bpyQe_9buj2ENZz6FNj6S87XSSfg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 7/20/20 10:49 AM, Stephen Smalley wrote:

>>>
>>> Looks like the template used is ima-ng which doesn't include the
>>> measured buffer. Please set template to "ima-buf" in the policy.
>>>
>>> For example,
>>> measure func=LSM_STATE template=ima-buf
>>
>> It seems like one shouldn't need to manually specify it if it is the
>> only template that yields a useful result for the LSM_STATE function?
> 
> Actually, if we used ima-ng template for selinux-policy-hash, then
> instead of needing to hash the policy
> first and passing the hash to IMA, we could just pass the policy as
> the buffer and IMA would take care of the hashing, right?

That is correct.

The IMA hook I've added to measure LSM structures is a generic one that 
can be used by any security module (SM). I feel it would be better to 
not have policy or state or any such SM specific logic in IMA, but leave 
that to the individual SM to handle.

What do you think?

> And we only need to use ima-buf for the selinux-state if we want the
> measurement list to include the string value that
> was hashed; if we just want to compare against a known-good, it would
> suffice to use ima-ng for it as well, right?
> 

  -lakshmi

