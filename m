Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03762297203
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Oct 2020 17:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461732AbgJWPMD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 23 Oct 2020 11:12:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37849 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S461722AbgJWPMC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 23 Oct 2020 11:12:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603465920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jTHdNB/AczUtmx4fGGDW94Nf1D2Dq1eyonOLPvs49Qw=;
        b=Ugy+E86GoCq9L7V7Ep28b8hWeSLMkq82O18q71ju2g/SPsq8/VEzdg8LTsRpWjqfn3clTD
        Z6MFitu/YZ2fA/eN8Hc2F0CU3IK0GCRotRhht/BHc/RBoJR+FrrmPTGhYvCMr5jWfXhGJ4
        TS4J4xU9dMSOC5exMRv1ZWy+G+/xQuU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-veHNhlKUOSesxsITs8zIeQ-1; Fri, 23 Oct 2020 11:11:58 -0400
X-MC-Unique: veHNhlKUOSesxsITs8zIeQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C31A74236C;
        Fri, 23 Oct 2020 15:11:56 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 48C855D9D5;
        Fri, 23 Oct 2020 15:11:53 +0000 (UTC)
Date:   Fri, 23 Oct 2020 11:11:52 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Jaskaran Khurana <jaskarankhurana@linux.microsoft.com>,
        dm-devel@redhat.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>,
        Milan Broz <gmazyland@gmail.com>
Subject: Re: [PATCH v2] dm verity: Add support for signature verification
 with 2nd keyring
Message-ID: <20201023151152.GA21936@redhat.com>
References: <20201015150504.1319098-1-mic@digikod.net>
 <20201015165229.GA5513@redhat.com>
 <022e949e-00c4-d98a-b536-1c5f9e05c09c@digikod.net>
 <b7ba2ff9-5f5f-8c1e-dfaa-33da56d3d8de@digikod.net>
 <b7ccaa01-0398-f108-a70d-c67753d9fa6d@gmail.com>
 <55389f91-60a5-05db-b3e1-8f24aa356893@digikod.net>
 <54e98aa6-0e52-1147-b9ce-a640e2317b00@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <54e98aa6-0e52-1147-b9ce-a640e2317b00@digikod.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Oct 23 2020 at  6:20am -0400,
Mickaël Salaün <mic@digikod.net> wrote:

> It seems that there is no more question. Mike, Alasdair, could you
> please consider to merge this into the tree?
> 
> On 16/10/2020 14:19, Mickaël Salaün wrote:
> > 
> > On 16/10/2020 13:08, Milan Broz wrote:
> >> On 16/10/2020 10:49, Mickaël Salaün wrote:
> >>> On 16/10/2020 10:29, Mickaël Salaün wrote:
> >>>>
> >>>> On 15/10/2020 18:52, Mike Snitzer wrote:
> >>>>> Can you please explain why you've decided to make this a Kconfig CONFIG
> >>>>> knob?  Why not either add: a dm-verity table argument? A dm-verity
> >>>>> kernel module parameter? or both (to allow a particular default but
> >>>>> then
> >>>>> per-device override)?
> >>>>
> >>>> The purpose of signed dm-verity images is to authenticate files, or said
> >>>> in another way, to enable the kernel to trust disk images in a flexible
> >>>> way (i.e. thanks to certificate's chain of trust). Being able to update
> >>>> such chain at run time requires to use the second trusted keyring. This
> >>>> keyring automatically includes the certificate authorities from the
> >>>> builtin trusted keyring, which are required to dynamically populate the
> >>>> secondary trusted keyring with certificates signed by an already trusted
> >>>> authority. The roots of trust must then be included at build time in the
> >>>> builtin trusted keyring.
> >>>>
> >>>> To be meaningful, using dm-verity signatures implies to have a
> >>>> restricted user space, i.e. even the root user has limited power over
> >>>> the kernel and the rest of the system. Blindly trusting data provided by
> >>>> user space (e.g. dm-verity table argument, kernel module parameter)
> >>>> defeat the purpose of (mandatory) authenticated images.
> >>>>
> >>>>>
> >>>>> Otherwise, _all_ DM verity devices will be configured to use secondary
> >>>>> keyring fallback.  Is that really desirable?
> >>>>
> >>>> That is already the current state (on purpose).
> >>>
> >>> I meant that when DM_VERITY_VERIFY_ROOTHASH_SIG is set, dm-verity
> >>> signature becomes mandatory. This new configuration
> >>> DM_VERITY_VERIFY_ROOTHASH_SIG_SECONDARY_KEYRING extend this trust to the
> >>> secondary trusted keyring, which contains certificates signed (directly
> >>> or indirectly) by CA from the builtin trusted keyring.
> >>>
> >>> So yes, this new (optional) configuration *extends* the source of trust
> >>> for all dm-verity devices, and yes, it is desirable. I think it should
> >>> have been this way from the beginning (as for other authentication
> >>> mechanisms) but it wasn't necessary at that time.
> >>
> >> Well, I understand why you need a config option here.
> >> And using the secondary keyring actually makes much more sense to me than
> >> the original approach.
> >>
> >> But please do not forget that dm-verity is sometimes used in different
> >> contexts where such strict in-kernel certificate trust is unnecessary.
> >> With your configure options set, you deliberately remove the possibility
> >> to configure such devices.
> > It doesn't make sense to set DM_VERITY_VERIFY_ROOTHASH_SIG in generic
> > distro because such policy is configured at build time in the kernel
> > with hardcoded CAs. If the new option is not set then nothing change. I
> > don't see why it could be an issue for use cases we previously defined
> > (with DM_VERITY_VERIFY_ROOTHASH_SIG).
> > 
> >> I understand that it is needed for "trusted" systems, but we should be
> >> clear
> >> in the documentation.
> >> Maybe also add note to
> >> /Documentation/admin-guide/device-mapper/verity.rst ?
> >> We already mention DM_VERITY_VERIFY_ROOTHASH_SIG there.
> > 
> > The current documentation remains true.
> > DM_VERITY_VERIFY_ROOTHASH_SIG_SECONDARY_KEYRING depends on
> > DM_VERITY_VERIFY_ROOTHASH_SIG.

Yes, while true that doesn't change the fact that documenting
DM_VERITY_VERIFY_ROOTHASH_SIG_SECONDARY_KEYRING is useful to potential
consumers of baseline DM_VERITY_VERIFY_ROOTHASH_SIG.

Please update Documentation and post v3, I'll get it merged for 5.11.

Thanks,
Mike

