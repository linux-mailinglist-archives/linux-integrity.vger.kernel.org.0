Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3BC5128360
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Dec 2019 21:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfLTUug (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 Dec 2019 15:50:36 -0500
Received: from linux.microsoft.com ([13.77.154.182]:45136 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727422AbfLTUuf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Dec 2019 15:50:35 -0500
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id CCD0120106BA;
        Fri, 20 Dec 2019 12:50:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CCD0120106BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1576875035;
        bh=nCXI723Paiou2qhM6Iep4RO6p6kZcLH60+OZE/A0Wj0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=P0+F991oIoc1uIRq2J/OZoa8NNdiJNVhpC3IYKHSoWeKEVzWoyGJpgn/IA0hfphjZ
         nCpVTpTjTT/XO4EE8LWgHUL/5WmRvhOHCWBTF224K04MJRhQJqoH9udQdNhI5h6Cbx
         THFVWApuNdTRqU0hXUxLvUP+mtueX23TYjvW8Ibo=
Subject: Re: [PATCH v5 0/2] IMA: Deferred measurement of keys
To:     Mimi Zohar <zohar@linux.ibm.com>,
        James.Bottomley@HansenPartnership.com,
        linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        mathew.j.martineau@linux.intel.com, matthewgarrett@google.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
References: <20191218164434.2877-1-nramas@linux.microsoft.com>
 <1576868506.5241.65.camel@linux.ibm.com>
 <589b893b-52e4-783c-0f32-608ed1cfd7f9@linux.microsoft.com>
 <1576870595.5241.83.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <9f346e6d-04f2-b8cd-bf67-f1cee59d9630@linux.microsoft.com>
Date:   Fri, 20 Dec 2019 12:50:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1576870595.5241.83.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/20/19 11:36 AM, Mimi Zohar wrote:

>>
>> Shall I create a new patch set to address that and have that be reviewed
>> independent of this patch set?
> 
> If it is just a single additional patch, feel free to post it without
> a cover letter.

Sure

>>
>> Like you'd suggested earlier, we can wait for a certain time, after IMA
>> is initialized, and free the queue if a custom policy was not loaded.
> 
> Different types of systems vary in boot time, but perhaps a certain
> amount of time after IMA is initialized would be consistent.  This
> would need to work for IoT devices/sensors to servers.
> 
> Mimi
> 

Yes - I agree.

thanks,
  -lakshmi
