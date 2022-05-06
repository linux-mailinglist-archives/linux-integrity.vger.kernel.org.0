Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B01251E004
	for <lists+linux-integrity@lfdr.de>; Fri,  6 May 2022 22:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383046AbiEFUTx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 6 May 2022 16:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442108AbiEFUTw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 6 May 2022 16:19:52 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A46FF644D6
        for <linux-integrity@vger.kernel.org>; Fri,  6 May 2022 13:16:08 -0700 (PDT)
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 44E9C20EB6C4;
        Fri,  6 May 2022 13:16:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 44E9C20EB6C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1651868168;
        bh=3Tb6wUUENDi4sFRNnWHt/tDXLmTBji4pHj0QUqNZxgY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ka7NZMkuDir3t+WSTOJY6v9ySLsRP2F10Eb7/CQwN67M0PRpeteRYrMfBldzvjbXj
         SYeWgJ4fIqSABnGI24tNN+XP20MyGyBmttCn3HQQGK3TZJ0I4nKMbKSkIahh+jQ1DU
         HSwfEpdBYOgxwQN1ZixTXMTvRc7wkMY9jAVuvSOQ=
Message-ID: <9fefc681-c8dd-0312-2d6b-ffe3fec05dcf@linux.microsoft.com>
Date:   Fri, 6 May 2022 13:16:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC PATCH 0/3] dm ima: allow targets to remeasure their state
Content-Language: en-US
To:     Thore Sommer <public@thson.de>, dm-devel@redhat.com,
        agk@redhat.com, snitzer@redhat.com
Cc:     tusharsu@linux.microsoft.com, linux-integrity@vger.kernel.org
References: <20220106203436.281629-1-public@thson.de>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
In-Reply-To: <20220106203436.281629-1-public@thson.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-22.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Thore,

On 1/6/2022 12:34 PM, Thore Sommer wrote:
> The current DM IMA events do not cover the case where a device changes
> their attributes to indicate a state change. 
It would be good to state here what issue(s) are caused, if any, or what 
data\event we might be missing as a result of not measuring the device 
attribute changes. And, then state the benefits of the changes you have 
implemented in this patch series.

This adds a new event
> (dm_target_update) which allows targets to remeasure their table entries.
> The event includes the dm version, device metadata and the target data.
> 
> Currently only verity supports this event to ensure that device corruption
> can be detected using IMA which is useful for remote attestation.
Using the term "currently" in this context seems to indicate that this 
is the current state (existing behavior) in the Linux kernel 
implementation. You could instead reword it to indicate that your 
proposed measurement change is used by verity to add support for 
detecting device corruption.

> 
> The current implementation does not update the active table hash because
> it would require to rehash the entire table on every target change.
Similar to the above comment - could be reworded to indicate this is the 
proposed change and not the existing behavior.

thanks,
  -lakshmi

> 
> Thore Sommer (3):
>    dm ima: allow targets to remeasure their table entry
>    dm verity: add support for IMA target update event
>    dm ima: add documentation target update event
> 
>   .../admin-guide/device-mapper/dm-ima.rst      | 33 ++++++++
>   drivers/md/dm-ima.c                           | 76 +++++++++++++++++++
>   drivers/md/dm-ima.h                           |  2 +
>   drivers/md/dm-verity-target.c                 |  6 ++
>   4 files changed, 117 insertions(+)
> 
