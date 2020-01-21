Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF7431443D8
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Jan 2020 19:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbgAUSA4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 21 Jan 2020 13:00:56 -0500
Received: from linux.microsoft.com ([13.77.154.182]:39816 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729080AbgAUSA4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Jan 2020 13:00:56 -0500
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id F394D20B4798;
        Tue, 21 Jan 2020 10:00:55 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F394D20B4798
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1579629656;
        bh=rEbmD/ZAcgYTqg5lv22gHg3BuIS3XcVwAuyZ8ZucRnY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Ke+o3F8JNJKUXLW8G/r7NY15sJb0k8OJM9cH1u8tH7ydq01p/8XTMiTadGcYv3rUa
         2tbdZzpRJxsThyHa+kheNH82qgi/wgWn1w7/aohJqryUVu5MVMUM9kjGPsgrFHMe7z
         RQPun7nIlFwFKrJQhM6JNZT4TNq9OUZ0rfkEO2Vk=
Subject: Re: [PATCH] IMA: Turn IMA_MEASURE_ASYMMETRIC_KEYS off by default
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, linux-kernel@vger.kernel.org
References: <20200121171302.4935-1-nramas@linux.microsoft.com>
 <1579628090.3390.28.camel@HansenPartnership.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <47a0ef08-3142-3e7c-a136-784767ba8370@linux.microsoft.com>
Date:   Tue, 21 Jan 2020 10:00:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1579628090.3390.28.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 1/21/20 9:34 AM, James Bottomley wrote:

> What exactly do you expect distributions to do with this?  I can tell
> you that most of them will take the default option, so this gets set to
> N and you may as well not have got the patches upstream because you
> won't be able to use them in any distro with this setting.

I agree - distros that are not sure or don't care about key measurement 
are anyway not going to choose this option. Only those that really care 
will opt in.

My goal is to not burden the vast majority of the users with this 
additional overhead if they don't need it - particularly, small systems 
such as embedded devices, etc.

> 
> Well, no they can't ... it's rather rare nowadays for people to build
> their own kernels.  The vast majority of Linux consumers take what the
> distros give them.  Think carefully before you decide a config option
> is the solution to this problem.
> 
> James
> 
If you have suggestions for how I can handle it in a different way 
(other than config option), I'll be happy to try it out.

thanks,
  -lakshmi
