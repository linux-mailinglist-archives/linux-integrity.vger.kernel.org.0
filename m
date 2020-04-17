Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD39D1AD3BF
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Apr 2020 02:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbgDQAtq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Apr 2020 20:49:46 -0400
Received: from linux.microsoft.com ([13.77.154.182]:55392 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgDQAtp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Apr 2020 20:49:45 -0400
Received: from [192.168.86.21] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7355420B4737;
        Thu, 16 Apr 2020 17:49:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7355420B4737
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1587084584;
        bh=QV36QWIYM6W7LdgpJqSP6H4kiHWCR20PTc2rSdaxqZg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=MnVlDzvmbHWZnrYV5o56wOdeu0ricWbz4vhV1FtrbcDo81EY+VuIQ5oUYWKDBiFKv
         VgCUE5EMclF6kSr8VNuLc/6pvXB24BA8Tq0es/oR8P1FexQWL+wGBpem4yX79VzX5c
         qViIQVrWpEBf1qjOWqMlDHloeY9CQOkZRDgK4a5U=
Subject: Re: [RFC] IMA: New IMA measurements for dm-crypt and selinux
To:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        dm-devel@redhat.com
Cc:     jmorris@namei.org, chpebeni@linux.microsoft.com,
        nramas@linux.microsoft.com, balajib@microsoft.com,
        sashal@kernel.org, suredd@microsoft.com
References: <f92bef0f-eb40-0e07-540c-321134e4b070@linux.microsoft.com>
 <b8dcaa3d-5006-2730-aa57-fb99e13c4472@schaufler-ca.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <1feebdbe-94a8-16f7-deea-704e858a40a4@linux.microsoft.com>
Date:   Thu, 16 Apr 2020 17:49:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <b8dcaa3d-5006-2730-aa57-fb99e13c4472@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 2020-04-08 9:34 a.m., Casey Schaufler wrote:
> On 4/8/2020 3:19 AM, Tushar Sugandhi wrote:
<snip>
>>
>> B. Measuring selinux constructs:
>>      We propose to add an IMA hook in enforcing_set() present under
>>      security/selinux/include/security.h.
>>      enforcing_set() sets the selinux state to enforcing/permissive etc.
>>      and is called from key places like selinux_init(),
>>      sel_write_enforce() etc.
>>      The hook will measure various attributes related to selinux status.
>>      Majority of the attributes are present in the struct selinux_state
>>      present in security/selinux/include/security.h
>>      e.g.
>>      $sestatus
>>             SELinux status:              enabled
>>             SELinuxfs mount:             /sys/fs/selinux
>>             SELinux root directory:      /etc/selinux
>>             Loaded policy name:          default
>>             Current mode:                permissive
>>             Mode from config file:       permissive
>>             Policy MLS status:           enabled
>>             Policy deny_unknown status:  allowed
>>             Memory protection checking:  requested (insecure)
>>             Max kernel policy version:   32
>>
>>      The above attributes will be serialized into a set of key=value
>>      pairs when passed to IMA for measurement.
>>
>>      Proposed Function Signature of the IMA hook:
>>      void ima_selinux_status(void *selinux_status, int len);
>>
>> Please provide comments\feedback on the proposal.
> 
> TL;DR - Why make this SELinux specific?
> 
> Integrating IMA and SELinux is a layering violation at best.
> Why isn't this ima_lsm_status(void *lsm_status, int len)?
That seems like a good idea.
I will investigate where can I place the hook for LSM.
Please let me know if you have any recommendations.
> Or, better yet, how about ima_lsm_status(char *name, void *value, int len),
> and you pass each name/value pair separately? That makes the
> interface generally useful.
> 
> Believe it or not, there *ARE* security modules that
> are not SELinux.
> 
>>
>> Thanks,
>> Tushar
>>
>> [1] https://sourceforge.net/p/linux-ima/wiki/Home/
>> [2] https://selinuxproject.org/page/FAQ
>> [3] https://gitlab.com/cryptsetup/cryptsetup/wikis/DMCrypt
