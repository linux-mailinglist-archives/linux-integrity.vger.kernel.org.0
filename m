Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74CA42D7CE3
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Dec 2020 18:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395150AbgLKR3N (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Dec 2020 12:29:13 -0500
Received: from linux.microsoft.com ([13.77.154.182]:33958 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394616AbgLKR2x (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Dec 2020 12:28:53 -0500
Received: from [192.168.86.31] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1616220B717A;
        Fri, 11 Dec 2020 09:28:12 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1616220B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1607707692;
        bh=Hk+1o6qAUkRmm64fM9bJ/clQ0i7hDtiKdMK/UvrH55s=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=j7w4kZQDQ8Gvuat3uH0J0qoskfgEj4aQHWIxWqJqU8/B+7j1ul13OO27hzYKusDXB
         tPeW18Zc43ck5wwPkskxx9pTUoKXKvNKRZnNTwpJ7D/t2ANjBHoeXiGpxkfQQvXmD7
         PUYSLBTZbDNmFs3EYvyfvZ3YWucpvLgkq1XHiAKU=
Subject: Re: [PATCH v7 3/8] IMA: define a hook to measure kernel integrity
 critical data
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com, sashal@kernel.org,
        jmorris@namei.org, nramas@linux.microsoft.com,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
References: <20201209194212.5131-1-tusharsu@linux.microsoft.com>
 <20201209194212.5131-4-tusharsu@linux.microsoft.com>
 <20201210230218.GH489768@sequoia>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <b65f2a10-037b-0fb7-fe88-5cc8482faedc@linux.microsoft.com>
Date:   Fri, 11 Dec 2020 09:28:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201210230218.GH489768@sequoia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

<snip>

>> + */
>> +void ima_measure_critical_data(const char *event_name,
>> +			       const void *buf, int buf_len,
>> +			       bool measure_buf_hash)
>> +{
>> +	if (!event_name || !buf || !buf_len) {
>> +		pr_err("Invalid arguments passed to %s().\n", __func__);
> 
> This is a problem for the developer making use of the
> ima_measure_critical_data() API and shouldn't be logged, IMO, because a
> user/admin can do nothing about it. I think the error message should be
> dropped.
> 
Thanks Tyler.
Will drop the message.
