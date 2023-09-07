Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804FC797DB0
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Sep 2023 23:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240939AbjIGVDS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 Sep 2023 17:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240015AbjIGVDL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Sep 2023 17:03:11 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D039B1990
        for <linux-integrity@vger.kernel.org>; Thu,  7 Sep 2023 14:03:06 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-590685a3be5so13777917b3.0
        for <linux-integrity@vger.kernel.org>; Thu, 07 Sep 2023 14:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1694120586; x=1694725386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FRdHQjf/tBzCy2IXz17HvVEnZ9t7E6rFEF3hyTH/5WQ=;
        b=c8G9NXT5q1Ibnajb3cC6Gh4AACXW+peEb53X6Az6mzaAWmTnGIrDYpopsN0GkpoCVq
         RY9btymGMjORQGWJvLGnE+4cPAonnx+KPCSKoLvrkpdQ/7pSUmtNgLobLFrqqP9zAEuo
         HEUbDy9W3Re0Il+7Ad6/dR7VJs7aesQWQ0+JPsDsQCKeEnJnAS5cxMX0o3wTCtqU4OPK
         qC4DQleTK4ShLoySfrUrlZUu9THcSF0533UJeFi9oktweqtfh72o+pkH3y2YP4fneXEi
         s9oHDYQGGgiyV0zmp+5sbW+XbbHmTyLt1NHf+cf1keqa1sjdsP/C/9laoyivFwLAqmj4
         bwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694120586; x=1694725386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FRdHQjf/tBzCy2IXz17HvVEnZ9t7E6rFEF3hyTH/5WQ=;
        b=vM7q3BubNxV0g+FD4RHVG1TXhjUfUUptiyjXDk9clIriN8Lbve22s/5z6siN5Hxgc0
         WRTCTQklzZMvHkNc6UDsSb9JcWFQcSltfQWw5HKNJOFHf8Q5rHoVdsYxD2INq4aCHel+
         qCxAMz5hxYA+tzZ8aXwHiRm7Kv8yr+cYUbQB1MRz+e1cd2nVxnNYjsFokVnb3qAtMz6P
         QqSOZ25Hhx8ZsYqR6Lbfu+NefvueXjhS36YP/E7UoLmvM2una5mA1hARf7MYNeGAVxMq
         gvTjvhRCntysGqcD+AdfMbz3i94xJgr67O2/vm5pGTTBgYN0rlkug67CdKa5ZuMU0X0X
         5f4w==
X-Gm-Message-State: AOJu0Ywm6f73KEoWHOVFYSxysr5IobvgWRXiItziJJRLKp0VtwViPT7q
        y3vWnML1eAzxkJmxjt/AFlRdfWk7xwURLBdZMWL6
X-Google-Smtp-Source: AGHT+IFDlkfTBZK0+MbboueHp/g4qH419JvtP06vu4lxBO7TjlbsQsl0/5IZc213XschnCZHZNUEjURU0tqfy5ak1jc=
X-Received: by 2002:a81:6d41:0:b0:595:80be:fc6b with SMTP id
 i62-20020a816d41000000b0059580befc6bmr695657ywc.18.1694120586006; Thu, 07 Sep
 2023 14:03:06 -0700 (PDT)
MIME-Version: 1.0
References: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com>
 <598fdd62-f4c3-a6dc-ae22-8f5a9e18f570@linux.ibm.com> <c83e13f8-4b7d-9489-37cc-53936b24343c@linux.microsoft.com>
 <0cfdad7c-8cb9-20d3-7986-c1d3d58a33db@linux.ibm.com>
In-Reply-To: <0cfdad7c-8cb9-20d3-7986-c1d3d58a33db@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 7 Sep 2023 17:02:55 -0400
Message-ID: <CAHC9VhRG1SgNz2RFe8gEYxT=5RK6EutFuNt0YRtwA0bp6PsRog@mail.gmail.com>
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal - aggregate
To:     Ken Goldman <kgold@linux.ibm.com>
Cc:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        Sush Shringarputale <sushring@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, bhe@redhat.com,
        vgoyal@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org,
        jmorris@namei.org, serge@hallyn.com, code@tyhicks.com,
        nramas@linux.microsoft.com, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Sep 6, 2023 at 4:49=E2=80=AFPM Ken Goldman <kgold@linux.ibm.com> wr=
ote:
> On 9/1/2023 6:06 PM, Tushar Sugandhi wrote:
> > On 8/30/23 11:12, Ken Goldman wrote:
> >> On 8/1/2023 3:12 PM, Sush Shringarputale wrote:
> >>> - A user-mode process will trigger the snapshot by opening a file in
> >>> SysFS
> >>>    say /sys/kernel/security/ima/snapshot (referred to as
> >>> sysk_ima_snapshot_file
> >>>    here onwards).
> >>> - The Kernel will get the current TPM PCR values and PCR update
> >>> counter [2]
> >>>    and store them as template data in a new IMA event
> >>> "snapshot_aggregate".
> >>
> >> If this is relying on a user-mode process, is there a concern that the
> >> process doesn't run. Might it be safer to have the kernel trigger the
> >> snapshot.
> >>
> > The UM process here would be typically an attestation client
> > which passes on the IMA log to the remote service for attestation.
> > If the process doesn't run, the client will operate the same way as it
> > does currently.
>
> I see.
>
> 1. Ensure that the attestation client stores the snapshot in a
> well-known and widely readable location.  There can be more than one
> attestation client, and all need access to the snapshot.

A few points:

* There is no requirement for an admin or solution provider to support
or otherwise use the IMA measurement log snapshotting functionality,
even if enabled in the kernel it is opt-in at runtime (i.e. simply
don't trigger the snapshot).  If the deployment in question is using
an attestation solution which is not compatible with the snapshot
concept then there is no need to perform a snapshot, the system will
behave just as it would today; nothing gained, but nothing lost.

* One of the benefits of initiating the snapshot in userspace is that
it affords solution providers a tremendous amount of flexibility with
respect to how to manage the IMA measurement log.  Not only can
different, and potentially more complex, logic be used to determine
the appropriate time to trigger the snapshot, but the trimmed/old log
can be processed any way the admin sees fit; writing and supporting
userspace code is many orders of magnitude easier than kernel code.

> There is a privacy concern around making the snapshot world-read.

See the above points.  If security requirements can not be satisfied
by any of the various solutions designed to protect the integrity of
system configuration and log data, the snapshotting functionality can
always be blocked at runtime by another collection of access control
solutions.

> 2. Is there a concern that, if the client doesn't run, it doesn't solve
> the kernel memory issue?

Yes, the design relies on a userspace process to initiate, and
complete the snapshotting process.  The good news is that if the
userspace process fails the system is no worse off than it is today,
but modern init-systems, e.g. systemd, should help ensure the
reliability of the userspace snapshot process/daemon.

> Is this relying on a UM process to solve a  kernel issue?

The ultimate problem is that we have an unbounded memory buffer that
we can't enforce limits on in the traditional sense.  The design here
proposes a checkpoint system which allows us to mitigate the
uncontrolled growth of this buffer while preserving the ability to
remotely attest the system (although perhaps with different, or
modified attestation tools).

I have not seen any other options for a viable, kernel driven solution
in any of the discussions thus far, but if you have any suggestions I
think we would all be very interested :)  The tmpfs based solution
doesn't solve the problem of system-wide memory pressure as tmpfs is
still a memory-backed filesystem.  Passing a fd to the kernel is still
a userspace initiated action, with the added problem of requiring the
kernel do the I/O itself.

--=20
paul-moore.com
