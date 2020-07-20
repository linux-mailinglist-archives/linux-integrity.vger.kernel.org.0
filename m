Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFD70226318
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Jul 2020 17:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgGTPRa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 Jul 2020 11:17:30 -0400
Received: from linux.microsoft.com ([13.77.154.182]:46812 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgGTPRa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Jul 2020 11:17:30 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 42B0D20B4909;
        Mon, 20 Jul 2020 08:17:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 42B0D20B4909
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1595258249;
        bh=oi0aM2Sv7g3ee0tu4NKpJk0WcdNS9Jhomo6QUfrwUC8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=j+5Jpthn6qxHKgYEcVruDugKQStaAoSJQ26AuuLLqKa6XO9Itcusw5gWOhY1k1m/B
         10oiCmTubARNogtNDf4kGp/S7B5rX5bYRPdpA69KRvybYl8UgL8WHPOaucUXXiYjtK
         E0UESnxt/2jXo9GqTIaFCLnd59Vbq0+XQQHEpISo=
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
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <c0fbfcf3-ec36-872a-c389-b3fea214848c@linux.microsoft.com>
Date:   Mon, 20 Jul 2020 08:17:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ7xQtZToF4d2w_o8SXFKG9kPZaWTWTFqyC-7GwBWnQa0A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 7/20/20 7:31 AM, Stephen Smalley wrote:

>> +void __init selinux_init_measurement(void)
>> +{
>> +       int i;
>> +
>> +       /*
>> +        * enabled
>> +        * enforcing
>> +        * checkreqport
> 
> checkreqprot (spelling)
:( - will fix that.

> 
> What about initialized?  Or do you consider that to be implicitly
> true/1 else we wouldn't be taking a measurement?  Only caveat there is
> that it provides one more means of disabling measurements (at the same
> time as disabling enforcement) by setting it to false/0 via kernel
> write flaw.
Yes - I was thinking measuring SELinux state would be meaningful only 
when initialized is set to true/1.

I can include "initialized" as well in the measurement.

> 
>> +        * All policy capability flags
>> +        */
>> +       selinux_state_count = 3 + __POLICYDB_CAPABILITY_MAX;
>> +
>> +       selinux_state_string_len = snprintf(NULL, 0, str_format,
>> +                                           "enabled", 0);
>> +       selinux_state_string_len += snprintf(NULL, 0, str_format,
>> +                                            "enforcing", 0);
>> +       selinux_state_string_len += snprintf(NULL, 0, str_format,
>> +                                            "checkreqprot", 0);
>> +       for (i = 3; i < selinux_state_count; i++) {
>> +               selinux_state_string_len +=
>> +                       snprintf(NULL, 0, str_format,
>> +                                selinux_policycap_names[i-3], 0);
>> +       }
> 
> What's the benefit of this pattern versus just making the loop go from
> 0 to __POLICYDB_CAPABILITY_MAX and using selinux_policycap_names[i]?

No real benefit - I was just trying to use selinux_state_count.
I'll change the loop to go from 0 to POLICY_CAP_MAX

> 
>> +void selinux_measure_state(struct selinux_state *selinux_state)
>> +{
>> +       void *policy = NULL;
>> +       void *policy_hash = NULL;
>> +       size_t curr, buflen;
>> +       int i, policy_hash_len, rc = 0;
>> +
>> +       if (!selinux_initialized(selinux_state)) {
>> +               pr_warn("%s: SELinux not yet initialized.\n", __func__);
>> +               return;
>> +       }
> 
> We could measure the global state variables before full SELinux
> initialization (i.e. policy load).
> Only the policy hash depends on having loaded the policy.

Thanks for the information. I'll measure the state variables always and 
measure policy only if "initialized" is true/1.

> 
>> +
>> +       if (!selinux_state_string) {
>> +               pr_warn("%s: Buffer for state not allocated.\n", __func__);
>> +               return;
>> +       }
>> +
>> +       curr = snprintf(selinux_state_string, selinux_state_string_len,
>> +                       str_format, "enabled",
>> +                       !selinux_disabled(selinux_state));
>> +       curr += snprintf((selinux_state_string + curr),
>> +                        (selinux_state_string_len - curr),
>> +                        str_format, "enforcing",
>> +                        enforcing_enabled(selinux_state));
>> +       curr += snprintf((selinux_state_string + curr),
>> +                        (selinux_state_string_len - curr),
>> +                        str_format, "checkreqprot",
>> +                        selinux_checkreqprot(selinux_state));
>> +
>> +       for (i = 3; i < selinux_state_count; i++) {
>> +               curr += snprintf((selinux_state_string + curr),
>> +                                (selinux_state_string_len - curr),
>> +                                str_format,
>> +                                selinux_policycap_names[i - 3],
>> +                                selinux_state->policycap[i - 3]);
>> +       }
> 
> Same question here as for the previous loop; seems cleaner to go from
> 0 to __POLICYDB_CAPABILITY_MAX and use [i].
Will change it.

> 
> What public git tree / branch would you recommend trying to use your
> patches against?  Didn't seem to apply to any of the obvious ones.
> 

Please try it on Mimi's next-integrity branch

https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/log/?h=next-integrity

You can try it on Linus's mainline as well if you apply the following 
patch first (have mentioned that in the Cover letter as well)


     https://patchwork.kernel.org/patch/11612989/

Thanks for trying out the changes. Please let me know the defects you find.

Just to let you know - I am making the following change (will update in 
the next patch):

  => Save the last policy hash and state string in selinux_state struct.
  => Measure policy and hash only if it has changed since the last 
measurement.
  => Also, suffix the IMA event name used with time stamp. For example,

10 e32e...5ac3 ima-buf sha256:86e8...4594
selinux-state-1595257807:874963248 
656e61626c65643d313b656e666f7263696e673d303b636865636b72657170726f743d313b6e6574706565723d313b6f70656e7065726d3d313b657874736f636b636c6173733d313b616c776179736e6574776f726b3d303b6367726f75707365636c6162656c3d313b6e6e706e6f737569647472616e736974696f6e3d313b67656e66737365636c6162656c73796d6c696e6b3d303b

10 f4a7...9408 ima-buf sha256:4941...68fc
selinux-policy-hash-1595257807:874963248
8d1d...1834

The above will ensure the following sequence will be measured:
  #1 State A - Measured
  #2 Change from State A to State B - Measured
  #3 Change from State B back to State A - Since the measured data is 
same as in #1, the change will be measured only if the event name is 
different between #1 and #3

thanks,
  -lakshmi

