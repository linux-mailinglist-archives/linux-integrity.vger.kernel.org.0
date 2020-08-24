Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCACD24FFE7
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Aug 2020 16:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgHXOgB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 24 Aug 2020 10:36:01 -0400
Received: from linux.microsoft.com ([13.77.154.182]:50890 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbgHXOgA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 24 Aug 2020 10:36:00 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id D2DDB20B4908;
        Mon, 24 Aug 2020 07:35:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D2DDB20B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1598279760;
        bh=f2HxVa6n2reQW84zOhm8zec3Ry0ai0OWbaiF8IC5tb4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UGjSnPsYB1Y242uKVWWJ8KFGrfyDE6bedytPq8IseIJX45Alkj7H0JB4JSrI1y/EY
         +wB270AESurzpju7ISCUH8K8y1e2Pu7gACR7mYmOIDs72bL5WDcheD5lrou5oGUO50
         tLjWRTnOcagdWUADhaTwqqEMh/95XTk6Cd01ES1Y=
Subject: Re: [PATCH] SELinux: Measure state and hash of policy using IMA
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        tusharsu@linux.microsoft.com, sashal@kernel.org,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200822010018.19453-1-nramas@linux.microsoft.com>
 <CAEjxPJ5Kok-TBfS=XQ+NUC5tuaZRkyLBOawG4UDky51_bsMnGw@mail.gmail.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <4eec93aa-2c32-8422-f62b-b101a0d0028a@linux.microsoft.com>
Date:   Mon, 24 Aug 2020 07:35:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ5Kok-TBfS=XQ+NUC5tuaZRkyLBOawG4UDky51_bsMnGw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 8/24/20 7:00 AM, Stephen Smalley wrote:
> On Fri, Aug 21, 2020 at 9:00 PM Lakshmi Ramasubramanian

> 
>> +int security_read_policy_kernel(struct selinux_state *state,
>> +                               void **data, size_t *len)
>> +{
>> +       int rc;
>> +
>> +       rc = security_read_policy_len(state, len);
>> +       if (rc)
>> +               return rc;
>> +
>> +       *data = vmalloc(*len);
>> +       if (!*data)
>> +               return -ENOMEM;
>>
>> +       return security_read_selinux_policy(state, data, len);
>>   }
> 
> See the discussion here:
> https://lore.kernel.org/selinux/20200824113015.1375857-1-omosnace@redhat.com/T/#t
> 
> In order for this to be safe, you need to ensure that all callers of
> security_read_policy_kernel() have taken fsi->mutex in selinuxfs and
> any use of security_read_policy_len() occurs while holding the mutex.
> Otherwise, the length can change between security_read_policy_len()
> and security_read_selinux_policy() if policy is reloaded.
> 

Thanks. I'll make this change.

  -lakshmi
