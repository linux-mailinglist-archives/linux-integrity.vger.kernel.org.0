Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4668D393389
	for <lists+linux-integrity@lfdr.de>; Thu, 27 May 2021 18:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbhE0QVU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 May 2021 12:21:20 -0400
Received: from linux.microsoft.com ([13.77.154.182]:52750 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbhE0QVU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 May 2021 12:21:20 -0400
Received: from [192.168.86.31] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 87CE320B8006;
        Thu, 27 May 2021 09:19:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 87CE320B8006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1622132386;
        bh=iaY2kkULryKMnFojuv9SqYYAR272Ejf87xXgilf1xvw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Fohw0RTIEfzZGNNgDiBhvAMN0CmRNfAB41R+f7e336Koqjt+wXMMPNjhGDGQzcmjH
         n6x7HsRsbJjE0mMwXQagYkPGPhWpw+WAar9ZJlWcbqoJ5Qhlp+Mtjox5W8ekSybF7b
         riHgvwT+iZCMDO0EUvUe73FzRFeEToeSdc9J8lbw=
Subject: Re: [PATCH v4] IMA: support for duplicate measurement records
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, pvorel@suse.cz
References: <20210510190939.28279-1-tusharsu@linux.microsoft.com>
 <4b21151fc53855049c8a452339be88be2e26f53c.camel@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <5daedb73-6c42-d556-2090-25d08f536ff1@linux.microsoft.com>
Date:   Thu, 27 May 2021 09:19:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4b21151fc53855049c8a452339be88be2e26f53c.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,
Sorry for the late response.
I wanted to spend some time thinking what other scenarios I could test.
Responses below.

On 2021-05-20 1:35 p.m., Mimi Zohar wrote:
> Hi Tushar,
> 
> On Mon, 2021-05-10 at 12:09 -0700, Tushar Sugandhi wrote:
>> IMA measures contents of a given file/buffer/critical-data record,
>> and properly re-measures it on change.  However, IMA does not measure
>> the duplicate value for a given record, since TPM extend is a very
>> expensive operation.  For example, if the record changes from value
>> 'v#1' to 'v#2', and then back to 'v#1', IMA will not measure and log
>> the last change to 'v#1', since the hash of 'v#1' for that record is
>> already present in the IMA htable.  This limits the ability of an
>> external attestation service to accurately determine the current state
>> of the system.  The service would incorrectly conclude that the latest
>> value of the given record on the system is 'v#2', and act accordingly.
>>
>> Define and use a new Kconfig option IMA_DISABLE_HTABLE to permit
>> duplicate records in the IMA measurement list.
>>
>> In addition to the duplicate measurement records described above,
>> other duplicate file measurement records may be included in the log,
>> when CONFIG_IMA_DISABLE_HTABLE=y.
>> For example,
>>      - i_version is not enabled,
>>      - i_generation changed,
>>      - an inode is evicted from dcache etc.
> 
> Missing from this list are the same file, perhaps on different
> filesystmes, such as initramfs and real root.  These can be identified
> by the different i_ino.  Is there anything else?
> 
> thanks,
> 
> Mimi
> 
Sure, I can add the 4th line to the list:

For example,
     - i_version is not enabled,
     - i_generation changed,
     - an inode is evicted from dcache,
     - same file present on different filesystems, with different i_ino
       etc.

Should I spin up v5 of this patch with the updated patch description?

I was also thinking if I should cover any other scenarios, and
soft-links/hard-links seemed like a good scenario to test - so I went
ahead and tested it. And it looks like the patch is working as expected
in this scenario.

Here are the detailed findings:

If I have a file original.txt, and create a soft-link file -
softlink.txt,

(1) only original.txt is reported in IMA log, regardless if I touch
     original.txt or softlink.txt.
     This is true in both cases - when allow_dup is turned on or off.
     (i.e. with or without this patch)
(2) duplicate entries are measured only when allow_dup is turned on.

If I have a file original.txt, and create a hard-link file -
hardlink.txt,
(1) whichever file I touch first, either original.txt or hardlink.txt,
     gets measured in IMA log, both when allow_dup is turned on or off.
     (i.e. with or without this patch)
(2) duplicate entries are measured only when allow_dup is turned on.

Since the the observed behavior is identical in both cases,
soft-links and hard-links (1), and duplicates are measured only when
allow_dup is turned on as expected (2), I don't believe we should call
out soft-links/hard-links in the list above. It is not a special case
like ones mentioned in the list.

Please let me know if you think otherwise.

Thanks,
Tushar
>>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> Reviewed-by: Petr Vorel <pvorel@suse.cz>
