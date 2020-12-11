Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667B02D7AE8
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Dec 2020 17:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392323AbgLKQ25 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Dec 2020 11:28:57 -0500
Received: from linux.microsoft.com ([13.77.154.182]:54224 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395153AbgLKQ2Z (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Dec 2020 11:28:25 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8FDB120B717A;
        Fri, 11 Dec 2020 08:27:44 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8FDB120B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1607704064;
        bh=ghhwTCKzUyzBuV9Ol4jB1Kk7JTxsBVEU1FEuL6OBZqI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=bYm81nVRNFLJCOUD3nU2g3EPeAwM7yK2qWOhvVWpORfguzdsiC4R3aaW0/IYpeuLl
         wu0uusHuI0oKHKL3WrIzKUh8odyaPRYdyEa8h0YXJQKLWZLGcUjVZ/HMLQzaz9thKz
         5n7nt+mo2Zp7g6IdTXi9xaHoI3yYbrY8HxyY/r0Y=
Subject: Re: [PATCH v7 8/8] selinux: include a consumer of the new IMA
 critical data hook
To:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com, sashal@kernel.org,
        jmorris@namei.org, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
References: <20201209194212.5131-1-tusharsu@linux.microsoft.com>
 <20201209194212.5131-9-tusharsu@linux.microsoft.com>
 <20201211153618.GA4951@sequoia> <20201211154156.GB4951@sequoia>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <27bce16a-9e95-2559-af37-b47b81bdcd2e@linux.microsoft.com>
Date:   Fri, 11 Dec 2020 08:27:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201211154156.GB4951@sequoia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/11/20 7:41 AM, Tyler Hicks wrote:
> On 2020-12-11 09:36:30, Tyler Hicks wrote:
>> The calls to pr_err() in this aren't quite following the style of the
>> other error SELinux error messages.
> 
> Sorry, I left out a word. I meant to say that the calls to pr_err() in
> this *file* aren't quite following the right style. Please adjust all of
> them.
> 
> Thanks!
> 

Thanks for reviewing the patch Tyler. I'll make the changes per your 
comments.

  -lakshmi


