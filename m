Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5217A7369
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Sep 2019 21:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbfICTPF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Sep 2019 15:15:05 -0400
Received: from linux.microsoft.com ([13.77.154.182]:58040 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfICTPF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Sep 2019 15:15:05 -0400
Received: from [10.91.6.157] (unknown [167.220.2.157])
        by linux.microsoft.com (Postfix) with ESMTPSA id B6D6020B7186;
        Tue,  3 Sep 2019 12:15:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B6D6020B7186
Subject: Re: [PATCH v4] tpm: Parse event log from TPM2 ACPI table
To:     jarkko.sakkinen@linux.intel.com, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190831051027.11544-1-jorhand@linux.microsoft.com>
 <20190903182742.rmqthgu6rms3uill@cantor>
From:   Jordan Hand <jorhand@linux.microsoft.com>
Message-ID: <e86fd977-9c16-68df-e38e-4f9650ec5ac9@linux.microsoft.com>
Date:   Tue, 3 Sep 2019 12:15:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190903182742.rmqthgu6rms3uill@cantor>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 9/3/19 11:27 AM, Jerry Snitselaar wrote:
>> +        len = tpm2_trailer.minimum_log_length;
>> +        start = tpm2_trailer.log_address;
> 
> Are your builds not failing here? Both v3 and v4 have this.
> 

Ya, I saw the kbuild bot failure and fixed in v5. I'm not entirely sure
why I didn't catch it locally. Maybe a was compiling against the wrong
tree or something silly like that.

Thanks,
Jordan
