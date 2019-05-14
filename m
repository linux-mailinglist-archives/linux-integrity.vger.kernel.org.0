Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 817D61CF47
	for <lists+linux-integrity@lfdr.de>; Tue, 14 May 2019 20:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbfENSmH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 May 2019 14:42:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:45520 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726229AbfENSmH (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 May 2019 14:42:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 827AEABE7;
        Tue, 14 May 2019 18:42:06 +0000 (UTC)
Subject: Re: [PATCH v2 3/3] ima: Add overlay test
To:     Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Fabian Vogt <FVogt@suse.com>,
        Marcus Meissner <meissner@suse.com>,
        linux-integrity@vger.kernel.org
References: <20190405165225.27216-1-pvorel@suse.cz>
 <20190405165225.27216-4-pvorel@suse.cz>
From:   Ignaz Forster <iforster@suse.de>
Message-ID: <810d4df7-1e5e-dd24-8b87-e0fa3edbd25f@suse.de>
Date:   Tue, 14 May 2019 20:42:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190405165225.27216-4-pvorel@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Petr,

thanks a lot for your continued work on the IMA / EVM tests and sorry 
for missing feedback - the mail got lost in my stack of TODO items.

Am 05.04.19 um 18:52 Uhr schrieb Petr Vorel:
> Should I check EVM enabled?

As these tests require an appropriately prepared machine anyway: How 
about printing a message whether only IMA or both IMA and EVM are 
enabled. These tests make sense in both cases, so I wouldn't block them 
on either setup.

> /sys/kernel/security/evm should be 1?

Yes, that should be enough to detect whether EVM is enabled.

> +test1()
> +{
> +	local file="foo1.txt"
> +
> +	tst_res TINFO "overwrite file in overlay"
> +	ROD echo lower \> $lower/$file
> +	EXPECT_PASS echo overlay \> $merged/$file

It seems the redirection / escaping is wrong here: the string "overlay" 
never ends up in the target file.

> +}
> +
> +test2()
> +{
> +	local file="foo2.txt"
> +
> +	tst_res TINFO "append file in overlay"
> +	ROD echo lower \> $lower/$file
> +	EXPECT_PASS echo overlay \>\> $merged/$file

Same here: "overlay" never ends up in the target file.

Ignaz
