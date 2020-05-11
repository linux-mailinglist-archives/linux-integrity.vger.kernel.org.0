Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31BF71CE233
	for <lists+linux-integrity@lfdr.de>; Mon, 11 May 2020 20:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731043AbgEKSDd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 11 May 2020 14:03:33 -0400
Received: from linux.microsoft.com ([13.77.154.182]:33770 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgEKSDc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 May 2020 14:03:32 -0400
Received: from [10.137.106.115] (unknown [131.107.174.243])
        by linux.microsoft.com (Postfix) with ESMTPSA id A459320B717B;
        Mon, 11 May 2020 11:03:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A459320B717B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1589220212;
        bh=rwCBjFjDRVRa/3cB9IsEzNvfLiKX6lRSr9M18CC7//4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QiKdEKorw3cyT1qWZiMET9W5veSrPG4eNvJe3qaXWcFMXz1t90fAPlv3CSYWjU6is
         1U+rcd04LKlXY+H4saO7e/yVSmO+N7R04feR23EWhVyWDS+8htuwyPBoJbD80fxF69
         MRo3aLdTplD7OzjW3HYeo901uWPxV5t777MZqC54=
Subject: Re: [RFC PATCH v3 00/12] Integrity Policy Enforcement LSM (IPE)
To:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        agk@redhat.com, axboe@kernel.dk, snitzer@redhat.com,
        jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, jannh@google.com
Cc:     tyhicks@linux.microsoft.com, pasha.tatashin@soleen.com,
        sashal@kernel.org, jaskarankhurana@linux.microsoft.com,
        nramas@linux.microsoft.com, mdsakib@linux.microsoft.com,
        linux-kernel@vger.kernel.org, corbet@lwn.net
References: <20200415162550.2324-1-deven.desai@linux.microsoft.com>
 <b07ac7e1-7cf5-92c9-81d0-64174c3d5024@digikod.net>
From:   Deven Bowers <deven.desai@linux.microsoft.com>
Message-ID: <0001755a-6b2a-b13b-960c-eb0b065c8e3c@linux.microsoft.com>
Date:   Mon, 11 May 2020 11:03:31 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <b07ac7e1-7cf5-92c9-81d0-64174c3d5024@digikod.net>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 5/10/2020 2:28 AM, Mickaël Salaün wrote:

[...snip]

>>
>> Additionally, rules are evaluated top-to-bottom. As a result, any
>> revocation rules, or denies should be placed early in the file to ensure
>> that these rules are evaluated before a rule with "action=ALLOW" is hit.
>>
>> IPE policy is designed to be forward compatible and backwards compatible,
>> thus any failure to parse a rule will result in the line being ignored,
>> and a warning being emitted. If backwards compatibility is not required,
>> the kernel commandline parameter and sysctl, ipe.strict_parse can be
>> enabled, which will cause these warnings to be fatal.
> 
> Ignoring unknown command may lead to inconsistent beaviors. To achieve
> forward compatibility, I think it would be better to never ignore
> unknown rule but to give a way to userspace to known what is the current
> kernel ABI. This could be done with a securityfs file listing the
> current policy grammar.
> 

That's a fair point. From a manual perspective, I think this is fine.
A human-user can interpret a grammar successfully on their own when new
syntax is introduced.

 From a producing API perspective, I'd have to think about it a bit 
more. Ideally, the grammar would be structured in such a way that the 
userland
interpreter of this grammar would not have to be updated once new syntax
is introduced, avoiding the need to update the userland binary. To do so
generically ("op=%s") is easy, but doesn't necessarily convey sufficient
information (what happens when a new "op" token is introduced?). I think
this may come down to regular expression representations of valid values
for these tokens, which worries me as regular expressions are incredibly
error-prone[1].

I'll see what I can come up with regarding this.


[1] 
https://blog.cloudflare.com/details-of-the-cloudflare-outage-on-july-2-2019/
