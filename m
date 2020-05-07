Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7F5E1C8337
	for <lists+linux-integrity@lfdr.de>; Thu,  7 May 2020 09:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbgEGHHc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 May 2020 03:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725783AbgEGHHb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 May 2020 03:07:31 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287B2C061A10;
        Thu,  7 May 2020 00:07:31 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id p16so4425056edm.10;
        Thu, 07 May 2020 00:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RQbMvC1ag/SPzt3A0iv4z8R55U/VKwxU9VmHI0/FJRU=;
        b=HuBe5N6XnGvBabUFlomvKFuULmswvV6IlY50t+tlQh3qqFeVo5mlJMIvc7M96A6QjC
         j3LZOLKTSOkTavRzmk9QLDOed90qTi8J5m3bCK/GvzbOX5+fQnqzZ2lrFFlL9zSBb7bK
         XAFcn2P2vqnrYdpevPVAct9mZB7yGVFNe7rfbteS1bSoApWNTeI58mDIb5AlotWlL2pa
         f6sensKTOJeJLEEFoM777CUpUg8U1KZPaHrhXNqS+3kVcZqWfT9/i1vrGvq/wP09QPjM
         JTwRcQ3BaHtmTWAgaJUkpGH6Yyk3vceaghoSvRuvmphb3vT0EJ+OnF4YC8Ni9cgd0/t6
         EkYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RQbMvC1ag/SPzt3A0iv4z8R55U/VKwxU9VmHI0/FJRU=;
        b=JYeLO9dHPTzWxV9rikm52SnOuuYoqMEldFpJ+gg6ZLxz+tvlAvCX8NaMjwEmUo72Gx
         n3IwQFLcYTinN5PyuM1JAmUapM2H9nAkEOZXQnomgHsgbjNhVAVk2PKOri57lwrpgqhI
         fZQx3hE+0PY0t6DBO+vElxTFLQr3z8mg+j2hJnaNynMTKuSHNcW4Ck8QOsf3XJgJs6m7
         G64im3xAYzUgEpS8ifFlAvT+9vUkr8Yfyde4u2Hv/XLh82U8vHHstEC7De2l4cz+FftN
         UNtHZlyHr6QWOMBwM8LVUYFVjNMrZVDVOGmB04aBX1h9JHjCn7vuHWVf2ponHMcz9zCU
         fZ3Q==
X-Gm-Message-State: AGi0PuYpW/7u6VPnOyxQmZbuk5qXyzbdq+8jseb14Hp3LrbzKDBq2n07
        XMmBWAjw18oPjF0INRW9VPqAlApOOHvd2zoOSRfgriNAQIlCRw==
X-Google-Smtp-Source: APiQypL8AC7ZUZnP0qgOLELJh2mB0qf4DRtMwN4Iryo60fDs4rqEG8PDwXDJX033RYCz1rFZGBj6H05V6VK++Hv+CxM=
X-Received: by 2002:aa7:c2d2:: with SMTP id m18mr10709938edp.142.1588835249498;
 Thu, 07 May 2020 00:07:29 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.21.2002041054320.12768@namei.org> <CALrft9_tam87oevNC6LDG_bZoH+BgfrD4Or3yQudDoVqTqBdvg@mail.gmail.com>
In-Reply-To: <CALrft9_tam87oevNC6LDG_bZoH+BgfrD4Or3yQudDoVqTqBdvg@mail.gmail.com>
From:   Elena Reshetova <elena.reshetova@gmail.com>
Date:   Thu, 7 May 2020 10:07:18 +0300
Message-ID: <CALrft98SzLkw3M0shurUsNxsNSuSR3qN236rX4mEvC8GsrnnWQ@mail.gmail.com>
Subject: [ANNOUNCE][CFP] Linux Security Summit Europe 2020
To:     linux-security-module@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, lwn@lwn.net,
        fedora-selinux-list@redhat.com, linux-crypto@vger.kernel.org,
        kernel-hardening@lists.openwall.com,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        Audit-ML <linux-audit@redhat.com>, gentoo-hardened@gentoo.org,
        keyrings@linux-nfs.org, tpmdd-devel@lists.sourceforge.net,
        Linux Security Summit Program Committee 
        <lss-pc@lists.linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
                   ANNOUNCEMENT AND CALL FOR PARTICIPATION

                        LINUX SECURITY SUMMIT EUROPE 2020

                                     29-30 OCTOBER
                                    DUBLIN, IRELAND
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

DESCRIPTION

Linux Security Summit Europe (LSS-EU) is a technical forum for
collaboration between Linux developers, researchers, and end-users.  Its
primary aim is to foster community efforts in analyzing and solving Linux
security challenges.

 The program committee currently seeks proposals for:

   * Refereed Presentations:
     45 minutes in length.

   * Panel Discussion Topics:
     45 minutes in length.

   * Short Topics:
     30 minutes in total, including at least 10 minutes discussion.

   * Tutorials
     90 minutes in length.

Tutorial sessions should be focused on advanced Linux security defense
topics within areas such as the kernel, compiler, and security-related
libraries.  Priority will be given to tutorials created for this conference=
,
and those where the presenter a leading subject matter expert on the topic.

Topic areas include, but are not limited to:

   * Kernel self-protection
   * Access control
   * Cryptography and key management
   * Integrity policy and enforcement
   * Hardware Security
   * IoT and embedded security
   * Virtualization and containers
   * System-specific system hardening
   * Case studies
   * Security tools
   * Security UX
   * Emerging technologies, threats & techniques

  Proposals should be submitted via:

   https://events.linuxfoundation.org/linux-security-summit-europe/program/=
cfp/

DATES

  * CFP close:            July 31
  * CFP notifications:    August 10
  * Schedule announced:   September 1
  * Event:                October 29-30

COVID-19 SITUATION

Currently LSS-EU is planned as in-person event, however this would be
re-evaluated closer to the event itself and if the situation in Europe does
not permit such events, it would be switched to a virtual event, similarly
as this year=E2=80=99s LSS-NA.

WHO SHOULD ATTEND

We're seeking a diverse range of attendees and welcome participation by
people involved in Linux security development, operations, and research.

LSS-EU is a unique global event that provides the opportunity to present an=
d
discuss your work or research with key Linux security community members and
maintainers.  It=E2=80=99s also useful for those who wish to keep up with t=
he latest
in Linux security development and to provide input to the development
process.

WEB SITE

    https://events.linuxfoundation.org/linux-security-summit-europe/

TWITTER

  For event updates and announcements, follow:

    https://twitter.com/LinuxSecSummit

    #linuxsecuritysummit

PROGRAM COMMITTEE

  The program committee for LSS 2020 is:

    * James Morris, Microsoft
    * Serge Hallyn, Cisco
    * Paul Moore, Cisco
    * Stephen Smalley, NSA
    * Elena Reshetova, Intel
    * John Johansen, Canonical
    * Kees Cook, Google
    * Casey Schaufler, Intel
    * Mimi Zohar, IBM
    * David A. Wheeler, Institute for Defense Analyses

  The program committee may be contacted as a group via email:
    lss-pc () lists.linuxfoundation.org
