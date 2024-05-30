Return-Path: <linux-integrity+bounces-2708-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E768D443B
	for <lists+linux-integrity@lfdr.de>; Thu, 30 May 2024 05:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3492284A39
	for <lists+linux-integrity@lfdr.de>; Thu, 30 May 2024 03:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0F1139D09;
	Thu, 30 May 2024 03:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="pCqjkDZk"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D55E42AAB;
	Thu, 30 May 2024 03:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717040325; cv=none; b=a0qncLwnf+HAUOEvD0F0HIRmbbMBEOQnywOijivfFX64gOuhIJ4xlA9Tk5YAIpjACj9pPB+Xjf4MehTLVbr5eIXp1otyZTN2gg447LD0cQJL1cAwJD7z7UbS3Td0KuHr7qRfA3d+xh5xt+Pzx6VSCEmqBxKJMEEyB3pwOhfVVR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717040325; c=relaxed/simple;
	bh=0Z+2DCu+nIujQLs3EfHQoGwPrgs21PJ6gT1bOiZx0yI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qrCz/E78RvxCLQVC+d7vkPchIrdVyLkweiN6TMmNTK6OoTNiDsgCjxqurpyITdT02BUhWdEbqra5gFddjyfoWLHujlh6E8/0FWNqXLw6WkCjgeLET4krzsVEJROoxpKDcLkaLQU9MoGd3RTc0zxc1S9/QnXyB5o4D9BmYGeRCGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=pCqjkDZk; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.106.151] (unknown [167.220.2.23])
	by linux.microsoft.com (Postfix) with ESMTPSA id C4B8220B915A;
	Wed, 29 May 2024 20:38:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C4B8220B915A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1717040321;
	bh=TLCa5Lp6oUMDlTzuXOnFGatDontTY5GUZPEI/tmIjEw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pCqjkDZkF9FDZNihcL/ShWsnn+No/zPiWEf13D3v2wpDg/tTVVU0zopv71uVpLq+h
	 Mqq06U7kuSUGZ24nO79MTV1eK87ubwB2yMbC9dvgSi2VXCbBz/t3CpZ7URhit2Ia7s
	 icM6r86KS1HnZkw2iwTpSNwYShDoCsJ9DZKWtPZo=
Message-ID: <aed4ed7d-9464-458a-9cc4-5d89ee9d8bb6@linux.microsoft.com>
Date: Wed, 29 May 2024 20:38:41 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 15/20] fsverity: expose verified fsverity built-in
 signatures to LSMs
To: Eric Biggers <ebiggers@kernel.org>, Paul Moore <paul@paul-moore.com>
Cc: corbet@lwn.net, zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com,
 tytso@mit.edu, axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
 mpatocka@redhat.com, eparis@redhat.com, linux-doc@vger.kernel.org,
 linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
 fsverity@lists.linux.dev, linux-block@vger.kernel.org,
 dm-devel@lists.linux.dev, audit@vger.kernel.org,
 linux-kernel@vger.kernel.org, Deven Bowers <deven.desai@linux.microsoft.com>
References: <1716583609-21790-1-git-send-email-wufan@linux.microsoft.com>
 <1716583609-21790-16-git-send-email-wufan@linux.microsoft.com>
 <CAHC9VhRsnGjZATBj7-evK6Gdryr54raTTKMYO_vup8AGXLwjQg@mail.gmail.com>
 <20240530030605.GA29189@sol.localdomain>
