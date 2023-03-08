Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6309F6B0A9B
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Mar 2023 15:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbjCHOKd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Mar 2023 09:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbjCHOJd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Mar 2023 09:09:33 -0500
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8979780914;
        Wed,  8 Mar 2023 06:08:28 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 902AA604F7;
        Wed,  8 Mar 2023 15:08:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1678284506; bh=b2xoRH8uNDDGrJhbs5P0hRrhL431AvtCXSHN4BCG9iM=;
        h=Date:To:Cc:From:Subject:From;
        b=SjYWgelJmI+V54+dNftTuCQLspEDfJm/jFUgUMFJOjSPwm2poQIgE0UAdM7Rbvqac
         YW/OwryV355G23WrMAWWEJP4O1nkcBc/s2g7bf9uCKsF8wd2kb+iViJXqwF4EHYGHY
         ZNO9kqO45TVEjazCeQaCVk0L0aF7Pn/p3l7hoh6dDghZ9ZdI52RvR+3HqIf1wTJskp
         uZdaiae4U6CbM5+f6PnXDZM6amOR4CkC7AbpOfJXpqqdAISBy6ry9CnHZhEQzaDnOG
         YGI770sX24RqDbGWt2Uxt6AcV536hoDnocVZU2i23M5DgO7e7+F+5mrXDzM62EeLh7
         P+yaERoM7NhwQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PdUCo2nhzweR; Wed,  8 Mar 2023 15:08:24 +0100 (CET)
Received: from [193.198.186.200] (pc-mtodorov.slava.alu.hr [193.198.186.200])
        by domac.alu.hr (Postfix) with ESMTPSA id 99FA6604F3;
        Wed,  8 Mar 2023 15:08:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1678284504; bh=b2xoRH8uNDDGrJhbs5P0hRrhL431AvtCXSHN4BCG9iM=;
        h=Date:To:Cc:From:Subject:From;
        b=XBz4R8ChK2fqGd1hXAtG54Brll2MmLQYgBXL6W3cqLLuXn3w04tssnwN5N9HsN1WC
         NcS4/946Z5GqmPDE2NWjfz/RjM9kRQ1lrwqZ1BGCoHflp27YwZ/J0gFkKrXTQu5is9
         lhNDbfVAuvF3bv8QvJnE5T4k2Xqwepid9Huc2R+3v4p1jc/J5UUS5SemOfq40Ir01O
         yrjy848vWm0HZasOo14hGWlzY4IpE9tKZWH7fiNYT0gggmhrxbPBfidpukxwv0ToSl
         TmJOFgMqmVjvVhDtih4c4oSRbR9j8hfkG0riAmY5kiFTE0CBw76VCOiYqhVNJzigea
         o27A6e257eGjA==
Message-ID: <60b2b66c-22c9-1d38-ed1c-7b7d95e32720@alu.unizg.hr>
Date:   Wed, 8 Mar 2023 15:08:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US, hr
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: INFO: BUG: kobject: 'integrity' (000000005198bea8): does not have a
 release() function, it is broken and must be fixed. See ...
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi, all!

This one is said to be bug, if we trust the Linux kernel debug output.

Usually I wouldn't have noticed it, but we were debugging the other module under
supervision from Andy of Intel. So it happened that I was accidentally monitoring
how the kobject_release() was called for kernel objects at shutdown of the OS.

It is past the rsyslog lifetime, so the only way I could capture it was a photo
from the smartphone.

Please see the bug reports from the kernel log:

https://domac.alu.hr/~mtodorov/linux/bugreports/integrity/20230308_123748.jpg

https://domac.alu.hr/~mtodorov/linux/bugreports/integrity/20230308_123752.jpg

The kernel is Linux 6.2.0-mg-andy-devres-12485-gf3a2439f20d9-dirty x86_64
on a LENOVO_MT_10TX_BU_Lenovo_FM_V530S-07ICB running AlmaLinux 8.7.

I was unable to reproduce on the other Lenovo laptop box, for the kernel
refused to boot, unable to find root drive on NVMe (other kernels w/o
CONFIG_DEBUG_KOBJECT=y run smoothly).

Config used is:

https://domac.alu.hr/~mtodorov/linux/bugreports/integrity/config-6.2.0-mg-andy-devres-12485-gf3a2439f20d9-dirty

As I already said to Andy, this might not be a critical bug, for it happens
only at shutdown AFAICS. However, it can be a sign of some more serious problem
in the code. :-/

Hope this helps.

Regards,
Mirsad

-- 
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu

System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
