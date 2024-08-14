Return-Path: <linux-integrity+bounces-3315-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64AF89521FB
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Aug 2024 20:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13BED1F23EEA
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Aug 2024 18:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482A21BD4ED;
	Wed, 14 Aug 2024 18:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="arhIygC1"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE30A1BBBDA;
	Wed, 14 Aug 2024 18:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723659827; cv=none; b=ecqMVYTAoQGQPVgtaSAWeGJhUfzGQp2f08y7fOVqbNqTm1M/P/PodtZd1J32iiUHcBLWhPEfa7XrBgK0VbByoawDDZzUa7qA9XfhQ9aQ6M4yhvNdfveEsOG95jssRdB6avaOfWphYYyZtqYUs+iNNJYbHIKLmXywMxB9wBHE+TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723659827; c=relaxed/simple;
	bh=VP+QiCS6zOdtfbT9zGI9LEQCyWB6JQVT2Grcrrb4SEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=enA1H0FcnXfL5DuueGnZBjbkH2BuyYsOFykiRk/bf6sbi8llo9qlQImUIq/nox5knqN3KfrdkstTbo3K25OSbeWHLpk9mJ5UoA+aXXpYE2hiWGKXLa9nBUq6diUmizS9ryaBFM4pWmB/8HNlnzBevY83OAZFrvcuxzDK8jnBuHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=arhIygC1; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.106.151] (unknown [131.107.174.23])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3D2C020B7165;
	Wed, 14 Aug 2024 11:23:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3D2C020B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1723659819;
	bh=rQ4vq6TsUxv4l4kbIL+sjMudyLAkyj4vXkuWLSuksPI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=arhIygC1hFg4TcYMA000C9oRAiO/qMK7FqChi4JOP6pNVnUW0LTKCD5XOeOTvqLjO
	 OxWN/HJ2LGm2JmHXlgiaG0btNEqrqB5MZKuZtC7CvZRFE5dhaiW+q0w86YV5loKWME
	 vgVOeLlN6FYqX4YJz687dnyfNgPTF6jdt4sY5pgY=
Message-ID: <cbf1caa0-835b-4d1d-aed5-9741eb10cf8b@linux.microsoft.com>
Date: Wed, 14 Aug 2024 11:23:39 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 02/20] ipe: add policy parser
To: Paul Moore <paul@paul-moore.com>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: corbet@lwn.net, zohar@linux.ibm.com, jmorris@namei.org, tytso@mit.edu,
 ebiggers@kernel.org, axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
 mpatocka@redhat.com, eparis@redhat.com, linux-doc@vger.kernel.org,
 linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
 fsverity@lists.linux.dev, linux-block@vger.kernel.org,
 dm-devel@lists.linux.dev, audit@vger.kernel.org,
 linux-kernel@vger.kernel.org, Deven Bowers <deven.desai@linux.microsoft.com>
References: <1722665314-21156-1-git-send-email-wufan@linux.microsoft.com>
 <1722665314-21156-3-git-send-email-wufan@linux.microsoft.com>
 <20240810155000.GA35219@mail.hallyn.com>
 <e1dd4dcf-8e2e-4e7b-9d40-533efd123103@linux.microsoft.com>
 <CAHC9VhTYT3RTG1FbnZQ2F68a16gU9_QJ-=LSGbroP-40tpRTiw@mail.gmail.com>
Content-Language: en-US
From: Fan Wu <wufan@linux.microsoft.com>
In-Reply-To: <CAHC9VhTYT3RTG1FbnZQ2F68a16gU9_QJ-=LSGbroP-40tpRTiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/13/2024 6:53 PM, Paul Moore wrote:
> On Tue, Aug 13, 2024 at 1:54 PM Fan Wu <wufan@linux.microsoft.com> wrote:
>> On 8/10/2024 8:50 AM, Serge E. Hallyn wrote:
>>> On Fri, Aug 02, 2024 at 11:08:16PM -0700, Fan Wu wrote:
>>>> From: Deven Bowers <deven.desai@linux.microsoft.com>
>>>>
>>>> IPE's interpretation of the what the user trusts is accomplished through
>>>
>>> nit: "of what the user trusts" (drop the extra 'the')
>>>
>>>> its policy. IPE's design is to not provide support for a single trust
>>>> provider, but to support multiple providers to enable the end-user to
>>>> choose the best one to seek their needs.
>>>>
>>>> This requires the policy to be rather flexible and modular so that
>>>> integrity providers, like fs-verity, dm-verity, or some other system,
>>>> can plug into the policy with minimal code changes.
>>>>
>>>> Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
>>>> Signed-off-by: Fan Wu <wufan@linux.microsoft.com>
>>>
>>> This all looks fine.  Just one comment below.
>>>
>> Thank you for reviewing this!
>>
>>>
>>>> +/**
>>>> + * parse_rule() - parse a policy rule line.
>>>> + * @line: Supplies rule line to be parsed.
>>>> + * @p: Supplies the partial parsed policy.
>>>> + *
>>>> + * Return:
>>>> + * * 0              - Success
>>>> + * * %-ENOMEM       - Out of memory (OOM)
>>>> + * * %-EBADMSG      - Policy syntax error
>>>> + */
>>>> +static int parse_rule(char *line, struct ipe_parsed_policy *p)
>>>> +{
>>>> +    enum ipe_action_type action = IPE_ACTION_INVALID;
>>>> +    enum ipe_op_type op = IPE_OP_INVALID;
>>>> +    bool is_default_rule = false;
>>>> +    struct ipe_rule *r = NULL;
>>>> +    bool first_token = true;
>>>> +    bool op_parsed = false;
>>>> +    int rc = 0;
>>>> +    char *t;
>>>> +
>>>> +    r = kzalloc(sizeof(*r), GFP_KERNEL);
>>>> +    if (!r)
>>>> +            return -ENOMEM;
>>>> +
>>>> +    INIT_LIST_HEAD(&r->next);
>>>> +    INIT_LIST_HEAD(&r->props);
>>>> +
>>>> +    while (t = strsep(&line, IPE_POLICY_DELIM), line) {
>>>
>>> If line is passed in as NULL, t will be NULL on the first test.  Then
>>> you'll break out and call parse_action(NULL), which calls
>>> match_token(NULL, ...), which I do not think is safe.
>>>
>>> I realize the current caller won't pass in NULL, but it seems worth
>>> checking for here in case some future caller is added by someone
>>> who's unaware.
>>>
>>> Or, maybe add 'line must not be null' to the function description.
>>
>> Yes, I agree that adding a NULL check would be better. I will include it
>> in the next version.
> 
> We're still waiting to hear back from the device-mapper devs, but if
> this is the only change required to the patchset I can add a NULL
> check when I merge the patchset as it seems silly to resend the entire
> patchset for this.  Fan, do you want to share the code snippet with
> the NULL check so Serge can take a look?
> 

Sure, here is the diff.

diff --git a/security/ipe/policy_parser.c b/security/ipe/policy_parser.c
index 32064262348a..0926b442e32a 100644
--- a/security/ipe/policy_parser.c
+++ b/security/ipe/policy_parser.c
@@ -309,6 +309,9 @@ static int parse_rule(char *line, struct 
ipe_parsed_policy *p)
         int rc = 0;
         char *t;

+       if (IS_ERR_OR_NULL(line))
+               return -EBADMSG;
+
         r = kzalloc(sizeof(*r), GFP_KERNEL);
         if (!r)
                 return -ENOMEM;

-Fan

