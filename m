Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC37E2904ED
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Oct 2020 14:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407419AbgJPMTS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 16 Oct 2020 08:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407418AbgJPMTR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Oct 2020 08:19:17 -0400
Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch [IPv6:2001:1600:3:17::42a9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7FBC0613D3
        for <linux-integrity@vger.kernel.org>; Fri, 16 Oct 2020 05:19:17 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4CCQDy0WxlzlhX9r;
        Fri, 16 Oct 2020 14:19:14 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [94.23.54.103])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4CCQDx0z2wzlh8TJ;
        Fri, 16 Oct 2020 14:19:13 +0200 (CEST)
Subject: Re: [PATCH v2] dm verity: Add support for signature verification with
 2nd keyring
To:     Milan Broz <gmazyland@gmail.com>, Mike Snitzer <snitzer@redhat.com>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Jaskaran Khurana <jaskarankhurana@linux.microsoft.com>,
        dm-devel@redhat.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>
References: <20201015150504.1319098-1-mic@digikod.net>
 <20201015165229.GA5513@redhat.com>
 <022e949e-00c4-d98a-b536-1c5f9e05c09c@digikod.net>
 <b7ba2ff9-5f5f-8c1e-dfaa-33da56d3d8de@digikod.net>
 <b7ccaa01-0398-f108-a70d-c67753d9fa6d@gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <55389f91-60a5-05db-b3e1-8f24aa356893@digikod.net>
Date:   Fri, 16 Oct 2020 14:19:12 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <b7ccaa01-0398-f108-a70d-c67753d9fa6d@gmail.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 16/10/2020 13:08, Milan Broz wrote:
> On 16/10/2020 10:49, Mickaël Salaün wrote:
>> On 16/10/2020 10:29, Mickaël Salaün wrote:
>>>
>>> On 15/10/2020 18:52, Mike Snitzer wrote:
>>>> Can you please explain why you've decided to make this a Kconfig CONFIG
>>>> knob?  Why not either add: a dm-verity table argument? A dm-verity
>>>> kernel module parameter? or both (to allow a particular default but
>>>> then
>>>> per-device override)?
>>>
>>> The purpose of signed dm-verity images is to authenticate files, or said
>>> in another way, to enable the kernel to trust disk images in a flexible
>>> way (i.e. thanks to certificate's chain of trust). Being able to update
>>> such chain at run time requires to use the second trusted keyring. This
>>> keyring automatically includes the certificate authorities from the
>>> builtin trusted keyring, which are required to dynamically populate the
>>> secondary trusted keyring with certificates signed by an already trusted
>>> authority. The roots of trust must then be included at build time in the
>>> builtin trusted keyring.
>>>
>>> To be meaningful, using dm-verity signatures implies to have a
>>> restricted user space, i.e. even the root user has limited power over
>>> the kernel and the rest of the system. Blindly trusting data provided by
>>> user space (e.g. dm-verity table argument, kernel module parameter)
>>> defeat the purpose of (mandatory) authenticated images.
>>>
>>>>
>>>> Otherwise, _all_ DM verity devices will be configured to use secondary
>>>> keyring fallback.  Is that really desirable?
>>>
>>> That is already the current state (on purpose).
>>
>> I meant that when DM_VERITY_VERIFY_ROOTHASH_SIG is set, dm-verity
>> signature becomes mandatory. This new configuration
>> DM_VERITY_VERIFY_ROOTHASH_SIG_SECONDARY_KEYRING extend this trust to the
>> secondary trusted keyring, which contains certificates signed (directly
>> or indirectly) by CA from the builtin trusted keyring.
>>
>> So yes, this new (optional) configuration *extends* the source of trust
>> for all dm-verity devices, and yes, it is desirable. I think it should
>> have been this way from the beginning (as for other authentication
>> mechanisms) but it wasn't necessary at that time.
> 
> Well, I understand why you need a config option here.
> And using the secondary keyring actually makes much more sense to me than
> the original approach.
> 
> But please do not forget that dm-verity is sometimes used in different
> contexts where such strict in-kernel certificate trust is unnecessary.
> With your configure options set, you deliberately remove the possibility
> to configure such devices.
It doesn't make sense to set DM_VERITY_VERIFY_ROOTHASH_SIG in generic
distro because such policy is configured at build time in the kernel
with hardcoded CAs. If the new option is not set then nothing change. I
don't see why it could be an issue for use cases we previously defined
(with DM_VERITY_VERIFY_ROOTHASH_SIG).

> I understand that it is needed for "trusted" systems, but we should be
> clear
> in the documentation.
> Maybe also add note to
> /Documentation/admin-guide/device-mapper/verity.rst ?
> We already mention DM_VERITY_VERIFY_ROOTHASH_SIG there.

The current documentation remains true.
DM_VERITY_VERIFY_ROOTHASH_SIG_SECONDARY_KEYRING depends on
DM_VERITY_VERIFY_ROOTHASH_SIG.

> 
> The current userspace configuration through veritysetup does not need
> any patches for your patch, correct?

Right, it's only different from the kernel point of view.

> 
> Thanks,
> Milan
> 
