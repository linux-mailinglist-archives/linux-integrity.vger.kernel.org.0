Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 307BD2EF6DD
	for <lists+linux-integrity@lfdr.de>; Fri,  8 Jan 2021 18:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbhAHR7R (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 8 Jan 2021 12:59:17 -0500
Received: from linux.microsoft.com ([13.77.154.182]:48070 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbhAHR7Q (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 8 Jan 2021 12:59:16 -0500
Received: from [192.168.1.13] (c-24-16-6-251.hsd1.wa.comcast.net [24.16.6.251])
        by linux.microsoft.com (Postfix) with ESMTPSA id CFC4D20B7192;
        Fri,  8 Jan 2021 09:58:35 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CFC4D20B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1610128716;
        bh=vV0VtRq33toP/rLMWnrhubjzoAMQ1mTnfcpAtrnqK+E=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=debEcT53rRjTCIaU9V3cO9Rj/+t+9vlohpCcb9BeeBqaE+rUnf9/Da9yRCUnZ8gUG
         7dk9Ex7wmeSYPLnrv3NSsKmLX5tqEyLDy7tW62St3Q/TPfm+lvax4JPeIegYDd8ziQ
         80r7nTX1wm78kZaV7zNwWJ2dHjtnRBgpXB3rkEtA=
Subject: Re: [RFC] Persist ima logs to disk
To:     Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        janne.karhunen@gmail.com
Cc:     linux-integrity@vger.kernel.org, tusharsu@linux.microsoft.com,
        tyhicks@linux.microsoft.com, nramas@linux.microsoft.com,
        balajib@linux.microsoft.com, Amir Goldstein <amir73il@gmail.com>
References: <20210105195742.2629-1-raphgi@linux.microsoft.com>
 <87127d502bcb9707dd4e7a43475ab6bed2fdd421.camel@linux.ibm.com>
 <715a265180a092754ab9ea8522c39427645b25ad.camel@HansenPartnership.com>
 <6e28c7a9742131cf508e77448bfee0a03b2c2e5e.camel@linux.ibm.com>
 <3c50bc449aae2f09bd7d43c401cc9b292f9ec2ae.camel@HansenPartnership.com>
 <570d54ca679b7a4f786fa65eb78601a2af91c397.camel@linux.ibm.com>
 <13447f30db609d4bd77d5a826c5102dd5a931a19.camel@HansenPartnership.com>
 <734adc26-0050-ce8f-4c8c-c8a907b569a6@linux.microsoft.com>
 <8c78437d0e9a4968996b834030661b6f567f87eb.camel@linux.ibm.com>
From:   Raphael Gianotti <raphgi@linux.microsoft.com>
Message-ID: <fc9a5d48-dc29-0d5d-55dd-bacac346da10@linux.microsoft.com>
Date:   Fri, 8 Jan 2021 09:58:33 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <8c78437d0e9a4968996b834030661b6f567f87eb.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 1/8/2021 4:38 AM, Mimi Zohar wrote:
> On Thu, 2021-01-07 at 14:57 -0800, Raphael Gianotti wrote:
>>>>>> But this doesn't address where the offloaded measurement list
>>>>>> will be stored, how long the list will be retained, nor who
>>>>>> guarantees the integrity of the offloaded list.  In addition,
>>>>>> different form factors will have different requirements.
>> For how long the list would be retained, or in the case of a log segments, it
>> might make sense to have that be an admin decision, something that can be
>> configured to satisfy the needs of a specific system, as mentioned below by
>> James, does that seem correct?
> For the discussion on exporting and truncating the IMA measurement
> list, refer to:
> https://lore.kernel.org/linux-integrity/1580998432.5585.411.camel@linux.ibm.com/
>
>> Given the possibility of keeping the logs around for an indefinite amount of
>> time, would using an expansion of the method present in this RFC be more
>> appropriate than going down the vfs_tmpfile route? Forgive my lack on expertise
>> on mm, but would the vfs_tmpfile approach work for keeping several log segments
>> across multiple kexecs?
> With the "vfs_tmpfile" mechanism, breaking up and saving the log in
> segments isn't needed.  The existing mechanism for carrying the
> measurement list across kexec would still be used.  Currently, if the
> kernel cannot allocate the memory needed for carrying the measurement
> across kexec, it simply emits an error message, but continues with the
> kexec.

In this change I had introduced "exporting" the log to disk when the size
of the measurement list was too large. Given part of the motivation behind
moving the measurement list is the possibility of it growing too large
and taking up too much of the kernel memory, that case would likely lead
to kexec not being able to carry over the logs. Do you believe it's better
to use the "vfs_tmpfile" mechanism for moving the logs to disk and worry
about potential issues with kexec not being able to carry over the logs
separately, given the "vfs_tempfile" approach seems to be preferred and
also simplifies worries regarding truncating the logs?

>
> Mimi
