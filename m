Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49BD228FFF7
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Oct 2020 10:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394392AbgJPI3u (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 16 Oct 2020 04:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394610AbgJPI3r (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Oct 2020 04:29:47 -0400
Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [IPv6:2001:1600:4:17::190a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B941AC061755
        for <linux-integrity@vger.kernel.org>; Fri, 16 Oct 2020 01:29:47 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4CCK881ZphzlhX5w;
        Fri, 16 Oct 2020 10:29:44 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [94.23.54.103])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4CCK864nJFzlh8T9;
        Fri, 16 Oct 2020 10:29:42 +0200 (CEST)
Subject: Re: [PATCH v2] dm verity: Add support for signature verification with
 2nd keyring
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Jaskaran Khurana <jaskarankhurana@linux.microsoft.com>,
        Milan Broz <gmazyland@gmail.com>, dm-devel@redhat.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>
References: <20201015150504.1319098-1-mic@digikod.net>
 <20201015165229.GA5513@redhat.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <022e949e-00c4-d98a-b536-1c5f9e05c09c@digikod.net>
Date:   Fri, 16 Oct 2020 10:29:42 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <20201015165229.GA5513@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 15/10/2020 18:52, Mike Snitzer wrote:
> On Thu, Oct 15 2020 at 11:05am -0400,
> Mickaël Salaün <mic@digikod.net> wrote:
> 
>> From: Mickaël Salaün <mic@linux.microsoft.com>
>>
>> Add a new configuration DM_VERITY_VERIFY_ROOTHASH_SIG_SECONDARY_KEYRING
>> to enable dm-verity signatures to be verified against the secondary
>> trusted keyring.  Instead of relying on the builtin trusted keyring
>> (with hard-coded certificates), the second trusted keyring can include
>> certificate authorities from the builtin trusted keyring and child
>> certificates loaded at run time.  Using the secondary trusted keyring
>> enables to use dm-verity disks (e.g. loop devices) signed by keys which
>> did not exist at kernel build time, leveraging the certificate chain of
>> trust model.  In practice, this makes it possible to update certificates
>> without kernel update and reboot, aligning with module and kernel
>> (kexec) signature verification which already use the secondary trusted
>> keyring.
>>
>> Cc: Alasdair Kergon <agk@redhat.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>> Cc: Jaskaran Khurana <jaskarankhurana@linux.microsoft.com>
>> Cc: Mike Snitzer <snitzer@redhat.com>
>> Cc: Milan Broz <gmazyland@gmail.com>
>> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
>> ---
>>
>> Previous version:
>> https://lore.kernel.org/lkml/20201002071802.535023-1-mic@digikod.net/
>>
>> Changes since v1:
>> * Extend the commit message (asked by Jarkko Sakkinen).
>> * Rename the Kconfig "help" keyword according to commit 84af7a6194e4
>>   ("checkpatch: kconfig: prefer 'help' over '---help---'").
> 
> Can you please explain why you've decided to make this a Kconfig CONFIG
> knob?  Why not either add: a dm-verity table argument? A dm-verity
> kernel module parameter? or both (to allow a particular default but then
> per-device override)?

The purpose of signed dm-verity images is to authenticate files, or said
in another way, to enable the kernel to trust disk images in a flexible
way (i.e. thanks to certificate's chain of trust). Being able to update
such chain at run time requires to use the second trusted keyring. This
keyring automatically includes the certificate authorities from the
builtin trusted keyring, which are required to dynamically populate the
secondary trusted keyring with certificates signed by an already trusted
authority. The roots of trust must then be included at build time in the
builtin trusted keyring.

To be meaningful, using dm-verity signatures implies to have a
restricted user space, i.e. even the root user has limited power over
the kernel and the rest of the system. Blindly trusting data provided by
user space (e.g. dm-verity table argument, kernel module parameter)
defeat the purpose of (mandatory) authenticated images.

> 
> Otherwise, _all_ DM verity devices will be configured to use secondary
> keyring fallback.  Is that really desirable?

That is already the current state (on purpose).

> 
> Regardless, I really don't see why a Kconfig knob is appropriate.

Moreover, a Kconfig knob makes sense as much as
DM_VERITY_VERIFY_ROOTHASH_SIG,
IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY, MODULE_SIG_FORCE and
other similar authentication mechanisms. Indeed, when using these
configurations, we want the kernel to enforce a specific policy.

Obviously, we can't make the DM_VERITY_VERIFY_ROOTHASH_SIG relies on the
secondary trusted keyring without important security implications for
systems already using this configuration (and then the builtin trusted
keyring as the unique source of trust).
