Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B087D5853D
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Jun 2019 17:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbfF0PIZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 Jun 2019 11:08:25 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58904 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbfF0PIY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Jun 2019 11:08:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4CZwDA7Pj4HoUqoimtFG6dWxz1lB8O8Y9IowCuyvjuo=; b=UWo6VtIXVEJUQFD02J/NXsl1wM
        dksFvEed5QUKJoHfH5JDzfNzWNvVYRJdhlJedBY+a7xGjEJkkV1DyQzILnoLXCOtpAPk6gpxXhWCd
        /bywSwc445dDB7Yc/btARPRov91Qe/os/xxO0dhqnmXVwRuCcpGUqyw/6D69aBX0almWfrGXonzbG
        BnT/W9EyfkP9tx3HmuTk9NYes5OwqyUC2/yHlS3/t8E52Jn8sAGbRLwzMvPbCiQOaDJaNKuzO+yHj
        oPp199PgJLgRw4Q/CzVPdgLpUs0iEmpT6q3e3sI09KgfkxXP4yFtVtlFqskFipbBHzLCf+0wa4WZk
        8wVY9SDA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgW0a-00014f-Om; Thu, 27 Jun 2019 15:08:20 +0000
Subject: Re: linux-next: Tree for Jun 26 (security/integrity/ima/)
To:     David Howells <dhowells@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-security-module <linux-security-module@vger.kernel.org>
References: <1561640534.4101.124.camel@linux.ibm.com>
 <20190626231617.1e858da3@canb.auug.org.au>
 <ee503bc1-a588-81f5-47e0-1762f590662f@infradead.org>
 <9446.1561642145@warthog.procyon.org.uk>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <596322b1-1c89-0538-5c26-cd132b03e3eb@infradead.org>
Date:   Thu, 27 Jun 2019 08:08:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <9446.1561642145@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/27/19 6:29 AM, David Howells wrote:
> Mimi Zohar <zohar@linux.ibm.com> wrote:
> 
>>>   CC      security/integrity/ima/ima_fs.o
>>> In file included from ../security/integrity/ima/ima.h:25:0,
>>>                  from ../security/integrity/ima/ima_fs.c:26:
>>> ../security/integrity/ima/../integrity.h:170:18: warning: ‘struct key_acl’ declared inside parameter list [enabled by default]
>>>            struct key_acl *acl)
>>>                   ^
>>> ../security/integrity/ima/../integrity.h:170:18: warning: its scope is only this definition or declaration, which is probably not what you want [enabled by default]
>>
>> David, CONFIG_INTEGRITY_SIGNATURE is dependent on KEYS being enabled,
>> but the stub functions are not.  There's now a dependency on
>> key_acl().
> 
> I added a forward declaration for struct key_acl into
> security/integrity/integrity.h as you can see here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/diff/security/integrity/integrity.h?h=keys-acl&id=75ce113a1d56880e5abd37fa664ea9af399d2bcd
> 
> which might not have made it into linux-next before you used it.

No problem in linux-next 20190627.

Thanks.

-- 
~Randy
