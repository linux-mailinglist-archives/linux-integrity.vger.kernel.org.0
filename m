Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75BC71BFF3C
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Apr 2020 16:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgD3OwT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Apr 2020 10:52:19 -0400
Received: from smtp-190a.mail.infomaniak.ch ([185.125.25.10]:55647 "EHLO
        smtp-190a.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726357AbgD3OwT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Apr 2020 10:52:19 -0400
X-Greylist: delayed 898 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Apr 2020 10:52:18 EDT
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 49Cd436GZyzlhyrF;
        Thu, 30 Apr 2020 16:26:43 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [94.23.54.103])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 49Cd4261cTzlndDX;
        Thu, 30 Apr 2020 16:26:42 +0200 (CEST)
Subject: Re: [PATCH 2/2] ima: add policy support for the new file open
 MAY_OPENEXEC flag
To:     Mimi Zohar <zohar@linux.ibm.com>,
        kbuild test robot <lkp@intel.com>,
        linux-integrity@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Steve Grubb <sgrubb@redhat.com>,
        Jann Horn <jannh@google.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1588167523-7866-3-git-send-email-zohar@linux.ibm.com>
 <202004300526.H4rF1lW2%lkp@intel.com>
 <1588254156.5167.32.camel@linux.ibm.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <48e67766-89ad-0b55-baa6-761ef09298bd@digikod.net>
Date:   Thu, 30 Apr 2020 16:26:42 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <1588254156.5167.32.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

OK, I'll add it to the next series.

On 30/04/2020 15:42, Mimi Zohar wrote:
> Hi Mickaël,
> 
> On Thu, 2020-04-30 at 05:24 +0800, kbuild test robot wrote:
>> Hi Mimi,
>>
>> I love your patch! Yet something to improve:
>>
>> [auto build test ERROR on integrity/next-integrity]
>> [also build test ERROR on linus/master v5.7-rc3 next-20200429]
>> [cannot apply to security/next-testing]
>> [if your patch is applied to the wrong git tree, please drop us a note to help
>> improve the system. BTW, we also suggest to use '--base' option to specify the
>> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> To prevent this sort of message, in the future could you include this
> patch (2/2) with your patch set?  Please include the "Reviewed-by:
> Lakshmi Ramasubramanian <nramas@linux.microsoft.com>" tag.
> 
> thanks,
> 
> Mimi
> 
>>
>> url:    https://github.com/0day-ci/linux/commits/Mimi-Zohar/ima-extending-IMA-policy-to-support-interpreters/20200430-030608
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity
>> config: arc-allyesconfig (attached as .config)
>> compiler: arc-elf-gcc (GCC) 9.3.0
>> reproduce:
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # save the attached .config to linux build tree
>>         COMPILER_INSTALL_PATH=$HOME/0day GCC_VERSION=9.3.0 make.cross ARCH=arc 
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kbuild test robot <lkp@intel.com>
>>
>> All error/warnings (new ones prefixed by >>):
>>
>>    security/integrity/ima/ima_main.c: In function 'ima_file_check':
>>>> security/integrity/ima/ima_main.c:442:20: error: 'MAY_OPENEXEC' undeclared (first use in this function); did you mean 'MAY_OPEN'?
>>      442 |         MAY_EXEC | MAY_OPENEXEC |
>>          |                    ^~~~~~~~~~~~
>>          |                    MAY_OPEN
> 
