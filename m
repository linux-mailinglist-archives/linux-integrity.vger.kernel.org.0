Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B30F226D33
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Jul 2020 19:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732744AbgGTReL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 Jul 2020 13:34:11 -0400
Received: from linux.microsoft.com ([13.77.154.182]:37202 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbgGTReL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Jul 2020 13:34:11 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7E77B20B4909;
        Mon, 20 Jul 2020 10:34:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7E77B20B4909
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1595266450;
        bh=IZbk6/wtyJwvcs8UDH0IEXfn70iZQSY+5CSfF+kU3Rc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=VNdAmeiW7jXcjnKnfNMnaEBf/ezZled7360IOAy1VUzHALwt7jjuWoAkwpSXHpul/
         4qfljZOmlJYttBy+0X7xXG+shb+uBTxDvlNY08zkr5FvlqeFMYE2GE92azX5ggHui+
         +DsrMVMna+iBrldPtiweIP24gad0m/PYLoQGCPlg=
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
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <bea0cb52-2e13-fb14-b66c-b57287c23c3f@linux.microsoft.com>
Date:   Mon, 20 Jul 2020 10:34:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ7VH18bEo6+U1GWrx=tHVGr=6XtF5_ygcfQYgdtZ74J+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 7/20/20 10:06 AM, Stephen Smalley wrote:

>> The above will ensure the following sequence will be measured:
>>    #1 State A - Measured
>>    #2 Change from State A to State B - Measured
>>    #3 Change from State B back to State A - Since the measured data is
>> same as in #1, the change will be measured only if the event name is
>> different between #1 and #3
> 
> Perhaps the timestamp / sequence number should be part of the hashed
> data instead of the event name?

If the timestamp/seqno is part of the hashed data, on every call to 
measure IMA will add a new entry in the IMA log. This would fill up the 
IMA log - even when there is no change in the measured data.

To avoid that I keep the last measurement in SELinux and measure only 
when there is a change with the timestamp in the event name.

> I can see the appraiser wanting to know two things:
> 1) The current state of the system (e.g. is it enforcing, is the
> currently loaded policy the expected one?).
> 2) Has the system ever been in an unexpected state (e.g. was it
> temporarily switched to permissive or had an unexpected policy
> loaded?)

Yes - you are right.
The appraiser will have to look at the entire IMA log (and the 
corresponding TPM PCR data) to know the above.

Time t0 => State of the system measured
Time tn => State changed and the new state measured
Time tm => State changed again and the new state measured.

Say, the measurement at "Time tn" was an illegal change, the appraiser 
would know.

> 
> I applied the patch series on top of the next-integrity branch, added
> measure func=LSM_STATE to ima-policy, and booted that kernel.  I get
> the following entries in ascii_runtime_measurements, but seemingly
> missing the final field:
> 
> 10 8a09c48af4f8a817f59b495bd82971e096e2e367 ima-ng
> sha256:21c3d7b09b62b4d0b3ed15ba990f816b94808f90b76787bfae755c4b3a44cd24
> selinux-state
> 10 e610908931d70990a2855ddb33c16af2d82ce56a ima-ng
> sha256:c8898652afd5527ef4eaf8d85f5fee1d91fcccee34bc97f6e55b96746bedb318
> selinux-policy-hash
> 
> Thus, I cannot verify. What am I missing?
> 

Looks like the template used is ima-ng which doesn't include the 
measured buffer. Please set template to "ima-buf" in the policy.

For example,
measure func=LSM_STATE template=ima-buf

thanks,
  -lakshmi


