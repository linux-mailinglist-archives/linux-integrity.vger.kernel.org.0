Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE7E01F0095
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jun 2020 21:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgFETyQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 Jun 2020 15:54:16 -0400
Received: from linux.microsoft.com ([13.77.154.182]:33226 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727868AbgFETyP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Jun 2020 15:54:15 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 260C920B7185;
        Fri,  5 Jun 2020 12:54:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 260C920B7185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1591386855;
        bh=7adZ1mV+sRKq6BSSwQpcHcTCgE1BM6KiH2V0doIwFc4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mrOw4zf3U55HlWNfq/Tro6txy/iOGRWHIPHjdxZcMZwzpm9BC5SSd2MolZkSq0ZQw
         9CDGF7hqAQTZVPv+KcZcupYnLmkdS+FbDJtAA4YkKrD67TDa8/P83Z28MotpFy5Bw7
         MTlYxOKpjP0ClhKxh1gCkzrZ/CCh6Zxdqz/CpUVc=
Subject: Re: [PATCH] IMA: Add log statements for failure conditions
To:     Paul Moore <paul@paul-moore.com>, Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, tusharsu@linux.microsoft.com,
        linux-kernel@vger.kernel.org, linux-audit@redhat.com
References: <20200604163243.2575-1-nramas@linux.microsoft.com>
 <1591382782.5816.36.camel@linux.ibm.com>
 <CAHC9VhS-EP=Kk3GKRzAGAYa5mqupkLQCHz_m_DgoAKRWcSTgLA@mail.gmail.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <8dfb3fa6-5c1f-d644-7d21-72a9448c52cc@linux.microsoft.com>
Date:   Fri, 5 Jun 2020 12:54:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhS-EP=Kk3GKRzAGAYa5mqupkLQCHz_m_DgoAKRWcSTgLA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/5/20 12:37 PM, Paul Moore wrote:

> If it's audit related, it's generally best to CC the linux-audit list,
> not just me (fixed).
> 
> It's not clear to me what this pr_err() is trying to indicate other
> than *something* failed.  Can someone provide some more background on
> this message?

process_buffer_measurement() is currently used to measure
"kexec command line", "keys", and "blacklist-hash". If there was any 
error in the measurement, this pr_err() will indicate which of the above 
measurement failed and the related error code.

Please let me know if you need more info on this one.

Since a pr_xyz() call was already present, I just wanted to change the 
log level to keep the code change to the minimum. But if audit log is 
the right approach for this case, I'll update.

thanks,
  -lakshmi


