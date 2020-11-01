Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBEB2A1BBC
	for <lists+linux-integrity@lfdr.de>; Sun,  1 Nov 2020 04:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgKADIT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 31 Oct 2020 23:08:19 -0400
Received: from linux.microsoft.com ([13.77.154.182]:43564 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbgKADIT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 31 Oct 2020 23:08:19 -0400
Received: from [192.168.86.21] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5B46620B4905;
        Sat, 31 Oct 2020 20:08:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5B46620B4905
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1604200098;
        bh=vnpGRdofobwuxdcpYzqgJbbMDhOYuoItMQZu+EpDLyI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ppJUiqBkQ8D0qXAAsYljmFa/fQRc/nX0eYW7QLQ+aCSbNi6JMFGoSuEAy6jJipSP8
         +v3gS44y+m6HmR0UYGnkcfaXpgxVFL1fhTZi2b/fTPGUWOzx/0/WOLzJ/pr/aWqzQB
         JNULC8U+0/rxZyypjMoNr5wQ1IURRpoiAIBuDQEk=
Subject: Re: [RFC] Finding the right target branch for patches that span IMA
 and SeLinux
To:     Paul Moore <paul@paul-moore.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        SELinux <selinux@vger.kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
References: <703ced1a-3a48-f29e-9141-af78415d8402@linux.microsoft.com>
 <f99f0f03aecc778826d79eb83d60cfd1a95196c5.camel@linux.ibm.com>
 <2ea3d341-6299-ec40-b553-f9f59a36cfb3@linux.microsoft.com>
 <CAHC9VhR8mbqZS3TVgG7MxQywe9uqDRCN+c59PozLTpOoQ-mK7Q@mail.gmail.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <9195fd7a-a5c5-8588-d33c-772d2f530032@linux.microsoft.com>
Date:   Sat, 31 Oct 2020 20:08:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhR8mbqZS3TVgG7MxQywe9uqDRCN+c59PozLTpOoQ-mK7Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Paul,

On 2020-10-30 1:37 p.m., Paul Moore wrote:
> On Fri, Oct 30, 2020 at 12:43 PM Tushar Sugandhi
> <tusharsu@linux.microsoft.com> wrote:
>>> Unless this patch set is specifically dependent on the two patches in
>>> the SELinux tree beyond v5.10.0-rc1, please base it on v5.10.0-rc1.
>>
>> Thanks Mimi. We don't have dependencies on those two patches in SELinux
>> tree.
>>
>> We'll base our changes on v5.10.0-rc1 in SELinux tree.
>>
>> Thanks for the quick response.
> 
> I'm not as fast as Mimi, but I thought it might be worthwhile to
> provide a bit more detail as to what I expect from SELinux kernel
> submissions.  I believe most other maintainers operate in a similar
> manner, but I obviously can't speak for them.
Thanks a lot for the detailed information Paul.
Its very helpful, and we appreciate it.
> 
> Unless there is an exception due to a previous discussion, I ask that
> all SELinux kernel patches be based on either the selinux/next branch
> or Linus' current tree.  If your patch(set) applies cleanly to either
> of those branches, and passes review, I'll merge it into the
> selinux/next branch taking care of any merge conflicts that may arise.
We will base on SeLinux -> next branch, as you/Mimi suggested.

> If the merge is particularly tricky I may ask you to double check the
> merge afterwards, but in my experience that is rare, most merge
> conflicts are trivially resolved.
> 
Based on our testing so far, there aren't any merge conflicts.
But if the need arises, we'll do our best to help you resolve/review
them.

> In the case where a patch(set) being proposed for inclusion in the
> SELinux tree has significant changes to another subsystem, I will ask
> the affected subsystem's maintainer to review the patch(set).  If the
> other maintainers do not provide an ACK for the patch(set) I will not
> merge the patches.  If the other maintainers do not respond at all for
> a few weeks, I may go ahead and merge the patch(set) anyway; that is a
> decision made on a case-by-base basis.
Mimi has been actively reviewing IMA side of the changes for this
patch-set.

> 
> If the patch(set) introduces new functionality I will ask you to add
> or update an existing test in the selinux-testsuite.
> * https://github.com/SELinuxProject/selinux-testsuite
> 
Lakshmi has written an SeLinux test for this feature, and it is
currently being targeted for LTP repo.
https://github.com/linux-test-project/ltp

We can work with you to also get it incorporated in selinux-testsuite.
But the concern here is we may have to pull additional dependent scripts
from LTP to selinux-testsuite to support our test.

Could you please take a look at Lakshmi's SeLinux test, and guide us
further on this? Here is the patch.
https://patchwork.kernel.org/patch/11804587/


> If the patch(set) introduces new, or changed, functionality I may ask
> you to update The SELinux Notebook.
> * https://github.com/SELinuxProject/selinux-notebook
> 
Will do. Thanks.

> Beyond the above, the general SELinux kernel tree process is
> documented in the README.md found in selinux/main:
> * https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git/tree/README.md
> 
Thanks for the pointer.
We'll go through the documentation.
~Tushar
