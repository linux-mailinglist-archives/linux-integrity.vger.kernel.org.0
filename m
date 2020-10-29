Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDDE829F91F
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Oct 2020 00:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725681AbgJ2XdJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 29 Oct 2020 19:33:09 -0400
Received: from linux.microsoft.com ([13.77.154.182]:52388 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgJ2XdJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 29 Oct 2020 19:33:09 -0400
Received: from [192.168.86.21] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1CABB20B4905;
        Thu, 29 Oct 2020 16:33:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1CABB20B4905
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1604014389;
        bh=u0stzGmOf7aPuEMWGwWvR7pKfadlDlmeZJue5nAHx0o=;
        h=To:Cc:From:Subject:Date:From;
        b=AkAs9ZAqqu3rNfgRvhV9JdQ7Tf+Cr2vBCo4z4ZjjRFIynv9Oj0P/dQo7vrGSnRoIh
         /hF0Mb7tKc+N2AmpTU1vKCEbYxSzSJao61V1mmB1LE6RM69bx0XCuGIkWFPYEOBzVc
         nxG0gBVC9eJajNKg0TzxlcVhAdJf6IIq4Fx28+vs=
To:     Mimi Zohar <zohar@linux.ibm.com>, stephen.smalley.work@gmail.com,
        paul@paul-moore.com
Cc:     SELinux <selinux@vger.kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Subject: [RFC] Finding the right target branch for patches that span IMA and
 SeLinux
Message-ID: <703ced1a-3a48-f29e-9141-af78415d8402@linux.microsoft.com>
Date:   Thu, 29 Oct 2020 16:33:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello Mimi/Stephen/Paul,

As you are already aware, we have several patch-sets in review for
IMA infrastructure for measurement of critical kernel data and it's
usage.

[1] infrastructure for measurement of critical data patch-set:

https://patchwork.kernel.org/project/linux-integrity/list/?series=354437

[2] Using [1] to measure SeLinux data:
     https://patchwork.kernel.org/patch/11801585/

[3] Using [1] to measure dm-crypt data:

https://patchwork.kernel.org/project/linux-integrity/list/?series=366903

[4] Using [1] to measure kernel_version:
     https://patchwork.kernel.org/patch/11854625/

[5] built-in IMA policy rule to handle critical data before
     a custom IMA policy is loaded:
     {Patch is not yet sent for public review}

Mimi has suggested that patch-set [1] should include a demonstrative
example use of the functionality in the same series. And that example
should be SeLinux (patch-set [2]).

However, SeLinux patch-set [2] depends on the functionality in SeLinux
branch [7], which is not yet merged in Integrity branch [6].
Therefore SeLinux patch-set [2] does not apply on the Integrity branch
at this time.

Further, SeLinux patch-set [2] also depends on the new code for
critical data infrastructure (patch-set [1] and [5]) which is all
IMA code. Patch-set [1] and [5], even though all IMA code, applies
cleanly on SeLinux branch - along with patch-set [2].

For the above reason, the new series we are going to post, which
combines [1], [2], and [5], needs to be based on SeLinux branch.

Since [1] and [5] contains IMA code - we wanted to confirm with the
maintainers if there are any concerns to base the series on SeLinux
branch.

Thanks,
Tushar

[6] Integrity Repo/Branch:
Repo: 
https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
Branch: linux-integrity

[7] SeLinux Branch:
Repo: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
Branch: next
