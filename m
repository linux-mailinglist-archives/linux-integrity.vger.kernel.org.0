Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3416CFCDFC
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Nov 2019 19:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfKNSpH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 Nov 2019 13:45:07 -0500
Received: from linux.microsoft.com ([13.77.154.182]:40118 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbfKNSpH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Nov 2019 13:45:07 -0500
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6BE9820110C5;
        Thu, 14 Nov 2019 10:45:06 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6BE9820110C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1573757106;
        bh=nT4IO+CWu2bRiTtDpcO+b4y7oYNV0E1iPqumup/LrHc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=iotEtJ/XIqAF3q7j3QPuh7LCcFit74EAEzsq08vINI1+90+Mjghnff2hxY+MSQ+O3
         VttqkrTk6ez8B+0isSwd+yavPOWWYM/yTF7cWY7aH9h3gexKIV7t2RPHh0qMI2Wtgb
         8f+nAKiP19QeLlqvJS9fhCwtFAQq8broiSkOwIOg=
Subject: Re: [PATCH] ima: avoid appraise error for hash calc interrupt
To:     Patrick Callaghan <patrickc@linux.vnet.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Patrick Callaghan <patrickc@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
References: <20191111192348.30535-1-patrickc@linux.ibm.com>
 <e3f520ce-a290-206d-8097-b852123357ca@linux.microsoft.com>
 <1573578841.17949.48.camel@linux.ibm.com>
 <c6a57c24-2f30-f252-0f42-8d748ede65af@linux.microsoft.com>
 <1573582344.17949.67.camel@linux.ibm.com>
 <abdf66fb39d4c8ee08e0b52c34fb81b93bd33006.camel@linux.vnet.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <4e1c0c6b-a5e1-a95a-8a0b-c5a7f0a253cf@linux.microsoft.com>
Date:   Thu, 14 Nov 2019 10:45:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <abdf66fb39d4c8ee08e0b52c34fb81b93bd33006.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/14/19 5:55 AM, Patrick Callaghan wrote:

Hi Patrick,

> Hello Laks,
> You suggested that the if statement of the patch change to the
> following:
> 
> if ((rbuf_len == 0) || (offset + rbuf_len >= i_size)) {
> 
> Unless the file size changed between the time that i_size was set in
> ima_calc_file_hash_tfm() and an i_size_read() call was subsequently
> issued in a function downstream of the integrity_kernel_read() call,
> the rbuf_len returned on the integrity_kernel_read() call will not be
> more than i_size - offset. I do not think that it is possible for the
> file size to change during this window but nonetheless, if it can, this
> would be a different problem and I would not want to include this in my
> patch. That said, I do appreciate you taking time to review this patch.

You are right - unless the file size changes between the calls this 
problem would not occur. I agree - that issue, even if it can occur, 
should be addressed separately.

Another one (again - am not saying this needs to be addressed in this 
patch, but just wanted to point out)

	rbuf = kzalloc(PAGE_SIZE, GFP_KERNEL);
	...
	rbuf_len = integrity_kernel_read(file, offset, rbuf, PAGE_SIZE);
	...
	rc = crypto_shash_update(shash, rbuf, rbuf_len);

rbuf is of size PAGE_SIZE, but rbuf_len, returned by 
integrity_kernel_read() is passed as buffer size to 
crypto_shash_update() without any validation (rbuf_len <= PAGE_SIZE)

It is assumed here that integrity_kernel_read() would not return a 
length greater than rbuf size and hence crypto_shash_update() would 
never access beyond the given buffer.

thanks,
  -lakshmi


