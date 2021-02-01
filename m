Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7A730AD1A
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Feb 2021 17:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbhBAQwe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 1 Feb 2021 11:52:34 -0500
Received: from smtp-190d.mail.infomaniak.ch ([185.125.25.13]:59997 "EHLO
        smtp-190d.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231760AbhBAQwG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Feb 2021 11:52:06 -0500
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4DTv8z06B5zMqCNG;
        Mon,  1 Feb 2021 17:51:15 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4DTv8w3YSxzlh8Td;
        Mon,  1 Feb 2021 17:51:12 +0100 (CET)
Subject: Re: [PATCH v5 0/5] Enable root to update the blacklist keyring
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
To:     David Howells <dhowells@redhat.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        James Morris <jmorris@namei.org>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20210128191705.3568820-1-mic@digikod.net>
 <4160652.1612184844@warthog.procyon.org.uk>
 <9d95ec74-cc89-9e0c-dac8-c05ea52991ac@digikod.net>
Message-ID: <702232df-e229-a716-b688-918fe7e168e8@digikod.net>
Date:   Mon, 1 Feb 2021 17:51:11 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <9d95ec74-cc89-9e0c-dac8-c05ea52991ac@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

It doesn't contain Jarkko's Tested-by and Reviewed-by tags though.

On 01/02/2021 17:48, Mickaël Salaün wrote:
> Hi,
> 
> Yes, you can pull this patchset from here:
> https://github.com/l0kod/linux branch dyn-auth-blacklist-v5 (commit
> 33b94bcd56843b4235c6ba4a44157b3c5a8792f1).
> 
>  Mickaël
> 
> 
> On 01/02/2021 14:07, David Howells wrote:
>>
>> Hi Mickaël,
>>
>> Do you have a public branch somewhere I can pull from?
>>
>> David
>>
