Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF84460F9
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Jun 2019 16:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbfFNOhZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 14 Jun 2019 10:37:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:41700 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728201AbfFNOhZ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 14 Jun 2019 10:37:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 263A1AEA4;
        Fri, 14 Jun 2019 14:37:24 +0000 (UTC)
Subject: Re: [PATCH v4 4/4] ima: Add overlay test + doc
To:     Petr Vorel <pvorel@suse.cz>
Cc:     ltp@lists.linux.it, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>
References: <20190613161414.29161-1-pvorel@suse.cz>
 <20190613161414.29161-5-pvorel@suse.cz>
 <55f6fec4-ef01-db2b-62c0-cbbbf79c6c12@suse.de>
 <20190614141449.GA24614@dell5510>
From:   Ignaz Forster <iforster@suse.de>
Message-ID: <794ee977-463f-6670-fac6-3e27e25d64ab@suse.de>
Date:   Fri, 14 Jun 2019 16:37:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190614141449.GA24614@dell5510>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Am 14.06.19 um 16:14 Uhr schrieb Petr Vorel:
>>> +++ b/testcases/kernel/security/integrity/ima/tests/README.md
>>> @@ -0,0 +1,83 @@
>>> +IMA + EVM testing
>>> +=================
>>> +
>>> +IMA tests
>>> +---------
>>> +
>>> +`ima_measurements.sh` require builtin IMA tcb policy to be loaded
>>> +(`ima_policy=tcb` or `ima_policy=appraise_tcb` kernel parameter).
> 
>> This test requires "appraise_tcb" ("tcb" is not enough), as the errors only
>> occur during appraisal.
> Are you sure? This is a note for ima_measurements.sh test (not for evm_overlay.sh).
> I require ima_policy=tcb here, according to Mimi [1]

Oh, sorry, you are correct - "tcb" is correct in this case. I got 
confused as the documentation is included in the overlayfs reproducer patch.

Ignaz
