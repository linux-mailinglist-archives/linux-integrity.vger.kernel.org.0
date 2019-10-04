Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75B0BCC38D
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Oct 2019 21:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbfJDT3I (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Oct 2019 15:29:08 -0400
Received: from linux.microsoft.com ([13.77.154.182]:41518 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfJDT3I (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Oct 2019 15:29:08 -0400
Received: from [10.200.157.26] (unknown [131.107.147.154])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8CEFD20B71C6;
        Fri,  4 Oct 2019 12:29:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8CEFD20B71C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1570217347;
        bh=YAma0bGF5RtxG7cbZduEzv133Tl63YTcqwfLLv1Pc70=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=C4K0ALeDP7q2s4ZhTyW41Hg/ZbeiaeFmDaZfyI3N7Grz0/mIHXIrz0R0VKfyusnUR
         ss/hmA1JzdBsip0ZAuiAvSG9Zscx1xKwor3WEiegTKlXK98JrPVzJ3I4l4lthMyvLw
         fyxqkw+JqAFkWcnphEFdJE5pqnzaAoadWbUGCnQk=
Subject: Re: [PATCH 0/1] KEYS: Measure keys in trusted keyring
To:     Mimi Zohar <zohar@linux.ibm.com>, Sasha Levin <sashal@kernel.org>
Cc:     linux-integrity@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>,
        jamorris@linux.microsoft.com, kgoldman@us.ibm.com,
        "Wiseman, Monty (GE Global Research, US)" <monty.wiseman@ge.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Greg KH <gregkh@linuxfoundation.org>
References: <20190828002735.31025-1-nramas@linux.microsoft.com>
 <1567041083.6115.133.camel@linux.ibm.com>
 <ec8d7cd5-a83a-c344-eaa6-9bd2cef08772@linux.microsoft.com>
 <1567190507.10024.134.camel@linux.ibm.com>
 <2cd27f52-1029-bcea-c73b-7d3d002cf030@linux.microsoft.com>
 <1568035881.4614.347.camel@linux.ibm.com> <20190919131851.GA8171@sasha-vm>
 <1568913178.4733.89.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <1dfc7a83-3fcb-1356-958e-2afb7c6f1285@linux.microsoft.com>
Date:   Fri, 4 Oct 2019 12:29:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1568913178.4733.89.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 9/19/19 10:12 AM, Mimi Zohar wrote:

Hi Mimi,

> On 9/1 I commented on this patch set from a technical perspective,
> saying: >
> IMA measures, appraises, and audits files based on policy[1].  If
> you're going to measure keys, all of the code should be within the IMA
> subdirectory.  The only code outside of the IMA subdirectory is either
> an LSM or IMA hook.  If an LSM hook already exists, use it.  If an LSM
> hook doesn't exist and the location is generic that other LSMs would
> be interested, define a new LSM hook, otherwise define a new IMA hook.

I am having trouble addressing the above feedback. Appreciate if you 
could provide guidance:

The key(s) in the trusted keys keyring (builtin, secondary, etc.) are 
added early in the kernel boot process. But IMA is initialized later.
If I have a LSM\IMA hook, that gets called when key(s) are added to the 
trusted keys keyring, I won't be able to invoke IMA on "key add" since 
IMA is not yet initialized.

Right now, I have the key measurement function in ima_init. I can gate 
that based on policy (similar to how Prakhar has done kexec_cmdline 
measurement) and follow the coding guidelines you have pointed to.
But it would still have to call keyring function to get the list of keys 
in the trusted keys keyring.

Are you fine if I take the above approach?

If not, could you please suggest a better way to handle it that meets 
the kernel layering guidelines?

Thanks,
  -lakshmi


