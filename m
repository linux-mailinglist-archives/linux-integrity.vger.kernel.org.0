Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36007D6726
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Oct 2019 18:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388055AbfJNQVf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 14 Oct 2019 12:21:35 -0400
Received: from linux.microsoft.com ([13.77.154.182]:55570 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729889AbfJNQVf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Oct 2019 12:21:35 -0400
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 23D8720B71C6;
        Mon, 14 Oct 2019 09:21:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 23D8720B71C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1571070094;
        bh=snmVMviQ6dYXuT0E2M4xIWzijdzDony/cPtcBfT/iu4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=MNaf8U9aX5hf5KIzJ5h9yU0D3ESAZSq1J1/UeQFAT4davfK4x2P3XOnEdcR+fG93q
         O/ZX1w+dhTAkcVQ7BncOPOtjgATaymr4Bu9DleVwe1AP1xs6pGnskPBEEbXeSHj3LO
         nhRrg9kGs+Gz5600MNqrnK45uiNtnIg2/q/ii4W0=
Subject: Re: [PATCH v0 1/2] KEYS: Measure keys added to builtin or secondary
 trusted keys keyring
To:     Nayna <nayna@linux.vnet.ibm.com>, linux-integrity@vger.kernel.org,
        zohar@linux.ibm.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, kgoldman@us.ibm.com,
        mjg59@google.com, dhowells@redhat.com
Cc:     balajib@linux.microsoft.com, prsriva@linux.microsoft.com,
        jorhand@linux.microsoft.com, patatash@linux.microsoft.com
References: <20191011173547.3200-1-nramas@linux.microsoft.com>
 <20191011173547.3200-2-nramas@linux.microsoft.com>
 <9f015e69-ba6c-8631-d3b4-e60501dd97d8@linux.vnet.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <f8e1e16f-ac60-7c95-f4fd-82a9926dc61c@linux.microsoft.com>
Date:   Mon, 14 Oct 2019 09:21:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <9f015e69-ba6c-8631-d3b4-e60501dd97d8@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 10/13/19 11:34 AM, Nayna wrote:

> Hi Lakshmi,
> I am wondering that even though there is just one argument change in the 
> process_buffer_measurement() function, a full new function is defined. 
> This makes reviewing the function more difficult than it should be. Can 
> you please check on how the patch is getting formatted ?
> 
> Moreover, I am already modifying this function as part of the blacklist 
> patchset, but in a different way. Please refer to the Patch [5/8] in the 
> patchset titled "powerpc: Enabling IMA arch specific secure boot 
> policies". It was posted on 8th October.
> 
> I will modify the process_buffer_measurement() function in a way that 
> can work for both of our requirements and will post a new version soon.
> 
> Thanks & Regards,
>       - Nayna

Hi Nayna,

I think it is because I moved the function towards the top of the file - 
so it appears like a delete and an add instead of a minor change :(

Please let me know when you send your change. I'll take a look.

thanks,
  -lakshmi



