Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 247242478D4
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Aug 2020 23:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgHQVaM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 Aug 2020 17:30:12 -0400
Received: from linux.microsoft.com ([13.77.154.182]:43890 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgHQVaL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Aug 2020 17:30:11 -0400
Received: from [192.168.1.12] (c-24-16-6-251.hsd1.wa.comcast.net [24.16.6.251])
        by linux.microsoft.com (Postfix) with ESMTPSA id F269320B4908;
        Mon, 17 Aug 2020 14:30:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F269320B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1597699811;
        bh=gwtlXOGLNOEhS8feeMsiU+VHB5OcE0A5+MQhHlaV/4o=;
        h=Subject:References:To:Cc:From:Date:In-Reply-To:From;
        b=lT5Pf3Y40XH1JJrct769/dcWiEIY/wRv4dGO/eOyiRJN7QJAuFHxaNTo2vlsb6XnD
         DwDjvi3afambMbTrx+SPVlCNuiAqIEuZ3CISkYTrb0TjSIF88jcZOvDQaGjfCdr/87
         gQMYJQt57oXEf8mKa07cC67QfA/EbNEQuC9t6yFg=
Subject: Re: [RFC] ima: export the measurement list when needed
References: <436e3951-d6d5-014a-dde1-8a6398dfe7a1@linux.microsoft.com>
To:     janne.karhunen@gmail.com, linux-integrity@vger.kernel.org,
        zohar@linux.ibm.com
Cc:     kgold@linux.ibm.com, david.safford@gmail.com, monty.wiseman@ge.com
From:   Raphael Gianotti <raphgi@linux.microsoft.com>
X-Forwarded-Message-Id: <436e3951-d6d5-014a-dde1-8a6398dfe7a1@linux.microsoft.com>
Message-ID: <57e0095a-ff6f-e5dc-6250-1320bd6518cb@linux.microsoft.com>
Date:   Mon, 17 Aug 2020 14:30:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <436e3951-d6d5-014a-dde1-8a6398dfe7a1@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Hi Janne,

Subject: Re: [RFC] ima: export the measurement list when needed
> Date: Wed, 18 Dec 2019 17:11:22 +0200
> From: Janne Karhunen <janne.karhunen@gmail.com>
> To: linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>
> CC: Ken Goldman <kgold@linux.ibm.com>, david.safford@gmail.com, 
> monty.wiseman@ge.com
>
> Hi,
>
> Have in mind that below is the first trial draft that booted and
> seemingly accomplished the task once, it was not really tested at all
> yet. I will make a polished and tested version if people like the
> concept.
>
> Note that the code (almost) supports pushing and pulling of the
> entries. This variant is a simple pull given that the list size is
> above the defined limits. Pushing can be put in place if the recursion
> with the list extend_list_mutex is cleared, maybe this could be done
> via another patch later on when we have a workqueue for the export
> task? The workqueue might be the best context for the export job since
> clearing the list is a heavy operation (and it's not entirely correct
> here AFAIK, there is no rcu sync before the template free).
>
>
> -- Janne
>
> On Wed, Dec 18, 2019 at 2:53 PM Janne Karhunen 
> <janne.karhunen@gmail.com> wrote:
>>
>> Some systems can end up carrying lots of entries in the ima
>> measurement list. Since every entry is using a bit of kernel
>> memory, add a new Kconfig variable to allow the sysadmin to
>> define the maximum measurement list size and the location
>> of the exported list.
>>
>> The list is written out in append mode, so the system will
>> keep writing new entries as long as it stays running or runs
>> out of space. File is also automatically truncated on startup.
>>
>> Signed-off-by: Janne Karhunen <janne.karhunen@gmail.com>
>> ---
>>  security/integrity/ima/Kconfig     |  10 ++
>>  security/integrity/ima/ima.h       |   7 +-
>>  security/integrity/ima/ima_fs.c    | 178 +++++++++++++++++++++++++++++
>>  security/integrity/ima/ima_queue.c |   2 +-
>>  4 files changed, 192 insertions(+), 5 deletions(-)

I've been looking into a solution to this same issue you started some 
work on. I was wondering if you are still working on it. I was 
considering taking your initial prototyping on this and extending it 
into a final solution, but I wanted to reply here first and check if you 
are currently working on this.

