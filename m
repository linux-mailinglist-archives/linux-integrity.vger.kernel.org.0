Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE4622CACC
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Jul 2020 18:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgGXQTc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 24 Jul 2020 12:19:32 -0400
Received: from linux.microsoft.com ([13.77.154.182]:39714 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgGXQTc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 24 Jul 2020 12:19:32 -0400
Received: from [192.168.1.22] (c-71-58-88-195.hsd1.pa.comcast.net [71.58.88.195])
        by linux.microsoft.com (Postfix) with ESMTPSA id D9A2820B4908;
        Fri, 24 Jul 2020 09:19:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D9A2820B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1595607571;
        bh=TtbKzEWXFrC8pjh8I3QKrliiQRzFkZKrfn4AgUk+fQw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Lznvocsl64E8unwJUhV4vNA16i8fOEYGY4WHiEL3BUK7ZetxXzhgZiaOWjyWDsJCe
         X+PQ4EbCdRpwcx4DFdmRHL2otjxCTRGBpfqevU8IpJVsci1US/prvFTHmN4El9x9HR
         6VbyL2wEASoE8TiZS7ze7FaObOtjOFjam5gtP8Ew=
Subject: Re: [PATCH v4 2/2] IMA: Add test for kexec cmdline measurement
To:     Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.ibm.com>
Cc:     ltp@lists.linux.it,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        balajib@linux.microsoft.com, linux-integrity@vger.kernel.org
References: <20200724070038.29491-1-pvorel@suse.cz>
 <20200724070038.29491-2-pvorel@suse.cz>
 <1595592111.5211.246.camel@linux.ibm.com> <20200724131845.GB24626@dell5510>
From:   Lachlan Sneff <t-josne@linux.microsoft.com>
Message-ID: <7cec65cc-efc7-045e-e905-07ad18ad24be@linux.microsoft.com>
Date:   Fri, 24 Jul 2020 12:19:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200724131845.GB24626@dell5510>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Petr,

On 7/24/20 9:18 AM, Petr Vorel wrote:
> Hi all,
>
>> On Fri, 2020-07-24 at 09:00 +0200, Petr Vorel wrote:
>>> From: Lachlan Sneff <t-josne@linux.microsoft.com>
>>> IMA policy can be set to measure the command line passed in the kexec
>>> system call. Add a testcase that verifies that the IMA subsystem
>>> correctly measure the cmdline specified during a kexec.
>>> Note that this test does not actually reboot.
>>>
>>>
>>> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>>> Signed-off-by: Lachlan Sneff <t-josne@linux.microsoft.com>
>>> Signed-off-by: Petr Vorel <pvorel@suse.cz>
>>> ---
>>> Hi,
>>> sent version with few my fixes.
>>> @Mimi: could you please have a quick look? (I know you reviewed previous
>>> version.)
> @Mimi, @Lachlan: if you both ack my changes, I can fix the code before merging.
> If there are more changes needed and thus Lachlan plan new version, please use
> my patches from https://patchwork.ozlabs.org/project/ltp/list/?series=191990&state=*
> (download https://patchwork.ozlabs.org/series/191990/mbox/ and import it with "git am")
> or clone my github fork and use kexec.v3.fixes branch:
> https://github.com/pevik/ltp/tree/ima/kexec.v3.fixes).
Hi Petr, these changes look good to me. I'm not exactly sure the 
convention here,
since I originally wrote the patch, but feel free to mark me as 
Signed-off-by.
>
> Kind regards,
> Petr
Thank you for working on this!
Lachlan