Content-Language: en-US
From: Fan Wu <wufan@linux.microsoft.com>
In-Reply-To: <20240530030605.GA29189@sol.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/29/2024 8:06 PM, Eric Biggers wrote:
> On Wed, May 29, 2024 at 09:46:57PM -0400, Paul Moore wrote:
>> On Fri, May 24, 2024 at 4:46 PM Fan Wu <wufan@linux.microsoft.com> wrote:
>>>
>>> This patch enhances fsverity's capabilities to support both integrity and
>>> authenticity protection by introducing the exposure of built-in
>>> signatures through a new LSM hook. This functionality allows LSMs,
>>> e.g. IPE, to enforce policies based on the authenticity and integrity of
>>> files, specifically focusing on built-in fsverity signatures. It enables
>>> a policy enforcement layer within LSMs for fsverity, offering granular
>>> control over the usage of authenticity claims. For instance, a policy
>>> could be established to permit the execution of all files with verified
>>> built-in fsverity signatures while restricting kernel module loading
>>> from specified fsverity files via fsverity digests.
>>>
>>> The introduction of a security_inode_setintegrity() hook call within
>>> fsverity's workflow ensures that the verified built-in signature of a file
>>> is exposed to LSMs. This enables LSMs to recognize and label fsverity files
>>> that contain a verified built-in fsverity signature. This hook is invoked
>>> subsequent to the fsverity_verify_signature() process, guaranteeing the
>>> signature's verification against fsverity's keyring. This mechanism is
>>> crucial for maintaining system security, as it operates in kernel space,
>>> effectively thwarting attempts by malicious binaries to bypass user space
>>> stack interactions.
>>>
>>> The second to last commit in this patch set will add a link to the IPE
>>> documentation in fsverity.rst.
>>>
>>> Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
>>> Signed-off-by: Fan Wu <wufan@linux.microsoft.com>
>>>
>>> ---
>>> v1-v6:
>>>    + Not present
>>>
>>> v7:
>>>    Introduced
>>>
>>> v8:
>>>    + Split fs/verity/ changes and security/ changes into separate patches
>>>    + Change signature of fsverity_create_info to accept non-const inode
>>>    + Change signature of fsverity_verify_signature to accept non-const inode
>>>    + Don't cast-away const from inode.
>>>    + Digest functionality dropped in favor of:
>>>      ("fs-verity: define a function to return the integrity protected
>>>        file digest")
>>>    + Reworded commit description and title to match changes.
>>>    + Fix a bug wherein no LSM implements the particular fsverity @name
>>>      (or LSM is disabled), and returns -EOPNOTSUPP, causing errors.
>>>
>>> v9:
>>>    + No changes
>>>
>>> v10:
>>>    + Rename the signature blob key
>>>    + Cleanup redundant code
>>>    + Make the hook call depends on CONFIG_FS_VERITY_BUILTIN_SIGNATURES
>>>
>>> v11:
>>>    + No changes
>>>
>>> v12:
>>>    + Add constification to the hook call
>>>
>>> v13:
>>>    + No changes
>>>
>>> v14:
>>>    + Add doc/comment to built-in signature verification
>>>
>>> v15:
>>>    + Add more docs related to IPE
>>>    + Switch the hook call to security_inode_setintegrity()
>>>
>>> v16:
>>>    + Explicitly mention "fsverity builtin signatures" in the commit
>>>      message
>>>    + Amend documentation in fsverity.rst
>>>    + Fix format issue
>>>    + Change enum name
>>>
>>> v17:
>>>    + Fix various documentation issues
>>>    + Use new enum name LSM_INT_FSVERITY_BUILTINSIG_VALID
>>>
>>> v18:
>>>    + Fix typos
>>>    + Move the inode_setintegrity hook call into fsverity_verify_signature()
>>>
>>> v19:
>>>    + Cleanup code w.r.t inode_setintegrity hook refactoring
>>> ---
>>>   Documentation/filesystems/fsverity.rst | 23 +++++++++++++++++++++--
>>>   fs/verity/signature.c                  | 18 +++++++++++++++++-
>>>   include/linux/security.h               |  1 +
>>>   3 files changed, 39 insertions(+), 3 deletions(-)
>>
>> Eric, can you give this patch in particular a look to make sure you
>> are okay with everything?  I believe Fan has addressed all of your
>> previous comments and it would be nice to have your Ack/Review tag if
>> you are okay with the current revision.
> 
> Sorry, I've just gotten a bit tired of finding so many basic issues in this
> patchset even after years of revisions.
> 
> This patch in particular is finally looking better.  There are a couple issues
> that I still see.  (BTW, you're welcome to review it too to help find these
> things, given that you seem to have an interest in getting this landed...):
> 
>> +	err = security_inode_setintegrity(inode,
>> +					  LSM_INT_FSVERITY_BUILTINSIG_VALID,
>> +					  signature,
>> +					  le32_to_cpu(sig_size));
> 
> This is doing le32_to_cpu() on a variable of type size_t, which will do the
> wrong thing on big endian systems and will generate a 'sparse' warning.
> 
Sorry for the mistake. As sig_size is already converted in open.c, there 
is indeed no need to call this function again. I will remove this 
unnecessary conversion.

> Also, the commit message still incorrectly claims that this patch allows
> "restricting kernel module loading from specified fsverity files via fsverity
> digests".  As I said before (sigh...), this is not correct as that can be done
> without this patch.
> 
> - Eric

As for the commit message, my intention was to provide an example of a 
policy that with the patch IPE can enforce, not to claim that this 
specific restriction requires the patch. However, I will remove it as it 
seems to be causing confusion.
-Fan

