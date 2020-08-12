Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E67924302D
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Aug 2020 22:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgHLUho (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 12 Aug 2020 16:37:44 -0400
Received: from linux.microsoft.com ([13.77.154.182]:59092 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgHLUhn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 12 Aug 2020 16:37:43 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7D4AC20B4908;
        Wed, 12 Aug 2020 13:37:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7D4AC20B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1597264662;
        bh=Tny2pnFNQ9hZUYldUbLplhq2a8CRyeGK5gKXS0FC5Ls=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ImHXDqrPSRfYm7TycdwQ548TDuo5B86Aq8OlGHQ3N/VC9Ho7HqPd7t13a1cLWE38E
         OdEkCIsFTO8kLm89D3GyAJLW6DWoGdkV6hodM4mAD0jsM9Kf/1tX8eidQ2JaxG4Uu/
         CUidwV9uPzhWVvDTMi8pcRT1E0LNPevuwxD1AdcY=
Subject: Re: [PATCH v6 0/4] LSM: Measure security module data
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     stephen.smalley.work@gmail.com, sashal@kernel.org,
        jmorris@namei.org, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200805004331.20652-1-nramas@linux.microsoft.com>
 <f3971f35-309d-c3e5-9126-69add7ad4c11@schaufler-ca.com>
 <50587a3e-bcb5-c68e-c16c-41baf68b4d4a@linux.microsoft.com>
 <c7c168f2-e30b-d2c5-abcb-1b6919197474@schaufler-ca.com>
 <20200805154504.GB4365@sequoia>
 <69810007161e689ac817099fb1c6df21962963e4.camel@linux.ibm.com>
 <9ad079ff-1bd4-1302-e6fb-25a7396ef12f@linux.microsoft.com>
 <ecc97f59-c2cc-0b23-6199-925ba0d6358b@schaufler-ca.com>
 <50f00ace-8d46-01c2-bf0f-d5484aafd95c@linux.microsoft.com>
 <5570a4d8-8779-6efe-b208-f7efa8ba9488@schaufler-ca.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <42c35947-9a81-e343-b111-5d4d90095888@linux.microsoft.com>
Date:   Wed, 12 Aug 2020 13:37:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5570a4d8-8779-6efe-b208-f7efa8ba9488@schaufler-ca.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 8/5/20 11:25 AM, Casey Schaufler wrote:

>>>>>
>>>>> I think moving away from the idea that measuring "critical" data should
>>>>> be limited to LSMs, will clarify this.
>>>>>
>>>>
>>>> Are you suggesting that instead of calling the hooks LSM_STATE and LSM_POLICY, we should keep it more generic so that it can be utilized by any subsystem to measure their "critical data"?
>>>
>>> Policy, state, history or whim, it should be up to the security module
>>> to determine what data it cares about, and how it should be measured.
>>> Smack does not keep its policy in a single blob of data, it uses lists
>>> which can be modified at will. Your definition of the behavior for
>>> LSM_POLICY wouldn't work for Smack. That doesn't mean that there isn't
>>> a viable way to measure the Smack policy, it just means that IMA isn't
>>> the place for it. If SELinux wants its data measured, SELinux should be
>>> providing the mechanism to do it.
>>>
>>> I guess that I'm agreeing with you in part. If you want a generic measurement
>>> of "critical data", you don't need to assign a type to it, you have the
>>> caller (a security module, a device driver or whatever) identify itself and
>>> how it is going to deal with the data. That's very different from what you've
>>> done to date.
>>
>> Agree.
>>
>> Like Stephen had stated earlier, the reason we kept separate hooks (STATE and POLICY) is because the data for state is usually small and therefore we measure the entire data. Whereas, policy data is usually quite large (a few MB) and hence we measure a hash of the policy.
> 
> SELinux should determine how it wants its data measured.
> SELinux, not IMA, should determine if some "critical data"
> be measured in total, by its hash or as a count of policy
> rules. It would be handy for IMA to supply functions to do
> data blobs and hashes, but it should be up to the caller to
> decide if they meet their needs.
> 

Per feedback from you all, my colleague Tushar has posted a patch series 
that defines a generic IMA hook to measure critical data from other 
subsystems (such as SELinux, AppArmor, Device-Mapper targets, etc.)

Link to the patch series is given below:

	https://patchwork.kernel.org/patch/11711249/

Shortly I will re-post the SELinux state and hash of policy measurement 
patch that will be based on the above patch series.

thanks,
  -lakshmi
