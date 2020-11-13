Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 390CD2B2218
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Nov 2020 18:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgKMRXE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 13 Nov 2020 12:23:04 -0500
Received: from linux.microsoft.com ([13.77.154.182]:33416 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbgKMRXC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 Nov 2020 12:23:02 -0500
Received: from [192.168.86.31] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6C59620C28A7;
        Fri, 13 Nov 2020 09:23:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6C59620C28A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1605288195;
        bh=aAzmi0v2l98LjNUH8gtaCpa7FwaGabf1iM4w3l3mIqg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=pGQd9YjkdXxUH100EXKoTq5sPmbz3UlFUxBDt0X0xz+vPCl9U2By8O+H2qXn/rKi+
         U9UGGnlTJ6jLzTqKXt8rHHTeqHb0ikHvUDTlorfMlnCHNKynEBvHKcpbhV0Xk+0onU
         rZAdaz3+OGAYOoHoM8KuaYiFpgKUNEfRrHlYNymw=
Subject: Re: [PATCH v5 3/7] IMA: add hook to measure critical data
To:     Mimi Zohar <zohar@linux.ibm.com>, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
References: <20201101222626.6111-1-tusharsu@linux.microsoft.com>
 <20201101222626.6111-4-tusharsu@linux.microsoft.com>
 <1f83ec246cb6356c340b379ab00e43f0b5bba0ae.camel@linux.ibm.com>
 <25622ca6-359d-fa97-c5e6-e314cba51306@linux.microsoft.com>
 <0f25c77c042f3e62405f12966c2358fe8cd82116.camel@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <1ce2b55e-5dd0-b147-5570-55e8db774055@linux.microsoft.com>
Date:   Fri, 13 Nov 2020 09:23:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0f25c77c042f3e62405f12966c2358fe8cd82116.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


>>> Including "data_source" here isn't quite right.  "data source" should
>>> only be added in the first patch which uses it, not here.   When adding
>>> it please shorten the field description to "kernel data source".   The
>>> longer explanation can be included in the longer function description.
>>>
>> *Question*
>> Do you mean the parameter @event_data_source should be removed from this
>> patch? And then later added in patch 7/7 – where SeLinux uses it?
> 
> Data source support doesn't belong in this patch.  Each patch should do
> one logical thing and only that one thing.  This patch is adding
> support for measuring critical data.  The data source patch will limit
> the critical data being measured.
> 
> Other than updating the data source list in the documentation,
> definitely do not add data source support to the SELinux patch.
> 
> thanks,
> 
> Mimi
> 
Makes sense, I will move the data_source from this patch to a
separate one before SeLinux.
And the SeLinux patch will simply update the documentation.

Thanks Mimi.
