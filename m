Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48054150122
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Feb 2020 06:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbgBCFPJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 Feb 2020 00:15:09 -0500
Received: from relay.sw.ru ([185.231.240.75]:44952 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbgBCFPJ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Feb 2020 00:15:09 -0500
Received: from vvs-ws.sw.ru ([172.16.24.21])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <vvs@virtuozzo.com>)
        id 1iyU4V-0002zD-4G; Mon, 03 Feb 2020 08:14:55 +0300
Subject: Re: [PATCH v2 2/2] tpm: tpm2_bios_measurements_next should increase
 position index
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>
References: <e72b6fda6c4ff0d54af37d064d66b883d7ea48e7.camel@linux.intel.com>
 <16bde2d6-4208-e478-0ac3-163b5c3a1eaa@virtuozzo.com>
 <20200201170329.GA14875@linux.intel.com>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <3ffb8968-fccc-9f2e-7931-01c634932d5e@virtuozzo.com>
Date:   Mon, 3 Feb 2020 08:14:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200201170329.GA14875@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/1/20 8:03 PM, Jarkko Sakkinen wrote:
> On Thu, Jan 30, 2020 at 01:23:21PM +0300, Vasily Averin wrote:
>> If seq_file .next function does not change position index,
>> read after non-zero lseek can generate unexpected output.
> 
> Is it unwanted or unexpected? Unexpected would be mean random
> output. I don't think that is the case. Please describe more
> throughly.

If .next function does not change position index, 
following .show function will repeat output related to current position index.

>> For /sys/kernel/security/tpm0/binary_bios_measurements:
>> 1) read after lseek beyond end of file generates whole last line.
>> 2) read after lseek to middle of last line generates
>> expected end of last line and unexpected whole last line once again.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 1f4aace60b0e ("fs/seq_file.c: simplify seq_file iteration code ...")
>>
> No empty line here.
> 
>> https://bugzilla.kernel.org/show_bug.cgi?id=206283
> 
> "Link: https://bugzilla.kernel.org/show_bug.cgi?id=206283"
> 
> /Jarkko
> 
