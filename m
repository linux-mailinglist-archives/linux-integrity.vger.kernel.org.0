Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 770593D45C5
	for <lists+linux-integrity@lfdr.de>; Sat, 24 Jul 2021 09:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234353AbhGXGpW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 24 Jul 2021 02:45:22 -0400
Received: from linux.microsoft.com ([13.77.154.182]:40758 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234227AbhGXGpW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 24 Jul 2021 02:45:22 -0400
Received: from [192.168.86.34] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id A9EFB20B7178;
        Sat, 24 Jul 2021 00:25:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A9EFB20B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1627111554;
        bh=j9sc3SI4YPKysNT1r2bWbGxdQtuDDb0QU/B2MwlJsIM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=aJ9nyHURWGjXG+gabAK7E4DlgnV7X5d8Y+/gTnHYEpTMdCmSUWagcfZDMxayBHFPK
         8YnH90gTCOaTgnjIld5gClA1FhZaQ/2piNuHZ0NStJz+CBJT2+kfgH3iGrn4a4Oi+l
         6+1oZOt+zsJPC5xjdgzvG0crhkbIeO1S7sztf78M=
Subject: Re: [PATCH 7/7] dm: add documentation for IMA measurement support
To:     Mimi Zohar <zohar@linux.ibm.com>, dm-devel@redhat.com,
        agk@redhat.com, snitzer@redhat.com
Cc:     linux-integrity@vger.kernel.org, nramas@linux.microsoft.com
References: <20210713004904.8808-1-tusharsu@linux.microsoft.com>
 <20210713004904.8808-8-tusharsu@linux.microsoft.com>
 <205b5336d60aee6b3f33ad67b2d0250e104d6779.camel@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <6b81b92f-7d7b-d198-5056-bab1bcbac522@linux.microsoft.com>
Date:   Sat, 24 Jul 2021 00:25:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <205b5336d60aee6b3f33ad67b2d0250e104d6779.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

On 7/20/21 7:33 PM, Mimi Zohar wrote:
> Hi Tushar, Mike,
> 
> On Mon, 2021-07-12 at 17:49 -0700, Tushar Sugandhi wrote:
>> +Then IMA ASCII measurement log has the following format:
>> +PCR TEMPLATE_DIGEST TEMPLATE ALG:EVENT_DIGEST EVENT_NAME EVENT_DATA
>> +
>> +PCR := Platform Configuration Register, in which the values are registered.
>> +       This is applicable if TPM chip is in use.
>> +TEMPLATE_DIGEST := Template digest of the IMA record.
> 
> ^TEMPLATE_DATA_DIGEST
> 
Will do.

>> +TEMPLATE := Template that registered the integrity value (e.g. ima-buf).
> 
> ^TEMPLATE_NAME
>
Will do.

> The template data format consists of:
>> +ALG:EVENT_DIGEST = Algorithm to compute event digest, followed by digest of event data
>> +EVENT_NAME := Description of the event (e.g. 'table_load').
>> +EVENT_DATA := The event data to be measured.
> 
Thanks. I will add this to the dm-ima documentation.

> Missing from the document is a way of validating the template data.
> For example, in the original case of file measurements, the template
> data contains the file hash, which can be recalculated or verified
> against an allow list.
> 
> Other than re-calculating the template data digest based on the
> template data, and verifying it against the template data digest in the
> measurement list, would an attestation server be able to verify the
> template data itself?
>
Yes.
In the context of device-mapper, EVENT_DATA for 'table_load' would
contain the key-value pairs for various targets in the table
(crypt, verity, integrity etc.) which the attestation servers
should be able to verify against the allowed/expected
key-value pairs specified in the attestation policy.

To avoid bloating the IMA log with same data from table_load again,
we only measure hash of the loaded table in the EVENT_DATA -
when there is a state change for DM device.
e.g. when EVENT_NAME is 'device_resume', 'table_clear',
'device_remove' etc.

Since the table clear-text is already present in the EVENT_DATA
buffer for 'table_load', and is available to attestation servers,
verifying the corresponding hash values in the
EVENT_DATA in the subsequent DM events should be possible for
the attestation servers.

Please let us know if you need further info.

Thanks,
Tushar

> thanks,
> 
> Mimi
> 
