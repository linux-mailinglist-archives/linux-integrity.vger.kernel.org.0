Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2C002609AC
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Sep 2020 06:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbgIHEom (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 8 Sep 2020 00:44:42 -0400
Received: from linux.microsoft.com ([13.77.154.182]:44740 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgIHEom (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Sep 2020 00:44:42 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 76A902074C73;
        Mon,  7 Sep 2020 21:44:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 76A902074C73
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1599540281;
        bh=TEOOR8j/hWPxlCxwN4TevnXBuQUcVlAC+4yB4apsr3s=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=diLF5VbkJv/7uC5w7isWgG+P1DKYZZIUXljR0d6IQedJ+8aqBnqdVKSrfQoPEmchd
         urkdbKP642eoCaULdCP0ynG4xZ4G4r8GPSSH6FZgd8jbyYAa5ivVvIdkbeT35Tx8eN
         6SuswUvYGNutjw+txEQJtUvqlco0NWd6L0vsAw1M=
Subject: Re: [PATCH] SELinux: Measure state and hash of policy using IMA
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        tusharsu@linux.microsoft.com, Sasha Levin <sashal@kernel.org>,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200907213855.3572-1-nramas@linux.microsoft.com>
 <CAEjxPJ5C64AmmVKuuPmtbfnY06w49ziryRAnARurWxpQumzfow@mail.gmail.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <7c4e2e9f-54e1-1dee-c33c-64dac0fe9678@linux.microsoft.com>
Date:   Mon, 7 Sep 2020 21:44:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ5C64AmmVKuuPmtbfnY06w49ziryRAnARurWxpQumzfow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 9/7/20 3:32 PM, Stephen Smalley wrote:

>> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
>> Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>> Reported-by: kernel test robot <lkp@intel.com> # error: implicit declaration of function 'vfree'
>> Reported-by: kernel test robot <lkp@intel.com> # error: implicit declaration of function 'crypto_alloc_shash'
>> Reported-by: kernel test robot <lkp@intel.com> # sparse: symbol 'security_read_selinux_policy' was not declared. Should it be static?
> 
> Not sure these Reported-by lines are useful since they were just on
> submitted versions of the patch not on an actual merged commit.

I'll remove them when I update the patch.

> 
>> diff --git a/security/selinux/measure.c b/security/selinux/measure.c
>> new file mode 100644
>> index 000000000000..caf9107937d9
>> --- /dev/null
>> +++ b/security/selinux/measure.c
> <snip>
>> +void selinux_measure_state(struct selinux_state *state, bool policy_mutex_held)
>> +{
> <snip>
>> +
>> +       if (!policy_mutex_held)
>> +               mutex_lock(&state->policy_mutex);
>> +
>> +       rc = security_read_policy_kernel(state, &policy, &policy_len);
>> +
>> +       if (!policy_mutex_held)
>> +               mutex_unlock(&state->policy_mutex);
> 
> This kind of conditional taking of a mutex is generally frowned upon
> in my experience.
> You should likely just always take the mutex in the callers of
> selinux_measure_state() instead.
> In some cases, it may be the caller of the caller.  Arguably selinuxfs
> could be taking it around all state modifying operations (e.g.
> enforce, checkreqprot) not just policy modifying ones although it
> isn't strictly for that purpose.

Since currently policy_mutex is not used to synchronize access to state 
variables (enforce, checkreqprot, etc.) I am wondering if 
selinux_measure_state() should measure only state if policy_mutex is not 
held by the caller - similar to how we skip measuring policy if 
initialization is not yet completed.

	/*
	 * Measure SELinux policy only after initialization is
          * completed.
	 */
	if (!initialized)
		goto out;

  -lakshmi


