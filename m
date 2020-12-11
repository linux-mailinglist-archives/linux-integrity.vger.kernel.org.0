Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78C082D6D92
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Dec 2020 02:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389796AbgLKBad (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Dec 2020 20:30:33 -0500
Received: from linux.microsoft.com ([13.77.154.182]:53436 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389797AbgLKBa3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Dec 2020 20:30:29 -0500
Received: from [192.168.86.31] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5007320B717A;
        Thu, 10 Dec 2020 17:29:48 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5007320B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1607650188;
        bh=yGgzoIdOorbDs7MxKlg+eL3hr036hpEtLmS92RUcudE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=atAYxjfS4S+6flO2iq7tGQCKH1dwb7TX5DHXLt0M7SEA+Olvn4o6HH1g3u6UypVYd
         E7ApJD01S/8ifxPosxr9WzFOQW8E7wJUsOfc3rtrgqzjLTSO5++WuHAk1H8xmfc3qF
         Ph8i/xozYVTLTThJbGWxwTrie4zn0apcGL67klHQ=
Subject: Re: [PATCH v7 6/8] IMA: extend critical data hook to limit the
 measurement based on a label
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com, sashal@kernel.org,
        jmorris@namei.org, nramas@linux.microsoft.com,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
References: <20201209194212.5131-1-tusharsu@linux.microsoft.com>
 <20201209194212.5131-7-tusharsu@linux.microsoft.com>
 <20201210231922.GK489768@sequoia>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <d0ad5746-e699-ad61-72bd-15a373e06928@linux.microsoft.com>
Date:   Thu, 10 Dec 2020 17:29:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201210231922.GK489768@sequoia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 2020-12-10 3:19 p.m., Tyler Hicks wrote:
> On 2020-12-09 11:42:10, Tushar Sugandhi wrote:
>> The IMA hook ima_measure_critical_data() does not support a way to
>> specify the source of the critical data provider. Thus, the data
>> measurement cannot be constrained based on the data source label
>> in the IMA policy.
>>
>> Extend the IMA hook ima_measure_critical_data() to support passing
>> the data source label as an input parameter, so that the policy rule can
>> be used to limit the measurements based on the label.
>>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> 
> Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> 
> Tyler
> 
Thanks for the review.
~Tushar
