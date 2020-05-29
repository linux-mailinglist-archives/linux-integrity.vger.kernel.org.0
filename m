Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE411E7811
	for <lists+linux-integrity@lfdr.de>; Fri, 29 May 2020 10:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgE2IS7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 29 May 2020 04:18:59 -0400
Received: from smtp-bc0a.mail.infomaniak.ch ([45.157.188.10]:59457 "EHLO
        smtp-bc0a.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726282AbgE2IS5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 29 May 2020 04:18:57 -0400
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 49YHXH2hL3zlhf9v;
        Fri, 29 May 2020 10:18:55 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [94.23.54.103])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 49YHXB4XMdzlhC5w;
        Fri, 29 May 2020 10:18:50 +0200 (CEST)
Subject: Re: [RFC PATCH v3 00/12] Integrity Policy Enforcement LSM (IPE)
To:     Jaskaran Singh Khurana <jaskarankhurana@linux.microsoft.com>
Cc:     Deven Bowers <deven.desai@linux.microsoft.com>, agk@redhat.com,
        axboe@kernel.dk, snitzer@redhat.com, jmorris@namei.org,
        serge@hallyn.com, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, jannh@google.com,
        tyhicks@linux.microsoft.com, pasha.tatashin@soleen.com,
        sashal@kernel.org, nramas@linux.microsoft.com,
        mdsakib@linux.microsoft.com, linux-kernel@vger.kernel.org,
        corbet@lwn.net
References: <20200415162550.2324-1-deven.desai@linux.microsoft.com>
 <b07ac7e1-7cf5-92c9-81d0-64174c3d5024@digikod.net>
 <0001755a-6b2a-b13b-960c-eb0b065c8e3c@linux.microsoft.com>
 <8ba7b15f-de91-40f7-fc95-115228345fce@linux.microsoft.com>
 <44fb36ae-959d-4ff7-ed1f-ccfc2e292232@digikod.net>
 <alpine.LRH.2.21.2005161420490.8455@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.inter>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <56a8c084-1496-b465-4f01-99282ac53baf@digikod.net>
Date:   Fri, 29 May 2020 10:18:36 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.2005161420490.8455@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.inter>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Jaskaran,

On 17/05/2020 00:14, Jaskaran Singh Khurana wrote:
> 
> Hello Mickael,
> 
> On Thu, 14 May 2020, Mickaël Salaün wrote:
> 
>>
>> On 12/05/2020 22:46, Deven Bowers wrote:
>>>
>>>
>>> On 5/11/2020 11:03 AM, Deven Bowers wrote:
>>>>
>>>>
>>>> On 5/10/2020 2:28 AM, Mickaël Salaün wrote:
>>>>
>>>> [...snip]
>>>>
>>>>>>
>>>>>> Additionally, rules are evaluated top-to-bottom. As a result, any
>>>>>> revocation rules, or denies should be placed early in the file to
>>>>>> ensure
>>>>>> that these rules are evaluated before a rule with "action=ALLOW" is
>>>>>> hit.
>>>>>>
>>>>>> IPE policy is designed to be forward compatible and backwards
>>>>>> compatible,
>>>>>> thus any failure to parse a rule will result in the line being
>>>>>> ignored,
>>>>>> and a warning being emitted. If backwards compatibility is not
>>>>>> required,
>>>>>> the kernel commandline parameter and sysctl, ipe.strict_parse can be
>>>>>> enabled, which will cause these warnings to be fatal.
>>>>>
>>>>> Ignoring unknown command may lead to inconsistent beaviors. To achieve
>>>>> forward compatibility, I think it would be better to never ignore
>>>>> unknown rule but to give a way to userspace to known what is the
>>>>> current
>>>>> kernel ABI. This could be done with a securityfs file listing the
>>>>> current policy grammar.
>>>>>
>>>>
>>>> That's a fair point. From a manual perspective, I think this is fine.
>>>> A human-user can interpret a grammar successfully on their own when new
>>>> syntax is introduced.
>>>>
>>>>  From a producing API perspective, I'd have to think about it a bit
>>>> more. Ideally, the grammar would be structured in such a way that the
>>>> userland
>>>> interpreter of this grammar would not have to be updated once new
>>>> syntax
>>>> is introduced, avoiding the need to update the userland binary. To
>>>> do so
>>>> generically ("op=%s") is easy, but doesn't necessarily convey
>>>> sufficient
>>>> information (what happens when a new "op" token is introduced?). I
>>>> think
>>>> this may come down to regular expression representations of valid
>>>> values
>>>> for these tokens, which worries me as regular expressions are
>>>> incredibly
>>>> error-prone[1].
>>>>
>>>> I'll see what I can come up with regarding this.
>>>
>>> I have not found a way that I like to expose some kind of grammar
>>> through securityfs that can be understood by usermode to parse the
>>> policy. Here's what I propose as a compromise:
>>>
>>>     1. I remove the unknown command behavior. This address your
>>> first point about inconsistent behaviors, and effectively removes the
>>> strict_parse sysctl (as it is always enabled).
>>>
>>>     2. I introduce a versioning system for the properties
>>> themselves. The valid set of properties and their versions
>>> can be found in securityfs, under say, ipe/config in a key=value
>>> format where `key` indicates the understood token, and `value`
>>> indicates their current version. For example:
>>>
>>>     $ cat $SECURITYFS/ipe/config
>>>     op=1
>>>     action=1
>>>     policy_name=1
>>>     policy_version=1
>>>     dmverity_signature=1
>>>     dmverity_roothash=1
>>>     boot_verified=1
>>
>> The name ipe/config sounds like a file to configure IPE. Maybe something
>> like ipe/config_abi or ipe/config_grammar?
>>
>>>
>>> if new syntax is introduced, the version number is increased.
>>>
>>>     3. The format of those versions are documented as part of
>>> the admin-guide around IPE. If user-mode at that point wants to rip
>>> the documentation formats and correlate with the versioning, then
>>> it fulfills the same functionality as above, with out the complexity
>>> around exposing a parsing grammar and interpreting it on-the-fly.
>>> Many of these are unlikely to move past version 1, however.
>>>
>>> Thoughts?
>>>
>>
>> That seems reasonable.
>>
> 
> There is a use case for not having strict parsing in the cloud world
> where there are multiple versions of OS deployed across a large number
> of systems say 100,000 nodes. An OS update can take weeks to complete
> across all the nodes, and we end up having a heterogeneous mix of OS
> versions.
> 
> Without non-strict parsing, to fix an issue in a policy we will need to
> update the various versions of the policy (one each for all OS versions
> which have different IPE policy schema). We will lose the agility we
> need to fix and deploy something urgently in the policy, the nodes might
> be failing some critical workloads meanwhile. All the various versions
> of the policy will need to be changed and production signed then
> deployed etc. Further some versions might introduce newer issues and we
> will need to see what all versions of the policy have that bug.

What can be done in the kernel to ignore some policy rules could also be
done in a tool managing different policies. For instance, a simple tool
can instantiate a human-written policy into multiple backward compatible
policies (according to different versions of supported kernels). The
appropriate policy could then be fetched on the fly by the nodes or
pushed by an orchestration system.

> 
> I propose keeping the non-strict option as well to cater to this use
> case. Let me know your thoughts on this.

With your constraints in mind, I still think that flexible policy
management can be achieved with strict kernel policy parsing. The
complexity should be handled by infrastructure management system.

> 
> Regards,
> JK
