Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D842A4F7A
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Nov 2020 19:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729429AbgKCS5g (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Nov 2020 13:57:36 -0500
Received: from linux.microsoft.com ([13.77.154.182]:55822 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgKCS5f (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Nov 2020 13:57:35 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 26E0720B4905;
        Tue,  3 Nov 2020 10:57:35 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 26E0720B4905
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1604429855;
        bh=cVbItptAW1tS1kJXEj6/BOOB6hgB5fsNAx9vzKmya7E=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=feOdQ716roT1YxuIu88Yr/V2A4sKG6SPqDvsuaDKRqg9d3kjBEWhVcI+6vAeAsSDH
         R4wGFCbTQFGfC85IdMg6azVXp/VwVdPwnlhMJ9ff+1jjR91zDRBfuUn5Br5V2IB+B+
         7dSYPQXeKPYh/ClSIGny9wfQNwgDNH3rZtaYkPlQ=
Subject: Re: [RFC] Finding the right target branch for patches that span IMA
 and SeLinux
To:     Paul Moore <paul@paul-moore.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        SELinux <selinux@vger.kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
References: <703ced1a-3a48-f29e-9141-af78415d8402@linux.microsoft.com>
 <f99f0f03aecc778826d79eb83d60cfd1a95196c5.camel@linux.ibm.com>
 <2ea3d341-6299-ec40-b553-f9f59a36cfb3@linux.microsoft.com>
 <CAHC9VhR8mbqZS3TVgG7MxQywe9uqDRCN+c59PozLTpOoQ-mK7Q@mail.gmail.com>
 <9195fd7a-a5c5-8588-d33c-772d2f530032@linux.microsoft.com>
 <CAHC9VhT36qSJvhH5CFwixdT8tzH2bqfvaDa6nPZt1rmOKOr_kQ@mail.gmail.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <58293728-9f2b-8a6c-ec32-ec35f594094e@linux.microsoft.com>
Date:   Tue, 3 Nov 2020 10:57:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhT36qSJvhH5CFwixdT8tzH2bqfvaDa6nPZt1rmOKOr_kQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/2/20 7:11 PM, Paul Moore wrote:

Hi Paul,

> On Sat, Oct 31, 2020 at 11:08 PM Tushar Sugandhi
> <tusharsu@linux.microsoft.com> wrote:
>> On 2020-10-30 1:37 p.m., Paul Moore wrote:
> 
> ...
> 
>>> If the patch(set) introduces new functionality I will ask you to add
>>> or update an existing test in the selinux-testsuite.
>>> * https://github.com/SELinuxProject/selinux-testsuite
>>
>> Lakshmi has written an SeLinux test for this feature, and it is
>> currently being targeted for LTP repo.
>> https://github.com/linux-test-project/ltp
>>
>> We can work with you to also get it incorporated in selinux-testsuite.
>> But the concern here is we may have to pull additional dependent scripts
>> from LTP to selinux-testsuite to support our test.
>>
>> Could you please take a look at Lakshmi's SeLinux test, and guide us
>> further on this? Here is the patch.
>> https://patchwork.kernel.org/patch/11804587/
> 
> As I'm looking at the test(s) above, I'm thinking that this may not be
> something that needs to be in the selinux-testsuite.  While SELinux is
> obviously an important part of the test, the test is more IMA focused
> (which is probably the way it should be).

Yes, as you mentioned, the test is more IMA focused. It is to validate 
the measurement done by IMA against the current state of the 
configuration and policy of SELinux. Therefore we would like to keep it 
in LTP.

> 
> As a bit of background, the selinux-testsuite is intended to serve as
> a relatively easy and quick to run test that can be used by developers
> to quickly test their patches; while it aims for good coverage, it
> does not try to be a comprehensive regression test suite.  Not only
> would that be duplicating other efforts such as the LTP, it would go
> against the goal of making the test suite quick and easy to use.
> 

thanks,
  -lakshmi
