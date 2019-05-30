Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7412FDBA
	for <lists+linux-integrity@lfdr.de>; Thu, 30 May 2019 16:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbfE3O1y (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 May 2019 10:27:54 -0400
Received: from ucol19pa14.eemsg.mail.mil ([214.24.24.87]:54334 "EHLO
        ucol19pa14.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfE3O1y (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 May 2019 10:27:54 -0400
X-Greylist: delayed 640 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 May 2019 10:27:54 EDT
X-EEMSG-check-017: 710501177|UCOL19PA14_EEMSG_MP12.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.60,531,1549929600"; 
   d="scan'208";a="710501177"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by ucol19pa14.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 30 May 2019 14:17:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1559225825; x=1590761825;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=x5pYU4TCoWLgtVrEJGOcRQt8l++yCJCVevkaZbRxsjU=;
  b=A8zKi57cl/j/nJjQeu8ipfA/Wdi6+VcxByRnHBmDXfbjuLdUI5JYX7vh
   GWWIGG1yrYVyNU7dO+5et2hBLZ/vuxmDynnRUjREE0XN8YQkAoouFlXP1
   7vRgZx5g5UgDvbSY5tV57cQ2OXtZe624tQnoRKFaq1Y4U3oVQ5mjglaDA
   BJUf/1mjh4VS3ja8Nbf81kudSFHvFKyChlW674S90v95awXCJCLYN/ggt
   ic0dbiuyVln9U5PPPd0738MmlV2dQJmceXSYWtq6AA6VrG6t90e2AbG+v
   1RB/thC0jdp7W63RobGeLyVHDu/vQN8vFqzdVIfYtJazt/MipkZuNoWa3
   A==;
X-IronPort-AV: E=Sophos;i="5.60,531,1549929600"; 
   d="scan'208";a="28345223"
IronPort-PHdr: =?us-ascii?q?9a23=3A/SkXyBEBayG2UBdwCDwp4Z1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ76psiybnLW6fgltlLVR4KTs6sC17OP9fm6CCdfvd6oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vMRm6txjdutcSjIdtKKs8xQ?=
 =?us-ascii?q?bCr2dVdehR2W5mP0+YkQzm5se38p5j8iBQtOwk+sVdT6j0fLk2QKJBAjg+PG?=
 =?us-ascii?q?87+MPktR/YTQuS/XQcSXkZkgBJAwfe8h73WIr6vzbguep83CmaOtD2TawxVD?=
 =?us-ascii?q?+/4apnVAPkhSEaPDMi7mrZltJ/g75aoBK5phxw3YjUYJ2ONPFjeq/RZM4WSX?=
 =?us-ascii?q?ZdUspUUSFODJm8b48SBOQfO+hWoZT2q18XoRa+AQSgAeXiwSJKiHDrx603y/?=
 =?us-ascii?q?kvHx/I3AIgHNwAvnrbo9r3O6gOXu6417XIwDfZYv9KxTvw5orFfxY8qv+MR7?=
 =?us-ascii?q?Jwds/RxFEyGQPZkFqQsYzlMC2T1u8Qrmab6vBvVeari2E5qwB6vz+ixtwxhY?=
 =?us-ascii?q?nSnY8V1lDF+jl5wIYyP9G4TlV7bsS+HJtfsCGaKZJ7T8U/SG9roCY30qAKtJ?=
 =?us-ascii?q?G0cSQQyJkr2gTTZ+KIfoSW+B7vSeCcKipiin1/YrKwnROy/FClyu37S8a7zk?=
 =?us-ascii?q?5HrjFAktnQrnAN0AHT6tSfRvt94Eih3TGP2hjP6u5eO0A0lLfbK4U7zr4slp?=
 =?us-ascii?q?scrUTDHijslEXwkKCWbVkr9vKt6+TmZrXqvp6cN4lqhQHiKqkih8OyDOsiPg?=
 =?us-ascii?q?UOQmSX4/qw2bL98UHjXblGlvg2nbPYsJDeK8QbvKm5AwpN34Y49hm/FCyr0M?=
 =?us-ascii?q?gYnHYbLFJFfwiLj47yO17UOvz4AvC/g0q0nDdx2//GJqHhAonKLnXbkrfuZ7?=
 =?us-ascii?q?B960hCxwYpztBQ/YhUCrEcIPL1REDxssfVDhA8MwOuwubnDM9x2Z8ZWWKKGq?=
 =?us-ascii?q?WZKr/dsUeU5uIzJOmBfI4UuDH9K/c//f7jlns5mV4bfam00pobcnG4Ee9jI0?=
 =?us-ascii?q?mDfXXshdIBG38QvgUiVOzqlEGCUTlLanaqRa08+zU7BZm+DYjZW4CthKWN3C?=
 =?us-ascii?q?K8Hp1RfGBJFEqAHmvvd4WBQ/0Mcj6dItd9kjwYUrisU4sh1RCotA/nxLtrN+?=
 =?us-ascii?q?vU+isEtZ3929h1/ezTlQ0y9DFvEcSd3H+CT3tukmMLWTA2xqZ/rlJ5yluZ1q?=
 =?us-ascii?q?h4mfNYH8RJ5/xVSgc6KYLcz+tiBtD2WwLBeMqJSVm/TtW9Hz4+Us8xw8UPY0?=
 =?us-ascii?q?ZhG9SulxXD3y23DL8Ik7yEGoc58rzT33fvPcZx0XXG27c7j1kgXMRPMXeqhq?=
 =?us-ascii?q?ll9wjcH4TJiVmWl762daQA2y7A7HqMwnCIvEFZTgFwVafFUGsaZkTIqdT54l?=
 =?us-ascii?q?nNT7mpCbUoKAdO1cmCKq4ZIuHu2HdPQvHucPfXeWKsnWq2TUKKz7WKYczpcn?=
 =?us-ascii?q?8dwSPQDmALlgkS+TCNMg1oVQm7pGeLNyBjDVLiZQvX9OB6rH6qBhsvwxqic1?=
 =?us-ascii?q?xq173z/AUcw/ObVaVAjfo/pC49pmAsTx6G1NXMBo/F/lcwcQ=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BVCwA/5e9c/wHyM5BlHQEBBQEHBQGBZYFnKoFtKIQUk?=
 =?us-ascii?q?wJPAQEBBoE1iVCJcIcXCQEBAQEBAQEBATQBAgEBhEACgn0jOBMBAwEBAQQBA?=
 =?us-ascii?q?QEBAwEBbCiCOikBgmYBAQEBAgEjBBFBEAsYAgImAgJXBg0GAgEBgl8/gXcFD?=
 =?us-ascii?q?6omfDOFR4MogUaBDCiLVhd4gQeBOIJrPodOglgEk2uUF2oJgg+CFpEHBhuCI?=
 =?us-ascii?q?ZQ3LY1zlm4hgVgrCAIYCCEPgyeCGxeOPCMDMIEGAQGNfQEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 30 May 2019 14:17:05 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x4UEH2nh017089;
        Thu, 30 May 2019 10:17:03 -0400
Subject: Re: sleep in selinux_audit_rule_init
To:     Janne Karhunen <janne.karhunen@gmail.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Paul Moore <paul@paul-moore.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Dan Jurgens <danielj@mellanox.com>
References: <CAE=NcrYsfQ2ijJJMEyTFoWnFqF2qGS=B2JNsVaE8WUNcGS7D9Q@mail.gmail.com>
 <e8dcc9a2-594d-f81a-32a7-e18f591c6062@tycho.nsa.gov>
 <4a725f06-8244-8264-a911-df7ca1c66789@tycho.nsa.gov>
 <1558530022.4347.11.camel@linux.ibm.com>
 <4db98b76-8637-edf6-c7df-3e244be0f11e@tycho.nsa.gov>
 <1558533420.4347.30.camel@linux.ibm.com>
 <1432f617-424e-044c-4f78-47f1100262ae@tycho.nsa.gov>
 <CAE=NcranYrvV5Xnu8656kyDVUUzCs=Tdy+fkeo5jwVhtF8=81Q@mail.gmail.com>
 <a39cedd1-a932-3140-bf11-ef4e3a88e254@tycho.nsa.gov>
 <CAE=NcrYV_x6dKbVvO+EDZNKMuEqVhyMKrdEjuUJXqfcYVeiXBA@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <54d804d0-25a6-2f5c-8fc9-0c671e34b8eb@tycho.nsa.gov>
Date:   Thu, 30 May 2019 10:17:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAE=NcrYV_x6dKbVvO+EDZNKMuEqVhyMKrdEjuUJXqfcYVeiXBA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 5/30/19 9:27 AM, Janne Karhunen wrote:
> On Thu, May 30, 2019 at 3:08 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
>>> @@ -269,11 +269,23 @@ static void ima_lsm_update_rules(void)
>>>                                                              Audit_equal,
>>>                                                              entry->lsm[i].args_p,
>>>                                                              &entry->lsm[i].rule);
>>> -                       BUG_ON(!entry->lsm[i].rule);
>>> +                       if (result == -EINVAL)
>>> +                               pr_warn("ima: rule for LSM \'%d\' is invalid\n",
>>> +                                       entry->lsm[i].type);
>>
>> I could be wrong, but I think there is still a problem here in that you
>> are modifying entry->lsm[i].rule in-place, but it is protected under RCU
>> and therefore needs to be duplicated and then modified?  Also you are
>> leaking the old rule?
> 
> Right. Bit too fast tapping the keyboard without thinking, will fix
> and post in the proper form. But I guess the original point was to
> verify if that 'notifier_block' is indeed the right way to get the
> update notification?

Yes.

> 
>>   Both of those issues also exist prior to your
>> patch but you aren't fixing them here. And lastly, it looks like lsm
>> notifiers are atomic notifiers (not clear to me why) so you can't block
>> in the callback, thereby requiring scheduling the work as is done in
>> infiniband.
> 
> Great catch, thank you. That's an easy fix if no-one objects pushing
> these through the system-wq for example.

I think you can switch the lsm notifier over to using blocking notifiers 
instead; there seems to be no valid reason for making it atomic.


