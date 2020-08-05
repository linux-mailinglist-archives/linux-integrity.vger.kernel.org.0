Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D085523CD63
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Aug 2020 19:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbgHER0j (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 Aug 2020 13:26:39 -0400
Received: from linux.microsoft.com ([13.77.154.182]:51984 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728734AbgHERZm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 Aug 2020 13:25:42 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 996E520B4908;
        Wed,  5 Aug 2020 10:25:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 996E520B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1596648341;
        bh=+M6ltu7sGUQlnHNTsNp9mZLiIc2hQZ8PeYQpqVYXFYM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=aq120tI83eo/0ZfotJa85eOXCSF6WK2VaEKe3K2eI2Z1BqmcHcv5/LO7pbV8P3+cS
         mDeBH4cFuU3GixNGpG6yad9UkomydJTxgRnnBfA7TMacP+M+eS8KMn5BgrBUhTrVqj
         Tf4oYsXQu+N4S/h0nRw7ASxCAi5FIzFChV3/3c+Q=
Subject: Re: [PATCH v6 0/4] LSM: Measure security module data
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Casey Schaufler <casey@schaufler-ca.com>
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
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <9ad079ff-1bd4-1302-e6fb-25a7396ef12f@linux.microsoft.com>
Date:   Wed, 5 Aug 2020 10:25:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <69810007161e689ac817099fb1c6df21962963e4.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 8/5/20 10:03 AM, Mimi Zohar wrote:
> On Wed, 2020-08-05 at 10:45 -0500, Tyler Hicks wrote:
> 
>> In addition to SELINUX_STATE and SELINUX_POLICY, we should also consider
>> the proposed LSM_STATE and LSM_POLICY func values but require an "lsm"
>> rule conditional.
>>
>> So the current proposed rules:
>>
>>   measure func=LSM_STATE
>>   measure func=LSM_POLICY
>>
>> Would become:
>>
>>   measure func=LSM_STATE lsm=selinux
>>   measure func=LSM_POLICY lsm=selinux
>>
>> The following rules would be rejected:
>>
>>   measure func=LSM_STATE
>>   measure func=LSM_POLICY
>>   measure func=LSM_STATE lsm=apparmor
>>   measure func=LSM_POLICY lsm=smack
> 
> Kees is cleaning up the firmware code which differentiated between how
> firmware was loaded.   There will be a single firmware enumeration.
> 
> Similarly, the new IMA hook to measure critical state may be placed in
> multiple places.  Is there really a need from a policy perspective for
> differentiating the source of the critical state being measurind?   The
> data being measured should include some identifying information.

Yes Mimi - SELinux is including the identifying information in the 
"event name" field. Please see a sample measurement of STATE and POLICY 
for SELinux below:

10 e32e...5ac3 ima-buf sha256:86e8...4594 
selinux-state-1595389364:287899386 
696e697469616c697a65643d313b656e61626c65643d313b656e666f7263696e673d303b636865636b72657170726f743d313b6e6574776f726b5f706565725f636f6e74726f6c733d313b6f70656e5f7065726d733d313b657874656e6465645f736f636b65745f636c6173733d313b616c776179735f636865636b5f6e6574776f726b3d303b6367726f75705f7365636c6162656c3d313b6e6e705f6e6f737569645f7472616e736974696f6e3d313b67656e66735f7365636c6162656c5f73796d6c696e6b733d303

10 f4a7...9408 ima-ng sha256:8d1d...1834 
selinux-policy-hash-1595389353:863934271

> 
> I think moving away from the idea that measuring "critical" data should
> be limited to LSMs, will clarify this.
> 

Are you suggesting that instead of calling the hooks LSM_STATE and 
LSM_POLICY, we should keep it more generic so that it can be utilized by 
any subsystem to measure their "critical data"?

I think that is a good idea.

  -lakshmi
