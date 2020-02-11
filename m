Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0F2C159641
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Feb 2020 18:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbgBKRgM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 Feb 2020 12:36:12 -0500
Received: from linux.microsoft.com ([13.77.154.182]:56056 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729441AbgBKRgM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 Feb 2020 12:36:12 -0500
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 36F3B20B9C02;
        Tue, 11 Feb 2020 09:36:11 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 36F3B20B9C02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1581442571;
        bh=1OcYi/WkAw80axoKpZykACPLnAh0Qk0BSYRrPJ/Xe2k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Ig1Zjy8BjCcj44nQBjr9wsAYYpCwlZH/6wF9hjNQ8kDYpmuPOzamFiQFdcydC3EJM
         4tve45vFmjv4zpJWxebnWZwBcsZn/bQMdTDCZ4TWoYOW1sjA7PT0wQgJs0PsZS/0eJ
         tv9dzntFr7+x1O7gaA65N2myQitHjqyGyQNxrmlk=
Subject: Re: [PATCH v2 1/3] IMA: Update KBUILD_MODNAME for IMA files to ima
To:     Joe Perches <joe@perches.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        zohar@linux.ibm.com, skhan@linuxfoundation.org,
        linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, linux-kernel@vger.kernel.org
References: <20200211024755.5579-1-tusharsu@linux.microsoft.com>
 <225b88ac1abcb293bf9d55ca53009015b1baa81c.camel@perches.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <cde01d57-99d0-34f7-41dd-5eb5a24b5037@linux.microsoft.com>
Date:   Tue, 11 Feb 2020 09:36:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <225b88ac1abcb293bf9d55ca53009015b1baa81c.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/10/20 7:09 PM, Joe Perches wrote:

Hi Joe,

> Series seems sensible, thanks Tushar.
> 
> Next time you might choose to use
> 
> 	git format-patch --cover-letter
> 
> and write in the 0/n cover letter what the point
> of the patch series is.
> 

I was the one who suggested that we may not need a cover letter and 
instead provide the details in the patch description. We can include the 
cover letter in the next update.

thanks,
  -lakshmi


