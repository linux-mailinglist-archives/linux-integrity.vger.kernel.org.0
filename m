Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3913258F6
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Feb 2021 22:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbhBYVvB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 Feb 2021 16:51:01 -0500
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:49194 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231326AbhBYVvB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Feb 2021 16:51:01 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id B68F312807C9;
        Thu, 25 Feb 2021 13:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1614289820;
        bh=HGOJpWfrv9GxrWzvvE7lAFDJ8qmywXKmntfMBM8l1oU=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=LiNzrFs3Pbz/QnSWd6EcDkanTY5r7UOuPIlQXaOTiyFz317BeDr2xXxk8mULvTeEF
         73kYleD1wLupZuxARvXMGqXknlfJV1uFSxB5fJ0hZ3e1HuXU6RUWJCBdP8cJ+a8gmP
         ZutyU9R/qXlFiT3HnxwHcNLOPbfrYPF4RPOPYT3A=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Kz9EfRdrsqxi; Thu, 25 Feb 2021 13:50:20 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::527])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 1FBD312807A2;
        Thu, 25 Feb 2021 13:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1614289820;
        bh=HGOJpWfrv9GxrWzvvE7lAFDJ8qmywXKmntfMBM8l1oU=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=LiNzrFs3Pbz/QnSWd6EcDkanTY5r7UOuPIlQXaOTiyFz317BeDr2xXxk8mULvTeEF
         73kYleD1wLupZuxARvXMGqXknlfJV1uFSxB5fJ0hZ3e1HuXU6RUWJCBdP8cJ+a8gmP
         ZutyU9R/qXlFiT3HnxwHcNLOPbfrYPF4RPOPYT3A=
Message-ID: <1e41f22b1f11784f1e943f32bf62034d4e054cdb.camel@HansenPartnership.com>
Subject: Re: [PATCH 0/3] Load keys from TPM2 NV Index on IMA keyring
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Patrick Uiterwijk <patrick@puiterwijk.org>, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, linux-integrity@vger.kernel.org
Cc:     pbrobinson@gmail.com, stefanb@linux.ibm.com, kgold@linux.ibm.com
Date:   Thu, 25 Feb 2021 13:50:19 -0800
In-Reply-To: <20210225203229.363302-1-patrick@puiterwijk.org>
References: <20210225203229.363302-1-patrick@puiterwijk.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-02-25 at 21:32 +0100, Patrick Uiterwijk wrote:
> The system's signature chain of trust is rooted in hardware and
> pivots to the keys baked into the kernel. IMA maintains this
> signature chain of trust by requiring any key being added to the IMA
> trusted keyring to be signed by a key on the builtin (or secondary)
> keyrings. This prevents a local key, needed for signing policies or
> other files, from being loaded on the IMA keyring, without requiring
> a custom built kernel (or injecting a key and resigning the kernel
> image).
> 
> Allow users to load their own public key stored in a specific TPM2 NV
> Index, requiring the absence of the Platform Create and Platform
> Write attributes on the NV Index, to be loaded on the IMA keyring.
> 
> To test this with the TPM2-software tools with a DER-encoded
> imacert.der:
>   tpm2_nvdefine -C o -s 945 0x184b520
>   tpm2_nvwrite -C o -i imacert.der 0x184b520
> 
> Or with the IBM TSS tools:
>   tssnvdefinespace -ha 0x184b520 -hi o -sz 945 +at ow +at or
>   tssnvwrite -hia o -ha 0x184b520 -if imacert.der
> 
> Then after a reboot, the ima keyring should contain the certificate.
> 
> Note that if this feature is enabled, users should make sure an NV
> Index is created with accurate attributes to prevent any other users
> from writing or deleting the NV Index. Without this precaution, any
> user who has access to the TPM would be able to write a key to the NV
> Index and have that key loaded on the IMA trusted keyring.
> 
> A distro who wants to enable this feature, for example, should ensure
> that the installer defines the NV Index in all cases, and only fills
> it if a key was provided by the user.

This has some problematic security implications:  any member of the tpm
group (which is pretty much all users if you use the TPM for user space
secrets or other operations) can read and write NV indexes.  What does
a distro do if the index is occupied on install (because it could be
some malicious entity who's put their cert in the index)?

> It is strongly adviced that any NV Index created for this purpose has
> at least the policy_delete and policywrite attributes set, together
> with a non-empty policy. Those flags make sure that the policy (which
> would be up to them to define) is required to be satisfied to delete
> or write the index.

This isn't necessarily good enough.  Unless the index has
PlatformCreate set, then any member of the tpm group can delete it with
TPM2_NV_UndefineIndex.  Creating stuff with TPM_NV_PLATFORMCREATE
attributes is possible, but whoever does must know the platform policy
or auth, so how would any distro get that if it's non standard (and if
it is standard then any tpm user can delete the index with
TPM2_NV_UndefineSpaceSpecial).

The bottom line is I don't see how this could safely be used by a
distribution in any standard manner, so why not simply pass the cert in
on the command line instead?  At least any random user can't then
compromise the process.

James


