Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4BA2619C3
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Jul 2019 06:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbfGHELL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 8 Jul 2019 00:11:11 -0400
Received: from linux.microsoft.com ([13.77.154.182]:48100 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfGHELL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 8 Jul 2019 00:11:11 -0400
Received: from [192.168.1.8] (c-67-168-100-174.hsd1.wa.comcast.net [67.168.100.174])
        by linux.microsoft.com (Postfix) with ESMTPSA id 72B8820B7185;
        Sun,  7 Jul 2019 21:11:10 -0700 (PDT)
Subject: Re: [PATCH] tpm: Document UEFI event log quirks
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     tweek@google.com, matthewgarrett@google.com,
        Jonathan Corbet <corbet@lwn.net>
References: <20190703161109.22935-1-jarkko.sakkinen@linux.intel.com>
 <dacf145d-49e0-16e5-5963-415bab1884e1@linux.microsoft.com>
 <fcf497b7aa95cd6915986bc4581f10814c4d5341.camel@linux.intel.com>
From:   Jordan Hand <jorhand@linux.microsoft.com>
Message-ID: <33ff21e2-1e27-cc85-0ea3-5127cb2598ba@linux.microsoft.com>
Date:   Sun, 7 Jul 2019 21:10:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <fcf497b7aa95cd6915986bc4581f10814c4d5341.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 7/5/19 3:26 AM, Jarkko Sakkinen wrote:
> On Wed, 2019-07-03 at 10:08 -0700, Jordan Hand wrote:
>>> +This introduces another problem: nothing guarantees that it is not
>>> +called before the stub gets to run. Thus, it needs to copy the final
>>> +events table preboot size to the custom configuration table so that
>>> +kernel offset it later on.
>>
>> This doesn't really explain what the size will be used for. Matthew's
>> patch description for "tpm: Don't duplicate events from the final event
>> log in the TCG2 log" outlines this well. You could maybe word it
>> differently but I think the information is necessary:
>>
>> "We can avoid this problem by looking at the size of the Final Event Log
>> just before we call ExitBootServices() and exporting this to the main
>> kernel. The kernel can then skip over all events that occured before
>> ExitBootServices() and only append events that were not also logged to
>> the main log."
> 
> Not exactly sure what is missing from my paragraph. The way I see it has
> more information as it states what is used at as the vessel for
> exportation (the custom configuration table).
> 
> Maybe something like:
> 
> "Thus, it nees to save the final events table size at the time to the
> custom configuration table so that the TPM driver can later on skip the
> events generated during the preboot time."
> 
Yes, that sounds more clear to me.

Thanks,
Jordan
