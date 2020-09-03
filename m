Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D277A25C6C3
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Sep 2020 18:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgICQ1m (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Sep 2020 12:27:42 -0400
Received: from mxout04.lancloud.ru ([89.108.124.63]:33392 "EHLO
        mxout04.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728901AbgICQ1l (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Sep 2020 12:27:41 -0400
X-Greylist: delayed 436 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Sep 2020 12:27:39 EDT
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru 6999D206FFD7
Received: from LanCloud
Received: from LanCloud
To:     linux-integrity <linux-integrity@vger.kernel.org>
From:   Igor Zhbanov <i.zhbanov@omprussia.ru>
Subject: LSM that blocks execution of the code from the anonymous pages
Message-ID: <5f166ecd-38e4-a808-c377-683aabf6bf65@omprussia.ru>
Date:   Thu, 3 Sep 2020 19:20:22 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: ru-RU
Content-Transfer-Encoding: 7bit
X-Originating-IP: [89.179.245.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To LFEX15.lancloud.ru
 (fd00:f066::45)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello!

Earlier in the therad "Should mprotect(..., PROT_EXEC) be checked by IMA?"
we've discussed whether IMA should intercept making executable of anonymous
pages.

I've implemented simple LSM that blocks execution of the code from anonymous
pages, like: mmap(RW) + read_unsigned_code_from_file() + mprotect(RX).

Currently it uses hooks similar to selinux_mmap_file() and
selinux_file_mprotect() to restrict any privileged processes (any uid is 0,
or any gid is 0 or any capability is set) from executing of anonymous unsigned
code.

The IMA module is specializing in file-backed (non-anonymous) code integrity
measurement while allowing execution of arbitrary anonymous code. In
conjunction with my LSM it would be possible to be sure that any code that is
executed on a device is trusted.

This would prevent malware payloads from being downloaded and executed in
both file-backed and anonymous memory. For example, there is even a framework
for making of filless malware:
https://www.prodefence.org/fireelf-fileless-linux-malware-framework/
Also there is an article about execution of ELFs from memory:
https://magisterquis.github.io/2018/03/31/in-memory-only-elf-execution.html
https://blog.fbkcs.ru/elf-in-memory-execution/

So it could be an independent LSM or extension of the LSM IMA functionality.

Also I'm thinking about extending working modes to:
1) no anonomous code for privileged processes (as currently),
2) no anonomous code for all processes,
3) no anonomous code for all processes with xattr-based exceptions (may be
    with xattr value signing)

I've found that some applications like browsers are using anonymous code
pages for JavaScript JIT code. Also some processes are using libffi that also
modifies to code. But it looks like it's possible to rebuild libffi with
trampoline support (PaX compatibility mode) to avoid altering the code pages.
Also QML-based application also use JS JIT. (And may be python scripts too.)

So for some (mostly unprivileged processes) we would need to make the
exceptions. But for most of the privileged system services (that is a good
target for attack because of their ptivileges) there is no need in code pages
modification, so the proposed functionality could be used to protect them,
as well as in embedded world where could be no user processes with JIT at all.

So IMA with this LSM would ensure that all the code that is executes is
trusted, signed and verified.

What do you think?

Thank you.
