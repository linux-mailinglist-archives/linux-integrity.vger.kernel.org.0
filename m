Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84F092505F1
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Aug 2020 19:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgHXRYj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 24 Aug 2020 13:24:39 -0400
Received: from linux.microsoft.com ([13.77.154.182]:57598 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgHXRYH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 24 Aug 2020 13:24:07 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2D58820B4908;
        Mon, 24 Aug 2020 10:24:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2D58820B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1598289847;
        bh=P+vH+9CgoxlkQcVVKVkVbeTTeVPmRvrMgEOQZfqs2Qw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=K5Pjs5SUP1ef+4WPSV7JOZBxbrNTXB3+yQ/+Fk2wtRuyZB04Pk4+M33NA9awaKWPQ
         dSbq5XK4lcuSe/9jKlvDtON3uSSoFARvVQqn86yG9O4eeUbJOQUOKxYJvGLxswA/de
         lJwNseAxO8usIcbmXmU+G8d28PJerE0RQSsLihbk=
Subject: Re: [LTP v4 1/5] IMA/ima_keys.sh: Fix policy content check usage
To:     Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
References: <20200820090824.3033-1-pvorel@suse.cz>
 <20200820090824.3033-2-pvorel@suse.cz> <20200824171943.GA15693@dell5510>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <9bd0a70c-ba3f-3538-cf4f-fddcdb14c383@linux.microsoft.com>
Date:   Mon, 24 Aug 2020 10:24:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200824171943.GA15693@dell5510>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 8/24/20 10:19 AM, Petr Vorel wrote:

Hi Petr,

> 
>> require_ima_policy_content cannot be used in subshell $() evaluation,
>> because tst_brk does not quit the test. It calls cleanup for the
>> subshell process and main process then continue:
> ...
> 
> Merged this one to at least fix ima_keys.sh test.
> I'll wait little longer before merging the rest of v4 patchset
> https://patchwork.ozlabs.org/project/ltp/list/?series=196621
> 
Sorry for the late response.

I applied your v4 patches and ran keys tests. The issues reported 
earlier by Mimi are fixed.

thanks,
  -lakshmi



