Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F5864DB92
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Dec 2022 13:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiLOMsP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 15 Dec 2022 07:48:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiLOMrv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Dec 2022 07:47:51 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CF923C
        for <linux-integrity@vger.kernel.org>; Thu, 15 Dec 2022 04:47:14 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4NXsJC0Wlsz9xFQL
        for <linux-integrity@vger.kernel.org>; Thu, 15 Dec 2022 20:39:55 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwAHkQxCF5tjfOoVAA--.22936S2;
        Thu, 15 Dec 2022 13:47:05 +0100 (CET)
Message-ID: <b438365f99bef86056d679252f9799136a4bda35.camel@huaweicloud.com>
Subject: Re: IMA & tpm_unsealdata with PCR 10
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     =?ISO-8859-1?Q?Micha=EBl?= Musset <mickamusset@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Thu, 15 Dec 2022 13:46:54 +0100
In-Reply-To: <CAF+MRt=yraJgxyXtv==30_drA=wLi36RVBPwK_34WCzw=C_Z3A@mail.gmail.com>
References: <CAF+MRt=yraJgxyXtv==30_drA=wLi36RVBPwK_34WCzw=C_Z3A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwAHkQxCF5tjfOoVAA--.22936S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WrW5Kr1kXr4fuw47tw4fKrg_yoW8Kw4kpa
        1agr1akF4DJ3WSkryIkr1UW340vrZ5Ja1UX3s5G348Zay5Gryv9r40ka4Y9Fy2qr4vvw1Y
        y3W09r1fJ3s8JaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
        Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
        AY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
        cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMI
        IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2
        KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAHBF1jj4auLwABs1
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2022-12-15 at 11:54 +0100, Michaël Musset wrote:
> Hi,
> 
> I've enabled IMA , policy that are enabled, checked only binary file and module.
> 
> The problem is that the booting of systemd is not predictable, so
> after each boot the PCR 10 is different.

Hi Michael

yes, this is one of the problems of doing file measurements with
parallel execution. It is a property of the TPM PCR extension, to bind
the current measurement to the previous ones. It is for security
reasons, to avoid an attacker to go back to when there were only good
measurements.

> Then I'm unable to use tpm_unsealdata at PCR 10 .

Yes, with the current measurement approach it is not feasible.

> I would like to have your opinion on that. What is the point of PCR 10
> if it's not the same at a certain moment on the linux boot.

PCR 10 was intended to protect the integrity of measurements, to be
sent to remote verifiers. Those verifiers, by seeing the measurements,
can conclude if the properties they are interested in are successfully
verified or not.

> I wanted to use PCR 10 to protect a key based on the hash of each
> binary in my linux SD.

I have developed a solution that does what you want. It is called
DIGLIM:

https://lore.kernel.org/linux-integrity/20210914163401.864635-1-roberto.sassu@huawei.com/

At boot time, before init, it extends a PCR with a list of digests of
files from your disk (or better, from your Linux distribution, signed
by the vendor). IMA then searches the digest of the files being
accessed at run-time in that preloaded list. If it finds it, it does
not further extend the PCR. Otherwise, it extends the PCR.

With this scheme, the PCR is again predictable and you can seal keys
with it. After an unknown file was accessed, the key becomes unusable
(due to the PCR extend).

I actually implemented a library:

https://github.com/openeuler-mirror/attest-tools

to generate keys and certificates to be used for a TLS connection. The
key is bound to the list of file digests (and to the other components
involved in the boot process). It requires openssl_tpm2_engine from
James Bottomley.

> looks like this is not the correct way,
> 
> I've an idea to fix it :
> 
> sort -k 5 /sys/kernel/security/ima/ascii_runtime_measurements > somefile.txt
> sha1sum somefile.txt
> with this somefile.txt contain a hash that is always the same after each boot

Yes, this is more or less what DIGLIM was at the beginning.

Roberto

